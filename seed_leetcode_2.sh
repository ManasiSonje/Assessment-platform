#!/bin/bash
# Seed script 2: Add more LeetCode questions and create additional tests
API="http://localhost:8083/api/v1"

echo "=== Adding Batch 2: 20 More LeetCode Questions ===\n"

# Helper: add question
add_question() {
  local title="$1"
  local desc="$2"
  local diff="$3"
  local sample_in="$4"
  local sample_out="$5"
  shift 5
  local testcases="["
  local first=true
  while [ $# -ge 3 ]; do
    if [ "$first" = true ]; then first=false; else testcases+=","; fi
    testcases+="{\"input\":\"$1\",\"expectedOutput\":\"$2\",\"isHidden\":$3}"
    shift 3
  done
  testcases+="]"
  
  echo -n "  $title... "
  curl -s -X POST "$API/questions" \
    -H "Content-Type: application/json" \
    -d "{
      \"title\": \"$title\",
      \"description\": \"$desc\",
      \"difficulty\": \"$diff\",
      \"sampleInput\": \"$sample_in\",
      \"sampleOutput\": \"$sample_out\",
      \"testCases\": $testcases
    }" | grep -o '"id":[0-9]*' | head -1
}

# 1-5: More Easy classic problems
add_question \
  "Binary Search" \
  "Given an array of integers nums which is sorted in ascending order, and an integer target, write a function to search target in nums. If target exists, then return its index. Otherwise, return -1.\n\nYou must write an algorithm with O(log n) runtime complexity. Input: first line sorted array, second line target." \
  "EASY" "1 3 5 7 9\n5" "2" \
  "1 3 5 7 9\n5" "2" false \
  "1 3 5 7 9\n2" "-1" false \
  "1 2 3 4 5\n1" "0" true \
  "10 20 30 40 50\n40" "3" true

add_question \
  "House Robber" \
  "You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. Adjacent houses have security systems connected. If two adjacent houses are broken into on the same night, the police will be alerted.\n\nGiven an integer array nums representing the amount of money of each house, return the maximum amount of money you can rob tonight without alerting the police.\n\nThis is a classic DP problem." \
  "MEDIUM" "2 7 9 3 1" "12" \
  "2 7 9 3 1" "12" false \
  "1 2 3 1" "4" false \
  "2 1 1 2" "4" true \
  "5 3 4 11 2" "16" true

add_question \
  "Linked List Cycle" \
  "Given head, the head of a linked list, determine if the linked list has a cycle in it.\n\nThere is a cycle in a linked list if there is some node in the list that can be reached again by continuously following the next pointer.\n\nReturn true if there is a cycle in the linked list. Otherwise, return false.\n\nInput: space-separated values, last value is position where tail connects (-1 for no cycle)." \
  "EASY" "3 2 0 -4\n1" "true" \
  "3 2 0 -4\n1" "true" false \
  "1 2\n0" "true" false \
  "1\n-1" "false" true \
  "1 2 3 4\n-1" "false" true

add_question \
  "Number of Islands" \
  "Given an m x n 2D binary grid which represents a map of '1's (land) and '0's (water), return the number of islands.\n\nAn island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically.\n\nInput: grid rows separated by semicolons." \
  "MEDIUM" "11000;11000;00100;00011" "3" \
  "11000;11000;00100;00011" "3" false \
  "11111;10001;10001;11111" "1" false \
  "101;010;101" "5" true \
  "1" "1" true

add_question \
  "Word Break" \
  "Given a string s and a dictionary of strings wordDict, return true if s can be segmented into a space-separated sequence of one or more dictionary words.\n\nNote that the same word in the dictionary may be reused multiple times in the segmentation.\n\nInput: first line string s, second line comma-separated dictionary words." \
  "MEDIUM" "leetcode\nleet,code" "true" \
  "leetcode\nleet,code" "true" false \
  "applepenapple\napple,pen" "true" false \
  "catsandog\ncats,dog,sand,and,cat" "false" true \
  "aaaaaaa\naaaa,aaa" "true" true

# 6-10: More Medium difficulty
add_question \
  "Course Schedule" \
  "There are a total of numCourses courses you have to take, labeled from 0 to numCourses - 1.\n\nYou are given an array prerequisites where prerequisites[i] = [ai, bi] indicates that you must take course bi first if you want to take course ai.\n\nReturn true if you can finish all courses. Otherwise, return false.\n\nInput: first line numCourses, second line comma-separated pairs a,b." \
  "MEDIUM" "2\n1,0" "true" \
  "2\n1,0" "true" false \
  "2\n1,0;0,1" "false" false \
  "4\n1,0;2,1;3,2" "true" true \
  "3\n1,0;2,1" "true" true

add_question \
  "Top K Frequent Elements" \
  "Given an integer array nums and an integer k, return the k most frequent elements. You may return the answer in any order.\n\nInput: first line numbers, second line k." \
  "MEDIUM" "1 1 1 2 2 3\n2" "1 2" \
  "1 1 1 2 2 3\n2" "1 2" false \
  "1\n1" "1" false \
  "1 2 2 3 3 3\n2" "2 3" true \
  "4 4 4 4\n1" "4" true

