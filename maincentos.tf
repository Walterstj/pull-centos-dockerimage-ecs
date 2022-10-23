resource "aws_ecs_cluster" "ecs" {
  name = "cluster"
}

resource "aws_ecs_cluster_capacity_providers" "ecs-cap" {
  cluster_name = aws_ecs_cluster.ecs.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

module "ecs-fargate" {
  source  = "umotif-public/ecs-fargate/aws"
  version = "~> 6.1.0"

  name_prefix        = "ecs-fargate"
  vpc_id             = aws_vpc.main.id
  private_subnet_ids = [aws_subnet.priv_sub1.id, aws_subnet.priv_sub2.id]

  cluster_id = aws_ecs_cluster.ecs.id

  task_container_image   = var.image //https://hub.docker.com/repository/docker/walterstj/centos
  task_definition_cpu    = 256
  task_definition_memory = 512

  task_container_port             = 80
  task_container_assign_public_ip = true

  load_balanced = false

  target_groups = [
    {
      target_group_name = "ecs-tg"
      container_port    = 80
    }
  ]

  health_check = {
    port = "traffic-port"
    path = "/"
  }
}
# Footer
# © 2022 GitHub, Inc.
# Footer navigation
# Terms
# Privacy
# Security
# Status