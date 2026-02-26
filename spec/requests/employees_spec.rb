require "rails_helper"

RSpec.describe "Employees API", type: :request do
  let!(:employees) { create_list(:employee, 3) }
  let(:employee_id) { employees.first.id }

  let(:valid_params) do
    {
      employee: {
        full_name: "John Doe",
        job_title: "Developer",
        country: "India",
        salary: 50000
      }
    }
  end

  let(:invalid_params) do
    {
      employee: {
        full_name: nil,
        job_title: nil,
        country: nil,
        salary: nil
      }
    }
  end

  # INDEX (GET /employees)
  describe "GET /api/v1/employees" do
    before { get "/api/v1/employees" }

    it "returns employees" do
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  # SHOW (GET /employees/:id)
  describe "GET /api/v1/employees/:id" do
    context "when employee exists" do
      before { get "/api/v1/employees/#{employee_id}" }

      it "returns the employee" do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(employee_id)
      end
    end

    context "when employee does not exist" do
      before { get "/api/v1/employees/999999" }

      it "returns 404" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  # CREATE (POST /employees)
  describe "POST /api/v1/employees" do
    context "with valid params" do
      it "creates an employee" do
        expect {
          post "/api/v1/employees", params: valid_params
        }.to change(Employee, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "returns unprocessable entity" do
        post "/api/v1/employees", params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  # UPDATE (PUT /employees/:id)
  describe "PUT /api/v1/employees/:id" do
    let(:update_params) do
      { employee: { job_title: "Senior Developer" } }
    end
    # if job title pass as nil
    let(:update_params_with_nil_job_title) do
      { employee: { job_title: nil } }
    end

    context "when job title is set to nil" do
      before { put "/api/v1/employees/#{employee_id}", params: update_params_with_nil_job_title }

      it "returns unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    before { put "/api/v1/employees/#{employee_id}", params: update_params }

    it "updates the employee" do
      expect(response).to have_http_status(:ok)
      expect(Employee.find(employee_id).job_title).to eq("Senior Developer")
    end
  end

  # DELETE (DELETE /employees/:id)
  describe "DELETE /api/v1/employees/:id" do
    it "deletes the employee" do
      expect {
        delete "/api/v1/employees/#{employee_id}"
      }.to change(Employee, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
