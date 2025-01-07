Return-Path: <linux-btrfs+bounces-10771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830AA03FC3
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C876318880E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819971F37C9;
	Tue,  7 Jan 2025 12:48:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB9208AD;
	Tue,  7 Jan 2025 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254082; cv=none; b=NdtqU1OL3TCkTSTdd0dPC4Xlv5PnBSzn4npYgTo+UV/Wk36SZ8l5gXrTsj8jEyBR6jaYl8jOERh1fnNaDtDLvkBddXy4/u5otBBDdxlzDzMzk9u2oFL29uy46KqdwXcBmaxsfZPd5L2i6AuKwV8AE4EHpc4UIcRiIBAwE8x/Jz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254082; c=relaxed/simple;
	bh=Y61cv6XONm5aSh6hqCsDgZWpAA78IkIVPAV2P/Gdd4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsWz9uEJz6NcdsZjq9euBKMh+8/ej/mrXULL8cWWeBAwnHzGEP2mce49sm5PPH0wVhDiFJr80w9tqnM71mUjjA3D18hPQ04pRKLbdW2IXmsLzDYlSpA8cqO9aybvYGumNnFUlWGRhw/N95TeqB/ogyDgLTWGj67NXd04z2Tc3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43675b1155bso147921465e9.2;
        Tue, 07 Jan 2025 04:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254077; x=1736858877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wo94xRQW7tw3npwzxFYun+vVy3ZCNUGiTzgM9DSsIwc=;
        b=NfBL5G/X8BSOkjxlvniBxCpZbbyKrABJnHo1jukNXOroqni6UR6rkp9zOcARo5K67o
         z40YLrHJUkvHmsnq3z0mBXDdaHI2FWVIczGkVHd22FZ9am3otoIBFbqPfERdaUvpSvCW
         Dg6nKrWx1SN3orsPektX+uJwcnue7fYNg2uE3bRjs7btv2rgkZ/0QiBthu0eaBzTItyB
         3SoYkKAl5XmhkgP3P2N4JcfRVnKLFAuA1yoqBZ0Wk2FpVw7F4XzolTxOKaKQ3Hl3b9tn
         IWWQyZtwScwxaHe1y2bBLaB36GjaW2+BrfXRzmZJWMW2QkoHfYLOfvMPEEHsAM+ahfLX
         JmmA==
X-Forwarded-Encrypted: i=1; AJvYcCXcHmv4gcc/SirT4XcQJ0bm1tYAzXQ8DwC/kCkcTXXfzPyth4bj2rYPHiPgKVBkGaE0JsvPob3n492pLos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzH6Ws2hj7qO28lxxn9gX4sQVvWsoNm6/o8w78UxkWfb5BkVGj
	65tts7rhsrRr1VeXaGa5cVsBvjcUjb2lk6lEIzkx5I1stSFq9q1cwRQC+g==
X-Gm-Gg: ASbGncuJ88LaQa/z0qKa141I4tPd9Y1D5tEumesHDlj6AcFo0wPFs+7FrnmOOydSuzC
	cgsTt+jp3BPX0IzUE2jof2TDbhTIoTkJxh5nsYxzpPT57L96K3YKzCGG4uyXSynSjIadHYvaqP2
	JJzq1aSPBEu+IG7E7Ts9WBCbIaRuoDq1kbYXBY27q7zCrrVcvjZgYOdrnAO+k6HyR+qJyuLgJCL
	YrmAA0i1wgr5SNA24ID5Xn7z73UwqZUhqSttzql746jdIJhq/zw601FWaPnqXFaOl/kQM80oLh0
	DFUjKOAdTZ3Xeby4msmP0e9O5iTECr8MenNO
X-Google-Smtp-Source: AGHT+IGOHd3+acGuNHFj14ExIK0HkqFGilzbQQllLLY8rN2DudjFZT8qfy/r3mRsaoIMeoJk9gx4yg==
X-Received: by 2002:a05:600c:4f0d:b0:432:cbe5:4f09 with SMTP id 5b1f17b1804b1-43671247b46mr508799485e9.4.1736254076761;
        Tue, 07 Jan 2025 04:47:56 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:56 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:40 +0100
Subject: [PATCH v2 10/14] btrfs: selftests: don't split RAID extents in
 half
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-10-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4127; i=jth@kernel.org;
 h=from:subject:message-id; bh=BKJ9UtZqMumOGnIO3fSUYTuxPI6H2ODSwOVX3gFSNx4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhW+36/206WwbdMMuc/CoR+dSu8xnPWLWjzXpiut6
 keLd/TGjlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZjIpr0M/9PdAy9WRsuLOzGa
 7JEqe3KppU9w4eaTpxZtmJJTLt4w7xrD/9yuWYmnum3q9f4Xt9858+xmvvj0G4sDX1Z1cYqwHvg
 TzA0A
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

