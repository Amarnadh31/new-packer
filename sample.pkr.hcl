variable "ami_id" {
    type = string
    default = "ami-0583d8c7a9c35822c"
}

variable "app_name" {
    type = string
    default = "httpd"
}

locals{
    app_name = "httpd"
}

source "amazon-ebs" "httpd" {
    ami_name = "packer-demo-${local.app_name}"
    instance_type = "t2.micro"
    region = "us-east-1"
    source_ami = "${var.ami_id}"
    ssh_username = "ec2-user"
    # ssh_key_path = "/c/Users/amarn/Downloads/packer.pem"
    # ssh_interface = "public_ip"
    tags ={
        Env = "dev"
        Name = "packer-demo-${local.app_name}"
    }
}

build {
    sources = ["source.amazon-ebs.httpd"]

    provisioner "shell"{
        script = "script.sh"
    }

    post-processor "shell-local"{
        inline = ["echo scipt completed"]
    }
}