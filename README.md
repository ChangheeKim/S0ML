Side 0ne Markup Language
========================
XML. so many \</>\</>\</>.  
CVS, simple but terrible readablity.  
It sucks, So I start to create new markup language that is easy to write, easy to read with only basic text editor.
#S0ML Document
##Examples
###Example 1
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

###Example 2
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

###Example 3
```
>
text;

>
"Hello, World!";

>
"What's up, World!";
```

###Example 4
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

#Classes
##S0ML
subclass of NSObject.
###Methods
####+(S0MLData *)parseString:(NSString*)string;
Parse string and return S0MLData.
####+(S0MLData*)parseBundleFileNamed:(NSString*)fileName;
Parse bundle file named as fileName and return S0MLData.  
If file name is 'fileName.s0ml', @"fileName.x0ml" = X, @"fileName: = O.

```
S0MLData *data = [S0ML parseBundleFileName:@"fileName"];
```
####+(S0MLData*)parseFileWithURL:(NSString*)urlString;
Parse file from URL, and return S0MLData.

```
S0MLData *data = [S0ML parseFileWithURL:@"http://a.com/fileName.s0ml"];
```
####+(void)logContentsOfS0MLData:(S0MLData*)data;
Show contents of the S0MLData with NSLog.  

```
[S0ML logContentsOfS0MLData:[S0ML parseFileWithURL:@"http://a.com/fileName.s0ml"]];
```
####+(id)nilElement;
Because of elements be stored in NSMutableArray, it should be object type.  
S0ML use ```[S0ML nilElement]``` to store nil.

```
S0MLData *data = [S0ML parseFileWithURL:@"http://a.com/fileName.s0ml"];

S0MLObject *object = [data firstObject];

if([object elementForName:@"name"] == [S0ML nilElement]){
	NSLog(@"element is nil");
}
```
##S0MLData
Subclass of NSObject.  
S0MLData is data object made with parsing S0ML document.
###Properties
####S0MLHeader *header;
####NSMutableArray *objects;
###Methods
####-(S0MLObject*)objectAtIndex:(NSInteger)index;
Return object at index.
####-(S0MLObject*)firstObject;
Return first object.
####-(S0MLObject*)lastObject;
Return last object.
####-(NSInteger)indexOfObject:(id)object;
Return index number of object.
####-(NSInteger)count;
Return number of object count.
##S0MLHeader
Subclass of NSObject.  
###Properties
####NSMutableArray *elementNames;
##S0MLObject
Subclass of NSObject.  
Basically, all of element stored as NSString.
###Properties
####NSMutableArray *elements;
####S0MLHeader *header;
###Methods
####-(NSString*)elementForName:(NSString*)name;
####-(NSString*)elementAtIndex:(NSInteger)index;
####-(BOOL)boolWithString:(NSString*)string;
Return BOOL with string.
for positive value:
````
YES, Yes, Y, y, true, True, TRUE, Positive, positive, O, o, [and bigger numbers than 0].
````  
for negative value:
````
0 or all of other characters not for positive value.
````
####-(BOOL)boolWithElementAtIndex:(NSInteger)index;
####-(BOOL)boolWithElementForName:(NSString*)name;
####-(NSInteger)integerWithElementAtIndex:(NSInteger)index;
####-(NSInteger)integerWithElementForName:(NSString*)name;
####-(float)floatWithElementAtIndex:(NSInteger)index;
####-(float)floatWithElementForName:(NSString*)name;
####-(double)doubleWithElementAtIndex:(NSInteger)index;
####-(double)doubleWithElementForName:(NSString*)name;
