Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CAA6742FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 20:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjASTkL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 14:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjASTjr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 14:39:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3949B139
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 11:39:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6490061D1B
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF6BC433F0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157185;
        bh=k3hDlSBp4vxCJoByeGhmpZ01i26TFdzLmWBekXsIG/Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PFhk9EVAo61Es6CvObaKEowH11sGyKgJ8UwxpJMvTzOze80OYs8cakdi7hNr93HQ7
         1SahVwn4/lhq9bmJRb7vDQO0YtpWZ17XaJHq7QMetNBtOCuKc/bykq+7x8CRRRqyj3
         mGKyza+QY+MC1UvQUk1Q+bN4O+drMcveisgDp6M+Eiwbjtzf+se4+icmEYAVw4+tnx
         Pg5IhqpAtgYItku6plnkgD/SyR2vRFO4oYU3LTu/JFbfq8bO9JhZF419cRuEp09tcM
         HImDwPDB84BSHNideF1dC5tYdAuZrQ9B0RRRvUwUDGjRlwL+LbHAO8tjh6q6m3VMgA
         0veY23Qj52mjA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 13/18] btrfs: send: cache information about created directories
Date:   Thu, 19 Jan 2023 19:39:25 +0000
Message-Id: <546be4877df604b6e64b18357ea694a491126621.1674157020.git.fdmanana@suse.com>
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

During an incremental send, when processing the a reference for an inode
we need to check if the directory where the new reference is located was
already created before creating the new reference. This check, which is
done by the helper did_create_dir(), can be expensive if the directory
has many entries, since it consists in seaching the send root's b+tree
and visiting every single dir index key until we either find one which
points to an inode with a number smaller than the current inode's number
or until we visited all index keys. So it doesn't scale well for very
large directories.

So improve on this by caching created directories using a lru cache, and
limiting its size to 64 entries, which results in using at most 4096
bytes of memory. The caching is optinal, if we fail to allocate memory,
we just proceed as before and use the existing slower path.

This patch is part of a larger patchset and the changelog of the last
patch in the series contains a sample performance test and results.
The patches that comprise the patchset are the following:

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

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index b31af939bea8..bc232eb60e68 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -117,6 +117,14 @@ struct backref_cache_entry {
 /* See the comment at lru_cache.h about struct btrfs_lru_cache_entry. */
 static_assert(offsetof(struct backref_cache_entry, entry) == 0);
 
+/*
+ * Max number of entries in the cache that stores directories that were already
+ * created. The cache uses raw struct btrfs_lru_cache_entry entries, so it uses
+ * at most 4096 bytes - sizeof(struct btrfs_lru_cache_entry) is 40 bytes, but
+ * the kmalloc-64 slab is used, so we get 4096 bytes (64 bytes * 64).
+ */
+#define SEND_MAX_DIR_CREATED_CACHE_SIZE 64
+
 struct send_ctx {
 	struct file *send_filp;
 	loff_t send_off;
@@ -288,6 +296,8 @@ struct send_ctx {
 
 	struct btrfs_lru_cache backref_cache;
 	u64 backref_cache_last_reloc_trans;
+
+	struct btrfs_lru_cache dir_created_cache;
 };
 
 struct pending_dir_move {
@@ -2936,6 +2946,22 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
 	return ret;
 }
 
+static void cache_dir_created(struct send_ctx *sctx, u64 dir)
+{
+	struct btrfs_lru_cache_entry *entry;
+	int ret;
+
+	/* Caching is optional, ignore any failures. */
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return;
+
+	entry->key = dir;
+	ret = btrfs_lru_cache_store(&sctx->dir_created_cache, entry, GFP_KERNEL);
+	if (ret < 0)
+		kfree(entry);
+}
+
 /*
  * We need some special handling for inodes that get processed before the parent
  * directory got created. See process_recorded_refs for details.
@@ -2951,6 +2977,9 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 	struct btrfs_key di_key;
 	struct btrfs_dir_item *di;
 
+	if (btrfs_lru_cache_lookup(&sctx->dir_created_cache, dir))
+		return 1;
+
 	path = alloc_path_for_send();
 	if (!path)
 		return -ENOMEM;
@@ -2974,6 +3003,7 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 		if (di_key.type != BTRFS_ROOT_ITEM_KEY &&
 		    di_key.objectid < sctx->send_progress) {
 			ret = 1;
+			cache_dir_created(sctx, dir);
 			break;
 		}
 	}
@@ -3003,7 +3033,12 @@ static int send_create_inode_if_needed(struct send_ctx *sctx)
 			return 0;
 	}
 
-	return send_create_inode(sctx, sctx->cur_ino);
+	ret = send_create_inode(sctx, sctx->cur_ino);
+
+	if (ret == 0 && S_ISDIR(sctx->cur_inode_mode))
+		cache_dir_created(sctx, sctx->cur_ino);
+
+	return ret;
 }
 
 struct recorded_ref {
@@ -4401,6 +4436,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				ret = send_create_inode(sctx, cur->dir);
 				if (ret < 0)
 					goto out;
+				cache_dir_created(sctx, cur->dir);
 			}
 		}
 
@@ -8109,6 +8145,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	INIT_LIST_HEAD(&sctx->name_cache_list);
 
 	btrfs_lru_cache_init(&sctx->backref_cache, SEND_MAX_BACKREF_CACHE_SIZE);
+	btrfs_lru_cache_init(&sctx->dir_created_cache,
+			     SEND_MAX_DIR_CREATED_CACHE_SIZE);
 
 	sctx->pending_dir_moves = RB_ROOT;
 	sctx->waiting_dir_moves = RB_ROOT;
@@ -8373,6 +8411,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 		close_current_inode(sctx);
 
 		btrfs_lru_cache_clear(&sctx->backref_cache);
+		btrfs_lru_cache_clear(&sctx->dir_created_cache);
 
 		kfree(sctx);
 	}
-- 
2.35.1

