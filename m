Return-Path: <linux-btrfs+bounces-10862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C06B6A07BA1
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7A116A89F
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A522248AA;
	Thu,  9 Jan 2025 15:15:34 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089C2236EC;
	Thu,  9 Jan 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435733; cv=none; b=D87BUv+plsdiw3kDIvzf2vGaati5K882t3g3li0Ckl1yeAqaLsTPu6oIOJCbV9xOJ9DUpIl5X9uGKgFnHk4m2mu1nqqLuBQ4q7PhrXNt7rjV8eYRUOfywRey3a5XTinmaaI0YXf/U2PMYR5DCEr96kJwUvRG4j3n8rnd8r/cWoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435733; c=relaxed/simple;
	bh=7fuPeZ6eTkkUO02ONgT8YE81H5pgw5MM/PhBKMB8iwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kVOCh6gGbEIj0s+UrjWYh+sWDBMYuUEHOWy7Nri0CNBuEPuq2sWT28aQ3YTb+hnxU8NYw1tFoLHJGtMrJfxtjWDHSxxANscOrUzarAKW3qtdEOQ6/VOqO65D+qjOG3SkWfuyNJjryUJHu+EPzft8M+w8ayek0THSlOiMGdpYmZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab2c9b8aecaso113540066b.0;
        Thu, 09 Jan 2025 07:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435730; x=1737040530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3PSh0B2ZMCmXCLngvICZw3M5+xhN20esGOtQ6jcvP4=;
        b=tqS96EOUtaz7T5B2kVm7S5m2iWjOi+Ck6A7IOJ211f78JqsqnOB2maGyOCGz/oxdY8
         8tiT/hxJpXmpLsCYh6+PrqtP2dzNBZRTQWUeZBCuVH+7GDyPhycAnFYulVgweXdqmNXH
         L6o+TBWoQGC0pmwvuqAlyjjpT/UEi7j/RZrsQFoRcGfM3myyWjxHZtxRdSal6rrlZ7kI
         /RTEz7Ab3ChVe8K2Z/8hh2gfCe2CCq0H+GtGTlOR8l/o6e0tncYC/9fXTWPn1T3Y6Egd
         2Sb8BHcwr7S+0QamPVeKp1awSkSuf1ug+xUI0VMDBMtXqxIiXTmenhJE330aF33la9Z6
         MF1g==
X-Forwarded-Encrypted: i=1; AJvYcCUM1HnU1NQXm8GmFNeflJVP1O5GCHuK0UH9wnxdE+8FQIFGx73d4VVT1jiGjrmJK39ECC6SkAz6Ii13RA==@vger.kernel.org, AJvYcCXClD+VDVR24JG67ALzNrU+JgrJXaDbD9z4Wn8eKIFtxaQPcFOdavqXtYVitOn4YaWXcJbTQcmLZzLANON1@vger.kernel.org
X-Gm-Message-State: AOJu0YylS2bRsjwmWu3kAejGmMcaDkuhNVJqi806Brk5idPt5oYFVVtS
	LI2guHjYbe7C5OzaRqDScb2CakIMlVu59vRKbSk6ph1pGBn6G3uG
X-Gm-Gg: ASbGnct9Lx2EhFadFb0GN8+Tjviz1RMZD3QHa9tJKp8K4akvMdyicm85mzaEJmnlgZh
	sh71/NxOLYUHUP/5cdx9piCVDzBCPhpm3RswFmWT0krrm/SxSlOu22ifJcs63Ay0o4fqC4/DPVJ
	NBtIQYsapNSXAnAoJ0SRweazh+9AizRm2e/jWWj5uvD95samRqXOUKEgAjd1CsDcYADho1wMRbq
	tem/043TI/UO4dR6rmWJ7BL6ZRpdnnPjVrThSJ1snkMXkXJQIc301t3ryhgK5wDLpOk4fBFi3yp
	OZgTQWtVAmJsJLBx41iYV6zUF4ez9EkaHG6m
X-Google-Smtp-Source: AGHT+IHc4Ne0XQo49HEGrQUZxV1ZxV8G9yZalXIJPutExISHA/aoFHipW8OtY9E6nmjyjq4zmnix+A==
X-Received: by 2002:a17:906:fe48:b0:aab:9842:71f9 with SMTP id a640c23a62f3a-ab2ab559c13mr663710166b.22.1736435729850;
        Thu, 09 Jan 2025 07:15:29 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:29 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:13 +0100
Subject: [PATCH v3 12/14] btrfs: selftests: add selftest for punching holes
 into the RAID stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-12-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5069; i=jth@kernel.org;
 h=from:subject:message-id; bh=EVHDj16oSZY+6HbUp0NyPkXxXTNMaQAqUAlZnYdPi9g=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2BNOzhZqPu3qQWv5aeN+ZsSZu158HSff6Bv58N/S
 5j4jOLcO0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAiEbGMDJ8UnhslKHz4Y/H2
 ltzyQzWl4s+MpF4xH/h9qbl6o7C5iSrDf6cDVh+uCMesDv523vLjlc0zi6sXLGCtbFNdrdW/bcr
 EKj4A
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


