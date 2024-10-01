module "catalogue_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = data.aws_ami.devops_ami.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.catalogue_sg_id.value]

  #it should be provision in DB subnet 
  subnet_id = element(split(",",data.aws_ssm_parameter.private_subnet_ids.value), 0)
  //user_data = file("catalogue.sh")
  
  #the below is optional if we dont give this will be provisioned inside default subnet
  #subnet_id = local.public_subnet_ids[0] # public subnet in default vpc

  tags = merge(
    {
        Name = "Catalogue-Dev-AMI"
    },
    var.common_tags
  )
}

resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.catalogue_instance.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case


  connection {
    type = "ssh"
    user = "centos"
    password = "DevOps321"
    host = module.catalogue_instance.private_ip
    
  }

  provisioner "file" {
    source = "catalogue.sh"
    destination = "/tmp/catalogue.sh"

    
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/catalogue.sh" , 
      "sudo sh /tmp/catalogue.sh ${var.app_version}"
      

    ]
  }
}

#stopping instance to take AMI 

resource "aws_ec2_instance_state" "test" {
  instance_id = module.catalogue_instance.id
  state       = "stopped"
}

#to take ami

resource "aws_ami_from_instance" "catalogue_ami" {
  name               = "${var.common_tags.Component}-${local.current_time}"
  source_instance_id = module.catalogue_instance.id
}

# to terminate the instance after taking the ami of that instance using null resources 

resource "null_resource" "delete_instance" {
 
  triggers = {
    ami_id = aws_ami_from_instance.catalogue_ami.id
  }


  provisioner "local-exec" {

    command = "aws ec2 terminate-instances --instance-ids ${module.catalogue_instance.id}"
  }
}

output "app_version" {
  value = var.app_version
  
}