resource "aws_ecs_task_definition" "task" {
  family                   = "jservice"
  network_mode             = "awsvpc"
  task_role_arn       = "arn:aws:iam::637423526018:role/ecstaskexecution"
  requires_compatibilities = ["FARGATE", "EC2"]
  cpu                      = 512
  memory                   = 2048
  container_definitions    = <<DEFINITION
  [
    {
      "name"      : "jenkins-container",
      "image"     : "jenkins/jenkins",
      "cpu"       : 512,
      "memory"    : 2048,
      "essential" : true,
      "portMappings" : [
        {
          "containerPort" : 8080,
          "hostPort"      : 8080
        }
      ],
      "mountPoints": [
        {
          "sourceVolume": "jenkins-efs",
          "containerPath": "/var/jenkins_home"
        }
      ]
    }
  ]
  DEFINITION
 volume {
    name = "jenkins-efs"

    efs_volume_configuration {
      file_system_id          = "fs-03817d4e0d0308a19"
      root_directory          = "/"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 12345
    }
  }
}