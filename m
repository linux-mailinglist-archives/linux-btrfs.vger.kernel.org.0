Return-Path: <linux-btrfs+bounces-10860-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617FAA07B9B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922FE3AA4D3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8FD22371E;
	Thu,  9 Jan 2025 15:15:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486BF2236E9;
	Thu,  9 Jan 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435733; cv=none; b=RZbhYJlv0CZ7Wrv60To1IR8Ef+v2mA3oBT+JrLV4nPeyT8NScyQcLAygUvN7Izk54YZ8YW+F3iXfqgTg3zonyuDeHq+SUz3zodcaH2bm6JrQaetOtvzr9wqL9b6AyAdE8tbkRH90EvsF3EOdFI+exNzdl2tSNSK8zH4fjOdVtYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435733; c=relaxed/simple;
	bh=Y61cv6XONm5aSh6hqCsDgZWpAA78IkIVPAV2P/Gdd4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DdFs7bOCzk2roErCrqGmbF0+eFhz0sBkbbX6CtBFNUEHbHKSaWKxY62uWK2HJTITccgEvLVSPbJGeUMK8cGdL5ph/vOsi9leRL1L53sJPLlGhmMbwHz7gLy/9ftUBFPcTNgDLPfGlQXyY8FLOFoDKb01mbpTRF9hP+iwb/MIbRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so223173166b.0;
        Thu, 09 Jan 2025 07:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435730; x=1737040530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wo94xRQW7tw3npwzxFYun+vVy3ZCNUGiTzgM9DSsIwc=;
        b=FJ13hmUNvfK5a4okH9p1MiBogwnOOkf6Yp4euXa/+DsW9YUosA8rUj8XXjAehPK5ie
         6KWNZHvEDWBWOkJlJG8Yl2ycnBBhPBgyXhQF0otvoNlHoE3+J+VDNG07GYv039TPRYsp
         HmTYxCp+M/oaE3XWM/QJ5Hjp7RjrI1jD6iSjwNw8pTLg3fWmzEOwqIxV1jzEqyvsMuPr
         QUerpgt4WEoXTs6AhFWTnneOvSZnnmttW+Tt7gmFu31SPLD85+CPAXDR16lL9m9ZPZgg
         GpCPWpHPfgA7RL2P9LB3Id7ikdfdBqVwHmloR8cO9juU1QLsWeBKuDD0vJvWrYKk80VZ
         K4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVhrCZzBwWpSWXuILfdQqmUjw5OJVALK4KZGHZNPZZy2+dWRSKGqSYYX9TNa5PhUsg+SmsCuXTo3uvYC6ZM@vger.kernel.org, AJvYcCXqxXDMzBwLi0nR4M/gFAH60yI9gJkVd3J4kZhRXxTvW1eGUsX3q/f7WsMmNOADX4NaahIjp0Vsa1CCCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRtZj47UqsjvHrsnbbm/6aGPFaoMb1dKtpivaX0xwuw5RDtptA
	OwRYicBW2ZKk8BX8FSpExgnbrnkzLXlLwpjZVxlu0LoRX1CMhx5z+IKFTg==
X-Gm-Gg: ASbGncsXKctS7CbAe4uDd3Rbf2KCRqpCTBHsGpXM+7gBzOab2Y8oqIUCvow406vG9EF
	yM1moSYp4T2lklf2e2p4P9Kq0Aqmtu9jLWbejVzXTYmq/B7MoaxnU9REGTHdw7n5nzrvwPhH4MN
	qZ3xRTjk64xFgxldnAngIbDNYpgjJ+2chBSG0mNfeRnTVIOcbX3HxUd80sfpXflwkD7pfehndww
	wdT0Xkvz+fYn8SDjat5PhUXa5/F1Pz4rlfatdOXOWpuGTlzSpuJLNuUdAX0meyENyZ28ooMiRSx
	gmE90GbEcsKMZ8hxhgpFy+MB3JRBb48BUPMJ
X-Google-Smtp-Source: AGHT+IEcVa8XSVCe0QzRkAVY9XKYyYLE2XeFL1KBk6OoVV6Uw+zDcCV8N3Pas9Ppodlw0mk/5De94g==
X-Received: by 2002:a17:907:2da4:b0:aaf:1183:e9be with SMTP id a640c23a62f3a-ab2ab6a8b31mr575455166b.2.1736435727973;
        Thu, 09 Jan 2025 07:15:27 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:27 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:11 +0100
Subject: [PATCH v3 10/14] btrfs: selftests: don't split RAID extents in
 half
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-10-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4127; i=jth@kernel.org;
 h=from:subject:message-id; bh=BKJ9UtZqMumOGnIO3fSUYTuxPI6H2ODSwOVX3gFSNx4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2A9aCnwtb/0Rc3Ktz6NMnePng+InN7mtSDlrvapW
 ber9uaYdpSyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEpDcwMsztyfVeaXPh4t+0
 HXPyzk6qadt3uzVUS6CIs7ThBcPt3n+MDDv3vD2qcOQZ3+e3d7uDzwQqq6TuTfijJyBXFe2+5Zb
 +OQYA
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


