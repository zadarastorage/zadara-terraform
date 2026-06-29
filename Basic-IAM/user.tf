resource "aws_iam_user" "user1" {
  name = var.username
}

resource "aws_iam_access_key" "user1key" {
  user    = aws_iam_user.user1.name
}

output "secret" {
  value = aws_iam_access_key.user1key.encrypted_secret
}