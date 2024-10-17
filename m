Return-Path: <linux-btrfs+bounces-8983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2438B9A1DCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 11:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D66B231A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087641D8E0F;
	Thu, 17 Oct 2024 09:04:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E551D88C2
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155869; cv=none; b=e5FBCQ6Bz+70nIpF7Y3XJEU5EKXLVT+CqimOQWMTJgFFTutRJ26MBTsK0Qy4xZ7JAwcNsoQ4mAKlef51/gLWJQvM1LIDRRPfg1EgSze6A9ZMjpsIX9S16Zy5bmG/xqg5iBvEl3AofELZLRGdzssqd7Fflk2dn8FJ5/QrjboC0ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155869; c=relaxed/simple;
	bh=6LHgcceAUHQ8U0uB9pG7WHgmDTigK76Qx//DU8jrEeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aK0ZVYosvLJhXnERq+3kv9nZtkKoUpS57mknvn/uIckkRqdkiWQBfxu0wl4iQHzOIoSC7WTzFxMhlKgJ9ypA9dgEJ/o2FuAfUcGNfbDcHr31PkwkMelUbvs9i4OA9gucdsmLZ7hGfsiRzInwGbctX2yCEspKOf4oM3mb/jvPBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431195c3538so6180895e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 02:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155865; x=1729760665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFAy95CVd1dVFAN4ux4JTrzom1j7KnPogOoHKAFUC+U=;
        b=jMdM9Pg7pFlvwdQQYK04qep/HGrX6U+L0hSa+Y+/R1wCDxovj1wMJIVN/Roah0utbH
         yOFaw/KFZKJDTEk0CjKGJ4CsfvvIp72cu+sKnIhe/GWBq+h6ZPIWr/jQ4u07KW1OZvnz
         UCYZFwooL+unj2pwXyftoQVmsL7vkopcHcO9lqOpMjco1M3a6mdR/S38S6h3eMxcnZiq
         x/T/vC8dCI8B4FbA+Tjx2m4bSY8VgWwEHjwoNEJd8EThr5PpFWs68+kBYlP+IRU5hpnb
         JZnE6jIl8DonHd4/dqJ0OW2AkFjyyccqB4QHhqwvDtvFwjrs1QIpWhuNkD/nSklf+HFI
         sOOg==
X-Gm-Message-State: AOJu0YyUqjqmT1gD91a56Tae+KVrD49E6iJz4hotyK3rmJRY54L1T4Az
	wXa1Xr112ZK/LsrTEadj4DlXMXRGiRkRBh78kGdvcaw7bVneO68euEZu+rJf
X-Google-Smtp-Source: AGHT+IGI1jml9gEFij5BU805yeGv0m97KimxqKANyWH03R6vpVLfwPFcF0RymMQUxQnz9sknzc8fLw==
X-Received: by 2002:a05:600c:4fd0:b0:430:56c1:644c with SMTP id 5b1f17b1804b1-4314a384f82mr52537665e9.31.1729155864993;
        Thu, 17 Oct 2024 02:04:24 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c37fbesm19700495e9.8.2024.10.17.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:04:24 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 2/2] btrfs: implement self-tests for partial RAID srtipe-tree delete
Date: Thu, 17 Oct 2024 11:04:11 +0200
Message-ID: <20241017090411.25336-3-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017090411.25336-1-jth@kernel.org>
References: <20241017090411.25336-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Implement self-tests for partial deletion of RAID stripe-tree entries.

These two new tests cover both the deletion of the front of a RAID
stripe-tree stripe extent as well as truncation of an item to make it
smaller.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 223 ++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index b8013ab13c43..5f1f1342b291 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -29,6 +29,227 @@ static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_devices *fs_de
 	return NULL;
 }
 
