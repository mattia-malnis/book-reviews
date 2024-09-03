module BooksHelper
  def book_image(book, classes = "")
    return unless book.image.attached?

    image_tag book.image.variant(:small),
              class: classes,
              alt: book.title,
              loading: "lazy"
  end
end
