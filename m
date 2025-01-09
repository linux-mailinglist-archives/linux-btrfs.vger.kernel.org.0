Return-Path: <linux-btrfs+bounces-10859-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C4AA07BB7
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56A77A4AD5
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEB7223708;
	Thu,  9 Jan 2025 15:15:33 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8D223335;
	Thu,  9 Jan 2025 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435732; cv=none; b=pH1UE7mfg1pjf6uPf5mE8tf1lyxlpTq26+9WgMrMotMtPhS+UdoF9Nxwu9MCKuUn/RDmJ//mosrDXua4wWYDRHXLJHeCj7USD/Jw+2fkaXgf6QVZL7UlLBA2EBLDUAt9sznLkclWgsSqHlPGMoT4ROUHkeMWlZs76RkuCh3U9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435732; c=relaxed/simple;
	bh=dJgfFFrHMNX/wt/rlx1ta5IfOA20OE0pHFuC1mtWUk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JW2S01rIYblvkDX3vcH8sQc6Ny8T3botZAkarufAENzbXlfih9iOZPP8qtVVhRlU2JiTnNMsBzudn3mhwNY/kpnkH2YBKoOSkQSTN0qswcDTAqi/4EO/lV/ZtYFO6uLXdFUtw4FRJhR186c42zsCngIGfnlpnxYor8ZWMuwMrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa68b513abcso197669566b.0;
        Thu, 09 Jan 2025 07:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435729; x=1737040529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71XSAwVnZXJGsAihpgV4sKSQDjM/13//Z7lrZY4oczs=;
        b=QnrTaSASkMJ1nEyu09Umq7xmVz1Wptz8IDHF/xELL6uBIMcdp7TZpyGytkExqxp+8O
         vYCOLloyut3+Lrh3PMiATID8Kfpzq2OoooXsA2oF6Ee3+JZxddoplMdfpHcSxhB3yQjA
         e8wtEmop53OeavCp6t7noh6EZ1qn2PeLvY3Dm6WwcSsiAR+COsAGV+OmAkHyzdCnLCbD
         jv8c1AXHzrTSSQydO3mNRn5JRcySrcTmPAvs4HnN++t+Cc3/ZVu2FpfZPncteTlV3/C9
         UJ1mtrO9E4WO5MvRSTOESG0X83BpdF+tg1yc2z96F6dVLbnC4p2JEflbqhHWSB3yjnWp
         Cl1g==
X-Forwarded-Encrypted: i=1; AJvYcCVJUROlJHqGzZAHM80rfImEcUVD9wYl3+x9GpLdtfM3Tuv731jAQutQedyRNhRV8fkUzZTV6XVkiVXIvLd5@vger.kernel.org, AJvYcCVuyrNEzpDwSh22/IMEAu0TXgNHUo1lRQK10kdf+kI3cRuEfPyyJehVoLFhUOI/5Guhm0MyWH8o7nUgtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gLb5C9FT+HEWIDSilr2S7RElC3vDGTe8Q4uLaMOLJC6f8PLm
	Mtcg5nEuhsH9ZeYw7benE5XxduIZHjrhMNf9FgxcHX2qhmuOTUZOmPtFMw==
X-Gm-Gg: ASbGncvC9VY5Ucfp6/PPzvSGi/3qegMet4QXFi18ofcRK6atFHI1NaJJvmNhtj7S/9X
	TGVF6hehqzuTGavGggKLRAakvzWH4EsBGYQpn0n87nx+si6n2LUjz7noKrQVCAH+ZR4KoU1SAeX
	0FToQOeNZmkmMqMJJc+vvGRPR6q58JbiGdyYn0aKywfbUkvWfcb81Kn4fcKRsY+jiC6UY5Wpqd/
	JSfH/TCLYnm8z0R/0Q15P975ZHtApEPNOhR0ZJa7XWJ9ar1MCDaN/CrcbnBq8SWgIsCY8WDoo/s
	mNns56iH+RBA90ecmyGnL3wkHbdT4qCAAIcU
X-Google-Smtp-Source: AGHT+IHwm7qlglao5OWNBR/6kYmwL8Y89xfmccUFdMBWRHsrLOIAIh8VrZLV9z8mYg7SWOG5TgQAKw==
X-Received: by 2002:a17:907:d8f:b0:aab:736c:558 with SMTP id a640c23a62f3a-ab2abdbfe2bmr574170166b.55.1736435728901;
        Thu, 09 Jan 2025 07:15:28 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:28 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:12 +0100
Subject: [PATCH v3 11/14] btrfs: selftests: test RAID stripe-tree deletion
 spanning two items
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-11-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5465; i=jth@kernel.org;
 h=from:subject:message-id; bh=7tLwXx2q11gSgeKl57UDh77jQX1COSI4LUB0wCH0mGQ=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2BdE80idEhP4NruCcdkpRWrnOaueLt8sag480Me7
 k1vs5h4OkpZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAiCzcz/E9IunTzR6iM52YL
 2agnrELbP62QlP/7bPMWHt3SrVPaYqYz/OFrSV475UveNHZPE22fHnUljXPHKov2Nu99HcCiEMz
 3hRsA
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


