using DelimitedFiles

path = joinpath(@__DIR__, "siw.txt")
data = readdlm(path; skipstart=1)
freqs_wn = data[:, 1]
ncases = (size(data, 2) - 1) ÷ 2
self_energies_iwn = ntuple(ncases) do i
    data[:, 2i] + im * data[:, 2i+1]
end

## problem 5a

using CairoMakie
using MakieTypstEngine
font = MakieTypstEngine.MTEFont("TeXGyrePagella")

inch = 96
pt = 4 / 3
cm = inch / 2.54

fig = Figure(; size=(15cm, 5cm), fonts=(; regular=font))

ylimits = nothing#extrema(data[:, 2:end])
limits = (nothing, ylimits)

for i in 1:ncases
    ax = Axis(fig[1, i]; title="Case $i", xlabel=typst"$omega_n$", ylabel=typst"$Sigma(i omega_n)$", limits)
    scatter!(ax, freqs_wn, real(self_energies_iwn[i]), label=typst"$Re$", color=:blue)
    scatter!(ax, freqs_wn, imag(self_energies_iwn[i]), label=typst"$Im$", color=:red)
    if i != 1
        hideydecorations!(ax; grid=false, ticks=false, ticklabels=false)
    end
    if i == ncases
        Legend(fig[1, ncases+1], ax)
    end
end

## problem 5b

using Statistics

cases = 1:3

# Polynomial orders:
# order 1: ImΣ ≈ a₀ + a₁ ω
# order 2: ImΣ ≈ a₀ + a₁ ω + a₂ ω²
# order 3: ImΣ ≈ a₀ + a₁ ω + a₂ ω² + a₃ ω³
poly_orders = 1:3

# Number of lowest Matsubara points included in the fit
nfit_values = 3:10

# Stable block used for the final single estimator
#
# This deliberately avoids:
# - order 1 fits, which often absorb curvature into the slope/intercept
# - very large nfit values, which are less local to ωₙ → 0⁺
selected_orders = 2:3
selected_nfit_values = 4:6

mkpath(joinpath(@__DIR__, "results"))

"""
    polyfit_coeffs(x, y, order)

Least-squares polynomial fit

    y ≈ a₀ + a₁ x + a₂ x² + ...

Returns coefficients `[a₀, a₁, a₂, ...]`.
"""
function polyfit_coeffs(x, y, order)
    X = hcat([x .^ p for p in 0:order]...)
    return X \ y
end

"""
    estimate_FL_params(freqs, sigma; nfit, order)

Fits the low-frequency imaginary self-energy as

    ImΣ(iωₙ) ≈ a₀ + a₁ ωₙ + a₂ ωₙ² + ...

Then extracts

    Γ = -a₀
    Z = 1 / (1 - a₁)
    m*/m = 1 / Z
"""
function estimate_FL_params(freqs, sigma; nfit, order)
    if nfit <= order
        return (; Z=NaN, mstar_over_m=NaN, Gamma=NaN)
    end

    x = freqs[1:nfit]
    y = imag.(sigma[1:nfit])

    coeffs = polyfit_coeffs(x, y, order)

    intercept = coeffs[1]
    slope = coeffs[2]

    Gamma = -intercept
    Z = 1 / (1 - slope)
    mstar_over_m = 1 / Z

    return (; Z, mstar_over_m, Gamma)
end

"""
    write_matrix_with_labels(path, matrix, row_labels, col_labels)

Writes a clean TSV file readable by Typst's `csv(..., delimiter: "\t")`.

Rows are polynomial orders.
Columns are numbers of fitted low-frequency Matsubara points.
"""
function write_matrix_with_labels(path, matrix, row_labels, col_labels)
    open(path, "w") do io
        print(io, "order")

        for nfit in col_labels
            print(io, "\t", nfit)
        end

        println(io)

        for (i, order) in enumerate(row_labels)
            print(io, order)

            for value in matrix[i, :]
                print(io, "\t", value)
            end

            println(io)
        end
    end
end

