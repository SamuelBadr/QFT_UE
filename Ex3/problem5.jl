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

fig_path = joinpath(@__DIR__, "figures", "siw_plot.pdf")
save(fig_path, fig)
fig

## problem 5b

cases = 1:3
Zs = map(cases) do case
    pdv_ImSigma_omegan = imag(self_energies_iwn[case][1]) / freqs_wn[1]
    1 / (1 - pdv_ImSigma_omegan)
end



open(joinpath(@__DIR__, "results", "results5b.txt"), "w") do io
    writedlm(io, [cases Zs])
end
