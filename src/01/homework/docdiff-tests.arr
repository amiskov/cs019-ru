include my-gdrive('docdiff-code.arr')
include math

d1 = [list: "a", "b", "c"]
d2 = [list: "d", "d", "d", "b"]
commonLetters = [list: "a", "b", "c", "d"]
v1 = [list: 1, 1, 1, 0]
v2 = [list: 0, 1, 0, 3]

check "find all distinct letters in documents":
  findAllWords(empty, empty) is empty
  findAllWords(d1, d2) is commonLetters
end

check "create a vector from document":
  makeVec(commonLetters, d1) is v1
  makeVec(commonLetters, d2) is v2
end

check "dot-product of two vectors":
  dot-product(v1, v2) is (1 * 0) + (1 * 1) + (1 * 0) + (0 * 3)
  dot-product([list: 1, 3, -5], [list: 4, -2, -1]) is 3
  dot-product(empty, empty) is 0
end

check "overlap of two documents":
  overlap([list:"a"], [list:"b"]) is 0
  overlap([list:"a"], [list:"a"]) is 1
  overlap(d1, d2) is dot-product(v1, v2) / max([list: dot-product(v1, v1), dot-product(v2, v2)])
end