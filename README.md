・amiの情報出力　※dataで常に最新のamiidの取り込みができる
aws ec2 describe-images --image-ids ami-030cf0a1edb8636ab

・keypeaの作成、登録
1. ssh-keygen -t rsa -b 2048 -f [terraform-aws-key]
2. 作成されたキーを適当なキーフォルダに移動して、pemキーの拡張子を.pemに変更
3. terraformでaws_key_pairにて、pubファイルを取り込んで、接続にはpemを使用


gpg key
1. gpg -o master.public.gpg --export master ※gpg公開鍵の作成
2. resource "aws_iam_user_login_profile"側で作成したキーを指定(filebase64で読み込む)
3. outputさせる  value = aws_iam_user_login_profile.this.encrypted_password
4. outputさせたファイルを適当なファイルに保存する
5. cat [userpass.txt] | base64 -d | gpg -r master --decrypt