require 'spec_helper'

describe SessionsController do
  describe '#create' do
    it "sets the session['logged_in'] to true" do
      request.env['omniauth.auth'] = { 'info' => { 'email' => 'mkocher@pivotallabs.com' } }
      get :create
      request.session['logged_in'].should be
    end

    it "does not allow someone from outside pivotallabs.com to log in" do
      request.env['omniauth.auth'] = { 'info' => { 'email' => 'mkocher@l33thack3r.com' } }
      get :create
      request.session['logged_in'].should_not be
    end
  end
end