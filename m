Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C715E3872E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 09:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243528AbhERHLJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 03:11:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:32912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237714AbhERHLI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 03:11:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621321790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78XJyVjiRmi2+KXDSxClWyC0XS9FDFDxilBB9+CmI0g=;
        b=TTdEuYi65HJ1tGRzBWj9DwsVpYtwAhIfB07MlHp7lxtQArcTHO5dCpcr+vtmeUQgwpwuIC
        xm486i3t+KwcCSJGcfLPIlPdBkR6IejZvBJt+Ovx7O3AgGwBELQ2YIl+/bBbw+j51U80Lb
        VfpdzJdl+bs0DMVNjevN+xIK1nqJ6hI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6071DB10B
        for <linux-btrfs@vger.kernel.org>; Tue, 18 May 2021 07:09:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: fix the unsafe access in btrfs_lookup_first_ordered_range()
Date:   Tue, 18 May 2021 15:09:42 +0800
Message-Id: <20210518070942.206846-3-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518070942.206846-1-wqu@suse.com>
References: <20210518070942.206846-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Please fold this fix into patch "btrfs: introduce btrfs_lookup_first_ordered_range()".

[BUG]
David reported a failure in generic/521 which
btrfs_lookup_first_ordered_range() got a poisoned pointer:

 run fstests generic/521 at 2021-05-14 00:33:06
 general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6a9b: 0000 [#1] PREEMPT SMP
 CPU: 0 PID: 20046 Comm: fsx Not tainted 5.13.0-rc1-default+ #1463
 RIP: 0010:btrfs_lookup_first_ordered_range+0x46/0x140 [btrfs]
 RAX: 6b6b6b6b6b6b6b6b RBX: 6b6b6b6b6b6b6b6b RCX: ffffffffffffffff
 RDX: 6b6b6b6b6b6b6b6b RSI: ffffffffc01b3e09 RDI: ffff93c444e397d0
 Call Trace:
  btrfs_invalidatepage+0xd3/0x390 [btrfs]
  truncate_cleanup_page+0xda/0x170
  truncate_inode_pages_range+0x131/0x5a0
  ? trace_btrfs_space_reservation+0x33/0xf0 [btrfs]
  ? lock_acquire+0xa0/0x150
  ? unmap_mapping_pages+0x4d/0x130
  ? do_raw_spin_unlock+0x4b/0xa0
  ? unmap_mapping_pages+0x5e/0x130
  btrfs_punch_hole_lock_range+0xc5/0x130 [btrfs]
  btrfs_zero_range+0x1d7/0x4b0 [btrfs]
  btrfs_fallocate+0x6b4/0x890 [btrfs]
  ? __x64_sys_fallocate+0x3e/0x70
  ? __do_sys_newfstatat+0x40/0x70
  vfs_fallocate+0x12e/0x420
  __x64_sys_fallocate+0x3e/0x70
  do_syscall_64+0x3f/0xb0
  entry_SYSCALL_64_after_hwframe+0x44/0xae

[CAUSE]
Although I can't reproduce, according to the line number, it's in the btree
search code, and just lines before that, I use some copied code from
tree_search():

	struct rb_node *node = tree->tree.rb_node;

But that assignment is out of spinlock, which is not safe to access,
thus lead to above poisoned pointer.

Unlike tree_search(), which callers have already hold the spinlock.

[FIX]
Fix it by only assign @node after we have hold the spinlock.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ordered-data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 4fa377da40e4..b1b377ad99a0 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -943,13 +943,14 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 			struct btrfs_inode *inode, u64 file_offset, u64 len)
 {
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
-	struct rb_node *node = tree->tree.rb_node;
+	struct rb_node *node;
 	struct rb_node *cur;
 	struct rb_node *prev;
 	struct rb_node *next;
 	struct btrfs_ordered_extent *entry = NULL;
 
 	spin_lock_irq(&tree->lock);
+	node = tree->tree.rb_node;
 	/*
 	 * Here we don't want to use tree_search() which will use tree->last
 	 * and screw up the search order.
-- 
2.31.1

