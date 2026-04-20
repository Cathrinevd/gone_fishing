class PagesController < ApplicationController
  def show
    @page = Page.find_by(title: params[:title])

    return unless @page.nil?

    redirect_to root_path, alert: "Page not found."
  end
end
