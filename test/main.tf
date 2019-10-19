provider "aws" {
	region = "us-east-1"
	alias = "virginia"
}

provider "aws" {
	region = "ap-southeast-1"
	alias = "sing"
}

resource "aws_security_group" "frontend_security" {
	provider    = "aws.virginia"
	name        = "fronend_sec"
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
		Name = "frontend_sec_group"
	}
}
