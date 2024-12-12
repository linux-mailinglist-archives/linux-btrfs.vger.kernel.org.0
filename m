Return-Path: <linux-btrfs+bounces-10302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2EF9EE0B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4D8188950C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA35020B807;
	Thu, 12 Dec 2024 07:56:09 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D220CCE0
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990169; cv=none; b=YIoyE736Czrzhn3eXIhzZNSdPRLJJ9b63bzT6CcY/fK5hgBDoyYKQkwVJaGnhJFqvIhlKLF3s3MczOkkmQWrq5skVR5S5JRjTGefmVNdjs1H8+XLlQAbyihtkT6x0y6In63/B5zT3Arz2v5ojn4LyBtKuzfIG/IDg5c3tEMRjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990169; c=relaxed/simple;
	bh=dTPU98wO8+hhf6fsmIai0iqs6Yv7Lf4wrssXlwuQXTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f61V91Grb+OwCRskkGvuDhKWfnRLCn2plhKsb6Mert7dlKwfJrcIXS3JF6r36s0m5rckhzVP4Ipp0nhpK16HWZA8hsnZbJOR3khugtKODyp8ME/sSUMpaPiWnOMEp7DusDiPkcIX/fuxPkXLyLGaWXhiGbBzcuJpTplLjHYawsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a68480164so39279566b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990165; x=1734594965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4A2xgaq7wh417qcM0Z8T4Mev1gyoxlAEwwcir/r31RU=;
        b=P+eJkYrVCbV9h74QBD896Dz8z/7pIU5vX3TyPz/TeLnQvXHzaM3hmL1RDuPZ4WpEGE
         y4j5vEtwa5kBYfZUVZv7w00UeDtGO2ZvsXhGIIiRN+Zw/fYBnKoyHnX9eyqmgWXuVq4L
         AVwFLhfHdJ8RL1OGzb8T0H5L4hLgaqfbqkIW5OqbVE97r1KcwWGKmDzq8jVDeLSt2Vvy
         2hdhmlUnHAr3hM4zgmkOLFPkvJtaVAsj/yydhc78QtgoPWDf/fi16dvQhHVnMp0+TMQR
         p71fNJOw35W1/xtN6gzakSRAP33TJps+SVZjSGDRP6xibiW0h7c5+AIYA1Ra3MoGvIm0
         sXkA==
X-Gm-Message-State: AOJu0Yw5vBh9AtG4++VQrUMkAwBRjgvoKib9zaWfokiePhCLZsYk8/jO
	tJqCFfKtX2Vyni0+2ZRRUKV0/HO/Zwb6CSn7jCaohiwhehXOgIFbW8qrfzGc
X-Gm-Gg: ASbGncsUkEMSD+sS6dAaq2rKpLQ3h01Bbsjf6xFbEpLMgbGUUzkqqHipaS6DnjmHVEt
	hSLgbnJwjZ5QNQ+rZNwQtmwq0tLqNswXWwD/qaXM5FIoEGdKFCVSwP9cLlJZ9fvEXGyuQVghkbb
	LqGwcI9JVyenWVX7s968mpU1CmtWRzip7abKCkN+cLpUnNWNtiZOm5L3rA4VsH90aYWEu1ZpXOF
	e2pEA7nRz8G4fiMqK5T4aySyda7n/TCfBUvI9RSGTAA3vRdr6bixfNYZ8lXo/WALj66r07vw7oJ
	tvnti0elUuXEFjfkFd4pGH+DPktrwKI9a0/sq1I=
X-Google-Smtp-Source: AGHT+IFqn2+PLv5RBXvnozsgg5REvM4zWKlxibZe1JohrVUHh/0uPhMRCEXSY5OYrgTmw2ppGc7XhA==
X-Received: by 2002:a17:906:3118:b0:aa5:27d4:980a with SMTP id a640c23a62f3a-aa6c1d2ba9dmr258265766b.49.1733990164690;
        Wed, 11 Dec 2024 23:56:04 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:56:04 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 10/14] btrfs: selftests: don't split RAID extents in half
Date: Thu, 12 Dec 2024 08:55:29 +0100
Message-ID: <9cabbac863682a0da549d04d37e785a11a9b51c0.1733989299.git.jth@kernel.org>
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

The selftests for partially deleting the start or tail of RAID
stripe-extents split these extents in half.

