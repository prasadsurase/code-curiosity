class RescoreMailer < ApplicationMailer
  default from: 'info@codecuriosity.org'

  def notify_judge(resource_type, resource_id, judge_email)
    @resource = resource_type.constantize.find(resource_id)
    mail(to: judge_email, subject: "Request for rescore for #{resource_type} with id #{resource_id}")
  end
end
