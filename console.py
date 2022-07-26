# Put this in the root of a project directory, then start python with this:
# PYTHONSTARTUP=console.py python
# I've seen this used in a makefile, but could also be a part of a .envrc
# for `direnv`, that way you'd always start python that way.

import sys

try:
    from ptpython.repl import embed
except ImportError:
    print("ptpython is not available: falling back to standard prompt")
else:
    sys.exit(embed(globals(), locals()))
