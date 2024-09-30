function hideNotifications() {
    const notifications = document.querySelectorAll('.notification');
    notifications.forEach(notification => {
        setTimeout(() => {
            notification.style.opacity = 0; 
            setTimeout(() => {
                notification.style.display = 'none'; 
            }, 600); 
        }, 2000); 
    });
}

window.onload = hideNotifications; 
