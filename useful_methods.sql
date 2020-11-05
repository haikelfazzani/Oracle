Function Name	Examples	                               Return Value
TO_CHAR ()	    TO_CHAR (3000, '$9999')                $3000
                TO_CHAR (SYSDATE, 'Day, Month YYYY')   Monday, June 2008
TO_DATE ()	    TO_DATE ('01-Jun-08')	                 01-Jun-08
NVL ()	        NVL (null, 1)	                         1


Function Name	Return Value
TO_CHAR (x [,y])	Converts Numeric and Date values to a character string value. 
                  It cannot be used for calculations since it is a string value.
                  
TO_DATE (x [, date_format])	Converts a valid Numeric and Character values to a Date value. 
  Date is formatted to the format specified by 'date_format'.
                            
NVL (x, y)	If 'x' is NULL, replace it with 'y'. 'x' and 'y' must be of the same datatype.

DECODE (a, b, c, d, e, default_value)	Checks the value of 'a', if a = b, 
  then returns 'c'. If a = d, then returns 'e'. Else, returns default_value.
