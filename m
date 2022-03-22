Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CCF4E388A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Mar 2022 06:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbiCVFjj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 01:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236710AbiCVFjg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 01:39:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C96A36B7A
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 22:38:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CEDA41F385
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 05:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647927485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=AB4/K+zGAFD+hMdQ7/mZAE87cbHcEq8A7S8/rNcfLwI=;
        b=PECZ9fUiqDKQsczrbPbmej3uhG8GNTsd5SYwoAmEXzlqzzRl5eIuJCxYTdxiUpo9KojxK+
        WTYjyWRoAGmrY0hl+LDspjNBD8Gj9hF1dmN5cjXveQntvIxdCxW2X7yPaT1Lyv9uqE46qx
        /B/+cRioO3oIWz1gvG3l070PiMO1C3k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7E20139FF
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 05:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MYJmI7tgOWIgLQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 05:38:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: verify the endio function at layer boundary
Date:   Tue, 22 Mar 2022 13:37:45 +0800
Message-Id: <27688f5ed1d59b26255f285843c4573322acfa39.1647926689.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs has two layer boundaries for its bios:

  inode address space

  ---------------------------    <- Operations like data read map those
                                    bio to btrfs logical address space
  btrfs logical address space

  ---------------------------    <- btrfs_map_bio() maps those bio to
                                    device physical address space

  device physical address space

