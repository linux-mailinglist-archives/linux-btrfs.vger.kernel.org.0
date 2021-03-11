Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7597F3375C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 15:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbhCKOb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 09:31:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233671AbhCKObZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 09:31:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50D7764FE8;
        Thu, 11 Mar 2021 14:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615473085;
        bh=y1RZTQszhrd9706ZBPIDfFMuO+2g/xMo9Agaer091Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yn/ZoC3SkQUsFlyoDKWK3Kmpy6ZQIpfHoaGIfp5L2nty3yks++ON9tSMFhytGdLxv
         40/+c3Paaod4lrRg/TdKKs+HV5iiW6Oj1jyb2DSmegQt6BiNZD5rFlyXSXkLdA+LLO
         hYhP7BiD4oFhaMfFFKMw6d8Thhn0hMoaz/LSdpQEXsi/uj+8zlf4VgkTIlVGZlyb7Y
         5fZSxuZ9PDtcmr5bmtIjKoz/ObFwMdcodj6LG83n6HkfOj4jGpZk4LsKcOvMvn+V+a
         jJDFevBAXr/dqXOB0KEEH8K3GCxJvbxc41VeEephJ+ljsO/rjxnLucdYiFLBuZtL83
         Z4dhr62Rg+mGg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     ce3g8jdj@umail.furryterror.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/9] btrfs: always pin deleted leaves when there are active tree mod log users
Date:   Thu, 11 Mar 2021 14:31:06 +0000
Message-Id: <d9d8cda5b3ab2a262d4d66e9fe8abd75912f252f.1615472583.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1615472583.git.fdmanana@suse.com>
References: <cover.1615472583.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When freeing a tree block we may end up adding its extent back to the
free space cache/tree, as long as there are no more references for it,
it was created in the current transaction and writeback for it never
happened. This is generally fine, however when we have tree mod log
operations it can result in inconsistent versions of a btree after
unwinding extent buffers with the recorded tree mod log operations.

This is because:

* We only log operations for nodes (adding and removing key/pointers),
  for leaves we don't do anything;

* This means that we can log a MOD_LOG_KEY_REMOVE_WHILE_FREEING operation
  for a node that points to a leaf that was deleted;

* Before we apply the logged operation to unwind a node, we can have
  that leaf's extent allocated again, either as a node or as a leaf, and
  possibly for another btree. This is possible if the leaf was created in
  the current transaction and writeback for it never started, in which
  case btrfs_free_tree_block() returns its extent back to the free space
  cache/tree;

* Then, before applying the tree mod log operation, some task allocates
  the metadata extent just freed before, and uses it either as a leaf or
  as a node for some btree (can be the same or another one, it does not
  matter);

* After applying the MOD_LOG_KEY_REMOVE_WHILE_FREEING operation we now
  get the target node with an item pointing to the metadata extent that
  now has content different from what it had before the leaf was deleted.
  It might now belong to a different btree and be a node and not a leaf
  anymore.

  As a consequence, the results of searches after the unwinding can be
  unpredictable and produce unexpected results.

So make sure we pin extent buffers corresponding to leaves when there
are tree mod log users.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5e228d6ad63f..2482b26b1971 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3310,6 +3310,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 	if (last_ref && btrfs_header_generation(buf) == trans->transid) {
 		struct btrfs_block_group *cache;
+		bool must_pin = false;
 
 		if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
 			ret = check_ref_cleanup(trans, buf->start);
@@ -3327,7 +3328,27 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
-		if (btrfs_is_zoned(fs_info)) {
+		/*
+		 * If this is a leaf and there are tree mod log users, we may
+		 * have recorded mod log operations that point to this leaf.
+		 * So we must make sure no one reuses this leaf's extent before
+		 * mod log operations are applied to a node, otherwise after
+		 * rewinding a node using the mod log operations we get an
+		 * inconsistent btree, as the leaf's extent may now be used as
+		 * a node or leaf for another different btree.
+		 * We are safe from races here because at this point no other
+		 * node or root points to this extent buffer, so if after this
+		 * check a new tree mod log user joins, it will not be able to
+		 * find a node pointing to this leaf and record operations that
+		 * point to this leaf.
+		 */
+		if (btrfs_header_level(buf) == 0) {
+			read_lock(&fs_info->tree_mod_log_lock);
+			must_pin = !list_empty(&fs_info->tree_mod_seq_list);
+			read_unlock(&fs_info->tree_mod_log_lock);
+		}
+
+		if (must_pin || btrfs_is_zoned(fs_info)) {
 			btrfs_redirty_list_add(trans->transaction, buf);
 			pin_down_extent(trans, cache, buf->start, buf->len, 1);
 			btrfs_put_block_group(cache);
-- 
2.28.0

