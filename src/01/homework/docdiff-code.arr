provide *

include math

fun findAllWords(doc1 :: List<String>, doc2 :: List<String>) -> List<String>:
  doc: "Returns a list with all possible distinct words in 2 lists of words."
  largerList = if (doc1.length() > doc2.length()): doc1 else: doc2 end
  aux = lam(elt, acc):
    if (acc.member(elt)):
      acc
    else:
      acc.append([list: elt])      
    end
  end
  doc1.append(doc2).foldl(aux, empty)
end

fun makeVec(words :: List<String>, doc :: List<String>) -> List<Number>:
  doc: "Returns a vector, representing how many times words in `doc` found in `words`."
  aux = lam(w):
    doc.filter(lam(dw): dw == w end).length()
  end
  words.map(aux)
end

fun dot-product(vec1 :: List<Number>, vec2 :: List<Number>) -> Number:
  doc: "Returns dot-product of 2 vectors."
  cases (List) vec1:
    | empty => 0
    | link(f1, r1) =>
      cases (List) vec2:
        | empty => 0
        | link(f2, r2) => (f1 * f2) + dot-product(r1, r2)
      end
  end
end

fun overlap(doc1 :: List<String>, doc2 :: List<String>) -> Number:
  doc: "Returns a number, representing similarities with doc1 and doc2."
  words = findAllWords(doc1, doc2)
  vec1 = makeVec(words, doc1)
  vec2 = makeVec(words, doc2)

  dp = dot-product(vec1, vec2)
  dp1 = dot-product(vec1, vec1)
  dp2 = dot-product(vec2, vec2)

  dp / max([list: dp1, dp2])
end

