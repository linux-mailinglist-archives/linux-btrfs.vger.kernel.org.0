Return-Path: <linux-btrfs+bounces-10306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757FC9EE0B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABB1B168CB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9820DD76;
	Thu, 12 Dec 2024 07:56:16 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC4920C007
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990175; cv=none; b=TzZmo6h+1tAa7PJ2PBWZoLi1m7g1w0dGcXp72idWQ5CpGCGBiJc2EvladpgmlCFgAiSfz1Cm58PdZHAnG9Bd9PPGZxYh4U2Z09IjeMkGFm2kIR86ZmKJT6haWGyxvA+geoQQ65BBjDCiG1KCi2pFpFbzVoigDZy+B+LPohvENII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990175; c=relaxed/simple;
	bh=st38RmZEpm0aq87kK+7A5xOXIND1kKFBw9NGlzNmH/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pksDbfbrG+KY2z5rZDy3O0Mu+KP0an6v7tf+vBqJo4hgLmRG30vgRc9tJyVUaAZ5bsf8FAcoxXQGLksckR8IVd2cpfhsM7a5wgQheRo/nR6DQNtNf9+G0IHacq39ayoVV2Q+t0xc4mFlRlGF8NtS4hDbNMx0GTsdCKu8vLh5O50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso48511766b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990172; x=1734594972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gikd2Wwi7AUJNjoWPoX2fc6Q5hZzYRYSNZdpT755xGc=;
        b=vA1CsHbeYcZWpehrImty0BTncIMpt8kbwmtKloAkeBbEcw3f0gaeUOsYSMjZrZ5uYJ
         zh2QDWftDqQN/MMemSftXCBqM25Hla5Po42YIUsztH1Y4Y4JClrbGcmkVtwqFxWmJymY
         0o02AeItnbKTEiXROz89GVekvt6VE4kWTdupGlWU77OeBKzpufR47tp1vxjPEXfEMJ1J
         QjQKg1vV+mz9VvJ1uPEQ4GpBAJM95x7dpKSfKI/Om5gIKpbVZiETu3d3I76L2yMSVjyH
         7k5aelrPpDiHRGDZizVmaJ4SSYbujY8hNfG1jT0nI9OJ7rWWUFugyzmn4nv+A6I74qU2
         k9xQ==
X-Gm-Message-State: AOJu0YxZH3QPTsqowo0oxRVuMaEuErE7ffCNnjg7tHLv0zZ8d36XmVdf
	zTTi92d6udeX3kJAzt6JVL00plMFEZqlv2siuonBlP/+kzEU1CMCuN4tZouK
X-Gm-Gg: ASbGncvNFfSAc+xoHHX7hSkMfQOtgaZZB+tsjFXAsIut+QucggaJQ1H6dQfCjSRtOda
	0jwY4/koJWYjL+3mQKwGxxhnH7Ry5TmrB387wOBmRRpdWMUfeAD6/yo2H4z8Wtp9Yt/palLwT5E
	vdwbXZStjdcX9mh+0musFvkHcLFCvDnGwKI6jH0CJ3HmgYXHuwv7a8IErnCyjsSHcVDyiu9Y6fN
	7pGaQjBBBukeV9lE8tPpf8wXe2sMgi/fJUBjCIpi6tYj3A5bimkOff12BqrNbiBKljoLQDbfmPV
	g4IBHS7ulYgvEi8HJDUUjeQ65uYEt3DAIilXgxg=
X-Google-Smtp-Source: AGHT+IGqAYWWC4/SVfmFC6X0ZSwCTApH/E9twwx18IR56oTBO+4ziXv7mLLDaE4opAM6Cyk6/f0otw==
X-Received: by 2002:a17:906:32c2:b0:aa6:7588:cbeb with SMTP id a640c23a62f3a-aa6b10f5e52mr511570966b.11.1733990170614;
        Wed, 11 Dec 2024 23:56:10 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:56:10 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 14/14] btrfs: selftests: add a selftest for deleting two out of three extents
Date: Thu, 12 Dec 2024 08:55:33 +0100
Message-ID: <8b38b12a3a1f3ead232143bbab1829ecff3b570f.1733989299.git.jth@kernel.org>
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

Add a selftest creating three extents and then deleting two out of the
three extents.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 144 ++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 8d74e95a8a75..29c45f75941f 100644
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
+	/* prepare for the test, 1st create 3 x 1M extents */
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
+	 * Delete a range starting at logical1 and 2M in length. Extents 1 and 2
+	 * are is dropped and extent 3 is kept as is.
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
@@ -928,6 +1071,7 @@ static const test_func_t tests[] = {
 	test_front_delete_prev_item,
 	test_punch_hole,
 	test_punch_hole_3extents,
+	test_delete_two_extents,
 };
 
 static int run_test(test_func_t test, u32 sectorsize, u32 nodesize)
-- 
2.43.0


