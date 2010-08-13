module PublicationsHelper
  def get_category_image(publication)
    return "archivo-type.gif" if publication.category == 1
    "mensaje-type.gif"
  end
  
  def get_category_name(publication)
    return "archivo" if publication.category == 0
    "mensaje"
  end
end
