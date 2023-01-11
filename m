Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F004D665A62
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjAKLjg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbjAKLjG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A9D137
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A89EAB81AD3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0139C433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436993;
        bh=HXV/Gb+mxi4s1k4nOv3b39QjeDGD/VgnxwTZaEwq//4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XiGBTFXaSi4wvacXA2w3z+57B5JAsE4q8s/VbeuDaTgGW3U53FIRfNPHdKq1VLWFp
         X9TK8l4sdX2jXMd3XYyFyKd/TaG+ph7Ng7sFVb+mF/vmWSYYOUvq+EpMD8/TftGvEg
         t2oS0FO5TxaZ40FCwnbsN+CevmwIyklCQNFn80bFP7EvPpzkhcCVJsJ6aAcm9lzB8v
         KAMyG7+3ITG6d/VYCsbfcFgdtRhBK7WkCX+bHkUdlnUABjQHfmR28pjAbZMowg5gpk
         xGbvl9nXyfn3Wb0gZN+SbeBf0ug7VNHzmlLDcmOh4ZSRX9z3HpXt5XgntOGZFNq6Sz
         ToZRya/1WzIjg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/19] btrfs: send: initialize all the red black trees earlier
Date:   Wed, 11 Jan 2023 11:36:12 +0000
Message-Id: <9e69f33b0dcce18f81e2829cf629110baacd578a.1673436276.git.fdmanana@suse.com>
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

After we allocate the send context object and before we initialize all
the red black trees, we can jump to the 'out' label if some errors happen,
and then under the 'out' label we use RB_EMPTY_ROOT() against some of the
those trees, which we have not yet initialized. This happens to work out
ok because the send context object was initialized to zeroes with kzalloc
and the RB_ROOT initializer just happens to have the following definition:

    #define RB_ROOT (struct rb_root) { NULL, }

But it's really neither clean nor a good practice as RB_ROOT is supposed
to be opaque and in case it changes or we change those red black trees to
some other data structure, it leaves us in a precarious situation.

So initialize all the red black trees immediately after allocating the
send context and before any jump into the 'out' label.

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
 fs/btrfs/send.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 5ac3cff7bd68..e60aa0cb0b5c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8142,6 +8142,12 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	INIT_LIST_HEAD(&sctx->backref_cache.lru_list);
 	mt_init_flags(&sctx->backref_cache.entries, MT_FLAGS_LOCK_EXTERN);
 
+	sctx->pending_dir_moves = RB_ROOT;
+	sctx->waiting_dir_moves = RB_ROOT;
+	sctx->orphan_dirs = RB_ROOT;
+	sctx->rbtree_new_refs = RB_ROOT;
+	sctx->rbtree_deleted_refs = RB_ROOT;
+
 	sctx->flags = arg->flags;
 
 	if (arg->flags & BTRFS_SEND_FLAG_VERSION) {
@@ -8207,12 +8213,6 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 		goto out;
 	}
 
-	sctx->pending_dir_moves = RB_ROOT;
-	sctx->waiting_dir_moves = RB_ROOT;
-	sctx->orphan_dirs = RB_ROOT;
-	sctx->rbtree_new_refs = RB_ROOT;
-	sctx->rbtree_deleted_refs = RB_ROOT;
-
 	sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
 				     arg->clone_sources_count + 1,
 				     GFP_KERNEL);
-- 
2.35.1

