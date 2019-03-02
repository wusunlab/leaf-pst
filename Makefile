.PHONY: default build install uninstall doc test fmt clean

default: build

build:
	dune build

install:
	dune install

uninstall:
	dune uninstall

doc:
	dune build @doc && ./append-katex-header.sh

test:
	dune runtest -f

fmt:
	dune build @fmt --auto-promote

clean:
	dune clean
