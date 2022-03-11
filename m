Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8954D60BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 12:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348299AbiCKLgr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 06:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245325AbiCKLgp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 06:36:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B671BE4D2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 03:35:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E133B61AD2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 11:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD623C340E9
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 11:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646998541;
        bh=o/yYtFIZiuNHbK9KEjesgtj/gUfAOwCAIfMfeuqqKFY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=P7264o3uNGN7oUKCBOaj1dQtx9kt323DqltKV/GgP/Thtz6KSVzk/19+hRk2M+u4P
         aqqX7IhE7r9UuY7fKeMSWmVjupmuatWJrb5kS3+zlD88bPxlrydm4ds2WRySMksZHN
         Pvjb+Yjt/K4Eat9w6sfgTP2NHEEuLmoZobHtBCM8YeBjenZoKjokOPXiHzc9SWdIIV
         uobsz0ReLdBNBddC+RjlBX71tLhlpcj0Hie1JtHVBXTHahaXcfQjjczCLk6HnoCWwA
         yK98g0pzEh61KC+AQLCAPjEwkPzqhNm6z6lK11A3OtlunFv7nsGBU/psORsvhDb0j5
         zVD5j+3jFZD8g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: update outdated comment for read_block_for_search()
Date:   Fri, 11 Mar 2022 11:35:33 +0000
Message-Id: <676a2001ca18304224cf0cf478e93f44d7235f2f.1646998177.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646998177.git.fdmanana@suse.com>
References: <cover.1646998177.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The comment at the top of read_block_for_search() is very outdated, as it
refers to the blocking versus spinning path locking modes. We no longer
have these two locking modes after we switched the btree locks from custom
code to rw semaphores. So update the comment to stop referring to the
blocking mode and put it more up to date.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e1e942e1918f..13d4833afcd3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1390,12 +1390,13 @@ static noinline void unlock_up(struct btrfs_path *path, int level,
 }
 
 /*
- * helper function for btrfs_search_slot.  The goal is to find a block
- * in cache without setting the path to blocking.  If we find the block
- * we return zero and the path is unchanged.
+ * Helper function for btrfs_search_slot() and other functions that do a search
+ * on a btree. The goal is to find a tree block in the cache (the radix tree at
+ * fs_info->buffer_radix), but if we can't find it, or it's not up to date, read
+ * its pages from disk.
  *
- * If we can't find the block, we set the path blocking and do some
- * reada.  -EAGAIN is returned and the search must be repeated.
+ * Returns -EAGAIN, with the path unlocked, if the caller needs to repeat the
+ * whole btree search, starting again from the current root node.
  */
 static int
 read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
-- 
2.33.0

