Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA15665A5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjAKLjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbjAKLjB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766AFA465
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D12361C06
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFE3C433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436984;
        bh=Xyzp+CKxgPWNP8tmtSZ7a9/ddn1gFU0DIwb1Qp8I6pM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZhqQKjH8DOS23JS5+Yd2+Ntsdl6Kp9DJ0SyUGgvOrmY7ZThkqbydrf2rjbiKZRl8Z
         ViNX/WSFolxlDPY2ErfSUqtY02YEF7dBilUQiN0aqzKJl+fTKJYmyJnVMILF0WA/9l
         a2gpjV2WNuJ2Bin3bVH/ioCyVyr/PRS1TPmNzWpEIqVwZFLHHoqsE0y+xZCP2jtUFb
         wFvOLFYTwpRgs+RUIyDKsnxsioywtMKmbsqfrb4pe8W2MMXhvSq7/OCDTV9Lg31xyL
         zKBIbObFrBOdoCKjWLZdA2Kdzs8Ad1936po0ta9j23WIrCmrlgZXYfZUBJwYhDBd/7
         tZdY0I9qYwucw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/19] btrfs: send: directly return from did_overwrite_ref() and simplify it
Date:   Wed, 11 Jan 2023 11:36:02 +0000
Message-Id: <06477426bff54ecc38f75e3a6845731bd9d4abba.1673436276.git.fdmanana@suse.com>
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

There are no resources to release before did_overwrite_ref() returns, so
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
 fs/btrfs/send.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index b90ad6f7219c..59106eb8b114 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2192,48 +2192,44 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 			    u64 ino, u64 ino_gen,
 			    const char *name, int name_len)
 {
-	int ret = 0;
+	int ret;
 	u64 gen;
 	u64 ow_inode;
 
 	if (!sctx->parent_root)
-		goto out;
+		return 0;
 
 	ret = is_inode_existent(sctx, dir, dir_gen);
 	if (ret <= 0)
-		goto out;
+		return ret;
 
 	if (dir != BTRFS_FIRST_FREE_OBJECTID) {
 		ret = get_inode_gen(sctx->send_root, dir, &gen);
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
 
 	/* check if the ref was overwritten by another ref */
 	ret = lookup_dir_item_inode(sctx->send_root, dir, name, name_len,
 				    &ow_inode);
-	if (ret < 0 && ret != -ENOENT)
-		goto out;
-	if (ret) {
+	if (ret == -ENOENT) {
 		/* was never and will never be overwritten */
-		ret = 0;
-		goto out;
+		return 0;
+	} else if (ret < 0) {
+		return ret;
 	}
 
 	ret = get_inode_gen(sctx->send_root, ow_inode, &gen);
 	if (ret < 0)
-		goto out;
+		return ret;
 
-	if (ow_inode == ino && gen == ino_gen) {
-		ret = 0;
-		goto out;
-	}
+	if (ow_inode == ino && gen == ino_gen)
+		return 0;
 
 	/*
 	 * We know that it is or will be overwritten. Check this now.
@@ -2244,12 +2240,9 @@ static int did_overwrite_ref(struct send_ctx *sctx,
 	if ((ow_inode < sctx->send_progress) ||
 	    (ino != sctx->cur_ino && ow_inode == sctx->cur_ino &&
 	     gen == sctx->cur_inode_gen))
-		ret = 1;
-	else
-		ret = 0;
+		return 1;
 
-out:
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.35.1

