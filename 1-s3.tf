######Creation of Bucket########

resource "aws_s3_bucket" "example" {
  bucket = "s3bucketforclass-uv"
}

########Bucket Policy#########
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.example.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {


}

######Owner Controls##########

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.example.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.example.id
  acl    = "public-read"
}

######Object for Bucket##########


resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.example.id
  key    = "Iza.jpeg"
  source = "C:/Users/jjgui/Documents/s3/s3projectforclass/Iza.jpeg"
  acl    = "public-read"
}

