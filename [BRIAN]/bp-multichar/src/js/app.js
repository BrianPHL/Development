$(() => {
    $('.charsel-create').on('click', () => {
        $('.char-sel').hide();
        $('.char-crtn').show();
    });
    $('#charcrtn-return').on('click', () => {
        $('.char-crtn').hide();
        $('.char-sel').show();
    });
    window.addEventListener('message', (event) => {
        const data = event.data;
        const type = event.data.type;
        if (type == 'stateObserver') {
            if (data.isEnabled == true) {
                console.log('inside addEventListener: "message"');
                $('.container').show();
            }
        }
    });
});
