Return-Path: <linux-btrfs+bounces-10863-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D957FA07BC4
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1A57A34AA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF2D224AFE;
	Thu,  9 Jan 2025 15:15:35 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF221D5AB;
	Thu,  9 Jan 2025 15:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435734; cv=none; b=nAFANDgtXNYlg76B2QIf93laMTBg3fQRBXMIZvOcoA10yxmVTa7BN59MSPzo+pKq488ZNCQ2mpmLxl5ID92rXf4TWNkwUida2Q8I/Z37SeO/VT9ha9gxqRzIWxUn06AASqTBvIHbLLJcEYzL6Ktm/Kx0TztZ0p5hreLX0fxRZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435734; c=relaxed/simple;
	bh=1AB4jwcI+lHYlYRcQqkQHVIt8MBO3ki9zuAxI9V49EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PnM2vHdBvjfB3IL3BU2tLIwcQFgSPoo6jX8fmAtpPlqEGhENAqXbAwR9vPslGcZmQzabq686g0L/4oxlFSoPNsR73Zvd5TJ0EcZ/Imr26ahBRSJ4/54TaNEfRH+6afPcCG+04H63w6K+wb0KixJWxGOumNJ1cEQPw6/q1fJNNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaec111762bso213335466b.2;
        Thu, 09 Jan 2025 07:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435731; x=1737040531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5zvsivh78DDNjeh2ZcSnXDI0hKH6mj4dodObFPkjBY=;
        b=wAxfWLcp+Ud5Csp0+3kIJd575b0MTAcx9BjbXnBEHd0D3MegvAHn8u6oD38fHKmqJS
         o/Qi6tzWUZdxzcapTL+qYOj50HaD+1SSeQp6WTa5rq8zy7aTRwzY/Kg9NlnJPLxIpQWd
         hOzF0SxpnDmseBa7QrWQ7aJbReXuUvX7A6LyGC2U+PYjipLhZ6dtUbhaM+bKhoHqr/Zk
         Ww8XxeuU6ri5BeACrkudbo/TKGo+/NjBEmCrK9DTKOLb8atir4qPl26FH1Mv1+yrW3PP
         bNqJWJP2EG0BC6ytwJA0J/atyrW1WllWAOzUFG/T9qFJN0KD/arZ3rF1EYVFVKer0arI
         t07Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQmdGnyQEUs/PBvS0N3cIsbEjzwOaNfKTflBXYIRKG/WuQ2D5L17SrVKtP5Q8nx3RQyfOlhwWCq6bmyg==@vger.kernel.org, AJvYcCXeZey5jyB3XDuvna3n+E2z3ucL4ZikVLUb9wl+zTgh5dKGuDj0bjgM6Y27miCKTF4xgpSaytbg1fewNGxu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GOc27j4zLz+GANNQjIsXctOt/d+jzrbxZak4o/7aXFOsM4Ja
	ma+T2bsc64mFUPblpbpCEWBIPy1c80gA4dztemGqdjRCKrsZRJWP
X-Gm-Gg: ASbGnctWvtL8av4mrBk2QwEkucRcJWCO+c8SGlaCg+Q7jFVBgAxbba9nXUaOxdTCdLa
	FFnlOfOgdJxvN6NxpUxNyMkkJwEstYt4+nxIl8wTYI/H0X/ct5aGywhCggSFz4E+eo1DOk64UVk
	9THdj8egLvLXAJ9D1FITHEvTd5wnIZKs9Aqfg8th/Ilokpwu2yymdS4tZzpjZBagT1RRYqMzRoq
	ya1NoZMWCwWgzs4Wbg+Oz9p/q4J6zMeYeV8i7ruCtkTE0fISNxeXjlP0QWV5Yo8vpbY7zjmThO3
	5HpNQw+Hg5+hAY0LWfGV3o/yJWYda6FcxMDR
X-Google-Smtp-Source: AGHT+IFMbcs+sRTrpEanYnX7cR1jbJDgbeZEoQAqS4vx8wNuafTXyiy4YhszQdUZH1pYN4qVzNcvRw==
X-Received: by 2002:a17:906:c143:b0:aae:8490:9363 with SMTP id a640c23a62f3a-ab2ab7408a4mr681805466b.34.1736435730744;
        Thu, 09 Jan 2025 07:15:30 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:30 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:14 +0100
Subject: [PATCH v3 13/14] btrfs: selftests: add test for punching a hole
 into 3 RAID stripe-extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-13-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6236; i=jth@kernel.org;
 h=from:subject:message-id; bh=ZR4+z/8IzbGtRFmu+ycYbFa6RrLQUuwbhqkmEim1rB0=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2D97vpwX7P6tg/m2s3Td9e8+Ry6fP6Fq9ZV4XkvZ
 eq2XZ/2pqOUhUGMi0FWTJHleKjtfgnTI+xTDr02g5nDygQyhIGLUwAmMs2JkWGfhZOT4P9mxt/X
 XMK4Pa/aR388d/e2Xbr7hUkVe4s9nS0YGdbsVOFSM2i8rjBhRntiSm7/tIcfF+vdO68we0sCm9C
 KOi4A
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Test creating a range of three RAID stripe-extents and then punch a hole
in the middle, deleting all of the middle extents and partially deleting
the "book ends".

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 183 ++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index c7e44e944f5ecc37ffb937237cb81fefbafbaf9a..e12b6abbfd2be66170d33ab13b1e0971444c0f9a 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -31,6 +31,188 @@ static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_devices *fs_de
 	return NULL;
 }
 
