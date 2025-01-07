Return-Path: <linux-btrfs+bounces-10772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4350DA03FCC
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD88D3A76EB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7885F1F3D3A;
	Tue,  7 Jan 2025 12:48:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224D1F2C2D;
	Tue,  7 Jan 2025 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254083; cv=none; b=nIm1ZOdE4XJaJsqbElWQP0Gj2/IWpTCv5aNE5C1IBGIE4Y5lhA+FnwGR4aEHp0Q4vuDcoSBjseGw8JkFPC+qZyZo445Y1OzeYBM236PK+X9oZ3Oc75NY/u3EtPwxD8X33+GFKQTXC2swUXSEQijdO94UiICVgz+3Fe3X+icXfnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254083; c=relaxed/simple;
	bh=dJgfFFrHMNX/wt/rlx1ta5IfOA20OE0pHFuC1mtWUk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPxVmSDBRShxEEnc3FjjnKpAqhPVWt+9s5U7+jxkIdH7jZSOPyfcZ08HCUN5VagfCTvF7P8d7rjoNWf4ttwec/QKSkVgpzTlRsVcjXb+cgEsBKmzN03Cg19UQC5BaOsN/lMBbrdkMKBO4Ds3EJphA7qfGofabfUJZT7t6RuMpQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43622267b2eso161824005e9.0;
        Tue, 07 Jan 2025 04:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254078; x=1736858878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71XSAwVnZXJGsAihpgV4sKSQDjM/13//Z7lrZY4oczs=;
        b=GSzypaHujIMjSkGDS55zDFPZGJ4e4J/Uf6PvgV8iSAs1t/lOWFxisYCj0CI2xTGsNG
         i2wocKn+HcErqksaKEoWV8A/J2Qs0D7b3xF96R5Nfq+mYVr17muA+3bMTIc8nJhQHHl+
         NeKZXRPfcWcDkopL7/qByooZPfLW962XF9lFm8RMSY2Q8RaZkuxznwD1GCJnjvaxkKdt
         cLPDgk4LUKux2CbROC9UVDWQZFKJAZOdi0E3TOOzFr0UoSP13m4J2ybI4NhaGWTLoXDd
         f/rRUt2s2nDxK4+X83cybb8xgz9L6a/b2v8QM/5ap0jKC5brEwMEI9RCC1qkTdEd2N2E
         WoOA==
X-Forwarded-Encrypted: i=1; AJvYcCWswjc3M2/vreZjAhOoWO0SlzpO5mtEglUwq9ADlbfNBg4VNOLBLoeQowoCBwOkSowbuG4DXbHZztb3NlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGQXzVBviI1sP9vdBhL8xKum2YjaN0AJfqy1yWPSSpGCLcEPQN
	OaVG0TFgLfLcgREUdDXUkBAaxg8BP4V4OQNP1qvy31+Wcv81N7to6+oYXg==
X-Gm-Gg: ASbGnctnAAQorUn+mjlyZk+zHKzmpHslDSuezwLLmZRca27ygi4TaYeDvIxeCv676R2
	bu3oyLjnkUDmNeOMcHLhdxVcwMLuCuxTne86yj+Lwt+MBwY6pCfTFsljbgbLzTW7v1rTLtha1T+
	K//5iQwmSXcSi3RsCPEYOOvep+vJedZAeYSS3RWpt1OHiD3zrJhQBoM3DCaoBmymtUttg/1/wBC
	wq2ujPYF4PAI4sw1NpNjuJ5NmlrdO1MgLzkTlTOm+QB1p2/9lNCwCC2xrZWG8nofUFfR91B4VSz
	E4foSD2ph3olV0PGuFatRaYN4TfvkNVQ8hUp
X-Google-Smtp-Source: AGHT+IFE1zt8adFn6ZNeImxchz/dBqGfM7brPaQ8kB+RQ76maEoS3xKrlZke2nAlEVd4ASdgKl1x4Q==
X-Received: by 2002:a05:600c:458f:b0:431:5632:448b with SMTP id 5b1f17b1804b1-43668b5e0c3mr464998095e9.25.1736254077792;
        Tue, 07 Jan 2025 04:47:57 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:57 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:41 +0100
Subject: [PATCH v2 11/14] btrfs: selftests: test RAID stripe-tree deletion
 spanning two items
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-11-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5465; i=jth@kernel.org;
 h=from:subject:message-id; bh=7tLwXx2q11gSgeKl57UDh77jQX1COSI4LUB0wCH0mGQ=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhUxfMt+W9nNobY8ScFxibahjZJM0qpE3hdRAlssn
 4SGakR1lLIwiHExyIopshwPtd0vYXqEfcqh12Ywc1iZwIZwcQrARJa9ZGQ4kXOFbetf73f/Gpwr
 8ywnRmxI+Vn7+t+cM+/Ydiv/n6HDw/BPabVb4NR1G+7PudNkXxvJeb3vVOJjp8qEpT8i7386cX0
 CEwA=
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
index 12f3dbb23a6423c4d224c5b087b35862b8d643db..a815fc5c4dd32e9b10844ad6df34f418c2e88ce7 100644
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


