require 'rails_helper'

describe 'View builds history in two charts on main page', type: :feature, js: true do
  before do
    visit root_path
  end

  it 'should render at least header and footer' do
    expect(page).to have_content('Data visualizer')
    expect(page).to have_link('Max Malinovsky')
  end

  it 'should hide "Loading..." gif when data the charts were built' do
    expect(page).to have_no_css('img#loading-image', wait: 5)
  end

  it 'should display two charts' do
    # chart header
    expect(page).to have_content('Passing and failing builds per day')
    # vAxis label
    expect(page).to have_content('Number of builds')
    # chart header
    expect(page).to have_content('Build duration vs. time')
    # hAxis label
    expect(page).to have_content('Session id')
  end

  it 'should display warning message and should not display charts when history file is empty' do
    Api::V1::HistoryController::CSV_FILE = Rails.root.join('spec', 'support', 'empty_file.csv')
    visit root_path
    expect(page).to have_content('There is no data to display')
    expect(page).to have_no_content('Passing and failing builds per day')
    expect(page).to have_no_content('Build duration vs. time')
    Api::V1::HistoryController::CSV_FILE = Rails.root.join('data', 'session_history.csv')
  end

  it 'should display error message and should not display charts when history file not found' do
    Api::V1::HistoryController::CSV_FILE = Rails.root.join('data', 'missing_file.csv')
    visit root_path
    expect(page).to have_content('Sorry, but an error occurred: Internal Server Error')
    expect(page).to have_no_content('Passing and failing builds per day')
    expect(page).to have_no_content('Build duration vs. time')
    Api::V1::HistoryController::CSV_FILE = Rails.root.join('data', 'session_history.csv')
  end

  # except /api/history
  it 'should redirect to main page from (almost) every other page' do
    visit '/wrong_page'
    expect(page.current_path).to eq root_path
  end

  it 'should be able to show/hide any line of passing/failing chart' do
    # blue "stopped rect"
    selector = 'body > div > div > div > div:nth-child(2) > div.well.ng-scope > div:nth-child(2) > div > div:nth-child(1) > div > svg > g:nth-child(3) > g:nth-child(3) > rect:nth-child(3)'
    elem = page.find(selector)
    expect(elem.native.style('fill')).to eq('rgb(0, 89, 255)')
    elem.click
    # we need to re-find element, just trust me, i am an engineer :)
    elem = page.find(selector)
    expect(elem.native.style('fill')).to eq('rgb(204, 204, 204)')
  end

end
