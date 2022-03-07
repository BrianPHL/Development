$(() => {

    const feedbackTextarea = $('.feedback-second-textarea > textarea')

    $(document).on('keyup', feedbackTextarea, function() {

        const feedbackTextareaVal : any = $(feedbackTextarea).val()
        const feedbackTextareaLength    = feedbackTextareaVal.length

        const feedbackCounter = $('#feedback-counter-value')
        feedbackCounter.text(feedbackTextareaLength)
        
    })

})