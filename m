Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695A1190B90
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 11:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgCXKxc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 06:53:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:33826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgCXKxb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 06:53:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12156AF39
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 10:53:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs-progs: extent-tree: Fix wrong post order rb tree cleanup for block groups
Date:   Tue, 24 Mar 2020 18:53:15 +0800
Message-Id: <20200324105315.136569-7-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324105315.136569-1-wqu@suse.com>
References: <20200324105315.136569-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Valgrind reports memory leak for fsck/012, even after the image is
repair, the memory leak can still be reproduced.
  ==107060== HEAP SUMMARY:
  ==107060==     in use at exit: 176 bytes in 1 blocks
  ==107060==   total heap usage: 10,647 allocs, 10,646 frees, 3,000,654 bytes allocated
  ==107060==
  ==107060== 176 bytes in 1 blocks are definitely lost in loss record 1 of 1
  ==107060==    at 0x483BB65: calloc (vg_replace_malloc.c:762)
  ==107060==    by 0x1BD953: read_one_block_group (extent-tree.c:2661)
  ==107060==    by 0x1BDBD8: btrfs_read_block_groups (extent-tree.c:2719)
  ==107060==    by 0x1B3A2C: btrfs_setup_all_roots (disk-io.c:1024)
  ==107060==    by 0x1B44CA: __open_ctree_fd (disk-io.c:1299)
  ==107060==    by 0x1B46C6: open_ctree_fs_info (disk-io.c:1345)
  ==107060==    by 0x16952E: cmd_check (main.c:10154)
  ==107060==    by 0x11CDC6: cmd_execute (commands.h:125)
  ==107060==    by 0x11D712: main (btrfs.c:386)
  ==107060==
  ==107060== LEAK SUMMARY:
  ==107060==    definitely lost: 176 bytes in 1 blocks
  ==107060==    indirectly lost: 0 bytes in 0 blocks
  ==107060==      possibly lost: 0 bytes in 0 blocks
  ==107060==    still reachable: 0 bytes in 0 blocks
  ==107060==         suppressed: 0 bytes in 0 blocks

[CAUSE]
In btrfs_free_block_groups(), we use
rbtree_postorder_for_each_entry_safe() to iterate all block group cache.

However since we're already doing post order iteration, we shouldn't
call rb_erase() during that iteration, as it would re-balance the tree,
and break the post order iteration.

This wrong rb_erase() call leads to above memory leak.

[FIX]
Kill that wrong rb_erase() call.

Fixes: b1bd3cd93fff ("btrfs-progs: reform block groups caches structure")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/extent-tree.c b/extent-tree.c
index f0cb9faa4da6..271a2714b889 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2560,7 +2560,6 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 			     &info->block_group_cache_tree, cache_node) {
 		if (!list_empty(&cache->dirty_list))
 			list_del_init(&cache->dirty_list);
-		rb_erase(&cache->cache_node, &info->block_group_cache_tree);
 		RB_CLEAR_NODE(&cache->cache_node);
 		if (cache->free_space_ctl) {
 			btrfs_remove_free_space_cache(cache);
-- 
2.25.2

