Return-Path: <linux-btrfs+bounces-5818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA8390F23F
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 17:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABC31C218E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2024 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84304152524;
	Wed, 19 Jun 2024 15:35:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0874D152166;
	Wed, 19 Jun 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811306; cv=none; b=EXRsacQJqWAX2lqFG312oUCWhgKtNULk1c6SkT9CcldmQ0nXianqPgcfvkfozp9G3xDiHpQD96pHSedxBXKhTVdqC+5+cGp68XB3l0iHgXVdIIMm/eui65zKpYdhQFG5Uj6DMEOdvnyFtJH05ETOAQHM6jztR2/GFK1mC48mTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811306; c=relaxed/simple;
	bh=oTC81cnH+dN3orzjDOYHiTXmmqEyLCQ0I7spUOgtIWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUz5CjkUGOzU5MCB3fZ6SPlEKf0LwO1S6PD02/0USs25WydBhoDqpz5MadtQQI7HhJdj+ADHZN3Z22wgQbfE7GaViIoE5VRbp1EHbbhCrJqsa8Uro7y5/STlKJIyuXHe3o/K5yhpopKGYNjoHrouTzupM11fse2Glob3LoYwwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso71071311fa.1;
        Wed, 19 Jun 2024 08:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811302; x=1719416102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53k60xnWItFNxouNmEA4t5IllOjqQs9+VoFJtvADyds=;
        b=AJ4K9nQrJVuGzE7njyjsau/ynEQC/BbYXpm3crYryErqoRrn5fAIj3+MpyBlHaR9nE
         MrDYBkgovXw8To9xAkrCdKETSpIWJzFiZMokePWA1U2OMwEkpioH1/v6133d3WLcNQHO
         dbn2CzbDuEz4d80IrP4w6NRBamqEAq+4/uGSqEkgtWZUiWRQpwzGOng0FaecQ9UgzByM
         wCI2lGgHMjsr0EDPVMTmsMrXh9PR7wo/moLQHd2hPpKHedCzRpeGqpXHKrcr+LvtGEgM
         Ym2F9IG5uQTm+gv0tugpJtPcpsukqZ3c5fDu+qTq+GqqRC66B7axuvo37jPjoG0gzAKA
         MELw==
X-Forwarded-Encrypted: i=1; AJvYcCV8fIBRvBspJ0w7IfMbBX/VWseGpB75fjHnIy5S0jQSR54xdT8YIFh1TUNlxSN+cjrb9BZTR4MU25I+8z1enSXbYupEFgCgD5cxZxqh
X-Gm-Message-State: AOJu0YxguEoR3UjXQZiD8LmKLsvI9GTS/ZsdniM3cUhGL4hUY2cwGSg4
	3W8u2OAr5UUrcguq20hrt/a7YjZshvSmMx+V4SkEPiKzBtKwGYZmp+Cvrw==
X-Google-Smtp-Source: AGHT+IGfTX0unf2WOkKR8sms1DcdbEpCT/3cHVuQWHIXFlVJrV1J5W3LA+F1J08FQmFFVWVNKMqsFQ==
X-Received: by 2002:a2e:7a02:0:b0:2ec:476:7c60 with SMTP id 38308e7fff4ca-2ec3cec59c3mr18572821fa.27.1718811299813;
        Wed, 19 Jun 2024 08:34:59 -0700 (PDT)
Received: from [127.0.0.1] (p200300f6f7110500fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f711:500:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe9263sm268882135e9.15.2024.06.19.08.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 08:34:59 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Wed, 19 Jun 2024 17:34:51 +0200
Subject: [PATCH v2 1/4] btrfs: rst: remove encoding field from
 stripe_extent
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-b4-rst-updates-v2-1-89c34d0d5298@kernel.org>
References: <20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org>
In-Reply-To: <20240619-b4-rst-updates-v2-0-89c34d0d5298@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7154; i=jth@kernel.org;
 h=from:subject:message-id; bh=nkXv4Jnd8z+PDnUnu1iNOeMHcBjG1Vc7IEHf3d1s/9M=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaQV/VqY+Cteq/vOkRmT+YquM7afZ5WZbXnmiteKFpP9/
 drvNumt7yhlYRDjYpAVU2Q5Hmq7X8L0CPuUQ6/NYOawMoEMYeDiFICJmFYxMvRNbJHP/28gL71+
 1xK591xOf58fNp57TIWjwTnqZdmbiwwM/3OP7F+y0D3aOoBzU30b3963v4/YbAtVrf8tYNGpL7x
 oHRcA
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
index c7636331e566..fc29d273845d 100644
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


