require 'rails_helper'
# load 'rails_helper'
# require_relative '../rails_helper'

# require_relative '../../app/controllers/home_controller.rb'
# require_relative '../../app/controllers/application_controller.rb'


RSpec.describe "HomeController", type: :controller do

  # top アクション
  describe 'GET #top' do
    before do
      get :top
    end
    it 'リクエストが200 OK となること' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end
    it ' :topを表示すること' do
      expect(response).to render_template :top
    end
  end


end
