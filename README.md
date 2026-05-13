# Assessment Platform 🎓

A **scalable online assessment platform** built with Spring Boot, featuring a collaborative coding environment with real-time code execution, automated evaluation, and role-based dashboards for administrators and students.

## 🚀 Live Demo

**Deployed URL:** https://assessment-platform-production-fe53.up.railway.app

## ✨ Features

### 👨‍🎓 Student Portal
- **Registration & Login** — Secure authentication with JWT tokens
- **Access Code Tests** — Enter test ID and access code to start assessments
- **Monaco Code Editor** — Professional code editor with syntax highlighting for Python, Java, and C++
- **Real-time Code Execution** — Submit code and get instant test case results via Judge0 API
- **Auto-save** — Code auto-saves every 5 seconds when switching between questions
- **Timer-based Tests** — Countdown timer with auto-submit on expiry
- **Question Navigation** — Previous/Next buttons for multi-question tests

### 👨‍💼 Admin Dashboard
- **Dashboard Overview** — Real-time stats: total tests, sessions, submissions, questions
- **Student Score Tracking** — View individual student scores and performance
- **Question Management** — Create coding questions with test cases
- **Test Creation** — Build tests by selecting questions and generating unique access codes
- **Submission Monitoring** — View all student submissions with detailed results

### 🔧 Technical Highlights
- **JWT Authentication** — Stateless auth with BCrypt password hashing
- **Role-based Access Control** — Admin/Student roles with protected endpoints
- **Auto Evaluation** — Each test case runs independently against student code
- **CORS Enabled** — Secure cross-origin request handling

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **Java 17** | Core language |
| **Spring Boot 3.2.0** | Backend framework |
| **Spring Security + JWT** | Authentication & authorization |
| **Spring Data JPA + Hibernate** | ORM & database access |
| **MySQL** | Database |
| **Monaco Editor** | Code editor (same as VS Code) |
| **Judge0 API** | Remote code execution sandbox |
| **HTML / CSS / JavaScript** | Frontend |
| **Maven** | Build & dependency management |
| **Railway** | Cloud deployment |

## 📋 Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Frontend (index.html)                    │
│  Monaco Editor │ Auth UI │ Admin Dashboard │ Student Portal  │
└──────────────────────────┬──────────────────────────────────┘
                           │ REST API (JSON)
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                  Spring Boot Backend :8083                   │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────────┐  │
│  │ Auth     │  │ Test     │  │ Question │  │ Submission │  │
│  │ Controller│  │ Controller│  │Controller │  │ Controller │  │
│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬───────┘  │
│       │              │             │              │          │
│  ┌────▼──────────────▼─────────────▼──────────────▼───────┐  │
│  │                    Service Layer                        │  │
│  │  AuthService │ TestService │ QuestionService │          │  │
│  │  SubmissionService │ CodeExecutionService                │  │
│  └────┬──────────────┬─────────────┬──────────────────────┘  │
│       │              │             │                         │
│  ┌────▼──────────────▼─────────────▼──────────────────────┐  │
│  │                    Repository Layer                     │  │
│  │  JPA Repositories (User, Test, Question, Submission)    │  │
│  └──────────────────────────┬────────────────────────────┘  │
│                             │                                │
└─────────────────────────────┼────────────────────────────────┘
                              │
                    ┌─────────▼─────────┐
                    │     MySQL DB      │
                    │  assessment_db    │
                    └───────────────────┘

   Code Execution Flow:
   Student Code → Judge0 API → Sandbox Execution → Result Evaluation → Score
```

## 🚦 Getting Started

### Prerequisites
- Java 17+
- MySQL 8+
- Maven 3.8+

### Local Development

```bash
# 1. Clone the repository
git clone https://github.com/ManasiSonje/Assessment-platform.git
cd Assessment-platform

# 2. Create MySQL database
mysql -u root -p -e "CREATE DATABASE assessment_db;"

