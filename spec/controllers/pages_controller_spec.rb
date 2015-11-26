require 'rails_helper'

RSpec.describe PagesController, :type => :controller do
  render_views

  describe "GET home" do
    it "returns http success and a homepage" do
      get :home
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Welcome on the homepage!")
    end
  end

  describe "GET about" do
    it "returns http success and a homepage" do
      get :about
      expect(response).to have_http_status(:success)
      expect(response.body).to eq("This is a class about Ruby on Rails")
    end
  end

  describe "GET random" do
    it "fills the DOM with a list of number" do
      get :random, times: "10"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<div>0</div>")
      expect(response.body).to include("<div>1</div>")
      expect(response.body).to include("<div>2</div>")
      expect(response.body).to include("<div>3</div>")
      expect(response.body).to include("<div>4</div>")
      expect(response.body).to include("<div>5</div>")
      expect(response.body).to include("<div>6</div>")
      expect(response.body).to include("<div>7</div>")
      expect(response.body).to include("<div>8</div>")
      expect(response.body).to include("<div>9</div>")
      expect(response.body).to_not include("<div>10</div>")

      get :random, times: "2"
      expect(response).to have_http_status(:success)
      expect(response.body).to include("<div>0</div>")
      expect(response.body).to include("<div>1</div>")
      expect(response.body).to_not include("<div>2</div>")
      expect(response.body).to_not include("No valid param")
    end

    it "does not fail when not passed a parameter or passed an invalid parameter" do
      get :random
      expect(response).to have_http_status(:success)
      expect(response.body).to include("No valid param")

      get :random, times: " "
      expect(response).to have_http_status(:success)
      expect(response.body).to include("No valid param")
    end
  end
end
