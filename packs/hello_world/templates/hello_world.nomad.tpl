job [[ template "job_name" . ]] {
  [[ template "region" . ]]
  datacenters = [[ .hello_world.datacenters | toPrettyJson ]]
  type = "sysbatch"

  periodic {
    cron = "@daily"
  }

  group "app" {
    count = [[ .hello_world.count ]]

    network {
      port "http" {
        to = 8000
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "server" {
      driver = "docker"

      config {
        image = "mnomitch/hello_world_server"
        ports = ["http"]
      }

      env {
        MESSAGE = [[.hello_world.message | quote]]
      }
    }
  }
}
