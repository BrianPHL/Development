$(() => {

    const navBtn = $('.nav-buttons')

    $(navBtn).on('click', function() {

        const highlight    = $('.nav-buttons-highlight')
        const identifier   = $(this).attr('id')
        const div          = $('.content-child')

        const hideElements = function() {

            highlight.hide()
            div.hide()

        }
        hideElements()

        $(this).find(highlight).show()
        $('.' + identifier).show()

    })

})