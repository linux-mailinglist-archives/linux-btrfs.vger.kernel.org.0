Return-Path: <linux-btrfs+bounces-13456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 066E4A9E72F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 06:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F807A8CD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 04:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234E3199FBA;
	Mon, 28 Apr 2025 04:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZycZ57b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1B0481C4
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745815604; cv=none; b=TbIuzSUt1gqQfwH+XMf3iU8HZDLSNcWOqU273rIGczfZ4SpRXGrukWsEzuCGwqpi8PShwrogHA7EmAqKNPsoTzcjKSAg5+YQmdEQGF8Q3taWFyDHvrHAnc6THtWSS+U4QZq38WiyyFq/VPXLvZaTKmVyxMN1HaRC3z9QGrtmQ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745815604; c=relaxed/simple;
	bh=cuwfzC5Ws1IdcDomwyM5HdirQykm/3dwlV+88nyWPXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t/4+VpEL/pvKYwZG9MpbgNOlR2ckgAZGJkQXZCL+wrYf1vKBPBuLNgpLvjmpKifdmjlPscGmGuT+A6aZhD4pNi5mnp4oLMYODWQX9EhtDz7OcYse1K4xzSJym/d9xxiNoBuvJX5XsFevDZvQoyOnetBAe4+4s+6hU5MttK76/6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZycZ57b; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301918a4e3bso4932678a91.3
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Apr 2025 21:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745815599; x=1746420399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dOHHnBO+zKL6LHtF6+7WU+ADvROfthuwM6WXeWBkTnE=;
        b=OZycZ57bScn2Dompb1T84A5QB76EXl2AZUNz+3d2+H7SroEp7yVsrQq9zw4hSCFT0k
         s/h0EBo2Ynenesfigj4G4KGebVElHZWw2LLYJFcc90T0bXFRnI2FCPOWGmUcfefxC1Wc
         FwNNjZ5LvP6MUqRB/wLY7v4Sydy+AT9Edkm+cDQEnikhbeu4xwTlPRevQzFiHQNw7ZOy
         BFvF1a3dPfxpFIjkP/No1T+sQeRkX9iPq1Zad/WEuR/VzSIATgkdJfcDxeBw1klWCNrK
         UXT5HBoCYjT8hZmjhv/aHZ3gioKEMVsqx5B+pSjK13/YJOyXVLHNFyx+O7+3QjB17MW1
         uu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745815599; x=1746420399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOHHnBO+zKL6LHtF6+7WU+ADvROfthuwM6WXeWBkTnE=;
        b=Y7D8H1w5kIhBaLORJhL2ibydMikCSiZOyOwFsBv4mOdwe/WI0wWslVuRJxvxABcDl0
         mfmjCqLdqPS5QppUrtznnvl2Sc/wdGtuF6Kcd6C1RpWmq5itk9yXcnSel3To3lTI/2kp
         0nGBxa6fxsi1VUOZRuT+zCZ6TumETzosYITNqv0ZFwwZnSDpRSp8CBuKTSSDCEBdj3/G
         54GGC61U8sovmHBInw+CT0lqspIjOvmxwsteL0Xfqw2LP5YBXJcSXynpemKVZXGgopCp
         FPP6yG0RNea5wcSVO4UBAYwDUlrEgX343Q2TX+DRnXsphuJhNNKyjciFqMU265iy4Yr+
         npqg==
X-Forwarded-Encrypted: i=1; AJvYcCVuDHqIzdU/IGPFBaEvTiI/h2wFpl+Poq3yWAIylyriopge3T30LZA1eijQr94VXJDFSWUlYq032OU0ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bpKcMxBZcBTgg9ZUJuCDMBF56b2ny3tUtNbCC8gjpJz6BWlD
	QkMLc7GWW+RKjyAN5ubEY8yd10QJRaBTtiurm72AdjZkueuVsWJV
X-Gm-Gg: ASbGncuYQf6p1RVlsmSxGu8zhMJUtDaJAmMTGZFrG54fgDYZxZQcynT8ExiduRfEEKo
	BNCP2ciGin4c6q4zO6jaTGH5EJBJu/aW8MKWV9guOx/t+DtDhKfjl+p/JpG/uViYIeYF1LT6Ejf
	Xf/5/AGJFrqFNoQauaoJMoH9wLiTL44hHhbEj52j1Pe1NoIceqj271iEsxm9Ohc3liUhNdXxBhj
	9uaHaEAHzMqDgoXAebfekJvpRqH73+oxrA9wyxP6zlLWS4GKumypuec64xf2IxJp8jcG4sbVudi
	0K/5rMfOSAUNYXNS+6ZRfQrul0XJwQYoY1jKwtDU6FuMU3Aok4gTsMGbW9J4WBM1LXKWHtTN3KQ
	=
X-Google-Smtp-Source: AGHT+IGfHw/VIi69GZTrpp49kSywANt+VJVM73otO0JvP3cjcxzYoteYED3yb0p+X2CXi28AeAdxTQ==
X-Received: by 2002:a17:90b:2dc3:b0:2fe:a545:4c85 with SMTP id 98e67ed59e1d1-309f7e9e747mr16312319a91.27.1745815599221;
        Sun, 27 Apr 2025 21:46:39 -0700 (PDT)
Received: from kogasawara-server.kern.oss.ntt.co.jp ([222.151.198.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216946sm72239935ad.224.2025.04.27.21.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 21:46:38 -0700 (PDT)
From: sawara04.o@gmail.com
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Implement warning for commit values exceeding 300
Date: Mon, 28 Apr 2025 13:46:21 +0900
Message-ID: <20250428044626.2371987-1-sawara04.o@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyoji Ogasawara <sawara04.o@gmail.com>

The Btrfs documentation states that if the commit value is greater than 300
a warning should be issued. This commit implements that functionality.
For more details, visit:
https://btrfs.readthedocs.io/en/latest/Administration.html#btrfs-specific-mount-options

Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
---
 fs/btrfs/fs.h    | 1 +
 fs/btrfs/super.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b572d6b9730b..f46fba127caa 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -285,6 +285,7 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
+#define BTRFS_WARNING_COMMIT_INTERVAL	(300)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
 
 struct btrfs_dev_replace {
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index dc4fee519ca6..c6911e9f17f2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -569,6 +569,12 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_commit_interval:
 		ctx->commit_interval = result.uint_32;
+		if (ctx->commit_interval > BTRFS_WARNING_COMMIT_INTERVAL) {
+			btrfs_warn(NULL,
+"commit=%u is considerably high (> %u). Large amount of data can be lost when the system crashes.",
+				ctx->commit_interval,
+				BTRFS_WARNING_COMMIT_INTERVAL);
+		}
 		if (ctx->commit_interval == 0)
 			ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
 		break;
-- 
2.47.0


