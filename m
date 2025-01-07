Return-Path: <linux-btrfs+bounces-10774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE98A03FC9
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB0C1888640
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B69B1F1303;
	Tue,  7 Jan 2025 12:48:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11781EB9F9;
	Tue,  7 Jan 2025 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254084; cv=none; b=bMOe1Dr+eFC1YHelrg01MW5zadB+T5sArd1pg2dMloOD4Zd3jPsl8JMTyut8gx/YEll5++m0/9hjm3t+s/YzfLQN3EtqEdT99z8yGOYXrjzsyIa7STMmgGjGmxSlY04SYgQFdri7nxJxHPeono51T0taFflaWv0MFC9gFr0Kb3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254084; c=relaxed/simple;
	bh=7fuPeZ6eTkkUO02ONgT8YE81H5pgw5MM/PhBKMB8iwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7Bn3cfD2ITueR8VGk7+R83UUMzsUH5CT42WH12VCOYVT0zmF1Cp/oVlqCwjDPB2axz71wbg/ICGh1KPItBSEeglJk9xSDrmzIuM0cs/pIf3BICT+OQVK3e9u7CwP6f2fQS544WSY9olC1iUHcygYoYbX545FrbuxABKuHMlNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so153875625e9.1;
        Tue, 07 Jan 2025 04:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254079; x=1736858879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3PSh0B2ZMCmXCLngvICZw3M5+xhN20esGOtQ6jcvP4=;
        b=bm/wckDyHDbE/SkD456plGCNCOWOJwuoHCXlgYFpmLmkbTFr9L58eR8Y7r6eTNzmwR
         5QG3OgOQGd3Zd5cYjWBDuzk4MFQZ+sZkoZuV1BiBjrX93ZcH0QI9h2iycaxqMlkiCJVx
         kF0tRJ7VaHsTNG25/0gHuTHIb5rN521gSCbNczMpoPLKd+Ha0t5w+UjW7zy7qYoKuFJ7
         IaNWpfGRawRNAlogG3nv04GC9xqJjoUgT6IQEix/+QGndMh1hlTsrOi6SlUzFYERN87+
         F+lRi7gKDWqytesVroKNuvPuvOmq24/kblX9NY95GtdP7weH9TBDAECsBS6f7mGm95Rr
         l4LA==
X-Forwarded-Encrypted: i=1; AJvYcCW+NDCYXU8XWzJpjhNLy8Poneq8qMwEMCJ7Q0TWrZ94X4qUZTBz5+UlWYIL1j56Xk8gHBf2671pW/fJN9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XCARLlFmiNP5TPu/x22PBguEZNqlV1rNwNLPhmUclihFGJyc
	FFm6hVIa8qGvf8A3CFCU3Q8EixyCqf0nOOhSvPfqD20+hTvqsOGgrLLJ3A==
X-Gm-Gg: ASbGncs0VUhptQESJgiINPTTIGE5c7mL/OPNlkrhU8ZsrBapv/GxtNlqMU3sNrNUyEV
	ys068Oi7CmA1xTBhZljCXEUDpjFiVJOKQJoCPQiFdyiQhbHG0PpZlnX2Xz7NWL1N0B2Ix0fsX80
	dhMl8kYoPCOy9/myvpVnfBL7OqaN+3rcGk203glCMFd0gDHZEyjRXkxpfXuoNT5tyLHBHJGgkHV
	e9Q0N6Oxiu0wh3MrtCynLPiYlENa8Oh9pqXQN1a0Lk4/XD2/bhFrmtXJ293yjtZ0+mHt5Tt6iiK
	u4RqeiwsEbYN7z1XUe0WUJUdxiztVgDIgNpY
X-Google-Smtp-Source: AGHT+IEibbKn9hcgmS1QMfr2XH3bhFZ5hAEFO6m0eanFwsoqIxybOxoK7gS5p5sQlsqzB6jIa5AkPw==
X-Received: by 2002:a05:600c:a0a:b0:434:fe62:28c1 with SMTP id 5b1f17b1804b1-43668645ffdmr568238375e9.18.1736254078686;
        Tue, 07 Jan 2025 04:47:58 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:58 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:42 +0100