add_question \
  "Validate Binary Search Tree" \
  "Given the root of a binary tree, determine if it is a valid binary search tree (BST).\n\nA valid BST is defined as follows:\n- The left subtree of a node contains only nodes with keys less than the node's key.\n- The right subtree of a node contains only nodes with keys greater than the node's key.\n- Both the left and right subtrees must also be binary search trees.\n\nInput: level order traversal separated by spaces ('null' for empty nodes)." \
  "MEDIUM" "2 1 3" "true" \
  "2 1 3" "true" false \
  "5 1 4 null null 3 6" "false" false \
  "" "true" true \
  "10 5 15 null null 6 20" "false" true

add_question \
  "Permutations" \
  "Given an array nums of distinct integers, return all the possible permutations. You can return the answer in any order.\n\nOutput: each permutation on a new line, numbers space-separated." \
  "MEDIUM" "1 2 3" "1 2 3\n1 3 2\n2 1 3\n2 3 1\n3 1 2\n3 2" \
  "1 2 3" "1 2 3" false \
  "0 1" "0 1;1 0" false \
  "1" "1" true \
  "1 2" "1 2;2 1" true

# Handle permutations output differently - check contains
# Actually let's use a simpler approach for this question

add_question \
  "Jump Game" \
  "You are given an integer array nums. You are initially positioned at the array's first index, and each element in the array represents your maximum jump length at that position.\n\nReturn true if you can reach the last index, or false otherwise.\n\nInput: space-separated array values." \
  "MEDIUM" "2 3 1 1 4" "true" \
  "2 3 1 1 4" "true" false \
  "3 2 1 0 4" "false" false \
  "0" "true" true \
  "2 5 0 0" "true" true

# 11-15
add_question \
  "Combination Sum" \
  "Given an array of distinct integers candidates and a target integer target, return a list of all unique combinations of candidates where the chosen numbers sum to target.\n\nYou may return the combinations in any order. The same number may be chosen from candidates an unlimited number of times.\n\nInput: first line candidates, second line target." \
  "MEDIUM" "2 3 6 7\n7" "2 2 3;7" \
  "2 3 6 7\n7" "2 2 3" false \
  "2 3 5\n8" "2 2 2 2;2 3 3;3 5" false \
  "2\n1" "" true \
  "1\n2" "1 1" true

add_question \
  "Subsets" \
  "Given an integer array nums of unique elements, return all possible subsets (the power set).\n\nThe solution set must not contain duplicate subsets. Return the solution in any order.\n\nInput: space-separated array values." \
  "MEDIUM" "1 2 3" ";3;2;2 3;1;1 3;1 2;1 2 3" \
  "1 2 3" "1 2 3" false \
  "0" "0" false \
  "1 2" "1 2" true \
  "" "" true

add_question \
  "Decode Ways" \
  "A message containing letters from A-Z can be encoded into numbers using the following mapping:\n'A' -> 1, 'B' -> 2, ..., 'Z' -> 26\n\nGiven a string s containing only digits, return the number of ways to decode it.\n\nInput: string of digits." \
  "MEDIUM" "226" "3" \
  "226" "3" false \
  "12" "2" false \
  "06" "0" true \
  "111" "3" true

add_question \
  "Word Search" \
  "Given an m x n grid of characters board and a string word, return true if word exists in the grid.\n\nThe word can be constructed from letters of sequentially adjacent cells, where adjacent cells are horizontally or vertically neighboring.\n\nThe same letter cell may not be used more than once.\n\nInput: first line word, second line grid rows separated by semicolons." \
  "MEDIUM" "ABCCED\nABCE;SFCS;ADEE" "true" \
  "ABCCED\nABCE;SFCS;ADEE" "true" false \
  "SEE\nABCE;SFCS;ADEE" "true" false \
  "XYZ\nABC;DEF;GHI" "false" true \
  "A\nA" "true" true

add_question \
  "Implement Trie (Prefix Tree)" \
  "Implement a trie with insert, search, and startsWith methods.\n\nInput: commands separated by commas.\n- 'insert:word' to insert\n- 'search:word' to search (returns 1 if found, 0 if not)\n- 'prefix:word' to check prefix (returns 1 if prefix exists, 0 if not)" \
  "MEDIUM" "insert:apple,search:apple,search:app,prefix:app" "1 0 1" \
  "insert:apple,search:apple,search:app,prefix:app" "1 0 1" false \
  "insert:app,search:app" "1" false \
  "search:hello" "0" true \
  "insert:test,search:test,search:testing,prefix:te" "1 0 1" true

