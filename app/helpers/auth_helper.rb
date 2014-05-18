module AuthHelper

  def ensure_signed_in_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end

  def ensure_admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end