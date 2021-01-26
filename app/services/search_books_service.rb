class SearchBooksService
  def self.search(search)
    if search != ""
      Book.where('title LIKE(?)', "%#{search}%")
    else
      Book.all
    end
  end
end