Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA24032B278
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243342AbhCCB6Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:58:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:40620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383065AbhCBKqR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Mar 2021 05:46:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614681930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=gMhegv0wURC2UGRjyU5EPTwJONbebSYq4WXPIKrC3ec=;
        b=NEAPSJkugybimN6OXpVf9gb/isEeU8uUP66ePPsNGFQ5Kx//glmxZoR3SjoFkH2XJJXQJ7
        R4JbMdzTkl5LJIeCIllgcSNNT/w21cqd/x+uTx93SvduckOS7JAdLva5mciK0X/i3Y3PNQ
        tC2FtehmgTkVDLfykvk+vhr4+ksKOCA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CCF5AD2B;
        Tue,  2 Mar 2021 10:45:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Refactor error handling in btrfs_zero_range
Date:   Tue,  2 Mar 2021 12:45:29 +0200
Message-Id: <20210302104529.2319101-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The major complexity when it comes to error handling in btrfs_zero_range
stems from the code executed under the 'reserve_space' label. Rather
than it having an effect on the whole of btrfs_zero_range refactor it
so that error handling specific to the functions called in this branch
is contained only within the branch itself. This obviates the need for
having the 'space_reserved' local flag since btrfs_free_reserved_data_space
is called from the 2 error branches it's needed. Furthermore, this
rids the code from the out label and enables converting most 'goto out'
statements to simiple 'return ret' making the function easier to read.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 70 +++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d0cb513d0019..de86372dba48 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3113,23 +3113,19 @@ static int btrfs_zero_range(struct inode *inode,
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	struct extent_map *em;
-	struct extent_changeset *data_reserved = NULL;
 	int ret;
 	u64 alloc_hint = 0;
 	const u64 sectorsize = btrfs_inode_sectorsize(BTRFS_I(inode));
 	u64 alloc_start = round_down(offset, sectorsize);
 	u64 alloc_end = round_up(offset + len, sectorsize);
 	u64 bytes_to_reserve = 0;
-	bool space_reserved = false;

 	inode_dio_wait(inode);

 	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
 			      alloc_end - alloc_start);
-	if (IS_ERR(em)) {
-		ret = PTR_ERR(em);
-		goto out;
-	}
+	if (IS_ERR(em))
+		return PTR_ERR(em);

 	/*
 	 * Avoid hole punching and extent allocation for some cases. More cases
@@ -3150,9 +3146,8 @@ static int btrfs_zero_range(struct inode *inode,
 			 * needed.
 			 */
 			free_extent_map(em);
-			ret = btrfs_fallocate_update_isize(inode, offset + len,
-							   mode);
-			goto out;
+			return btrfs_fallocate_update_isize(inode, offset + len,
+							    mode);
 		}
 		/*
 		 * Part of the range is already a prealloc extent, so operate
@@ -3170,26 +3165,22 @@ static int btrfs_zero_range(struct inode *inode,
 	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
 		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
 				      sectorsize);
-		if (IS_ERR(em)) {
-			ret = PTR_ERR(em);
-			goto out;
-		}
+		if (IS_ERR(em))
+			return PTR_ERR(em);

 		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
 			free_extent_map(em);
-			ret = btrfs_fallocate_update_isize(inode, offset + len,
-							   mode);
-			goto out;
+			return btrfs_fallocate_update_isize(inode,
+							offset + len, mode);
 		}
 		if (len < sectorsize && em->block_start != EXTENT_MAP_HOLE) {
 			free_extent_map(em);
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
 						   0);
-			if (!ret)
-				ret = btrfs_fallocate_update_isize(inode,
-								   offset + len,
-								   mode);
-			return ret;
+			if (ret)
+				return ret;
+			return btrfs_fallocate_update_isize(inode,
+							    offset + len, mode);
 		}
 		free_extent_map(em);
 		alloc_start = round_down(offset, sectorsize);
@@ -3210,14 +3201,14 @@ static int btrfs_zero_range(struct inode *inode,
 		ret = btrfs_zero_range_check_range_boundary(BTRFS_I(inode),
 							    offset);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (ret == RANGE_BOUNDARY_HOLE) {
 			alloc_start = round_down(offset, sectorsize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
 			if (ret)
-				goto out;
+				return ret;
 		} else {
 			ret = 0;
 		}
@@ -3227,7 +3218,7 @@ static int btrfs_zero_range(struct inode *inode,
 		ret = btrfs_zero_range_check_range_boundary(BTRFS_I(inode),
 							    offset + len);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (ret == RANGE_BOUNDARY_HOLE) {
 			alloc_end = round_up(offset + len, sectorsize);
 			ret = 0;
@@ -3235,7 +3226,7 @@ static int btrfs_zero_range(struct inode *inode,
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset + len,
 						   0, 1);
 			if (ret)
-				goto out;
+				return ret;
 		} else {
 			ret = 0;
 		}
@@ -3243,6 +3234,7 @@ static int btrfs_zero_range(struct inode *inode,

 reserve_space:
 	if (alloc_start < alloc_end) {
+		struct extent_changeset *data_reserved = NULL;
 		struct extent_state *cached_state = NULL;
 		const u64 lockstart = alloc_start;
 		const u64 lockend = alloc_end - 1;
@@ -3251,18 +3243,27 @@ static int btrfs_zero_range(struct inode *inode,
 		ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode),
 						      bytes_to_reserve);
 		if (ret < 0)
-			goto out;
-		space_reserved = true;
+			return ret;
 		ret = btrfs_punch_hole_lock_range(inode, lockstart, lockend,
 						  &cached_state);
-		if (ret)
-			goto out;
+		if (ret) {
+			btrfs_free_reserved_data_space(BTRFS_I(inode),
+						       data_reserved,
+						       alloc_start,
+						       bytes_to_reserve);
+			return ret;
+		}
 		ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), &data_reserved,
 						alloc_start, bytes_to_reserve);
 		if (ret) {
+			btrfs_free_reserved_data_space(BTRFS_I(inode),
+						       data_reserved,
+						       alloc_start,
+						       bytes_to_reserve);
 			unlock_extent_cached(&BTRFS_I(inode)->io_tree, lockstart,
 					     lockend, &cached_state);
-			goto out;
+			extent_changeset_free(data_reserved);
+			return ret;
 		}
 		ret = btrfs_prealloc_file_range(inode, mode, alloc_start,
 						alloc_end - alloc_start,
@@ -3272,16 +3273,11 @@ static int btrfs_zero_range(struct inode *inode,
 				     lockend, &cached_state);
 		/* btrfs_prealloc_file_range releases reserved space on error */
 		if (ret) {
-			space_reserved = false;
-			goto out;
+			extent_changeset_free(data_reserved);
+			return ret;
 		}
 	}
 	ret = btrfs_fallocate_update_isize(inode, offset + len, mode);
- out:
-	if (ret && space_reserved)
-		btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
-					       alloc_start, bytes_to_reserve);
-	extent_changeset_free(data_reserved);

 	return ret;
 }
--
2.25.1

