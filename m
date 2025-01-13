Return-Path: <linux-btrfs+bounces-10951-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8690A0C18B
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B15188ACC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E51F9F51;
	Mon, 13 Jan 2025 19:32:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D961F9423;
	Mon, 13 Jan 2025 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796725; cv=none; b=YzqqpOVhn/goOF51UfI/RFHzcq1lkrDw3dSyDlQ+ydz98vHICGFAa7UYP/97ooypzU3TJvCpcnMLXf0CI3yDNs7uGUZ2YLpUjoAPZk090CMG8hSMNSNRg4qrRuxTvN6mOt/G87Fk1abSNoIwY2o3p++FofJJboHylTv3E5z9Ww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796725; c=relaxed/simple;
	bh=gDP/I78MDlAkYzglHE8sONICC/MAn9JP0XxUPCQ8Yyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BfNAr6/d0fHwe0EpMUplue61PrfXYeJdTWrQ9P2+6h2ObhO94HttmXLX4aG8Vn330qQKDGcZIBgz08dSZyZwgxhe94zkVgAt2QJ++tJ4kComZAPW2cQb9gTG90c3lt+2vPuhTVzRkDuCAeNFDgFXPHX9xTeuHy7LDCrms9mk1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361fe642ddso49410925e9.2;
        Mon, 13 Jan 2025 11:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796722; x=1737401522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf1MZZCNyGnD5eJ+FhAWK0BfEji/54ltHeaNcuHF5kY=;
        b=IwwcEEblDAutlHquQAS7u3auG1eY0gY9fZATRd2QR0rwSzHWvlJbLYBRQBpnu9UA7n
         5O/b+aBnA/edIhumxnQrU9cpR3zixHxndlFozMyvMcdWVFx8OiW0/WPesC/GpBejUT1j
         9GWmHkHZnSEDNGM54EOipu5iBb6enOQPkdDrA+m+J307Z0FPMpZh6nCNfjDwcS26b30x
         2/j29jNrfbKk/ghhUKAwWBlWHiHkkRvXYJYZBZ2m/vkZOZRlMiz52mYIBhw2lT0NoRlc
         cniol5gcwCKvVCdhSKOclaoQR1ih5MMSd7qLHp/BgqnIICz4YmN7iQLpkfgsVfoOopne
         UcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW11FnePCKL94iZIH4W8kOzTts9yF/1MPRl8U3dIfyluys9f4hRLhGgrkrk8FWVta6jj2tY7Xk9qWSSiQ==@vger.kernel.org, AJvYcCW5Hk+iAAbLTUk2LYg884IneLBgS27vTRIyW1ysDkv/iuQrH8Cj48vVAyLXu2DJ7EEoxoCGsORM4OoW0kJb@vger.kernel.org
X-Gm-Message-State: AOJu0YyfkrJmoE7fjz6eA9OYYaSxOgoM39vxh1JeCUoO3eAekEsag7sl
	5rl6h2/ev98H7eaMH2YKYg+u9hxMxGZi6JOyW2YNjEOPH6DfJOVJ
X-Gm-Gg: ASbGncsYVncsF7pirtCbuh2aKF95lnJReKW5bFDqHAhcr7oktfDdCfWzHX9xaIVZCaz
	cTDlyMke8du9YLmFOq3npEyzYWg/mdVmq8YQ25SA29sIeC65AmqNakUaN60Y8Whnwy7E0vQ9Iyd
	vJT9sl2LDUaW6Wqw62PZpyRuhDbHKePxGk2DDFum9vExj6xNGtETmGF1EHSMA3NQ4vxEgLgEsJr
	Shtl+tPuwSLMkobFOWx7WbrUlsr/JcEcxzhVnMmnKLRq0u7doeCpIRrqtgxwA144NEkxr12H5+x
	W0hI6m1+AKa5LfvKNZ8vK03Uo2gMQ6Lf5ZEQ
X-Google-Smtp-Source: AGHT+IE/miXKCD1BKJ2B/xBdPFfZ4alKznPnzbQZ03Z/A8IGeSwhFyZYyEW9vkUwgNIT9nkeqGCEzQ==
X-Received: by 2002:a05:600c:1c84:b0:434:e9ee:c2d with SMTP id 5b1f17b1804b1-436e26e2725mr176538155e9.26.1736796721873;
        Mon, 13 Jan 2025 11:32:01 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:32:01 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:52 +0100