Subject: [PATCH v2 12/14] btrfs: selftests: add selftest for punching holes
 into the RAID stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-12-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5069; i=jth@kernel.org;
 h=from:subject:message-id; bh=EVHDj16oSZY+6HbUp0NyPkXxXTNMaQAqUAlZnYdPi9g=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhXNOhCxV9u92OvQIm2Dgi07dGZvMD6X++GznqX68
 mczpfmOd5SyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEcnYw/PdWOS3ExS0TLfUh
 V/u22Pc5klsk7tZHuxxOfLlz03uOlEhGhibWRde/zwrfF9TulMaqedtTtElukt+xryo2Qqeztkr
 zsAAA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a selftest for punching a hole into a RAID stripe extent. The test
create an 1M extent and punches a 64k bytes long hole at offset of 32k from
the start of the extent.

Afterwards it verifies the start and length of both resulting new extents
"left" and "right" as well as the absence of the hole.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 140 ++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index a815fc5c4dd32e9b10844ad6df34f418c2e88ce7..c7e44e944f5ecc37ffb937237cb81fefbafbaf9a 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -31,6 +31,145 @@ static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_devices *fs_de
 	return NULL;
 }
 
+/* Test punching a hole into a single RAID stripe-extent. */
+static int test_punch_hole(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_io_context *bioc;
+	struct btrfs_io_stripe io_stripe = { 0 };
+	u64 map_type = RST_TEST_RAID1_TYPE;
+	u64 logical1 = SZ_1M;
+	u64 hole_start = logical1 + SZ_32K;
+	u64 hole_len = SZ_64K;
+	u64 logical2 = hole_start + hole_len;
+	u64 len = SZ_1M;
+	u64 len1 = SZ_32K;
+	u64 len2 = len - len1 - hole_len;
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
+	if (len != SZ_1M) {
+		test_err("invalid stripe length, expected %llu got %llu",
+			 (u64)SZ_1M, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, hole_start, hole_len);
+	if (ret) {
+		test_err("deleting RAID extent [%llu, %llu] failed",
+			 hole_start, hole_start + hole_len);
+		goto out;
+	}
+
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
+	if (len1 != SZ_32K) {
+		test_err("invalid stripe length, expected %llu, got %llu",
+			 (u64)SZ_32K, len1);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = btrfs_get_raid_extent_offset(fs_info, logical2, &len2, map_type,
+					   0, &io_stripe);
+	if (ret) {
+		test_err("lookup of RAID extent [%llu, %llu] failed", logical2,
+			 logical2 + len2);
+		goto out;
+	}
+
+	if (io_stripe.physical != logical2) {
+		test_err("invalid physical address, expected %llu, got %llu",
+			 logical2, io_stripe.physical);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (len2 != len - len1 - hole_len) {
+		test_err("invalid length, expected %llu, got %llu",
+			 len - len1 - hole_len, len2);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Check for the absence of the hole. */
+	ret = btrfs_get_raid_extent_offset(fs_info, hole_start, &hole_len,
+					   map_type, 0, &io_stripe);
+	if (ret != -ENODATA) {
+		ret = -EINVAL;
+		test_err("lookup of RAID extent [%llu, %llu] succeeded, should fail",
+			 hole_start, hole_start + SZ_64K);
+		goto out;
+	}
+
+	ret = btrfs_delete_raid_extent(trans, logical1, len1);
+	if (ret)
+		goto out;
+
+	ret = btrfs_delete_raid_extent(trans, logical2, len2);
+out:
+	btrfs_put_bioc(bioc);
+	return ret;
+}
+
 /*
  * Test a 1M RST write that spans two adjecent RST items on disk and then
  * delete a portion starting in the first item and spanning into the second
@@ -612,6 +751,7 @@ static const test_func_t tests[] = {
 	test_tail_delete,
 	test_front_delete,
 	test_front_delete_prev_item,
+	test_punch_hole,
 };
 
 static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)

-- 
2.43.0


