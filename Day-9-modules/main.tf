module "test" {
    source = "../Day-2-EC2-Creation" #source will be clone from Day-2 folder
    ami_id = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.medium"
  
}