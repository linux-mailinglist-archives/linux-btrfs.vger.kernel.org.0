Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8193190B8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 11:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbgCXKx3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 06:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:33800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727314AbgCXKx3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 06:53:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A8D0AF39
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 10:53:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs-progs: check/original: Fix uninitialized extent buffer contents
Date:   Tue, 24 Mar 2020 18:53:14 +0800
Message-Id: <20200324105315.136569-6-wqu@suse.com>
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
Valgrind reports the following error for fsck/012:
  adding new tree backref on start 4206592 len 4096 parent 0 root 5
  ==100735== Syscall param pwrite64(buf) points to uninitialised byte(s)
  ==100735==    at 0x49F303A: pwrite (in /usr/lib/libpthread-2.31.so)
  ==100735==    by 0x1A5C85: write_extent_to_disk (extent_io.c:815)
  ==100735==    by 0x1B2507: write_and_map_eb (disk-io.c:512)
  ==100735==    by 0x1B26A7: write_tree_block (disk-io.c:545)
  ==100735==    by 0x1D4822: __commit_transaction (transaction.c:148)
  ==100735==    by 0x1D4AA2: btrfs_commit_transaction (transaction.c:213)
  ==100735==    by 0x16360D: fixup_extent_refs (main.c:7662)
  ==100735==    by 0x16449F: check_extent_refs (main.c:8033)
  ==100735==    by 0x166199: check_chunks_and_extents (main.c:8786)
  ==100735==    by 0x166441: do_check_chunks_and_extents (main.c:8842)
  ==100735==    by 0x169D13: cmd_check (main.c:10324)
  ==100735==    by 0x11CDC6: cmd_execute (commands.h:125)
  ==100735==  Address 0x4e8aeb0 is 128 bytes inside a block of size 4,224 alloc'd
  ==100735==    at 0x483BB65: calloc (vg_replace_malloc.c:762)
  ==100735==    by 0x1A54C5: __alloc_extent_buffer (extent_io.c:609)
  ==100735==    by 0x1A5AD1: alloc_extent_buffer (extent_io.c:752)
  ==100735==    by 0x1B1A0A: btrfs_find_create_tree_block (disk-io.c:222)
  ==100735==    by 0x1BD4A2: btrfs_alloc_free_block (extent-tree.c:2538)
  ==100735==    by 0x1A8CE3: __btrfs_cow_block (ctree.c:322)
  ==100735==    by 0x1A91C6: btrfs_cow_block (ctree.c:415)
  ==100735==    by 0x1AB16C: btrfs_search_slot (ctree.c:1185)
  ==100735==    by 0x160BBC: delete_extent_records (main.c:6652)
  ==100735==    by 0x16343F: fixup_extent_refs (main.c:7629)
  ==100735==    by 0x16449F: check_extent_refs (main.c:8033)
  ==100735==    by 0x166199: check_chunks_and_extents (main.c:8786)
  ==100735==

[CAUSE]
For new extent buffer allocated, we don't initialize its content.

This is not a major concern, at all.
For the above report, the reported range is inside the unused part of
the extent buffer, thus won't cause anything.

Regular btrfs_cow_block() will cover all the used ranges of one extent
buffer.

[FIX]
But still, since kernel initialize the extent buffer with 0, it won't
hurt to do extra initialized to make valgrind happy.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/extent_io.c b/extent_io.c
index f11917a4c6fc..4b5acb1aabf0 100644
--- a/extent_io.c
+++ b/extent_io.c
@@ -622,6 +622,7 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *info,
 	eb->tree = &info->extent_cache;
 	INIT_LIST_HEAD(&eb->recow);
 	INIT_LIST_HEAD(&eb->lru);
+	memset_extent_buffer(eb, 0, 0, blocksize);
 
 	return eb;
 }
-- 
2.25.2

