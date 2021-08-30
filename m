Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AEF3FB839
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhH3O0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 10:26:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55950 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbhH3O0n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 10:26:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0DF8200C0;
        Mon, 30 Aug 2021 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630333548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xsr7LY1mUCpXYjBcFhqAUYzYu8lMRAEivasf4ZTEGSY=;
        b=XBJadKhtZ4z8vIrZJwD7VjVcW8X5LgGRQTTwAiYdW9g2HN7P95BKgMCESUS60Er/pMoCf9
        Ywnc4bLjHcVh996ca9BhQ998RLxT9avGWzBIAAMCnqalgDWWeMiiYa3IW4blsLsXYLIDjV
        P30G3LHshsmtZEt8g0222zsTuuAjPr0=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9E97713990;
        Mon, 30 Aug 2021 14:25:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id q8H7I2zqLGF4BQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Mon, 30 Aug 2021 14:25:48 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [RESEND PATCH] btrfs: Refactor error handling in btrfs_zero_range
Date:   Mon, 30 Aug 2021 17:25:47 +0300
Message-Id: <20210830142547.889802-1-nborisov@suse.com>
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

I sent this patch some time ago but didn't get any replies so now I'm resending
it again.
 fs/btrfs/file.c | 70 +++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7ff577005d0f..94f4353618d4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3143,23 +3143,19 @@ static int btrfs_zero_range(struct inode *inode,
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
@@ -3180,9 +3176,8 @@ static int btrfs_zero_range(struct inode *inode,
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
@@ -3200,26 +3195,22 @@ static int btrfs_zero_range(struct inode *inode,
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
+			return  btrfs_fallocate_update_isize(inode,
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
@@ -3240,14 +3231,14 @@ static int btrfs_zero_range(struct inode *inode,
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
@@ -3257,7 +3248,7 @@ static int btrfs_zero_range(struct inode *inode,
 		ret = btrfs_zero_range_check_range_boundary(BTRFS_I(inode),
 							    offset + len);
 		if (ret < 0)
-			goto out;
+			return ret;
 		if (ret == RANGE_BOUNDARY_HOLE) {
 			alloc_end = round_up(offset + len, sectorsize);
 			ret = 0;
@@ -3265,7 +3256,7 @@ static int btrfs_zero_range(struct inode *inode,
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset + len,
 						   0, 1);
 			if (ret)
-				goto out;
+				return ret;
 		} else {
 			ret = 0;
 		}
@@ -3273,6 +3264,7 @@ static int btrfs_zero_range(struct inode *inode,

 reserve_space:
 	if (alloc_start < alloc_end) {
+		struct extent_changeset *data_reserved = NULL;
 		struct extent_state *cached_state = NULL;
 		const u64 lockstart = alloc_start;
 		const u64 lockend = alloc_end - 1;
@@ -3281,18 +3273,27 @@ static int btrfs_zero_range(struct inode *inode,
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
@@ -3302,16 +3303,11 @@ static int btrfs_zero_range(struct inode *inode,
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

