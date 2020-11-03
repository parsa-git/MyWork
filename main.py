from antlr4 import *

from gen.AssignmentStLexer import AssignmentStLexer
from gen.AssignmentStParser import AssignmentStParser
from gen.AssignmentStListener import AssignmentStListener

import argparse

class MyListener(AssignmentStListener):
    pass

def main(args):
    # Step 1: Load input source into stream
    stream = FileStream(args.file, encoding='utf8')
    # input_stream = StdinStream()
    # Step 2: Create an instance of AssignmentStLexer
    lexer = AssignmentStLexer(stream)
    # Step 3: Convert the input source into a list of tokens
    token_stream = CommonTokenStream(lexer)
    # Step 4: Create an instance of the AssignmentStParser
    parser = AssignmentStParser(token_stream)
    # Step 5: Create parse tree

    # Step 6: Create an instance of AssignmentStListener
    AssignmentSt_listener = AssignmentStListener()
    print('begin')
    token = lexer.nextToken()
    while token.type != Token.EOF:
        print("token - text: ", token.text, " line: ", token.line)
        token = lexer.nextToken()
    # parse_tree = parser.start()
if __name__ == '__main__':
    argparser = argparse.ArgumentParser()
    argparser.add_argument(
        '-n', '--file',
        help='Input source', default = r"D:\LectureNotes-98\Compiler\3-Tools\Antlr\AssignmentST\AssSt.txt")
    args = argparser.parse_args()
    main(args)