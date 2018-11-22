require 'spec_helper'

describe HelenaAdministration::ApplicationHelper do
  describe '.title' do
    it 'sets content for :title' do
      helper.title 'test'
      expect(view.content_for(:title)).to eq 'test'
    end
  end

  describe '.truncate_between' do
    it 'truncates a string correctly' do
      output = helper.truncate_between 'abcdefghijklmnopqrstuvwxyz', 20
      expect(output).to eq 'abcdefghi...stuvwxyz'
    end
  end
end
