class StaticPagesController < ApplicationController
  def about
  end

  def privacy
  end

  def terms
  end

  def fallback_index_html
    render file: Rails.public_path.join('index.html'), layout: false
  end
end 