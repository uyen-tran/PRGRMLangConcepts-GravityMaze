# Programming Language Concepts - GravityMaze

**Homework 01** (Due: Friday, March 5,2021,11 : 59 : 00PM)

## 1 Instructions

In this assignment, you will be required to scan, parse, and check the semantics of a file that encodes
the state of a variation of Gravity Maze. The definition of a properly formatted input file is given in
Section 1.1.
You will be submitting one .java file and two .g4 (ANTLR) files via web hand-in.

### 1.1 File Specification

• The file contains two (2) labeled sections: Maze and Moves . Each section is enclosed by start and end tags (\begin{section} and \end{section}, respectively). The value of the section is set by the :: assignment operator.

• Moves is an tilde-separated (~) list of move values that appear between \begin{moves} and \end{moves}. Valid moves are c (Clockwise rotation), cc (Counterclockwise rotation), and 180 (180 degree rotation).

• Maze is a two-dimensional array of space-separated entries that uses alphanumeric symbols to encode the state of the maze. Rows will be ended with a \\ and the Maze will be begun with a \begin{maze} and ended with a \end{maze}.

• You may assume that tabs will not appear in the file.

An example of a properly formatted file is shown in Figure 1.

\begin{section } \t i t l e {Moves} : : \begin{moves} cc  ̃ 180  ̃ 180  ̃ c  ̃ 180  ̃ cc  ̃ c  ̃ c  ̃ cc  ̃ 180  ̃ c\end{moves} \end{section }

\begin{section } \t i t l e {Maze} : : \begin{maze}

x x x x x x x x x x x x x x\\

x − − − − − − − − − − − − x\\

x − − x − − − − − − x − x x\\

x − − − − − − − x − − − − x\\

x − − − − − − − − 2 − − − x\\

x − − − − − − − − − − − − x\\

x − g 1 − − − x − − − − − x\\

x − − − − x − − − x − − − x\\

x x x x x x x x x x x x x x

\end{maze}

\end{section }

Figure 1: A properly formatted Gravity Game (G) encoding

The assignment is made up of two parts: scanning the text of the input file and parsing the information contained in the input file.

### 1.2 Scanning

Construct a combined grammar in a .g4 file that ANTLR can use to scan a supplied Gravity Game encoding. The logic in this file should be robust enough to identify tokens in the encoding and accurately process any correctly formatted encoding. The rules in your .g4 file will be augmented with actions that display information about the input file. An example of that output is specified in Section 2.

The purpose of the scanner is to extract tokens from the input and pass those along to the parser. For the Gravity Game encoding, the types of tokens that you will need to consider are given in Table 1.

Type               Form

Section            Beginning \begin{section}

Section Ending     \end{section}

Section Title      \title{Moves} and \title{Maze}

Assign Value       ::

Move Symbol        c, cc, or l80

Maze Symbol        -, g, x, or one (1) or more numerical symbols

Numerical Symbol   0, 1, 2, 3, 4, 5, 6, 7, 8, 9

Row Ending         \\

Maze Beginning     \begin{maze}

Maze Ending        \end{maze}

List Beginning     \begin{moves}

List Ending        \end{moves}

White Space (to be ignored) spaces, tabs, newlines

Table 1: Tokens to Consider

**1.2.1 Invalid Encodings**

For invalid Maze Game encodings, the output The unrecognizable token T appears in line L. should display. T would be the symbol read and L would be the line of input where the symbol was read. Your scanner should stop scanning the file after an unrecognized token is found.

### 1.3 Parsing

Construct a combined grammar in a .g4 file that ANTLR can use to parse a supplied Gravity Game encoding. In addition to the rules for scanning, there are several parsing rules:

• Each section appears once and only once. The sections may appear in either Moves/Maze or Maze/Moves order.

• There must be more than five (5) rows in a valid Maze.

• There must be more than five (5) columns in a valid Maze. You may assume that each row has the same number of columns, and each column has the same number of rows.

• The first row, last row, first column, and last column of the Maze must contain only x symbols.

• There must be more than five (5) moves in the Moves section.

The semantics of a properly formatted Maze Game encoding are:

1. Between one (1) and four (4) (inclusive) players must appear in the Maze.

2. The Maze must contain exactly one (1) g symbol.

3. The number of x symbols in the Maze must not exceed 60% of all symbols in the Maze.

4. c, cc, and 180 must each appear at least once in the Moves.

5. Extra Credit (10 points or Honors contract): The goal must not be adjacent to an x symbol (considering only the up, down, left, and right directions).
