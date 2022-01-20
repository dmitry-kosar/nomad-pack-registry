job [[ template "job_name" . ]] {
  type = "sysbatch"

  group "app" {
    count = 1

    periodic {
      cron = "@daily"
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
