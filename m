Return-Path: <linux-btrfs+bounces-10864-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF73A07BA3
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB4F16AC86
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3813421D5A7;
	Thu,  9 Jan 2025 15:15:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1AD22371A;
	Thu,  9 Jan 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435735; cv=none; b=Cu9rh1rR8ohz0hDIJvHwf6lZC+hSimsAYpiNflTtEIncZZYDplKtGMaarBmP9EUoETIcmhcNBOaL/A8nI+rJCLqVE5VlTup3yitv0aJQLYdL79vyQYMjSJrm0pSqJlTZsW/rB0QHnkIRbcWsjJSA3LcT3n4efaZKltNUOZObp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435735; c=relaxed/simple;
	bh=O6xA0U6e8EcrdV9gBkOcBpJ1iaQ0NLLesxhyKpoD70U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFGPfd1ANDh6/8cYg9jiFHI2ZagYSfqLBFWosu57M+G22GO6StDgiIhdhVs67iSjSTyuL7YxSvB6MmDPyjIsLmNt7wazmLZPI4nZ9DrDncudWIrjDMvs/3s8+cCEcoz4nmR/mpGUmV1VVM7mM1KhCurR0/O1KgjNLs5Q4Q103Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa67ac42819so158995766b.0;
        Thu, 09 Jan 2025 07:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435732; x=1737040532;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VjMqnnPdmmXdxnSjbPvoY1ry5RF8O2XMIoYq3Ycrjc=;
        b=DoFyQ8iZI2xOwNBiVN4hYgMAdDjNNUY+XvP2A2ZhUT0wgdwU7pkSCC6ZQS/1/yTdwk
         LbrACUszzJoAIls49c5O5hRKZLEWozw6KNcTkAL3y1S+7CWqztaXp7m0HlB0GsgUi+Xk
         7GkEvSP98qZjMv+0nPssuiKOTZJ4IQkuJFGhv/B80fgWTTnE2qkdw+t/sb3VsAWTU7Si
         pHUYVW3p3vrlzWiBFBTrHrI1xtZar6BLPeX0RDiW3gzzBvpaFF4rgM80BdYxytXN2fnh
         Hx/bFv7oEZMNZjBXsTAxrTl5cdxI4v4VW5fV2gfuXU9hDEoTw9UeRt6Pz7zUWGo7i6Fq
         jdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVceqqINUQFanohHhFD2xEVbRfo/+T0DiLxsx3oGmmPBnB/MTn86oHbJsxRIV8whqp/lAp6qnjbb22TwA==@vger.kernel.org, AJvYcCWynkCRMkGwoZ6/W53DZ+mMba0FrlqxgglwVnEGwL9a1Z//qG3s/CzmkDrH0bV8W4m+Evb8Uo7+8G6VOyeG@vger.kernel.org
X-Gm-Message-State: AOJu0YylsrvQw5+lqyWg7642PybJljd6X/3IAunWWPG0HlrGJzDF3L/w
	KcXsPOX1XS2+qDfpOLmU/S9qvFppRR2ikJhpsz6qry0+CTVWTqQJ
X-Gm-Gg: ASbGncu/ypIMPwhn74fpVL6qhXkKEIuwJ8zUwb+8c3/Ty5IWN2Rau4Rm72WBQiUKMXt
	SvjSGCgEOpSc4L8mbhSJ5s68ZVVikmeDbbxjmsNYHZammd1XvcvHYwxcp1ZKrHbGMfKc9ancIsr
	TJhmOeo6TSZ9VLAaXOr4KzvmF8TY7rg43OSLg3TxzOnOVAd/3IjNM3Qawy3x9e+s0NneHJs4Jy0
	B2HpEBmS26NxXtvpv9xRuJeRRqUmEM5LoX35ByGygwTM6Z0A4/3th2sFG1kh7oR7igsh1czz5wG
	7zsFJNNLuiVohA+BGJ5Wwhw539g9y1KPXXHa
X-Google-Smtp-Source: AGHT+IFVAs88sxMHf56IEEcXaCJLI3KFDemZBw9jJ3144m7fm/re9ArLlf/FClHAMC82Iqdr5unhXA==
X-Received: by 2002:a17:907:7f08:b0:aab:9430:40e9 with SMTP id a640c23a62f3a-ab2ab70a84emr576387366b.32.1736435731654;
        Thu, 09 Jan 2025 07:15:31 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:31 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:15 +0100
Subject: [PATCH v3 14/14] btrfs: selftests: add a selftest for deleting two
 out of three extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-14-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4970; i=jth@kernel.org;
 h=from:subject:message-id; bh=tFlMhQskj89bb4c6eNa63cULusVqX4eFepmYM+2AqgU=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2A1mXtjxZ/XJcmbbmwp4ojbaXnv+YmpnyVTwup2d
 Ul7Tq6Z1lHKwiDGxSArpshyPNR2v4TpEfYph16bwcxhZQIZwsDFKQATET3JyPDfOfnVeS2b6Jsc
 2fGBfX93zUnKX2t+9t8C5oAG+QmJOgcZ/tl8Viw7L/U+4KvDORnZHXn7e6S195jNf16+pueVPZ+
 oAzsA
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


