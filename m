Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971DB797F28
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 01:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbjIGXQT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Sep 2023 19:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjIGXQS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Sep 2023 19:16:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E783BD
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Sep 2023 16:16:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4A1C6210DB;
        Thu,  7 Sep 2023 23:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694128573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tCDVKww6XokR+tOZIqJYRVbnfyMRrQtOAjukDoN90dI=;
        b=gle45QtdgQwtmGp8rwIRkRC99Ne4K6/4agloT5uAUTveSjSsYheJ0OIwR6FhmmIGQ74iSL
        Qi9ltCQRNM3DhXHEsz75FMCesy8zWCht43HH2Q/AR51FrfiOs3ZujJZT0epdnR2Ga4ukoa
        rUZWv1m8fRembLO1/SpKnuL7iypBmjY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3F2922C142;
        Thu,  7 Sep 2023 23:16:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 71503DA8C5; Fri,  8 Sep 2023 01:09:42 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 10/10] btrfs: move extent_buffer::lock_owner to debug section
Date:   Fri,  8 Sep 2023 01:09:42 +0200
Message-ID: <3f96e9c3d06ed846b19b63cd9001cb0c66bd8a00.1694126893.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694126893.git.dsterba@suse.com>
References: <cover.1694126893.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The lock_owner is used for a rare corruption case and we haven't seen
any reports in years. Move it to the debugging section of eb.  To close
the holes also move log_index so the final layout looks like:

struct extent_buffer {
        u64                        start;                /*     0     8 */
        long unsigned int          len;                  /*     8     8 */
        long unsigned int          bflags;               /*    16     8 */
        struct btrfs_fs_info *     fs_info;              /*    24     8 */
        spinlock_t                 refs_lock;            /*    32     4 */
        atomic_t                   refs;                 /*    36     4 */
        int                        read_mirror;          /*    40     4 */
        s8                         log_index;            /*    44     1 */

        /* XXX 3 bytes hole, try to pack */

        struct callback_head       callback_head __attribute__((__aligned__(8))); /*    48    16 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct rw_semaphore        lock;                 /*    64    40 */
        struct page *              pages[16];            /*   104   128 */

        /* size: 232, cachelines: 4, members: 11 */
        /* sum members: 229, holes: 1, sum holes: 3 */
        /* forced alignments: 1, forced holes: 1, sum forced holes: 3 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));

This saves 8 bytes in total and still keeps the lock on a separate cacheline.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 32 +++++++++++++++++++++++---------
 fs/btrfs/extent_io.h   |  4 ++--
 fs/btrfs/locking.c     | 15 ++++++++++++---
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3e46bb4cc957..6f6838226fe7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4801,6 +4801,28 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+#ifdef CONFIG_BTRFS_DEBUG
+/*
+ * Extra safety check in case the extent tree is corrupted and extent allocator
+ * chooses to use a tree block which is already used and locked.
+ */
+static bool check_eb_lock_owner(const struct extent_buffer *eb)
+{
+	if (eb->lock_owner == current->pid) {
+		btrfs_err_rl(eb->fs_info,
+"tree block %llu owner %llu already locked by pid=%d, extent tree corruption detected",
+			     eb->start, btrfs_header_owner(eb), current->pid);
+		return true;
+	}
+	return false;
+}
+#else
+static bool check_eb_lock_owner(struct extent_buffer *eb)
+{
+	return false;
+}
+#endif
+
 static struct extent_buffer *
 btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      u64 bytenr, int level, u64 owner,
@@ -4814,15 +4836,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	if (IS_ERR(buf))
 		return buf;
 
-	/*
-	 * Extra safety check in case the extent tree is corrupted and extent
-	 * allocator chooses to use a tree block which is already used and
-	 * locked.
-	 */
-	if (buf->lock_owner == current->pid) {
-		btrfs_err_rl(fs_info,
-"tree block %llu owner %llu already locked by pid=%d, extent tree corruption detected",
-			buf->start, btrfs_header_owner(buf), current->pid);
+	if (check_eb_lock_owner(buf)) {
 		free_extent_buffer(buf);
 		return ERR_PTR(-EUCLEAN);
 	}
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 68368ba99321..2171057a4477 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -80,16 +80,16 @@ struct extent_buffer {
 	spinlock_t refs_lock;
 	atomic_t refs;
 	int read_mirror;
-	struct rcu_head rcu_head;
-	pid_t lock_owner;
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	s8 log_index;
+	struct rcu_head rcu_head;
 
 	struct rw_semaphore lock;
 
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
 #ifdef CONFIG_BTRFS_DEBUG
 	struct list_head leak_list;
+	pid_t lock_owner;
 #endif
 };
 
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index c3128cdf1177..6ac4fd8cc8dc 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -103,6 +103,15 @@ void btrfs_maybe_reset_lockdep_class(struct btrfs_root *root, struct extent_buff
 
 #endif
 
+#ifdef CONFIG_BTRFS_DEBUG
+static void btrfs_set_eb_lock_owner(struct extent_buffer *eb, pid_t owner)
+{
+	eb->lock_owner = owner;
+}
+#else
+static void btrfs_set_eb_lock_owner(struct extent_buffer *eb, pid_t owner) { }
+#endif
+
 /*
  * Extent buffer locking
  * =====================
@@ -165,7 +174,7 @@ int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 {
 	if (down_write_trylock(&eb->lock)) {
-		eb->lock_owner = current->pid;
+		btrfs_set_eb_lock_owner(eb, current->pid);
 		trace_btrfs_try_tree_write_lock(eb);
 		return 1;
 	}
@@ -198,7 +207,7 @@ void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
 		start_ns = ktime_get_ns();
 
 	down_write_nested(&eb->lock, nest);
-	eb->lock_owner = current->pid;
+	btrfs_set_eb_lock_owner(eb, current->pid);
 	trace_btrfs_tree_lock(eb, start_ns);
 }
 
@@ -213,7 +222,7 @@ void btrfs_tree_lock(struct extent_buffer *eb)
 void btrfs_tree_unlock(struct extent_buffer *eb)
 {
 	trace_btrfs_tree_unlock(eb);
-	eb->lock_owner = 0;
+	btrfs_set_eb_lock_owner(eb, 0);
 	up_write(&eb->lock);
 }
 
-- 
2.41.0

