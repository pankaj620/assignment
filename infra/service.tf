resource "aws_ecs_service" "service" {
  name             = "jservice"
  cluster          = aws_ecs_cluster.cluster.id
  task_definition  = aws_ecs_task_definition.task.id
  launch_type      = "FARGATE"
  platform_version = "LATEST"
  enable_execute_command=true

  network_configuration {
    assign_public_ip = true
    security_groups  = ["sg-02e8ccdf4912b25c1","sg-08aa5d12e67394666","sg-02597fc27eb245906"]
    subnets          = ["subnet-084af0705c79cb79b","subnet-0a3093c306ee8816a","subnet-07f5e5c744da93cb6"]
  }

load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "jenkins-container"
    container_port   = 8080
}  

}