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