extends Node

var current_level := 1;

var collected_coins := 0b0000000000 
	
func count_bitfield(bitfield: int) -> int:
	var count = 0
	while bitfield != 0:
		bitfield &= bitfield - 1
		count += 1
	return count
