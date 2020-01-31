Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4D6D14EE2B
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 15:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgAaOGM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 09:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728500AbgAaOGM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 09:06:12 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51A1D2067C
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580479570;
        bh=GgEqBqZxE2MNwhuKD28Eqf66N4/N+s+0oIGlcICJvYY=;
        h=From:To:Subject:Date:From;
        b=srCfNF9o89wVZDIRM7LN3B++RK+ZvK558XyQqKqAk+iCdPaVoVPqkMSErSngmlVH1
         mqbUCJY2DDyQNcHKRfVyFWsShZ++XfOesFfM5guX+o4u3fHI6ad17M2s0InthfHmGj
         Mpf3wQMRGZ3aS4aah5gNO90rpxVMDzHB8+yIfoeU=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix race between using extent maps and merging them
Date:   Fri, 31 Jan 2020 14:06:07 +0000
Message-Id: <20200131140607.26923-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We have a few cases where we allow an extent map that is in an extent map
tree to be merged with other extents in the tree. Such cases include the
unpinning of an extent after the respective ordered extent completed or
after logging an extent during a fast fsync. This can lead to subtle and
dangerous problems because when doing the merge some other task might be
using the same extent map and as consequence see an inconsistent state of
the extent map - for example sees the new length but has seen the old start
offset.

With luck this triggers a BUG_ON(), and not some silent bug, such as the
following one in __do_readpage():

  $ cat -n fs/btrfs/extent_io.c
  3061  static int __do_readpage(struct extent_io_tree *tree,
  3062                           struct page *page,
  (...)
  3127                  em = __get_extent_map(inode, page, pg_offset, cur,
  3128                                        end - cur + 1, get_extent, em_cached);
  3129                  if (IS_ERR_OR_NULL(em)) {
  3130                          SetPageError(page);
  3131                          unlock_extent(tree, cur, end);
  3132                          break;
  3133                  }
  3134                  extent_offset = cur - em->start;
  3135                  BUG_ON(extent_map_end(em) <= cur);
  (...)

Consider the following example scenario, where we end up hitting the
BUG_ON() in __do_readpage().

We have an inode with a size of 8Kb and 2 extent maps:

  extent A: file offset 0, length 4Kb, disk_bytenr = X, persisted on disk by
            a previous transaction

  extent B: file offset 4Kb, length 4Kb, disk_bytenr = X + 4Kb, not yet
            persisted but writeback started for it already. The extent map
	    is pinned since there's writeback and an ordered extent in
	    progress, so it can not be merged with extent map A yet

The following sequence of steps leads to the BUG_ON():

1) The ordered extent for extent B completes, the respective page gets its
   writeback bit cleared and the extent map is unpinned, at that point it
   is not yet merged with extent map A because it's in the list of modified
   extents;

2) Due to memory pressure, or some other reason, the mm subsystem releases
   the page corresponding to extent B - btrfs_releasepage() is called and
   returns 1, meaning the page can be released as it's not dirty, not under
   writeback anymore and the extent range is not locked in the inode's
   iotree. However the extent map is not released, either because we are
   not in a context that allows memory allocations to block or because the
   inode's size is smaller than 16Mb - in this case our inode has a size
   of 8Kb;

3) Task B needs to read extent B and ends up __do_readpage() through the
   btrfs_readpage() callback. At __do_readpage() it gets a reference to
   extent map B;

4) Task A, doing a fast fsync, calls clear_em_loggin() against extent map B
   while holding the write lock on the inode's extent map tree - this
   results in try_merge_map() being called and since it's possible to merge
   extent map B with extent map A now (the extent map B was removed from
   the list of modified extents), the merging begins - it sets extent map
   B's start offset to 0 (was 4Kb), but before it increments the map's
   length to 8Kb (4kb + 4Kb), task A is at:

   BUG_ON(extent_map_end(em) <= cur);

   The call to extent_map_end() sees the extent map has a start of 0
   and a length still at 4Kb, so it returns 4Kb and 'cur' is 4Kb, so
   the BUG_ON() is triggered.

So it's dangerous to modify an extent map that is in the tree, because some
other task might have got a reference to it before and still using it, and
needs to see a consistent map while using it. Generally this is very rare
since most paths that lookup and use extent maps also have the file range
locked in the inode's iotree. The fsync path is pretty much the only
exception where we don't do it to avoid serialization with concurrent
reads.

Fix this by not allowing an extent map do be merged if if it's being used
by tasks other then the one attempting to merge the extent map (when the
reference count of the extent map is greater than 2).

Reported-by: ryusuke1925 <st13s20@gm.ibaraki-ct.ac.jp>
Reported-by: Koki Mitani <koki.mitani.xg@hco.ntt.co.jp>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206211
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 6f417ff68980..bd6229fb2b6f 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -237,6 +237,17 @@ static void try_merge_map(struct extent_map_tree *tree, struct extent_map *em)
 	struct extent_map *merge = NULL;
 	struct rb_node *rb;
 
+	/*
+	 * We can't modify an extent map that is in the tree and that is being
+	 * used by another task, as it can cause that other task to see it in
+	 * inconsistent state during the merging. We always have 1 reference for
+	 * the tree and 1 for this task (which is unpinning the extent map or
+	 * clearing the logging flag), so anything > 2 means it's being used by
+	 * other tasks too.
+	 */
+	if (refcount_read(&em->refs) > 2)
+		return;
+
 	if (em->start != 0) {
 		rb = rb_prev(&em->rb_node);
 		if (rb)
-- 
2.11.0

