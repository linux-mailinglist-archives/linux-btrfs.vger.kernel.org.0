Return-Path: <linux-btrfs+bounces-10952-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B9AA0C18D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 20:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C42C3AAE01
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F72C1FA150;
	Mon, 13 Jan 2025 19:32:07 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E521F9A90;
	Mon, 13 Jan 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796726; cv=none; b=sJLXV9Te2AvX/btLVkl8w0IkC6WYtJUbm6Y0K0Ta0GREGpYT3TGqKCW9X40XP0bjRkXcYBYSDNGxudthRcAYclIAyoE4SyMDvEHUyV6xzrw86ZPxuURIHVD4QczaqAJCxmiWXbZsSp8GzlxjxGqXYC/fo1qYtTrWdvE5QeSkoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796726; c=relaxed/simple;
	bh=LzyPjO3Kv5CbdoOJNMEDoznEK5M2gPvof+JnHQnPz1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dbMZFt+fPUZ5VyJAr6vMPHIGVfDhRQsZDvFupM2kPxwTJTKvwuWvab3GTSiTC0NFKox8PKf+T808iCmwK79aP4KjWOxzg1LAXJ00wR9Lxzc9kHR7evFTuMV7evbrrelnOLKCcBOl785q5tDXh9DR4xBwKyTAaIpqVJSX0sZiEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3863703258fso3578508f8f.1;
        Mon, 13 Jan 2025 11:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796723; x=1737401523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ur/+A0ELFVMxAVca9a6mKArrXJSe18Wd0kDdlASpQk=;
        b=eAswST5iLbziqDNntolZxADNcoc3I95UYwbu6AIqO6+z6UtJKBJJIHXye8ydUSswmn
         lKZ9vofdpmNNS4dMaoEOqga+xIucfoiSYQyejlvzOLhHY2ByHQmrXnWjUCNpnmAhL58F
         d+deZbA2MiLQZ21fYgSpiorp76PBxbwov13GL//+Wxh8dizRkkb+mVFL/fydTcvXRI6c
         T8eZHq8uCD1+JpxSuxTJeXo+Yy1Ijp5938ONSb1yDPa/cEiQ80WJwJoeyFGchW9Cm0/J
         hAKwyDIlmVjFKEHFE3nDy5XgQ3dZIyaVM5FIGqFa5AvLV+u9pZqzbbFFD0t91gAqFHlq
         PGrA==
X-Forwarded-Encrypted: i=1; AJvYcCVrJBc/5IGh3PdF2Wq8uasKOjB5uA06ZCMXvzkOUY9LYs7oztwu8W9xpDywmsq3B39Avpmn32y+fCkZyASp@vger.kernel.org, AJvYcCWkvq8eLMVN5FcncV2pu/pMB9XJd2M0Tiwz6Wcpv8Gyuf/snmssh3e3uaje2Vf1qimZdzsaE5X8O9tkzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qxtILL3ftMIsxOd62JjOnCvW4806zOa1iNNtL1zJP9Tz15Bo
	l7l2L+NS75lcA+bHAAMljgspliS1YGS6J/7Uk6xGtMIyGUiqBbsq
X-Gm-Gg: ASbGncvfxYKDdNwURjFttUW5ZPSJ10i2I/L+T5n3LeiHxCDcw7qdixoDSJkov7js8X5
	6URLvNgsV8po7FWY1uwulQ3WUVUMYMNSOFm13l1V2MdE8rGIJBZRP4VkQ6T4XpJmkzQHcvLv+CM
	cKg8Ak15RIQgzE9N6Z1qewzHT37q1PComYu4d/kdZtKsWHaNAvxd7sRtwo7NNEvTwQfKZDUUZla
	fIydZjd2rWBS3ZsZ2i8qY+MqQt7mqkraEy4qNsk5Dw0yTZb1MAIgRACkwvhGRrkvV7R+vTqXZf9
	bBBKMcKco6pkKIqUiMjOL4cmZ+/1SPJco9YP
X-Google-Smtp-Source: AGHT+IGK0c+lKzHAxjaz9yWEW6WsFg8gXZlAMsxPc1fJXKbRSxi28L/3yPOO+at+Os5PMwXUYNFK5g==
X-Received: by 2002:a05:6000:1547:b0:386:34af:9bae with SMTP id ffacd0b85a97d-38a8b0b7fd0mr14515951f8f.4.1736796722808;
        Mon, 13 Jan 2025 11:32:02 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2da6271sm186221475e9.9.2025.01.13.11.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 11:32:02 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 13 Jan 2025 20:31:53 +0100
Subject: [PATCH v4 12/14] btrfs: selftests: add selftest for punching holes
 into the RAID stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-rst-delete-fixes-v4-12-c00c61d2b126@kernel.org>
References: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
In-Reply-To: <20250113-rst-delete-fixes-v4-0-c00c61d2b126@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5117; i=jth@kernel.org;
 h=from:subject:message-id; bh=SaNEzj9HvSfFtWgV9sIm5xhTefDohh7cX/HrQLrGrXU=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaS3Zqn+FQ1atNQq6PZex2XGF46uf8zf/8CjcKWWjANfz
 3+ju91FHaUsDGJcDLJiiizHQ233S5geYZ9y6LUZzBxWJpAhDFycAjCR4zsYGfZMEgnfFPPaRFYn
 0cfizvZZeRpLZ9101pHSTvj1RvnwsU8M/90uKHVXLl1v7MM474X2ds23Hux5R6cyyDR5Cz5dVsp
 ozw0A
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a selftest for punching a hole into a RAID stripe extent. The test
create an 1M extent and punches a 64k bytes long hole at offset of 32k from
the start of the extent.

Afterwards it verifies the start and length of both resulting new extents
"left" and "right" as well as the absence of the hole.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 140 ++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 2138d7561f40efed5449ebd9ae66aa6adec4858e..f71e2ed97b2a8069d4af45c073fcbdd427905325 100644
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


