Return-Path: <linux-btrfs+bounces-10953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7AAA0C18F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CBF16C65E
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE071FA251;
	Mon, 13 Jan 2025 19:32:08 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38201F9EC8;
	Mon, 13 Jan 2025 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796728; cv=none; b=HgLclFEkKB8sonrlTkwEpVuVSwCBYzYJg6xOYQ9B5JXUKUK+90/WjqaPmWQR/ble/JvxSRG2hmO/pI+e3SUjHjFgnaI0oS6X582Zo7gDMXxw1O4nyQ0BLoGVqSzUFgGlR348UvutLTvTOJVAN3tDSlQZ/a1kBUEWZ+7N5CTJcug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796728; c=relaxed/simple;
	bh=eoHpGvYEYnLQ45fC+G9SKF8MwRnIGG9F7C99Q+XahH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C90XaEZsX0eWZ19W9R6MSIZgOdnle+4whNZMfU7az4Q6Mb3dx+4icucukzv0G+53AIsm1w2V5GMxlKqq57dgfMkoqQLsUr8vLrT1zmuSoWKBImvitkZ/Wl0bRaoSUncDSoiFuodl2X7IP3XXpMCIXw7UKyrUpyLp2m/5l1FIQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43621d27adeso32764015e9.2;
        Mon, 13 Jan 2025 11:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796724; x=1737401524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPj0r4XCxEfWZHW3cEMl0QHLGDNa7kG2aj8kvuFQOmQ=;
        b=ms0ueFjlL4t0dcS/D69lL4clwRWJUBV3MIVwyx0QvVPsvCvqL4/I2FQ+wIbyyE+428
         y7g1D4Iuq0QLvd7czgFAWUHpMePRbUaRfUmhXYlmBZJD2NbKjACGkUq2jRKl7TmIGYD+
         lvdzJqcA7IgkE9asZUM935hPlKUyCPAVFxPiDZZkqgzCxbAYM1C+ZhvWiHDNvQm0R5f4
         LFuFzW84wYEWPzPp14+h+RqP6eaywh7vIVAbjjCugM4OmRgcWw9aaNDcbLVSLYosL/PL
         yx8Z+K2JA0T1uUBI+P3L6EJZx2n6aNZp77tq2M1dqQBNZwaEi/bzRlmoibSkl3oMiARn
         V/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK+0yvDbd8zYE0IcM+03+dCgFXniiBB1u6tVhABGW1cKcY6h9QvF3J13lvdE6Rqi6IYOWqkbnD7XRcA8Cf@vger.kernel.org, AJvYcCX1RMnCB5m9ay98xw+TPakfxOzNP5mgl6/3i6Y0odp5BGbb6H7ilxSpAPeh/Osw1R+4n27bHb+XQbLTwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGUhV6rroyrpXF4hnfOGQWZLxZ2ij5kfi+WVU5l1RAJQyO5o43
	NlErpSyhuKHjwpXK7fEREI98LA7EYi89+hNGb9vGGARgADQkOPDW
X-Gm-Gg: ASbGncuqPDlsrbtX2kB77nNTNhYgfNVljypHaMDdo97g/xJ9hji/c00J99j0HZgDxgD
	x2ZYlE/A7s6nr0VpHDlydBNjQEGoE1PZFS/lg2GLxj32lqRCnu9pp44u3xabr9t4PlGliwC5wkv
	fTcqK6WYU+AZdEejltI1MksUYopsrZa6Z7KueB9F63SGxxSv+MptjYmfIRZ+iTJYQ42Hav3wwDk
	K7Sfd6HMCSM0YAPrPB1yMbNOa9pujTm5ajbSEbNPtzkh8CK+6Y6O7NkLBb3sf5bJ/NYx/VO59pY
	HK61Js6UAImLvbMR3qLoejsTSxPVJXnDdFFp
X-Google-Smtp-Source: AGHT+IGEqSutg4TufNeYWiIsEgjHPDPz/EU9pmStOtiScexaxbzS+GsnMqopvVfhuFOeDs1vWUsc2w==
X-Received: by 2002:a05:600c:1c98:b0:434:a04f:2557 with SMTP id 5b1f17b1804b1-436e266e802mr196701695e9.4.1736796723750;
        Mon, 13 Jan 2025 11:32:03 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:32:03 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:54 +0100
Subject: [PATCH v4 13/14] btrfs: selftests: add test for punching a hole
 into 3 RAID stripe-extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-13-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6236; i=jth@kernel.org;
 h=from:subject:message-id; bh=8fxmSbOef6Jwx1uuEAO2yWzEF8rJOV2UM2ZHGlsK6h4=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3Zqm9rlvvv/ebdth6l1P13/e2KPntc824VHHt4tJIv
 Rrrnr9HO0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAiG18w/I+SEPn8XVj7gZaL
 rLLIRP6LZZ7lx+4+f/foFueiWS+W8Wsw/Hf+XGfiOTVJKy9ial25Y4pQeAnL06Kn+7cIiPHrzd2
 3lwEA
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
index f71e2ed97b2a8069d4af45c073fcbdd427905325..6365cf1e08a5d0d2e6b11a219d292db02275eb70 100644
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


