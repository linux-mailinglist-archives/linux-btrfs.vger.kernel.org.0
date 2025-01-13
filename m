Return-Path: <linux-btrfs+bounces-10950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB27A0C18A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311AC188AEF0
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544F91F9ABE;
	Mon, 13 Jan 2025 19:32:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2191EE7A4;
	Mon, 13 Jan 2025 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796724; cv=none; b=Wqv5oGsFIfWjZaWpRuIlqYUfb8Fq6UqljkpvKLQ9waZSK7qlBlkk7dR/GfscYDEIuAvbiksg6uxr9xIofQuDmZ8bFjbGrgyjscz6/DmY72YQ6AEPOoB/f1TeUcF+8CoUvv3/tP+govMPl0dJW7KocfoTyOOnhmR+OUTtcZtcoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796724; c=relaxed/simple;
	bh=w5qZztUH2e3eNwWq/SsGElt7/PtIalBrKOR0qlroJLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIa6Zp0iwkD+Ackdcae6bBiQFuYhOQqzPS8gmeNnFXpK6rvdr/bx6ZBRD5riJOb6Y3FnsGDeMFmx6GiAIw2IHit9OvKvtdSyWP185gj7LoqfakeCYvAJACqvc9Bm5DA9JzQxOnctItXu1TAp6R7sEZMrZB172jeUN+cjubcIrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436a39e4891so32829595e9.1;
        Mon, 13 Jan 2025 11:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796721; x=1737401521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lYbTFMBuCIPE1uBL3n/gmzZstoHZgCeNJ9JWSt4JBs=;
        b=NMjq6LZhDrJweuxNDHWkvbYt8zwUUEGgCrPI66NFFrUKTwb9OGs39OA2rDeUIAYN/9
         RnxM46Mxh7LSLP32Qx3rnnR2Y2xX43/zBkrj8NLGexUBce8hYfk5i620iI/0KDAk9UOM
         stSA8Uj2rN1UjgpJdPAvHl66jP7ZicE3NNUcG+rxK2JlyrgQjr84S0Asm8ef541H2qsl
         WsKR2R0QBaQeQEBxU9FsARz5V8XBM2bM55sLUtoIGbgYKzEBexUxkiz5mknRdRQPBzLs
         G08tDZhsr3AQllgHXlaQLPbI9DPZT+UsbHWg4muI7tp4FhaKteuCOAJ7CRkbKyia7FA8
         3CQw==
X-Forwarded-Encrypted: i=1; AJvYcCWB8wvlywyEVPr66buqIfq02xINp6URos8s1tXabu4Nkm4CC299x3GzMVv1sCnIMydZ28yyoM+lxKY6jQ==@vger.kernel.org, AJvYcCWmJUvcIVor9AdhPDRbfI8pbbNCUAAwwgqikLCKh4g8R6lEs03HNp/2Mzma4tzVbdXX1ZbXDxEezGjF7uPU@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXLGZ/C8i7OZuA0adZqj7bq8PM+TJy9Xgk+mwbPddw6+y3Odc
	sQ8PowHE7wl/FsRXHOuXGz1dqvafHLHd4BgdHX3mYvAfZ8bAuObL
X-Gm-Gg: ASbGncsAvvW+cSHjgNLYMXq4cpjhu7sea2lstLjorewlK+nUoGXMPjW9Yp7TgeWU/Nc
	3z7YP+grVX8NKeLaG+b2ctsKmXdXd2VvcQ73PDkMH8BzvxaNXKZ3426Yvh1KnYhEnLFU/x6AScw
	Xvm6sqdF/6EwiTHbbad3Poapy32NeOiWZIqLQTLg0Dge84ZGRUPG8Utr2qxstp0+VQR3Tuv+2HP
	wki/0Wuu8GW62+wuw1KSLMNIvj0+H9X0jlwxT+CZqF2EGq9tXEkHmsAOE+7N5YZZ4aIXo5wzNjR
	fVcbkYGZxsdFqOcWMPDfc8tl+PmPeWcKGDuQ
X-Google-Smtp-Source: AGHT+IG2AhxzcI58jheR7j9ozUGeOyLTteS3yCY5XvpAarUkzY4hkRigBWVEla6TSujBRAc7za1pRQ==
X-Received: by 2002:a7b:cc14:0:b0:436:e751:e417 with SMTP id 5b1f17b1804b1-436e751e4ddmr191773795e9.7.1736796721036;
        Mon, 13 Jan 2025 11:32:01 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:31:59 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:51 +0100
Subject: [PATCH v4 10/14] btrfs: selftests: don't split RAID extents in
 half
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-10-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4127; i=jth@kernel.org;
 h=from:subject:message-id; bh=9tBCl1tRdaRHBU9/u8961DwANMUjbMM2sk8km51WH+M=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3ZqmmSZ7a432AoXp1zNY1j2x5jwY5sDtzdq2TKDlwb
 CbzDua4jlIWBjEuBlkxRZbjobb7JUyPsE859NoMZg4rE8gQBi5OAZjI1AKG/1EflE3nHVXi43x5
 rP1IxVP31je51imfb+k8lVZPmyYufIeR4eyzDOkE7/d/P/9JaVUxkP+atN1903bP16V5HSuOvJ6
 XyQwA
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
index 446c46d89152a5a903476c5ab1abef81978c2aef..da73369a79b41d90cd05bc1c8c373d1ef5f253cc 100644
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


