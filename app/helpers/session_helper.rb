module SessionHelper
  def log_in_session(user)
    session[:UserLoggedId] = user.id
  end

  def current_logged_user
    user = User.find_by(id: session[:UserLoggedId])
  end

  def is_logged_in
    !session[:UserLoggedId].nil? && current_logged_user.present? && !current_logged_user.id.nil?
  end

  def log_out
    session.delete(:UserLoggedId)
  end

  def must_be_logged
    render_403 unless is_logged_in
  end
end
