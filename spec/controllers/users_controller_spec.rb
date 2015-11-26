require 'rails_helper'

RSpec.describe "UsersController", :type => :controller do

  render_views

  describe "GET index" do
    it "displays a title" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("All Users")
    end

    it "displays a list of users" do
      User.create(name: "Eileen", email: "Eileen@rs.com")
      User.create(name: "Benson", email: "benson@rs.com")
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Eileen")
      expect(response.body).to include("Benson")
    end

    it "doesn't displays a list of users if there are no users" do
      User.delete_all
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to_not include("Eileen")
      expect(response.body).to_not include("Benson")
    end

    it "is possible to create a user" do
      expect(User.count).to eq(0)
      post :create, user: { name: "John", email: "john@stripe.com" }
      expect(User.count).to eq(1)
      user = User.last
      expect(user.name).to eq("John")
      expect(user.email).to eq("john@stripe.com")
    end

    it "will fail to create an invalid user" do
      post :create, user: { name: "John", email: "notanemail" }
      expect(User.count).to eq(0)
      expect(response.body).to include("Email is invalid")

      post :create, user: { name: nil, email: "email@email.com" }
      expect(User.count).to eq(0)
      expect(response.body).to include("Name") # Expecting "Name can't be blank"
      expect(response.body).to include("blank")
    end
  end

  describe "GET export" do
    it "returns an export of all the users as json" do
      eileen = User.create(name: "Eileen #{rand(1000)}", email: "Eileen@rs.com")

      get :export, format: :json
      expect(response).to have_http_status(:success)
      expect(response.body).to eq(
        "[{\"id\":#{eileen.id},\"name\":\"#{eileen.name}\",\"email\":\"#{eileen.email}\"}]"
      )
    end
  end
end
