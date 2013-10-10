
Style guide
===========

I am bad at following a conistent style, but this how I try to code:

-Organize files in a version control repo/ rstudio project

-File Names: no caps or spaces, end in `.R` or `.md`

-Load all libraries and needed files first

-Use headers: `##headers---`

-Identifiers: `variable_name`, no caps

-Line Length: maximum ~ 80 characters (i.e. an Rstudio source screen)

-Indentation: use tabs, when a line break occurs inside parentheses, align the wrapped line with the first character inside the parenthesis

-Place spaces around all binary operators (=, +, -, <-, etc.)

-Curly Braces: first on same line, last on own line. but use `else` surround else with braces

-Assignment: use `<-`, not `=`

-Semicolons: don't use them

-Commenting Guidelines: comment a lot, all comments begin with # followed by a space; inline comments need a tab before the #

-TODO Style: `#TODO(username)`

-Functions should contain a comments section immediately below the function definition line. These comments should consist of a one-sentence description of the function; a list of the function's arguments, denoted by `Args:`, with a description of each (including the data type); and a description of the return value, denoted by `Returns:`. The comments should be descriptive enough that a caller can use the function without reading any of the function's code.




