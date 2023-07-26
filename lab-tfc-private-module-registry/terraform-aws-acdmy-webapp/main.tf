resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "${var.prefix}-${var.name}"

  force_destroy = true
}

resource "aws_s3_bucket_website_configuration" "bucket" {
  depends_on = [aws_s3_bucket_public_access_block.bucket]

  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_ownership_controls" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  depends_on = [aws_s3_bucket_public_access_block.bucket]

  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}

resource "aws_s3_object" "webapp" {
  depends_on = [aws_s3_bucket_public_access_block.bucket]

  acl    = "public-read"
  key    = "index.html"
  bucket = aws_s3_bucket.bucket.id
  content = templatefile("${path.module}/templates/index.tpl", {
    public_key = var.public_key
  })
  content_type = "text/html"
}
