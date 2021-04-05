MAKEFLAGS+=-j
NAME=a.out
SOURCES=$(wildcard sources/*.cpp)
OBJECTS=$(SOURCES:.cpp=.o)
DEPENDS=$(OBJECTS:.o=.d)
INCLUDES=-I. -Iincludes/
LIBRARIES=
CXXFLAGS=$(INCLUDES) $(LIBRARIES) -W -Wall -Wextra -Wno-unused-function

-include $(DEPENDS)

.PHONY: debug release build rebuild tags lint clean

debug: CXXFLAGS+=-g
debug: build tags

release: CXXFLAGS+=-O3
release: rebuild

build: $(OBJECTS)
	$(CXX) $(CXXFLAGS) $? -o $(NAME)

%.o: %.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -MMD -MP -c $< -o $@

rebuild:
	$(MAKE) clean
	$(MAKE) build

lint: $(SOURCES)
	clang-tidy -header-filter=.* $? -- $(CXXFLAGS) $(INCLUDES)

tags:
	ctags -R

clean:
	rm -f *.d $(DEPENDS)
	rm -f *.o $(OBJECTS)
	rm -f *.out $(NAME)
	rm -f tags
