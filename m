Return-Path: <linux-btrfs+bounces-9098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BF9ACB25
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 15:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17120281209
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2024 13:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A81B4F10;
	Wed, 23 Oct 2024 13:25:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB41AE01F
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689937; cv=none; b=Gb0jateNtOL7OagspMIcMRJBRZNePvX+MbKHPgie273KMQGagURGc9ZU2Vb6QcFJaDqmGrAQDDdyHjthC479dlCBQrJCiStQB9E4gFPvDVam4bNVY4eRGeZDtJuVHsWvy4n3uYeGJmIXzgclVSf/qTBUf+JSNHi16uKbnWV+SLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689937; c=relaxed/simple;
	bh=ZnzJXlhc0bppR72gW2t7UcqKfhOAKrqOiO0mycFp3iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Akwnd3dSl2RXuKMhr6kBVhGhLlJis5C2FcHiWkM66sSZLmtY/ClLYGpXaKkTVzaW5pkCdzJvOD5skEZS6sK7HcRSxF2w8TlgNFuEJG4QTzPTLrn2ucmIUc6qv+ptoJ8tw+iDhh+sdyL0xAb+FWBWZrVPcCEqDyWj3oaQpLAQk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4314a26002bso74983645e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2024 06:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729689933; x=1730294733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SF+oPGug6oBwKe3l8fZ5hC8uzrur/uUkBJvgLvpeq8=;
        b=kNOWTlWkXb4aE58QDV8TQdj15hDjfM6soKOJTxIMWH79l0KRvu9MDiBArKxQApfIIb
         LEZG/9qbw3gC2oJj/nEcvaqz/tQ3NLIOZMxz/hYe/mu+6kb1bJMMgMaUVqdrXDJJwpXS
         iGIDRnnCJ7POUKAtET5vW66I+u415VZnDcGF/nLDsgEmMV3flNL4iueRlmvGycoMimUy
         8C07hXkH3J7EDpID4+0/hvm0kkuTfPctA+VNo0vBOT9vAnK+NsYRztjMYmRSaBI9LOzq
         w+VUfsP+7c5Zb8kemTmquvpwxcT2KNjO8cTnfkXxJjSFJougquQ6SGdcMgwauHz+LThS
         sOgw==
X-Gm-Message-State: AOJu0YyI5eW8B5DW+pbhY/lZ4YIAWtKdF4gfIjoocGI1sCBBNyI5QoEp
	E+F4EQ5hiN3e1hm98NwpoNehDbS7ZI83Ydz6GChDTEWV1s/mVCrGbJ07nQ==
X-Google-Smtp-Source: AGHT+IFP31p+/Asqg2FGRBq6CmM6gcw23I/blIWX+GiV3yxH6EWanqV1JL0bihAC1qMl6BYP2ujfqQ==
X-Received: by 2002:a05:600c:1e28:b0:426:627e:37af with SMTP id 5b1f17b1804b1-4318412fd23mr25227595e9.3.1729689932621;
        Wed, 23 Oct 2024 06:25:32 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c1e387sm16169935e9.41.2024.10.23.06.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 06:25:32 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 2/2] btrfs: implement self-tests for partial RAID srtipe-tree delete
Date: Wed, 23 Oct 2024 15:25:18 +0200
Message-ID: <20241023132518.19830-3-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023132518.19830-1-jth@kernel.org>
References: <20241023132518.19830-1-jth@kernel.org>
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
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 224 ++++++++++++++++++++++++
 1 file changed, 224 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index b8013ab13c43..3e6932de5623 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -29,6 +29,228 @@ static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_devices *fs_de
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
+	btrfs_put_bioc(bioc);
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
@@ -235,6 +457,8 @@ static int test_simple_create_delete(struct btrfs_trans_handle *trans)
 static const test_func_t tests[] = {
 	test_simple_create_delete,
 	test_create_update_delete,
+	test_tail_delete,
+	test_front_delete,
 };
 
 static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
-- 
2.43.0


