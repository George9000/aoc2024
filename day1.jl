using aoc2024, Chain, DataPipes
include("constants.jl")

@chain begin getdata11(joinpath(datap, "data1.1.txt"))
    totaldiffbetlists
end

@p let
    getdata11(joinpath(datap, "data1.1.txt"))
    @aside sim = similarity
    sim .* __.list2
    sum
end
