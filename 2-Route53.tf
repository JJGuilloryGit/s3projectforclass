resource "aws_route53_zone" "example" {
  name = var.domainName
}

resource "aws_route53_record" "exampleDomain-a" {
  zone_id = aws_route53_zone.example.zone_id
  name    = var.domainName
  type    = "A"
  alias {
    name                   = aws_s3_bucket.bucket.website_endpoint
    zone_id                = aws_s3_bucket.bucket.hosted_zone_id
    evaluate_target_health = true
  }
}