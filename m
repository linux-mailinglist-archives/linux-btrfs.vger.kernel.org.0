Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C42C6F5AFC
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjECPZC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjECPZA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:25:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3971B1730
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jQfcrYL1fPwM78F25IQsmQRkL4H+iyAfOSfmq1EWmJM=; b=2LJKHMbZns2H9rumlmBiWgVXWt
        XF6oLr+wlEKixvYRobMtAwS26enQ0YVQSNAjins8HQl2428maYvp7R4sHIaqlcAIiah6DcvTI2RPb
        zJkUl449pxdvKocgeQWedgURBsvb1+MDZwfwTIhR6ygtPcJJj9b2mp986D9rZCdW3SEQQm/uGvNw0
        bZSzYWpdSotSBSDfMU16r3uM5mDq2hK4oJ57OGWuF7fwe41CsPwEEBg0f8SEhV80RJXNwU9qgNKhG
        MOqXTfGf12uAfIw+jazbVxhkRGOIy+5wZQ/aFqUUb7fLKd8XkZd+yE+WUD76OQ6qnsVHib61iXLsF
        VJNUU3DQ==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puELf-004xdi-21;
        Wed, 03 May 2023 15:24:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 04/21] btrfs: merge verify_parent_transid and btrfs_buffer_uptodate
Date:   Wed,  3 May 2023 17:24:24 +0200
Message-Id: <20230503152441.1141019-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
References: <20230503152441.1141019-1-hch@lst.de>
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

verify_parent_transid is only called by btrfs_buffer_uptodate, which
confusingly inverts the return value.  Merge the two functions and
reflow the parent_transid so that error handling is in a branch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 46 +++++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 33a1ed6e68ed3e..abd00d78c1a709 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -110,32 +110,33 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
  * detect blocks that either didn't get written at all or got written
  * in the wrong place.
  */
-static int verify_parent_transid(struct extent_io_tree *io_tree,
-				 struct extent_buffer *eb, u64 parent_transid,
-				 int atomic)
+int btrfs_buffer_uptodate(struct extent_buffer *eb, u64 parent_transid,
+			  int atomic)
 {
+	struct inode *btree_inode = eb->pages[0]->mapping->host;
+	struct extent_io_tree *io_tree = &BTRFS_I(btree_inode)->io_tree;
 	struct extent_state *cached_state = NULL;
-	int ret;
+	int ret = 1;
 
-	if (!parent_transid || btrfs_header_generation(eb) == parent_transid)
+	if (!extent_buffer_uptodate(eb))
 		return 0;
 
+	if (!parent_transid || btrfs_header_generation(eb) == parent_transid)
+		return 1;
+
 	if (atomic)
 		return -EAGAIN;
 
 	lock_extent(io_tree, eb->start, eb->start + eb->len - 1, &cached_state);
-	if (extent_buffer_uptodate(eb) &&
-	    btrfs_header_generation(eb) == parent_transid) {
-		ret = 0;
-		goto out;
-	}
-	btrfs_err_rl(eb->fs_info,
+	if (!extent_buffer_uptodate(eb) ||
+	    btrfs_header_generation(eb) != parent_transid) {
+		btrfs_err_rl(eb->fs_info,
 "parent transid verify failed on logical %llu mirror %u wanted %llu found %llu",
 			eb->start, eb->read_mirror,
 			parent_transid, btrfs_header_generation(eb));
-	ret = 1;
-	clear_extent_buffer_uptodate(eb);
-out:
+		clear_extent_buffer_uptodate(eb);
+		ret = 0;
+	}
 	unlock_extent(io_tree, eb->start, eb->start + eb->len - 1,
 		      &cached_state);
 	return ret;
@@ -4644,23 +4645,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	btrfs_close_devices(fs_info->fs_devices);
 }
 
-int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
-			  int atomic)
-{
-	int ret;
-	struct inode *btree_inode = buf->pages[0]->mapping->host;
-
-	ret = extent_buffer_uptodate(buf);
-	if (!ret)
-		return ret;
-
-	ret = verify_parent_transid(&BTRFS_I(btree_inode)->io_tree, buf,
-				    parent_transid, atomic);
-	if (ret == -EAGAIN)
-		return ret;
-	return !ret;
-}
-
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
-- 
2.39.2

