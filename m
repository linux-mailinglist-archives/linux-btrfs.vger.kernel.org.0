Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5016E717697
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjEaGF5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjEaGF4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74201122
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SnRAIhj+LdQ1G0qfAt/U4NJTlcCmh+X5KsnsVKLgKd8=; b=GSFGCIb84dy9Yyml2uuV9uXRqp
        VAr5e5+Eeyr/6kC8vmAjoldrDcVYFtiA3z8Jv/MF6OUXVvu/KoBFq0HQL0VxgAI+OQqeRjcZwk7e5
        9DXzQww9wTt716SXXEO2+BHvmIvLnsCXkJTkFHMO+6Wvf6I1/nokszBHlXbUurg/v3z+LycvXQMvr
        DWF3PFO1eNciogDWc+r5U7T7Arkn9+PsvenYFG0L5Nah2cEFo/fnIISk30R2QY8ryniH0QDGI5bNS
        zr4GYLSsjxJzh3Cx/HcXe0sw7qtLfYEhP1RhEjTfgS4yqD1LL02hj2lA64/rj6UhGloZSHbc00OBh
        ugwDssiA==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Ey1-00GFA2-2S;
        Wed, 31 May 2023 06:05:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/16] btrfs: refactor the zoned device handling in cow_file_range
Date:   Wed, 31 May 2023 08:05:04 +0200
Message-Id: <20230531060505.468704-16-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
References: <20230531060505.468704-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Handling of the done_offset to cow_file_range is a bit confusing, as
it is not updated at all when the function succeeds, and the -EAGAIN
status is used bother for the case where we need to wait for a zone
finish and the one where the allocation was partially successful.

Change the calling convention so that done_offset is always updated,
and 0 is returned if some allocation was successful (partial allocation
can still only happen for zoned devices), and -EAGAIN is only returned
when the caller needs to wait for a zone finish.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 53 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 68ae20a3f785e3..a12d4f77859706 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1403,7 +1403,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	unsigned clear_bits;
 	unsigned long page_ops;
 	bool extent_reserved = false;
-	int ret = 0;
+	int ret;
 
 	if (btrfs_is_free_space_inode(inode)) {
 		ret = -EINVAL;
@@ -1462,7 +1462,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * inline extent or a compressed extent.
 			 */
 			unlock_page(locked_page);
-			goto out;
+			goto done;
 		} else if (ret < 0) {
 			goto out_unlock;
 		}
@@ -1491,6 +1491,23 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		ret = btrfs_reserve_extent(root, cur_alloc_size, cur_alloc_size,
 					   min_alloc_size, 0, alloc_hint,
 					   &ins, 1, 1);
+		if (ret == -EAGAIN) {
+			/*
+			 * For zoned devices, let the caller retry after writing
+			 * out the already allocated regions or waiting for a
+			 * zone to finish if no allocation was possible at all.
+			 *
+			 * Else convert to -ENOSPC since the caller cannot
+			 * retry.
+			 */
+			if (btrfs_is_zoned(fs_info)) {
+				if (start == orig_start)
+					return -EAGAIN;
+				*done_offset = start - 1;
+				return 0;
+			}
+			ret = -ENOSPC;
+		}
 		if (ret < 0)
 			goto out_unlock;
 		cur_alloc_size = ins.offset;
@@ -1571,8 +1588,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (ret)
 			goto out_unlock;
 	}
-out:
-	return ret;
+done:
+	if (done_offset)
+		*done_offset = end;
+	return 0;
 
 out_drop_extent_cache:
 	btrfs_drop_extent_map_range(inode, start, start + ram_size - 1, false);
@@ -1580,21 +1599,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_unlock:
-	/*
-	 * If done_offset is non-NULL and ret == -EAGAIN, we expect the
-	 * caller to write out the successfully allocated region and retry.
-	 */
-	if (done_offset && ret == -EAGAIN) {
-		if (orig_start < start)
-			*done_offset = start - 1;
-		else
-			*done_offset = start;
-		return ret;
-	} else if (ret == -EAGAIN) {
-		/* Convert to -ENOSPC since the caller cannot retry. */
-		ret = -ENOSPC;
-	}
-
 	/*
 	 * Now, we have three regions to clean up:
 	 *
@@ -1826,23 +1830,20 @@ static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
 	while (start <= end) {
 		ret = cow_file_range(inode, locked_page, start, end, page_started,
 				     nr_written, 0, &done_offset);
-		if (ret && ret != -EAGAIN)
-			return ret;
-
 		if (*page_started) {
 			ASSERT(ret == 0);
 			return 0;
 		}
+		if (ret == -EAGAIN) {
+			ASSERT(btrfs_is_zoned(inode->root->fs_info));
 
-		if (ret == 0)
-			done_offset = end;
-
-		if (done_offset == start) {
 			wait_on_bit_io(&inode->root->fs_info->flags,
 				       BTRFS_FS_NEED_ZONE_FINISH,
 				       TASK_UNINTERRUPTIBLE);
 			continue;
 		}
+		if (ret)
+			return ret;
 
 		extent_write_locked_range(&inode->vfs_inode, locked_page, start,
 					  done_offset, wbc);
-- 
2.39.2

