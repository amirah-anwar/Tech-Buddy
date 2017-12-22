module ApplicationHelper

	def flash_class(name)
    {
      "notice"  => "alert alert-info",
      "success" => "alert alert-success",
      "error"   => "alert alert-danger",
      "alert"   => "alert alert-danger",
    }[name]
	 end

end
