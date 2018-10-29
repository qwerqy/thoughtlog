require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end

    it 'returns a new User to @user' do
      user = User.new
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  context 'POST #create' do
    before do
      params = {
        :user => {
          first_name: 'John',
          last_name: 'Doe',
          email: 'john@example.com',
          password: 'password'
        }
      }
      should permit(:first_name, :last_name, :email, :password).
      for(:create, params: {params: params}).
        on(:user)
    end

    it 'signs in user after sign up' do
      user = create(:user)
      session[:user_id] = user.id
      expect(controller.current_user).to eq(user)
    end

    it 'should redirect to root with valid input' do
      user = create(:user)
      expect(user.valid?).to redirect_to(root_path)
    end
  end

  context 'GET #show' do
    before do
      @user = create(:user)
      session[:user_id] = @user.id
    end

    it 'should returns successful response' do
      get :show, params: {id: @user.id}
      expect(response).to be_successful
    end
  end

  context 'GET #edit' do
    before do
      @user = create(:user)
      session[:user_id] = @user.id
    end

    it 'should returns successful response' do
      get :edit, params: {id: @user.id}
      expect(response).to be_successful
    end
  end

  context 'PATCH #update' do
    before do
      @user = create(:user, id: 1)
      session[:user_id] = @user.id
    end
    it do
      params = {
        id: 1,
        user: {
          first_name: 'Jon',
          last_name: 'Doe',
          email: 'jondoe@example.com',
          password: 'password'
        }
      }
      should permit(:first_name, :last_name, :email, :password).
        for(:update, params: {params: params}).
        on(:user)
    end
  end

  context 'PATCH #update_email' do
    before do
      @user = create(:user, id: 1)
      session[:user_id] = @user.id
    end

    it 'should update email and response successful' do
      params = {
        id: 1,
        user: {
          current_email: 'jondoe@example.com',
          new_email: 'jonny@ex.com',
          password: 'password'
        }
      }
      patch :update, params: params
    end
  end

  context 'PATCH #update_password' do
    before do
      @user = create(:user, id: 1)
      session[:user_id] = @user.id
    end

    it 'should update email and response successful' do
      params = {
        id: 1,
        user: {
          current_password: 'password',
          new_password: 'asdasdasd',
          confirm_password: 'asdasdasd'
        }
      }
      patch :update, params: params
    end
  end

  context 'POST #follow' do
    before(:each) do
      @user = create(:user)
      @current_user = create(:user, email: 'asfaofn@gmmm.com')
    end

    it "should able create follow to other user" do
      follow = @current_user.follow!(@user)
      expect(follow).to be_valid
    end
  end

  context 'DELETE #unfollow' do
    before(:each) do
      @user = create(:user)
      @current_user = create(:user, email: 'asfaofn@gmmm.com')
      @current_user.follow!(@user)
    end

    it "should able destroy follow to other user" do
      unfollow = @current_user.unfollow!(@user)
      expect(unfollow).to be_valid
    end
  end
end
