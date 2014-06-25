require 'rails_helper'

describe Circle do
  context 'listings' do
    it 'ordered by constituted_at' do
      first_circle  = create(:circle, constituted_at: Date.today)
      second_circle = create(:circle, constituted_at: 1.day.ago)

      expect(Circle.first).to eq(first_circle)
    end

    it 'by recent (or not revised)' do
      create(:circle, :recent)
      create_list(:circle, 5, :revised)

      expect(Circle.recent.count).to be 1
    end

    it 'by revised' do
      create(:circle, :revised)
      create_list(:circle, 5, :recent)

      expect(Circle.revised.count).to be 1
    end

    it 'by kind group' do
      create(:circle, :group)
      create_list(:circle, 5, :page)

      expect(Circle.groups.count).to be 1
    end

    it 'by kind page' do
      create(:circle, :page)
      create_list(:circle, 5, :group)

      expect(Circle.pages.count).to be 1
    end

    it 'by kind user' do
      create(:circle, :user)
      create_list(:circle, 5, :page)

      expect(Circle.users.count).to be 1
    end
  end

end