"""
    selected_values(matrix, poly_orders, nfit_values, selected_orders, selected_nfit_values)

Extracts all finite values from a selected block of the stability matrix.
"""
function selected_values(
    matrix,
    poly_orders,
    nfit_values,
    selected_orders,
    selected_nfit_values,
)
    values = Float64[]

    poly_orders_vec = collect(poly_orders)
    nfit_values_vec = collect(nfit_values)

    for order in selected_orders
        i_order = findfirst(==(order), poly_orders_vec)

        if isnothing(i_order)
            continue
        end

        for nfit in selected_nfit_values
            i_nfit = findfirst(==(nfit), nfit_values_vec)

            if isnothing(i_nfit)
                continue
            end

            value = matrix[i_order, i_nfit]

            if isfinite(value)
                push!(values, value)
            end
        end
    end

    return values
end

"""
    robust_estimator(values)

Returns a robust central value and a simple systematic uncertainty.

The central value is the median.
The uncertainty is half the range.
"""
function robust_estimator(values)
    if isempty(values)
        return NaN, NaN
    end

    center = median(values)
    spread = (maximum(values) - minimum(values)) / 2

    return center, spread
end

final_results = []

for case in cases
    Z_matrix = fill(NaN, length(poly_orders), length(nfit_values))
    mstar_matrix = fill(NaN, length(poly_orders), length(nfit_values))
    Gamma_matrix = fill(NaN, length(poly_orders), length(nfit_values))

    for (i_order, order) in enumerate(poly_orders)
        for (i_nfit, nfit) in enumerate(nfit_values)
            params = estimate_FL_params(
                freqs_wn,
                self_energies_iwn[case];
                nfit=nfit,
                order=order,
            )

            Z_matrix[i_order, i_nfit] = params.Z
            mstar_matrix[i_order, i_nfit] = params.mstar_over_m
            Gamma_matrix[i_order, i_nfit] = params.Gamma
        end
    end

    # Write full stability matrices
    write_matrix_with_labels(
        joinpath(@__DIR__, "results", "case$(case)_Z_matrix.txt"),
        Z_matrix,
        poly_orders,
        nfit_values,
    )

    write_matrix_with_labels(
        joinpath(@__DIR__, "results", "case$(case)_mstar_matrix.txt"),
        mstar_matrix,
        poly_orders,
        nfit_values,
    )

    write_matrix_with_labels(
        joinpath(@__DIR__, "results", "case$(case)_Gamma_matrix.txt"),
        Gamma_matrix,
        poly_orders,
        nfit_values,
    )

    # Extract final robust estimators from selected stability block
    Z_values = selected_values(
        Z_matrix,
        poly_orders,
        nfit_values,
        selected_orders,
        selected_nfit_values,
    )

    mstar_values = selected_values(
        mstar_matrix,
        poly_orders,
        nfit_values,
        selected_orders,
        selected_nfit_values,
    )

    Gamma_values = selected_values(
        Gamma_matrix,
        poly_orders,
        nfit_values,
        selected_orders,
        selected_nfit_values,
    )

    Z_est, Z_err = robust_estimator(Z_values)
    mstar_est, mstar_err = robust_estimator(mstar_values)
    Gamma_est, Gamma_err = robust_estimator(Gamma_values)

    push!(
        final_results,
        (
            case=case,
            Z=Z_est,
            Z_err=Z_err,
            mstar_over_m=mstar_est,
            mstar_over_m_err=mstar_err,
            Gamma=Gamma_est,
            Gamma_err=Gamma_err,
        ),
    )
end

# Write final compact table
open(joinpath(@__DIR__, "results", "results5b_final.txt"), "w") do io
    println(
        io,
        "case\tZ\tZ_err\tmstar_over_m\tmstar_over_m_err\tGamma\tGamma_err",
    )

    for r in final_results
        println(
            io,
            r.case,
            "\t",
            r.Z,
            "\t",
            r.Z_err,
            "\t",
            r.mstar_over_m,
            "\t",
            r.mstar_over_m_err,
            "\t",
            r.Gamma,
            "\t",
            r.Gamma_err,
        )
    end
end

# Optional: print final results to terminal
println("Final robust estimates from selected block:")
println("orders = $(collect(selected_orders)), nfit = $(collect(selected_nfit_values))")
println()

for r in final_results
    println(
        "Case $(r.case): ",
        "Z = $(r.Z) ± $(r.Z_err), ",
        "m*/m = $(r.mstar_over_m) ± $(r.mstar_over_m_err), ",
        "Γ = $(r.Gamma) ± $(r.Gamma_err)",
    )
end