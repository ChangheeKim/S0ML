S0ML
====
Side 0ne Markup Language.

XML, so many \</>\</>\</>.  
CVS, simple but what the hell is readablity.

Here is Hybrid of XML and CVS.  
Simple and Readable.

#example 1
```
header>
element0;
element1;

object0>
element;
element;

object1>
element;
element;
```

#example 2
```
// This is example.

>
number;

>
0;

>
1;

>
2;
```

#example 3
```
>
text;

>
"Hello, World!";

>
"What's up, World!";
```

#example 3
```
//	Side0ne Markup Language Example.
//	Created by Changhee Kim on 2015/06/15.



This is header. You can comment here.>
name;
color;
score;			// Perfect score is 5;
availability;	// Availability in Japan;

This is first object. You can also comment here.>
"Coke Cola";	//	without "", spaces will be ignored.
brown;
3;
YES;			//	for a boolean type data, you can use followings:
				//		YES, Yes, Y, y, true, True, TRUE, Positive, positive, O, o, [and bigger numbers than 0]
				//	Number 0 or All of other characters mean negative. (ex: false, no, x, asdf, etc.. )


>
"Pocari Sweat";
"Transparent white";
4;
true;


>
"Welch's sparkling grape";
purple;
5;
nope;
```
