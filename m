Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C608246617
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Aug 2020 14:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgHQMMv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Aug 2020 08:12:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:57132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728163AbgHQMMo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Aug 2020 08:12:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5C89AEDA;
        Mon, 17 Aug 2020 12:13:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7F98ADA6EF; Mon, 17 Aug 2020 14:11:39 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: send: remove indirect callback parameter for changed_cb
Date:   Mon, 17 Aug 2020 14:11:39 +0200
Message-Id: <3b69b646fdc01f9ad04be59178efcd535ed34da4.1597666167.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1597666167.git.dsterba@suse.com>
References: <cover.1597666167.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a custom callback passed to btrfs_compare_trees which happens to
be named exactly same as the existing function implementing it. This is
confusing and the indirection is not necessary for our needs. Compiler
is clever enough to call it directly so there's effectively no change.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d9813a5b075a..7c7c09fc65e8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -278,11 +278,6 @@ enum btrfs_compare_tree_result {
 	BTRFS_COMPARE_TREE_CHANGED,
 	BTRFS_COMPARE_TREE_SAME,
 };
-typedef int (*btrfs_changed_cb_t)(struct btrfs_path *left_path,
-				  struct btrfs_path *right_path,
-				  struct btrfs_key *key,
-				  enum btrfs_compare_tree_result result,
-				  void *ctx);
 
 __cold
 static void inconsistent_snapshot_error(struct send_ctx *sctx,
@@ -6692,8 +6687,7 @@ static int tree_compare_item(struct btrfs_path *left_path,
  * If it detects a change, it aborts immediately.
  */
 static int btrfs_compare_trees(struct btrfs_root *left_root,
-			struct btrfs_root *right_root,
-			btrfs_changed_cb_t changed_cb, void *ctx)
+			struct btrfs_root *right_root, void *ctx)
 {
 	struct btrfs_fs_info *fs_info = left_root->fs_info;
 	int ret;
@@ -6960,8 +6954,7 @@ static int send_subvol(struct send_ctx *sctx)
 		goto out;
 
 	if (sctx->parent_root) {
-		ret = btrfs_compare_trees(sctx->send_root, sctx->parent_root,
-				changed_cb, sctx);
+		ret = btrfs_compare_trees(sctx->send_root, sctx->parent_root, sctx);
 		if (ret < 0)
 			goto out;
 		ret = finish_inode_if_needed(sctx, 1);
-- 
2.25.0

