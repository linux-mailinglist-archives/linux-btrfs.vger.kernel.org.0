Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC68475373
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 08:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbhLOHAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 02:00:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53234 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbhLOHAD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 02:00:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 592CC21135
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639551602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BaGsWYISu0AzVBvBDVGjboTA+Nb2m2z1mXZ7SxdhvNA=;
        b=Krc78kXSRtS5zE0VJYITOeIzfUSnWbnq0Xee8f9nnNECcgbyvHvx3EvwqhrQ0VIoROp/K6
        B0YWvc/fs7EOuFj3i8CtwAhwDAC3NnTOlqe8iP/pLCt4i4QzXagBCQKgwx1jd7MOcO+DTl
        ioF/lXxyfewujuSHUiuRq0mqHFSx3hw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7C3D139CF
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 07:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8QKfIHGSuWHiEwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 07:00:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: cleanup the argument list of scrub_chunk()
Date:   Wed, 15 Dec 2021 14:59:41 +0800
Message-Id: <20211215065942.26683-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The argument list of scrub_chunk() has the following problems:

- Duplicated @chunk_offset
  It is the same as btrfs_block_group::start.

- Confusing @length
  The most instinctive guess is chunk length, and one may want to delete
  it, but the truth is, it's device extent length.

Fix this by:

- Remove @chunk_offset
  Use btrfs_block_group::start instead.

- Rename @length to @dev_ext_len
  Also rename the caller to remove the ambiguous naming.

- Rename @cache to @bg
  The "_cache" suffix for btrfs_block_group is removed for a while.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5e59e27e6bcd..ffbaf6fbf71c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3548,10 +3548,10 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 }
 
 static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
+					  struct btrfs_block_group *bg,
 					  struct btrfs_device *scrub_dev,
-					  u64 chunk_offset, u64 length,
 					  u64 dev_offset,
-					  struct btrfs_block_group *cache)
+					  u64 dev_ext_len)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
@@ -3561,7 +3561,7 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 	int ret = 0;
 
 	read_lock(&map_tree->lock);
-	em = lookup_extent_mapping(map_tree, chunk_offset, 1);
+	em = lookup_extent_mapping(map_tree, bg->start, bg->length);
 	read_unlock(&map_tree->lock);
 
 	if (!em) {
@@ -3569,26 +3569,24 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 		 * Might have been an unused block group deleted by the cleaner
 		 * kthread or relocation.
 		 */
-		spin_lock(&cache->lock);
-		if (!cache->removed)
+		spin_lock(&bg->lock);
+		if (!bg->removed)
 			ret = -EINVAL;
-		spin_unlock(&cache->lock);
+		spin_unlock(&bg->lock);
 
 		return ret;
 	}
-
-	map = em->map_lookup;
-	if (em->start != chunk_offset)
+	if (em->start != bg->start)
 		goto out;
-
-	if (em->len < length)
+	if (em->len < dev_ext_len)
 		goto out;
 
+	map = em->map_lookup;
 	for (i = 0; i < map->num_stripes; ++i) {
 		if (map->stripes[i].dev->bdev == scrub_dev->bdev &&
 		    map->stripes[i].physical == dev_offset) {
 			ret = scrub_stripe(sctx, map, scrub_dev, i,
-					   chunk_offset, length, cache);
+					   bg->start, dev_ext_len, bg);
 			if (ret)
 				goto out;
 		}
@@ -3626,7 +3624,6 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	struct btrfs_path *path;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_root *root = fs_info->dev_root;
-	u64 length;
 	u64 chunk_offset;
 	int ret = 0;
 	int ro_set;
@@ -3650,6 +3647,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 
 	while (1) {
+		u64 dev_ext_len;
+
 		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 		if (ret < 0)
 			break;
@@ -3686,9 +3685,9 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			break;
 
 		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
-		length = btrfs_dev_extent_length(l, dev_extent);
+		dev_ext_len = btrfs_dev_extent_length(l, dev_extent);
 
-		if (found_key.offset + length <= start)
+		if (found_key.offset + dev_ext_len <= start)
 			goto skip;
 
 		chunk_offset = btrfs_dev_extent_chunk_offset(l, dev_extent);
@@ -3822,13 +3821,14 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		scrub_pause_off(fs_info);
 		down_write(&dev_replace->rwsem);
-		dev_replace->cursor_right = found_key.offset + length;
+		dev_replace->cursor_right = found_key.offset + dev_ext_len;
 		dev_replace->cursor_left = found_key.offset;
 		dev_replace->item_needs_writeback = 1;
 		up_write(&dev_replace->rwsem);
 
-		ret = scrub_chunk(sctx, scrub_dev, chunk_offset, length,
-				  found_key.offset, cache);
+		ASSERT(cache->start == chunk_offset);
+		ret = scrub_chunk(sctx, cache, scrub_dev, found_key.offset,
+				  dev_ext_len);
 
 		/*
 		 * flush, submit all pending read and write bios, afterwards
@@ -3909,7 +3909,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			break;
 		}
 skip:
-		key.offset = found_key.offset + length;
+		key.offset = found_key.offset + dev_ext_len;
 		btrfs_release_path(path);
 	}
 
-- 
2.34.1

