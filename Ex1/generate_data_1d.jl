using CSV
using QuadGK
using SpecialFunctions: ellipk

const Interval = Tuple{Float64,Float64}

"""
    dos_1d(epsilon::Real) -> Float64

Return the 1D nearest-neighbor tight-binding density of states for
`epsilon(k) = -2 cos(k)`.
"""
function dos_1d(epsilon::Real)
    energy = float(epsilon)
    abs_energy = abs(energy)

    abs_energy > 2 && return 0.0
    abs_energy == 2 && return Inf

    return inv(π * sqrt(4 - energy^2))
end

"""
    dos_2d(epsilon::Real) -> Float64

Return the square-lattice density of states for the 2D nearest-neighbor
tight-binding model with `epsilon(k) = -2(cos(k_x) + cos(k_y))`.
"""
function dos_2d(epsilon::Real)
    energy = float(epsilon)
    abs_energy = abs(energy)

    abs_energy > 4 && return 0.0
    iszero(energy) && return Inf

    # `ellipk` expects the parameter m, not the modulus k.
    m = min(1 - energy^2 / 16, prevfloat(1.0))
    return ellipk(m) / (2π^2)
end

"""
    dos_3d(epsilon::Real; rtol=1e-10) -> Float64

Return the cubic-lattice density of states obtained by convolving the
square-lattice DOS over the third momentum component.
"""
function dos_3d(epsilon::Real; rtol=1e-10)
    energy = float(epsilon)
    intervals = kz_support_intervals(energy)
    isempty(intervals) && return 0.0

    if abs(energy) <= 2
        kz0 = acos(-energy / 2)
        intervals = split_intervals(intervals, kz0)
        intervals = split_intervals(intervals, 2π - kz0)
    end

    f(kz) = dos_2d(energy + 2cos(kz))
    value = sum(first(quadgk(f, a, b; rtol=rtol)) for (a, b) in intervals)
    return value / (2π)
end

"""
    kz_support_intervals(epsilon::Float64) -> Vector{Tuple{Float64, Float64}}

Return the `k_z` intervals for which `abs(epsilon + 2cos(k_z)) <= 4`.
"""
function kz_support_intervals(epsilon::Float64)
    abs(epsilon) >= 6 && return Interval[]

    if epsilon <= -2
        kz0 = acos(clamp((-4 - epsilon) / 2, -1.0, 1.0))
        return [(0.0, kz0), (2π - kz0, 2π)]
    elseif epsilon >= 2
        kz0 = acos(clamp((4 - epsilon) / 2, -1.0, 1.0))
        return [(kz0, 2π - kz0)]
    end

    return [(0.0, 2π)]
end

"""
    split_intervals(intervals, point) -> Vector{Tuple{Float64, Float64}}

Split each interval at `point` when it lies strictly inside the interval.
"""
function split_intervals(intervals::Vector{Interval}, point::Float64)
    split = Interval[]

    for (a, b) in intervals
        if a < point < b
            push!(split, (a, point), (point, b))
        else
            push!(split, (a, b))
        end
    end

    return split
end

"""
    write_dos_csv(path, dos, cutoff; n=4000, margin=1e-4) -> Nothing

Sample `dos` on `n` evenly spaced energy values inside the band edge `cutoff`
and write a CSV with `x = epsilon` and `rho = dos(epsilon)`.
"""
function write_dos_csv(path, dos, cutoff; n=4000, margin=1e-4)
    x = range(-cutoff * (1 - margin), cutoff * (1 - margin); length=n)
    rho = dos.(x)
    CSV.write(path, (; x, rho))
end

function (@main)(args)
    outdir = isempty(args) ? joinpath(@__DIR__, "dos-data") : args[1]
    mkpath(outdir)

    write_dos_csv(joinpath(outdir, "dos_1d.csv"), dos_1d, 2)
    write_dos_csv(joinpath(outdir, "dos_2d.csv"), dos_2d, 4)
    write_dos_csv(joinpath(outdir, "dos_3d.csv"), dos_3d, 6)

    return nothing
end
