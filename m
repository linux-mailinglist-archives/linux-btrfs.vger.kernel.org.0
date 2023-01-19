Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA53674C85
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 06:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjATFgz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 00:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjATFgh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6CB6A31F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 21:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7494AB8271D
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A40C433D2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157190;
        bh=pBgcnaEKimQGquxSVWRD6yR4nP+3nu0sU5mfw3OsVMQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=u0c3ut2JHxXEZZkYW4oGZievyiHFVxoV2OpOJxlk+hZJi6lhv48FLfMl+IP4Nmi24
         Jh5A9leMkRaDYikHBhJyiLmVUU9p/UZe/Bt0oHoKU5oUtcYHR90AJgf1ZOCOOpEzUF
         qED+1Npun1fXCmDcvXv9TgRUB2z+SyFC44DfQ24ejupVZhefnf7/QBREhhCD2GF631
         BZoq2ifamh+XNn8i3ilje+WrmNMz+qIbKMly1uSViJ6sA9n/hRrXdM7vWku3akM/U+
         EjKFTn5Ja2suaaLO+b3E9g3WkWILuYnynm08fT8DI6mB4sa1EEj9yIUCI0pn7ayc4g
         NoNALOg201q5Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 18/18] btrfs: send: cache utimes operations for directories if possible
Date:   Thu, 19 Jan 2023 19:39:30 +0000
Message-Id: <4483b872a3d205aa9db83be74ae7f7730b32380d.1674157020.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1674157020.git.fdmanana@suse.com>
References: <cover.1674157020.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Whenever we add or remove an entry to a directory, we issue an utimes
command for the directory. If we add 1000 entries to a directory (create
1000 files under it or move 1000 files to it), then we issue the same
utimes command 1000 times, which increases the send stream size, results
in more pipe IO, one search in the send b+tree, allocating one path for
the search, etc, as well as making the receiver do a system call for each
duplicated utimes command.

We also issue an utimes command when we create a new directory, but later
we might add entries to it corresponding to inodes with an higher inode
number, so it's pointless to issue the utimes command before we create
the last inode under the directory.

So use a lru cache to track directories for which we must send a utimes
command. When we need to remove an entry from the cache, we issue the
utimes command for the respective directory. When finishing the send
operation, we go over each cache element and issue the respective utimes
command. Finally the caching is entirely optional, just a performance
optimization, meaning that if we fail to cache (due to memory allocation
failure), we issue the utimes command right away, that is, we fallback
to the previous, unoptimized, behaviour.

This patch belongs to a patchset comprised of the following patches:

  btrfs: send: directly return from did_overwrite_ref() and simplify it
  btrfs: send: avoid unnecessary generation search at did_overwrite_ref()
  btrfs: send: directly return from will_overwrite_ref() and simplify it
  btrfs: send: avoid extra b+tree searches when checking reference overrides
  btrfs: send: remove send_progress argument from can_rmdir()
  btrfs: send: avoid duplicated orphan dir allocation and initialization
  btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
  btrfs: send: reduce searches on parent root when checking if dir can be removed
  btrfs: send: iterate waiting dir move rbtree only once when processing refs
  btrfs: send: initialize all the red black trees earlier
  btrfs: send: genericize the backref cache to allow it to be reused
  btrfs: adapt lru cache to allow for 64 bits keys on 32 bits systems
  btrfs: send: cache information about created directories
  btrfs: allow a generation number to be associated with lru cache entries
  btrfs: add an api to delete a specific entry from the lru cache
  btrfs: send: use the lru cache to implement the name cache
  btrfs: send: update size of roots array for backref cache entries
  btrfs: send: cache utimes operations for directories if possible

