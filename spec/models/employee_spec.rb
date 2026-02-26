require 'rails_helper'

RSpec.describe Employee do
  it { is_expected.to validate_presence_of(:full_name) }
  it { is_expected.to validate_presence_of(:job_title) }
  it { is_expected.to validate_presence_of(:country) }
  it { is_expected.to validate_presence_of(:salary) }
end
