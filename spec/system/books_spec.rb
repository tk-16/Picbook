require 'rails_helper'

RSpec.describe '絵本投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.create(:book)
    @book_title = Faker::Lorem.sentence
    @book_story = Faker::Lorem.sentence
    @book_impression = Faker::Lorem.sentence
    @book.image = fixture_file_upload("/files/test_image.png")
  end

  context '投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      sign_in(@user)
      # 新規投稿ページへのリンクがある
      expect(page).to have_content('新規投稿')
      # 投稿ページに移動する
      visit new_book_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('book[image]',image_path,make_visible: true)
      fill_in 'Title', with: @book_title
      fill_in 'Story', with: @book_story
      fill_in 'Impression', with: @book_impression
      # 送信するとBookモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { Book.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容が存在する
      expect(page).to have_selector("img[src$='test_image.png']")
      expect(page).to have_content(@book_title)
      expect(page).to have_content(@book_story)
      expect(page).to have_content(@book_impression)
    end
  end
  context '絵本投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('新規投稿')
    end
  end
end

RSpec.describe '投稿編集', type: :system do
  before do
    @book1 = FactoryBot.create(:book)
    @book2 = FactoryBot.create(:book)
  end
  context '投稿編集ができるとき' do
    it 'ログインしたユーザーは自分の投稿を編集できる' do
      # book1を投稿したユーザーでログインする
      sign_in(@book1.user)
      # book1に「編集」ボタンがある
       expect(
      all(".cp_navi")[0]
    ).to have_link '編集', href: edit_book_path(@book1)
      # 編集ページへ遷移する
      visit edit_book_path(@book1)
      # すでに投稿済みの内容がフォームに入っている
      expect(
        find('#book_title').value
      ).to eq @book1.title
      expect(
        find('#book_story').value
      ).to eq @book1.story
      expect(
        find('#book_impression').value
      ).to eq @book1.impression
      # 投稿内容を編集する
      image_path = Rails.root.join('public/images/test_image2.jpg')
      attach_file('book[image]',image_path,make_visible: true)
      fill_in 'Title', with: "#{@book1.title}+編集したタイトル"
      fill_in 'Story', with: "#{@book1.story}+編集したストーリー"
      fill_in 'Impression', with: "#{@book1.impression}+編集した感想"

      # 編集してもBookモデルのカウントは変わらない
      expect{
        find('input[name="commit"]').click
      }.to change { Book.count }.by(0)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど変更した内容の投稿が存在する
      expect(page).to have_selector("img[src$='test_image2.jpg']")
      expect(page).to have_content("#{@book1.title}+編集したタイトル")
      expect(page).to have_content("#{@book1.story}+編集したストーリー")
      expect(page).to have_content("#{@book1.impression}+編集した感想")
    end
  end

  context '投稿編集ができないとき' do
    it 'ログインしたユーザーは自分以外の投稿の編集画面には遷移できない' do
      # book1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @book1.user.email
      fill_in 'Password', with: @book1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # book2に「編集」ボタンがない
      expect(
        all(".cp_navi")[1]
      ).to have_no_link '編集', href: edit_book_path(@book2)
    end
    it 'ログインしていないと投稿の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # book1に「編集」ボタンがない
      expect(
      all(".cp_navi")[0]
    ).to have_no_link '編集', href: edit_book_path(@book1)
      # book2に「編集」ボタンがない
      expect(
      all(".cp_navi")[1]
    ).to have_no_link '編集', href: edit_book_path(@book2)
    end
  end
end

RSpec.describe '投稿削除', type: :system do
  before do
    @book1 = FactoryBot.create(:book)
    @book2 = FactoryBot.create(:book)
  end
  context '投稿削除ができるとき' do
    it 'ログインしたユーザーは自らの投稿を削除ができる' do
      # book1を投稿したユーザーでログインする
      sign_in(@book1.user)
      # book1に「削除」ボタンがある
      expect(
        all(".cp_navi")[0]
      ).to have_link '削除', href: book_path(@book1)
  
      # 投稿を削除するとレコードの数が1減る
      expect{
        all(".cp_navi")[0].find_link('削除', href: book_path(@book1)).click
      }.to change { Book.count }.by(-1)
      # トップページに遷移する
      visit root_path
      # トップページにはbook1の内容が存在しない
      expect(page).to have_no_selector("img[src$='test_image2.jpg']")
      expect(page).to have_no_content(@book1.title)
      expect(page).to have_no_content(@book1.story)
      expect(page).to have_no_content(@book1.impression)
    end
  end
  context '投稿削除ができないとき' do
    it 'ログインしたユーザーは自分以外の投稿を削除ができない' do
      # book1を投稿したユーザーでログインする
      sign_in(@book1.user)
      # book2に「削除」ボタンが無い
      expect(
          all("cp_navi")[0]
        ).to have_no_link '削除', href: book_path(@book2)
    end
    it 'ログインしていないと投稿の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # book1に「削除」ボタンが無い
       expect(
          all(".cp_navi")[1]
        ).to have_no_link '削除', href: book_path(@book1)
      # book2に「削除」ボタンが無い
       expect(
          all(".cp_navi")[0]
        ).to have_no_link '削除', href: book_path(@book2)
    end
  end
end

RSpec.describe '投稿詳細', type: :system do
  before do
    @book = FactoryBot.create(:book)
  end
  it 'ログインしたユーザーは投稿詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    sign_in(@book.user)
    # 投稿に詳細ページに遷移するボタンがある
    expect(
        all(".card-title")[0]
      ).to have_link @book.title, href: book_path(@book)
    # 詳細ページに遷移する
    visit book_path(@book)
    # 詳細ページに投稿の内容が含まれている
    expect(page).to have_selector("img[src$='test_image.png']")
    expect(page).to have_content(@book.title)
    expect(page).to have_content(@book.story)
    expect(page).to have_content(@book.impression)

    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態で詳細ページに遷移できるもののコメント投稿欄が表示されない' do
    # トップページに移動する
    visit root_path
    # 投稿に詳細ページに遷移するボタンがある
    expect(
        all(".card-title")[0]
      ).to have_link @book.title, href: book_path(@book)
    # 詳細ページに遷移する
    visit book_path(@book)
    # 詳細ページに投稿の内容が含まれている
    expect(page).to have_selector("img[src$='test_image.png']")
    expect(page).to have_content(@book.title)
    expect(page).to have_content(@book.story)
    expect(page).to have_content(@book.impression)

    # フォームが存在しないことを確認する
    expect(page).to have_no_selector 'form'
    # 「コメントの投稿には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content('コメントの投稿には新規登録/ログインが必要です')
  end
end