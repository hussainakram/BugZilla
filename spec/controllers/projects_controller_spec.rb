require 'rails_helper'

RSpec.describe ProjectsController do
  it "populates an array of projects" do
    project = build(:project)
    get :index
    assert_equal Project.all, assigns(:projects)
  end
 it "renders the :index view" do
    get :index
    response.should render_template :index
  end
end
