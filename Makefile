rule110.ed: rule110.proto.ed
	cp $< $@
	ed -s $@ < build.ed

.PHONY: clean
clean:
	rm -f rule110.ed
