Return-Path: <linux-btrfs+bounces-8984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AE99A1DCB
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 11:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD061C20A86
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2024 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB491D8E16;
	Thu, 17 Oct 2024 09:04:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690DB1D88A4
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155869; cv=none; b=Wd0DaeahMfzmrEW/MakkgEm0VLhZ+dWy/NT16XqNzEVQyWrXSIwrlW3Xz2PmJn3RCAxI7tCfSUXN+IkG2bZJgEGJ3MUfcQeExjVaeR8yEpyd0bQeiVCEBcA60eA2cXZnhhQbAO5FSPxpzhAz0MvYwyYfytX6nsf8ymbwTDbzU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155869; c=relaxed/simple;
	bh=UbFN251aIqsI+ArgL5vxr4xQqjV2r/jBVhUT/EHZqfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvgE+FdKmL56sHm4o0n4gWHrPEqXmoqQldz7SC34476Z2k53oor7dBDLD8JSr7xNLilwDJqgUSmxOucy6Jtz7ywuG34Km3XJZzwLG0UAMb8xsmXm6lpYKlvM5Xho02N/53J3IhAa7uTSuQTTvVfaKDj8TjIyzDrJ0nm6cDsmxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so505872f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2024 02:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155864; x=1729760664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ta4yLfokfKjcxUBVwUJ5T2AqG9n+LaN4CApBi7u8OxI=;
        b=nF+uDH1aATozXwR9k7vEjBdm5v9O1Udcok3Q+ISfLoQbLQHfB1d5ALn1Qv8PTMWNPD
         kZejxPTSD/Cdvgi4ZoHq+Bh2AfFLxYellyg86N0GDZrAXIdlWpgSIigX9DP6biODcAVg
         I+QlzxbnMgH9HQoWicoToBujRxnPJNC7r6g8jriaQJjs6XG7LZtC1Uasvanau9iiVgRg
         2qjVTJAByhBjivZUz6xbPdIBlw2EpG4MqeHKAEvwOJcRPUF5555Y3SLYD8gJbZUmp+d4
         TGfj5rf9M3Bm0GrCtAJBz9FpPDng+iB1OBd+eX9EjUkcX9LebKc1g79eezOQ9yqW+kVa
         UVxw==
X-Gm-Message-State: AOJu0YzBcjahFeCASvwaN973CD2EG8W3ZKqRVK/psz7ZFGlib45fHSg6
	IlDBBoF1Xh3BZUF95hQ/Y4zTfbcdF7GVbEIUQ02ED6DgGftF31WQZ7EowtPp
X-Google-Smtp-Source: AGHT+IESi5mr0vlaGJtVma/UdCdKZ5aSkd9xQipARtCvcF/BWU1cFoFbBGwejx2nt/rP65BL4JmQPw==
X-Received: by 2002:a05:6000:111:b0:37c:d537:9dc0 with SMTP id ffacd0b85a97d-37d551847cfmr14195828f8f.12.1729155864195;
        Thu, 17 Oct 2024 02:04:24 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f71fdb00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f71f:db00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c37fbesm19700495e9.8.2024.10.17.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:04:23 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 1/2] btrfs: implement partial deletion of RAID stripe extents
Date: Thu, 17 Oct 2024 11:04:10 +0200
Message-ID: <20241017090411.25336-2-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017090411.25336-1-jth@kernel.org>
References: <20241017090411.25336-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

In our CI system, the RAID stripe tree configuration sometimes fails with
the following ASSERT():

 assertion failed: found_start >= start && found_end <= end, in fs/btrfs/raid-stripe-tree.c:64

This ASSERT()ion triggers, because for the initial design of RAID
stripe-tree, I had the "one ordered-extent equals one bio" rule of zoned
btrfs in mind.

But for a RAID stripe-tree based system, that is not hosted on a zoned
storage device, but on a regular device this rule doesn't apply.

So in case the range we want to delete starts in the middle of the
previous item, grab the item and "truncate" it's length. That is, clone
the item, subtract the deleted portion from the key's offset, delete the
old item and insert the new one.

In case the range to delete ends in the middle of an item, we have to
adjust both the item's key as well as the stripe extents and then
re-insert the modified clone into the tree after deleting the old stripe
extent.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.c            |  1 +
 fs/btrfs/raid-stripe-tree.c | 94 ++++++++++++++++++++++++++++++++++---
 2 files changed, 88 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index b11ec86102e3..3f320f6e7767 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3863,6 +3863,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
 	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
