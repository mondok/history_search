TARGET = history_search

 all: $(TARGET)

 $(TARGET):
	 mix escript.build
	 mv $(TARGET) ./bin/$(TARGET)

 clean:
	 $(RM) $(TARGET)
