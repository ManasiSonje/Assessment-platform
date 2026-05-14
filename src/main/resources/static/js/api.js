// API Configuration
const API_BASE = 'https://assessment-platform-production-fe53.up.railway.app/api/v1';

function getAuthHeaders() {
    const token = localStorage.getItem('authToken');
    return {
        'Content-Type': 'application/json',
        ...(token ? { 'Authorization': `Bearer ${token}` } : {})
    };
}

// Auth APIs
async function register(data) {
    const response = await fetch(`${API_BASE}/auth/register`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
    return response.json();
}

async function login(data) {
    const response = await fetch(`${API_BASE}/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
    return response.json();
}

// Question APIs
async function getQuestions() {
    const response = await fetch(`${API_BASE}/questions`);
    return response.json();
}

async function getQuestion(id) {
    const response = await fetch(`${API_BASE}/questions/${id}`);
    return response.json();
}

async function updateQuestion(id, data) {
    const response = await fetch(`${API_BASE}/questions/${id}`, {
        method: 'PUT',
        headers: getAuthHeaders(),
        body: JSON.stringify(data)
    });
    return response.json();
}

async function deleteQuestion(id) {
    const response = await fetch(`${API_BASE}/questions/${id}`, {
        method: 'DELETE',
        headers: getAuthHeaders()
    });
    return response.json();
}

async function createQuestion(data) {
    const response = await fetch(`${API_BASE}/questions`, {
        method: 'POST',
        headers: getAuthHeaders(),
        body: JSON.stringify(data)
    });
    return response.json();
}

// Submission APIs
async function createSubmission(data, userId, testSessionId) {
    let url = `${API_BASE}/submissions?userId=${userId}`;
    if (testSessionId) {
        url += `&testSessionId=${testSessionId}`;
    }
    const response = await fetch(url, {
        method: 'POST',
        headers: getAuthHeaders(),
        body: JSON.stringify(data)
    });
    return response.json();
}

async function getSubmission(id) {
    const response = await fetch(`${API_BASE}/submissions/${id}`);
    return response.json();
}

async function getSubmissionsByUser(userId) {
    const response = await fetch(`${API_BASE}/submissions/user/${userId}`);
    return response.json();
}

// Helper functions
function showError(message) {
    alert(message);
}

function showSuccess(message) {
    alert(message);
}

function formatDate(timestamp) {
    if (!timestamp) return '-';
    return new Date(timestamp).toLocaleString();
}

// Test APIs
async function getTests() {
    const response = await fetch(`${API_BASE}/tests`);
    return response.json();
}

async function getTest(id) {
    const response = await fetch(`${API_BASE}/tests/${id}`);
    return response.json();
}

async function updateTest(id, data) {
    const response = await fetch(`${API_BASE}/tests/${id}`, {
        method: 'PUT',
        headers: getAuthHeaders(),
        body: JSON.stringify(data)
    });
    return response.json();
}

async function deleteTest(id) {
    const response = await fetch(`${API_BASE}/tests/${id}`, {
        method: 'DELETE',
        headers: getAuthHeaders()
    });
    return response.json();
}

async function createTest(data) {
    console.log('API createTest:', JSON.stringify(data));
    const response = await fetch(`${API_BASE}/tests`, {
        method: 'POST',
        headers: getAuthHeaders(),
        body: JSON.stringify(data)
    });
    const result = await response.json();
    console.log('API result:', result);
    return result;
}

async function startTest(data) {
    const response = await fetch(`${API_BASE}/tests/start`, {
        method: 'POST',
        headers: getAuthHeaders(),
        body: JSON.stringify(data)
    });
    return response.json();
}

async function getTestSession(id) {
    const response = await fetch(`${API_BASE}/tests/session/${id}`);
    return response.json();
}

async function submitTestSession(id) {
    const response = await fetch(`${API_BASE}/tests/session/${id}/submit`, {
        method: 'POST',
        headers: getAuthHeaders()
    });
    return response.json();
}

// Admin APIs
async function getDashboard() {
    const response = await fetch(`${API_BASE}/admin/dashboard`, {
        headers: getAuthHeaders()
    });
    return response.json();
}

async function getAdminTests() {
    const response = await fetch(`${API_BASE}/admin/tests`, {
        headers: getAuthHeaders()
    });
    return response.json();
}

async function getTestResults(testId) {
    const response = await fetch(`${API_BASE}/admin/test/${testId}/results`, {
        headers: getAuthHeaders()
    });
    return response.json();
}

// Make functions globally available
window.api = {
    register,
    login,
    getQuestions,
    getQuestion,
    createQuestion,
    updateQuestion,
    deleteQuestion,
    createSubmission,
    getSubmission,
    getSubmissionsByUser,
    getTests,
    getTest,
    createTest,
    updateTest,
    deleteTest,
    startTest,
    getTestSession,
    submitTest: submitTestSession,
    submitTestSession,
    getDashboard,
    getAdminTests,
    getTestResults
};
