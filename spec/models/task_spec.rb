require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_inclusion_of(:status).in_array(%w[pending in_progress completed]) }
  it { should validate_inclusion_of(:priority).in_array(%w[low medium high]) }

  context 'when start date larger than end date' do
    let(:task) { tasks(:start_date_larger_than_end_date_task) }
    it 'is invalid' do
      expect(task).to be_invalid
      expect(task.errors.full_messages).to include 'Start date should not larger than end date'
    end
  end
end
