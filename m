Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A50294853
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440849AbgJUG2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:44668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408802AbgJUG2G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFzCJG/dqdXVRC4Qbca7pddtH8GvWutEoImar3oxE1E=;
        b=ax5G4nk0p8+fjbcr837n2QgA8K3rTsqVtoYMZn2L89opp79aVkt8ViLhW98iVypkcu7L+1
        5xw5ljo+viVNzsK2vSbs0kcdnuCcfQlonQQUWvo/Q+0EkUBhqzP0kk3kVps3LLnZIMAxVg
        PHG8EUQNOY/K0KqyfwpvHYAyuWwEEuk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A653AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 55/68] btrfs: file: make hole punching page aligned for subpage
Date:   Wed, 21 Oct 2020 14:25:41 +0800
Message-Id: <20201021062554.68132-56-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since current subpage data write only support full page write, make hole
punching to follow page size instead of sector size.

Also there is an optimization branch which will skip any existing holes,
but since we can still have subpage holes in the hole punching range,
the optimization needs to be disabled in subpage case.

Update the related comment for subpage support, explaining why we don't
want that optimization.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 564784a5c0c0..cb8f2b04ccd8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2802,6 +2802,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	u64 tail_start;
 	u64 tail_len;
 	u64 orig_start = offset;
+	u32 blocksize = PAGE_SIZE;
 	int ret = 0;
 	bool same_block;
 	u64 ino_size;
@@ -2813,7 +2814,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		return ret;
 
 	inode_lock(inode);
-	ino_size = round_up(inode->i_size, fs_info->sectorsize);
+	ino_size = round_up(inode->i_size, block_size);
 	ret = find_first_non_hole(inode, &offset, &len);
 	if (ret < 0)
 		goto out_only_mutex;
@@ -2823,11 +2824,10 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		goto out_only_mutex;
 	}
 
-	lockstart = round_up(offset, btrfs_inode_sectorsize(inode));
-	lockend = round_down(offset + len,
-			     btrfs_inode_sectorsize(inode)) - 1;
-	same_block = (BTRFS_BYTES_TO_BLKS(fs_info, offset))
-		== (BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1));
+	lockstart = round_up(offset, blocksize);
+	lockend = round_down(offset + len, blocksize) - 1;
+	same_block = round_down(offset, blocksize) ==
+		     round_down(offset + len - 1, blocksize);
 	/*
 	 * We needn't truncate any block which is beyond the end of the file
 	 * because we are sure there is no data there.
@@ -2836,7 +2836,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	 * Only do this if we are in the same block and we aren't doing the
 	 * entire block.
 	 */
-	if (same_block && len < fs_info->sectorsize) {
+	if (same_block && len < blocksize) {
 		if (offset < ino_size) {
 			truncated_block = true;
 			ret = btrfs_truncate_block(inode, offset, len, 0);
@@ -2856,10 +2856,13 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		}
 	}
 
-	/* Check the aligned pages after the first unaligned page,
-	 * if offset != orig_start, which means the first unaligned page
-	 * including several following pages are already in holes,
-	 * the extra check can be skipped */
+	/*
+	 * Optimization to check if we can skip any already existing holes.
+	 *
+	 * If offset != orig_start, which means the first unaligned page
+	 * and several following pages are already holes, thus can skip the
+	 * check.
+	 */
 	if (offset == orig_start) {
 		/* after truncate page, check hole again */
 		len = offset + len - lockstart;
@@ -2871,7 +2874,8 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 			ret = 0;
 			goto out_only_mutex;
 		}
-		lockstart = offset;
+		lockstart = max_t(u64, lockstart,
+				  round_down(offset, blocksize));
 	}
 
 	/* Check the tail unaligned part is in a hole */
-- 
2.28.0

