Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE7665A66
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbjAKLj2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbjAKLjD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B1F3884
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64B9561B8E
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5366EC433F1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436989;
        bh=YmKLNs8Sf/Umkr43m/ieZAWQg3jFPSTPhM7eHLzFT6I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JaSLUFXOtgb+SdDE4BMtUoUb/f/1CZSSUH35xN+trGj3ziK9Ko5+JLXyoIQNZG7Wo
         SZtmRP8OoT82EZNsKk+2kQHE5z7jLpFgYjrrdvam4O7SAW/NOAHL+z3wPzLd5H63eK
         NlXfJ6kWPG4E3UPEgzvGQw6t8r5xD4cS9S5ukCp60uqaKkdx4/iAEO1nHT7deHD6e6
         DCAuPfj3R5rNDV5CxnbbzkGci9ev8mCO0Fk+lyjnXQzxUSLkZqSRHEfbjuc79B45I0
         IDV29ZvHkxK0w4lfO8/huCruMW0Evvv5kk7s8x/0Pl/REWlHmse9L+iG1Rq8ywB7jI
         fFP0z4LibxiNQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/19] btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
Date:   Wed, 11 Jan 2023 11:36:08 +0000
Message-Id: <08ad72730636a2f40abba7f0be31e0a40c6049c6.1673436276.git.fdmanana@suse.com>
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

At can_rmdir() we start by searching the orphan dirs rbtree for an orphan
dir object for the target directory. Later when iterating over the dir
index keys, if we find that any dir entry points to inode for which there
is a pending dir move or the inode was not yet processed, we exit because
we can't remove the directory yet. However we end up always calling
add_orphan_dir_info(), which will iterate again the rbtree and if there is
already an orphan dir object (created by the first call to can_rmdir()),
it returns the existing object. This is unnecessary work because in case
there is already an existing orphan dir object, we got a reference to it
at the start of can_rmdir(). So skip the call to add_orphan_dir_info()
if we already have a reference for an orphan dir object.

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
 fs/btrfs/send.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f7d533c364b1..bc57fa8a6bde 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -3278,11 +3278,14 @@ static int can_rmdir(struct send_ctx *sctx, u64 dir, u64 dir_gen)
 	if (ret)
 		return ret;
 
-	odi = add_orphan_dir_info(sctx, dir, dir_gen);
-	if (IS_ERR(odi))
-		return PTR_ERR(odi);
+	if (!odi) {
+		odi = add_orphan_dir_info(sctx, dir, dir_gen);
+		if (IS_ERR(odi))
+			return PTR_ERR(odi);
+
+		odi->gen = dir_gen;
+	}
 
-	odi->gen = dir_gen;
 	odi->last_dir_index_offset = found_key.offset;
 
 	return 0;
-- 
2.35.1

