module aoc2024
using DataFrames, CSV

export getdata11, totaldiffbetlists, similarity
export getdata21, safereports
export safep

# day1 functions #

"""
    getdata11(path)

Get data for day 1.1
"""
function getdata11(path)
    df = CSV.read(path, DataFrame; header = [:list1, :list2], delim=' ', ignorerepeated=true)
    df.list1 = sort!(df.list1)
    df.list2 = sort!(df.list2)
    return df
end

"""
    totaldiffbetlists(df)

Get the total diff between list1 and list2 in df.
"""
function totaldiffbetlists(df)
    df = transform(df, [:list1, :list2] => ByRow((l1, l2) -> abs(l1 - l2)) => :distance)
    sum(df.distance)
end

"""
    similarity(df)

Compute the similarity between list1 and list2 items.
If an item in list2 is present in list1, multiply the value
of the list2 item by the number of times it appears in list2.
"""
function similarity(df)
    df.list2 .∈ Ref(df.list1)
end

# day2 functions #

"""
    getdata21(path)

Get data for day 2.2.
Integers separated by space as delimiter.
Varying number of fields/columns per line.
"""
function getdata21(path)
    result = Vector{Int64}[]
    for line in eachline(path)
        v= parse.(Int, split(line))
        push!(result, v)
    end
    return result
end

"""
    safereports(vecofvectors)

Find vectors in the collection that
satisfy a predicate for safety.
"""
function safereports(vecofvectors)
    diffs = diff.(vecofvectors)
    sum(safep.(diffs))
end

"""
    safep(vec)

Test if vec satisfies predicate
for safety:
1) have all positive or all negative elements
2) have absolute value of element, e, such that
   1 ≤ e ≤ 3
"""
function safep(vec)
    deltaf(x) =  1 ≤ abs(x) ≤ 3
    (all(>(0), vec) || all(<(0), vec)) && (all(deltaf, vec))
end


end # module aoc2024
