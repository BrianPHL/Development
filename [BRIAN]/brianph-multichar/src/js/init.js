$(() => {
    window.addEventListener('message', (event) => {
        const data = event.data;
        const type = event.data.type;
        if (type == 'stateObserver') {
            if (data.isEnabled == true) {
                console.log('inside addEventListener: "message"');
                $('.container').fadeIn();
            }
        }
    });
});
