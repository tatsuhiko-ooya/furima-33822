const myPageScroll = () => {
  if (location.pathname.match("/users") || location.pathname.match("/categories")) {

    const linkTriggers = document.querySelectorAll('a[href^="#"]')
    linkTriggers.forEach(function(linkTrigger){
      linkTrigger.addEventListener("click", function(e) {
        const href = linkTrigger.getAttribute("href")
        const targetElement = document.getElementById(href)
        if (targetElement){
          e.preventDefault();
          e.stopPropagation();
          targetElement.scrollIntoView(true)
        }
      })      
    })
  }
}

window.addEventListener("load", myPageScroll)