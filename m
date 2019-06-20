Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 356CF4DA66
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfFTTip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:45 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40364 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfFTTip (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:45 -0400
Received: by mail-yb1-f193.google.com with SMTP id i14so1668931ybp.7
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=1sXdulqIjFCBFS4xb7FhZ0v3HmcGIARmmwu5Sh8FvYQ=;
        b=IIlH09pzIl04qa1pX/XvHAXLtggvq5eZ3vD/NETuU0dkbriKq5KwrPHG06hzLgUg23
         3qhG8pIcDxYpmMhSBLI/7w1Zj3mktMkiiFBch/3f7r7sfEvoM2iJGEL/gLUxGQyh+LgO
         y85kLHlxUiruEfeJFLhDyxUAP25l84yTuFRKDRCkX6p0n1/9Xy/80UyvgCZKGf7jJebn
         ZUrJj8kngZED8LSjMNrJqBQqnS8YNUg9XUU61CywTa6QEQFCyGwKpvUU7yYxCVHJQ4vH
         nNg/gKGN78NkTO0W4dXv5ruD52UK9+bD8uEDJT5xLbh2pxzsMixT3S9hXTCO/n8B/IN3
         PNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=1sXdulqIjFCBFS4xb7FhZ0v3HmcGIARmmwu5Sh8FvYQ=;
        b=lRJZKpiejjNOigJVjDwwBNfZl7An03x3nWrHAK9RDYEX3QhAsocy+KZJ6GaCo9SHYW
         dCU4Idsinw+iXdMNCdAvyopdmhsw0UpR2x4tNUcGJdhw9RH2iH30412fay9NXfskK0i5
         fsjomDv5sLB9Qy5KYFP1jSGHLZPoDapALayZRNsNAjz8U+59mezRltd51rminTK0Nds8
         YDlLKQTXOO7ECug7urECDh+12Fk7jwM6LVEwq+y6U0xo2O2bU1fFzOw606eRf3ubVBpA
         REfjx1GPhl69eC/LfnHrElgvyPmsDmqqCvyrOKIRC1+RlgWqFYBCpA5ye5SzHnGjD3yp
         YhrA==
X-Gm-Message-State: APjAAAWfpsOW8RqUNSbzc8wzvhCqo0ffL31QOe0xWEsCWpHjCTsmUGlR
        iXOYNT+GdXDF2UQA38O0crkhtAM/fQau9g==
X-Google-Smtp-Source: APXvYqz78zCaIoAkKMLn2VUqhZ9WbOJy8t66OWndGCZqwhodY6PswQAxIBNpngPdUCZqN/t046nEVA==
X-Received: by 2002:a25:7408:: with SMTP id p8mr67945105ybc.523.1561059523639;
        Thu, 20 Jun 2019 12:38:43 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id i126sm101474ywa.108.2019.06.20.12.38.42
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 21/25] btrfs: migrate btrfs_can_relocate
Date:   Thu, 20 Jun 2019 15:38:03 -0400
Message-Id: <20190620193807.29311-22-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This belongs to block-group.c, move it over.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/ctree.h       |   1 -
 fs/btrfs/extent-tree.c | 141 -------------------------------------------------
 4 files changed, 142 insertions(+), 142 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6a189ad3e7e1..4d029089ec32 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2679,3 +2679,144 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
 }
