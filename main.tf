provider "aws" {
	region = "us-east-1"
	alias = "virginia"
}

provider "aws" {
	region = "ap-southeast-1"
	alias = "sing"
}

resource "aws_instance" "frontend" {
	provider 	= "aws.virginia"
	count 		= 1	
	ami 		= "ami-00eb20669e0990cb4"
	instance_type 	= "t2.micro"
	key_name 	= "cfn-key-1"
        disable_api_termination = false
	security_groups = [ "frontend_sec" ]
	depends_on 	= [ "aws_security_group.frontend_security"]
	user_data       = "${file("init.sh")}"
#			   #! /bin/bash -x
#        		   sudo yum install -y nginx
#        		   sudo service nginx start
#        		   sudo chkconfig nginx on
#                          echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
#       		   EOF
	tags {
		Name 	   = "tf-frontend-1"
		App 	   = "devops-demo"
        	Maintainer = "Eswar"
	}
	lifecycle {
		prevent_destroy = false
	}
}

resource "aws_security_group" "frontend_security" {
	provider    = "aws.virginia"
	name        = "frontend_sec"
	description = "Allow traffic over port 80"

  	ingress {
    		from_port   = 80
    		to_port     = 80
    		protocol    = "tcp"
    		cidr_blocks = [ "0.0.0.0/0" ]
    	#	description = "allow http on the server"
  	}
  	egress {
    		from_port   = 0
    		to_port     = 0
    		protocol    = "-1"
    		cidr_blocks = [ "0.0.0.0/0" ]
  	}
	tags {
		Name = "frontend_sec"
	}	
}