This can hide errors in the calculation, so don't split the RAID
stripe-extents in half but delete the first or last 16K of the 64K
extents.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/tests/raid-stripe-tree-tests.c | 44 ++++++++++++++++---------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/tests/raid-stripe-tree-tests.c b/fs/btrfs/tests/raid-stripe-tree-tests.c
index 19f6147a38a5..12f3dbb23a64 100644
--- a/fs/btrfs/tests/raid-stripe-tree-tests.c
+++ b/fs/btrfs/tests/raid-stripe-tree-tests.c
@@ -14,6 +14,8 @@
 #define RST_TEST_NUM_DEVICES	(2)
 #define RST_TEST_RAID1_TYPE	(BTRFS_BLOCK_GROUP_DATA | BTRFS_BLOCK_GROUP_RAID1)
 
+#define SZ_48K (SZ_32K + SZ_16K)
+
 typedef int (*test_func_t)(struct btrfs_trans_handle *trans);
 
 static struct btrfs_device *btrfs_device_by_devid(struct btrfs_fs_devices *fs_devices,
@@ -94,32 +96,32 @@ static int test_front_delete(struct btrfs_trans_handle *trans)
 		goto out;
 	}
 
-	ret = btrfs_delete_raid_extent(trans, logical, SZ_32K);
+	ret = btrfs_delete_raid_extent(trans, logical, SZ_16K);
 	if (ret) {
 		test_err("deleting RAID extent [%llu, %llu] failed", logical,
-			 logical + SZ_32K);
+			 logical + SZ_16K);
 		goto out;
 	}
 
-	len = SZ_32K;
-	ret = btrfs_get_raid_extent_offset(fs_info, logical + SZ_32K, &len,
+	len -= SZ_16K;
+	ret = btrfs_get_raid_extent_offset(fs_info, logical + SZ_16K, &len,
 					   map_type, 0, &io_stripe);
 	if (ret) {
 		test_err("lookup of RAID extent [%llu, %llu] failed",
-			 logical + SZ_32K, logical + SZ_32K + len);
+			 logical + SZ_16K, logical + SZ_64K);
 		goto out;
 	}
 
-	if (io_stripe.physical != logical + SZ_32K) {
+	if (io_stripe.physical != logical + SZ_16K) {
 		test_err("invalid physical address, expected %llu, got %llu",
-			 logical + SZ_32K, io_stripe.physical);
+			 logical + SZ_16K, io_stripe.physical);
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (len != SZ_32K) {
+	if (len != SZ_48K) {
 		test_err("invalid stripe length, expected %llu, got %llu",
-			 (u64)SZ_32K, len);
+			 (u64)SZ_48K, len);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -128,11 +130,11 @@ static int test_front_delete(struct btrfs_trans_handle *trans)
 	if (ret != -ENODATA) {
 		ret = -EINVAL;
 		test_err("lookup of RAID extent [%llu, %llu] succeeded, should fail",
-			 logical, logical + SZ_32K);
+			 logical, logical + SZ_16K);
 		goto out;
 	}
 
-	ret = btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K);
+	ret = btrfs_delete_raid_extent(trans, logical + SZ_16K, SZ_48K);
 out:
 	btrfs_put_bioc(bioc);
 	return ret;
@@ -209,14 +211,14 @@ static int test_tail_delete(struct btrfs_trans_handle *trans)
 		goto out;
 	}
 
-	ret = btrfs_delete_raid_extent(trans, logical + SZ_32K, SZ_32K);
+	ret = btrfs_delete_raid_extent(trans, logical + SZ_48K, SZ_16K);
 	if (ret) {
 		test_err("deleting RAID extent [%llu, %llu] failed",
-			 logical + SZ_32K, logical + SZ_64K);
+			 logical + SZ_48K, logical + SZ_64K);
 		goto out;
 	}
 
-	len = SZ_32K;
+	len = SZ_48K;
 	ret = btrfs_get_raid_extent_offset(fs_info, logical, &len, map_type, 0, &io_stripe);
 	if (ret) {
 		test_err("lookup of RAID extent [%llu, %llu] failed", logical,
@@ -231,9 +233,19 @@ static int test_tail_delete(struct btrfs_trans_handle *trans)
 		goto out;
 	}
 
-	if (len != SZ_32K) {
+	if (len != SZ_48K) {
 		test_err("invalid stripe length, expected %llu, got %llu",
-			 (u64)SZ_32K, len);
+			 (u64)SZ_48K, len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	len = SZ_16K;
+	ret = btrfs_get_raid_extent_offset(fs_info, logical + SZ_48K, &len,
+					   map_type, 0, &io_stripe);
+	if (ret != -ENODATA) {
+		test_err("lookup of RAID extent [%llu, %llu] succeeded should fail",
+			 logical + SZ_48K, logical + SZ_64K);
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.43.0


