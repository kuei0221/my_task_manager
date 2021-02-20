require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_inclusion_of(:status).in_array(%w[pending in_progress completed]) }
  it { should define_enum_for(:priority).with_values(%w[low medium high]) }

  context 'when start date larger than end date' do
    let(:task) { tasks(:start_date_larger_than_end_date_task) }
    it 'is invalid' do
      expect(task).to be_invalid
      expect(task.errors.full_messages).to include 'Start date should not larger than end date'
    end
  end

  describe '::search_by_name' do
    subject { described_class.search_by_name(name) }
    let(:name) { 'test' }

    it 'should find all task with name' do
      expect(subject.pluck(:name)).to all(include(name))
    end
  end

  describe '::search_by_status' do
    subject { described_class.search_by_status(status) }
    let(:status) { 'pending' }

    it 'should find all task with name' do
      expect(subject.pluck(:status)).to all(include(status))
    end
  end

  describe '::search' do
    subject { described_class.search(name: name, status: status) }

    before do
      allow(Task).to receive(:search_by_name).and_return(Task)
      allow(Task).to receive(:search_by_status).and_return(Task)
    end

    context 'when name present' do
      let(:name) { 'test' }
      let(:status) { '' }

      it 'should call search_by_name' do
        subject
        expect(Task).to have_received(:search_by_name)
      end
    end

    context 'when status present' do
      let(:name) { '' }
      let(:status) { 'pending' }

      it 'should call search_by_name' do
        subject
        expect(Task).to have_received(:search_by_status)
      end
    end

    context 'when name and status present' do
      let(:name) { 'test' }
      let(:status) { 'pending' }

      it 'should call search_by_name' do
        subject
        expect(Task).to have_received(:search_by_name)
        expect(Task).to have_received(:search_by_status)
      end
    end

    context 'when name and status none present' do
      let(:name) { '' }
      let(:status) { '' }

      it 'should call search_by_name' do
        subject
        expect(Task).not_to have_received(:search_by_name)
        expect(Task).not_to have_received(:search_by_status)
      end
    end
  end
end
