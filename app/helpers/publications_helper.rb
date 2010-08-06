module PublicationsHelper
  def get_category_image(publication)
    return "archivo-type.gif" if publication.category == 2
    "mensaje-type.gif"
  end
  
  def get_category_name(publication)
    return "archivo" if publication.category == 2
    "mensaje"
  end
end
