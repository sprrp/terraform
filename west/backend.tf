terraform {
  backend "s3" {
    bucket = "surendrawest"
    key    = "petclinic/dev/tf.state"
    region = "us-west-1"
  }
}
