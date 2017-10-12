grammar Expr;

prog : stat+;

stat: expr NEWLINE          # printexpr
    | ID '=' expr NEWLINE   # assign
    | NEWLINE               # blank
    ;

expr: expr op=(MUL|DIV) expr        # MulDiv
    | expr op=(ADD|SUB) expr        # AddSub
    | INT                           # expr
    | ID                            # id
    | '(' expr ')'                  # parens
;

MUL : '*' ; // assigns token name to '*' used above in grammar
DIV : '/' ;
ADD : '+' ;
SUB : '-' ;
ID : [a-zA-Z]+ ;
INT : [0-9]+ ;
NEWLINE:'\r'? '\n' ;
WS : [ \t]+ -> skip;