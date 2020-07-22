Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E71229769
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgGVL2r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 07:28:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbgGVL2q (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 07:28:46 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7773320771
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jul 2020 11:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595417325;
        bh=UnPgDnAiOTkBEk8q3IuY1ljE9xYmfrXAbtiy8viQvJA=;
        h=From:To:Subject:Date:From;
        b=gp2Pf7+PiBNQ9+gY3cMyQEs5/YGdu3dCtSefYGClDQVPm8rY+XckSw2cY3nm/h5sO
         NusZAG7xsxcB04OaolXGc0xQFQoevkqWyagwPXeACRZffn+b9n+V83EJBgWYoOA5oH
         uaHbORPISrhL77Mq/2ArgQderrET00eGXstWx8II=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: fix race between page release and a fast fsync
Date:   Wed, 22 Jul 2020 12:28:37 +0100
Message-Id: <20200722112837.15516-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When releasing an extent map, done through the page release callback, we
can race with an ongoing fast fsync and cause the fsync to miss a new
extent and not log it. The steps for this to happen are the following:

1) A page is dirtied for some inode I;

2) Writeback for that page is triggered by a path other than fsync, for
   example by the system due to memory pressure;

3) When the ordered extent for the extent (a single 4K page) finishes,
   we unpin the corresponding extent map and set its generation to N,
   the current transaction's generation;

4) The btrfs_releasepage() callback is invoked by the system due to
   memory pressure for that no longer dirty page of inode I;

5) At the same time, some task calls fsync on inode I, joins transaction
   N, and at btrfs_log_inode() it sees that the inode does not have the
   full sync flag set, so we proceed with a fast fsync. But before we get
   into btrfs_log_changed_extents() and lock the inode's extent map tree:

6) Through btrfs_releasepage() we end up at try_release_extent_mapping()
   and we remove the extent map for the new 4Kb extent, because it is
   neither pinned anymore nor locked. By calling remove_extent_mapping(),
   we remove the extent map from the list of modified extents, since the
   extent map does not have the logging flag set. We unlock the inode's
   extent map tree;

7) The task doing the fast fsync now enters btrfs_log_changed_extents(),
   locks the inode's extent map tree and iterates its list of modified
   extents, which no longer has the 4Kb extent in it, so it does not log
   the extent;

8) The fsync finishes;

9) Before transaction N is committed, a power failure happens. After
   replaying the log, the 4K extent of inode I will be missing, since
   it was not logged due to the race with try_release_extent_mapping().

So fix this by teaching try_release_extent_mapping() to not remove an
extent map if it's still in the list of modified extents.

Fixes: ff44c6e36dc9dc ("Btrfs: do not hold the write_lock on the extent tree while logging")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8a7e9da74b87..57f85d451695 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4500,15 +4500,25 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 				free_extent_map(em);
 				break;
 			}
-			if (!test_range_bit(tree, em->start,
-					    extent_map_end(em) - 1,
-					    EXTENT_LOCKED, 0, NULL)) {
+			if (test_range_bit(tree, em->start,
+					   extent_map_end(em) - 1,
+					   EXTENT_LOCKED, 0, NULL))
+				goto next;
+			/*
+			 * If it's not in the list of modified extents, used
+			 * by a fast fsync, we can remove it. If it's being
+			 * logged we can safely remove it since fsync took an
+			 * extra reference on the em.
+			 */
+			if (list_empty(&em->list) ||
+			    test_bit(EXTENT_FLAG_LOGGING, &em->flags)) {
 				set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
 					&btrfs_inode->runtime_flags);
 				remove_extent_mapping(map, em);
 				/* once for the rb tree */
 				free_extent_map(em);
 			}
+next:
 			start = extent_map_end(em);
 			write_unlock(&map->lock);
 
-- 
2.26.2

