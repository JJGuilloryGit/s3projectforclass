######Creation of Bucket########

resource "aws_s3_bucket" "bucket" {
  bucket = "s3bucketforclass-uv"
}


####Website Config#######

resource "aws_s3_bucket_website_configuration" "www" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

######Owner Controls##########

resource "aws_s3_bucket_ownership_controls" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

######Objects for Bucket##########


resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "Iza.jpeg"
  source = "C:/Users/jjgui/Documents/s3/s3projectforclass/Iza.jpeg"
  acl    = "public-read"
}

resource "aws_s3_bucket_object" "file" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"
  source = "C:/Users/jjgui/Documents/s3/s3projectforclass1/s3class-main/index.html"
  acl    = "public-read"
}

######Bucket Policy#########


resource "aws_s3_bucket_policy" "my_bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.bucket.arn}/*"
        ]
      },
    ]
  })
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "policy_id" {
  value = aws_s3_bucket_policy.my_bucket_policy.id
}