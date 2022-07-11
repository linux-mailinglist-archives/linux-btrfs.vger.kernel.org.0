Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66604570575
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 16:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiGKOW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiGKOW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 10:22:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ED165556
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 07:22:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0040BB80FB3
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 14:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402CDC341C8
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 14:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657549374;
        bh=W1C8DAytyQwkXqm2aj8IyvMCU/pUSkmum7gAZ0XPzJM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nnNQyUBoZH9yCCbOdgrxguSoV/z5Tf+4KzR/l1SYkQDJmXRVK/bBZY3xQCO2y5mrP
         1AMfRbNYKsbOzo2mXtm0TWBOogezyyb7xIDq0ZX/ICs6rv3zR/bOlBGkdAS0KdCM8y
         o5ER+3vi1Kl6wIVz99r4UCGRGOwGsA0RB3xzfjPEKqWvNZFxxt3vYMSRwsnvUBEnkJ
         //KVLznEkCfuf/SVoAw5fthRI3Ka8o5z/q5m3RCJvEFARry4vzKLoaBLWrVySNXLMQ
         Hd9g32NSZCR75bTE/Wt/HagWrbX9LuUaN432jZ86M9K3CqgMVFhIqnn0x+0JsqYngS
         bddi0GEQ7t58Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: set the objectid of the btree inode's location key
Date:   Mon, 11 Jul 2022 15:22:49 +0100
Message-Id: <92f0a873da8c66fd4b6615a3b2c580d3a410a11f.1657549024.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657549024.git.fdmanana@suse.com>
References: <cover.1657549024.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We currently don't use the location key of the btree inode, its content
is set to zeroes, as it's a special inode that is not persisted (it has
no inode item stored in any btree).

At btrfs_ino(), an inline function used extensively in btrfs, we have
this special check if the given inode's location objectid is 0, and if it
is, we return the value stored in the VFS' inode i_ino field instead
(which is BTRFS_BTREE_INODE_OBJECTID for the btree inode).

To reduce the code at btrfs_ino(), we can simply set the objectid of the
btree inode to the value BTRFS_BTREE_INODE_OBJECTID. This eliminates the
need to check for the special case of the objectid being zero, with the
side effect of reducing the overall code size and having less code to
execute, as btrfs_ino() is an inline function.

Before:

$ size fs/btrfs/btrfs.ko
   text	   data	    bss	    dec	    hex	filename
1620502	 189240	  29032	1838774	 1c0eb6	fs/btrfs/btrfs.ko

After:

$ size fs/btrfs/btrfs.ko
   text	   data	    bss	    dec	    hex	filename
1617487	 189240	  29032	1835759	 1c02ef	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h | 7 ++-----
 fs/btrfs/disk-io.c     | 4 +++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b467264bd1bb..a18f90ff16f1 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -283,11 +283,8 @@ static inline u64 btrfs_ino(const struct btrfs_inode *inode)
 {
 	u64 ino = inode->location.objectid;
 
-	/*
-	 * !ino: btree_inode
-	 * type == BTRFS_ROOT_ITEM_KEY: subvol dir
-	 */
-	if (!ino || inode->location.type == BTRFS_ROOT_ITEM_KEY)
+	/* type == BTRFS_ROOT_ITEM_KEY: subvol dir */
+	if (inode->location.type == BTRFS_ROOT_ITEM_KEY)
 		ino = inode->vfs_inode.i_ino;
 	return ino;
 }
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0da86fba370e..b42908ad4af7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2306,7 +2306,9 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 	extent_map_tree_init(&BTRFS_I(inode)->extent_tree);
 
 	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
-	memset(&BTRFS_I(inode)->location, 0, sizeof(struct btrfs_key));
+	BTRFS_I(inode)->location.objectid = BTRFS_BTREE_INODE_OBJECTID;
+	BTRFS_I(inode)->location.type = 0;
+	BTRFS_I(inode)->location.offset = 0;
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 	btrfs_insert_inode_hash(inode);
 }
-- 
2.35.1

