rule110.ed: rule110.proto.ed
	cp $< $@
	ed -s $@ < build.ed

.PHONY: clean run
clean:
	rm -f rule110.ed
run: rule110.ed cells.dat
	ed -s cells.dat < rule110.ed; wait
