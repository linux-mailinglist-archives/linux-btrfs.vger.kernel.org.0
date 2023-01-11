Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C62665A5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238493AbjAKLjb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238228AbjAKLjE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871CB65B7
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38850B81BAE
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4C5C433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436988;
        bh=IZn6Ia3g/yg2V15zZbqJ5NKqtnKzpAhV4fNWgDDJTp0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aa6lnvZErdCQd9aLBzY1T0j1N/gVhvn3uI4XJLTDIoX4jA69t8MM0rOlhm/s0dtHv
         e1KiiDal0UvLERziZ0zpVZbeuO0K8yjqao7Rdf4fI8ouEMOdOZTfntZOUC3QrNuhwT
         N5AVXsTkNbBpH6m9cXlLuMhSEXCiPpvs7/hikuFJ/psm1OUbea9IML8f/duTESebux
         EA05hLkQ1ehJpy1HonoEOlg+Cbu+LOUdzrQNAWR5lQijWh3/kRegLe3NqvKKQmjr5L
         sgZ+tuwj45uBYcH7t8QBdTcY77sn5Sduk3lZlrfiWAScfbzWP1rN855v4mBkY2Zrpb
         XcWyw/GJFJFvA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/19] btrfs: send: avoid duplicated orphan dir allocation and initialization
Date:   Wed, 11 Jan 2023 11:36:07 +0000
Message-Id: <ecf486ee5db9b0acdfd57959500ae5b735dd1089.1673436276.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673436276.git.fdmanana@suse.com>
References: <cover.1673436276.git.fdmanana@suse.com>
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

At can_rmdir() we are allocating and initializing an orphan dir object
twice. This can be deduplicated outside of the loop that iterates over
the dir index keys. So deduplicate that code, even because other patch
in the series will need to add more initializion code and another one
will add one more condition.

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
  btrfs: send: use MT_FLAGS_LOCK_EXTERN for the backref cache maple tree
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
 fs/btrfs/send.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 32dd88ed629a..f7d533c364b1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -3253,13 +3253,6 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 
 		dm = get_waiting_dir_move(sctx, loc.objectid);
 		if (dm) {
-			odi = add_orphan_dir_info(sctx, dir, dir_gen);
-			if (IS_ERR(odi)) {
-				ret = PTR_ERR(odi);
-				goto out;
-			}
-			odi->gen = dir_gen;
-			odi->last_dir_index_offset = found_key.offset;
 			dm->rmdir_ino = dir;
 			dm->rmdir_gen = dir_gen;
 			ret = 0;
@@ -3267,13 +3260,6 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 		}
 
 		if (loc.objectid > sctx->cur_ino) {
-			odi = add_orphan_dir_info(sctx, dir, dir_gen);
-			if (IS_ERR(odi)) {
-				ret = PTR_ERR(odi);
-				goto out;
-			}
-			odi->gen = dir_gen;
-			odi->last_dir_index_offset = found_key.offset;
 			ret = 0;
 			goto out;
 		}
@@ -3288,7 +3274,18 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 
 out:
 	btrfs_free_path(path);
-	return ret;
+
+	if (ret)
+		return ret;
+
+	odi = add_orphan_dir_info(sctx, dir, dir_gen);
+	if (IS_ERR(odi))
+		return PTR_ERR(odi);
+
+	odi->gen = dir_gen;
+	odi->last_dir_index_offset = found_key.offset;
+
+	return 0;
 }
 
 static int is_waiting_for_move(struct send_ctx *sctx, u64 ino)
-- 
2.35.1

