import java.io.IOException;
import org.antlr.v4.runtime.*;

public class csce322hw01pt02driver{
    public static void main(String args[])
    {
	CharStream input = null;
	if( args.length == 1 )
	    {
		try {
		    input = CharStreams.fromFileName( args[0] );
		} catch (IOException e) {
		    // TODO Auto-generated catch block
		    e.printStackTrace();
		}
	    }
	else
	    {
		System.err.println( "File Not Provided" );
		System.exit(0);
	    }
	
	csce322hw01pt02Lexer lexer = new csce322hw01pt02Lexer( input );
	CommonTokenStream tokens = new CommonTokenStream( lexer );
	csce322hw01pt02Parser parser = new csce322hw01pt02Parser( tokens );
	lexer.removeErrorListeners();
	parser.removeErrorListeners();
	lexer.addErrorListener( new csce322hw01pt02error() );
	parser.addErrorListener( new csce322hw01pt02error() );
	parser.gravityGame();
    }
}
