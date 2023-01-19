Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D905E6742F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 20:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjASTjn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 14:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjASTjl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 14:39:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CA3A5FD
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 11:39:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7551E61D1B
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C89C433D2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157178;
        bh=JZ0IvlubeXdciN/LPPq5UdjDR7dEa2SVmoHgTfZ/8xU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L/41wRPDvak/dZzbkFy/kMYkM0PbnuiPoU4HqM9dRPge48xiozqMbMBIEHpIzTq3N
         EIReMc+11xgmGLYSdhrXTWtmN/IkduJzx4PsczquHlSJjExgu7w28lwK7n9JtH3Xpp
         SshpIB0ULm5a5njb2dfbUyWui58HUzFanzWGFEyo9LqupYV3soY9hEOkoBosid81vJ
         7h9ieAdBecdWIzzZrrracTvOpjak27ci2S8BWuvlrmA5gcz7x75TblFaQuS1R7TR/b
         N0eqA7UjnGqlaYzOBEcaPWuO8jyA6i6aj9LOSiRvCV1sZzOW1XkH476OIkocAaTOSh
         Mcbwx3UrrZFVA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/18] btrfs: send: remove send_progress argument from can_rmdir()
Date:   Thu, 19 Jan 2023 19:39:17 +0000
Message-Id: <09271a55f41a848b2fec3e167beb1905c6f3de4e.1674157020.git.fdmanana@suse.com>
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

All callers of can_rmdir() pass sctx->cur_ino as the value for the
send_progress argument, so remove the argument and directly use
sctx->cur_ino.

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
 fs/btrfs/send.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6332add4865c..32dd88ed629a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -3210,8 +3210,7 @@ static void free_orphan_dir_info(struct send_ctx *sctx,
  * We check this by iterating all dir items and checking if the inode behind
  * the dir item was already processed.
  */
-static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
-		     u64 send_progress)
+static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 {
 	int ret = 0;
 	int iter_ret = 0;
@@ -3267,7 +3266,7 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen,
 			goto out;
 		}
 
-		if (loc.objectid > send_progress) {
+		if (loc.objectid > sctx->cur_ino) {
 			odi = add_orphan_dir_info(sctx, dir, dir_gen);
 			if (IS_ERR(odi)) {
 				ret = PTR_ERR(odi);
@@ -3574,7 +3573,7 @@ static int apply_dir_move(struct send_ctx *sctx, struct pending_dir_move *pm)
 		}
 		gen = odi->gen;
 
-		ret = can_rmdir(sctx, rmdir_ino, gen, sctx->cur_ino);
+		ret = can_rmdir(sctx, rmdir_ino, gen);
 		if (ret < 0)
 			goto out;
 		if (!ret)
@@ -4465,8 +4464,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		 * later, we do this check again and rmdir it then if possible.
 		 * See the use of check_dirs for more details.
 		 */
-		ret = can_rmdir(sctx, sctx->cur_ino, sctx->cur_inode_gen,
-				sctx->cur_ino);
+		ret = can_rmdir(sctx, sctx->cur_ino, sctx->cur_inode_gen);
 		if (ret < 0)
 			goto out;
 		if (ret) {
@@ -4571,8 +4569,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				goto out;
 		} else if (ret == inode_state_did_delete &&
 			   cur->dir != last_dir_ino_rm) {
-			ret = can_rmdir(sctx, cur->dir, cur->dir_gen,
-					sctx->cur_ino);
+			ret = can_rmdir(sctx, cur->dir, cur->dir_gen);
 			if (ret < 0)
 				goto out;
 			if (ret) {
-- 
2.35.1

