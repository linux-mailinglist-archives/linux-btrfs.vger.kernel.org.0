Return-Path: <linux-btrfs+bounces-15583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45358B0BD28
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 09:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2DC8189BFC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D8281378;
	Mon, 21 Jul 2025 07:02:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3698227FD7F
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753081351; cv=none; b=A2zySyKSQnST8gIKWWnP7Ae6htO8UBXCTlYaZoZpoWqzWQTTjnw/is5TOy09/02qN3bMC2IPmpiHjwkxl2eCB5N7fbPhtAxyCGNXJ/BMqlhewJ+pOEMHk+Af4ZseUyG2BNrSoqegJaYL7avBxS5TXks3VP6HBbrR6UqvP2j3ej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753081351; c=relaxed/simple;
	bh=PSocjnQ2yzeuEJRFr75r1vlTShHC889IOsZHE1rYL+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0LSkn2z3dLTVMwPAY390LEz/YCd3XO5n1wOrYUpUsHr5wy2hbmhHyXZdkTFAMmwKBa4UIPEXD7gvE7qatk3SvujywXFHVRDtIHmTuz3kJ/y1hXwDDtGWGt2CfLrRKKkAVm6FwusqU5p1mtVBgL9MWrAU5LNLGVCjV3+P8LKs5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a575a988f9so2278577f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 00:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753081348; x=1753686148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xixjdcCQ8sKgLkDmT5gyFwF5Xi883Lrl6z955FwEeGs=;
        b=WWgMR61MhNsTTBurFbN4tvvePMTZDa8wtgqGOT/w7N3M2rtjRWELYpAc+iJgaHhwwg
         W8TwPDlUX/kBwD1atbv4XAC5RQjywDcFyGQC+JqTvEdbXRiaX23CcfhQ8ZKNaAqS2CSl
         ICyOFISXVibnHH9NAJHFVjAE9hmYddhTmI1J6q59juk82aKAKCE5IoAGZfm8jI4UMQG/
         JMoAvvdmzjFT56oQKvJ/JPlhK2hdox10MFbylLDG0mi5INu/QqMZJpBx6LvLVzYkDxYm
         YBnmNW/dqk8QooonbyvEcM6HBULzMHITYQggMPLSTDGYjHBQQtXW/js4pJBquYSvDZwe
         tY+Q==
X-Gm-Message-State: AOJu0Yz4y+LbGTvyk5f03Y+LRl8QMjv9kmyDbjLkcuhr9K5MR4Tuxqxt
	p7Lcogtk5xIE6ygimS2UIcbr5JftQZJqMjjT0AHpRr0rSRXuyl0LFlbQBP8i52as
X-Gm-Gg: ASbGncv3FNvoK0XC36PKkEm7t0O4Z7FbalDVg+KEncunXlWHNvR5RBYpbFOabQUYQy3
	Bj7hpCIuCCC3+IS/jF4rBJya5B5xZUPo9wzR2OK2qrid3Sj4HDmPrKHtNUgTvbizKJ+0mcYxehI
	jVCdsluQaTudM3yi4NJBnGhHypgg5dMPZmp+xNkR5rylE2fOyoSS8UZlOya8yhuKBl4CU2KS3Bn
	/r3oxyi9wbrQ1LHIUvq3gW1T2ksbWJ6dPAKYLijEGLhnPkipbwCRF/XzN+u7TUUNqkuEtLuQVnD
	H9al0sGpGEhi9xb2gHjR4wPPJYXKT7k9pl7zUzSm72Isv79C5GXDOX7saGQhYHZTYXl8X/5lpsX
	NMmGwBUEAq55QxN5v+Z7PZ5/dfmdpKJyOFm8QLxCrabCoztQyv+HNYazvUE+KzdADEC6marTwRD
	4G5BTsc27qgg==
X-Google-Smtp-Source: AGHT+IEapjjMq8dRdWiDhQznwthJx2AmSlu5Me/Yc/seeeFox9ZXtPr5fSvYHaQZeITHuhOY39QB6Q==
X-Received: by 2002:a05:6000:220d:b0:3b6:de9:8079 with SMTP id ffacd0b85a97d-3b61abe204emr9020452f8f.0.1753081348275;
        Mon, 21 Jul 2025 00:02:28 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d73esm9327128f8f.66.2025.07.21.00.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 00:02:27 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/2] btrfs: zoned: return error from btrfs_zone_finish_endio()
Date: Mon, 21 Jul 2025 09:02:16 +0200
Message-ID: <20250721070216.701986-3-jth@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250721070216.701986-1-jth@kernel.org>
References: <20250721070216.701986-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now that btrfs_zone_finish_endio_workfn() is directly calling
do_zone_finish() the only caller of btrfs_zone_finish_endio() is
btrfs_finish_one_ordered().

btrfs_finish_one_ordered() already has error handling in-place so
btrfs_zone_finish_endio() can return an error if the block group lookup
fails.

Also as btrfs_zone_finish_endio() already checks for zoned filesystems and
returns early, there's no need to do this in the caller. For developer
builds leave the ASSERT() in place to check for a block-group lookup
failure.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c |  8 +++++---
 fs/btrfs/zoned.c | 10 +++++++---
 fs/btrfs/zoned.h |  9 ++++++---
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7ed340cac33f..bfddbbd46366 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3102,9 +3102,11 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	if (btrfs_is_zoned(fs_info))
-		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
-					ordered_extent->disk_num_bytes);
+	ret = btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
+				      ordered_extent->disk_num_bytes);
+	if (ret) {
+		goto out;
+	}
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 4444a667c71e..b1320b12e0e4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2431,16 +2431,19 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	return ret;
 }
 
-void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 length)
+int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 length)
 {
 	struct btrfs_block_group *block_group;
 	u64 min_alloc_bytes;
 
 	if (!btrfs_is_zoned(fs_info))
-		return;
+		return 0;
 
 	block_group = btrfs_lookup_block_group(fs_info, logical);
-	ASSERT(block_group);
+	if (!block_group) {
+		ASSERT(block_group);
+		return -EIO;
+	}
 
 	/* No MIXED_BG on zoned btrfs. */
 	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
@@ -2457,6 +2460,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
 
 out:
 	btrfs_put_block_group(block_group);
+	return 0;
 }
 
 static void btrfs_zone_finish_endio_workfn(struct work_struct *work)
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 6e11533b8e14..17c5656580dd 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -83,7 +83,7 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 bool btrfs_zone_activate(struct btrfs_block_group *block_group);
 int btrfs_zone_finish(struct btrfs_block_group *block_group);
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags);
-void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
+int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 			     u64 length);
 void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 				   struct extent_buffer *eb);
@@ -234,8 +234,11 @@ static inline bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 	return true;
 }
 
-static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
-					   u64 logical, u64 length) { }
+static inline int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
+					   u64 logical, u64 length)
+{
+	return 0;
+}
 
 static inline void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 						 struct extent_buffer *eb) { }
-- 
2.50.0


