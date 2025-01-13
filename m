Return-Path: <linux-btrfs+bounces-10954-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E3A0C191
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 426757A3F45
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A921FA8C5;
	Mon, 13 Jan 2025 19:32:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C831F9F5F;
	Mon, 13 Jan 2025 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796728; cv=none; b=KUDXEmXU4KAZl4i0gGm6qliuCw/dPUdfJ+S80In8nhAk1ybZvAG6B3tYLF4bMsQFOuPChnlAp6frKZaxx9nGNAoRxZDaH5p18fDb5KR2mv7Y3GRXcKg3Ej8tPUNUaYZfHH/V4x7PRtp6v8IEmHwvpJIj5iXDt2MQd7XOU4gwCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796728; c=relaxed/simple;
	bh=a2D31HL+b0vBvzMICTsCYmbMeh0kRcWFFuv01Ss+Nsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iNy5grh+2yvoto4krgMolmeFzct9GpS271LsCHqXKV6GRoqVOKuHu4hCrc3RHLES6j2TyAumMAlTvuxNM2TRqNsCqhAWwX+FWQ7w51PetOOdW6Ewfb0JnmDujoUJsp4kKaWyw7yEwKCQ3tICqohA43Sl4VNGW7toJeGfR1+plKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43618283d48so33903585e9.1;
        Mon, 13 Jan 2025 11:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796725; x=1737401525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K3V9QWHXuJ6xxtV+RQPaKdykPic91LAByNAfLRmofA=;
        b=m10UW+A6qAM95lWaJBGn7QXL8T0H0bYNxFVNJ6z6DVRg4iSt+Oqviu9aowRjPctD00
         ViU26qtbM7S0u94AYFMn3X9QB5s3+TA6tAUwtaeK31ddwZ5HDjojkGRuvFNSN0HSEXeg
         fgbfPToo3dGgmoZh5WcvFbhmgFr+8FC3tMXM+xG3tYFK9HafUIEpzHHexFSxnZ0tcbEb
         lKP2Rn0krmwgZaYQGIISJj5xO0sawNHgk1sizGnjoAto/KLRvkc2pUYSOEIvSFRYXuMJ
         K6LNLxPiLEMfd/+GrFLOrgzm0rOr5Sz12UFl9t9qXr6l5ay1GTmno4N9pVZBxnw1nIip
         EfSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGGS6+D+/PeTbkA3pUQTAgkBUb1pplqsuE0rTIwZAblhcA3H3JA5BJmJFOPI4V+uexDaIsnB9kYSuA/A==@vger.kernel.org, AJvYcCWJMIfb6P5DHwH5bz+9rZ2/Rd/9gSdYp+GsXBdJa6C2H5y89XyNLizQhRAYDZL+Qm44+24QVpUHzRoIaJpM@vger.kernel.org
X-Gm-Message-State: AOJu0YyG/sN5RjRlDl8Ddl0gcjEoJuNSjFcSgHLmBvG2pKgeEzD0tRK6
	SMEv3+ZBoe5W45g03P+jJ9H4r1fLxuwfsr1O+mSNN/z0mdukR9LB
X-Gm-Gg: ASbGncubvnMA64LvF80CZ8nIVX2E6I9Q7OL57e7v/Xk/FWsdO0w3ht6XJetKAd2lkxH
	Hf2iWGTfLe26Sv1Aygl5izkkHaqV/zRVhdC6tA8WlcRR1nIUXog1xPVPwntkENYATIT3i+M3FOu
	QpoFgoHrO/jhRmRRMBqfuWXAmP3FL253+ndX0NCN5RQhgW8kdUzJvFDksxxGQhmllbauhIqamQQ
	MhrQ8hxKFiP+k7UORCArMabDX3qWpHZSEM/K5rslIbCgXtTFVSrOgR9is8lJ0sd1UItH0sRLb/M
	o9c2gt79rcsIYmRdNfq+lL6Jv9YWp06+M/ME
X-Google-Smtp-Source: AGHT+IECICG4/4svbFau6OhfM7ZxsVqENRXoVHnUqWgFHHujcfqFYh30eFm+SDAgYy2WONz8UOHUXw==
X-Received: by 2002:a05:600c:4511:b0:434:fe3c:c67c with SMTP id 5b1f17b1804b1-436e26e51eemr177438345e9.26.1736796724621;
        Mon, 13 Jan 2025 11:32:04 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:32:04 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:55 +0100
Subject: [PATCH v4 14/14] btrfs: selftests: add a selftest for deleting two
 out of three extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-14-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4970; i=jth@kernel.org;
 h=from:subject:message-id; bh=xQRMlJYgYbM7Yr+yNmYmjqxYz5n1mdnAiVjmPu/CZRg=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3ZqnZGGz/sG697OK8Wx9m8TI2Xzuhd0NNPNhzW/jrU
 7VTOLxdO0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAivxwZfrModXs7GmT4Hu+W
 PfnrlxuXkccen8PNNyQXntFerPL5ZyQjw9wZ/+v/C/MnPzhiH3Ln84I5eW5LKipFhO2OT3qscqU
 9iB0A
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a selftest creating three extents and then deleting two out of the
three extents.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 144 ++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 6365cf1e08a5d0d2e6b11a219d292db02275eb70..6f4eeeb8d4563dd75d436e0fa38fec78ccdc79d0 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -213,6 +213,149 @@ static int test_punch_hole_3extents(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+static int test_delete_two_extents(struct btrfs_trans_handle *trans)
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
+	 * Delete a range starting at logical1 and 2M in length. Extents 1
+	 * and 2 are dropped and extent 3 is kept as is.
+	 */
+	ret = btrfs_delete_raid_extent(trans, logical1, len1 + len2);
+	if (ret) {
+		test_err("deleting RAID extent [%llu, %llu] failed",
+			 logical1, logical1 + len1 + len2);
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical1, &len1, map_type,
+					   0, &io_stripe);
+	if (ret != -ENODATA) {
+		test_err("lookup of RAID extent [%llu, %llu] suceeded, should fail\n",
+			 logical1, len1);
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical2, &len2, map_type,
+					   0, &io_stripe);
+	if (ret != -ENODATA) {
+		test_err("lookup of RAID extent [%llu, %llu] suceeded, should fail\n",
+			 logical2, len2);
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical3, &len3, map_type,
+					   0, &io_stripe);
+	if (ret) {
+		test_err("lookup of RAID extent [%llu, %llu] failed\n",
+			 logical3, len3);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical3) {
+		test_err("invalid physical address, expected %llu, got %llu",
+			 logical3, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len3 != SZ_1M) {
+		test_err("invalid stripe length, expected %llu, got %llu",
+			 (u64)SZ_1M, len3);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, logical3, len3);
+out:
+	btrfs_put_bioc(bioc);
+	return ret;
+}
+
 /* Test punching a hole into a single RAID stripe-extent. */
 static int test_punch_hole(struct btrfs_trans_handle *trans)
 {
@@ -935,6 +1078,7 @@ static const test_func_t tests[] = {
 	test_front_delete_prev_item,
 	test_punch_hole,
 	test_punch_hole_3extents,
+	test_delete_two_extents,
 };
 
 static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)

-- 
2.43.0


