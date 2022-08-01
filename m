Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA60586C68
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiHAN6D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 09:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiHAN6B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 09:58:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5822DE8
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 06:58:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0BB26131B
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 13:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D5C433D6
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659362279;
        bh=djzP1n4LjsaCB08LT8QfOKNNx4Eas9PBHdRP6Bwd5iM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=d2fmFPEJMj5zFBfVW80tY4Lwt/Jx1FVsAqsPbZCBK+6tb6ChRpcFZ4Iz8TC8SEsWs
         ARHbiEa+uCsrSUlHFBARNWJ04ke7VIcqWR1oag/zkDGoHii1A7VjQNW99XCubsmc4e
         ZiIL02KG8/G0BWhTIyX2n6QnounueZkIO/Sx7eF86CZGvSa5bwQKmEVswExuGbZftH
         jxruSZgmWok4OaPnS2In+3zhh/i69fw4kRoA8KHXnqYt208I5QDxzdZFf4HGpdXABX
         gmNTP/yzt1IYXv4mrqF/u1shOvKbwnPNXcMD05ftefi1QbCUtaaldSDyJTlkLwFmt5
         oOYXXzik+yM1A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: fix warning during log replay when bumping inode link count
Date:   Mon,  1 Aug 2022 14:57:52 +0100
Message-Id: <55311bcaf0bce109e52a7032bf9148dccff65d10.1659361747.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1659361747.git.fdmanana@suse.com>
References: <cover.1659361747.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During log replay, at add_link(), we may increment the link count of
another inode that has a reference that conflicts with a new reference
for the inode currently being processed.

During log replay, at add_link(), we may drop (unlink) a reference from
some inode in the subvolume tree if that reference conflicts with a new
reference found in the log for the inode we are currently processing.

After the unlink, If the link count has decreased from 1 to 0, then we
increment the link count to prevent the inode from being deleted if it's
evicted by an iput() call, because we may have references to add to that
inode later on (and we will fixup its link count later during log replay).

However incrementing the link count from 0 to 1 triggers a warning:

  $ cat fs/inode.c
  (...)
  void inc_nlink(struct inode *inode)
  {
        if (unlikely(inode->i_nlink == 0)) {
                 WARN_ON(!(inode->i_state & I_LINKABLE));
                 atomic_long_dec(&inode->i_sb->s_remove_count);
        }
  (...)

The I_LINKABLE flag is only set when creating an O_TMPFILE file, so it's
never set during log replay.

Most of the time, the warning isn't triggered even if we dropped the last
reference of the conflicting inode, and this is because:

1) The conflicting inode was previously marked for fixup, through a call
   to link_to_fixup_dir(), which increments the inode's link count;

2) And the last iput() on the inode has not triggered eviction of the
   inode, nor was eviction triggered after the iput(). So at add_link(),
   even if we unlink the last reference of the inode, its link count ends
   up being 1 and not 0.

So this means that if eviction is triggered after link_to_fixup_dir() is
called, at add_link() we will read the inode back from the subvolume tree
and have it with a correct link count, matching the number of references
it has on the subvolume tree. So if when we are at add_link() the inode
has exactly one reference only, its link count is 1, and after the unlink
its link count becomes 0.

So fix this by using set_nlink() instead of inc_nlink(), as the former
accepts a transition from 0 to 1 and it's what we use in other similar
contextes (like at link_to_fixup_dir().

Also make add_inode_ref() use set_nlink() instead of inc_nlink() to
bump the link count from 0 to 1.

The warning is actually harmless, but it may scare users. Josef also ran
into it recently.

CC: stable@vger.kernel.org # 5.1+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ccf93ac58e73..ff786e712f2b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1459,7 +1459,7 @@ static int add_link(struct btrfs_trans_handle *trans,
 	 * on the inode will not free it. We will fixup the link count later.
 	 */
 	if (other_inode->i_nlink == 0)
-		inc_nlink(other_inode);
+		set_nlink(other_inode, 1);
 add_link:
 	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
 			     name, namelen, 0, ref_index);
@@ -1602,7 +1602,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				 * free it. We will fixup the link count later.
 				 */
 				if (!ret && inode->i_nlink == 0)
-					inc_nlink(inode);
+					set_nlink(inode, 1);
 			}
 			if (ret < 0)
 				goto out;
-- 
2.35.1

