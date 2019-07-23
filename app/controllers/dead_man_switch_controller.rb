class DeadManSwitchController < ApplicationController

  def create
    convert_time(switch_params)
    @user = current_user
    @dead_man_switch = DeadManSwitch.find_or_create_by(user_id: @user.id)
    @dead_man_switch.update(interval_in_seconds: @length_of_time_for_switch)
    flash[:message] = "Your Dead Man Switch has been created and will expire on #{expiration_date}."
    redirect_to dashboard_path
  end

  def update
    @user = current_user
    @user.dead_man_switch.touch
    @user.dead_man_switch.one_day_message_sent = false
    @user.dead_man_switch.one_hour_message_sent = false
    flash[:message] = "Your timer has been reset and will expire on #{expiration_date}."
    redirect_to dashboard_path
  end

  private

  def convert_time(switch_params)
    interval_type = switch_params[:interval]
    time = switch_params[:quantity].to_i
    if
      interval_type == "Days"
      @length_of_time_for_switch = time.days.seconds.to_i
    elsif
      interval_type == "Months"
      @length_of_time_for_switch = time.months.seconds.to_i
    elsif
      interval_type == "Years"
      @length_of_time_for_switch = time.years.seconds.to_i
    end
    return @length_of_time_for_switch
  end

  def expiration_date
    date = @user.dead_man_switch.updated_at + @user.dead_man_switch.interval_in_seconds
    formatted_date = date.strftime('%B %-d, %Y at %l:%M:%S')
  end

  def switch_params
    params.permit(:interval, :quantity)
  end
end