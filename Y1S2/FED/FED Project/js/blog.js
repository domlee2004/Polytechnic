// JavaScript source code

new Masonry("#posts .grid",
    {
        itemSelector: '.grid-item',
        gutter: 20
    });
// swiper initialization
new Swiper('.swiper-container',
    {
        direction: 'horizontal',
        loop: true,
        slidesPerView: 5,
        autoplay: {
            delay: 3000
        },
        allowTouchMove: true,
        breakpoints:
        {
            '@0':
            {
                slidesPerView:2
            },
            '@1.0':
            {
                slidesPerView:3 
            },
            '@1.25':
            {
                slidesPerView:4
            },
            '@1.50':
            {
                slidesPerView:5
            }
        }
    });