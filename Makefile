rule110.ed: rule110.proto.ed
	cp $< $@
	ed -s $@ < build.ed
