Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08B93A58D8
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhFMNnV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34620 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhFMNnU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:20 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9617C21970;
        Sun, 13 Jun 2021 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNZG1TTDQhR2kz38dZlRJEd5iHoYePtsFIpo634A8Wc=;
        b=kKjwRfwJ2s5tkRXu7yGfDXvV4qhbw9EMPOYQD5Dt6UxpnOQdn0MeOCUF1xagRAvkwJgfU5
        VBuqjPBd8acZb89mTJN6EER3GYuHP779GD5DX/4D3C3CTwHm5ajMFvyYiO/yqZxANPOYrA
        QOHuqM6XybmeuxUMTK1AXhAGgyKExaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNZG1TTDQhR2kz38dZlRJEd5iHoYePtsFIpo634A8Wc=;
        b=pnMdmsIr8yGl3NQiKT9k0lskHhI0kc9gEQ58wMifG343TslZWv7y5uF3J8Fjs2eAamyHvM
        8X4P4zbInP28vLBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 38961118DD;
        Sun, 13 Jun 2021 13:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNZG1TTDQhR2kz38dZlRJEd5iHoYePtsFIpo634A8Wc=;
        b=kKjwRfwJ2s5tkRXu7yGfDXvV4qhbw9EMPOYQD5Dt6UxpnOQdn0MeOCUF1xagRAvkwJgfU5
        VBuqjPBd8acZb89mTJN6EER3GYuHP779GD5DX/4D3C3CTwHm5ajMFvyYiO/yqZxANPOYrA
        QOHuqM6XybmeuxUMTK1AXhAGgyKExaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNZG1TTDQhR2kz38dZlRJEd5iHoYePtsFIpo634A8Wc=;
        b=pnMdmsIr8yGl3NQiKT9k0lskHhI0kc9gEQ58wMifG343TslZWv7y5uF3J8Fjs2eAamyHvM
        8X4P4zbInP28vLBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id cLMfAv4KxmCrJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:41:18 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 29/31] btrfs: Use iomap_readpage_ops to allocate and submit bio
Date:   Sun, 13 Jun 2021 08:39:57 -0500
Message-Id: <a4c3d7874e487e6902126b6bc905ae9da249f9f5.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Set the alloc_io() and submit_io() functions of iomap_readpage_ops
While performing readpage, the an btrfs_io_bio is allocated to fill
csums and check data csums.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h     |  1 +
 fs/btrfs/extent_io.c | 10 ++++++++++
 fs/btrfs/extent_io.h |  3 +++
 fs/btrfs/inode.c     |  9 +++++++--
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d4567c7a93cb..5826933ba4d2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3214,6 +3214,7 @@ void btrfs_inode_unlock(struct inode *inode, unsigned int ilock_flags);
 void btrfs_update_inode_bytes(struct btrfs_inode *inode,
 			      const u64 add_bytes,
 			      const u64 del_bytes);
+void btrfs_buffered_submit_io(struct inode *inode, struct bio *bio);
 
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b0a01e3e4e7f..88a8fbf467b0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -7284,3 +7284,13 @@ void btrfs_readahead_node_child(struct extent_buffer *node, int slot)
 				   btrfs_node_ptr_generation(node, slot),
 				   btrfs_header_level(node) - 1);
 }
+
+static struct bio *btrfs_readpage_alloc_bio(gfp_t gfp_mask, unsigned short nr)
+{
+	return btrfs_io_bio_alloc(nr);
+}
+
+const struct iomap_readpage_ops btrfs_iomap_readpage_ops = {
+	.alloc_bio = btrfs_readpage_alloc_bio,
+	.submit_io = btrfs_buffered_submit_io,
+};
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e3685b071eba..8cb79f8d1af8 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -7,6 +7,7 @@
 #include <linux/refcount.h>
 #include <linux/fiemap.h>
 #include <linux/btrfs_tree.h>
+#include <linux/iomap.h>
 #include "ulist.h"
 
 /*
@@ -313,6 +314,8 @@ int btrfs_repair_one_sector(struct inode *inode,
 			    u64 start, int failed_mirror,
 			    submit_bio_hook_t *submit_bio_hook);
 
+extern const struct iomap_readpage_ops btrfs_iomap_readpage_ops;
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6b9b238837b8..1ca83c11e8b9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -35,6 +35,7 @@
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
+#include "extent_io.h"
 #include "transaction.h"
 #include "btrfs_inode.h"
 #include "print-tree.h"
@@ -8431,7 +8432,7 @@ static void btrfs_writepage_endio(struct bio *bio)
 	iomap_writepage_end_bio(bio);
 }
 
-static void btrfs_buffered_submit_io(struct inode *inode, struct bio *bio)
+void btrfs_buffered_submit_io(struct inode *inode, struct bio *bio)
 {
 	struct bio_vec *bvec;
 	struct bvec_iter_all iter_all;
@@ -8440,7 +8441,11 @@ static void btrfs_buffered_submit_io(struct inode *inode, struct bio *bio)
 		bio_for_each_segment_all(bvec, bio, iter_all)
 			set_page_extent_mapped(bvec->bv_page);
 
-	bio->bi_end_io = btrfs_writepage_endio;
+	if (bio_op(bio) == REQ_OP_WRITE)
+		bio->bi_end_io = btrfs_writepage_endio;
+	else
+		bio->bi_end_io = btrfs_readpage_endio;
+
 	if (is_data_inode(inode))
 		btrfs_submit_data_bio(inode, bio, 0, 0);
 	else
-- 
2.31.1

