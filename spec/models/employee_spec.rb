RSpec.describe Employee do
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:job_title) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:salary) }
end
