const preview = ()=>{
  if (location.pathname.match("products/new")){
    const imagePreview = document.getElementById('image-preview')
    const itemImage = document.getElementById('item-image')
    
    itemImage.addEventListener('change', function(e){
      const imageContent = document.querySelector('img')
      if (imageContent){
        imageContent.remove()
      }
      const file = e.target.files[0]
      const blob = window.URL.createObjectURL(file)
      
      const imageElement = document.createElement('div')
      const blobImage = document.createElement('img')
      blobImage.setAttribute('src', blob)
      imageElement.appendChild(blobImage)
      imagePreview.appendChild(imageElement)
    })
  }
}

window.addEventListener('load', preview)