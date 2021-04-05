function defineNameOfForm(idName, parentIdName, categories){
  const parentName = parentIdName
  let formClassName = "select-box"
  let paramsName = "product[child_category_id]"
  if (location.pathname.match("products/search")){  
    formClassName = "search-input"
    paramsName = "q[category_id_in]"
  }
  return [idName, formClassName, paramsName, parentName, categories]
}

function addCategoryForm(idName, className, paramName, parentIdName, categories){
  const categorySelect = document.createElement("select")
  categorySelect.setAttribute('class', className)
  categorySelect.setAttribute('id', idName)
  categorySelect.setAttribute('name', paramName)
  const nullOption = document.createElement("option")
  nullOption.setAttribute("value", "")
  nullOption.innerHTML = ("---")
  categorySelect.appendChild(nullOption)
  categories.forEach(function(child) {
    const childOption = document.createElement("option")
    childOption.setAttribute("value", child.id)
    childOption.innerHTML = child.name
    categorySelect.appendChild(childOption)
  })
  document.getElementById(parentIdName).insertAdjacentElement('afterend', categorySelect)
}



const category = () => {
  if (location.pathname.match("products/search") || location.pathname.match("products/new")){
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
          const [childIdName, 
                childClassName, 
                childParamName, 
                rootIdName, 
                childCategories] = defineNameOfForm('item-child-category','item-category',XHR.response)

          addCategoryForm(childIdName, childClassName, childParamName, rootIdName, childCategories)

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
                const [grandChildIdName, 
                      grandChildClassName, 
                      grandChildParamName, 
                      parentIdName, 
                      grandChildCategories] = defineNameOfForm('item-grandchild-category','item-child-category',XHR.response)

                addCategoryForm(grandChildIdName, grandChildClassName, grandChildParamName, parentIdName, grandChildCategories)
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
}
window.addEventListener("load", category)