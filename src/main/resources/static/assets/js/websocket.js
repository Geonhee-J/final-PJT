/**
 * 
 */

let stompClient = null;
let usercode = null;
let username = null;

function connect() {
    function createSocket() {
        return new SockJS('/gaent/ws');
    }

    stompClient = StompJs.Stomp.over(createSocket);
    stompClient.connect({}, onConnected, onError);

    /*window.onbeforeunload = function() {
        sendSystemMessage('LEAVE');
    }*/
}

function onConnected() {
    console.log('Connected');

    stompClient.subscribe('/user/queue/messages', function(chatMessage) {
        console.log('Message received:' + chatMessage);
        showMessage(JSON.parse(chatMessage.body));
    });

    sendSystemMessage('JOIN');
}

function onError(error) {
    console.log('Error: ' + error);
}

function sendMessage() {
    const messageContent = document.getElementById('message').value;
    const receiver = '20110006';

    const chatMessage = {
        sender: username,
        message: messageContent,
        receiver: receiver,
        type: 'CHAT'
    }

    stompClient.send('/app/chat.sendMessage', {}, JSON.stringify(chatMessage));
    document.getElementById('message').value = '';
    
    showMessage(chatMessage);
}

function sendSystemMessage(type) {
    const receiver = '20110006';

    const chatMessage = {
        sender: username,
        message: '',
        receiver: receiver,
        type: type
    }

    stompClient.send('/app/chat.sendMessage', {}, JSON.stringify(chatMessage));
}

function showMessage(message) {
    console.log('showMessage' + message);
    const chatHistory = document.getElementById('chat-history');
    const messageElement = document.createElement('li');
    messageElement.classList.add('chat-message', message.sender === username ? 'chat-message-right' : 'chat-message-left');

    messageElement.innerHTML = `
        <div class="d-flex overflow-hidden">
            <div class="user-avatar flex-shrink-0 ${message.sender === username ? 'ms-4' : 'me-4'}">
                <div class="avatar avatar-sm">
                    <img src="/path/to/avatar.png" alt="Avatar" class="rounded-circle"/>
                </div>
            </div>
            <div class="chat-message-wrapper flex-grow-1">
                <div class="chat-message-text ${message.sender === username ? 'primary' : ''}">
                    <p class="mb-0">${message.content}</p>
                </div>
                <div class="${message.sender === username ? 'text-end' : ''} text-muted mt-1">
                    <small>${new Date().toLocaleTimeString()}</small>
                </div>
            </div>
        </div>
    `;

    chatHistory.appendChild(messageElement);
    chatHistory.scrollTop = chatHistory.scrollHeight;
}

document.addEventListener('DOMContentLoaded', function() {
    connect();
    document.getElementById('send').addEventListener('click', function(e) {
        e.preventDefault();
        sendMessage();
    });

    usercode = document.getElementById('sessionEmpCode').value;
    username = document.getElementById('sessionKorName').value;
    console.log('usercode: ' + usercode + ' / username: ' + username);
});

function chatClose() {
    sendSystemMessage('LEAVE');
}

/*document.getElementById('close').addEventListener('click', function(e) {
    e.preventDefault();
    sendSystemMessage('LEAVE');
});*/