# 3. Configure database credentials in application.yml
#    src/main/resources/application.yml

# 4. Build and run
mvn spring-boot:run

# 5. Open in browser
http://localhost:8083
```

## 📋 Questions Available

**46 DSA Questions** from LeetCode covering Easy to Hard difficulty:

### Easy (15)
Two Sum, Valid Palindrome, Reverse String, Climbing Stairs, Merge Two Sorted Lists, Valid Anagram, Best Time to Buy and Sell Stock, Valid Parentheses, Reverse Linked List, Maximum Depth of Binary Tree, Binary Search, Linked List Cycle, subarray, Sum of two numbers

### Medium (25)
Longest Substring Without Repeating Characters, Container With Most Water, Maximum Subarray, 3Sum, Merge Intervals, Longest Palindromic Substring, Group Anagrams, Product of Array Except Self, Find the Duplicate Number, Rotate Array, Coin Change, Longest Consecutive Sequence, House Robber, Number of Islands, Word Break, Course Schedule, Top K Frequent Elements, Validate Binary Search Tree, Permutations, Jump Game, Combination Sum, Subsets, Decode Ways, Word Search, Implement Trie

### Hard (6)
Trapping Rain Water, First Missing Positive, Minimum Window Substring, Median of Two Sorted Arrays, Sliding Window Maximum, Edit Distance, Palindrome Pairs

## 📝 Tests Available (12 tests)

| Test | Duration | Code | Focus |
|------|----------|------|-------|
| DSA Fundamentals | 120 min | `B1B21D4F` | Arrays, Strings, Linked Lists |
| Medium Level DSA | 90 min | `E3133477` | Sliding Window, Two Pointers, DP |
| Advanced Challenges | 60 min | `78815D66` | Hard DP, Arrays |
| Graph & Tree Algorithms | 90 min | `9FFD5137` | Graphs, Trees, Traversals |
| Dynamic Programming Series | 120 min | `8CE10240` | DP from Easy to Hard |
| String & Array Mastery | 90 min | `852C5ED5` | Strings, Arrays, Hash Maps |
| Hard Challenge Marathon | 180 min | `4C98C7B8` | Hard problems collection |
| Coding Interview Prep | 60 min | `1ECE2996` | Most commonly asked questions |

## 🔌 API Endpoints

### Authentication
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/v1/auth/register` | Register new user |
| POST | `/api/v1/auth/login` | Login and get JWT token |

### Questions
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/questions` | Get all questions |
| GET | `/api/v1/questions/{id}` | Get question by ID |
| POST | `/api/v1/questions` | Create question |

### Tests
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/tests` | Get all tests |
| POST | `/api/v1/tests` | Create test |
| POST | `/api/v1/tests/start` | Start test with access code |

### Submissions
| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/v1/submissions` | Submit code for evaluation |
| GET | `/api/v1/submissions/{id}` | Get submission details |

### Admin
| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/v1/admin/dashboard` | Dashboard stats & scores |
| GET | `/api/v1/admin/tests` | All tests with results |

## 📦 Database Schema

```
users          → id, username, email, password, role, full_name
tests          → id, title, description, access_code, duration
test_sessions  → id, test_id, user_id, student_name, score, status
questions      → id, title, description, difficulty
submissions    → id, user_id, question_id, test_session_id, score, status
test_cases     → id, question_id, input, expected_output
submission_results → id, submission_id, test_case_index, actual_output, is_passed
```

## 🌐 Deployment

The project is configured for **Railway** deployment with zero config:

1. Push code to GitHub
2. Connect repository on [Railway](https://railway.app)
3. Add MySQL database service
4. Set environment variables (`JDBC_DATABASE_URL`, etc.)
5. Railway auto-builds and deploys

## 🤝 Contributing

Contributions are welcome! Please fork the repo and submit a pull request.

## 📄 License

MIT License — see [LICENSE](LICENSE) for details.
