OUT = /out

.SUFFIXES: .erl .beam .yrl

.erl.beam:
	/usr/local/bin/erlc -W $<

ERL = erl -boot start_clean

MODS = poker_hands poker_hands_tests

all: test

compile: ${MODS:%=%.beam}

test: compile
	${ERL} -pa ./ -s eunit test poker_hands -s init stop

clean:
	rm -rf *.beam erl_crash.dump

