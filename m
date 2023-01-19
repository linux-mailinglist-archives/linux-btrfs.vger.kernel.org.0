Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5787674C9E
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 06:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjATFhe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 00:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjATFgt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696B560C99
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 21:33:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 663EAB82715
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3980C433F0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157177;
        bh=JZDTPPOKQWO3LkI1oPetOFxqhj5/jCkznUSbsY2PgEQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CR51n3+zczHPTRY+co0J+8CsPxgDFq0nUXN/fs8rFq+4uWn6Rqzc1Du+o0hzMiLo4
         pCN49Wf3QFMp9PmZaYDNKEi4db2y2frC5DduZuB//HMiW8PGf8Ryt9A6tGpeFvVjs8
         TQfs0omPgasbyU5WUBosGvOIb/KwcBbULjdlKMejQ9BPOnj8gINoKs9aQmUSF/Honr
         Nz6Mgg62kqVGVx5Tjkmwgmbn6Tlx6OwN/v0BG90mh2WYCHImtWD0NNckVW+LT/IEFa
         sv4sbGxEVaImEdH/m/EE1ec8ZmlAmrn08e7KG80taYXe0LO8DvmujtacYDRPHwtAKE
         dww1/3GpZDRxA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 03/18] btrfs: send: directly return from will_overwrite_ref() and simplify it
Date:   Thu, 19 Jan 2023 19:39:15 +0000
Message-Id: <1747b050e9ac81e0ddc845cffdb05c27c733aa18.1674157020.git.fdmanana@suse.com>
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

There are no resources to release before will_overwrite_ref() returns, so
we don't really need the 'out' label and jumping to it when conditions are
met - we can directly return and get rid of the label and jumps. Also we
can deal with -ENOENT and other errors in a single if-else logic, as it's
more straightforward.

This helps the next patch in the series to be more simple as well.

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
 fs/btrfs/send.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 23060eec30de..9be3d7db85d6 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2119,17 +2119,17 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 			      const char *name, int name_len,
 			      u64 *who_ino, u64 *who_gen, u64 *who_mode)
 {
-	int ret = 0;
+	int ret;
 	u64 gen;
 	u64 other_inode = 0;
 	struct btrfs_inode_info info;
 
 	if (!sctx->parent_root)
-		goto out;
+		return 0;
 
 	ret = is_inode_existent(sctx, dir, dir_gen);
 	if (ret <= 0)
-		goto out;
+		return 0;
 
 	/*
 	 * If we have a parent root we need to verify that the parent dir was
@@ -2138,24 +2138,21 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	 */
 	if (sctx->parent_root && dir != BTRFS_FIRST_FREE_OBJECTID) {
 		ret = get_inode_gen(sctx->parent_root, dir, &gen);
-		if (ret < 0 && ret != -ENOENT)
-			goto out;
-		if (ret) {
-			ret = 0;
-			goto out;
-		}
+		if (ret == -ENOENT)
+			return 0;
+		else if (ret < 0)
+			return ret;
+
 		if (gen != dir_gen)
-			goto out;
+			return 0;
 	}
 
 	ret = lookup_dir_item_inode(sctx->parent_root, dir, name, name_len,
 				    &other_inode);
-	if (ret < 0 && ret != -ENOENT)
-		goto out;
-	if (ret) {
-		ret = 0;
-		goto out;
-	}
+	if (ret == -ENOENT)
+		return 0;
+	else if (ret < 0)
+		return ret;
 
 	/*
 	 * Check if the overwritten ref was already processed. If yes, the ref
@@ -2166,18 +2163,15 @@ static int will_overwrite_ref(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 	    is_waiting_for_move(sctx, other_inode)) {
 		ret = get_inode_info(sctx->parent_root, other_inode, &info);
 		if (ret < 0)
-			goto out;
+			return ret;
 
-		ret = 1;
 		*who_ino = other_inode;
 		*who_gen = info.gen;
 		*who_mode = info.mode;
-	} else {
-		ret = 0;
+		return 1;
 	}
 
-out:
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.35.1

