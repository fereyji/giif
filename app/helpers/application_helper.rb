
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
    def logged_user
      # This method depends on initialized user session, if it doesn't exist, It doesn't work
      User.find(session[:user]).login
    end

    def simple_select(object_name, model_name, id=nil)
      field_name = ActiveSupport::Inflector.foreign_key(model_name)
      if model_name.to_s == "Currency"
        select(object_name, field_name, model_name.find(:all, :conditions => ["id<=?", 6], :order => 'id').collect { |record| [record.name, record.id] }, :prompt => '--Seleccionar--', :selected => id)
      else
        select(object_name, field_name, model_name.find(:all, :order => 'id').collect { |record| [record.name, record.id] }, :prompt => '--Seleccionar--', :selected => id)
      end
    end

end