The following test was run before and after applying the whole patchset,
and on a non-debug kernel (Debian's default kernel config):

   #!/bin/bash

   MNT=/mnt/sdi
   DEV=/dev/sdi

   mkfs.btrfs -f $DEV > /dev/null
   mount $DEV $MNT

   mkdir $MNT/A
   for ((i = 1; i <= 20000; i++)); do
       echo -n > $MNT/A/file_$i
   done

   btrfs subvolume snapshot -r $MNT $MNT/snap1

   mkdir $MNT/B
   for ((i = 20000; i <= 40000; i++)); do
       echo -n > $MNT/B/file_$i
   done

   mv $MNT/A/file_* $MNT/B/

   btrfs subvolume snapshot -r $MNT $MNT/snap2

   start=$(date +%s%N)
   btrfs send -p $MNT/snap1 $MNT/snap2 > /dev/null
   end=$(date +%s%N)

   dur=$(( (end - start) / 1000000 ))
   echo "Incremental send took $dur milliseconds"

   umount $MNT

Before the whole patchset: 18408 milliseconds
After the whole patchset:   1942 milliseconds  (9.5x speedup)

Using 60000 files instead of 40000:

Before the whole patchset: 39764 milliseconds
After the whole patchset:   3076 milliseconds  (12.9x speedup)

Using 20000 files instead of 40000:

Before the whole patchset:  5072 milliseconds
After the whole patchset:    916 milliseconds  (5.5x speedup)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/lru_cache.h | 15 ++++++++
 fs/btrfs/send.c      | 81 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/lru_cache.h b/fs/btrfs/lru_cache.h
index 57e5bdc57e6d..9f3101cc89d5 100644
--- a/fs/btrfs/lru_cache.h
+++ b/fs/btrfs/lru_cache.h
@@ -47,11 +47,26 @@ struct btrfs_lru_cache {
 	unsigned int max_size;
 };
 
+#define btrfs_lru_cache_for_each_entry_safe(cache, entry, tmp) \
+	list_for_each_entry_safe_reverse((entry), (tmp), &(cache)->lru_list, lru_list)
+
 static inline unsigned int btrfs_lru_cache_size(const struct btrfs_lru_cache *cache)
 {
 	return cache->size;
 }
 
+static inline bool btrfs_lru_cache_is_full(const struct btrfs_lru_cache *cache)
+{
+	return cache->size >= cache->max_size;
+}
+
+static inline struct btrfs_lru_cache_entry *btrfs_lru_cache_lru_entry(
+					      struct btrfs_lru_cache *cache)
+{
+	return list_first_entry_or_null(&cache->lru_list,
+					struct btrfs_lru_cache_entry, lru_list);
+}
+
 void btrfs_lru_cache_init(struct btrfs_lru_cache *cache, unsigned int max_size);
 struct btrfs_lru_cache_entry *btrfs_lru_cache_lookup(struct btrfs_lru_cache *cache,
 						     u64 key, u64 gen);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ae2d462f647e..a271b39c1445 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -125,6 +125,14 @@ static_assert(offsetof(struct backref_cache_entry, entry) == 0);
  */
 #define SEND_MAX_DIR_CREATED_CACHE_SIZE 64
 
+/*
+ * Max number of entries in the cache that stores directories that were already
+ * created. The cache uses raw struct btrfs_lru_cache_entry entries, so it uses
+ * at most 4096 bytes - sizeof(struct btrfs_lru_cache_entry) is 48 bytes, but
+ * the kmalloc-64 slab is used, so we get 4096 bytes (64 bytes * 64).
+ */
+#define SEND_MAX_DIR_UTIMES_CACHE_SIZE 64
+
 struct send_ctx {
 	struct file *send_filp;
 	loff_t send_off;
@@ -296,6 +304,7 @@ struct send_ctx {
 	u64 backref_cache_last_reloc_trans;
 
 	struct btrfs_lru_cache dir_created_cache;
+	struct btrfs_lru_cache dir_utimes_cache;
 };
 
 struct pending_dir_move {
@@ -2747,6 +2756,46 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	return ret;
 }
 
+static int cache_dir_utimes(struct send_ctx *sctx, u64 dir, u64 gen)
+{
+	struct btrfs_lru_cache_entry *entry;
+	int ret;
+
+	entry = btrfs_lru_cache_lookup(&sctx->dir_utimes_cache, dir, gen);
+	if (entry != NULL)
+		return 0;
+
+	if (btrfs_lru_cache_is_full(&sctx->dir_utimes_cache)) {
+		struct btrfs_lru_cache_entry *lru;
+
+		lru = btrfs_lru_cache_lru_entry(&sctx->dir_utimes_cache);
+		ASSERT(lru != NULL);
+
+		ret = send_utimes(sctx, lru->key, lru->gen);
+		if (ret)
+			return ret;
+
+		btrfs_lru_cache_remove(&sctx->dir_utimes_cache, lru);
+	}
+
+	/* Caching is optional, don't fail if we can't allocate memory. */
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return send_utimes(sctx, dir, gen);
+
+	entry->key = dir;
+	entry->gen = gen;
+
+	ret = btrfs_lru_cache_store(&sctx->dir_utimes_cache, entry, GFP_KERNEL);
+	ASSERT(ret != -EEXIST);
+	if (ret) {
+		kfree(entry);
+		return send_utimes(sctx, dir, gen);
+	}
+
+	return 0;
+}
+
 /*
  * Sends a BTRFS_SEND_C_MKXXX or SYMLINK command to user space. We don't have
  * a valid path yet because we did not process the refs yet. So, the inode
@@ -3540,7 +3589,7 @@ static int apply_dir_move(struct send_ctx *sctx, struct pending_dir_move *pm)
 	}
 
 finish:
-	ret = send_utimes(sctx, pm->ino, pm->gen);
+	ret = cache_dir_utimes(sctx, pm->ino, pm->gen);
 	if (ret < 0)
 		goto out;
 
@@ -3560,7 +3609,7 @@ static int apply_dir_move(struct send_ctx *sctx, struct pending_dir_move *pm)
 		if (ret < 0)
 			goto out;
 
-		ret = send_utimes(sctx, cur->dir, cur->dir_gen);
+		ret = cache_dir_utimes(sctx, cur->dir, cur->dir_gen);
 		if (ret < 0)
 			goto out;
 	}
@@ -4507,8 +4556,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 
 		if (ret == inode_state_did_create ||
 		    ret == inode_state_no_change) {
-			/* TODO delayed utimes */
-			ret = send_utimes(sctx, cur->dir, cur->dir_gen);
+			ret = cache_dir_utimes(sctx, cur->dir, cur->dir_gen);
 			if (ret < 0)
 				goto out;
 		} else if (ret == inode_state_did_delete &&
@@ -6690,7 +6738,18 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 		 * it's moved/renamed, therefore we don't need to do it here.
 		 */
 		sctx->send_progress = sctx->cur_ino + 1;
-		ret = send_utimes(sctx, sctx->cur_ino, sctx->cur_inode_gen);
+
+		/*
+		 * If the current inode is a non-empty directory, delay issuing
+		 * the utimes command for it, as it's very likely we have inodes
+		 * with an higher number inside it. We want to issue the utimes
+		 * command only after adding all dentries to it.
+		 */
+		if (S_ISDIR(sctx->cur_inode_mode) && sctx->cur_inode_size > 0)
+			ret = cache_dir_utimes(sctx, sctx->cur_ino, sctx->cur_inode_gen);
+		else
+			ret = send_utimes(sctx, sctx->cur_ino, sctx->cur_inode_gen);
+
 		if (ret < 0)
 			goto out;
 	}
@@ -7980,6 +8039,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	int clone_sources_to_rollback = 0;
 	size_t alloc_size;
 	int sort_clone_roots = 0;
+	struct btrfs_lru_cache_entry *entry;
+	struct btrfs_lru_cache_entry *tmp;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -8035,6 +8096,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	btrfs_lru_cache_init(&sctx->backref_cache, SEND_MAX_BACKREF_CACHE_SIZE);
 	btrfs_lru_cache_init(&sctx->dir_created_cache,
 			     SEND_MAX_DIR_CREATED_CACHE_SIZE);
+	btrfs_lru_cache_init(&sctx->dir_utimes_cache,
+			     SEND_MAX_DIR_UTIMES_CACHE_SIZE);
 
 	sctx->pending_dir_moves = RB_ROOT;
 	sctx->waiting_dir_moves = RB_ROOT;
@@ -8215,6 +8278,13 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	if (ret < 0)
 		goto out;
 
+	btrfs_lru_cache_for_each_entry_safe(&sctx->dir_utimes_cache, entry, tmp) {
+		ret = send_utimes(sctx, entry->key, entry->gen);
+		if (ret < 0)
+			goto out;
+		btrfs_lru_cache_remove(&sctx->dir_utimes_cache, entry);
+	}
+
 	if (!(sctx->flags & BTRFS_SEND_FLAG_OMIT_END_CMD)) {
 		ret = begin_cmd(sctx, BTRFS_SEND_C_END);
 		if (ret < 0)
@@ -8299,6 +8369,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 		btrfs_lru_cache_clear(&sctx->name_cache);
 		btrfs_lru_cache_clear(&sctx->backref_cache);
 		btrfs_lru_cache_clear(&sctx->dir_created_cache);
+		btrfs_lru_cache_clear(&sctx->dir_utimes_cache);
 
 		kfree(sctx);
 	}
-- 
2.35.1