+/*
+ * Test creating a range of three extents and then punch a hole in the middle,
+ * deleting all of the middle extents and partially deleting the "book ends"
+ */
+static int test_punch_hole_3extents(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_stripe io_stripe = { 0 };
+	u64 map_type = RST_TEST_RAID1_TYPE;
+	u64 logical1 = SZ_1M;
+	u64 len1 = SZ_1M;
+	u64 logical2 = logical1 + len1;
+	u64 len2 = SZ_1M;
+	u64 logical3 = logical2 + len2;
+	u64 len3 = SZ_1M;
+	u64 hole_start = logical1 + SZ_256K;
+	u64 hole_len = SZ_2M;
+	int ret;
+
+	bioc = alloc_btrfs_io_context(fs_info, logical1, RST_TEST_NUM_DEVICES);
+	if (!bioc) {
+		test_std_err(TEST_ALLOC_IO_CONTEXT);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	io_stripe.dev = btrfs_device_by_devid(fs_info->fs_devices, 0);
+
+	/* Prepare for the test, 1st create 3 x 1M extents. */
+	bioc->map_type = map_type;
+	bioc->size = len1;
+
+	for (int i = 0; i < RST_TEST_NUM_DEVICES; i++) {
+		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
+
+		stripe->dev = btrfs_device_by_devid(fs_info->fs_devices, i);
+		if (!stripe->dev) {
+			test_err("cannot find device with devid %d", i);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		stripe->physical = logical1 + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret) {
+		test_err("inserting RAID extent failed: %d", ret);
+		goto out;
+	}
+
+	bioc->logical = logical2;
+	bioc->size = len2;
+	for (int i = 0; i < RST_TEST_NUM_DEVICES; i++) {
+		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
+
+		stripe->dev = btrfs_device_by_devid(fs_info->fs_devices, i);
+		if (!stripe->dev) {
+			test_err("cannot find device with devid %d", i);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		stripe->physical = logical2 + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret) {
+		test_err("inserting RAID extent failed: %d", ret);
+		goto out;
+	}
+
+	bioc->logical = logical3;
+	bioc->size = len3;
+	for (int i = 0; i < RST_TEST_NUM_DEVICES; i++) {
+		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
+
+		stripe->dev = btrfs_device_by_devid(fs_info->fs_devices, i);
+		if (!stripe->dev) {
+			test_err("cannot find device with devid %d", i);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		stripe->physical = logical3 + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret) {
+		test_err("inserting RAID extent failed: %d", ret);
+		goto out;
+	}
+
+	/*
+	 * Delete a range starting at logical1 + 256K and 2M in length. Extent
+	 * 1 is truncated to 256k length, extent 2 is completely dropped and
+	 * extent 3 is moved 256K to the right.
+	 */
+	ret = btrfs_delete_raid_extent(trans, hole_start, hole_len);
+	if (ret) {
+		test_err("deleting RAID extent [%llu, %llu] failed",
+			 hole_start, hole_start + hole_len);
+		goto out;
+	}
+
+	/* Get the first extent and check its size. */
+	ret = btrfs_get_raid_extent_offset(fs_info, logical1, &len1, map_type,
+					   0, &io_stripe);
+	if (ret) {
+		test_err("lookup of RAID extent [%llu, %llu] failed",
+			 logical1, logical1 + len1);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical1) {
+		test_err("invalid physical address, expected %llu, got %llu",
+			 logical1, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len1 != SZ_256K) {
+		test_err("invalid stripe length, expected %llu, got %llu",
+			 (u64)SZ_256K, len1);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Get the second extent and check it's absent. */
+	ret = btrfs_get_raid_extent_offset(fs_info, logical2, &len2, map_type,
+					   0, &io_stripe);
+	if (ret != -ENODATA) {
+		test_err("lookup of RAID extent [%llu, %llu] succeeded should fail",
+			 logical2, logical2 + len2);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Get the third extent and check its size. */
+	logical3 += SZ_256K;
+	ret = btrfs_get_raid_extent_offset(fs_info, logical3, &len3, map_type,
+					   0, &io_stripe);
+	if (ret) {
+		test_err("lookup of RAID extent [%llu, %llu] failed",
+			 logical3, logical3 + len3);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical3) {
+		test_err("invalid physical address, expected %llu, got %llu",
+			 logical3 + SZ_256K, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len3 != SZ_1M - SZ_256K) {
+		test_err("invalid stripe length, expected %llu, got %llu",
+			 (u64)SZ_1M - SZ_256K, len3);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, logical1, len1);
+	if (ret) {
+		test_err("deleting RAID extent [%llu, %llu] failed",
+			 logical1, logical1 + len1);
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, logical3, len3);
+	if (ret) {
+		test_err("deleting RAID extent [%llu, %llu] failed",
+			 logical1, logical1 + len1);
+		goto out;
+	}
+
+out:
+	btrfs_put_bioc(bioc);
+	return ret;
+}
+
 /* Test punching a hole into a single RAID stripe-extent. */
 static int test_punch_hole(struct btrfs_trans_handle *trans)
 {
@@ -752,6 +934,7 @@ static const test_func_t tests[] = {
 	test_front_delete,
 	test_front_delete_prev_item,
 	test_punch_hole,
+	test_punch_hole_3extents,
 };
 
 static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)

-- 
2.43.0


