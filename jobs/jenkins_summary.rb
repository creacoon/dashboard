require './lib/jenkins_client'

JENKINS_SUMMARY_HOST     = ENV.fetch('JENKINS_SUMMARY_HOST')
JENKINS_SUMMARY_USERNAME = ENV.fetch('JENKINS_SUMMARY_USERNAME')
JENKINS_SUMMARY_TOKEN    = ENV.fetch('JENKINS_SUMMARY_TOKEN')
JENKINS_SUMMARY_VIEW     = ENV.fetch('JENKINS_SUMMARY_VIEW', 'All')

SCHEDULER.every '10s', first_in: 0 do
  jenkins = JenkinsClient.new(JENKINS_SUMMARY_HOST, JENKINS_SUMMARY_USERNAME, JENKINS_SUMMARY_TOKEN)
  jobs = jenkins.get_jobs(view: JENKINS_SUMMARY_VIEW)

  failing_jobs = -> (j) { j['color'] == 'red' }

  red_jobs_names   = jobs.select(&failing_jobs).map {|j| j['name'] }
  green_jobs_count = jobs.reject(&failing_jobs).size

  send_event('jenkins-summary', {
    red: red_jobs_names,
    green: green_jobs_count
  })
end
