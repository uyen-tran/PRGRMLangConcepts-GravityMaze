grammar csce322hw01pt01;

// tokens
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
ROW_ending : ['\\']['\\'];
NUMERICAL : [0-9]+;
TIDLE : '~';
WS : [ \t\r\n]+ -> skip;
AnythingElse : .;

token
 : SectionBeginning {System.out.println("Open Section: " + $SectionBeginning.text);}
 | SectionEnding {System.out.println("Close Section: " + $SectionEnding.text);}
 | SectionTitle {System.out.println("Section Title: " + $SectionTitle.text);}
 | AssignValue {System.out.println("Designation: " + $AssignValue.text);}
 | MAZE_beginning {System.out.println("Open Maze: " + $MAZE_beginning.text);}
 | MAZE_ending {System.out.println("Close Maze: " + $MAZE_ending.text);}
 | LIST_beginning {System.out.println("Open Moves: " + $LIST_beginning.text);}
 | LIST_ending {System.out.println("Close Moves: " + $LIST_ending.text);}
 | MOVE_symbol {System.out.println("Move: " + $MOVE_symbol.text);}
 | MAZE_symbol {System.out.println("Location: " + $MAZE_symbol.text);}
 | ROW_ending {System.out.println("Close Row: " + $ROW_ending.text);}
 | NUMERICAL
 | TIDLE
 | WS
 | AnythingElse
   {System.out.println("The unrecognizable token " + $AnythingElse.text + " appears in line " + $AnythingElse.line + ".");
    System.exit(0);};

// rules
gravityGame : token* EOF{System.out.println("Close of File");};
