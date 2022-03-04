declare var jquery: any;
declare var $: any;

$(() => {

    //addEventListener "click" on navBtn
    const navBtn = $('.nav-buttons')

    // function when navBtn is clicked 
    navBtn.click(function() {

        // constanced variables
        const navHighlight = $('.nav-buttons-highlight')
        const navId        = $(this).attr('id')
        const navDiv       = $('.content-child')

        // hides previously activated styles
        // it only shows on a clicked button
        navDiv.hide()
        navHighlight.hide()

        // shows styles on clicked button 
        $(this).find(navHighlight).show()
        $('.' + navId).show()

    })

    const box = $('.penalcodes-second-entries')
    const height = box.height()
    const width = box.width()

    console.log(height, width)

})