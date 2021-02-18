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
        expect(page).to have_content(task.start)
        expect(page).to have_content(task.end)
      end
    end
  end

  describe 'visit root' do
    it 'show all task' do
      visit tasks_path
      expect(page).to have_content(tasks(:pending_task).name)
      expect(page).to have_content(tasks(:progressing_task).name)
      expect(page).to have_content(tasks(:completed_task).name)
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
        select('2020', from: 'task_start_1i')
        select('Jun', from: 'task_start_2i')
        select('20', from: 'task_start_3i')
        select('2021', from: 'task_end_1i')
        select('July', from: 'task_end_2i')
        select('30', from: 'task_end_3i')
        click_on 'Create Task'

        expect(page).to have_content('Task Create Success')
        expect(page).to have_content('testing create')
        expect(page).to have_content('This is testing the creation of a new test')
        expect(page).to have_content('high')
        expect(page).to have_content('in progress')
        expect(page).to have_content('2020-06-20')
        expect(page).to have_content('2021-07-30')
      end
    end
  end

  describe 'edit task' do
    let(:task) { tasks(:pending_task) }
    it do
      visit edit_task_path(task)
      select('In Progress', from: 'Status')
      click_on 'Update Task'
      expect(page).to have_content('Task Update Success')
      expect(page).to have_content('in progress')
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
    end
  end
end
