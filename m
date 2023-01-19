Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259D76742FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 20:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjASTjp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 14:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjASTjm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 14:39:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AEE94300
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 11:39:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 325C861D5C
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268EBC433D2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157180;
        bh=B0BGda+QDkxmYfExAf7G5qYUNM//hTWB1tjAXwQFjBY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZdnhmC3uYg7dB8rURDvhLD3067l8KWGHskFsnc4RkjP0SuC9sQ2BFLrintEQlxxM3
         auTkfctdc9dSU8PwsPVbllzVUGPjeq4iPd+EOeMvLj9jAlE6wCmZztMlaRALxp73xM
         zSEdzMMzibmFW1uRayIv1I0qP1lgONBjzcO32cd8qpb9k3WzY+8W+0jevxRvp3Hd+A
         z8qkXjUFAF0nlQUo3eiW+4nb/KVUHTBXPXiNnNCBBTw7br/lSNVKv2QMIeGF9XdSvy
         eopWgnzzywkOpphbMgS0QnnYt5ihwxNRxgfnz99wvKLsjWJaLcDgMYLkjvQ60TyZXB
         g5NZIiXqmdNgA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/18] btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
Date:   Thu, 19 Jan 2023 19:39:19 +0000
Message-Id: <4ee5e1fd893a126e9ae6f43959a8abc03be8188c.1674157020.git.fdmanana@suse.com>
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

