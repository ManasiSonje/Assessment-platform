package com.assessment.coding.config;

import com.assessment.coding.entity.Question;
import com.assessment.coding.entity.Test;
import com.assessment.coding.entity.TestCase;
import com.assessment.coding.entity.User;
import com.assessment.coding.enums.Difficulty;
import com.assessment.coding.enums.TestType;
import com.assessment.coding.repository.QuestionRepository;
import com.assessment.coding.repository.TestCaseRepository;
import com.assessment.coding.repository.TestRepository;
import com.assessment.coding.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
@RequiredArgsConstructor
@Slf4j
public class DataInitializer implements CommandLineRunner {

    private final QuestionRepository questionRepository;
    private final TestCaseRepository testCaseRepository;
    private final TestRepository testRepository;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) {
        if (questionRepository.count() > 0) {
            log.info("Questions already exist (count={}), skipping seed", questionRepository.count());
            return;
        }

        log.info("Seeding database with default data...");

        // Create default admin user
        if (userRepository.findByEmail("admin@assessment.com").isEmpty()) {
            User admin = User.builder()
                    .username("admin")
                    .email("admin@assessment.com")
                    .password(passwordEncoder.encode("admin123"))
                    .fullName("Admin User")
                    .role("ADMIN")
                    .build();
            userRepository.save(admin);
            log.info("Created default admin user (email: admin@assessment.com, password: admin123)");
        }

        log.info("Seeding LeetCode questions...");

        // 1. Two Sum
        Question q1 = saveQuestion("Two Sum", "Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.", Difficulty.EASY, "2 7 11 15 9", "0 1");
        saveTestCase(q1, "2 7 11 15 9", "0 1", false);
        saveTestCase(q1, "3 2 4 6", "1 2", false);
        saveTestCase(q1, "3 3 6", "0 1", true);
        saveTestCase(q1, "1 2 3 4 7", "2 3", true);

        // 2. Valid Palindrome
        Question q2 = saveQuestion("Valid Palindrome", "A phrase is a palindrome if it reads the same forwards and backwards. Given a string s, return true if it is a palindrome.", Difficulty.EASY, "A man, a plan, a canal: Panama", "true");
        saveTestCase(q2, "A man, a plan, a canal: Panama", "true", false);
        saveTestCase(q2, "race a car", "false", false);
        saveTestCase(q2, " ", "true", true);
        saveTestCase(q2, "ab_a", "true", true);

        // 3. Reverse String
        Question q3 = saveQuestion("Reverse String", "Reverse the given string.", Difficulty.EASY, "hello", "olleh");
        saveTestCase(q3, "hello", "olleh", false);
        saveTestCase(q3, "world", "dlrow", false);
        saveTestCase(q3, "a", "a", true);
        saveTestCase(q3, "12345", "54321", true);

        // 4. Longest Substring Without Repeating Characters
        Question q4 = saveQuestion("Longest Substring Without Repeating Characters", "Given a string s, find the length of the longest substring without repeating characters.", Difficulty.MEDIUM, "abcabcbb", "3");
        saveTestCase(q4, "abcabcbb", "3", false);
        saveTestCase(q4, "bbbbb", "1", false);
        saveTestCase(q4, "pwwkew", "3", true);
        saveTestCase(q4, "", "0", true);

        // 5. Container With Most Water
        Question q5 = saveQuestion("Container With Most Water", "Given n non-negative integers a1, a2, ..., an, find two lines that together with the x-axis forms a container that contains the most water.", Difficulty.MEDIUM, "1 8 6 2 5 4 8 3 7", "49");
        saveTestCase(q5, "1 8 6 2 5 4 8 3 7", "49", false);
        saveTestCase(q5, "1 1", "1", false);
        saveTestCase(q5, "4 3 2 1 4", "16", true);
        saveTestCase(q5, "1 2 1", "2", true);

        // 6. Maximum Subarray
        Question q6 = saveQuestion("Maximum Subarray", "Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.", Difficulty.MEDIUM, "-2 1 -3 4 -1 2 1 -5 4", "6");
        saveTestCase(q6, "-2 1 -3 4 -1 2 1 -5 4", "6", false);
        saveTestCase(q6, "1", "1", false);
        saveTestCase(q6, "5 4 -1 7 8", "23", true);
        saveTestCase(q6, "-1 -2 -3", "-1", true);

        // 7. Climbing Stairs
        Question q7 = saveQuestion("Climbing Stairs", "You are climbing a staircase. It takes n steps to reach the top. Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?", Difficulty.EASY, "3", "3");
        saveTestCase(q7, "2", "2", false);
        saveTestCase(q7, "3", "3", false);
        saveTestCase(q7, "5", "8", true);
        saveTestCase(q7, "10", "89", true);

        // 8. 3Sum
        Question q8 = saveQuestion("3Sum", "Given an integer array nums, return all triplets that sum to 0.", Difficulty.MEDIUM, "-1 0 1 2 -1 -4", "-1 -1 2; -1 0 1");
        saveTestCase(q8, "-1 0 1 2 -1 -4", "-1 -1 2; -1 0 1", false);
        saveTestCase(q8, "0 1 1", "", false);
        saveTestCase(q8, "0 0 0", "0 0 0", true);
        saveTestCase(q8, "-2 0 0 2 2", "-2 0 2", true);

        // 9. Merge Two Sorted Lists
        Question q9 = saveQuestion("Merge Two Sorted Lists", "You are given the heads of two sorted linked lists. Merge the two lists into one sorted list.", Difficulty.EASY, "1 2 4\n1 3 4", "1 1 2 3 4 4");
        saveTestCase(q9, "1 2 4\n1 3 4", "1 1 2 3 4 4", false);
        saveTestCase(q9, "\n0", "0", false);
        saveTestCase(q9, "1\n", "1", true);
        saveTestCase(q9, "1 3 5\n2 4 6", "1 2 3 4 5 6", true);

        // 10. Valid Anagram
        Question q10 = saveQuestion("Valid Anagram", "Given two strings s and t, return true if t is an anagram of s.", Difficulty.EASY, "anagram nagaram", "true");
        saveTestCase(q10, "anagram nagaram", "true", false);
        saveTestCase(q10, "rat car", "false", false);
        saveTestCase(q10, "listen silent", "true", true);
        saveTestCase(q10, "hello world", "false", true);

        // 11. Best Time to Buy and Sell Stock
        Question q11 = saveQuestion("Best Time to Buy and Sell Stock", "You are given an array prices. Return the maximum profit you can achieve.", Difficulty.EASY, "7 1 5 3 6 4", "5");
        saveTestCase(q11, "7 1 5 3 6 4", "5", false);
        saveTestCase(q11, "7 6 4 3 1", "0", false);
        saveTestCase(q11, "1 2 3 4 5", "4", true);
        saveTestCase(q11, "3 2 6 5 0 3", "4", true);

        // 12. Valid Parentheses
        Question q12 = saveQuestion("Valid Parentheses", "Given a string s containing just the characters (){}[], determine if the input string is valid.", Difficulty.EASY, "()[]{}", "true");
        saveTestCase(q12, "()", "true", false);
        saveTestCase(q12, "()[]{}", "true", false);
        saveTestCase(q12, "(]", "false", false);
        saveTestCase(q12, "([)]", "false", true);

        // 13. Reverse Linked List
        Question q13 = saveQuestion("Reverse Linked List", "Given the head of a singly linked list, reverse the list.", Difficulty.EASY, "1 2 3 4 5", "5 4 3 2 1");
        saveTestCase(q13, "1 2 3 4 5", "5 4 3 2 1", false);
        saveTestCase(q13, "1 2", "2 1", false);
        saveTestCase(q13, "", "", true);
        saveTestCase(q13, "10 20 30", "30 20 10", true);

        // 14. Merge Intervals
        Question q14 = saveQuestion("Merge Intervals", "Given an array of intervals, merge all overlapping intervals.", Difficulty.MEDIUM, "1 3 2 6 8 10 15 18", "1 6 8 10 15 18");
        saveTestCase(q14, "1 3 2 6 8 10 15 18", "1 6 8 10 15 18", false);
        saveTestCase(q14, "1 4 4 5", "1 5", false);
        saveTestCase(q14, "1 4 0 2 3 5", "0 5", true);
        saveTestCase(q14, "5 7 1 3", "1 3 5 7", true);

        // 15. Longest Palindromic Substring
        Question q15 = saveQuestion("Longest Palindromic Substring", "Return the longest palindromic substring in s.", Difficulty.MEDIUM, "babad", "bab");
        saveTestCase(q15, "babad", "bab", false);
        saveTestCase(q15, "cbbd", "bb", false);
        saveTestCase(q15, "a", "a", true);
        saveTestCase(q15, "ac", "a", true);

        // 16. Group Anagrams
        Question q16 = saveQuestion("Group Anagrams", "Given an array of strings, group the anagrams together.", Difficulty.MEDIUM, "eat,tea,tan,ate,nat,bat", "bat\neat tea ate\ntan nat");
        saveTestCase(q16, "eat,tea,tan,ate,nat,bat", "bat", false);
        saveTestCase(q16, "abc,bca,cab", "abc bca cab", false);
        saveTestCase(q16, "a", "a", true);
        saveTestCase(q16, "hello,world", "hello\nworld", true);

        // 17. Product of Array Except Self
        Question q17 = saveQuestion("Product of Array Except Self", "Return an array answer such that answer[i] = product of all elements except nums[i].", Difficulty.MEDIUM, "1 2 3 4", "24 12 8 6");
        saveTestCase(q17, "1 2 3 4", "24 12 8 6", false);
        saveTestCase(q17, "-1 1 0 -3 3", "0 0 9 0 0", false);
        saveTestCase(q17, "2 3", "3 2", true);
        saveTestCase(q17, "10 20 30 40", "24000 12000 8000 6000", true);

        // 18. Trapping Rain Water
        Question q18 = saveQuestion("Trapping Rain Water", "Compute how much water it can trap after raining.", Difficulty.HARD, "0 1 0 2 1 0 1 3 2 1 2 1", "6");
        saveTestCase(q18, "0 1 0 2 1 0 1 3 2 1 2 1", "6", false);
        saveTestCase(q18, "4 2 0 3 2 5", "9", false);
        saveTestCase(q18, "1 0 1", "1", true);
        saveTestCase(q18, "5 0 5", "5", true);

        // 19. Binary Search
        Question q19 = saveQuestion("Binary Search", "Given a sorted array, search for a target value. Return its index or -1.", Difficulty.EASY, "1 3 5 7 9 5", "2");
        saveTestCase(q19, "1 3 5 7 9 5", "2", false);
        saveTestCase(q19, "1 3 5 7 9 2", "-1", false);
        saveTestCase(q19, "1 2 3 4 5 1", "0", true);
        saveTestCase(q19, "10 20 30 40 50 40", "3", true);

        // 20. House Robber
        Question q20 = saveQuestion("House Robber", "Return max amount you can rob without alerting police (adjacent houses).", Difficulty.MEDIUM, "2 7 9 3 1", "12");
        saveTestCase(q20, "2 7 9 3 1", "12", false);
        saveTestCase(q20, "1 2 3 1", "4", false);
        saveTestCase(q20, "2 1 1 2", "4", true);
        saveTestCase(q20, "5 3 4 11 2", "16", true);

        // 21. Linked List Cycle
        Question q21 = saveQuestion("Linked List Cycle", "Determine if a linked list has a cycle.", Difficulty.EASY, "3 2 0 -4 1", "true");
        saveTestCase(q21, "3 2 0 -4 1", "true", false);
        saveTestCase(q21, "1 2 0", "true", false);
        saveTestCase(q21, "1 -1", "false", true);
        saveTestCase(q21, "1 2 3 4 -1", "false", true);

        // 22. Number of Islands
        Question q22 = saveQuestion("Number of Islands", "Given a 2D grid of 1s (land) and 0s (water), return the number of islands.", Difficulty.MEDIUM, "11000;11000;00100;00011", "3");
        saveTestCase(q22, "11000;11000;00100;00011", "3", false);
        saveTestCase(q22, "11111;10001;10001;11111", "1", false);
        saveTestCase(q22, "101;010;101", "5", true);
        saveTestCase(q22, "1", "1", true);

        // 23. Word Break
        Question q23 = saveQuestion("Word Break", "Given a string and a dictionary, return true if the string can be segmented.", Difficulty.MEDIUM, "leetcode\nleet,code", "true");
        saveTestCase(q23, "leetcode\nleet,code", "true", false);
        saveTestCase(q23, "applepenapple\napple,pen", "true", false);
        saveTestCase(q23, "catsandog\ncats,dog,sand,and,cat", "false", true);
        saveTestCase(q23, "aaaaaaa\naaaa,aaa", "true", true);

        // 24. Coin Change
        Question q24 = saveQuestion("Coin Change", "Return the fewest number of coins needed to make up that amount.", Difficulty.MEDIUM, "1 2 5\n11", "3");
        saveTestCase(q24, "1 2 5\n11", "3", false);
        saveTestCase(q24, "2\n3", "-1", false);
        saveTestCase(q24, "1\n0", "0", true);
        saveTestCase(q24, "1 3 4 5\n7", "2", true);

        // 25. First Missing Positive
        Question q25 = saveQuestion("First Missing Positive", "Return the smallest missing positive integer.", Difficulty.HARD, "1 2 0", "3");
        saveTestCase(q25, "1 2 0", "3", false);
        saveTestCase(q25, "3 4 -1 1", "2", false);
        saveTestCase(q25, "7 8 9 11 12", "1", true);
        saveTestCase(q25, "1 2 3", "4", true);

        // 26. Longest Consecutive Sequence
        Question q26 = saveQuestion("Longest Consecutive Sequence", "Return the length of the longest consecutive elements sequence.", Difficulty.MEDIUM, "100 4 200 1 3 2", "4");
        saveTestCase(q26, "100 4 200 1 3 2", "4", false);
        saveTestCase(q26, "0 3 7 2 5 8 4 6 0 1", "9", false);
        saveTestCase(q26, "1 2 0 1", "3", true);
        saveTestCase(q26, "", "0", true);

        // 27. Jump Game
        Question q27 = saveQuestion("Jump Game", "Return true if you can reach the last index.", Difficulty.MEDIUM, "2 3 1 1 4", "true");
        saveTestCase(q27, "2 3 1 1 4", "true", false);
        saveTestCase(q27, "3 2 1 0 4", "false", false);
        saveTestCase(q27, "0", "true", true);
        saveTestCase(q27, "2 5 0 0", "true", true);

        // 28. Decode Ways
        Question q28 = saveQuestion("Decode Ways", "Return the number of ways to decode a digit string into letters.", Difficulty.MEDIUM, "226", "3");
        saveTestCase(q28, "226", "3", false);
        saveTestCase(q28, "12", "2", false);
        saveTestCase(q28, "06", "0", true);
        saveTestCase(q28, "111", "3", true);

        // 29. Word Search
        Question q29 = saveQuestion("Word Search", "Given a grid and a word, return true if word exists in the grid.", Difficulty.MEDIUM, "ABCCED\nABCE;SFCS;ADEE", "true");
        saveTestCase(q29, "ABCCED\nABCE;SFCS;ADEE", "true", false);
        saveTestCase(q29, "SEE\nABCE;SFCS;ADEE", "true", false);
        saveTestCase(q29, "XYZ\nABC;DEF;GHI", "false", true);
        saveTestCase(q29, "A\nA", "true", true);

        // 30. Subsets
        Question q30 = saveQuestion("Subsets", "Return all possible subsets (power set).", Difficulty.MEDIUM, "1 2 3", "1 2 3");
        saveTestCase(q30, "1 2 3", "1 2 3", false);
        saveTestCase(q30, "0", "0", false);
        saveTestCase(q30, "1 2", "1 2", true);
        saveTestCase(q30, "", "", true);

        // 31. Combination Sum
        Question q31 = saveQuestion("Combination Sum", "Return all unique combinations where candidates sum to target.", Difficulty.MEDIUM, "2 3 6 7\n7", "2 2 3");
        saveTestCase(q31, "2 3 6 7\n7", "2 2 3", false);
        saveTestCase(q31, "2 3 5\n8", "2 2 2 2", false);
        saveTestCase(q31, "2\n1", "", true);
        saveTestCase(q31, "1\n2", "1 1", true);

        // 32. Top K Frequent Elements
        Question q32 = saveQuestion("Top K Frequent Elements", "Return the k most frequent elements.", Difficulty.MEDIUM, "1 1 1 2 2 3\n2", "1 2");
        saveTestCase(q32, "1 1 1 2 2 3\n2", "1 2", false);
        saveTestCase(q32, "1\n1", "1", false);
        saveTestCase(q32, "1 2 2 3 3 3\n2", "2 3", true);
        saveTestCase(q32, "4 4 4 4\n1", "4", true);

        // 33. Course Schedule
        Question q33 = saveQuestion("Course Schedule", "Return true if you can finish all courses given prerequisites.", Difficulty.MEDIUM, "2\n1,0", "true");
        saveTestCase(q33, "2\n1,0", "true", false);
        saveTestCase(q33, "2\n1,0;0,1", "false", false);
        saveTestCase(q33, "4\n1,0;2,1;3,2", "true", true);
        saveTestCase(q33, "3\n1,0;2,1", "true", true);

        // 34. Minimum Window Substring
        Question q34 = saveQuestion("Minimum Window Substring", "Return minimum window substring containing all characters of t.", Difficulty.HARD, "ADOBECODEBANC\nABC", "BANC");
        saveTestCase(q34, "ADOBECODEBANC\nABC", "BANC", false);
        saveTestCase(q34, "a\na", "a", false);
        saveTestCase(q34, "a\naa", "", true);
        saveTestCase(q34, "aabdec\nabc", "abdec", true);

        // 35. Median of Two Sorted Arrays
        Question q35 = saveQuestion("Median of Two Sorted Arrays", "Return the median of two sorted arrays.", Difficulty.HARD, "1 3\n2", "2.0");
        saveTestCase(q35, "1 3\n2", "2.0", false);
        saveTestCase(q35, "1 2\n3 4", "2.5", false);
        saveTestCase(q35, "0 0\n0 0", "0.0", true);
        saveTestCase(q35, "1\n2 3 4", "2.5", true);

        // 36. Sliding Window Maximum
        Question q36 = saveQuestion("Sliding Window Maximum", "Return max sliding window of size k.", Difficulty.HARD, "1 3 -1 -3 5 3 6 7\n3", "3 3 5 5 6 7");
        saveTestCase(q36, "1 3 -1 -3 5 3 6 7\n3", "3 3 5 5 6 7", false);
        saveTestCase(q36, "1\n1", "1", false);
        saveTestCase(q36, "1 -1\n1", "1 -1", true);
        saveTestCase(q36, "9 11 8 5 7 10\n2", "11 11 8 7 10", true);

        // 37. Edit Distance
        Question q37 = saveQuestion("Edit Distance", "Return minimum operations to convert word1 to word2.", Difficulty.HARD, "horse\nros", "3");
        saveTestCase(q37, "horse\nros", "3", false);
        saveTestCase(q37, "intention\nexecution", "5", false);
        saveTestCase(q37, "abc\nabc", "0", true);
        saveTestCase(q37, "a\nb", "1", true);

        // 38. Find the Duplicate Number
        Question q38 = saveQuestion("Find the Duplicate Number", "Return the repeated number in an array of n+1 integers.", Difficulty.MEDIUM, "1 3 4 2 2", "2");
        saveTestCase(q38, "1 3 4 2 2", "2", false);
        saveTestCase(q38, "3 1 3 4 2", "3", false);
        saveTestCase(q38, "2 2 2 2", "2", true);
        saveTestCase(q38, "1 1", "1", true);

        // 39. Maximum Depth of Binary Tree
        Question q39 = saveQuestion("Maximum Depth of Binary Tree", "Return maximum depth of a binary tree.", Difficulty.EASY, "3 9 20 null null 15 7", "3");
        saveTestCase(q39, "3 9 20 null null 15 7", "3", false);
        saveTestCase(q39, "1 null 2", "2", false);
        saveTestCase(q39, "", "0", true);
        saveTestCase(q39, "1 2 3 4 5", "3", true);

        // 40. Rotate Array
        Question q40 = saveQuestion("Rotate Array", "Rotate the array to the right by k steps.", Difficulty.MEDIUM, "1 2 3 4 5 6 7\n3", "5 6 7 1 2 3 4");
        saveTestCase(q40, "1 2 3 4 5 6 7\n3", "5 6 7 1 2 3 4", false);
        saveTestCase(q40, "-1 -100 3 99\n2", "3 99 -1 -100", false);
        saveTestCase(q40, "1 2\n0", "1 2", true);
        saveTestCase(q40, "1 2 3\n1", "3 1 2", true);

        // 41. Permutations
        Question q41 = saveQuestion("Permutations", "Return all possible permutations of an array.", Difficulty.MEDIUM, "1 2 3", "1 2 3");
        saveTestCase(q41, "1 2 3", "1 2 3", false);
        saveTestCase(q41, "0 1", "0 1", false);
        saveTestCase(q41, "1", "1", true);
        saveTestCase(q41, "1 2", "1 2", true);

        // 42. Validate Binary Search Tree
        Question q42 = saveQuestion("Validate Binary Search Tree", "Determine if a binary tree is a valid BST.", Difficulty.MEDIUM, "2 1 3", "true");
        saveTestCase(q42, "2 1 3", "true", false);
        saveTestCase(q42, "5 1 4 null null 3 6", "false", false);
        saveTestCase(q42, "", "true", true);
        saveTestCase(q42, "10 5 15 null null 6 20", "false", true);

        // 43. Implement Trie (Prefix Tree)
        Question q43 = saveQuestion("Implement Trie (Prefix Tree)", "Implement a trie with insert, search, and startsWith.", Difficulty.MEDIUM, "insert:apple,search:apple,search:app,prefix:app", "1 0 1");
        saveTestCase(q43, "insert:apple,search:apple,search:app,prefix:app", "1 0 1", false);
        saveTestCase(q43, "insert:app,search:app", "1", false);
        saveTestCase(q43, "search:hello", "0", true);
        saveTestCase(q43, "insert:test,search:test,search:testing,prefix:te", "1 0 1", true);

        // 44. Add Two Numbers
        Question q44 = saveQuestion("Add Two Numbers", "You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order. Add the two numbers and return the sum as a linked list.", Difficulty.MEDIUM, "2 4 3\n5 6 4", "7 0 8");
        saveTestCase(q44, "2 4 3\n5 6 4", "7 0 8", false);
        saveTestCase(q44, "0\n0", "0", false);
        saveTestCase(q44, "9 9 9 9 9 9 9\n9 9 9 9", "8 9 9 9 0 0 0 1", true);

        // 45. Longest Common Prefix
        Question q45 = saveQuestion("Longest Common Prefix", "Write a function to find the longest common prefix string amongst an array of strings.", Difficulty.EASY, "flower,flow,flight", "fl");
        saveTestCase(q45, "flower,flow,flight", "fl", false);
        saveTestCase(q45, "dog,racecar,car", "", false);
        saveTestCase(q45, "apple,apricot,april", "ap", true);

        // 46. Roman to Integer
        Question q46 = saveQuestion("Roman to Integer", "Given a roman numeral, convert it to an integer.", Difficulty.EASY, "III", "3");
        saveTestCase(q46, "III", "3", false);
        saveTestCase(q46, "LVIII", "58", false);
        saveTestCase(q46, "MCMXCIV", "1994", true);

        // 47. Merge Sorted Array
        Question q47 = saveQuestion("Merge Sorted Array", "Given two sorted arrays, merge them into one sorted array.", Difficulty.EASY, "1 2 3 0 0 0\n2 5 6", "1 2 2 3 5 6");
        saveTestCase(q47, "1 2 3 0 0 0\n2 5 6", "1 2 2 3 5 6", false);
        saveTestCase(q47, "1\n", "1", false);
        saveTestCase(q47, "0\n1", "1", true);

        // 48. Single Number
        Question q48 = saveQuestion("Single Number", "Given an array, every element appears twice except one. Find that single one.", Difficulty.EASY, "2 2 1", "1");
        saveTestCase(q48, "2 2 1", "1", false);
        saveTestCase(q48, "4 1 2 1 2", "4", false);
        saveTestCase(q48, "5 5 3 3 7 7 9", "9", true);

        // 49. Majority Element
        Question q49 = saveQuestion("Majority Element", "Return the majority element that appears more than ⌊n/2⌋ times.", Difficulty.EASY, "3 2 3", "3");
        saveTestCase(q49, "3 2 3", "3", false);
        saveTestCase(q49, "2 2 1 1 1 2 2", "2", false);
        saveTestCase(q49, "6 5 5", "5", true);

        // 50. Happy Number
        Question q50 = saveQuestion("Happy Number", "Determine if a number is happy (repeated sum of squares of digits ends in 1).", Difficulty.EASY, "19", "true");
        saveTestCase(q50, "19", "true", false);
        saveTestCase(q50, "2", "false", false);
        saveTestCase(q50, "7", "true", true);

        // 51. Remove Duplicates from Sorted Array
        Question q51 = saveQuestion("Remove Duplicates from Sorted Array", "Remove duplicates from sorted array in-place and return the count of unique elements.", Difficulty.EASY, "1 1 2", "2\n1 2");
        saveTestCase(q51, "1 1 2", "2\n1 2", false);
        saveTestCase(q51, "0 0 1 1 1 2 2 3 3 4", "5\n0 1 2 3 4", false);
        saveTestCase(q51, "", "0", true);

        // 52. Plus One
        Question q52 = saveQuestion("Plus One", "Increment a large integer represented as an array by one.", Difficulty.EASY, "1 2 3", "1 2 4");
        saveTestCase(q52, "1 2 3", "1 2 4", false);
        saveTestCase(q52, "9", "1 0", false);
        saveTestCase(q52, "9 9 9", "1 0 0 0", true);

        // 53. Pascal Triangle
        Question q53 = saveQuestion("Pascal Triangle", "Return the first numRows of Pascal triangle.", Difficulty.EASY, "5", "1\n1 1\n1 2 1\n1 3 3 1\n1 4 6 4 1");
        saveTestCase(q53, "5", "1\n1 1\n1 2 1\n1 3 3 1\n1 4 6 4 1", false);
        saveTestCase(q53, "1", "1", false);
        saveTestCase(q53, "3", "1\n1 1\n1 2 1", true);

        // 54. Valid Sudoku
        Question q54 = saveQuestion("Valid Sudoku", "Determine if a 9x9 Sudoku board is valid.", Difficulty.MEDIUM, "53..7....;6..195...;.98....6.;8...6...3;4..8.3..1;7...2...6;.6....28.;...419..5;....8..79", "true");
        saveTestCase(q54, "53..7....;6..195...;.98....6.;8...6...3;4..8.3..1;7...2...6;.6....28.;...419..5;....8..79", "true", false);
        saveTestCase(q54, "83..7....;6..195...;.98....6.;8...6...3;4..8.3..1;7...2...6;.6....28.;...419..5;....8..79", "false", false);
        saveTestCase(q54, "53..7....;6..195...;.98....6.;8...6...3;4..8.3..1;7...2...6;.6....28.;...419..5;....8..79", "true", true);

        // 55. Search in Rotated Sorted Array
        Question q55 = saveQuestion("Search in Rotated Sorted Array", "Search for a target in a rotated sorted array. Return index or -1.", Difficulty.MEDIUM, "4 5 6 7 0 1 2\n0", "4");
        saveTestCase(q55, "4 5 6 7 0 1 2\n0", "4", false);
        saveTestCase(q55, "4 5 6 7 0 1 2\n3", "-1", false);
        saveTestCase(q55, "3 1\n1", "1", true);

        // 56. Generate Parentheses
        Question q56 = saveQuestion("Generate Parentheses", "Generate all combinations of well-formed parentheses for n pairs.", Difficulty.MEDIUM, "3", "((())) (()()) (())() ()(()) ()()()");
        saveTestCase(q56, "3", "((())) (()()) (())() ()(()) ()()()", false);
        saveTestCase(q56, "1", "()", false);
        saveTestCase(q56, "2", "(()) ()()", true);

        // 57. Unique Paths
        Question q57 = saveQuestion("Unique Paths", "A robot on an m x n grid. Count unique paths to bottom-right corner (only down/right moves).", Difficulty.MEDIUM, "3 7", "28");
        saveTestCase(q57, "3 7", "28", false);
        saveTestCase(q57, "3 2", "3", false);
        saveTestCase(q57, "3 3", "6", true);

        // 58. Sort Colors
        Question q58 = saveQuestion("Sort Colors", "Sort an array of 0s, 1s, and 2s in-place (Dutch national flag problem).", Difficulty.MEDIUM, "2 0 2 1 1 0", "0 0 1 1 2 2");
        saveTestCase(q58, "2 0 2 1 1 0", "0 0 1 1 2 2", false);
        saveTestCase(q58, "2 0 1", "0 1 2", false);
        saveTestCase(q58, "1 2 0 2 1 0 1", "0 0 1 1 1 2 2", true);

        // 59. Binary Tree Level Order Traversal
        Question q59 = saveQuestion("Binary Tree Level Order Traversal", "Return level order traversal of a binary tree (each level on a separate line).", Difficulty.MEDIUM, "3 9 20 null null 15 7", "3\n9 20\n15 7");
        saveTestCase(q59, "3 9 20 null null 15 7", "3\n9 20\n15 7", false);
        saveTestCase(q59, "1", "1", false);
        saveTestCase(q59, "1 2 3 4 5", "1\n2 3\n4 5", true);

        // 60. Symmetric Tree
        Question q60 = saveQuestion("Symmetric Tree", "Check whether a binary tree is a mirror of itself (symmetric).", Difficulty.EASY, "1 2 2 3 4 4 3", "true");
        saveTestCase(q60, "1 2 2 3 4 4 3", "true", false);
        saveTestCase(q60, "1 2 2 null 3 null 3", "false", false);
        saveTestCase(q60, "1", "true", true);

        // 61. Path Sum
        Question q61 = saveQuestion("Path Sum", "Return true if the tree has a root-to-leaf path summing to target.", Difficulty.EASY, "5 4 8 11 null 13 4 7 2 null null null 1\n22", "true");
        saveTestCase(q61, "5 4 8 11 null 13 4 7 2 null null null 1\n22", "true", false);
        saveTestCase(q61, "1 2 3\n5", "false", false);
        saveTestCase(q61, "1\n1", "true", true);

        // 62. Best Time to Buy and Sell Stock II
        Question q62 = saveQuestion("Best Time to Buy and Sell Stock II", "You may buy/sell multiple times to maximize profit (at most one share at a time).", Difficulty.MEDIUM, "7 1 5 3 6 4", "7");
        saveTestCase(q62, "7 1 5 3 6 4", "7", false);
        saveTestCase(q62, "1 2 3 4 5", "4", false);
        saveTestCase(q62, "7 6 4 3 1", "0", true);

        // 63. LRU Cache
        Question q63 = saveQuestion("LRU Cache", "Design a Least Recently Used (LRU) cache with get and put operations.", Difficulty.MEDIUM, "put:1 1,put:2 2,get:1,put:3 3,get:2,put:4 4,get:1,get:3,get:4", "1 -1 -1 3 4");
        saveTestCase(q63, "put:1 1,put:2 2,get:1,put:3 3,get:2,put:4 4,get:1,get:3,get:4", "1 -1 -1 3 4", false);
        saveTestCase(q63, "get:1,put:1 1,get:1", "-1 1", false);
        saveTestCase(q63, "put:1 1,put:2 2,get:1,get:2", "1 2", true);

        log.info("Seeded {} questions successfully!", questionRepository.count());

        // Create Tests
        User admin = userRepository.findByEmail("admin@assessment.com").orElse(null);
        Long adminId = admin != null ? admin.getId() : null;

        List<Question> allQuestions = questionRepository.findAll();
        long qCount = allQuestions.size();

        if (qCount >= 8) {
            Test test1 = Test.builder()
                    .title("Easy Warmup")
                    .description("A collection of easy problems to warm up your coding skills.")
                    .duration(60)
                    .testType(TestType.CODING)
                    .isActive(true)
                    .createdBy(adminId)
                    .build();
            test1.addQuestion(allQuestions.get(0));
            test1.addQuestion(allQuestions.get(1));
            test1.addQuestion(allQuestions.get(2));
            test1.addQuestion(allQuestions.get(10));
            test1.addQuestion(allQuestions.get(18));
            testRepository.save(test1);
        }

        if (qCount >= 14) {
            Test test2 = Test.builder()
                    .title("Array Mastery")
                    .description("Test your array manipulation skills with two pointers, sliding window, and sorting.")
                    .duration(90)
                    .testType(TestType.CODING)
                    .isActive(true)
                    .createdBy(adminId)
                    .build();
            test2.addQuestion(allQuestions.get(0));
            test2.addQuestion(allQuestions.get(4));
            test2.addQuestion(allQuestions.get(5));
            test2.addQuestion(allQuestions.get(13));
            test2.addQuestion(allQuestions.get(16));
            testRepository.save(test2);
        }

        if (qCount >= 5) {
            Test test3 = Test.builder()
                    .title("Tree Week")
                    .description("Binary tree and BST problems including traversals, validation, and path finding.")
                    .duration(90)
                    .testType(TestType.CODING)
                    .isActive(true)
                    .createdBy(adminId)
                    .build();
            test3.addQuestion(allQuestions.get(38));
            test3.addQuestion(allQuestions.get(41));
            test3.addQuestion(allQuestions.get(59));
            test3.addQuestion(allQuestions.get(60));
            test3.addQuestion(allQuestions.get(61));
            testRepository.save(test3);
        }

        if (qCount >= 20) {
            Test test4 = Test.builder()
                    .title("Dynamic Programming")
                    .description("Classic DP problems including climbing stairs, coin change, and unique paths.")
                    .duration(120)
                    .testType(TestType.CODING)
                    .isActive(true)
                    .createdBy(adminId)
                    .build();
            test4.addQuestion(allQuestions.get(6));
            test4.addQuestion(allQuestions.get(9));
            test4.addQuestion(allQuestions.get(13));
            test4.addQuestion(allQuestions.get(19));
            test4.addQuestion(allQuestions.get(23));
            test4.addQuestion(allQuestions.get(27));
            testRepository.save(test4);
        }

        if (qCount >= 25) {
            Test test5 = Test.builder()
                    .title("Medium Mix")
                    .description("A curated mix of medium problems covering graphs, strings, and backtracking.")
                    .duration(120)
                    .testType(TestType.CODING)
                    .isActive(true)
                    .createdBy(adminId)
                    .build();
            test5.addQuestion(allQuestions.get(3));
            test5.addQuestion(allQuestions.get(7));
            test5.addQuestion(allQuestions.get(11));
            test5.addQuestion(allQuestions.get(21));
            test5.addQuestion(allQuestions.get(22));
            test5.addQuestion(allQuestions.get(30));
            testRepository.save(test5);
        }

        if (qCount >= 35) {
            Test test6 = Test.builder()
                    .title("Hard Challenge")
                    .description("Hard difficulty problems for advanced coders.")
                    .duration(180)
                    .testType(TestType.CODING)
                    .isActive(true)
                    .createdBy(adminId)
                    .build();
            test6.addQuestion(allQuestions.get(17));
            test6.addQuestion(allQuestions.get(24));
            test6.addQuestion(allQuestions.get(33));
            test6.addQuestion(allQuestions.get(34));
            test6.addQuestion(allQuestions.get(35));
            test6.addQuestion(allQuestions.get(36));
            testRepository.save(test6);
        }

        log.info("Created {} tests successfully!", testRepository.count());
    }

    private Question saveQuestion(String title, String description, Difficulty difficulty, String sampleInput, String sampleOutput) {
        Question q = Question.builder()
                .title(title)
                .description(description)
                .difficulty(difficulty)
                .sampleInput(sampleInput)
                .sampleOutput(sampleOutput)
                .build();
        return questionRepository.save(q);
    }

    private void saveTestCase(Question question, String input, String expectedOutput, boolean isHidden) {
        TestCase tc = TestCase.builder()
                .question(question)
                .input(input)
                .expectedOutput(expectedOutput)
                .isHidden(isHidden)
                .build();
        testCaseRepository.save(tc);
    }
}
