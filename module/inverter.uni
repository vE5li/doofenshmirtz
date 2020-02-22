component InverterModule<count>(in clock, in selector[#selector(#count)], in source[#source(#count)], out destination[#register][0:2]) {
    Wire input[#bit_width:0]
    BusRegister<#count>(clock, selector, source, input)
    destination[0] := input
    destination[1] := ~input
}
