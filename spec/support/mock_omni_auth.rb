module MockOmniAuth
  def mock_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_apps] = {
      'info' => {
        'email' => 'mkocher@pivotallabs.com'
      }
    }
  end
end