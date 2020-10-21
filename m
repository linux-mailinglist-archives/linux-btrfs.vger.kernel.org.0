Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEB529485A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440851AbgJUG2U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:44898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408668AbgJUG2U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KumKuUaRwWqWy2QYBREe/xkuwU22J4PNsV1XesEWk8w=;
        b=pk+tRktbvDh7NGkF/1Ut5uChd9D4uuvFC0zpKAw8itWxASUFq6Y4DVqdCAUhJ3EqKL63po
        DNkCFoOuIKrCMBZ9sqiLrdcA17bVlN7hgPGQk1wQ4koTlIW+DHtm85SgFdcMN/ufaEbDg+
        1RsSk3hLh6Czh4MLrRl/eVK5B3hjVjA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 86636AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 62/68] btrfs: file: make hole punch and zero range to be page aligned
Date:   Wed, 21 Oct 2020 14:25:48 +0800
Message-Id: <20201021062554.68132-63-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To workaround the fact that we can't yet submit subpage write bio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 8f44bde1d04e..6e342c466fdf 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2455,6 +2455,8 @@ static int btrfs_punch_hole_lock_range(struct inode *inode,
 				       const u64 lockend,
 				       struct extent_state **cached_state)
 {
+	ASSERT(IS_ALIGNED(lockstart, PAGE_SIZE) &&
+	       IS_ALIGNED(lockend + 1, PAGE_SIZE));
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 		int ret;
@@ -3033,12 +3035,12 @@ enum {
 static int btrfs_zero_range_check_range_boundary(struct inode *inode,
 						 u64 offset)
 {
-	const u64 sectorsize = btrfs_inode_sectorsize(inode);
+	const u32 blocksize = PAGE_SIZE;
 	struct extent_map *em;
 	int ret;
 
-	offset = round_down(offset, sectorsize);
-	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, sectorsize);
+	offset = round_down(offset, blocksize);
+	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, offset, blocksize);
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 
@@ -3058,14 +3060,13 @@ static int btrfs_zero_range(struct inode *inode,
 			    loff_t len,
 			    const int mode)
 {
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	struct extent_map *em;
 	struct extent_changeset *data_reserved = NULL;
 	int ret;
+	const u32 blocksize = PAGE_SIZE;
 	u64 alloc_hint = 0;
-	const u64 sectorsize = btrfs_inode_sectorsize(inode);
-	u64 alloc_start = round_down(offset, sectorsize);
-	u64 alloc_end = round_up(offset + len, sectorsize);
+	u64 alloc_start = round_down(offset, blocksize);
+	u64 alloc_end = round_up(offset + len, blocksize);
 	u64 bytes_to_reserve = 0;
 	bool space_reserved = false;
 
@@ -3105,18 +3106,17 @@ static int btrfs_zero_range(struct inode *inode,
 		 * Part of the range is already a prealloc extent, so operate
 		 * only on the remaining part of the range.
 		 */
-		alloc_start = em_end;
-		ASSERT(IS_ALIGNED(alloc_start, sectorsize));
+		alloc_start = round_down(em_end, blocksize);
 		len = offset + len - alloc_start;
 		offset = alloc_start;
 		alloc_hint = em->block_start + em->len;
 	}
 	free_extent_map(em);
 
-	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) ==
-	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
+	if (round_down(offset, blocksize) ==
+	    round_down(offset + len - 1, blocksize)) {
 		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, alloc_start,
-				      sectorsize);
+				      blocksize);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
@@ -3128,7 +3128,7 @@ static int btrfs_zero_range(struct inode *inode,
 							   mode);
 			goto out;
 		}
-		if (len < sectorsize && em->block_start != EXTENT_MAP_HOLE) {
+		if (len < blocksize && em->block_start != EXTENT_MAP_HOLE) {
 			free_extent_map(em);
 			ret = btrfs_truncate_block(inode, offset, len, 0);
 			if (!ret)
@@ -3138,13 +3138,13 @@ static int btrfs_zero_range(struct inode *inode,
 			return ret;
 		}
 		free_extent_map(em);
-		alloc_start = round_down(offset, sectorsize);
-		alloc_end = alloc_start + sectorsize;
+		alloc_start = round_down(offset, blocksize);
+		alloc_end = alloc_start + blocksize;
 		goto reserve_space;
 	}
 
-	alloc_start = round_up(offset, sectorsize);
-	alloc_end = round_down(offset + len, sectorsize);
+	alloc_start = round_up(offset, blocksize);
+	alloc_end = round_down(offset + len, blocksize);
 
 	/*
 	 * For unaligned ranges, check the pages at the boundaries, they might
@@ -3152,12 +3152,12 @@ static int btrfs_zero_range(struct inode *inode,
 	 * they might map to a hole, in which case we need our allocation range
 	 * to cover them.
 	 */
-	if (!IS_ALIGNED(offset, sectorsize)) {
+	if (!IS_ALIGNED(offset, blocksize)) {
 		ret = btrfs_zero_range_check_range_boundary(inode, offset);
 		if (ret < 0)
 			goto out;
 		if (ret == RANGE_BOUNDARY_HOLE) {
-			alloc_start = round_down(offset, sectorsize);
+			alloc_start = round_down(offset, blocksize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
 			ret = btrfs_truncate_block(inode, offset, 0, 0);
@@ -3168,13 +3168,13 @@ static int btrfs_zero_range(struct inode *inode,
 		}
 	}
 
-	if (!IS_ALIGNED(offset + len, sectorsize)) {
+	if (!IS_ALIGNED(offset + len, blocksize)) {
 		ret = btrfs_zero_range_check_range_boundary(inode,
 							    offset + len);
 		if (ret < 0)
 			goto out;
 		if (ret == RANGE_BOUNDARY_HOLE) {
-			alloc_end = round_up(offset + len, sectorsize);
+			alloc_end = round_up(offset + len, blocksize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
 			ret = btrfs_truncate_block(inode, offset + len, 0, 1);
-- 
2.28.0

