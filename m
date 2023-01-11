Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B056665A59
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjAKLjV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbjAKLjC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41D12BD3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E620B81B8D
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58DBC433F1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436985;
        bh=bz2hjETIMiO1Y/a5EWyqQkJemp8px3E+gwWGVekGXa4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NbfqwwmjH6n9W7gqrHeqN+ZHHFU2X/OJvgAqJJorBKXQ1/csWj7vRzPXfEclll4ks
         v3PRhow5rceaUIRXYiCkFM5Xr//5korjBE6vl/KXV34ytF7FD1hVL8lR8CpisMBi9z
         bVcA2V6GIruJsOl0DXpwvQQ6s4UtnBLKacOcvSpxALnRlNYUsBEypue1234krqp7Vn
         JQv9qoe9MIufJ/Lbno3lzkUAyjmx4ru4tw+GjJcC2ReY62g3o/MRPMup0iXcdcqypq
         uRDbpTiqMV1N2cp8lwSH9XGAjkoOmT/XW4LGw65PlrQx6PNUmob/u3h/gJnfp1VSs1
         u7NKQpFkV4t5g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/19] btrfs: send: avoid unnecessary generation search at did_overwrite_ref()
Date:   Wed, 11 Jan 2023 11:36:03 +0000
Message-Id: <22bedd046623def51d4bfcf1bd313da15f2e27ba.1673436276.git.fdmanana@suse.com>
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

At did_overwrite_ref() we always call get_inode_gen() to find out the
generation of the inode 'ow_inode'. However we don't always need to use
that generation, and in fact it's very common to not use it, so we end
up doing a b+tree search on the send root, allocating a path, etc, for
nothing. So improve on this by getting the generation only if we need
to use it.

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
 fs/btrfs/send.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 59106eb8b114..23060eec30de 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2193,8 +2193,8 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 			    const char *name, int name_len)
 {
 	int ret;
-	u64 gen;
 	u64 ow_inode;
+	u64 ow_gen = 0;
 
 	if (!sctx->parent_root)
 		return 0;
@@ -2204,6 +2204,8 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 		return ret;
 
 	if (dir != BTRFS_FIRST_FREE_OBJECTID) {
+		u64 gen;
+
 		ret = get_inode_gen(sctx->send_root, dir, &gen);
 		if (ret == -ENOENT)
 			return 0;
@@ -2224,12 +2226,15 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 		return ret;
 	}
 
-	ret = get_inode_gen(sctx->send_root, ow_inode, &gen);
-	if (ret < 0)
-		return ret;
+	if (ow_inode == ino) {
+		ret = get_inode_gen(sctx->send_root, ow_inode, &ow_gen);
+		if (ret < 0)
+			return ret;
 
-	if (ow_inode == ino && gen == ino_gen)
-		return 0;
+		/* It's the same inode, so no overwrite happened. */
+		if (ow_gen == ino_gen)
+			return 0;
+	}
 
 	/*
 	 * We know that it is or will be overwritten. Check this now.
@@ -2237,11 +2242,19 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 	 * inode 'ino' to be orphanized, therefore check if ow_inode matches
 	 * the current inode being processed.
 	 */
-	if ((ow_inode < sctx->send_progress) ||
-	    (ino != sctx->cur_ino && ow_inode == sctx->cur_ino &&
-	     gen == sctx->cur_inode_gen))
+	if (ow_inode < sctx->send_progress)
 		return 1;
 
+	if (ino != sctx->cur_ino && ow_inode == sctx->cur_ino) {
+		if (ow_gen == 0) {
+			ret = get_inode_gen(sctx->send_root, ow_inode, &ow_gen);
+			if (ret < 0)
+				return ret;
+		}
+		if (ow_gen == sctx->cur_inode_gen)
+			return 1;
+	}
+
 	return 0;
 }
 
-- 
2.35.1

