Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E47E6742FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 20:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjASTjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 14:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjASTjo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 14:39:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A1A5FD
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 11:39:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E407D61D1B
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC41BC433F0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157182;
        bh=3JVlcVMDynD013hZOe1M/K44O4llr6B7BUBJgoSzHXg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Wzb/JtAbo+CF7AXMnAPx6Txw3DU6ZtKBX37blCaleH9zN3+0+z+K7WnGfggxV42QZ
         gJ3qq0nN5xoSsAdgUAKjyeV5+lyxQI36Mu0jRaQZT1FZtbUxSiMbV3fwfW4Rc18n6b
         Ug3IUlLUs5iFdsOTJynZ2VohEFkRy+NFhYDBLZLWp3t5mVRYVFl3cQTD0X4/Bd+SLO
         p7V/Mu6dbFaoEOsbqaCLpsZyGWyHQyLVkx+rsio33f7mbXCy10eWEoqvH2bEMn4y/S
         K8NoD137afTcBmKoaiGGY7VvRtwvKx2XuKnse6QjOZrsjHjeDPjr8eCMGFiu5qOXnL
         LQz/VF7JmJVvQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 09/18] btrfs: send: iterate waiting dir move rbtree only once when processing refs
Date:   Thu, 19 Jan 2023 19:39:21 +0000
Message-Id: <f4d99ec2e8089cb2015f9da2e37f85c70d886868.1674157020.git.fdmanana@suse.com>
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

When processing the new references for an inode, we unnecessarily iterate
twice the waiting dir moves rbtree, once with is_waiting_for_move() and
if we found an entry in the rbtree, we iterate it again with a call to
get_waiting_dir_move(). This is pointless, we can make this simpler and
more efficient by calling only get_waiting_dir_move(), so just do that.

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
 fs/btrfs/send.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index cd4aa0eae66c..20fcf1c0832a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4335,12 +4335,9 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				 * the source path when performing its rename
 				 * operation.
 				 */
-				if (is_waiting_for_move(sctx, ow_inode)) {
-					wdm = get_waiting_dir_move(sctx,
-								   ow_inode);
-					ASSERT(wdm);
+				wdm = get_waiting_dir_move(sctx, ow_inode);
+				if (wdm)
 					wdm->orphanized = true;
-				}
 
 				/*
 				 * Make sure we clear our orphanized inode's
-- 
2.35.1

