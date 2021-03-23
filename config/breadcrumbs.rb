crumb :root do
  link "トップページ", root_path
end

crumb :category_index do
  link "カテゴリー一覧", categories_path
  parent :root
end

crumb :parent_category do |category|
  category = Category.find(params[:id]).root
  link "#{category.name}", category_path(category)
  parent :category_index  
end

crumb :child_category do |category|
  category = Category.find(params[:id])
  if category.has_children?
    link "#{category.name}", category_path(category)
  else
    link "#{category.parent.name}", category_path(category.parent.id)
  end
  parent :parent_category
end

crumb :grandchild_category do |category|
  category = Category.find(params[:id])
  link "#{category.name}", category_path(category)
  parent :child_category
end





