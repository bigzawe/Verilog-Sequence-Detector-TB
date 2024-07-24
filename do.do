vlib work

vlog	sdet_tb.v sdet.v

vsim -voptargs=+acc work.sdet_tb

add wave * 

run -all