+
+/*
+ * Checks to see if it's even possible to relocate this block group.
+ *
+ * @return - -1 if it's not a good idea to relocate this block group, 0 if its
+ * ok to go ahead and try.
+ */
+int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
+{
+	struct btrfs_block_group_cache *block_group;
+	struct btrfs_space_info *space_info;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_device *device;
+	u64 min_free;
+	u64 dev_min = 1;
+	u64 dev_nr = 0;
+	u64 target;
+	int debug;
+	int index;
+	int full = 0;
+	int ret = 0;
+
+	debug = btrfs_test_opt(fs_info, ENOSPC_DEBUG);
+
+	block_group = btrfs_lookup_block_group(fs_info, bytenr);
+
+	/* odd, couldn't find the block group, leave it alone */
+	if (!block_group) {
+		if (debug)
+			btrfs_warn(fs_info,
+				   "can't find block group for bytenr %llu",
+				   bytenr);
+		return -1;
+	}
+
+	min_free = btrfs_block_group_used(&block_group->item);
+
+	/* no bytes used, we're good */
+	if (!min_free)
+		goto out;
+
+	space_info = block_group->space_info;
+	spin_lock(&space_info->lock);
+
+	full = space_info->full;
+
+	/*
+	 * if this is the last block group we have in this space, we can't
+	 * relocate it unless we're able to allocate a new chunk below.
+	 *
+	 * Otherwise, we need to make sure we have room in the space to handle
+	 * all of the extents from this block group.  If we can, we're good
+	 */
+	if ((space_info->total_bytes != block_group->key.offset) &&
+	    (btrfs_space_info_used(space_info, false) + min_free <
+	     space_info->total_bytes)) {
+		spin_unlock(&space_info->lock);
+		goto out;
+	}
+	spin_unlock(&space_info->lock);
+
+	/*
+	 * ok we don't have enough space, but maybe we have free space on our
+	 * devices to allocate new chunks for relocation, so loop through our
+	 * alloc devices and guess if we have enough space.  if this block
+	 * group is going to be restriped, run checks against the target
+	 * profile instead of the current one.
+	 */
+	ret = -1;
+
+	/*
+	 * index:
+	 *      0: raid10
+	 *      1: raid1
+	 *      2: dup
+	 *      3: raid0
+	 *      4: single
+	 */
+	target = btrfs_get_restripe_target(fs_info, block_group->flags);
+	if (target) {
+		index = btrfs_bg_flags_to_raid_index(extended_to_chunk(target));
+	} else {
+		/*
+		 * this is just a balance, so if we were marked as full
+		 * we know there is no space for a new chunk
+		 */
+		if (full) {
+			if (debug)
+				btrfs_warn(fs_info,
+					   "no space to alloc new chunk for block group %llu",
+					   block_group->key.objectid);
+			goto out;
+		}
+
+		index = btrfs_bg_flags_to_raid_index(block_group->flags);
+	}
+
+	if (index == BTRFS_RAID_RAID10) {
+		dev_min = 4;
+		/* Divide by 2 */
+		min_free >>= 1;
+	} else if (index == BTRFS_RAID_RAID1) {
+		dev_min = 2;
+	} else if (index == BTRFS_RAID_DUP) {
+		/* Multiply by 2 */
+		min_free <<= 1;
+	} else if (index == BTRFS_RAID_RAID0) {
+		dev_min = fs_devices->rw_devices;
+		min_free = div64_u64(min_free, dev_min);
+	}
+
+	mutex_lock(&fs_info->chunk_mutex);
+	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
+		u64 dev_offset;
+
+		/*
+		 * check to make sure we can actually find a chunk with enough
+		 * space to fit our block group in.
+		 */
+		if (device->total_bytes > device->bytes_used + min_free &&
+		    !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
+			ret = find_free_dev_extent(device, min_free,
+						   &dev_offset, NULL);
+			if (!ret)
+				dev_nr++;
+
+			if (dev_nr >= dev_min)
+				break;
+
+			ret = -1;
+		}
+	}
+	if (debug && ret == -1)
+		btrfs_warn(fs_info,
+			   "no space to allocate a new chunk for block group %llu",
+			   block_group->key.objectid);
+	mutex_unlock(&fs_info->chunk_mutex);
+out:
+	btrfs_put_block_group(block_group);
+	return ret;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 3b7516836849..328cbffc5ce8 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -202,6 +202,7 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
 			     u64 ram_bytes, u64 num_bytes, int delalloc);
 void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
 			       u64 num_bytes, int delalloc);
+int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr);
 
 static inline int
 btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 15ab2d5f7cd7..e6b32c0fcbb4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2520,7 +2520,6 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 
 int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
-int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr);
 void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info);
 void btrfs_get_block_group_trimming(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *cache);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 971d0e336fc2..b72bc622cb9a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5873,147 +5873,6 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 	return free_bytes;
 }
 