Unlike stacked drivers, btrfs handles all those operation in-house, thus
we have very limited (although it's already 8 different functions) endio
functions.

Here we verify the endio functions between btrfs logical address space
and device physical address space.

This also helps to have a better layer separation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This patch is based on previous bio split patchset.

Reason for RFC:

I want to make this thread a possible discussion on the future iomap
integration.

Goldwyn is working on the iomap integration for buffered data read/write
(direct IO is already using iomap).

From the iomap point of view, it only cares if one read/write bio
finishes without error. It doesn't care about if some range failed due
to csum error.

Its all-or-nothing method is a perfect match for stacked drivers, which
mostly uses chained bio to split bios for stripes.

But it can be problematic for btrfs, as btrfs needs to try to repair the
exact corrupted range.

Thus if we're going to use iomap, we need btrfs to know if a bio should
be ended like chained bios, or the endio function can be called for the
split range.

Currently all involved functions are already split bio compatible, so
this patch is just a sanity check.
---
 fs/btrfs/compression.c |  8 ++---
 fs/btrfs/compression.h |  2 ++
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/extent_io.c   | 73 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h   |  3 ++
 fs/btrfs/inode.c       |  4 +--
 fs/btrfs/volumes.c     |  1 +
 7 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2df034f6194c..b6c59c5cdacc 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -282,7 +282,7 @@ static void finish_compressed_bio_read(struct compressed_bio *cb)
  * The compressed pages are freed here, and it must be run
  * in process context
  */
-static void end_compressed_bio_read(struct bio *bio)
+void btrfs_end_compressed_bio_read(struct bio *bio)
 {
 	struct compressed_bio *cb = bio->bi_private;
 	struct inode *inode;
@@ -406,7 +406,7 @@ static void finish_compressed_bio_write(struct compressed_bio *cb)
  * This also calls the writeback end hooks for the file pages so that metadata
  * and checksums can be updated in the file.
  */
-static void end_compressed_bio_write(struct bio *bio)
+void btrfs_end_compressed_bio_write(struct bio *bio)
 {
 	struct compressed_bio *cb = bio->bi_private;
 
@@ -528,7 +528,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		/* Allocate new bio if submitted or not yet allocated */
 		if (!bio) {
 			bio = alloc_compressed_bio(cb, cur_disk_bytenr,
-				bio_op | write_flags, end_compressed_bio_write);
+				bio_op | write_flags, btrfs_end_compressed_bio_write);
 			if (IS_ERR(bio)) {
 				ret = errno_to_blk_status(PTR_ERR(bio));
 				bio = NULL;
@@ -861,7 +861,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		/* Allocate new bio if submitted or not yet allocated */
 		if (!comp_bio) {
 			comp_bio = alloc_compressed_bio(cb, cur_disk_byte,
-					REQ_OP_READ, end_compressed_bio_read);
+					REQ_OP_READ, btrfs_end_compressed_bio_read);
 			if (IS_ERR(comp_bio)) {
 				ret = errno_to_blk_status(PTR_ERR(comp_bio));
 				comp_bio = NULL;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index ac5b20731d2a..8c15ba63bd5d 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -183,5 +183,7 @@ struct list_head *zstd_alloc_workspace(unsigned int level);
 void zstd_free_workspace(struct list_head *ws);
 struct list_head *zstd_get_workspace(unsigned int level);
 void zstd_put_workspace(struct list_head *ws);
+void btrfs_end_compressed_bio_read(struct bio *bio);
+void btrfs_end_compressed_bio_write(struct bio *bio);
 
 #endif
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db17bd05a21..bd78916d0001 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3225,6 +3225,8 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
+void btrfs_end_dio_bio(struct bio *bio);
+void btrfs_encoded_read_endio(struct bio *bio);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a5764b89d020..d7a0ce3b82f3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -28,6 +28,7 @@
 #include "subpage.h"
 #include "zoned.h"
 #include "block-group.h"
+#include "compression.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -3218,6 +3219,7 @@ static void split_bio_endio(struct bio *bio)
 	ASSERT(parent && !btrfs_bio(parent)->is_split_bio);
 
 	bio->bi_end_io = bbio->orig_endio;
+	btrfs_check_logical_endio(bbio->device->fs_info, bio);
 	bio_endio(bio);
 	bio_endio(parent);
 }
@@ -7540,3 +7542,74 @@ void btrfs_readahead_node_child(struct extent_buffer *node, int slot)
 				   btrfs_node_ptr_generation(node, slot),
 				   btrfs_header_level(node) - 1);
 }
+
+#ifdef CONFIG_BTRFS_DEBUG
+/*
+ * Make sure the logical bio has correct endio function.
+ *
+ * In btrfs there are currently two types of endio:
+ * - Logical address space bio
+ *   They use logical bytenr
+ * - Device address space bio
+ *   They use physical bytenr of each device
+ *
+ * This function makes sure the bio has correct endio functions for its endio
+ * function.
+ *
+ * NOTE: There are some cases not covered by this function:
+ *
+ * - Scrub
+ *   It maintains its own device mapping, thus directly submit bio to device, without
+ *   using logical address space bio.
+ *
+ * - Read repair
+ *   The same as scrub.
+ *
+ * - RAID
+ *   They work at a lower level
+ *
+ */
+void btrfs_check_logical_endio(const struct btrfs_fs_info *fs_info,
+			       const struct bio *bio)
+{
+	/* For directIO, read write endio shares the same function */
+	if (bio->bi_end_io == btrfs_end_dio_bio)
+		return;
+
+	if (bio_op(bio) == REQ_OP_READ) {
+		/*
+		 * For read bio, we have the following valid endios for logical
+		 * bios:
+		 * - DirectIO (handled above)
+		 * - Buffered read for both data and metadata
+		 * - Compressed data read
+		 * - Encoded data read
+		 */
+		if (likely(bio->bi_end_io == btrfs_encoded_read_endio ||
+			   bio->bi_end_io == end_bio_extent_readpage ||
+			   bio->bi_end_io == btrfs_end_compressed_bio_read))
+			return;
+	} else {
+		/*
+		 * For write bio, we have the following valid endios for logical
+		 * bios:
+		 * - DirectIO (handled above)
+		 * - Buffered data write
+		 * - Metadata write (only buffered)
+		 *   This includes both endios for subpage and regular case
+		 * - Compressed data write
+		 */
+		if (likely(bio->bi_end_io == end_bio_extent_writepage ||
+			   bio->bi_end_io == end_bio_extent_buffer_writepage ||
+			   bio->bi_end_io == end_bio_subpage_eb_writepage ||
+			   bio->bi_end_io == btrfs_end_compressed_bio_write))
+			return;
+	}
+
+	/* Unknown end io functions for logical bio */
+	btrfs_crit(fs_info,
+	"unexpect endio function for logical bio, logical=%llu bi_end_io=%ps",
+		   bio->bi_iter.bi_sector, bio->bi_end_io);
+	BUG_ON(1);
+}
+#endif /* CONFIG_BTRFS_DEBUG */
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 493c2cd96424..97e91bce66b1 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -320,8 +320,11 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 
 #ifdef CONFIG_BTRFS_DEBUG
 void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info);
+void btrfs_check_logical_endio(const struct btrfs_fs_info *fs_info,
+			       const struct bio *bio);
 #else
 #define btrfs_extent_buffer_leak_debug_check(fs_info)	do {} while (0)
+#define btrfs_check_logical_endio(fs_info, bio)		do {} while (0)
 #endif
 
 #endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ecf039c272fc..83f48a4d2ef9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7881,7 +7881,7 @@ static blk_status_t btrfs_submit_bio_start_direct_io(struct inode *inode,
 	return btrfs_csum_one_bio(BTRFS_I(inode), bio, dio_file_offset, false);
 }
 
-static void btrfs_end_dio_bio(struct bio *bio)
+void btrfs_end_dio_bio(struct bio *bio)
 {
 	struct btrfs_dio_private *dip = bio->bi_private;
 	struct bvec_iter iter;
@@ -10301,7 +10301,7 @@ static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
 	return BLK_STS_OK;
 }
 
-static void btrfs_encoded_read_endio(struct bio *bio)
+void btrfs_encoded_read_endio(struct bio *bio)
 {
 	struct btrfs_encoded_read_private *priv = bio->bi_private;
 	struct btrfs_bio *bbio = btrfs_bio(bio);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 301491429e37..e70a272b41f9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6877,6 +6877,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	u64 cur_logical = orig_logical;
 	int ret;
 
+	btrfs_check_logical_endio(fs_info, bio);
 	while (cur_logical < orig_logical + orig_length) {
 		u64 map_length = orig_logical + orig_length - cur_logical;
 		struct btrfs_io_context *bioc = NULL;
-- 
2.35.1

