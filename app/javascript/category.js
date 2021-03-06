const category = () => {
  const parentCategory = document.getElementById("item-category") 
  parentCategory.addEventListener('change', () => {
    const parentCategoryId = document.getElementById("item-category").value
    if (parentCategoryId) {
      const XHR = new XMLHttpRequest()
      XHR.open('GET', `/products/${parentCategoryId}/get_category_child`, true)
      XHR.responseType = 'json'
      XHR.send()
      XHR.onload = ()=> {
        if (XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null;
        }
        if (document.getElementById("item-child-category") != null){
          document.getElementById("item-child-category").remove()
          if (document.getElementById("item-grandchild-category") != null){
            document.getElementById("item-grandchild-category").remove()
          }
        }
        const childCategories = XHR.response
        
        const childCategorySelect = document.createElement("select")
        childCategorySelect.setAttribute('class', "select-box")
        childCategorySelect.setAttribute('id', 'item-child-category')
        childCategorySelect.setAttribute('name', 'product[category_id]')
        const nullOption = document.createElement("option")
        nullOption.setAttribute("value", "")
        nullOption.innerHTML = ("---")
        childCategorySelect.appendChild(nullOption)
        childCategories.forEach(function(child) {
          let childOption = document.createElement("option")
          childOption.setAttribute("value", child.id)
          childOption.innerHTML = child.name
          childCategorySelect.appendChild(childOption)
        })

        document.getElementById("item-category").insertAdjacentElement('afterend', childCategorySelect)

          const childCategory = document.getElementById("item-child-category") 
          
        childCategory.addEventListener('change', () => {
          const childCategoryId = document.getElementById("item-child-category").value
          if (childCategoryId) {
            const XHR = new XMLHttpRequest()
            XHR.open('GET', `/products/${childCategoryId}/get_category_grandchild`, true)
            XHR.responseType = 'json'
            XHR.send()
            XHR.onload = ()=> {
              if (XHR.status != 200) {
                alert(`Error ${XHR.status}: ${XHR.statusText}`);
                return null;
              }

              if (document.getElementById("item-grandchild-category") != null) {
                document.getElementById("item-grandchild-category").remove()
              }
              
              
              const grandChildCategories = XHR.response
              
              const grandChildCategorySelect = document.createElement("select")
              grandChildCategorySelect.setAttribute('class', "select-box")
              grandChildCategorySelect.setAttribute('id', 'item-grandchild-category')
              grandChildCategorySelect.setAttribute('name', 'product[category_id]')
              const nullOption = document.createElement("option")
              nullOption.setAttribute("value", "")
              nullOption.innerHTML = ("---")
              grandChildCategorySelect.appendChild(nullOption)
              grandChildCategories.forEach(function(grandChild) {
                let grandChildOption = document.createElement("option")
                grandChildOption.setAttribute("value", grandChild.id)
                grandChildOption.innerHTML = grandChild.name
                grandChildCategorySelect.appendChild(grandChildOption)
              })
              document.getElementById("item-child-category").insertAdjacentElement('afterend', grandChildCategorySelect)
            }
          }
          else { if (document.getElementById("item-grandchild-category") != null){
                      document.getElementById("item-grandchild-category").remove()
                 }
                }

       })
      }
    }
    else { if (document.getElementById("item-child-category") != null){
                document.getElementById("item-child-category").remove()
              if (document.getElementById("item-grandchild-category") != null){
                  document.getElementById("item-grandchild-category").remove()
              }
           }
    }
  })
}
window.addEventListener("load", category)