$(() => {

    const flushForms = (() => {

        $('textarea').val('')
        $('input').val('')

    })
    flushForms()

    const feedbackTextarea = $('.feedback-second-textarea > textarea')

    $(document).on('keyup', feedbackTextarea, (() => {

        const feedbackTextareaVal    = $(feedbackTextarea).val() as string
        const feedbackTextareaLength = feedbackTextareaVal.length

        const feedbackCounter = $('#feedback-counter-value')
        feedbackCounter.text(feedbackTextareaLength)
        
    }))

    $(document).keydown((data) => {

        if (data.which == 27) {

            $.post('https://brianph-mdb/bp-mdb:closeMDB')

        }

    })

    window.addEventListener('message', (event) => {

        const data = event.data
        const type = event.data.type

        if (type == 'MDBstate') {

            if (data.isOpen == true) {

                $('.container').show()
                $('.container').animate({
                    'margin-top': '0px'
                })

            }

            else {

                $('.container').animate({
                    'margin-top': '1200px'
                })
                setTimeout(() => {
                    $('.container').hide()
                }, 500)

            }

        }

    })

})  