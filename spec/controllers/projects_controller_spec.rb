require 'rails_helper'

RSpec.describe ProjectsController do
  let!(:user) { create(:user) }
  let(:project) { create(:project, user_id: user.id) }
  before { sign_in(user) }

  describe 'GET #index' do
    it 'has a 200 status code' do
      get :index
      expect render_template('index')
      expect(response.status).to eq(200)
    end
    it 'render index template' do
      get :index
      expect render_template('index')
    end
  end
  describe 'GET #new' do
    it 'has a 200 status code' do
      get :new
      expect(response.status).to eq(200)
    end
    it 'render index template' do
      get :new
      expect render_template('new')
    end
  end
  describe 'GET #show' do
    it 'has a 200 status code' do
      get :index, params: { id: 1 }
      expect(response.status).to eq(200)
    end
    it 'render show template' do
      get :index, params: { id: 1 }
      expect render_template :show
    end
  end

  describe 'with valid attributes' do
    before do
      user = create(:user, email: Faker::Internet.email)
      allow_any_instance_of(ProjectsController).to receive(:current_user) { user }
    end
    it 'should create project' do
      expect do
        post :create, params: { project: FactoryBot.attributes_for(:project) }
      end.to change(Project, :count).by(1)
    end
  end

  describe 'PATCH #update' do
    before(:each) do
      @project = create(:project)
    end
    let(:attr) do
      { name: 'my project is awesome', description: 'this is awesome description' }
    end
    before(:each) do
      put :update, params: { id: @project.id, project: attr }
      @project.reload
    end

    it { expect(response).to redirect_to(@project) }
    it { expect(@project.name).to eql attr[:name] }
    it { expect(@project.description).to eql attr[:description] }
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @project = create(:project)
    end
    context 'success' do
      it 'deletes the project' do
        expect do
          delete :destroy, params: { id: @project, project: { name: @project.name } }
        end.to change(Project, :count).by(-1)
      end
    end
  end
end
