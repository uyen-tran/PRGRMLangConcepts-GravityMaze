grammar csce322hw01pt02;

// tokens
SectionBeginning : '\\begin{section}';
SectionEnding : '\\end{section}';
LIST_title: '\\title{Moves}';
MAZE_title : '\\title{Maze}';
AssignValue : '::';
MAZE_beginning : '\\begin{maze}';
MAZE_ending : '\\end{maze}';
LIST_beginning : '\\begin{moves}';
LIST_ending : '\\end{moves}';

MOVE_symbols
 : 'c'
 | 'cc'
 | '180';
X : 'x';
MAZE_symbol
 : 'g'
 | '-'
 | NUMERICAL;
ROW_ending : '\\\\';
NUMERICAL : [0-9]+;
TIDLE : '~';
WS : [ \t\r\n]+ -> skip;
AnythingElse : .;


// rules
gravityGame : input  EOF;

input
    locals[
        int count_x = 0, int count_g = 0, int count_player = 0,
        int count_all = 0,
        int count_c = 0, int count_cc = 0, int count_180 = 0,
        int g_row = -1, int g_col = -1,
        boolean vio = false,
        List<String> rows = new ArrayList<String>(),
        String current = "", String above = "",  String below = "",
        char up, char down, char left, char right
    ]:
    SectionBeginning WS*
    ((maze WS* SectionEnding WS* SectionBeginning WS* moves) | (moves WS* SectionEnding WS* SectionBeginning WS* maze))
    WS* SectionEnding

    { if (($count_player<1) | ($count_player>4))
            { System.out.println("The semantic rule 1 was violated."); }

          if ($count_g!=1)
            { System.out.println("The semantic rule 2 was violated."); }

          if (((double)($count_x)/(double)($count_all))>0.6)
            { System.out.println("The semantic rule 3 was violated."); }
    }
    { if (($count_c==0) | ($count_cc==0) | ($count_180==0))
            { System.out.println("The semantic rule 4 was violated."); }
    }
    { $current = $rows.get($g_row);
      $above = $rows.get($g_row-1);
      $below = $rows.get($g_row+1);
      $up = $above.charAt($g_col);
      $down = $below.charAt($g_col);
      $left = $current.charAt($g_col-1);
      $right = $current.charAt($g_col+1);
      if (($up=='x')| ($down=='x') | ($left=='x') | ($right=='x'))
        System.out.println("The semantic rule 5 was violated.");
    };

maze
    locals[
        String s = "";
    ]:
    MAZE_title WS*
    AssignValue WS*
    MAZE_beginning WS*
    x_symbols WS* x_symbols WS* x_symbols WS* x_symbols WS* (x_symbols WS*)+ x_symbols ROW_ending
    { $input::rows.add($s);
          $s="";
    }
    x_symbols WS* (maze_symbols WS*)* x_symbols ROW_ending
    { $input::rows.add($s);
          $s="";
    }
    x_symbols WS* (maze_symbols WS*)* x_symbols ROW_ending
    { $input::rows.add($s);
          $s="";
    }
    x_symbols WS* (maze_symbols WS*)* x_symbols ROW_ending
    { $input::rows.add($s);
          $s="";
    }
    (x_symbols WS* (maze_symbols WS*)* x_symbols ROW_ending
    { $input::rows.add($s);
          $s="";
    })+
    x_symbols WS* x_symbols WS* x_symbols WS* x_symbols WS* (x_symbols WS*)+ x_symbols
    { $input::rows.add($s); }
    MAZE_ending;

x_symbols : x='x'{
        $maze::s+="x";
        $input::count_x++;
        $input::count_all++;
    };

maze_symbols : ma=(MAZE_symbol | X) {
        if ($ma.text.equals("x")) $input::count_x++;
            else { if ($ma.text.equals("g"))
                    { $input::count_g++;
                      $input::g_row = $input::rows.size();
                      $input::g_col = $maze::s.length();
                    }
                    else { if (!($ma.text.equals("-")))
                            $input::count_player++;};
                    }
        $maze::s+=$ma.text;
        $input::count_all++;
    };

moves :
    LIST_title WS*
    AssignValue WS*
    LIST_beginning WS*
    moves_symbol TIDLE
    moves_symbol TIDLE
    moves_symbol TIDLE
    moves_symbol TIDLE
    (moves_symbol TIDLE)+
    moves_symbol WS*
    LIST_ending;

moves_symbol : mo=MOVE_symbols WS*{
        if ($mo.text.equals("c"))
            $input::count_c++;
        if ($mo.text.equals("cc"))
            $input::count_cc++;
        if ($mo.text.equals("180"))
            $input::count_180++;
    };