The selftests for partially deleting the start or tail of RAID
stripe-extents split these extents in half.

This can hide errors in the calculation, so don't split the RAID
stripe-extents in half but delete the first or last 16K of the 64K
extents.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 44 +++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 19f6147a38a54f6fe581264a971542840bc61180..12f3dbb23a6423c4d224c5b087b35862b8d643db 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -14,6 +14,8 @@
 #define RST_TEST_NUM_DEVICES	(2)
 #define RST_TEST_RAID1_TYPE	(BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_RAID1)
 
+#define SZ_48K (SZ_32K + SZ_16K)
+
 typedef int (*test_func_t)(struct btrfs_trans_handle *trans);
 
 static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_devices *fs_devices,
@@ -94,32 +96,32 @@ static int test_front_delete(struct btrfs_trans_handle *trans)
 		goto out;
 	}
 
-	ret = btrfs_delete_raid_extent(trans, logical, SZ_32K);
+	ret = btrfs_delete_raid_extent(trans, logical, SZ_16K);
 	if (ret) {
 		test_err("deleting RAID extent [%llu, %llu] failed", logical,
-			 logical + SZ_32K);
+			 logical + SZ_16K);
 		goto out;
 	}
 
-	len = SZ_32K;
-	ret = btrfs_get_raid_extent_offset(fs_info, logical + SZ_32K, &len,
+	len -= SZ_16K;
+	ret = btrfs_get_raid_extent_offset(fs_info, logical + SZ_16K, &len,
 					   map_type, 0, &io_stripe);
 	if (ret) {
 		test_err("lookup of RAID extent [%llu, %llu] failed",
-			 logical + SZ_32K, logical + SZ_32K + len);
+			 logical + SZ_16K, logical + SZ_64K);
 		goto out;
 	}
 
-	if (io_stripe.physical != logical + SZ_32K) {
+	if (io_stripe.physical != logical + SZ_16K) {
 		test_err("invalid physical address, expected %llu, got %llu",
-			 logical + SZ_32K, io_stripe.physical);
+			 logical + SZ_16K, io_stripe.physical);
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (len != SZ_32K) {
+	if (len != SZ_48K) {
 		test_err("invalid stripe length, expected %llu, got %llu",
-			 (u64)SZ_32K, len);
+			 (u64)SZ_48K, len);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -128,11 +130,11 @@ static int test_front_delete(struct btrfs_trans_handle *trans)
 	if (ret != -ENODATA) {
 		ret = -EINVAL;
 		test_err("lookup of RAID extent [%llu, %llu] succeeded, should fail",
-			 logical, logical + SZ_32K);
+			 logical, logical + SZ_16K);
 		goto out;
 	}
 
-	ret = btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K);
+	ret = btrfs_delete_raid_extent(trans, logical + SZ_16K, SZ_48K);
 out:
 	btrfs_put_bioc(bioc);
 	return ret;
@@ -209,14 +211,14 @@ static int test_tail_delete(struct btrfs_trans_handle *trans)
 		goto out;
 	}
 
-	ret = btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K);
+	ret = btrfs_delete_raid_extent(trans, logical + SZ_48K, SZ_16K);
 	if (ret) {
 		test_err("deleting RAID extent [%llu, %llu] failed",
-			 logical + SZ_32K, logical + SZ_64K);
+			 logical + SZ_48K, logical + SZ_64K);
 		goto out;
 	}
 
-	len = SZ_32K;
+	len = SZ_48K;
 	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0, &io_stripe);
 	if (ret) {
 		test_err("lookup of RAID extent [%llu, %llu] failed", logical,
@@ -231,9 +233,19 @@ static int test_tail_delete(struct btrfs_trans_handle *trans)
 		goto out;
 	}
 
-	if (len != SZ_32K) {
+	if (len != SZ_48K) {
 		test_err("invalid stripe length, expected %llu, got %llu",
-			 (u64)SZ_32K, len);
+			 (u64)SZ_48K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	len = SZ_16K;
+	ret = btrfs_get_raid_extent_offset(fs_info, logical + SZ_48K, &len,
+					   map_type, 0, &io_stripe);
+	if (ret != -ENODATA) {
+		test_err("lookup of RAID extent [%llu, %llu] succeeded should fail",
+			 logical + SZ_48K, logical + SZ_64K);
 		ret = -EINVAL;
 		goto out;
 	}

-- 
2.43.0


