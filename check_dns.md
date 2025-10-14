# DNSレコード確認方法

## DNSレコードの反映状況確認

### 1. SPFレコードの確認
```bash
nslookup -type=TXT xn--v8jc9fuf1610a.com
```

### 2. DMARCレコードの確認
```bash
nslookup -type=TXT _dmarc.xn--v8jc9fuf1610a.com
```

### 3. オンラインツールでの確認
- [MXToolbox SPF Checker](https://mxtoolbox.com/spf.aspx)
- [DMARC Analyzer](https://dmarc.postmarkapp.com/)

## 期待される結果

### SPFレコード
```
v=spf1 include:_spf.google.com ~all
```

### DMARCレコード
```
v=DMARC1; p=quarantine; rua=mailto:admin@xn--v8jc9fuf1610a.com
```

## 反映時間
- 通常: 24-48時間
- 最大: 72時間

## 確認後の対応
DNSレコードが反映されたら、メール機能をテストしてください。
