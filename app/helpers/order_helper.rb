module OrderHelper
  def get_coordinated_for_x(x)
    ["150", "222", "306", "387", "150"][x.to_i - 1]
  end

  def get_coordinated_for_y(y)
    y == 5 ? "285" : "295"
  end

  def link_to_status(status, title, image_name, options={})
    case status
    when false then image_tag(image_name, :title => title)
    when true  then
      if (title=='Enviar solicitud' or title=="Aprobar" or title=="Cambiar divisa" )
        link_to_remote(image_tag(image_name, :title => title), options) 
      else 
        link_to(image_tag(image_name, :title => title), options) 
      end
    end
  end

  def activate_links(controller_name, status)
    if controller_name == "estimates"
      case status
      when "cotización_no_enviada" : [true, true, true]
      when "cotización_en_progreso" : []
      else [false, false, false]
      end
    elsif controller_name == "orders" 
      case status
      when "solicitud_no_enviada" : [true, true, true, true, true]
      when "cotización_en_progreso" : [true, true, false, false, false]
      else [false, false, true, true, false]
      end
    elsif controller_name == "budget/orders" 
      case status
      when "presupuesto_en_progreso" : [true, false, false, true, true, true, true, true]
      else [false, false, false, false, false, false, true, true]
      end
    elsif controller_name == "acquisition/orders" 
      case status
      when "adquisición_en_progreso" : [true, false, true, true, false]
      else [false, false, true, true, false]
      end
    end
  end

  def set_row_class(object)
  	'row_' + ((object + 1) % 2).to_s
  end
  
  def status_image_tag(record)
    image_tag("status_"+record.current_status.downcase.split(/\s+/).join('_')+".jpg")
  end
end
