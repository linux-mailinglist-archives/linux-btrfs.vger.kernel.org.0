Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7D3511249
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358732AbiD0HWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358730AbiD0HWl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0DE60AB5
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 564E0210E1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QVPxQdNB7UJGeJiSzH7G0crAhp9nbFTA8U8HbjatvMI=;
        b=jou24xU6cjZu+K457qXmzmzNWIxe9nfINNaiXK7uKfWi4fA4kZyao7D08EiPBxNFAQlnZ/
        gLMus+qaBQn89JeMhrd0qy9e7LlkNqdC4Fjpjxgfp989AOK7+BYiIaQ6SwZ7r5cbAYGsj3
        aMZB5lWDt5LMk6K8rRbR/CqNPKbRGJs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CA2613A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eBxiGIHuaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 12/12] btrfs: remove btrfs_inode::io_failure_tree
Date:   Wed, 27 Apr 2022 15:18:58 +0800
Message-Id: <4e7f71eb811b82d2053cb1ba61111abfa94abf01.1651043618.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651043617.git.wqu@suse.com>
References: <cover.1651043617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we're handling all data read error inside the endio function,
there is no need to record any error in io_failure_tree.

Let remove btrfs_inode::io_failure_tree completely.

Although we have extra memory usage for btrfs_read_repair_ctrl, its
lifespan is only in endio, while the io_failure_tree has a lifespan as
long as each inode.
Thus this should bring a overall memory usage reduce.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h       | 5 -----
 fs/btrfs/extent-io-tree.h    | 1 -
 fs/btrfs/inode.c             | 3 ---
 include/trace/events/btrfs.h | 1 -
 4 files changed, 10 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 32131a5d321b..2ff4da4ed2a1 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -91,11 +91,6 @@ struct btrfs_inode {
 	/* the io_tree does range state (DIRTY, LOCKED etc) */
 	struct extent_io_tree io_tree;
 
-	/* special utility tree used to record which mirrors have already been
-	 * tried when checksums fail for a given block
-	 */
-	struct extent_io_tree io_failure_tree;
-
 	/*
 	 * Keep track of where the inode has extent items mapped in order to
 	 * make sure the i_size adjustments are accurate
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index d46c064e5dad..8ab9b6cd53ed 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -56,7 +56,6 @@ enum {
 	IO_TREE_FS_EXCLUDED_EXTENTS,
 	IO_TREE_BTREE_INODE_IO,
 	IO_TREE_INODE_IO,
-	IO_TREE_INODE_IO_FAILURE,
 	IO_TREE_RELOC_BLOCKS,
 	IO_TREE_TRANS_DIRTY_PAGES,
 	IO_TREE_ROOT_DIRTY_LOG_PAGES,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 99408618af1c..4351ee995a52 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8822,12 +8822,9 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	inode = &ei->vfs_inode;
 	extent_map_tree_init(&ei->extent_tree);
 	extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO, inode);
-	extent_io_tree_init(fs_info, &ei->io_failure_tree,
-			    IO_TREE_INODE_IO_FAILURE, inode);
 	extent_io_tree_init(fs_info, &ei->file_extent_tree,
 			    IO_TREE_INODE_FILE_EXTENT, inode);
 	ei->io_tree.track_uptodate = true;
-	ei->io_failure_tree.track_uptodate = true;
 	atomic_set(&ei->sync_writers, 0);
 	mutex_init(&ei->log_mutex);
 	btrfs_ordered_inode_tree_init(&ei->ordered_tree);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index f068ff30d654..020ca1f7687a 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -82,7 +82,6 @@ struct btrfs_space_info;
 	EM( IO_TREE_FS_EXCLUDED_EXTENTS,  "EXCLUDED_EXTENTS")	    \
 	EM( IO_TREE_BTREE_INODE_IO,	  "BTREE_INODE_IO")	    \
 	EM( IO_TREE_INODE_IO,		  "INODE_IO")		    \
-	EM( IO_TREE_INODE_IO_FAILURE,	  "INODE_IO_FAILURE")	    \
 	EM( IO_TREE_RELOC_BLOCKS,	  "RELOC_BLOCKS")	    \
 	EM( IO_TREE_TRANS_DIRTY_PAGES,	  "TRANS_DIRTY_PAGES")      \
 	EM( IO_TREE_ROOT_DIRTY_LOG_PAGES, "ROOT_DIRTY_LOG_PAGES")   \
-- 
2.36.0

