Return-Path: <linux-btrfs+bounces-10305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8079EE0B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936FB2859A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727EE20C003;
	Thu, 12 Dec 2024 07:56:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580A20DD58
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990173; cv=none; b=Bi/OwoxP6xoFsRaSBDLnO3WMW+NKYr9Miqx+u7opXe19oBWHFtFpS7DMuOiiX/n/Jf2sY7KdQVePJZ9D6LdSY0hVjqHOw4L/tmVvtrlmLc2c3IMpT5vC4bqdW/AT0NyS5q3c0Nsxs/tH92q3nxmgc0nN0ufkJgYq2fr/Pa/ZdcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990173; c=relaxed/simple;
	bh=jXZrJPWGovd5Z8NgLmgV1Rcpxy4kXQAEZtI5WlnnKFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR1kwVqlriMP/fexZS7eVs02NPKrSMOgc22HyEdQCxTNKYQCPx/QuWO8oiJMoA8A8DKe5se0rCC0z87VEwvF2v3ufI/8jj4bDCJsZHzxA9X0IWnULT6sSf0iqD2jpgRUXEa4Gq91zzZp9U/50/6i0mH9afWcYYr2CkLeM9Dmg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa67333f7d2so40457666b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990170; x=1734594970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBwWq+36VjgbADt9rxWO7KTgR6EWm+cYtUJRpKHMaoc=;
        b=ewnAKNogtLZtr5pgkZGIsITslg4GHSXImLFwTXnkrw/INmu4QQ7S0s5Mb4hEgTwfP8
         BMt7l/7r6up8RVQnOEOyE/lLjXfM7bZvP+8zTUSeG8Htu3naMya+uRpPnjnq41VV7eR8
         GxgXKGjMWjTabo4HvMFB5jdW3xXANsY8Q++CXq4SGgs6r2+Usog9po92YhKc4+Jo5U0o
         lypF/ZLmveqvPxIG0QZRuv2GE3gwe9pntpuL26LiOooj44vT7zdpgtFTALCgwmyPWol/
         DyfgYBW6bjb9fAgl/zy2zpIsi68vThiXg7hW2juFwABgE0JuiiMfug9q5BzrxIZR1h3J
         FVhw==
X-Gm-Message-State: AOJu0YyKugxt4pp3gZB/+2B+sH71gIo1HHxSosQVbIQyNvVaoE3adUN7
	yDaUf+KfDW87JEh4UUdjUzsDwPZznkgyFY0/hzOot6nNqlfEUdrp+uj80Yew
X-Gm-Gg: ASbGncvmwvYFcljIFUZ6/7prIWzUvnnwH6Yen4Po9b809EbtTynJyvIHuMb96ScpJk3
	FZT0AYkd8RG4JUqByJHnNCwmbqbXh6Kwt5pZ+U67nI0CpUpMKA5dRaxcbb8YjAPxTjd/dvjf2fK
	wyREmqgijfx7+tm3Ue9t+M0+esOYlgceaLe2PK06YPsp/l900FyuZbIrQZC0svWvpt0epP4d0n5
	m2zz+uxQoWoe0kh/LeFs+9nOFEadxikcWYD+okynHW+L0CpfABwKC3GMFdDQeC8DAvvjJVB0zcT
	Nstlzyd9IxjFFj1mLdLyQB9E+mqQX14IfffF19Q=
X-Google-Smtp-Source: AGHT+IFaCUQekPwWjaD4LLOkYRKAuRfH7/M2Hs7pRj+R4vQQLLrGCJhrxe8TJoHQZ+02b0dLD78/aw==
X-Received: by 2002:a17:906:2929:b0:aa5:31f5:922a with SMTP id a640c23a62f3a-aa6b119dc22mr537091666b.19.1733990169628;
        Wed, 11 Dec 2024 23:56:09 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:56:09 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 13/14] btrfs: selftests: add test for punching a hole into 3 RAID stripe-extents
Date: Thu, 12 Dec 2024 08:55:32 +0100
Message-ID: <9ca5d0de8c4ebd1e6267f1fbae9238753d14cf50.1733989299.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733989299.git.jth@kernel.org>
References: <cover.1733989299.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 183 ++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 37b87ccb5858..8d74e95a8a75 100644
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
+	/* prepare for the test, 1st create 3 x 1M extents */
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
+	/* get the first extent and check its size */
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
+	/* get the second extent and check it's absent */
+	ret = btrfs_get_raid_extent_offset(fs_info, logical2, &len2, map_type,
+					   0, &io_stripe);
+	if (ret != -ENODATA) {
+		test_err("lookup of RAID extent [%llu, %llu] succeeded should fail",
+			 logical2, logical2 + len2);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* get the third extent and check its size */
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
@@ -745,6 +927,7 @@ static const test_func_t tests[] = {
 	test_front_delete,
 	test_front_delete_prev_item,
 	test_punch_hole,
+	test_punch_hole_3extents,
 };
 
 static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
-- 
2.43.0