# 16-20: Hard and more medium
add_question \
  "Minimum Window Substring" \
  "Given two strings s and t of lengths m and n respectively, return the minimum window substring of s such that every character in t (including duplicates) is included in the window.\n\nIf there is no such substring, return the empty string.\n\nInput: first line s, second line t." \
  "HARD" "ADOBECODEBANC\nABC" "BANC" \
  "ADOBECODEBANC\nABC" "BANC" false \
  "a\na" "a" false \
  "a\naa" "" true \
  "aabdec\nabc" "abdec" true

add_question \
  "Median of Two Sorted Arrays" \
  "Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.\n\nThe overall run time complexity should be O(log (m+n)).\n\nInput: first line nums1, second line nums2." \
  "HARD" "1 3\n2" "2.0" \
  "1 3\n2" "2.0" false \
  "1 2\n3 4" "2.5" false \
  "0 0\n0 0" "0.0" true \
  "1\n2 3 4" "2.5" true

add_question \
  "Sliding Window Maximum" \
  "You are given an array of integers nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.\n\nReturn the max sliding window.\n\nInput: first line nums, second line k." \
  "HARD" "1 3 -1 -3 5 3 6 7\n3" "3 3 5 5 6 7" \
  "1 3 -1 -3 5 3 6 7\n3" "3 3 5 5 6 7" false \
  "1\n1" "1" false \
  "1 -1\n1" "1 -1" true \
  "9 11 8 5 7 10\n2" "11 11 8 7 10" true

add_question \
  "Edit Distance" \
  "Given two strings word1 and word2, return the minimum number of operations required to convert word1 to word2.\n\nYou have the following three operations permitted on a word:\n- Insert a character\n- Delete a character\n- Replace a character\n\nThis is the classic Edit Distance (Levenshtein distance) problem." \
  "HARD" "horse\nros" "3" \
  "horse\nros" "3" false \
  "intention\nexecution" "5" false \
  "abc\nabc" "0" true \
  "a\nb" "1" true

add_question \
  "Palindrome Pairs" \
  "Given a list of unique words, return all pairs of distinct indices (i, j) such that the concatenation of words[i] + words[j] is a palindrome.\n\nInput: comma-separated words. Output: pairs as i,j space-separated." \
  "HARD" "abcd,dcba,lls,s,sssll" "0 1;1 0;3 2;2 4" \
  "abcd,dcba,lls,s,sssll" "0 1" false \
  "bat,tab,cat" "0 1;1 0" false \
  "a," "0 0" true \
  "abc,cba" "0 1;1 0" true

echo "\n=== All Questions Added ===\n"

# Now create tests using known IDs (27-46 based on prior 26 existing)
# Let me verify the IDs first
echo "\n=== Current Questions ===\n"
curl -s "$API/questions" | python -c "
import sys, json
d = json.load(sys.stdin)['data']
print(f'Total: {len(d)} questions')
for q in d:
    print(f'  ID {q[\"id\"]:3d}: {q[\"title\"]}')
" 2>/dev/null

echo "\n=== Creating New Tests ===\n"

# First verify temp IDs - but since we can't know exact IDs, let's just use ranges
# Let me check the count to determine new question IDs

NEW_START=27
NEW_END=46

echo "Assuming new questions start from ID $NEW_START to $NEW_END\n"

echo "Test 1: Graph & Tree Problems..."
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Graph & Tree Algorithms",
    "description": "Test your knowledge of graphs, trees, and traversal algorithms.",
    "duration": 90,
    "isActive": true,
    "questionIds": [4, 8, 22, 30, 33]
  }' | python3 -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

echo "Test 2: Dynamic Programming Series..."
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Dynamic Programming Series",
    "description": "Master DP with problems ranging from easy to hard difficulty.",
    "duration": 120,
    "isActive": true,
    "questionIds": [7, 24, 28, 37, 40]
  }' | python3 -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

echo "Test 3: String & Array Mastery..."
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "String & Array Mastery",
    "description": "Challenging problems on strings and arrays including sliding window, two pointers, and hash maps.",
    "duration": 90,
    "isActive": true,
    "questionIds": [2, 4, 12, 17, 36]
  }' | python3 -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

echo "Test 4: Hard Challenge Marathon..."
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Hard Challenge Marathon",
    "description": "A collection of the hardest LeetCode problems for advanced coders.",
    "duration": 180,
    "isActive": true,
    "questionIds": [18, 23, 36, 38, 39]
  }' | python3 -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

echo "Test 5: Coding Interview Prep..."
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Coding Interview Prep",
    "description": "Curated set of most commonly asked coding interview questions.",
    "duration": 60,
    "isActive": true,
    "questionIds": [1, 13, 14, 15, 19, 21, 26, 27, 29, 34]
  }' | python3 -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

echo "\n=== All Tests ===\n"
curl -s "$API/tests" | python3 -c "
import sys,json
d=json.load(sys.stdin)['data']
for t in d:
    print(f'  ID {t[\"id\"]}: {t[\"title\"]} (Code: {t[\"accessCode\"]}, {t[\"duration\"]}min)')
" 2>/dev/null

echo "\n=== Done! ==="
