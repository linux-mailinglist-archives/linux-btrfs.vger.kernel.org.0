Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E237B7D66
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242216AbjJDKjP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 06:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242213AbjJDKjN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 06:39:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA354AF
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 03:39:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0938BC433CB
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 10:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696415942;
        bh=jdm6IuM+nsbObIqkWKZ6X8WLaeVNBagouTnbhwfD6vc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S9bjxnB6nKQSKA4E3pVLWMsBiq1KpsOJ4mNCd9U3YtAXyZxOBHMdG0qChAx4E2Teb
         A1rTFU/1ZeDQOH3APaFh1WE+fmnZc964Ib26KIofKHXQF3ecELOL1xFdiU+NNYwOK2
         vOCPmmlYn6GNxVhahhv1yiT42KRclUfv6h7DxDPXYf2bzCNMpVwLIMIiOGdQm42OK7
         ysuwoQSSkUXp9H/Uf3H3YhzYhnqtNdufUvCB6+iWFb25kCmiqgY5lTdliqoZ4gpomb
         YmlMZwz9uaUBjACcknTlW46TThVSyrlSHlWRMzi0sC3paAXRlGnXEDkdgb2RdTS7PQ
         G9Wre8GIIv9wg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: update comment for struct btrfs_inode::lock
Date:   Wed,  4 Oct 2023 11:38:53 +0100
Message-Id: <02305b5457dcfa0b425cb4ebeba01271f28c49f1.1696415673.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696415673.git.fdmanana@suse.com>
References: <cover.1696415673.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Update the comment for the lock named "lock" in struct btrfs_inode because
it does not mention that the fields "delalloc_bytes", "defrag_bytes",
"csum_bytes", "outstanding_extents" and "disk_i_size" are also protected
by that lock.

Also add a comment on top of each field protected by this lock to mention
that the lock protects them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d32ef248828e..bebb5921b922 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -93,8 +93,9 @@ struct btrfs_inode {
 	/*
 	 * Lock for counters and all fields used to determine if the inode is in
 	 * the log or not (last_trans, last_sub_trans, last_log_commit,
-	 * logged_trans), to access/update new_delalloc_bytes and to update the
-	 * VFS' inode number of bytes used.
+	 * logged_trans), to access/update delalloc_bytes, new_delalloc_bytes,
+	 * defrag_bytes, disk_i_size, outstanding_extents, csum_bytes and to
+	 * update the VFS' inode number of bytes used.
 	 */
 	spinlock_t lock;
 
@@ -117,7 +118,7 @@ struct btrfs_inode {
 	 * Counters to keep track of the number of extent item's we may use due
 	 * to delalloc and such.  outstanding_extents is the number of extent
 	 * items we think we'll end up using, and reserved_extents is the number
-	 * of extent items we've reserved metadata for.
+	 * of extent items we've reserved metadata for. Protected by 'lock'.
 	 */
 	unsigned outstanding_extents;
 
@@ -143,28 +144,31 @@ struct btrfs_inode {
 	u64 generation;
 
 	/*
-	 * transid of the trans_handle that last modified this inode
+	 * ID of the transaction handle that last modified this inode.
+	 * Protected by 'lock'.
 	 */
 	u64 last_trans;
 
 	/*
-	 * transid that last logged this inode
+	 * ID of the transaction that last logged this inode.
+	 * Protected by 'lock'.
 	 */
 	u64 logged_trans;
 
 	/*
-	 * log transid when this inode was last modified
+	 * Log transaction ID when this inode was last modified.
+	 * Protected by 'lock'.
 	 */
 	int last_sub_trans;
 
-	/* a local copy of root's last_log_commit */
+	/* A local copy of root's last_log_commit. Protected by 'lock'. */
 	int last_log_commit;
 
 	union {
 		/*
 		 * Total number of bytes pending delalloc, used by stat to
 		 * calculate the real block usage of the file. This is used
-		 * only for files.
+		 * only for files. Protected by 'lock'.
 		 */
 		u64 delalloc_bytes;
 		/*
@@ -182,7 +186,7 @@ struct btrfs_inode {
 		 * Total number of bytes pending delalloc that fall within a file
 		 * range that is either a hole or beyond EOF (and no prealloc extent
 		 * exists in the range). This is always <= delalloc_bytes and this
-		 * is used only for files.
+		 * is used only for files. Protected by 'lock'.
 		 */
 		u64 new_delalloc_bytes;
 		/*
@@ -193,15 +197,15 @@ struct btrfs_inode {
 	};
 
 	/*
-	 * total number of bytes pending defrag, used by stat to check whether
-	 * it needs COW.
+	 * Total number of bytes pending defrag, used by stat to check whether
+	 * it needs COW. Protected by 'lock'.
 	 */
 	u64 defrag_bytes;
 
 	/*
-	 * the size of the file stored in the metadata on disk.  data=ordered
+	 * The size of the file stored in the metadata on disk.  data=ordered
 	 * means the in-memory i_size might be larger than the size on disk
-	 * because not all the blocks are written yet.
+	 * because not all the blocks are written yet. Protected by 'lock'.
 	 */
 	u64 disk_i_size;
 
@@ -235,7 +239,7 @@ struct btrfs_inode {
 
 	/*
 	 * Number of bytes outstanding that are going to need csums.  This is
-	 * used in ENOSPC accounting.
+	 * used in ENOSPC accounting. Protected by 'lock'.
 	 */
 	u64 csum_bytes;
 
-- 
2.40.1

