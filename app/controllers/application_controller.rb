class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :search_product

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']  # 環境変数を読み込む記述に変更
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_day])
  end

  def search_product
    if params[:q].present?
      if params[:q][:category_id_in].present?
        category = Category.find(params[:q][:category_id_in])
        if category.root?
          category_grandchild_ids = category.indirect_ids
          params[:q][:category_id_in] = category_grandchild_ids
        elsif category.has_children?
          category_grandchild_ids = category.child_ids
          params[:q][:category_id_in] = category_grandchild_ids
        end
      end
    end
    @p = Product.ransack(params[:q])
  end
end
