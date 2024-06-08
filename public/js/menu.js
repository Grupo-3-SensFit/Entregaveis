function menuLateral(e) {
    let navlist = document.querySelector('#navbar-list');
    let mobileButton = document.querySelector('#mobile-button')
    mobileButton.classList.toggle('active');
    navlist.classList.toggle('show')

}

function menuScroll (){
    const scroll = window.scrollY;
    if (scroll > 0) {
        document.querySelector('nav').classList.add("active") 
        document.querySelector('#logo').src="img/LogoLaranja2.png"
    } else {
        document.querySelector('nav').classList.remove("active") 
        document.querySelector('#logo').src="img/LogoBranca2.png"
    }
}

document.addEventListener('scroll', menuScroll)