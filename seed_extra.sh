#!/bin/bash
# Extra LeetCode seed script
# Usage: ./seed_extra.sh [api_url]
# Default: http://localhost:8080/api/v1

API="${1:-http://localhost:8080/api/v1}"

echo "=== Adding More LeetCode Questions ==="

# 1. Add Two Numbers
echo "1. Add Two Numbers..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Add Two Numbers",
    "description": "You are given two non-empty linked lists representing two non-negative integers.\nThe digits are stored in reverse order, and each of their nodes contains a single digit.\nAdd the two numbers and return the sum as a linked list.\n\nInput format: first line first number digits space-separated, second line second number digits.\nOutput format: sum digits space-separated.",
    "difficulty": "MEDIUM",
    "sampleInput": "2 4 3\n5 6 4",
    "sampleOutput": "7 0 8",
    "testCases": [
      {"input": "2 4 3\n5 6 4", "expectedOutput": "7 0 8", "isHidden": false},
      {"input": "0\n0", "expectedOutput": "0", "isHidden": false},
      {"input": "9 9 9 9 9 9 9\n9 9 9 9", "expectedOutput": "8 9 9 9 0 0 0 1", "isHidden": true},
      {"input": "1 8\n0", "expectedOutput": "1 8", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 2. Longest Common Prefix
echo "2. Longest Common Prefix..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Longest Common Prefix",
    "description": "Write a function to find the longest common prefix string amongst an array of strings.\n\nIf there is no common prefix, return an empty string.\n\nInput: comma-separated strings.\nOutput: the common prefix.",
    "difficulty": "EASY",
    "sampleInput": "flower,flow,flight",
    "sampleOutput": "fl",
    "testCases": [
      {"input": "flower,flow,flight", "expectedOutput": "fl", "isHidden": false},
      {"input": "dog,racecar,car", "expectedOutput": "", "isHidden": false},
      {"input": "apple,apricot,april", "expectedOutput": "ap", "isHidden": true},
      {"input": "a", "expectedOutput": "a", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 3. Roman to Integer
echo "3. Roman to Integer..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Roman to Integer",
    "description": "Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.\n\nGiven a roman numeral, convert it to an integer.\n\nSymbol values: I=1, V=5, X=10, L=50, C=100, D=500, M=1000",
    "difficulty": "EASY",
    "sampleInput": "III",
    "sampleOutput": "3",
    "testCases": [
      {"input": "III", "expectedOutput": "3", "isHidden": false},
      {"input": "LVIII", "expectedOutput": "58", "isHidden": false},
      {"input": "MCMXCIV", "expectedOutput": "1994", "isHidden": false},
      {"input": "IV", "expectedOutput": "4", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 4. Merge Sorted Array
echo "4. Merge Sorted Array..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Merge Sorted Array",
    "description": "You are given two integer arrays nums1 and nums2, sorted in non-decreasing order.\nMerge nums2 into nums1 as one sorted array.\n\nInput: first line nums1, second line nums2.\nOutput: merged sorted array.",
    "difficulty": "EASY",
    "sampleInput": "1 2 3 0 0 0\n2 5 6",
    "sampleOutput": "1 2 2 3 5 6",
    "testCases": [
      {"input": "1 2 3 0 0 0\n2 5 6", "expectedOutput": "1 2 2 3 5 6", "isHidden": false},
      {"input": "1\n", "expectedOutput": "1", "isHidden": false},
      {"input": "0\n1", "expectedOutput": "1", "isHidden": true},
      {"input": "4 5 6 0 0 0\n1 2 3", "expectedOutput": "1 2 3 4 5 6", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 5. Single Number
echo "5. Single Number..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Single Number",
    "description": "Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.\n\nYou must implement a solution with a linear runtime complexity and use only constant extra space.",
    "difficulty": "EASY",
    "sampleInput": "2 2 1",
    "sampleOutput": "1",
    "testCases": [
      {"input": "2 2 1", "expectedOutput": "1", "isHidden": false},
      {"input": "4 1 2 1 2", "expectedOutput": "4", "isHidden": false},
      {"input": "1", "expectedOutput": "1", "isHidden": true},
      {"input": "5 5 3 3 7 7 9", "expectedOutput": "9", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 6. Majority Element
echo "6. Majority Element..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Majority Element",
    "description": "Given an array nums of size n, return the majority element.\n\nThe majority element is the element that appears more than ⌊n / 2⌋ times.\nYou may assume that the majority element always exists in the array.",
    "difficulty": "EASY",
    "sampleInput": "3 2 3",
    "sampleOutput": "3",
    "testCases": [
      {"input": "3 2 3", "expectedOutput": "3", "isHidden": false},
      {"input": "2 2 1 1 1 2 2", "expectedOutput": "2", "isHidden": false},
      {"input": "1", "expectedOutput": "1", "isHidden": true},
      {"input": "6 5 5", "expectedOutput": "5", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 7. Happy Number
echo "7. Happy Number..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Happy Number",
    "description": "Write an algorithm to determine if a number n is happy.\n\nA happy number is a number defined by the following process:\n- Starting with any positive integer, replace the number by the sum of the squares of its digits.\n- Repeat the process until the number equals 1, or it loops endlessly in a cycle.\n- Return true if it ends in 1.\n\nInput: a positive integer.\nOutput: true/false.",
    "difficulty": "EASY",
    "sampleInput": "19",
    "sampleOutput": "true",
    "testCases": [
      {"input": "19", "expectedOutput": "true", "isHidden": false},
      {"input": "2", "expectedOutput": "false", "isHidden": false},
      {"input": "1", "expectedOutput": "true", "isHidden": true},
      {"input": "7", "expectedOutput": "true", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 8. Remove Duplicates from Sorted Array
echo "8. Remove Duplicates from Sorted Array..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Remove Duplicates from Sorted Array",
    "description": "Given an integer array nums sorted in non-decreasing order, remove the duplicates in-place.\nReturn the number of unique elements.\n\nOutput: the count of unique elements, followed by the unique elements space-separated.",
    "difficulty": "EASY",
    "sampleInput": "1 1 2",
    "sampleOutput": "2\n1 2",
    "testCases": [
      {"input": "1 1 2", "expectedOutput": "2\n1 2", "isHidden": false},
      {"input": "0 0 1 1 1 2 2 3 3 4", "expectedOutput": "5\n0 1 2 3 4", "isHidden": false},
      {"input": "1 2 3", "expectedOutput": "3\n1 2 3", "isHidden": true},
      {"input": "", "expectedOutput": "0", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 9. Plus One
echo "9. Plus One..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Plus One",
    "description": "You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer.\nThe digits are ordered from most significant to least significant in left-to-right order.\nIncrement the large integer by one and return the resulting array.",
    "difficulty": "EASY",
    "sampleInput": "1 2 3",
    "sampleOutput": "1 2 4",
    "testCases": [
      {"input": "1 2 3", "expectedOutput": "1 2 4", "isHidden": false},
      {"input": "4 3 2 1", "expectedOutput": "4 3 2 2", "isHidden": false},
      {"input": "9", "expectedOutput": "1 0", "isHidden": true},
      {"input": "9 9 9", "expectedOutput": "1 0 0 0", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 10. Pascal's Triangle
echo "10. Pascal Triangle..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Pascal Triangle",
    "description": "Given an integer numRows, return the first numRows of Pascal triangle.\n\nIn Pascal triangle, each number is the sum of the two numbers directly above it.\n\nOutput: each row on a separate line, numbers space-separated.",
    "difficulty": "EASY",
    "sampleInput": "5",
    "sampleOutput": "1\n1 1\n1 2 1\n1 3 3 1\n1 4 6 4 1",
    "testCases": [
      {"input": "5", "expectedOutput": "1\n1 1\n1 2 1\n1 3 3 1\n1 4 6 4 1", "isHidden": false},
      {"input": "1", "expectedOutput": "1", "isHidden": false},
      {"input": "3", "expectedOutput": "1\n1 1\n1 2 1", "isHidden": true},
      {"input": "6", "expectedOutput": "1\n1 1\n1 2 1\n1 3 3 1\n1 4 6 4 1\n1 5 10 10 5 1", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 11. Valid Sudoku
echo "11. Valid Sudoku..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Valid Sudoku",
    "description": "Determine if a 9 x 9 Sudoku board is valid.\n\nOnly the filled cells need to be validated according to the rules:\n1. Each row must contain digits 1-9 without repetition.\n2. Each column must contain digits 1-9 without repetition.\n3. Each 3x3 sub-box must contain digits 1-9 without repetition.\n\nInput: 9 rows separated by semicolons, dots for empty cells.\nOutput: true/false.",
    "difficulty": "MEDIUM",
    "sampleInput": "53..7....;6..195...;.98....6.;8...6...3;4..8.3..1;7...2...6;.6....28.;...419..5;....8..79",
    "sampleOutput": "true",
    "testCases": [
      {"input": "53..7....;6..195...;.98....6.;8...6...3;4..8.3..1;7...2...6;.6....28.;...419..5;....8..79", "expectedOutput": "true", "isHidden": false},
      {"input": "83..7....;6..195...;.98....6.;8...6...3;4..8.3..1;7...2...6;.6....28.;...419..5;....8..79", "expectedOutput": "false", "isHidden": false},
      {"input": "53..7....;6..195...;.98....6.;8...6...3;4..8.3..1;7...2...6;.6....28.;...419..5;....8..79", "expectedOutput": "true", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 12. Search in Rotated Sorted Array
echo "12. Search in Rotated Sorted Array..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Search in Rotated Sorted Array",
    "description": "There is an integer array nums sorted in ascending order (with distinct values).\nPrior to being passed to your function, nums is rotated at an unknown pivot.\nGiven the array nums and a target integer, return the index of target if it is in nums, or -1 if not.\n\nInput: first line nums, second line target.\nOutput: index or -1.",
    "difficulty": "MEDIUM",
    "sampleInput": "4 5 6 7 0 1 2\n0",
    "sampleOutput": "4",
    "testCases": [
      {"input": "4 5 6 7 0 1 2\n0", "expectedOutput": "4", "isHidden": false},
      {"input": "4 5 6 7 0 1 2\n3", "expectedOutput": "-1", "isHidden": false},
      {"input": "1\n0", "expectedOutput": "-1", "isHidden": true},
      {"input": "3 1\n1", "expectedOutput": "1", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 13. Generate Parentheses
echo "13. Generate Parentheses..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Generate Parentheses",
    "description": "Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.\n\nOutput: all valid combinations sorted, space-separated.",
    "difficulty": "MEDIUM",
    "sampleInput": "3",
    "sampleOutput": "((())) (()()) (())() ()(()) ()()()",
    "testCases": [
      {"input": "3", "expectedOutput": "((())) (()()) (())() ()(()) ()()()", "isHidden": false},
      {"input": "1", "expectedOutput": "()", "isHidden": false},
      {"input": "2", "expectedOutput": "(()) ()()", "isHidden": true},
      {"input": "4", "expectedOutput": "(((()))) ((()())) ((())()) ((()))() (()(())) (()()()) (()())() (())(()) (())()() ()((())) ()(()()) ()(())() ()()(()) ()()()()", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 14. Unique Paths
echo "14. Unique Paths..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Unique Paths",
    "description": "There is a robot on an m x n grid. The robot is trying to reach the bottom-right corner.\nThe robot can only move down or right at any point in time.\n\nGiven m and n, return the number of possible unique paths.\n\nInput: m n\nOutput: number of unique paths.",
    "difficulty": "MEDIUM",
    "sampleInput": "3 7",
    "sampleOutput": "28",
    "testCases": [
      {"input": "3 7", "expectedOutput": "28", "isHidden": false},
      {"input": "3 2", "expectedOutput": "3", "isHidden": false},
      {"input": "7 3", "expectedOutput": "28", "isHidden": true},
      {"input": "3 3", "expectedOutput": "6", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 15. Sort Colors
echo "15. Sort Colors..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Sort Colors",
    "description": "Given an array nums with n objects colored red, white, or blue, sort them in-place.\n\nWe will use integers 0, 1, and 2 to represent red, white, and blue respectively.\n\nInput: space-separated integers (0, 1, 2)\nOutput: sorted array space-separated.",
    "difficulty": "MEDIUM",
    "sampleInput": "2 0 2 1 1 0",
    "sampleOutput": "0 0 1 1 2 2",
    "testCases": [
      {"input": "2 0 2 1 1 0", "expectedOutput": "0 0 1 1 2 2", "isHidden": false},
      {"input": "2 0 1", "expectedOutput": "0 1 2", "isHidden": false},
      {"input": "0", "expectedOutput": "0", "isHidden": true},
      {"input": "1 2 0 2 1 0 1", "expectedOutput": "0 0 1 1 1 2 2", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 16. Binary Tree Level Order Traversal
echo "16. Binary Tree Level Order Traversal..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Binary Tree Level Order Traversal",
    "description": "Given the root of a binary tree, return the level order traversal of its nodes values.\n\nInput: space-separated nodes (null for missing), level order.\nOutput: each level on a new line, values space-separated.",
    "difficulty": "MEDIUM",
    "sampleInput": "3 9 20 null null 15 7",
    "sampleOutput": "3\n9 20\n15 7",
    "testCases": [
      {"input": "3 9 20 null null 15 7", "expectedOutput": "3\n9 20\n15 7", "isHidden": false},
      {"input": "1", "expectedOutput": "1", "isHidden": false},
      {"input": "", "expectedOutput": "", "isHidden": true},
      {"input": "1 2 3 4 5", "expectedOutput": "1\n2 3\n4 5", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 17. Symmetric Tree
echo "17. Symmetric Tree..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Symmetric Tree",
    "description": "Given the root of a binary tree, check whether it is a mirror of itself (symmetric around its center).\n\nInput: space-separated nodes (null for missing), level order.\nOutput: true/false.",
    "difficulty": "EASY",
    "sampleInput": "1 2 2 3 4 4 3",
    "sampleOutput": "true",
    "testCases": [
      {"input": "1 2 2 3 4 4 3", "expectedOutput": "true", "isHidden": false},
      {"input": "1 2 2 null 3 null 3", "expectedOutput": "false", "isHidden": false},
      {"input": "1", "expectedOutput": "true", "isHidden": true},
      {"input": "", "expectedOutput": "true", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 18. Path Sum
echo "18. Path Sum..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Path Sum",
    "description": "Given the root of a binary tree and an integer targetSum, return true if the tree has a root-to-leaf path such that summing all the values along the path equals targetSum.\n\nInput: first line nodes space-separated, second line target sum.\nOutput: true/false.",
    "difficulty": "EASY",
    "sampleInput": "5 4 8 11 null 13 4 7 2 null null null 1\n22",
    "sampleOutput": "true",
    "testCases": [
      {"input": "5 4 8 11 null 13 4 7 2 null null null 1\n22", "expectedOutput": "true", "isHidden": false},
      {"input": "1 2 3\n5", "expectedOutput": "false", "isHidden": false},
      {"input": "1 2\n1", "expectedOutput": "false", "isHidden": true},
      {"input": "1\n1", "expectedOutput": "true", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 19. Best Time to Buy and Sell Stock II
echo "19. Best Time to Buy and Sell Stock II..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Best Time to Buy and Sell Stock II",
    "description": "You are given an integer array prices where prices[i] is the price of a given stock on the ith day.\n\nOn each day, you may decide to buy and/or sell the stock. You can only hold at most one share at any time.\nFind and return the maximum profit you can achieve.",
    "difficulty": "MEDIUM",
    "sampleInput": "7 1 5 3 6 4",
    "sampleOutput": "7",
    "testCases": [
      {"input": "7 1 5 3 6 4", "expectedOutput": "7", "isHidden": false},
      {"input": "1 2 3 4 5", "expectedOutput": "4", "isHidden": false},
      {"input": "7 6 4 3 1", "expectedOutput": "0", "isHidden": true},
      {"input": "1 5 3 8 4 9", "expectedOutput": "13", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 20. LRU Cache
echo "20. LRU Cache..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "LRU Cache",
    "description": "Design a data structure that follows the constraints of a Least Recently Used (LRU) cache.\n\nImplement the LRUCache class:\n- LRUCache(capacity) Initialize the LRU cache with positive size capacity.\n- get(key) Return the value if key exists, otherwise return -1.\n- put(key, value) Update or insert the value. If the number of keys exceeds capacity, evict the LRU key.\n\nInput: operations in format 'get:1,put:1 1,get:1'\nOutput: results of get operations space-separated.",
    "difficulty": "MEDIUM",
    "sampleInput": "put:1 1,put:2 2,get:1,put:3 3,get:2,put:4 4,get:1,get:3,get:4",
    "sampleOutput": "1 -1 -1 3 4",
    "testCases": [
      {"input": "put:1 1,put:2 2,get:1,put:3 3,get:2,put:4 4,get:1,get:3,get:4", "expectedOutput": "1 -1 -1 3 4", "isHidden": false},
      {"input": "get:1,put:1 1,get:1", "expectedOutput": "-1 1", "isHidden": false},
      {"input": "put:1 1,put:2 2,get:1,get:2", "expectedOutput": "1 2", "isHidden": true},
      {"input": "put:2 1,put:2 2,get:2", "expectedOutput": "2", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

echo ""
echo "=== Questions Added! ==="

# Get and display all questions
echo ""
echo "=== All Questions ==="
curl -s "$API/questions" | python -c "
import sys, json
d = json.load(sys.stdin)['data']
print(f'Total: {len(d)} questions')
for q in d:
    print(f'  ID {q[\"id\"]:3d}: {q[\"title\"][:45]:45s} ({q[\"difficulty\"]})')
" 2>/dev/null || curl -s "$API/questions" | python3 -c "
import sys, json
d = json.load(sys.stdin)['data']
print(f'Total: {len(d)} questions')
for q in d:
    print(f'  ID {q[\"id\"]:3d}: {q[\"title\"][:45]:45s} ({q[\"difficulty\"]})')
"

echo ""
echo "=== Creating Tests ==="

# First get the latest question IDs
QUESTION_JSON=$(curl -s "$API/questions")
echo "Got question list, creating tests..."

# Test 1: Easy Warmup
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Easy Warmup",
    "description": "A collection of easy problems to warm up your coding skills. Covers arrays, strings, and basic algorithms.",
    "duration": 60,
    "isActive": true,
    "questionIds": [1, 2, 3, 11, 12, 13, 19, 39]
  }' | python -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

# Test 2: Array Mastery
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Array Mastery",
    "description": "Test your array manipulation skills with problems on two pointers, sliding window, and sorting.",
    "duration": 90,
    "isActive": true,
    "questionIds": [1, 5, 6, 14, 15, 17, 26]
  }' | python -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

# Test 3: Tree Week
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Tree Week",
    "description": "Binary tree and BST problems including traversals, validation, and path finding.",
    "duration": 90,
    "isActive": true,
    "questionIds": [16, 17, 18, 39, 42]
  }' | python -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

# Test 4: Dynamic Programming
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Dynamic Programming",
    "description": "Challenge yourself with classic DP problems including climbing stairs, coin change, and unique paths.",
    "duration": 120,
    "isActive": true,
    "questionIds": [7, 10, 14, 20, 24, 28]
  }' | python -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

# Test 5: Medium Mix
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Medium Mix",
    "description": "A curated mix of medium difficulty problems covering graphs, strings, and backtracking.",
    "duration": 120,
    "isActive": true,
    "questionIds": [4, 8, 12, 22, 23, 29, 31]
  }' | python -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

# Test 6: Hard Challenge
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Hard Challenge",
    "description": "Hard difficulty problems for advanced coders. Covers hard DP, rain water, and median finding.",
    "duration": 180,
    "isActive": true,
    "questionIds": [18, 25, 34, 35, 36, 37]
  }' | python -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

echo ""
echo "=== All Tests ==="
curl -s "$API/tests" | python -c "
import sys,json
d=json.load(sys.stdin)['data']
print(f'Total: {len(d)} tests')
for t in d:
    print(f'  ID {t[\"id\"]}: {t[\"title\"]} (Code: {t[\"accessCode\"]}, Duration: {t[\"duration\"]}min)')
" 2>/dev/null

echo ""
echo "=== Done! ==="
echo "Run the app and use access codes above to start tests."
