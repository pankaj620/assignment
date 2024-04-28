############CREATING A ECS CLUSTER#############

resource "aws_ecs_cluster" "cluster" {
  name = "jcluster"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}