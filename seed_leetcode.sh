#!/bin/bash
# Seed script: Add LeetCode questions and create tests
API="http://localhost:8083/api/v1"

echo "=== Adding LeetCode Questions ==="

# 1. Two Sum (already exists - skip)
echo "1. Two Sum - already exists, skipping"

# 2. Valid Anagram
echo "\n2. Valid Anagram..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Valid Anagram",
    "description": "Given two strings s and t, return true if t is an anagram of s, and false otherwise.\n\nAn Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, using all the original letters exactly once.",
    "difficulty": "EASY",
    "sampleInput": "anagram nagaram",
    "sampleOutput": "true",
    "testCases": [
      {"input": "anagram nagaram", "expectedOutput": "true", "isHidden": false},
      {"input": "rat car", "expectedOutput": "false", "isHidden": false},
      {"input": "listen silent", "expectedOutput": "true", "isHidden": true},
      {"input": "hello world", "expectedOutput": "false", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 3. Best Time to Buy and Sell Stock
echo "\n3. Best Time to Buy and Sell Stock..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Best Time to Buy and Sell Stock",
    "description": "You are given an array prices where prices[i] is the price of a given stock on the ith day.\n\nYou want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.\n\nReturn the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.",
    "difficulty": "EASY",
    "sampleInput": "7 1 5 3 6 4",
    "sampleOutput": "5",
    "testCases": [
      {"input": "7 1 5 3 6 4", "expectedOutput": "5", "isHidden": false},
      {"input": "7 6 4 3 1", "expectedOutput": "0", "isHidden": false},
      {"input": "1 2 3 4 5", "expectedOutput": "4", "isHidden": true},
      {"input": "3 2 6 5 0 3", "expectedOutput": "4", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 4. Valid Parentheses
echo "\n4. Valid Parentheses..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Valid Parentheses",
    "description": "Given a string s containing just the characters ( ), { }, [ ], determine if the input string is valid.\n\nAn input string is valid if:\n1. Open brackets must be closed by the same type of brackets.\n2. Open brackets must be closed in the correct order.\n3. Every close bracket has a corresponding open bracket of the same type.",
    "difficulty": "EASY",
    "sampleInput": "()[]{}",
    "sampleOutput": "true",
    "testCases": [
      {"input": "()", "expectedOutput": "true", "isHidden": false},
      {"input": "()[]{}", "expectedOutput": "true", "isHidden": false},
      {"input": "(]", "expectedOutput": "false", "isHidden": false},
      {"input": "([])", "expectedOutput": "true", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 5. Reverse Linked List (as array in/out)
echo "\n5. Reverse Linked List..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Reverse Linked List",
    "description": "Given the head of a singly linked list, reverse the list, and return the reversed list.\n\nInput is given as space-separated integers representing the linked list values. Output should be the reversed list as space-separated integers.",
    "difficulty": "EASY",
    "sampleInput": "1 2 3 4 5",
    "sampleOutput": "5 4 3 2 1",
    "testCases": [
      {"input": "1 2 3 4 5", "expectedOutput": "5 4 3 2 1", "isHidden": false},
      {"input": "1 2", "expectedOutput": "2 1", "isHidden": false},
      {"input": "", "expectedOutput": "", "isHidden": true},
      {"input": "10 20 30", "expectedOutput": "30 20 10", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 6. Merge Intervals
echo "\n6. Merge Intervals..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Merge Intervals",
    "description": "Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.\n\nInput format: space-separated pairs start end. Output format: merged pairs space-separated.",
    "difficulty": "MEDIUM",
    "sampleInput": "1 3 2 6 8 10 15 18",
    "sampleOutput": "1 6 8 10 15 18",
    "testCases": [
      {"input": "1 3 2 6 8 10 15 18", "expectedOutput": "1 6 8 10 15 18", "isHidden": false},
      {"input": "1 4 4 5", "expectedOutput": "1 5", "isHidden": false},
      {"input": "1 4 0 2 3 5", "expectedOutput": "0 5", "isHidden": true},
      {"input": "5 7 1 3", "expectedOutput": "1 3 5 7", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 7. Longest Palindromic Substring
echo "\n7. Longest Palindromic Substring..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Longest Palindromic Substring",
    "description": "Given a string s, return the longest palindromic substring in s.\n\nA palindrome reads the same forwards and backwards.",
    "difficulty": "MEDIUM",
    "sampleInput": "babad",
    "sampleOutput": "bab",
    "testCases": [
      {"input": "babad", "expectedOutput": "bab", "isHidden": false},
      {"input": "cbbd", "expectedOutput": "bb", "isHidden": false},
      {"input": "a", "expectedOutput": "a", "isHidden": true},
      {"input": "ac", "expectedOutput": "a", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 8. Group Anagrams
echo "\n8. Group Anagrams..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Group Anagrams",
    "description": "Given an array of strings strs, group the anagrams together. You can return the answer in any order.\n\nAn Anagram is a word or phrase formed by rearranging the letters of a different word.\n\nInput: comma-separated words. Output: each group on a new line, words space-separated.",
    "difficulty": "MEDIUM",
    "sampleInput": "eat,tea,tan,ate,nat,bat",
    "sampleOutput": "eat tea ate\ntan nat\nbat",
    "testCases": [
      {"input": "eat,tea,tan,ate,nat,bat", "expectedOutput": "bat\neat tea ate\ntan nat", "isHidden": false},
      {"input": "abc,bca,cab", "expectedOutput": "abc bca cab", "isHidden": false},
      {"input": "a", "expectedOutput": "a", "isHidden": true},
      {"input": "hello,world", "expectedOutput": "hello\nworld", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 9. Product of Array Except Self
echo "\n9. Product of Array Except Self..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Product of Array Except Self",
    "description": "Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].\n\nThe product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.\n\nYou must write an algorithm that runs in O(n) time and without using the division operation.",
    "difficulty": "MEDIUM",
    "sampleInput": "1 2 3 4",
    "sampleOutput": "24 12 8 6",
    "testCases": [
      {"input": "1 2 3 4", "expectedOutput": "24 12 8 6", "isHidden": false},
      {"input": "-1 1 0 -3 3", "expectedOutput": "0 0 9 0 0", "isHidden": false},
      {"input": "2 3", "expectedOutput": "3 2", "isHidden": true},
      {"input": "10 20 30 40", "expectedOutput": "24000 12000 8000 6000", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 10. Trapping Rain Water
echo "\n10. Trapping Rain Water..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Trapping Rain Water",
    "description": "Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it can trap after raining.",
    "difficulty": "HARD",
    "sampleInput": "0 1 0 2 1 0 1 3 2 1 2 1",
    "sampleOutput": "6",
    "testCases": [
      {"input": "0 1 0 2 1 0 1 3 2 1 2 1", "expectedOutput": "6", "isHidden": false},
      {"input": "4 2 0 3 2 5", "expectedOutput": "9", "isHidden": false},
      {"input": "1 0 1", "expectedOutput": "1", "isHidden": true},
      {"input": "5 0 5", "expectedOutput": "5", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 11. Find the Duplicate Number
echo "\n11. Find the Duplicate Number..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Find the Duplicate Number",
    "description": "Given an array of integers nums containing n + 1 integers where each integer is in the range [1, n] inclusive.\n\nThere is only one repeated number in nums, return this repeated number.\n\nYou must solve the problem without modifying the array nums and using only constant extra space.",
    "difficulty": "MEDIUM",
    "sampleInput": "1 3 4 2 2",
    "sampleOutput": "2",
    "testCases": [
      {"input": "1 3 4 2 2", "expectedOutput": "2", "isHidden": false},
      {"input": "3 1 3 4 2", "expectedOutput": "3", "isHidden": false},
      {"input": "2 2 2 2", "expectedOutput": "2", "isHidden": true},
      {"input": "1 1", "expectedOutput": "1", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 12. Maximum Depth of Binary Tree (simplified)
echo "\n12. Maximum Depth of Binary Tree..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Maximum Depth of Binary Tree",
    "description": "Given the root of a binary tree, return its maximum depth.\n\nA binary tree level order traversal is given as space-separated values (null for missing nodes). Compute the maximum depth of the tree.",
    "difficulty": "EASY",
    "sampleInput": "3 9 20 null null 15 7",
    "sampleOutput": "3",
    "testCases": [
      {"input": "3 9 20 null null 15 7", "expectedOutput": "3", "isHidden": false},
      {"input": "1 null 2", "expectedOutput": "2", "isHidden": false},
      {"input": "", "expectedOutput": "0", "isHidden": true},
      {"input": "1 2 3 4 5", "expectedOutput": "3", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 13. Rotate Array
echo "\n13. Rotate Array..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Rotate Array",
    "description": "Given an integer array nums, rotate the array to the right by k steps, where k is non-negative.\n\nInput: first line numbers, second line k value.\nOutput: rotated array.",
    "difficulty": "MEDIUM",
    "sampleInput": "1 2 3 4 5 6 7\n3",
    "sampleOutput": "5 6 7 1 2 3 4",
    "testCases": [
      {"input": "1 2 3 4 5 6 7\n3", "expectedOutput": "5 6 7 1 2 3 4", "isHidden": false},
      {"input": "-1 -100 3 99\n2", "expectedOutput": "3 99 -1 -100", "isHidden": false},
      {"input": "1 2\n0", "expectedOutput": "1 2", "isHidden": true},
      {"input": "1 2 3\n1", "expectedOutput": "3 1 2", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 14. Coin Change
echo "\n14. Coin Change..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Coin Change",
    "description": "You are given an integer array coins representing coins of different denominations and an integer amount representing a total amount of money.\n\nReturn the fewest number of coins that you need to make up that amount. If that amount of money cannot be made up by any combination of the coins, return -1.\n\nInput: first line coins, second line amount.",
    "difficulty": "MEDIUM",
    "sampleInput": "1 2 5\n11",
    "sampleOutput": "3",
    "testCases": [
      {"input": "1 2 5\n11", "expectedOutput": "3", "isHidden": false},
      {"input": "2\n3", "expectedOutput": "-1", "isHidden": false},
      {"input": "1\n0", "expectedOutput": "0", "isHidden": true},
      {"input": "1 3 4 5\n7", "expectedOutput": "2", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 15. First Missing Positive
echo "\n15. First Missing Positive..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "First Missing Positive",
    "description": "Given an unsorted integer array nums, return the smallest missing positive integer.\n\nYou must implement an algorithm that runs in O(n) time and uses O(1) auxiliary space.",
    "difficulty": "HARD",
    "sampleInput": "1 2 0",
    "sampleOutput": "3",
    "testCases": [
      {"input": "1 2 0", "expectedOutput": "3", "isHidden": false},
      {"input": "3 4 -1 1", "expectedOutput": "2", "isHidden": false},
      {"input": "7 8 9 11 12", "expectedOutput": "1", "isHidden": true},
      {"input": "1 2 3", "expectedOutput": "4", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# 16. Longest Consecutive Sequence
echo "\n16. Longest Consecutive Sequence..."
curl -s -X POST "$API/questions" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Longest Consecutive Sequence",
    "description": "Given an unsorted array of integers nums, return the length of the longest consecutive elements sequence.\n\nYou must write an algorithm that runs in O(n) time.",
    "difficulty": "MEDIUM",
    "sampleInput": "100 4 200 1 3 2",
    "sampleOutput": "4",
    "testCases": [
      {"input": "100 4 200 1 3 2", "expectedOutput": "4", "isHidden": false},
      {"input": "0 3 7 2 5 8 4 6 0 1", "expectedOutput": "9", "isHidden": false},
      {"input": "1 2 0 1", "expectedOutput": "3", "isHidden": true},
      {"input": "", "expectedOutput": "0", "isHidden": true}
    ]
  }' | grep -o '"id":[0-9]*' | head -1

# ============================================================
# Get final question list
# ============================================================
echo "\n=== Final Question List ==="
curl -s "$API/questions" | python -c "
import sys, json
d = json.load(sys.stdin)['data']
print(f'Total: {len(d)} questions')
for q in d:
    print(f'  ID {q[\"id\"]:3d}: {q[\"title\"][:40]:40s} ({q[\"difficulty\"]})')
" 2>/dev/null || curl -s "$API/questions" | python3 -c "
import sys, json
d = json.load(sys.stdin)['data']
print(f'Total: {len(d)} questions')
for q in d:
    print(f'  ID {q[\"id\"]:3d}: {q[\"title\"][:40]:40s} ({q[\"difficulty\"]})')
"

echo "\n=== Creating Tests ==="
# Create Test 1: DSA Fundamentals (Easy questions)
echo "\nTest 1: DSA Fundamentals..."
# Use question IDs for Valid Palindrome(2), Reverse String(3), Climbing Stairs(7), Merge Two Sorted Lists(9), Valid Anagram(new)
# We need to find the new question IDs. Let's use known ones: 2,3,7,9 plus find the new anagram ID
# Actually let's just create a test with a range of IDs
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "DSA Fundamentals",
    "description": "Test your skills on fundamental DSA problems including arrays, strings, and linked lists.",
    "duration": 120,
    "isActive": true,
    "questionIds": [1, 2, 3, 7, 9]
  }' | python -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

echo "\nTest 2: Medium Level DSA..."
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Medium Level DSA",
    "description": "Medium difficulty coding challenges including sliding window, two pointers, and dynamic programming.",
    "duration": 90,
    "isActive": true,
    "questionIds": [4, 5, 6, 8]
  }' | python -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

echo "\nTest 3: Advanced Challenges..."
curl -s -X POST "$API/tests" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Advanced Challenges",
    "description": "Advanced problems covering hard DP, arrays, and optimization techniques.",
    "duration": 60,
    "isActive": true,
    "questionIds": [10, 14, 15]
  }' | python -c "import sys,json;d=json.load(sys.stdin);print(f'  Created: ID={d[\"data\"][\"id\"]}, Code={d[\"data\"][\"accessCode\"]}')" 2>/dev/null

echo "\n=== All Tests ==="
curl -s "$API/tests" | python -c "
import sys,json
d=json.load(sys.stdin)['data']
print(f'Total: {len(d)} tests')
for t in d:
    print(f'  ID {t[\"id\"]}: {t[\"title\"]} (Code: {t[\"accessCode\"]}, Duration: {t[\"duration\"]}min)')
" 2>/dev/null

echo "\n=== Done! ==="
