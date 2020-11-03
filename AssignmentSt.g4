grammar AssignmentSt;
@members {
                etype = 0
                ttype = 0
                ftype = 0
          }
start : prog EOF ;
prog : prog assign  | assign ;
assign : ID ':=' e=expr (NEWLINE | EOF)  ;
expr returns [n = str()]:
    e=expr '+' t=term           {etype = ttype
                                 if etype == 2:
                                    n = str(float($e.text) + float($t.text))
                                 else :
                                    n = str(int($e.text) + int($t.text))}
    | e=expr '-' t=term         {etype = ttype}
    | expr RELOP term           {etype = ttype}
    | t=term                    {etype = ttype};
term :
    t=term '*' f = factor       {ttype = ftype}
    | t=term '/' f=factor       {ttype = ftype}
    | f=factor                  {ttype = ftype};
factor :
    '(' expr ')'                {ftype = etype}
    | ID                        {ftype = 1}
    | Number
    ;
Number :
        FLOAT                   {ftype = 2}
       | INT                    {ftype = 3}
       ;
/* Lexical Rules */
fragment
        DIGIT: [0-9] ;
fragment
        LETTER: [a-zA-Z] ;
fragment
        ESC: '\\"' | '\\\\' ;
INT     : DIGIT+ ;
FLOAT:
    DIGIT+ '.' DIGIT*
    | '.' DIGIT+ ;
STRING:
        '"' (ESC|.)*? '"' ;
ID:
    LETTER(LETTER|DIGIT)* ;
WS: [ \t\r]+ -> skip ;
NEWLINE: '\n';
RELOP: '<=' | '<' ;