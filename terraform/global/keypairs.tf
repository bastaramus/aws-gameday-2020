###
#------------ Key Pairs ------------ 
###

resource "aws_key_pair" "ssh_auth" {
  key_name   = "devx_auth"
  public_key = file("keys/id_rsa_gameday.pub")
}