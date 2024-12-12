Return-Path: <linux-btrfs+bounces-10303-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56849EE0B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F561889506
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3DC20D4E1;
	Thu, 12 Dec 2024 07:56:10 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DD420B7FC
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990170; cv=none; b=Nk43nRTIs5Zj8xxIJRRNYKgUGCXUyrsMhIhH/nemOLYu6XC9ql74mwkZwQJpr23U+g2x4XNOUlx6OjPqbQUinqdKi3gkDud1ZZCNCns0r5aa3GC73eVTDaAuDQZTGsLZA0AUYwDOotj5j5FEibVXsKQ/FucB1/45Wki3cuaVWXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990170; c=relaxed/simple;
	bh=lsalZYTX7Yfe+Z2ikNJkiwDQeUMbpgUuww8qUyEQH1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEFMQXVgT+4inzeyNiSe55IeLXs7zmiH4Z4bTQE4eXrSgQjGcegWblkxUKhrpePfVPKljhe4FYpONbGX3ALOmV6kFjGARQnaV/aSujF7USK8iuHfzobkI4AdqfSsM+wbB8a7CJPVuy+/MMvdTAJmZqv4IEOdQtvfgTI8RDQ1870=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa6aad76beeso43439966b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990167; x=1734594967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGBSaj/NTtT7gerNC19D9yN2B2q1gfc9/emRAxeQxqI=;
        b=lXJQTpjXOkEjVo94Hreg2qhTIpxCb45KchzZlW8OA0s7shcj0vBMUm0+tfg06AKSHU
         fei8EApDTc15Jp53xcrPPJNGQs61OYo7AH7F530ni3xdE038vEVxCEVb2tQBGMfEiP7U
         Mn3QD6J78za8XLg3sN8vWF+se86mETl9soXwpHp3lVUkYGKiucGJvjM+xGzgogSDCZgh
         Q1McpBRgz/RGEXPDluNefTEPaveO8g8nd3pKSXDISmjcehL15eK9goV85mAAU7grC0OT
         VwyuMu+KV4PTtUSC3nGSQKky+hhgouqB+lmbz/9ZXrzGOhHD3RrAI5Pz4c693PM/iR6Q
         9R9A==
X-Gm-Message-State: AOJu0YyLWrwSSIEE/hC/GSeDGV92vTB2ip8/u3mQ91wOazQLaBwzv0Iq
	OP6YtJVTzYk6A+w9snZVpXjHwV3qIFKa9BwJoMHF6R4TyAXBAz7H/931bN3P
X-Gm-Gg: ASbGncs7y4/+X8nEUkWS6wS2KWVcN25xtLjumK4WkadUQZwXjvyF3MbYB2ogkP0c/Nv
	iNLITUOe9ZgBaszBQtx785KDGCu9k1JenckFSPgmYSzoPnOK0G34+4pKpc8cccv8qY3UL+2Q8ai
	AKwnKCsF2EpG1McvITsjjr4xMGJWbdQpImJui6qQIumre9KOhNW4ohR1TxzQPaH3tyW3Jzy7CVS
	SkRfJvo0JR3YCIorWBakIhkx9M7opylknAKs2bFGGTXmhB5kUY2rtMBZA9BK3ar+JfxuzHkw27f
	4JWeUjLtHRWa9ZjVoqZQCK3zE6bpst9MZzZD+Hg=
X-Google-Smtp-Source: AGHT+IETe7PekR4qdpeocSdh/fn6qpJyEaOIH36n93N/VcYaDjb3+TEKz4fSUijHpFmjHHLzw7dquw==
X-Received: by 2002:a17:907:c912:b0:aa6:7cf3:c6ef with SMTP id a640c23a62f3a-aa6b1192f5dmr471598066b.15.1733990166739;
        Wed, 11 Dec 2024 23:56:06 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:56:05 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 11/14] btrfs: selftests: test RAID stripe-tree deletion spanning two items
Date: Thu, 12 Dec 2024 08:55:30 +0100
Message-ID: <3f5da94fb0a98e09556468efdfff1cd7f71495c5.1733989299.git.jth@kernel.org>
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

Add a selftest for RAID stripe-tree deletion with a delete range spanning
two items, so that we're punching a hole into two adjacent RAID stripe
extents truncating the first and "moving" the second to the right.

The following diagram illustrates the operation:

 |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
 |-----  keep  -----|--- drop ---|-----  keep  ----|

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 144 ++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 12f3dbb23a64..a815fc5c4dd3 100644
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


