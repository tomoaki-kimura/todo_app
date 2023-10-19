module TasksHelper
  def colord_button(task)
    case task.status.to_sym
    when :not_started
      "btn-danger"
    when :in_progress
      "btn-warning"
    when :closed
      "btn-primary"
    end
  end
end
