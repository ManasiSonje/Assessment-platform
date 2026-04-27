// API Configuration
const API_BASE = 'http://localhost:8080/api/v1';

// Question APIs
async function getQuestions() {
    const response = await fetch(`${API_BASE}/questions`);
    return response.json();
}

async function getQuestion(id) {
    const response = await fetch(`${API_BASE}/questions/${id}`);
    return response.json();
}

async function createQuestion(data) {
    const response = await fetch(`${API_BASE}/questions`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
    return response.json();
}

// Submission APIs
async function createSubmission(data, userId) {
    const response = await fetch(`${API_BASE}/submissions?userId=${userId}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
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

// Make functions globally available
window.api = {
    getQuestions,
    getQuestion,
    createQuestion,
    createSubmission,
    getSubmission,
    getSubmissionsByUser
};