+/*
+ * Test a 64K RST write on a 2 disk RAID1 at a logical address of 1M and then
+ * delete the 1st 32K, making the new start address 1M+32K.
+ */
+static int test_front_delete(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_stripe io_stripe = { 0 };
+	u64 map_type = RST_TEST_RAID1_TYPE;
+	u64 logical = SZ_1M;
+	u64 len = SZ_64K;
+	int ret;
+
+	bioc = alloc_btrfs_io_context(fs_info, logical, RST_TEST_NUM_DEVICES);
+	if (!bioc) {
+		test_std_err(TEST_ALLOC_IO_CONTEXT);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	io_stripe.dev = btrfs_device_by_devid(fs_info->fs_devices, 0);
+	bioc->map_type = map_type;
+	bioc->size = len;
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
+		stripe->physical = logical + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret) {
+		test_err("inserting RAID extent failed: %d", ret);
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0,
+					   &io_stripe);
+	if (ret) {
+		test_err("lookup of RAID extent [%llu, %llu] failed", logical,
+			 logical + len);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical) {
+		test_err("invalid physical address, expected %llu got %llu",
+			 logical, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len != SZ_64K) {
+		test_err("invalid stripe length, expected %llu got %llu",
+			 (u64)SZ_64K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, logical, SZ_32K);
+	if (ret) {
+		test_err("deleting RAID extent [%llu, %llu] failed", logical,
+			 logical + SZ_32K);
+		goto out;
+	}
+
+	len = SZ_32K;
+	ret = btrfs_get_raid_extent_offset(fs_info, logical + SZ_32K, &len,
+					   map_type, 0, &io_stripe);
+	if (ret) {
+		test_err("lookup of RAID extent [%llu, %llu] failed",
+			 logical + SZ_32K, logical + SZ_32K + len);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical + SZ_32K) {
+		test_err("invalid physical address, expected %llu, got %llu",
+			 logical + SZ_32K, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len != SZ_32K) {
+		test_err("invalid stripe length, expected %llu, got %llu",
+			 (u64)SZ_32K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0,
+					   &io_stripe);
+	if (!ret) {
+		ret = -EINVAL;
+		test_err("lookup of RAID extent [%llu, %llu] succeeded, should fail",
+			 logical, logical + SZ_32K);
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K);
+ out:
+	return ret;
+}
+
+/*
+ * Test a 64K RST write on a 2 disk RAID1 at a logical address of 1M and then
+ * truncate the stripe extent down to 32K.
+ */
+static int test_tail_delete(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_stripe io_stripe = { 0 };
+	u64 map_type = RST_TEST_RAID1_TYPE;
+	u64 logical = SZ_1M;
+	u64 len = SZ_64K;
+	int ret;
+
+	bioc = alloc_btrfs_io_context(fs_info, logical, RST_TEST_NUM_DEVICES);
+	if (!bioc) {
+		test_std_err(TEST_ALLOC_IO_CONTEXT);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	io_stripe.dev = btrfs_device_by_devid(fs_info->fs_devices, 0);
+	bioc->map_type = map_type;
+	bioc->size = len;
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
+		stripe->physical = logical + i * SZ_1G;
+	}
+
+	ret = btrfs_insert_one_raid_extent(trans, bioc);
+	if (ret) {
+		test_err("inserting RAID extent failed: %d", ret);
+		goto out;
+	}
+
+	io_stripe.dev = btrfs_device_by_devid(fs_info->fs_devices, 0);
+	if (!io_stripe.dev) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0,
+					   &io_stripe);
+	if (ret) {
+		test_err("lookup of RAID extent [%llu, %llu] failed", logical,
+			 logical + len);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical) {
+		test_err("invalid physical address, expected %llu got %llu",
+			 logical, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len != SZ_64K) {
+		test_err("invalid stripe length, expected %llu got %llu",
+			 (u64)SZ_64K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K);
+	if (ret) {
+		test_err("deleting RAID extent [%llu, %llu] failed",
+			 logical + SZ_32K, logical + SZ_64K);
+		goto out;
+	}
+
+	len = SZ_32K;
+	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0, &io_stripe);
+	if (ret) {
+		test_err("lookup of RAID extent [%llu, %llu] failed", logical,
+			 logical + len);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical) {
+		test_err("invalid physical address, expected %llu, got %llu",
+			 logical, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len != SZ_32K) {
+		test_err("invalid stripe length, expected %llu, got %llu",
+			 (u64)SZ_32K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, logical, len);
+	if (ret)
+		test_err("deleting RAID extent [%llu, %llu] failed", logical,
+			 logical + len);
+
+out:
+	btrfs_put_bioc(bioc);
+	return ret;
+}
+
 /*
  * Test a 64K RST write on a 2 disk RAID1 at a logical address of 1M and then
  * overwrite the whole range giving it new physical address at an offset of 1G.
@@ -235,6 +456,8 @@ static int test_simple_create_delete(struct btrfs_trans_handle *trans)
 static const test_func_t tests[] = {
 	test_simple_create_delete,
 	test_create_update_delete,
+	test_tail_delete,
+	test_front_delete,
 };
 
 static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
-- 
2.43.0


