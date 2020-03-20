module LogInHelpers
  def admin_token
    admin = create :admin, email: 'admin@example.com', password: 'password'
    post(api_v1_auth_admin_path, nil, {email: admin.email, password: admin.password })
    response_json['auth_token']
    {'Authorization' => "#{response_json['auth_token']}"}
  end
end
