module BooksHelper
  def book_image(book, classes = "")
    return unless book.image.attached?

    image_tag book.image.variant(:small),
              class: classes,
              alt: book.title,
              loading: "lazy"
  end

  def render_stars(rating, max_stars = 5)
    full_stars = [ inline_svg_tag("star.svg", class: "size-4") * rating ]
    empty_stars = [ inline_svg_tag("star-outline.svg", class: "size-4") * (max_stars - rating) ]

    content_tag :span, class: "flex" do
      safe_join(full_stars + empty_stars)
    end
  end

  def reviews_average(reviews)
    return if reviews.blank?

    average = reviews.average(:rating)
    content_tag :div, class: "flex items-center text-sm text-gray-500 mb-2" do
      concat(inline_svg_tag("star.svg", class: "size-5 text-yellow-500 mr-1"))
      concat("#{average} / 5")
    end
  end
end
