Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AFE33D9E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 17:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhCPQyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 12:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234702AbhCPQyP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 12:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C950765090
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615913655;
        bh=wGsLN4jbqvML2U9zaNYjW8aifQI71xSOP66LVRNgv2U=;
        h=From:To:Subject:Date:From;
        b=rCDoNMJ7L077wT08oWTwzVRhM37M1oJxUZCuJem6UYc7BS39tdG3Vwdn0ku1HY7o2
         qQS6UwoJgnNwhT/zp/TXDPDmlvh59FTVlfbSo5eV8dglhe+byKE2qZrHqDzsU6iCMV
         mhAZh5P/XuEB5WBqVYklWwKO9g85qB4KTAC6qHIb7zgs9dpw2NjICBVNa09+f4xBja
         D8Ix80R/+C1FW0Bpa2qxw3whp5a9durZ+KlNV11IZbI2dRgL6D+E5IIPg1lrOycUYC
         zJtOjvV8YZp07lCro5UB7+sMz0Ek9lMruD0jyMf2lTiP4o6PAZ1oGE/lQ8HdIXXUt8
         b0Ke9SX5AHalA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: update outdated comment at btrfs_orphan_cleanup()
Date:   Tue, 16 Mar 2021 16:54:13 +0000
Message-Id: <deaf0ddafcd9327079b0af3130d398e8ec421e5a.1615912483.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

btrfs_orphan_cleanup() has a comment referring to find_dead_roots, but
function does not exists since commit cb517eabba4f10 ("Btrfs: cleanup the
similar code of the fs root read"). What we use now to find and load dead
roots is btrfs_find_orphan_roots(). So update the comment and make it a
bit more detailed about why we can not delete an orphan item for a root.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ddbac78c4abe..31717ef76a90 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3383,15 +3383,19 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 			int is_dead_root = 0;
 
 			/*
-			 * this is an orphan in the tree root. Currently these
+			 * This is an orphan in the tree root. Currently these
 			 * could come from 2 sources:
-			 *  a) a snapshot deletion in progress
+			 *  a) a root (snapshot/subvolume) deletion in progress
 			 *  b) a free space cache inode
-			 * We need to distinguish those two, as the snapshot
-			 * orphan must not get deleted.
-			 * find_dead_roots already ran before us, so if this
-			 * is a snapshot deletion, we should find the root
-			 * in the fs_roots radix tree.
+			 * We need to distinguish those two, as the orphan item
+			 * for a root must not get deleted before the deletion
+			 * of the snapshot/subvolume's tree completes.
+			 *
+			 * btrfs_find_orphan_roots() ran before us, which has
+			 * found all deleted roots and loaded them into
+			 * fs_info->fs_roots_radix. So here we can find if an
+			 * orphan item corresponds to a deleted root by looking
+			 * up the root from that radix tree.
 			 */
 
 			spin_lock(&fs_info->fs_roots_radix_lock);
-- 
2.28.0

