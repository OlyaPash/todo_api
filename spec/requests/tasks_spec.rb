require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /index" do
    let(:tasks) { create_list(:task, 2) }

    it "returns all tasks" do
      get "/tasks"

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /show" do
    let(:task) { create(:task) }

    it "returns task" do
      get "/tasks/#{task.id}"

      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    it "returns status created" do
      post "/tasks", params: {
        task: {
        "title": "Task_1",
        "completed": false
        }
      }

      expect(response).to have_http_status(:created)
    end
  end

  describe "PATCH /update" do
    let(:task) { create(:task) }

    context "update task" do
      before do
        patch "/tasks/#{task.id}", params: {
          task: { "title": "Anything" }
        }
      end

      it "returns updated task" do
        task.reload

        expect(task.title).to eq "Anything"
      end

      it "returns status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE /destroy" do
    let(:task) { create(:task) }

    it "successfully deleted" do
      delete "/tasks/#{task.id}", params: { id: task }

      expect(Task.count).to eq 0
    end
  end
end
