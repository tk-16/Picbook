require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @book = FactoryBot.build(:book)
    @book.image = fixture_file_upload("/files/test_image.png")
  end

  describe '投稿の保存' do
    context "投稿できる場合" do
      it "image,title,story,impressionがあれば投稿できる" do
        expect(@book).to be_valid
      end

    end
    context "投稿できない場合" do
      it "imageが空では投稿できない" do
        @book.image = nil
        @book.valid?
        expect(@book.errors.full_messages).to include("Image can't be blank")
      end   
      
      it "titleが空では投稿できない" do
        @book.title = ""
        @book.valid?
        expect(@book.errors.full_messages).to include("Title can't be blank")
      end  
      it "storyが空では投稿できない" do
        @book.story = ""
        @book.valid?
        expect(@book.errors.full_messages).to include("Story can't be blank")
      end  
      it "impressionが空では投稿できない" do
        @book.impression = ""
        @book.valid?
        expect(@book.errors.full_messages).to include("Impression can't be blank")
      end  

      it "ユーザーが紐付いていなければ投稿できない" do
        @book.user = nil
        @book.valid?
        expect(@book.errors.full_messages).to include("User must exist")
      end
    end
  end
end
