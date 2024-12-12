Return-Path: <linux-btrfs+bounces-10304-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F83F9EE0B3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC08A1889608
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C2920DD4C;
	Thu, 12 Dec 2024 07:56:11 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8D920B7FE
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990170; cv=none; b=d9fIh1ly02naepY7OYiR+XX0W7mhUtNgXKAzjNN5zTnazfENNeWB5wVrlNsBK6mu2MV5mr2rGxX9MEL4aNORdPp2hK56zw1bCV0CEg85gAjO51D1jm82T4ZgGUQTrF6/zr0m6CCvWg+mGxhDmysmvk8Oo5T7LHhupfblYtOPOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990170; c=relaxed/simple;
	bh=BWH0+6z1Iwy9XUQzsDvEhGduSzrwaIIFPeTo5EHBmpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZMJ9Byet+Ox4cAbqVjQtNbGZAOYAwLRDdb3PYMoIemFWnu9x3IIWR1vpN5QaIJS0P00Hzogp2vF3DwtCfSiy63PPGkcEFKTqKLz/euKasDBLFGwrHLeo9hNU9IN52gnzcDxJuXOUXjyiX1n4ESufJ13Ger6JPrgSQyAc8neHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso45410666b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990168; x=1734594968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r48XIgLiD0tfU33Kd3M1iAsJHXPjIUYXmKA/bdPJW9c=;
        b=HB2yr3cxtDY0GRPCH5qMy8ptjpKn0zipAcJ/QFr+KFlow4PXY6v2pwATRRIjsnX7k9
         CmDaIwalqYWDFSJ4Y/PxRu6fe9bwTRZClRvV93IEHOBLHpalRrQPGnbA1d1TbvH6qLy3
         JHudcr1QOzQU0z1EUsuxyS/+M04dgGyKFshvSioZN8tfafnCQTwzWDKOIJHXT3EILqot
         acrmcDfM2DbMVVJH917eOoyivCTvkPpdHMNfi7ZmieVaHGr4C3pi1y8skZi74Q3EuVLA
         DECxpFoDtbBi2lvm0CCfsxd/zAEudUcxfSnYH/BvA2D3bVEu7YTkNn/Uf/lj2HlLEU8v
         QLDQ==
X-Gm-Message-State: AOJu0YyOz4YDMJJ0XL8qxvXm9kxeXx+Mq0S6qNw/GqRgDQ+EGwgmGIpY
	RTPpUIBHQUhWs+nMWBkLWHEYPIdUeBclPgXXJaucsqqdC8n8VGSloDCnPgrF
X-Gm-Gg: ASbGncuJBPTJlRlWyot7RyZAgvTo89ytaXFz1Y4ucWa4C/mpGCq3Bekat2KRyEvjVze
	9dJNxR+xOkbr5NCC7D399k4oQ/mpJG5eQbwmGRG5iz2eqIjfQMAISlCYIG8CO/yIwDH4YLlY7rV
	mfzWZVnGRik+pnmiuOJQbVzNrV/d/PAAo8qcGhBUZy/MsK/wAG3XfwM258+WYkr+O4k35RXAG32
	UH0c95zmqrHwSJlyrSB3YIuRv3Cq6RKsSAX1Fl+jmMceD6nfZcD3lQQBoDYx3HAAs/Z+XZG30yh
	LpQdajuFrhx9RYjReammGu6lEGXBF93uQMK3FGA=
X-Google-Smtp-Source: AGHT+IEI6X/+7SB1IBvUzY110eAhhJscsIpbiUTMtQgFXhJmRTdV9471TVWnBexFXBejD1LuX+/+Ng==
X-Received: by 2002:a17:906:4ca:b0:aa6:993a:259f with SMTP id a640c23a62f3a-aa6b1396ea0mr621290466b.40.1733990167643;
        Wed, 11 Dec 2024 23:56:07 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:56:07 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 12/14] btrfs: selftests: add selftest for punching holes into the RAID stripe extents
Date: Thu, 12 Dec 2024 08:55:31 +0100
Message-ID: <48a5cfb4c94de62c961f36d0a6ff9c9c24902116.1733989299.git.jth@kernel.org>
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

Add a selftest for punching a hole into a RAID stripe extent. The test
create an 1M extent and punches a 64k bytes long hole at offset of 32k from
the start of the extent.

Afterwards it verifies the start and length of both resulting new extents
"left" and "right" as well as the absence of the hole.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 133 ++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index a815fc5c4dd3..37b87ccb5858 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -31,6 +31,138 @@ static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_devices *fs_de
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
@@ -612,6 +744,7 @@ static const test_func_t tests[] = {
 	test_tail_delete,
 	test_front_delete,
 	test_front_delete_prev_item,
+	test_punch_hole,
 };
 
 static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
-- 
2.43.0


