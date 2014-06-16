module PagesHelper
  def facebook_page_url(page)
    "https://www.facebook.com/pages/anything/#{page.fb_page_id}"
  end
end
