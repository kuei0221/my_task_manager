# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Task Managemenet', type: :feature do
  describe 'show specific task' do
    context 'when task exist' do
      let(:task) { tasks(:pending_task) }

      it 'show task' do
        visit task_path(task.id)
        expect(page).to have_content(task.name)
        expect(page).to have_content(task.description)
        expect(page).to have_content(task.priority)
        expect(page).to have_content(task.status)
        expect(page).to have_content(task.start_date)
        expect(page).to have_content(task.end_date)
      end
    end
  end

  describe 'visit task list' do
    before { visit tasks_path }

    it 'show all task' do
      expect(page).to have_content(tasks(:pending_task).name)
      expect(page).to have_content(tasks(:progressing_task).name)
      expect(page).to have_content(tasks(:completed_task).name)
    end

    it 'sort tasks by created_at in desc' do
      expect(page).to have_text(/test3.+test2.+test1/)
    end

    context 'when click Created At' do
      it 'sorts all task by created_at' do
        click_link 'Created At'
        expect(page).to have_text(/test1.+test2.+test3/)
        click_link 'Created At'
        expect(page).to have_text(/test3.+test2.+test1/)
      end
    end

    context 'when click End At' do
      it 'sorts all task by end_date' do
        click_link 'End At'
        expect(page).to have_text(/test1.+test2.+test3/)
        click_link 'End At'
        expect(page).to have_text(/test3.+test2.+test1/)
      end
    end
  end

  describe 'create task' do
    context 'when create success' do
      it 'create task' do
        visit new_task_path
        fill_in 'Name', with: 'testing create'
        fill_in 'Description', with: 'This is testing the creation of a new test'
        select('High', from: 'Priority')
        select('In Progress', from: 'Status')
        select('2020', from: 'task_start_date_1i')
        select('Jun', from: 'task_start_date_2i')
        select('20', from: 'task_start_date_3i')
        select('2021', from: 'task_end_date_1i')
        select('July', from: 'task_end_date_2i')
        select('30', from: 'task_end_date_3i')
        click_on 'Create Task'

        expect(page).to have_content('Task Create Success')
        expect(page).to have_content('testing create')
        expect(page).to have_content('This is testing the creation of a new test')
        expect(page).to have_content('high')
        expect(page).to have_content('in_progress')
        expect(page).to have_content('2020-06-20')
        expect(page).to have_content('2021-07-30')
      end
    end

    context 'when create fail' do
      it 'shows alert and errors' do
        visit new_task_path
        select('2022', from: 'task_start_date_1i')
        select('2020', from: 'task_end_date_1i')
        click_on 'Create Task'
        expect(page).to have_content('Task Create Fail')
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content('Start date should not larger than end date')
      end
    end
  end

  describe 'edit task' do
    let(:task) { tasks(:pending_task) }

    it 'update task' do
      visit edit_task_path(task)
      select('Pending', from: 'Status')
      click_on 'Update Task'
      expect(page).to have_content('Task Update Success')
      expect(page).to have_content('pending')
    end

    context 'when update fail' do
      it 'shows alert and errors' do
        visit edit_task_path(task)
        fill_in 'Name', with: ''
        select('2022', from: 'task_start_date_1i')
        select('2020', from: 'task_end_date_1i')
        click_on 'Update Task'
        expect(page).to have_content('Task Update Fail')
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content('Start date should not larger than end date')
      end
    end
  end

  describe 'delete task', js: true do
    let(:task) { tasks(:pending_task) }
    it do
      visit task_path(task)
      page.accept_alert 'Do you really want to delete this task ?' do
        click_on('Delete')
      end
      expect(page).not_to have_content(task.name)
      expect(page).to have_content('Task Delete Success')
    end
  end
end
