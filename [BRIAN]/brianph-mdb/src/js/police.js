$(() => {

    const navHighlight = $('.nav-buttons-highlight')

    $('#dashboard').addClass('nav-buttons-active')
    $('#dashboard').find(navHighlight).show()

    $(document).on('click', '.nav-buttons', function() {

        const navHighlight = $('.nav-buttons-highlight')
        const navButton = $('.nav-buttons')

        $(navButton).removeClass('nav-buttons-active')
        $(navHighlight).hide()

        $(this).addClass('nav-buttons-active')
        $(this).find(navHighlight).show()

        const id  = $(this).attr('id')
        const div = $('.content-child')
        
        div.hide()
        $('.' + id).show()

    })
    
})