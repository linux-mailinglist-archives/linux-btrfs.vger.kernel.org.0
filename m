Return-Path: <linux-btrfs+bounces-10775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C13A03FCD
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894307A3982
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9041F4290;
	Tue,  7 Jan 2025 12:48:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22AE1F2C58;
	Tue,  7 Jan 2025 12:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254085; cv=none; b=SeiCYPcPDX8bnBhBiWoYFRCoLpXkoChJb+Wpy0MTNIMonAYs3p3zn/hhGrQ2QM4J1JitGj5TYpHYY6dreY34gCSdwDmFdKZrirJdZLNMlpHlNli2KN9El5p3Vaqq4N+/kpnDI/N0urKVAUKNavJ1e8KCdcPOFzdMQQF9ZDZVEvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254085; c=relaxed/simple;
	bh=1AB4jwcI+lHYlYRcQqkQHVIt8MBO3ki9zuAxI9V49EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S4CX/iP43VuApK50ZV+lXHKBXy0quKLaFO3o5CqxW1ng54IGnELdseTim8gS0TRsAe+XL63SzQimZWD3jpI6mgXwu5Yn+AyFi2uJ7E0ohsjn65pFemRncEEhvxJpO1xOttddk5qoIi9yMML4QiVpo1GPh985Yi43HFxSE7XF7jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-386329da1d9so7208948f8f.1;
        Tue, 07 Jan 2025 04:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254080; x=1736858880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5zvsivh78DDNjeh2ZcSnXDI0hKH6mj4dodObFPkjBY=;
        b=aXZdNtK+BZ5MScjflImVcIgXr0wG7u3elg6bd4+ozcHBfSPaRd2f7BdgtclGbRbgyZ
         4rd9QbHuO23Gyn99fsE9TfuxR4sZtJqSd9OfkZFQ/I4wi7Nkfa2PKKzU6El63fdP+JoI
         f4iUw8JfgygEeaZgp4Od7uNVKETI5cjgQ6VOPXe+MJHcW3u0+62r9eaCCxsTB4s5yTS+
         BvKpvjGYauSeylUq0eo3x6kA9gjQkhoAI7NYgo6YYb0UAkNoJ6klCsN8/DHGl9N1sEVH
         ZtXhRlOvwq4AzLKF3SJB2m7reeZp8PheQg9XucHWHlWHPw+r6p8mE6vSo2bJgITGoPtQ
         VOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrv6gsyu09kXASjPRXXzNjpOLZuX9j8VFg17QGlhcZuC3x+SpMh9zEyLUWiwFKt2FHJjWdMs6gLD7wocs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdeS35inPUzwELcmAx3t2Ra8pWoO9Id2VI+st78uFhQVOZ6hCg
	TIaZVdoLl51eFwrQgJwKoIjn3YEs1UqvynPYuW5B592zOkITwrIP8ns9BA==
X-Gm-Gg: ASbGnctaElXbt/OmJOdXzIsJb+lKHkU3SiOm0mN5612ga6Jmh7hr0WAg9DEzs/nVViX
	xpjeIapoDrRX1G//Qnt8nivtBSNQVWGZcuAk4Vj866/oEKSMjQ8DicPgiAvDR8umv4siwYreRmT
	DnuqVp8W7WhmOjpIvH8qGU5yNBQ52ukrgRhopagSwFQr53TViAtN484c97kBi1pZFyQU/PAXp1A
	tgiHGgybanRLiFWCcbjotfGsxhl/vNsnG6U+9ygEJ9s3K2MFR9XFcAZmd1Mg8SsPBufuZi7zGtz
	8yZiYkUuxkHP2sNEfXbldNqrjQcs+XfTvVMw
X-Google-Smtp-Source: AGHT+IGnxS0+auQ6sGjRktG+CrQnSJpucjwpxDOsKOlNT0eAt7DrP4JZnKcly9Zk0jhrY2VD60V37w==
X-Received: by 2002:a5d:648a:0:b0:386:36e7:f44f with SMTP id ffacd0b85a97d-38a221fb038mr42569704f8f.18.1736254079728;
        Tue, 07 Jan 2025 04:47:59 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:59 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:43 +0100
Subject: [PATCH v2 13/14] btrfs: selftests: add test for punching a hole
 into 3 RAID stripe-extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-13-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6236; i=jth@kernel.org;
 h=from:subject:message-id; bh=ZR4+z/8IzbGtRFmu+ycYbFa6RrLQUuwbhqkmEim1rB0=;
 b=kA0DAAoW0p7yIq+KHe4ByyZiAGd9InLIsOyT09fQfCJvS6/Fm6nct6I3Zlmgr0fVZmgbumEif
 4h1BAAWCgAdFiEEx1U9vxg1xAeUwus20p7yIq+KHe4FAmd9InIACgkQ0p7yIq+KHe7DzgEA0Bss
 OFqEeAKwQCVFxVjfOH5FRnSUQCTiOaaVz/CQe80BAL+ULXogwG1g+sQ8tZbO4p9SPWT6ywP2KMb
 YmYl6/icF
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Test creating a range of three RAID stripe-extents and then punch a hole
in the middle, deleting all of the middle extents and partially deleting
the "book ends".

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 183 ++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index c7e44e944f5ecc37ffb937237cb81fefbafbaf9a..e12b6abbfd2be66170d33ab13b1e0971444c0f9a 100644
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
+	/* Get the first extent and check its size. */
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
+	/* Get the second extent and check it's absent. */
+	ret = btrfs_get_raid_extent_offset(fs_info, logical2, &len2, map_type,
+					   0, &io_stripe);
+	if (ret != -ENODATA) {
+		test_err("lookup of RAID extent [%llu, %llu] succeeded should fail",
+			 logical2, logical2 + len2);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Get the third extent and check its size. */
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
@@ -752,6 +934,7 @@ static const test_func_t tests[] = {
 	test_front_delete,
 	test_front_delete_prev_item,
 	test_punch_hole,
+	test_punch_hole_3extents,
 };
 
 static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)

-- 
2.43.0


