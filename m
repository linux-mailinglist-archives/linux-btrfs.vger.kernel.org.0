Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5066A759D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 21:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCAUxT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 15:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCAUxS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 15:53:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B080E265B1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 12:53:17 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6A13A21AC1;
        Wed,  1 Mar 2023 20:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1677703996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b+XMOPPUWUcipTxpWEBcvn15I897uDrJ1m+S/mBTV5g=;
        b=uSrmHfGOYnHV0ftAmW6QeBwmy9Icti72qg9JPTFChp8Hs0JoQxrPlS32ZlWZnlpR59gA/8
        uqGgQYlwkf4lU9rFdQfgLegetB01zHXZR/N3mC4WfXzx2dRResDy2LqxJDehVbAwhqSUNr
        r1QeoPIN5rxT9ynI8GlK6Ml2MbeQDUw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5C79C2C141;
        Wed,  1 Mar 2023 20:53:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AB265DA7A3; Wed,  1 Mar 2023 21:47:17 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: locking: use atomic for DREW lock writers
Date:   Wed,  1 Mar 2023 21:47:08 +0100
Message-Id: <20230301204708.25710-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The DREW lock uses percpu variable to track lock counters and for that
it needs to allocate the structure. In btrfs_read_tree_root() or
btrfs_init_fs_root() this may add another error case or requires the
NOFS scope protection.

One way is to preallocate the structure as was suggested in
https://lore.kernel.org/linux-btrfs/20221214021125.28289-1-robbieko@synology.com/

We may avoid the allocation altogether if we don't use the percpu
variables but an atomic for the writer counter. This should not make any
difference, the DREW lock is used for truncate and NOCOW writes along
with other IO operations.

The percpu counter for writers has been there since the original commit
8257b2dc3c1a1057 "Btrfs: introduce btrfs_{start, end}_nocow_write() for
each subvolume". The reason could be to avoid hammering the same
cacheline from all the readers but then the writers do that anyway.

Signed-off-by: David Sterba <dsterba@suse.com>
---

 fs/btrfs/disk-io.c | 12 +-----------
 fs/btrfs/locking.c | 25 ++++++-------------------
 fs/btrfs/locking.h |  5 ++---
 3 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5d86daa5d685..956a6c23be10 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1341,17 +1341,8 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 {
 	int ret;
-	unsigned int nofs_flag;
 
-	/*
-	 * We might be called under a transaction (e.g. indirect backref
-	 * resolution) which could deadlock if it triggers memory reclaim
-	 */
-	nofs_flag = memalloc_nofs_save();
-	ret = btrfs_drew_lock_init(&root->snapshot_lock);
-	memalloc_nofs_restore(nofs_flag);
-	if (ret)
-		goto fail;
+	btrfs_drew_lock_init(&root->snapshot_lock);
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
 	    !btrfs_is_data_reloc_root(root)) {
@@ -2065,7 +2056,6 @@ void btrfs_put_root(struct btrfs_root *root)
 		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
 		if (root->anon_dev)
 			free_anon_bdev(root->anon_dev);
-		btrfs_drew_lock_destroy(&root->snapshot_lock);
 		free_root_extent_buffers(root);
 #ifdef CONFIG_BTRFS_DEBUG
 		spin_lock(&root->fs_info->fs_roots_radix_lock);
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 870528d87526..3a496b0d3d2b 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -325,24 +325,12 @@ struct extent_buffer *btrfs_try_read_lock_root_node(struct btrfs_root *root)
  * acquire the lock.
  */
 
-int btrfs_drew_lock_init(struct btrfs_drew_lock *lock)
+void btrfs_drew_lock_init(struct btrfs_drew_lock *lock)
 {
-	int ret;
-
-	ret = percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
-	if (ret)
-		return ret;
-
 	atomic_set(&lock->readers, 0);
+	atomic_set(&lock->writers, 0);
 	init_waitqueue_head(&lock->pending_readers);
 	init_waitqueue_head(&lock->pending_writers);
-
-	return 0;
-}
-
-void btrfs_drew_lock_destroy(struct btrfs_drew_lock *lock)
-{
-	percpu_counter_destroy(&lock->writers);
 }
 
 /* Return true if acquisition is successful, false otherwise */
@@ -351,10 +339,10 @@ bool btrfs_drew_try_write_lock(struct btrfs_drew_lock *lock)
 	if (atomic_read(&lock->readers))
 		return false;
 
-	percpu_counter_inc(&lock->writers);
+	atomic_inc(&lock->writers);
 
 	/* Ensure writers count is updated before we check for pending readers */
-	smp_mb();
+	smp_mb__after_atomic();
 	if (atomic_read(&lock->readers)) {
 		btrfs_drew_write_unlock(lock);
 		return false;
@@ -374,7 +362,7 @@ void btrfs_drew_write_lock(struct btrfs_drew_lock *lock)
 
 void btrfs_drew_write_unlock(struct btrfs_drew_lock *lock)
 {
-	percpu_counter_dec(&lock->writers);
+	atomic_dec(&lock->writers);
 	cond_wake_up(&lock->pending_readers);
 }
 
@@ -390,8 +378,7 @@ void btrfs_drew_read_lock(struct btrfs_drew_lock *lock)
 	 */
 	smp_mb__after_atomic();
 
-	wait_event(lock->pending_readers,
-		   percpu_counter_sum(&lock->writers) == 0);
+	wait_event(lock->pending_readers, atomic_read(&lock->writers) == 0);
 }
 
 void btrfs_drew_read_unlock(struct btrfs_drew_lock *lock)
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 11c2269b4b6f..edb9b4a0dba1 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -195,13 +195,12 @@ static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
 
 struct btrfs_drew_lock {
 	atomic_t readers;
-	struct percpu_counter writers;
+	atomic_t writers;
 	wait_queue_head_t pending_writers;
 	wait_queue_head_t pending_readers;
 };
 
-int btrfs_drew_lock_init(struct btrfs_drew_lock *lock);
-void btrfs_drew_lock_destroy(struct btrfs_drew_lock *lock);
+void btrfs_drew_lock_init(struct btrfs_drew_lock *lock);
 void btrfs_drew_write_lock(struct btrfs_drew_lock *lock);
 bool btrfs_drew_try_write_lock(struct btrfs_drew_lock *lock);
 void btrfs_drew_write_unlock(struct btrfs_drew_lock *lock);
-- 
2.37.3