-/*
- * Checks to see if it's even possible to relocate this block group.
- *
- * @return - -1 if it's not a good idea to relocate this block group, 0 if its
- * ok to go ahead and try.
- */
-int btrfs_can_relocate(struct btrfs_fs_info *fs_info, u64 bytenr)
-{
-	struct btrfs_block_group_cache *block_group;
-	struct btrfs_space_info *space_info;
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	struct btrfs_device *device;
-	u64 min_free;
-	u64 dev_min = 1;
-	u64 dev_nr = 0;
-	u64 target;
-	int debug;
-	int index;
-	int full = 0;
-	int ret = 0;
-
-	debug = btrfs_test_opt(fs_info, ENOSPC_DEBUG);
-
-	block_group = btrfs_lookup_block_group(fs_info, bytenr);
-
-	/* odd, couldn't find the block group, leave it alone */
-	if (!block_group) {
-		if (debug)
-			btrfs_warn(fs_info,
-				   "can't find block group for bytenr %llu",
-				   bytenr);
-		return -1;
-	}
-
-	min_free = btrfs_block_group_used(&block_group->item);
-
-	/* no bytes used, we're good */
-	if (!min_free)
-		goto out;
-
-	space_info = block_group->space_info;
-	spin_lock(&space_info->lock);
-
-	full = space_info->full;
-
-	/*
-	 * if this is the last block group we have in this space, we can't
-	 * relocate it unless we're able to allocate a new chunk below.
-	 *
-	 * Otherwise, we need to make sure we have room in the space to handle
-	 * all of the extents from this block group.  If we can, we're good
-	 */
-	if ((space_info->total_bytes != block_group->key.offset) &&
-	    (btrfs_space_info_used(space_info, false) + min_free <
-	     space_info->total_bytes)) {
-		spin_unlock(&space_info->lock);
-		goto out;
-	}
-	spin_unlock(&space_info->lock);
-
-	/*
-	 * ok we don't have enough space, but maybe we have free space on our
-	 * devices to allocate new chunks for relocation, so loop through our
-	 * alloc devices and guess if we have enough space.  if this block
-	 * group is going to be restriped, run checks against the target
-	 * profile instead of the current one.
-	 */
-	ret = -1;
-
-	/*
-	 * index:
-	 *      0: raid10
-	 *      1: raid1
-	 *      2: dup
-	 *      3: raid0
-	 *      4: single
-	 */
-	target = btrfs_get_restripe_target(fs_info, block_group->flags);
-	if (target) {
-		index = btrfs_bg_flags_to_raid_index(extended_to_chunk(target));
-	} else {
-		/*
-		 * this is just a balance, so if we were marked as full
-		 * we know there is no space for a new chunk
-		 */
-		if (full) {
-			if (debug)
-				btrfs_warn(fs_info,
-					   "no space to alloc new chunk for block group %llu",
-					   block_group->key.objectid);
-			goto out;
-		}
-
-		index = btrfs_bg_flags_to_raid_index(block_group->flags);
-	}
-
-	if (index == BTRFS_RAID_RAID10) {
-		dev_min = 4;
-		/* Divide by 2 */
-		min_free >>= 1;
-	} else if (index == BTRFS_RAID_RAID1) {
-		dev_min = 2;
-	} else if (index == BTRFS_RAID_DUP) {
-		/* Multiply by 2 */
-		min_free <<= 1;
-	} else if (index == BTRFS_RAID_RAID0) {
-		dev_min = fs_devices->rw_devices;
-		min_free = div64_u64(min_free, dev_min);
-	}
-
-	mutex_lock(&fs_info->chunk_mutex);
-	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
-		u64 dev_offset;
-
-		/*
-		 * check to make sure we can actually find a chunk with enough
-		 * space to fit our block group in.
-		 */
-		if (device->total_bytes > device->bytes_used + min_free &&
-		    !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
-			ret = find_free_dev_extent(device, min_free,
-						   &dev_offset, NULL);
-			if (!ret)
-				dev_nr++;
-
-			if (dev_nr >= dev_min)
-				break;
-
-			ret = -1;
-		}
-	}
-	if (debug && ret == -1)
-		btrfs_warn(fs_info,
-			   "no space to allocate a new chunk for block group %llu",
-			   block_group->key.objectid);
-	mutex_unlock(&fs_info->chunk_mutex);
-out:
-	btrfs_put_block_group(block_group);
-	return ret;
-}
-
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 {
 	struct btrfs_block_group_cache *block_group;
-- 
2.14.3

