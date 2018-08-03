class GetProject < BaseIntent
  private
  def set_response
    count = Project.count
    @response = "Currently we have #{count} projects"
  end

end
