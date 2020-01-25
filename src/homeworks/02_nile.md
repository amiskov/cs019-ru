# Nile
[Original text](https://cs.brown.edu/courses/cs019/2018/nilenile.html)

## 1. Introduction
You are creating Nile.com, which you hope will be the next big thing in online bookstores. You know that you can save money by anticipating what books people will buy; you will pass these savings on to your users by offering a discount if they buy books that Nile recommends.

> This assignment is meant to introduce you to the concept of [collaborative filtering](https://en.wikipedia.org/wiki/Collaborative_filtering).

To do this, you offer an incentive for people to upload their lists of recommended books. From their lists, you can establish suggested pairs. A pair of books is a suggested pair if both books appear on one person’s recommendation list. Of course, some suggested pairs are more popular than others. Also, any given book is paired with some books much more frequently than with others.

## 2. Warning
Past students have found this assignment quite difficult relative to when it appears in the course. Think hard about decomposing the problem into simpler pieces rather than trying to solve it entirely in one step. Give yourself enough time!

## 3. Assignment
You need to organize the list of recommended books to support two tasks:

- recommend a Book;
- recommend a Pair of Books.

### 3.1 Recommend a Book
When someone buys a book, you want to be able to suggest a second book to accompany it. Specifically, you should provide the book it is most frequently paired with in the recommendation lists, along with a count of how frequent this is. Because there may be more than one book with that count, you should return a list of books (even if there is only one) as well as the count. This will be in the form of a Recommendation:

```pyret
data Recommendation:
    | recommendation(count :: Number, names :: List<String>)
end
```

### 3.2 Recommend a Pair of Books
Sometimes, an indecisive user asks for a book recommendation. Nile offers not one recommendation at a time, but pairs of them! Wow! To support this, you must be able to identify the most popular pairs of suggested books. Return the most popular pair, with a count of how often it occurs. Again, because there may be multiple pairs with the same count, you should return a list of pairs (even if there is only one).

A list of recommended books is represented as a File:

```pyret
data File:
    | file(name :: String, content :: String)
end
```

Each file contains a single input list, with single book descriptions on each line. That is, book descriptions will be separated by `"\n"`. Each book has a unique and unambiguous description; that is, if two lines in two different input lists are identical, they refer to the same book. Otherwise they refer to different books. Input lists will always contain at least two books, and they will never contain duplicates. For example, an input file could be

```pyret
file("vty.txt", "Crime and Punishment\nHeaps are Lame\nLord of the Flies")
```

### 3.3 Functions
Define the following functions:

```pyret
fun recommend(title :: String, book-records :: List<File>) -> Recommendation
```

`recommend` takes a book title and a list of `File`s and produces a `Recommendation`. The `Recommendation`’s names is a list of the titles of the books that are most often paired with the input book. The `Recommendation`’s count is the number of times the books in the names list are each paired with the input book. When no pairing can be found, recommend should return `recommendation(0,[list: ])`.

```pyret
fun popular-pairs(records :: List<File>) -> Recommendation
```

`popular-pairs` takes a list of `File`s and produces a `Recommendation`. The `Recommendation`’s names is a list of `String`s each of which represent a pair of books. Each of these `String`s contains two titles separated by a `"+"`, for example `"book1+book2"`. Each most popular pair of books should appear exactly once and order is irrelevant. The `Recommendation`’s count is the number of times each pair occurred together in a file. When no pairing can be found, popular-pairs should return `recommendation(0, [list: ])`.

### 3.4 Built-Ins
For this assignment, you will need to write your own version of any built-in functions that you choose to use, other than the higher-order functions `map`, `filter`, and `fold`.

> This is to force you to practice: you should be getting able to write such functions without much difficulty. Also, studies show that _drill_ is a really good way to get better at programming.

For strings, you may only use `string-to-code-point`, `string-from-code-point`, `string-to-code-points`, and `string-from-code-points`. Built-in string functions can be recreated by operating on lists of code points. You are, however, welcome to use operators on `String`s (`+`, `<=`, `>`, `==`, etc.).

For lists, you may use `list.first`, `list.rest`, `map`, `filter`, and `fold`. You may not use any built-in functions such as `length`, `member`, `get`, `split-at`, etc. You should be able to write your own versions of these functions using link and empty.

When writing your own version of built-in functions, we do expect to see all the steps of design recipe, including a reasonable sample of examples (but not a detailed test suite).

## Comments
Because we have not yet discussed any efficiency measures in class, you are not asked to consider the efficiency of your implementation.

As a reminder, you may not use a late pass for this assignment.

## Handing In
You will submit two separate files, `nile-code.arr` and `nile-tests.arr`.
