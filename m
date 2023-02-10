Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA38C691F22
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 13:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjBJM3z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 07:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjBJM3y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 07:29:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4E71039
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 04:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87B6461D57
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 12:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7437BC433EF
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676032192;
        bh=aj0LTC6EgGPzQdh6wzVn+DelcOfjrg+EtyP4iYkSeAQ=;
        h=From:To:Subject:Date:From;
        b=uXPDzGTcTNHrETX0VTAOvgtSWjNM8YszbjJ2YMZawDYVw3kDt5GHDNLq7t5aG542g
         NoTzuAhI5kWbzT8+l0HKoySMM0gCxPO8AK952MZVV0Env9wYj4QaQ5iOlOzSZYqXPF
         0hI3QuWWByz4ZQ8coDy1Z0XXSnmviESZKOcrTu4YyvZmheyNkyaAiqzMPRP2YrRaeT
         jpv8OR8bvVk4IUtxS/IOf0cxqvFgMw+kiyPh8jeYJn7wyy7aRUkK9pj/b4n9wLIwpA
         ZFmx7pbGAoRJmmPyY2lTAQdmKXPr9MiJlLoSsNmzKJEx6a6KgUw6mOTR9QZfRq9E/x
         0hAe4H7ZMzEKQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: fix emission of invalid paths when issuing utimes commands
Date:   Fri, 10 Feb 2023 12:29:49 +0000
Message-Id: <1a3cca74c6033ba5312e68bda061eac3019848d4.1676031737.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

During an incremental send, when processing the new reference for a
directory that was renamed/moved to another directory, we need to cache
an utimes operation for the old parent directory. However if the utimes
cache is full, we remove the LRU entry and issue a utimes command for the
inode associated with that entry. It may happen that the full path for
the inode that the entry refers to, contains the directory that we are
processing and have just renamed, in which case we generate a path for
the utimes operation that contains the old name/location of the directory,
resulting in the receiver to fail.

So fix this by never removing an entry from the utimes cache when it's
full and we are adding a new entry to it. Instead trim the cache only
after finishing processing an inode, after the current send progress is
updated.

The issue was introduced by the following patch:

   "btrfs: send: cache utimes operations for directories if possible"

which is not yet in Linus' tree, and it could be sporadically triggered
by test case btrfs/252 from fstests.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/lru_cache.c |  4 +++-
 fs/btrfs/send.c      | 53 +++++++++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/lru_cache.c b/fs/btrfs/lru_cache.c
index 38722dc07676..0fe0ae54ac67 100644
--- a/fs/btrfs/lru_cache.c
+++ b/fs/btrfs/lru_cache.c
@@ -9,6 +9,8 @@
  *
  * @cache:      The cache.
  * @max_size:   Maximum size (number of entries) for the cache.
+ *              Use 0 for unlimited size, it's the user's responsability to
+ *              trim the cache in that case.
  */
 void btrfs_lru_cache_init(struct btrfs_lru_cache *cache, unsigned int max_size)
 {
@@ -129,7 +131,7 @@ int btrfs_lru_cache_store(struct btrfs_lru_cache *cache,
 		return ret;
 	}
 
-	if (cache->size == cache->max_size) {
+	if (cache->max_size > 0 && cache->size == cache->max_size) {
 		struct btrfs_lru_cache_entry *lru_entry;
 
 		lru_entry = list_first_entry(&cache->lru_list,
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c3146ce84156..f936c203f386 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2756,6 +2756,16 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	return ret;
 }
 
+/*
+ * If the cache is full, we can't remove entries from it and do a call to
+ * send_utimes() for each respective inode, because we might be finishing
+ * processing an inode that is a directory and it just got renamed, and existing
+ * entries in the cache may refer to inodes that have the directory in their
+ * full path - in which case we would generate outdated paths (pre-rename)
+ * for the inodes that the cache entries point to. Instead of prunning the
+ * cache when inserting, do it after we finish processing each inode at
+ * finish_inode_if_needed().
+ */
 static int cache_dir_utimes(struct send_ctx *sctx, u64 dir, u64 gen)
 {
 	struct btrfs_lru_cache_entry *entry;
@@ -2765,19 +2775,6 @@ static int cache_dir_utimes(struct send_ctx *sctx, u64 dir, u64 gen)
 	if (entry != NULL)
 		return 0;
 
-	if (btrfs_lru_cache_is_full(&sctx->dir_utimes_cache)) {
-		struct btrfs_lru_cache_entry *lru;
-
-		lru = btrfs_lru_cache_lru_entry(&sctx->dir_utimes_cache);
-		ASSERT(lru != NULL);
-
-		ret = send_utimes(sctx, lru->key, lru->gen);
-		if (ret)
-			return ret;
-
-		btrfs_lru_cache_remove(&sctx->dir_utimes_cache, lru);
-	}
-
 	/* Caching is optional, don't fail if we can't allocate memory. */
 	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
@@ -2796,6 +2793,26 @@ static int cache_dir_utimes(struct send_ctx *sctx, u64 dir, u64 gen)
 	return 0;
 }
 
+static int trim_dir_utimes_cache(struct send_ctx *sctx)
+{
+	while (btrfs_lru_cache_size(&sctx->dir_utimes_cache) >
+	       SEND_MAX_DIR_UTIMES_CACHE_SIZE) {
+		struct btrfs_lru_cache_entry *lru;
+		int ret;
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
+	return 0;
+}
+
 /*
  * Sends a BTRFS_SEND_C_MKXXX or SYMLINK command to user space. We don't have
  * a valid path yet because we did not process the refs yet. So, the inode
@@ -6755,6 +6772,9 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 	}
 
 out:
+	if (!ret)
+		ret = trim_dir_utimes_cache(sctx);
+
 	return ret;
 }
 
@@ -8096,8 +8116,11 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	btrfs_lru_cache_init(&sctx->backref_cache, SEND_MAX_BACKREF_CACHE_SIZE);
 	btrfs_lru_cache_init(&sctx->dir_created_cache,
 			     SEND_MAX_DIR_CREATED_CACHE_SIZE);
-	btrfs_lru_cache_init(&sctx->dir_utimes_cache,
-			     SEND_MAX_DIR_UTIMES_CACHE_SIZE);
+	/*
+	 * This cache is periodically trimmed to a fixed size elsewhere, see
+	 * cache_dir_utimes() and trim_dir_utimes_cache().
+	 */
+	btrfs_lru_cache_init(&sctx->dir_utimes_cache, 0);
 
 	sctx->pending_dir_moves = RB_ROOT;
 	sctx->waiting_dir_moves = RB_ROOT;
-- 
2.35.1

