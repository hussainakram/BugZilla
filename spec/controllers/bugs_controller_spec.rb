require 'rails_helper'

RSpec.describe BugsController do
  let!(:user) { create(:user) }
  let(:project) { create(:project, user_id: user.id) }
  let(:bug) { create(:bug) }
  before { sign_in(user) }

  describe 'GET #index' do
    it 'has a 200 status code' do
      get :index, params: { project_id: project.id }
      expect render_template('index')
      expect(response.status).to eq(200)
    end
    it 'render index template' do
      get :index, params: { project_id: project.id }
      expect render_template('index')
    end
  end

  describe 'GET #new' do
    it 'has a 200 status code' do
      get :new, params: { project_id: project.id }
      expect(response.status).to eq(200)
    end
    it 'render index template' do
      get :new, params: { project_id: project.id }
      expect render_template('new')
    end
  end

  describe 'GET #show' do
    it 'has a 200 status code' do
      get :index, params: { project_id: project.id, id: 1 }
      expect(response.status).to eq(200)
    end
    it 'render show template' do
      get :index, params: { project_id: project.id, id: 1 }
      expect render_template :show
    end
  end

  describe 'with valid attributes' do
    before do
      user = create(:user, email: Faker::Internet.email)
      project = create(:project, user_id: user.id, name: Faker::Name.title)
      allow_any_instance_of(BugsController).to receive(:current_user) { user }
    end
    it 'should create project' do
      expect do
        post :create, params: { bug: FactoryBot.attributes_for(:bug), project_id: project.id }
      end.to change(Bug, :count).by(1)
    end
  end

  describe 'PATCH #update' do
    before(:each) do
      @bug = create(:bug)
    end
    let(:attr) do
      {
        title: Faker::Science.element,
        description: Faker::Lorem.sentences,
        deadline: Faker::Date.between_except(1.year.ago, 1.year.from_now, Time.zone.today),
        bug_type: 'feature',
        status: 'Started'
      }
    end
    before(:each) do
      put :update, params: { id: @bug.id, bug: attr }
      @bug.reload
    end

    it { expect(response).to redirect_to(@bug) }
    it { expect(@bug.title).to eql attr[:title] }
  end

  describe 'DELETE #destroy' do
    before(:each) do
      @bug = create(:bug)
    end
    context 'with valid parameters' do
      it 'deletes the bug' do
        expect do
          delete :destroy, params: { id: @bug, bug: { title: @bug.title } }
        end.to change(Bug, :count).by(-1)
      end
    end
  end
end
