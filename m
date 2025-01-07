Return-Path: <linux-btrfs+bounces-10776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B57A03FCE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C041643E0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649DB208AD;
	Tue,  7 Jan 2025 12:48:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4663B1A2;
	Tue,  7 Jan 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254086; cv=none; b=sZK/ZsZ9IUHhGBPh3/ijz8tve0lBEtikfgSyLJC0ypdH8Wb16NErmStH46FQkrx5CUPbvXepidD6LOCWyGI6PWjTWu9BbjidfjEp7kHdJUCXSXJ27frRjeQ7JqeTUMRCc/PBeGu1TqZFWrXB9Nyt0Lz6AWu0ssBv/wA9Ux6h5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254086; c=relaxed/simple;
	bh=O6xA0U6e8EcrdV9gBkOcBpJ1iaQ0NLLesxhyKpoD70U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWS5o0VnYxmyL7GTpblcW3zNe1/MNZlW68ZPOo5rdlcjNtosLZ7m6E1n09oD9zM9O76gsjtVQfXDLONjZsB3CyaFZeHVAhOxS7Z5T6KqLBtN7G1Cfc2iTqaffQE8S8KFB+ukM8cLx3zhe+4GDVdelgDEDNegOzhUoFWBmPQBsbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43626213fffso95831995e9.1;
        Tue, 07 Jan 2025 04:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254081; x=1736858881;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VjMqnnPdmmXdxnSjbPvoY1ry5RF8O2XMIoYq3Ycrjc=;
        b=mIXpY/89rKlVtV2fLHeSe/Zcp8itPIfbLkDJZwZaYmDCqtHmgPiBf+6yTKBZOZw3Ls
         xU0XYEeb3NPPI7fjWmmt03NLixgQjTM/og3n3FnpnuqyEuHsjp3r5vIx8yyVSEe/R0mw
         HdZ8j+WBN2HAFw+ei3nJT3gKWzlD+vaztvzkE3u07rdBk+HD2gCgC/XyugD+9ixbQzZr
         cYKFSS9zyodWxbgrTjCGTBT0kBy/kVQ8HP6AmGGyDKcnklBQbTBqGQiOQxH8qHUzwMzR
         7Eigv03OJSqIOtkxNtGNQHzWNuxqh1fZ//p0SfrP4PVB0feuRWWAG4K1LLtEdRzZFusE
         gPaA==
X-Forwarded-Encrypted: i=1; AJvYcCXkHqyke6SQjpJbs1qmWAByLMU9KVQRu3YQfwjWHU+O/Gje8Wcd6qKrjWUbCtz9POz2ZDDVnyK9Ar5/kdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHZ5eEqAVQi7nD4Zir8nncGTkxNt3A9oCE5Q4IiE2RQD9VpY8
	y5di/S/Irc499bW3FXAJV+jCbyIY7uwDVi9FqT/kYrhTAgU8eQPYkR0/1Q==
X-Gm-Gg: ASbGnctR15aAehsBePRaYNe3RUmNpLFGoKT0C/UAekNWgyHLg/J75ACUiQ1ew2eIlJu
	ujt5CtjuoNYL0MzvQT/udaEpZSINvfNwtSJxKK8zO17Gh3Vg3WAyYCkjoobLT877hpaze/klXjv
	rtenYhaNhvdt4sBzWh2NroZQNHJ+lBrgBveV71AG22gJ1oXWySzZruygaWE8gD2Yw2MB8pLxVbj
	WF1GitIiQ4lhsnE71XUbt+oO75yh8lf0GHSvgNTRMQDkUEBkcnaNKJE8lHQ7xY61ZBzb46A2Kof
	+2+dmLWhTtLZR8TmE9ud9/ssuDfEJ8zM0MM4
X-Google-Smtp-Source: AGHT+IFFzkQfEutSaulWgleGeMdH07LAqYJkY4OqPNG733r16FrxfeBQW7cw+kks76sIu0BKQhFUPA==
X-Received: by 2002:a7b:c8da:0:b0:436:51ff:25de with SMTP id 5b1f17b1804b1-436dc1c7f41mr25500305e9.7.1736254080618;
        Tue, 07 Jan 2025 04:48:00 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:48:00 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:44 +0100
Subject: [PATCH v2 14/14] btrfs: selftests: add a selftest for deleting two
 out of three extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-14-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4970; i=jth@kernel.org;
 h=from:subject:message-id; bh=tFlMhQskj89bb4c6eNa63cULusVqX4eFepmYM+2AqgU=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhVNli8Wdvuy/KLw89o/O3ccvt1yNpexNkjFfEn8q
 atMR24Zd5SyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBELFwY/sftzb+tOf3MgZPl
 j+arvgk9lvXUff6GMv2ErYvkZJ8LaB9hZOjyS98j/mBx5tyirBOcmbr+9hsL0mXSc1kErkz4suW
 XDx8A
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
index e12b6abbfd2be66170d33ab13b1e0971444c0f9a..6c7e561e55641472a63bb15c8c2213273111ad08 100644
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


