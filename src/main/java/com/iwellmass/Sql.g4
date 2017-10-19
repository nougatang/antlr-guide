grammar Sql;

prog : stat+;

stat: e NEWLINE          # printsqlstat
    | NEWLINE               # blank
    ;

expr: expr op=(MUL|DIV) expr        # MulDiv
    | expr op=(ADD|SUB) expr        # AddSub
    | INT                           # int
    | ID                            # id
    | '(' expr ')'                  # parens
    ;

sqlstat : 'select' item 'from' ID (wherestat)?
        ;

wherestat : 'where' equal ';'
          ;

item : item ',' item
     | ID
     ;
equal : ID '=' expr
      ;

retstat : 'select' expr ';';

operator : retstat
         | 'break' ';'
         | 'continue' ';'
         ;

e : e '*' e # MUL
  | e '+' e # ADD
  | INT     # INT
  ;

inc : e '++' ;

field : e '.' e ;

s : field
        {
        List<EContext> x=$field.ctx.e();
        }
  ;

state : 'return' value=e ';' #Return
      | 'break' ';' #Break
      ;



MUL : '*' ; // assigns token name to '*' used above in grammar
DIV : '/' ;
ADD : '+' ;
SUB : '-' ;
ID : [a-zA-Z]+ ;
INT : [0-9]+ ;
NEWLINE:'\r'?'\n' ;
WS : [ \t]+ -> skip;