+	       key.type != BTRFS_RAID_STRIPE_KEY &&
 	       key.type != BTRFS_EXTENT_CSUM_KEY);
 
 	if (btrfs_leaf_free_space(leaf) >= ins_len)
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 41970bbdb05f..569273e42d85 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -13,6 +13,50 @@
 #include "volumes.h"
 #include "print-tree.h"
 
+static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
+					      struct btrfs_path *path,
+					      struct btrfs_key *oldkey,
+					      u64 newlen, u64 frontpad)
+{
+	struct btrfs_root *stripe_root = trans->fs_info->stripe_root;
+	struct btrfs_stripe_extent *extent;
+	struct extent_buffer *leaf;
+	int slot;
+	size_t item_size;
+	int ret;
+	struct btrfs_key newkey = {
+		.objectid = oldkey->objectid + frontpad,
+		.type = BTRFS_RAID_STRIPE_KEY,
+		.offset = newlen,
+	};
+
+	ASSERT(oldkey->type == BTRFS_RAID_STRIPE_KEY);
+	ret = btrfs_duplicate_item(trans, stripe_root, path, &newkey);
+	if (ret)
+		return ret;
+
+	leaf = path->nodes[0];
+	slot = path->slots[0];
+	item_size = btrfs_item_size(leaf, slot);
+	extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
+
+	for (int i = 0; i < btrfs_num_raid_stripes(item_size); i++) {
+		struct btrfs_raid_stride *stride = &extent->strides[i];
+		u64 phys;
+
+		phys = btrfs_raid_stride_physical(leaf, stride);
+		btrfs_set_raid_stride_physical(leaf, stride, phys + frontpad);
+	}
+
+	btrfs_mark_buffer_dirty(trans, leaf);
+
+	/* delete the old item, after we've inserted a new one. */
+	path->slots[0]--;
+	ret = btrfs_del_item(trans, stripe_root, path);
+
+	return ret;
+}
+
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 length)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -36,23 +80,24 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 	while (1) {
 		key.objectid = start;
 		key.type = BTRFS_RAID_STRIPE_KEY;
-		key.offset = length;
+		key.offset = 0;
 
 		ret = btrfs_search_slot(trans, stripe_root, &key, path, -1, 1);
 		if (ret < 0)
 			break;
-		if (ret > 0) {
-			ret = 0;
-			if (path->slots[0] == 0)
-				break;
+
+		if (path->slots[0] == btrfs_header_nritems(path->nodes[0]))
 			path->slots[0]--;
-		}
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 		btrfs_item_key_to_cpu(leaf, &key, slot);
 		found_start = key.objectid;
 		found_end = found_start + key.offset;
+		ret = 0;
+
+		if (key.type != BTRFS_RAID_STRIPE_KEY)
+			break;
 
 		/* That stripe ends before we start, we're done. */
 		if (found_end <= start)
@@ -61,7 +106,42 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		trace_btrfs_raid_extent_delete(fs_info, start, end,
 					       found_start, found_end);
 
-		ASSERT(found_start >= start && found_end <= end);
+		/*
+		 * The stripe extent starts before the range we want to delete:
+		 *
+		 * |--- RAID Stripe Extent ---|
+		 * |--- keep  ---|--- drop ---|
+		 *
+		 * This means we have to duplicate the tree item, truncate the
+		 * length to the new size and then re-insert the item.
+		 */
+		if (found_start < start) {
+			u64 diff = start - found_start;
+
+			ret = btrfs_partially_delete_raid_extent(trans, path,
+								 &key,
+								 diff, 0);
+			break;
+		}
+
+		/*
+		 * The stripe extent ends after the range we want to delete:
+		 *
+		 * |--- RAID Stripe Extent ---|
+		 * |--- drop  ---|--- keep ---|
+		 *
+		 * This means we have to duplicate the tree item, truncate the
+		 * length to the new size and then re-insert the item.
+		 */
+		if (found_end > end) {
+			u64 diff = found_end - end;
+
+			ret = btrfs_partially_delete_raid_extent(trans, path,
+								 &key,
+								 diff, diff);
+			break;
+		}
+
 		ret = btrfs_del_item(trans, stripe_root, path);
 		if (ret)
 			break;
-- 
2.43.0


