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
        let childClassName = "select-box"
        let childParamName = "product[child_category_id]"
        if (location.pathname.match("products/search")){
          childClassName = "search-input"
          childParamName = "q[category_id_in]"
        }
        const childCategorySelect = document.createElement("select")
        childCategorySelect.setAttribute('class', childClassName)
        childCategorySelect.setAttribute('id', 'item-child-category')
        childCategorySelect.setAttribute('name', childParamName)
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
              let grandChildClassName = "select-box"
              let grandChildParamName = "product[category_id]"
              if (location.pathname.match("products/search")){
                grandChildClassName = "search-input"
                grandChildParamName = "q[category_id_in]"
              }
              const grandChildCategorySelect = document.createElement("select")
              grandChildCategorySelect.setAttribute('class', grandChildClassName)
              grandChildCategorySelect.setAttribute('id', 'item-grandchild-category')
              grandChildCategorySelect.setAttribute('name', grandChildParamName)
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
  if (location.pathname.match("products/search")){
    const searchForm = document.getElementById("detail-product_search")
    searchForm.addEventListener("submit", (e) => {
      e.preventDefault();
      if (document.getElementById("item-child-category")){
        if (document.getElementById("item-category").value != "" && document.getElementById("item-child-category").value == ""){
          document.getElementById("item-child-category").remove()
        }
        if (document.getElementById("item-grandchild-category")){
            if (document.getElementById("item-child-category").value != "" && document.getElementById("item-grandchild-category").value == ""){
              document.getElementById("item-grandchild-category").remove()
            }
        }

      }
      document.getElementById("detail-product_search").submit()
    })
    
  }
}
window.addEventListener("load", category)