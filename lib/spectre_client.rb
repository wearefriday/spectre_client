require "spectre_client/version"
require "rest_client"

module SpectreClient
  class Client
    def initialize(project_name, suite_name, url_base)
      @url_base = url_base
      request = RestClient::Request.execute(
        method: :post,
        url: "#{@url_base}/runs",
        timeout: 120,
        payload: {
          project: project_name,
          suite: suite_name
        }
      )
      response = JSON.parse(request.to_str)
      @run_id = response['id']
    end

    def submit_test(name, browser, platform, width, screenshot)
      request = RestClient::Request.execute(
        method: :post,
        url: "#{@url_base}/tests",
        timeout: 120,
        :multipart: true,
        payload: {
          test: {
            run_id: @run_id,
            name: name,
            platform: platform,
            browser: browser,
            width: width,
            screenshot: screenshot
          }
        }
      )
      JSON.parse(request.to_str, symbolize_names:true)
    end
  end
end
