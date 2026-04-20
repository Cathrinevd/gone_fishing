class PagesController < ApplicationController
  def show
    @page = Page.find_by("lower(trim(title)) = ?", params[:title].downcase.strip)

    return unless @page.nil?

    redirect_to root_path, alert: "Page not found."
  end
end
