require_dependency Rails.root.join("app", "controllers", "management", "users_controller").to_s

class Management::UsersController
  def show
    @user = User.find(params[:id])
  end

  def verify
    now = Time.current
    @user.update!(residence_verified_at: now, verified_at: now, level_two_verified_at: now)
    redirect_to management_users_path
  end
end
