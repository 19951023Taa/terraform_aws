・amiの情報出力　※dataで常に最新のamiidの取り込みができる
aws ec2 describe-images --image-ids ami-030cf0a1edb8636ab

・keypeaの作成、登録
1. ssh-keygen -t rsa -b 2048 -f [terraform-aws-key]
2. 作成されたキーを適当なキーフォルダに移動して、pemキーの拡張子を.pemに変更
3. terraformでaws_key_pairにて、pubファイルを取り込んで、接続にはpemを使用