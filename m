Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBDE63A5C0
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Nov 2022 11:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiK1KMU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Nov 2022 05:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiK1KMS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Nov 2022 05:12:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28F02BFE
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 02:12:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9874061042
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 10:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843BCC433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Nov 2022 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669630337;
        bh=93KsJAVxS6gmVW2irriy3phlkCs/DKPbzzn/Lh1EslY=;
        h=From:To:Subject:Date:From;
        b=YSRL1aEeUQ4oDpxM6RPgaYSvwDOQAaDDiD37I/55VRlLlji71PtK7D2hJH8W/43Xd
         QhAbXpyhC8Aiq+22vemsVPtnvhWnzntdYpy/POzIrrVXXwG9oG8kws0HgFremv7z/W
         u6LlBspPIJcsqAkHU+ztWg1NP8lUa63n+qGAtlQDOaEwZRyuCcPzv1toegfOaCCZCx
         Y6GyrVcoWkIUTXeLEzwpotefCJTEk35CbJ5Wy/9kgLlQvKLKxzsHEBlHUVo5GhuzID
         XVXQayXtg0K6RqLGGjOmNbKfsC42uZFikIxxaD+avKnUhGOSyhkWCYSCH7yd0dxmhY
         8lR0oj6F1sB7w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: send: initialize backref cache earlier
Date:   Mon, 28 Nov 2022 10:12:13 +0000
Message-Id: <25b5197a1d0b81c12acdb79ac0f6d82df287c3c7.1669630263.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
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

If we successfully allocated the send context object but ran into an error
after it and before initializing the backref cache, then under the 'out'
label we'll end up calling empty_backref_cache(), which will iterate over
a the backref cache's lru list which was not initialized, triggering
invalid memory accesses.

Fix this by initializing the backref cache immediately after a successful
allocation of the send context.

This fixes a recent patch not yet in Linus' tree, only in misc-next and
linux-next, which has the subject:

  "btrfs: send: cache leaf to roots mapping during backref walking"

Reported-by: syzbot+c423003741c992ccf56b@syzkaller.appspotmail.com
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 5a00d08c8300..67f7c698ade3 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8096,6 +8096,9 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	INIT_RADIX_TREE(&sctx->name_cache, GFP_KERNEL);
 	INIT_LIST_HEAD(&sctx->name_cache_list);
 
+	INIT_LIST_HEAD(&sctx->backref_cache.lru_list);
+	mt_init(&sctx->backref_cache.entries);
+
 	sctx->flags = arg->flags;
 
 	if (arg->flags & BTRFS_SEND_FLAG_VERSION) {
@@ -8167,9 +8170,6 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	sctx->rbtree_new_refs = RB_ROOT;
 	sctx->rbtree_deleted_refs = RB_ROOT;
 
-	INIT_LIST_HEAD(&sctx->backref_cache.lru_list);
-	mt_init(&sctx->backref_cache.entries);
-
 	sctx->clone_roots = kvcalloc(sizeof(*sctx->clone_roots),
 				     arg->clone_sources_count + 1,
 				     GFP_KERNEL);
-- 
2.35.1

