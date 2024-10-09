Return-Path: <linux-btrfs+bounces-8731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8469999702D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B381C224B6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CDFB1E1A18;
	Wed,  9 Oct 2024 15:31:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026337E765
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487860; cv=none; b=ic9nV2viYr+u0xWRZn8bdXhpo2c76NGxSzdRrqPJ6FfD/06c1NqYaTrvOUhgl13sF0IFah9RTukLQSSMI/wQX21QPRqRkkGr7Neq0WRyjzvDWCEMw6fb1vCZiO0hBTYLG7wPh0XBKWTak0Lor3hHy814LG+uUdXlAHfKakm2m/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487860; c=relaxed/simple;
	bh=MRa0Xsnz77pNiLhCEYoR1EBeH5Mtv2RodA2Bdeh5D0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDoD13MAL0K6KFD3ujwsl0v8R8qEwfN8IGR4qfEi4wFQugqabgxXGR4ARTKc0XU0B7Bi/ldDVHhvkaGyy3V9Qc7g0kWfCtO+jw47+ThQrl+Ur68H8Z+JIJRJEFfCui5mVaHQ33GcmkMdvjWq+I8p2asHORPPSFM7vglovoGeS0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cae102702so56327845e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 08:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728487857; x=1729092657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nshRKds/A6uq6snpucW4vdlyKaUmqEaKMZu+3of92Xg=;
        b=lzFqWx38KcBYyKUJTmib/EE5Le7kbENDPq4pOX1NKaHmCCeDcUDD7nRBatWl53Yki6
         N/TFCz82HWElA+yQdYQT18zEPoHGncNn7sj4FakotKNI+4HE4iNFvA6TmymLYaL6+Grq
         TP1zRDsXd+zTh02qkSRd52IBFe1HDeSyFwIsxBDIHQ7/rXTk+a6QfjhLrJAQC/6AXSP0
         Da4WaYPPztEz3/mgc/qifauBXPWrKNBLFJSQsYbCEHSdyLG9rOBwERBy+UHZ0fhlCcKB
         /LlAvgsCD7aFUygnEVB3ZEOC4eC5AAAlqEYKHPO/bwgkL/xNBZcnfbRypbHRDUgMdcN1
         JEtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh4sWcjRMKjIyPudouUJsCBLY5mpJUmWpJM5bKjwG7iGNW4IHjYJC0IiQvgbGcJgdVjxjgjuCVMR65XQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4fcK4sOV6IsDMciAMyyAhrs3+dC1Q6JaxoYsuR7zL91+bwNj
	2eaaQhOae18bKDXuDnLUR6NR9I/EBAplGZANk3jdmN0LoaTJZ0lX
X-Google-Smtp-Source: AGHT+IEd6b42DhNfQ1L5GNcwbkdlpA6J3Qr2GsjLh7W6+xqME9SVWRqxrPenGzmJlNYOTJH+PVhVpQ==
X-Received: by 2002:a5d:5745:0:b0:37c:d244:bdb1 with SMTP id ffacd0b85a97d-37d3aa57b97mr1753268f8f.26.1728487857172;
        Wed, 09 Oct 2024 08:30:57 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f724f700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f724:f700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d371b0731sm3252521f8f.90.2024.10.09.08.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:30:56 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 2/2] btrfs: implement self-tests for partial RAID srtipe-tree delete
Date: Wed,  9 Oct 2024 17:30:32 +0200
Message-ID: <20241009153032.23336-3-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009153032.23336-1-jth@kernel.org>
References: <20241009153032.23336-1-jth@kernel.org>
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
index b8013ab13c43..dafa6a9addee 100644
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
+			 logical, logical + len);
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


