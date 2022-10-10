grammar DynScope;


SectionBeginning : '\\begin{section}';
SectionEnding : '\\end{section}';
SectionTitle
 : '\\title{Moves}'
 | '\\title{Maze}';
AssignValue : '::';
MAZE_beginning : '\\begin{maze}';
MAZE_ending : '\\end{maze}';
LIST_beginning : '\\begin{moves}';
LIST_ending : '\\end{moves}';

MOVE_symbol
 : 'c'
 | 'cc'
 | '180';
MAZE_symbol
 : '-'
 | 'g'
 | 'x'
 | NUMERICAL;
ROW_ending : '\\\\';
NUMERICAL : [0-9]+;
TIDLE : '~';
WS : [ \t\r\n]+ -> skip;
AnythingElse : .;

prog: maze ;

symbol : m=MAZE_symbol {
    if($m.text.equals("x"))
       $maze::cntx++;
};

maze
    locals [
        int cntx = 0
    ]
    :
    SectionBeginning
    symbol
    symbol
    symbol
    symbol
    symbol+
    SectionEnding
    {
        System.out.println("cntx is " + $cntx);
    }
    ;
