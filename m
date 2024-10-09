Return-Path: <linux-btrfs+bounces-8730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 713A899702C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 18:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCE21F21EB9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD8C1E1A35;
	Wed,  9 Oct 2024 15:31:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63A81E1A18
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487860; cv=none; b=mA7MaKenCaa5i0R2r0zpam9eFyqP9GiIbYXU+iD86IVnm6hcOqxCSV43tiw/66ev0lc10sdwQBDMtxQ6BwBeXfGafB32ZOzlXRLAPCUm96Qy6HU9KmvQ8kXzP4szRHocvBocjS1YgjVn/vUa7YBw0/YwwDl+aMb/6F45em5WstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487860; c=relaxed/simple;
	bh=r1Csa6iei3Ep+QIxaHz0at6KXo33i6JFjipBfNknAhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuZujMM77s88daFErQvJa5BZAHU8MI6APxzvnzfl/1+ZmrScLAfStw9iBCna8znYqa2PNM3lw0D+iExnKcI3SbaHWKLWTpU0IDLfTqsba6A6XOjmb+Us/oT4tFLXq08JS8T4r84whLBVIhLemyqwxCX9y31shgHQowzXI2jgzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d47eff9acso41526f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 08:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728487857; x=1729092657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtRm37YvZs5jI/FSGcYqhQsIg9u6qt/gq1T0QxmudVE=;
        b=wJJYcUQ49gYEvSvM6XqrbsmqFj0aXexCK2UcUUuknVR7n0A8eLRlO586jwcBGRCoab
         aBPQZMCuoQrFtwfyUr1cDzscgh+oQExg36cJFpSJxzY6irOIsAFX8eTsOjbZejFBniCx
         x5Xn0aKXgoIawgDxxNmFULtN/cIDEkbRwe4EkSbbYPOrDgfYI/y4lJ2ZqGJBMxYxQ6M5
         ZmdRPkopTyVAJqbX+cL4bUVD5Eng99rp/DWh5w8AxxzVOzJFS+9it5Hu2zTuaDPslaSk
         viGCqD66OFp+pGJrzUZ74pHDCw4iu5TmXowsavyPyqD2STL5t35uRNhhk64bINB23gho
         OqYw==
X-Forwarded-Encrypted: i=1; AJvYcCXrRfbHzfB0wZnJURebrIcVLQ706Gn937LUIwbv3XuYPA2vllfum3JZl5HAb4fCtNUIOwHWOcJGxC6hiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vdm4GmIVx32iixk8/2N/ZSuO+B+OjFIxtL6uC4j+0cqrZs3D
	wzayr8yNwrAgitS+byg93LMkUzbjWFgw4schKDAcuV9bEIM2+Z4h
X-Google-Smtp-Source: AGHT+IE6Rm/wl4XyWjVcvzk4eDhcc7XE3d+yIIoUVhl0YoOhQXu0DnAEojzmOOBn0rpodwrVM4OzHA==
X-Received: by 2002:adf:f788:0:b0:37c:cee9:4684 with SMTP id ffacd0b85a97d-37d3a9d3d76mr1674704f8f.14.1728487855497;
        Wed, 09 Oct 2024 08:30:55 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f724f700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f724:f700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d371b0731sm3252521f8f.90.2024.10.09.08.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:30:55 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>
Cc: Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/2] btrfs: implement partial deletion of RAID stripe extents
Date: Wed,  9 Oct 2024 17:30:31 +0200
Message-ID: <20241009153032.23336-2-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009153032.23336-1-jth@kernel.org>
References: <20241009153032.23336-1-jth@kernel.org>
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
 fs/btrfs/raid-stripe-tree.c | 85 +++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 41970bbdb05f..40cc0a392be2 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -13,6 +13,54 @@
 #include "volumes.h"
 #include "print-tree.h"
 
+static int btrfs_partially_delete_raid_extent(struct btrfs_trans_handle *trans,
+					      struct btrfs_path *path,
+					      struct btrfs_key *oldkey,
+					      u64 newlen, u64 frontpad)
+{
+	struct btrfs_root *stripe_root = trans->fs_info->stripe_root;
+	struct btrfs_stripe_extent *extent, *new;
+	struct extent_buffer *leaf = path->nodes[0];
+	int slot = path->slots[0];
+	const size_t item_size = btrfs_item_size(leaf, slot);
+	struct btrfs_key newkey;
+	int ret;
+	int i;
+
+	new = kzalloc(item_size, GFP_NOFS);
+	if (!new)
+		return -ENOMEM;
+
+	memcpy(&newkey, oldkey, sizeof(struct btrfs_key));
+	newkey.objectid += frontpad;
+	newkey.offset -= newlen;
+
+	extent = btrfs_item_ptr(leaf, slot, struct btrfs_stripe_extent);
+
+	for (i = 0; i < btrfs_num_raid_stripes(item_size); i++) {
+		u64 devid;
+		u64 phys;
+
+		devid = btrfs_raid_stride_devid(leaf, &extent->strides[i]);
+		btrfs_set_stack_raid_stride_devid(&new->strides[i], devid);
+
+		phys = btrfs_raid_stride_physical(leaf, &extent->strides[i]);
+		phys += frontpad;
+		btrfs_set_stack_raid_stride_physical(&new->strides[i], phys);
+	}
+
+	ret = btrfs_del_item(trans, stripe_root, path);
+	if (ret)
+		goto out;
+
+	btrfs_release_path(path);
+	ret = btrfs_insert_item(trans, stripe_root, &newkey, new, item_size);
+
+ out:
+	kfree(new);
+	return ret;
+}
+
 int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 length)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -43,9 +91,8 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 			break;
 		if (ret > 0) {
 			ret = 0;
-			if (path->slots[0] == 0)
-				break;
-			path->slots[0]--;
+			if (path->slots[0] > 0)
+				path->slots[0]--;
 		}
 
 		leaf = path->nodes[0];
@@ -61,7 +108,37 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
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
+			ret = btrfs_partially_delete_raid_extent(trans, path, &key,
+							start - found_start, 0);
+			break;
+		}
+
+		/*
+		 * The stripe extent ends after the range we want to delete:
+		 *
+		 * |--- RAID Stripe Extent ---|
+		 * |--- drop  ---|--- keep ---|
+		 * This means we have to duplicate the tree item, truncate the
+		 * length to the new size and then re-insert the item.
+		 */
+		if (found_end > end) {
+			u64 diff = found_end - end;
+
+			ret = btrfs_partially_delete_raid_extent(trans, path, &key,
+								 diff, diff);
+			break;
+		}
+
 		ret = btrfs_del_item(trans, stripe_root, path);
 		if (ret)
 			break;
-- 
2.43.0


