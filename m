Return-Path: <linux-btrfs+bounces-5592-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B2901D1D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 10:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A26282E3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Jun 2024 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1393B7404B;
	Mon, 10 Jun 2024 08:40:37 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1B3EA86;
	Mon, 10 Jun 2024 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008836; cv=none; b=itFYV9vawmAf1WUA9a7m/1xJvR4YnhIFXRNTUmTfefmBp0oN2/cwZFKm7FGqbW8p+6N7Ci2LdVI53de+GHWo1Gtf9vMfxbE85/X1TBLQRf1zmstd1Cxx0myvGVwFCmXU/ZbgImCkpaSLI5FfFbEGTy87Dji4byX/nKGRb8HPeSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008836; c=relaxed/simple;
	bh=JPY8tVqMOJipo1DorjDsnC+tAZXnS8c3lxL1U0CFXIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFlUeSWtpXUoSaxHJ8CTVSEvJJTpA1o99H4kYXZYnuuKak8tp+DNq/EWKSM+yjH1IyxE4iGtwGDm6KzII2UXgzBdUJ7s65caJE9AyIWsgtNvqfMq1OVAd0iWDL8Cq91F/7PkoRnQ0czq6W0BX03YLPfoaZGIUytaS53B2MbeKY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a68b41ef3f6so449697266b.1;
        Mon, 10 Jun 2024 01:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008833; x=1718613633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+eJEFjxldYnixSnwYdNSI70ueCp+KRkHgoV9hazIIc=;
        b=lBcyiNhh7SXtYoe/m0ueNhDgcfTVmQJ3QEJkEd+5QfxCHon3Fb2Cv6Wu3MeRBI/NS7
         0ds5kMxW4kO0ssQGNQ1ew9/YIPU9QmbU/ME4Ip94yfxZMoTwuruI6tdYRSWEpFRkuq8I
         Bz2CzIEyhT/n57hEKxDbosij6kwDuPieY4gSX3RoCXOxhRHdJxElVw51x+ao7LaEwukw
         MgXQR5Kf90TfZpa3lrBEJ0N8S0bnwSGtS/yVEKodnFnIYwWhtPVzUPV2hy36YgclmdSc
         2hgZrYH912tv0TYCYV2Vp02i0NzL7V5ipa+ew2e/5jqjLqh1pxiq+gIw4LXXstjFBX2P
         O5bg==
X-Forwarded-Encrypted: i=1; AJvYcCUobL6XibZInSpoBvkWW7UNGOav+rzNrboOTFmzshZj7yCyGCfxyik8stFM4i0gYMVCWqQ0HaO1WMxTraN2HIIOxNnlrfX78i5mJjnY
X-Gm-Message-State: AOJu0YxyemYXNYLS8J/Bup46rfbhAVUpazJpEAt2kCUij/mDTL9MEWuS
	t/EWJ/UaiBDuTRiG00a2rzpDIxZ1hZgzc9RaIm/a/B1B0+W3Wi1V/Ev86Q==
X-Google-Smtp-Source: AGHT+IHDYorhX7Q4PIHPkKfC/GOau2fl6U9o8TrTlziYQxa6i9+2+i//VAaD3wic6MVmzHZMHhzBzg==
X-Received: by 2002:a17:906:c0d8:b0:a68:e161:b765 with SMTP id a640c23a62f3a-a6cd665c27emr509480566b.29.1718008832751;
        Mon, 10 Jun 2024 01:40:32 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7253800fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f725:3800:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c72efe054sm3259581a12.66.2024.06.10.01.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 01:40:32 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 10 Jun 2024 10:40:25 +0200
Subject: [PATCH 1/3] btrfs: rst: remove encoding field from stripe_extent
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-b4-rst-updates-v1-1-179c1eec08f2@kernel.org>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
In-Reply-To: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7154; i=jth@kernel.org;
 h=from:subject:message-id; bh=U4tM6VSGUfSvCYcn0kHPFwtPUTrQwDO8nUqFnyLGY5Q=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaSl7f6XeTDYYjOb3ppzNll2KYLTFd5OO1B7tj3dW3H+s
 cPCZ/Z2d5SyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEnHYz/FN8yll9OGKdjab3
 7eme7pKxc+bOmd5XbbXM8g5rs+lTm0yG/26dxmkS6/j5D9zxna5uV5j/n6U/d27Kh0nJv9fpBze
 2MwEA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Remove the encoding field from 'struct btrfs_stripe_extent'. It was
originally intended to encode the RAID type as well as if we're a data
or a parity stripe.

But the RAID type can be inferred form the block-group and the data vs.
parity differentiation can be done easier with adding a new key type
for parity stripes in the RAID stripe tree.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/accessors.h            |  3 ---
 fs/btrfs/print-tree.c           |  5 -----
 fs/btrfs/raid-stripe-tree.c     | 13 -------------
 fs/btrfs/raid-stripe-tree.h     |  3 +--
 fs/btrfs/tree-checker.c         | 19 -------------------
 include/uapi/linux/btrfs_tree.h | 14 +-------------
 6 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 6c3deaa3e878..b2eb9cde2c5d 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -315,11 +315,8 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
 
-BTRFS_SETGET_FUNCS(stripe_extent_encoding, struct btrfs_stripe_extent, encoding, 8);
 BTRFS_SETGET_FUNCS(raid_stride_devid, struct btrfs_raid_stride, devid, 64);
 BTRFS_SETGET_FUNCS(raid_stride_physical, struct btrfs_raid_stride, physical, 64);
-BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_encoding,
-			 struct btrfs_stripe_extent, encoding, 8);
 BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_devid, struct btrfs_raid_stride, devid, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_raid_stride_physical, struct btrfs_raid_stride, physical, 64);
 
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 7e46aa8a0444..9f1e5e11bf71 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -208,11 +208,6 @@ static void print_raid_stripe_key(const struct extent_buffer *eb, u32 item_size,
 				  struct btrfs_stripe_extent *stripe)
 {
 	const int num_stripes = btrfs_num_raid_stripes(item_size);
-	const u8 encoding = btrfs_stripe_extent_encoding(eb, stripe);
-
-	pr_info("\t\t\tencoding: %s\n",
-		(encoding && encoding < BTRFS_NR_RAID_TYPES) ?
-		btrfs_raid_array[encoding].raid_name : "unknown");
 
 	for (int i = 0; i < num_stripes; i++)
 		pr_info("\t\t\tstride %d devid %llu physical %llu\n",
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 6af6b4b9a32e..e6f7a234b8f6 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -80,7 +80,6 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 	struct btrfs_key stripe_key;
 	struct btrfs_root *stripe_root = fs_info->stripe_root;
 	const int num_stripes = btrfs_bg_type_to_factor(bioc->map_type);
-	u8 encoding = btrfs_bg_flags_to_raid_index(bioc->map_type);
 	struct btrfs_stripe_extent *stripe_extent;
 	const size_t item_size = struct_size(stripe_extent, strides, num_stripes);
 	int ret;
@@ -94,7 +93,6 @@ static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *trans,
 
 	trace_btrfs_insert_one_raid_extent(fs_info, bioc->logical, bioc->size,
 					   num_stripes);
-	btrfs_set_stack_stripe_extent_encoding(stripe_extent, encoding);
 	for (int i = 0; i < num_stripes; i++) {
 		u64 devid = bioc->stripes[i].dev->devid;
 		u64 physical = bioc->stripes[i].physical;
@@ -159,7 +157,6 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	struct extent_buffer *leaf;
 	const u64 end = logical + *length;
 	int num_stripes;
-	u8 encoding;
 	u64 offset;
 	u64 found_logical;
 	u64 found_length;
@@ -222,16 +219,6 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 
 	num_stripes = btrfs_num_raid_stripes(btrfs_item_size(leaf, slot));
 	stripe_extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
-	encoding = btrfs_stripe_extent_encoding(leaf, stripe_extent);
-
-	if (encoding != btrfs_bg_flags_to_raid_index(map_type)) {
-		ret = -EUCLEAN;
-		btrfs_handle_fs_error(fs_info, ret,
-				      "on-disk stripe encoding %d doesn't match RAID index %d",
-				      encoding,
-				      btrfs_bg_flags_to_raid_index(map_type));
-		goto out;
-	}
 
 	for (int i = 0; i < num_stripes; i++) {
 		struct btrfs_raid_stride *stride = &stripe_extent->strides[i];
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index c9c258f84903..1ac1c21aac2f 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -48,8 +48,7 @@ static inline bool btrfs_need_stripe_tree_update(struct btrfs_fs_info *fs_info,
 
 static inline int btrfs_num_raid_stripes(u32 item_size)
 {
-	return (item_size - offsetof(struct btrfs_stripe_extent, strides)) /
-		sizeof(struct btrfs_raid_stride);
+	return item_size / sizeof(struct btrfs_raid_stride);
 }
 
 #endif
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a2c3651a3d8f..1e140f6dabc6 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1682,9 +1682,6 @@ static int check_inode_ref(struct extent_buffer *leaf,
 static int check_raid_stripe_extent(const struct extent_buffer *leaf,
 				    const struct btrfs_key *key, int slot)
 {
-	struct btrfs_stripe_extent *stripe_extent =
-		btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
-
 	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
 		generic_err(leaf, slot,
 "invalid key objectid for raid stripe extent, have %llu expect aligned to %u",
@@ -1698,22 +1695,6 @@ static int check_raid_stripe_extent(const struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 
-	switch (btrfs_stripe_extent_encoding(leaf, stripe_extent)) {
-	case BTRFS_STRIPE_RAID0:
-	case BTRFS_STRIPE_RAID1:
-	case BTRFS_STRIPE_DUP:
-	case BTRFS_STRIPE_RAID10:
-	case BTRFS_STRIPE_RAID5:
-	case BTRFS_STRIPE_RAID6:
-	case BTRFS_STRIPE_RAID1C3:
-	case BTRFS_STRIPE_RAID1C4:
-		break;
-	default:
-		generic_err(leaf, slot, "invalid raid stripe encoding %u",
-			    btrfs_stripe_extent_encoding(leaf, stripe_extent));
-		return -EUCLEAN;
-	}
-
 	return 0;
 }
 
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index d24e8e121507..cb103c76d398 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -747,21 +747,9 @@ struct btrfs_raid_stride {
 	__le64 physical;
 } __attribute__ ((__packed__));
 
-/* The stripe_extent::encoding, 1:1 mapping of enum btrfs_raid_types. */
-#define BTRFS_STRIPE_RAID0	1
-#define BTRFS_STRIPE_RAID1	2
-#define BTRFS_STRIPE_DUP	3
-#define BTRFS_STRIPE_RAID10	4
-#define BTRFS_STRIPE_RAID5	5
-#define BTRFS_STRIPE_RAID6	6
-#define BTRFS_STRIPE_RAID1C3	7
-#define BTRFS_STRIPE_RAID1C4	8
-
 struct btrfs_stripe_extent {
-	__u8 encoding;
-	__u8 reserved[7];
 	/* An array of raid strides this stripe is composed of. */
-	struct btrfs_raid_stride strides[];
+	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);
 } __attribute__ ((__packed__));
 
 #define BTRFS_HEADER_FLAG_WRITTEN	(1ULL << 0)

-- 
2.43.0


