Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A54049501D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jan 2022 15:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347338AbiATO2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jan 2022 09:28:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56714 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347071AbiATO2C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jan 2022 09:28:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3824D61781
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 14:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25136C340E0
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jan 2022 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642688879;
        bh=hRcC0tcLINeJo6WGwNHrDJbVrERG+6xjXxYZ91dPodo=;
        h=From:To:Subject:Date:From;
        b=FF50tbYHlVeoRa8jVBvh7lRGrtDZ0f6wtr9F4UKMHF79B10PSV8dgWzED8ry4HWIR
         CoDvqIO0jgdaFk1gDt6BCT3+1ehfR0xQb0+yCy/5TDeBd2RToyo3E5t7kRAuw1ogkP
         tyKdgfeeQWncc7J4ixZNwL4pHTAHrx02YCkaHiruBZaN+uqyazZOfOsminQMpSWAha
         bbq6d/goq78usB6orQT/YyDUKVWqNXIceV6eNzjz5m5/UcN/CNmL9bVRBNdj5ojuqQ
         7/cRQrnOugyx55luO/x4firkACilxpMNRcXQM1tHURdancUruiD3V7XJtj5YtuoEsM
         cyYiCNprcXKxg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix deadlock when reserving space during defrag
Date:   Thu, 20 Jan 2022 14:27:56 +0000
Message-Id: <5cb3ce140c84b0283be685bae8a5d75d5d19af08.1642688018.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When defragging we can end up collecting a range for defrag that has
already pages under delalloc (dirty), as long as the respective extent
map for their range is not mapped to a hole, a prealloc extent or
the extent map is from an old generation.

Most of the time that is harmless from a functional perspective at
least, however it can result in a deadlock:

1) At defrag_collect_targets() we find an extent map that meets all
   requirements but there's delalloc for the range it covers, and we add
   its range to list of ranges to defrag;

2) The defrag_collect_targets() function is called at defrag_one_range(),
   after it locked a range that overlaps the range of the extent map;

3) At defrag_one_range(), while the range is still locked, we call
   defrag_one_locked_target() for the range associated to the extent
   map we collected at step 1);

4) Then finally at defrag_one_locked_target() we do a call to
   btrfs_delalloc_reserve_space(), which will reserve data and metadata
   space. If the space reservations can not be satisfied right away, the
   flusher might be kicked in and start flushing delalloc and wait for
   the respective ordered extents to complete. If this happens we will
   deadlock, because both flushing delalloc and finishing an ordered
   extent, requires locking the range in the inode's io tree, which was
   already locked at defrag_collect_targets().

So fix this by skipping extent maps for which there's already delalloc.

Fixes: eb793cf857828d ("btrfs: defrag: introduce helper to collect target file extents")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 550d8f2dfa37..0082e9a60bfc 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1211,6 +1211,35 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (em->generation < newer_than)
 			goto next;
 
+		/*
+		 * Our start offset might be in the middle of an existing extent
+		 * map, so take that into account.
+		 */
+		range_len = em->len - (cur - em->start);
+		/*
+		 * If this range of the extent map is already flagged for delalloc,
+		 * skipt it, because:
+		 *
+		 * 1) We could deadlock later, when trying to reserve space for
+		 *    delalloc, because in case we can't immediately reserve space
+		 *    the flusher can start delalloc and wait for the respective
+		 *    ordered extents to complete. The deadlock would happen
+		 *    because we do the space reservation while holding the range
+		 *    locked, and starting writeback, or finishing an ordered
+		 *    extent, requires locking the range;
+		 *
+		 * 2) If there's delalloc there, it means there's dirty pages for
+		 *    which writeback has not started yet (we clean the delalloc
+		 *    flag when starting writeback and after creating an ordered
+		 *    extent). If we mark pages in an adjacent range for defrag,
+		 *    then we will have a larger contiguous range for delalloc,
+		 *    very likely resulting in a larger extent after writeback is
+		 *    triggered (except in a case of free space fragmentation).
+		 */
+		if (test_range_bit(&inode->io_tree, cur, cur + range_len - 1,
+				   EXTENT_DELALLOC, 0, NULL))
+			goto next;
+
 		/*
 		 * For do_compress case, we want to compress all valid file
 		 * extents, thus no @extent_thresh or mergeable check.
@@ -1219,7 +1248,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 			goto add;
 
 		/* Skip too large extent */
-		if (em->len >= extent_thresh)
+		if (range_len >= extent_thresh)
 			goto next;
 
 		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
-- 
2.33.0

