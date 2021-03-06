MAKEFLAGS+=-j
NAME=
SOURCES=$(shell find sources/ -type f -name '*.cpp')
INCLUDES=-I. -Iincludes/
OBJECTS=$(SOURCES:.cpp=.o)
LIBRARIES=
CXXFLAGS=$(INCLUDES) $(LIBRARIES) -W -Wall -Wextra -Wno-unused-function

.PHONY: debug release build rebuild tags lint clean

debug: CXXFLAGS+=-g
debug: build lint tags

release: CXXFLAGS+=-O3
release: rebuild

build: $(OBJECTS)
	$(CXX) $(CXXFLAGS) $? -o $(NAME)

rebuild: | build clean

lint: $(SOURCES)
	clang-tidy $? -- $(CXXFLAGS) $(INCLUDES)

tags:
	ctags -R

clean:
	rm -f *.o $(OBJECTS)
	rm -f *.out $(NAME)
	rm -f tags
