Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C9B665A67
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbjAKLjc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbjAKLjE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C4BB7FF
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DDAAFB81B8D
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2C1C433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436991;
        bh=d/4tneVXKHXgIx1Vi1b7OwN5+doGiLmXydrL8Jv8BL4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uYsDRm6EzD48cgIKmPdzsVlTBrpPUklnOLbINDaXDYA+ZnjWiYzxOgoJqUpVvWy9V
         pzb6CX+cA4RldHPzUkFtXOj/c7hwRdZ4uevEhH8AzxfmKU2dygYg1eepEVZ0DpfzZa
         dF28VgZmv9+BmmHCAITcb39SFJydqxd0dDXS1Pv5/dZAigceJpJOKoCkTGCxkpWQyf
         /w2gdy+OpszTiqBgdTS3PXmCegneaSUdpL5jUsOJ/eLq9qpdwAnm8GsjB47MrTQPz5
         lsL1tHx7c7jb1qvN5iQ/zNaOx1LSzC15IjFzEYJLAbkGVIPNYkLET0J4JuyGM7hunR
         xgLTwEcwthgqg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/19] btrfs: send: iterate waiting dir move rbtree only once when processing refs
Date:   Wed, 11 Jan 2023 11:36:10 +0000
Message-Id: <5486d61909a314d37d64512fc8a9acb8f4e2025a.1673436276.git.fdmanana@suse.com>
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

