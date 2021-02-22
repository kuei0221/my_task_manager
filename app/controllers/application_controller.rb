class ApplicationController < ActionController::Base
  include ApplicationHelper
  rescue_from StandardError, with: :standard_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def not_found
    @error = error_detail.merge(
      {
        status: 404,
        message: "The page you were looking for doesn't exist"
      }
    )
    render 'layouts/error'
  end

  def internal_error
    @error = error_detail.merge(
      {
        status: 500,
        message: "We're sorry, but something went wrong"
      }
    )
    render 'layouts/error'
  end

  private

  def record_not_found(exception)
    @error = rescue_error_detail(exception).merge({ status: 404 })
    render 'layouts/error'
  end

  def standard_error(exception)
    @error = rescue_error_detail(exception).merge({ status: 500 })
    render 'layouts/error'
  end

  def error_detail
    {
      params: params.inspect,
      request: request.inspect
    }
  end

  def rescue_error_detail(exception)
    error_detail.merge(
      {
        exception: exception.inspect,
        backtrace: exception.backtrace.take(10)
      }
    )
  end

  def authenticate_user
    redirect_to login_path, notice: 'please login first' unless current_user
  end
end
