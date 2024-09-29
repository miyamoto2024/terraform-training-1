## 前提
1. GCPに登録済み
2. GCPにterraform用のサービスアカウント作成済み
3. サービスアカウントの鍵(auth.json)をCloudStorageにアップロード済み 
4. Terraform Cloudに登録済み

※手順 3. の鍵については[こちら](https://qiita.com/donko_/items/6289bb31fecfce2cda79#%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%A2%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%88%E3%81%AE%E4%BD%9C%E6%88%90%E6%96%B9%E6%B3%95%E3%81%A8json%E3%81%AE%E5%85%A5%E6%89%8B%E6%96%B9%E6%B3%95%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A61)を参照

## コンテナ
* build
``` bash
docker build -t terraform-training \
--build-arg GITHUB_USER_NAME="user.name" \
--build-arg GITHUB_USER_EMAIL="user.email" \
--build-arg GITHUB_USER_TOKEN="github_token" \
--no-cache .
```

* run
``` bash
docker run -itd --privileged --rm \
--name terraform-training \
--hostname terraform-training \
terraform-training
```

* login
``` bash
docker exec -it terraform-training /bin/bash
```

## gcloud
* set config
``` bash
gcloud config configurations create <任意>
gcloud config set core/account <Google Cloudのログインに使ったメアド>
gcloud config set core/project <Google CloudのプロジェクトID>
```

* auth login
``` bash
gcloud auth login
gcloud auth application-default login
```

* auth.json download
``` bash
gcloud storage ls
gcloud storage cp gs://<BUCKET_NAME>/<OBJECT_NAME> ./auth.json
```
※詳細については[こちら](https://zenn.dev/waddy/articles/terraform-google-cloud)を参照

## Terraform cloud
* set config
``` bash
echo 'export TF_TOKEN_app_terraform_io="<TERRAFORM_TOKEN_VALUE>"' >> ~/.bash_profile
source ~/.bash_profile
```
詳細について[こちら](https://developer.hashicorp.com/terraform/cli/config/config-file)を参照

* register terraform key(Optional post-deployment option)
``` bash
gcloud secrets list
printf "<TERRAFORM_TOKEN_VALUE>" | gcloud secrets versions add terraform-api-key --data-file=-
```