Subject: [PATCH v4 11/14] btrfs: selftests: test RAID stripe-tree deletion
 spanning two items
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-11-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5465; i=jth@kernel.org;
 h=from:subject:message-id; bh=Pmlf4j9IejX6u5oXvfLGlm5RsFbWv1KD23mgVZl/JvI=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3ZqneEJ8kydOluPQo31aOCD3BKI0X5nuNO96tD8733
 O00Uy2mo5SFQYyLQVZMkeV4qO1+CdMj7FMOvTaDmcPKBDKEgYtTACaS9Ybhn8lDczPxSWvf7GWM
 OKzh9Z3bdcm26VM/6D5lmjqrkc+6/Qsjw22Xv2t97GUqfxzRbZhxyTGfSeae7Cr+7HVMV2X51p/
 qYAEA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a selftest for RAID stripe-tree deletion with a delete range spanning
two items, so that we're punching a hole into two adjacent RAID stripe
extents truncating the first and "moving" the second to the right.

The following diagram illustrates the operation:

 |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
 |-----  keep  -----|--- drop ---|-----  keep  ----|

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 144 ++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index da73369a79b41d90cd05bc1c8c373d1ef5f253cc..2138d7561f40efed5449ebd9ae66aa6adec4858e 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -31,6 +31,149 @@ static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_devices *fs_de
 	return NULL;
 }
 
+/*
+ * Test a 1M RST write that spans two adjecent RST items on disk and then
+ * delete a portion starting in the first item and spanning into the second
+ * item. This is similar to test_front_delete(), but spanning multiple items.
+ */
+static int test_front_delete_prev_item(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_stripe io_stripe = { 0 };
+	u64 map_type = RST_TEST_RAID1_TYPE;
+	u64 logical1 = SZ_1M;
+	u64 logical2 = SZ_2M;
+	u64 len = SZ_1M;
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
+	bioc->map_type = map_type;
+	bioc->size = len;
+
+	/* insert RAID extent 1. */
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
+	/* Insert RAID extent 2, directly adjacent to it. */
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
+	ret = btrfs_delete_raid_extent(trans, logical1 + SZ_512K, SZ_1M);
+	if (ret) {
+		test_err("deleting RAID extent [%llu, %llu] failed",
+			 logical1 + SZ_512K, (u64)SZ_1M);
+		goto out;
+	}
+
+	/* Verify item 1 is truncated to 512K. */
+	ret = btrfs_get_raid_extent_offset(fs_info, logical1, &len, map_type, 0,
+					   &io_stripe);
+	if (ret) {
+		test_err("lookup of RAID extent [%llu, %llu] failed", logical1,
+			 logical1 + len);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical1) {
+		test_err("invalid physical address, expected %llu got %llu",
+			 logical1, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len != SZ_512K) {
+		test_err("invalid stripe length, expected %llu got %llu",
+			 (u64)SZ_512K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Verify item 2's start is moved by 512K. */
+	ret = btrfs_get_raid_extent_offset(fs_info, logical2 + SZ_512K, &len,
+					   map_type, 0, &io_stripe);
+	if (ret) {
+		test_err("lookup of RAID extent [%llu, %llu] failed",
+			 logical2 + SZ_512K, logical2 + len);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical2 + SZ_512K) {
+		test_err("invalid physical address, expected %llu got %llu",
+			 logical2 + SZ_512K, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len != SZ_512K) {
+		test_err("invalid stripe length, expected %llu got %llu",
+			 (u64)SZ_512K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Verify there's a hole at [1M+512K, 2M+512K] */
+	len = SZ_1M;
+	ret = btrfs_get_raid_extent_offset(fs_info, logical1 + SZ_512K, &len,
+					   map_type, 0, &io_stripe);
+	if (ret != -ENODATA) {
+		test_err("lookup of RAID [%llu, %llu] succeeded, should fail",
+			 logical1 + SZ_512K, logical1 + SZ_512K + len);
+		goto out;
+	}
+
+	/* Clean up after us. */
+	ret = btrfs_delete_raid_extent(trans, logical1, SZ_512K);
+	if (ret)
+		goto out;
+
+	ret = btrfs_delete_raid_extent(trans, logical2 + SZ_512K, SZ_512K);
+
+out:
+	btrfs_put_bioc(bioc);
+	return ret;
+}
+
 /*
  * Test a 64K RST write on a 2 disk RAID1 at a logical address of 1M and then
  * delete the 1st 32K, making the new start address 1M+32K.
@@ -468,6 +611,7 @@ static const test_func_t tests[] = {
 	test_create_update_delete,
 	test_tail_delete,
 	test_front_delete,
+	test_front_delete_prev_item,
 };
 
 static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)

-- 
2.43.0


