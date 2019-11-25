# Homework for Lecture 1
https://cs.brown.edu/courses/cs019/2018/docdiffdocdiff.html

## Introduction
Consider the problem of comparing two text documents. Why might you want to do this? Perhaps you want to check for plagiarism, search for articles similar to a particular one you’re studying, or have uncovered a new manuscript and want to know whether it’s a legitimate Shakespeare or a fake. All these require being able to determine the similarity between documents. In this assignment we will define a document as list of strings, with each string representing a word. Here’s an example of a document:

```pyret
[list: "The", "quick", "brown", "fox", "jumps"]
```

In order to compute the similarity between two documents, we associate each document with a mathematical vector, which here we will represent using a list of numbers. The indices of the vector correspond to words that are found in either document. The value at each index is how many times the corresponding word occurs in the document.

This is called the bag of words model. It’s a “bag” because, like a set, order doesn’t matter, but the count does.

For example, the documents `[list: "a", "b", "c"]` and `[list: "d", "d", "d", "b"]` would result in vectors of length `4`, accounting for all unique words ("a", "b", "c", and "d"):

  
"a"
  
"b"
  
"c"
  
"d"
[list: "a", "b", "c"]
  
1
  
1
  
1
  
0
[list: "d", "d", "d", "b"]
  
0
  
1
  
0
  
3
Therefore, the two documents will respectively have the representations [list: 1, 1, 1, 0] and [list: 0, 1, 0, 3].

We assume that two words are the same if they have the same characters in the same order, ignoring upper- and lower-case (Pyret has functions to upper- or lower-case a string, and for sorting; you can look up these functions in the string and list libraries.)

We define the overlap between two documents, represented this way, to be proportional (∝
∝
) to the dot product of these two document vectors:

overlap(d1→,d2→)∝d1→⋅d2→
o
v
e
r
l
a
p
(
d
1
→
,
d
2
→
)
∝
d
1
→
⋅
d
2
→

To obtain a formula, we normalize this dot-product. We will choose a simple method, which is to divide by the squared magnitude of the larger vector:

overlap(d1→,d2→)=d1→⋅d2→max(‖d1→‖2,‖d2→‖2)
o
v
e
r
l
a
p
(
d
1
→
,
d
2
→
)
=
d
1
→
⋅
d
2
→
m
a
x
(
‖
d
1
→
‖
2
,
‖
d
2
→
‖
2
)

where the magnitude of a vector x⃗ 
x
→
, denoted as ‖x⃗ ‖
‖
x
→
‖
, is given by sqrt(x⃗ ⋅x⃗ )
s
q
r
t
(
x
→
⋅
x
→
)
. Observe that this means every document will have an overlap of 1 with itself, and any two documents that have no words in common will have overlaps of 0 with each other.

4 Assignment
Define a function
fun overlap(doc1 :: List<String>, doc2 :: List<String>) -> Number: ... end
where doc1 and doc2 are lists of strings and overlap returns a number. This function computes the overlap of two non-empty documents, defined by the formula above.
Note that we are not asking you to consider efficiency of implementation.

5 Language Use
You may not use built-in sets; everything in the list library is permitted.

6 Background
You will find this chapter useful in learning to convert from Racket to Pyret, and this one useful for learning more about lists in Pyret.

7 Extra TA Hours
In addition to the listed hours, your TAs will be holding extra hours for this assignment at the following times:

Date
  
Hours
  
Where
  
Who
Friday, 9/7
  
5pm - 7pm
  
CIT 201
  
zespirit
Friday, 9/7
  
7pm - 9pm
  
CIT 201
  
msantoma
Friday, 9/7
  
7pm - 9pm
  
CIT 201
  
mlitt2
Please make sure to take advantage of the available hours—your TAs are here to help you succeed in the course!

8 Template Files
Examplar

Implementation

9 Handing In
You will submit two separate files, named docdiff-code.arr and docdiff-tests.arr.