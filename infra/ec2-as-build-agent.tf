# Terraform configuration to provision an EC2 instance and configure it as a Jenkins build agent
# EC2 instance resource


resource "aws_instance" "jenkins_build_agent" {
  ami                    = "ami-12345678"  # Update with desired AMI
  instance_type          = "t2.micro"      # Update with desired instance type
  subnet_id              = "subnet-084af0705c79cb79b"  
  //security_group_ids     = ["sg-02e8ccdf4912b25c1"],
  key_name               = "test-key-pair"  # Update with your SSH key pair name

  tags = {
    Name = "jenkins-build-agent"
  }

  
  connection {
    type        = "ssh"
    user        = "ec2-user"   # Update with appropriate SSH user
    private_key = file("~/.ssh/id_rsa")  # Update with your SSH private key
    host        = self.public_ip
  }

  # Provisioner to configure the EC2 instance as a Jenkins build agent
  provisioner "remote-exec" {
    inline = [
     
      "sudo yum install -y java-1.8.0-openjdk",
      "wget -O agent.jar https://jenkins_url/jnlpJars/agent.jar",  # Update with actual Jenkins URL
      "java -jar agent.jar -jnlpUrl https://jenkins_url/computer/${NODE_NAME}/slave-agent.jnlp -secret YOUR_SECRET_KEY"  # Update with actual Jenkins URL and secret key
    ]
  }
}


