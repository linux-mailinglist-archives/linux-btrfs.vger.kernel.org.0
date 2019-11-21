Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C7710520A
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 13:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKUMDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 07:03:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:52390 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbfKUMDi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 07:03:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D412AFD4;
        Thu, 21 Nov 2019 12:03:37 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Don't discard unwritten extents
Date:   Thu, 21 Nov 2019 14:03:29 +0200
Message-Id: <20191121120331.29070-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121120331.29070-1-nborisov@suse.com>
References: <20191121120331.29070-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All callers of btrfs_free_reserved_extent (respectively
__btrfs_free_reserved_extent with in set to 0) pass in extents which
have only been reserved but not yet written to. Namely,

* In cow_file_range that function is called only if create_io_em fails or
btrfs_add_ordered_extent fail, both of which happen _before_ any IO is
submitted to the newly reserved range.

* In submit_compressed_extents the code flow is similar - out_free_reserve
can be called only before btrfs_submit_compressed_write which is where
any writes to the range could occur.

* btrfs_new_extent_direct also calls btrfs_free_reserved_extent only
if extent_map fails, before any IO is issued.

* __btrfs_prealloc_file_range also calls btrfs_free_reserved_extent
in case insertion of the metadata fails.

* btrfs_alloc_tree_block again can only be called in case in-memory
operations fail, before any IO is submitted.

* btrfs_finish_ordered_io - this is the only caller where discarding
the extent could have a material effect, since it can be called for
an extent which was partially written.

With this change the submission of discards is optimised since discards
are now not being created for extents which are known to not have been
touched on disk.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 2 --
 fs/btrfs/inode.c       | 7 ++++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fe0f33dd344d..613c7bbf5cbd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4169,8 +4169,6 @@ static int __btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
 		if (ret)
 			goto out;
 	} else {
-		if (btrfs_test_opt(fs_info, DISCARD))
-			ret = btrfs_discard_extent(fs_info, start, len, NULL);
 		btrfs_add_free_space(cache, start, len);
 		btrfs_free_reserved_bytes(cache, len, delalloc);
 		trace_btrfs_reserved_extent_free(fs_info, start, len);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0ac0f5b33003..5d80fe030e79 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3250,10 +3250,15 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		if ((ret || !logical_len) &&
 		    clear_reserved_extent &&
 		    !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags) &&
-		    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags))
+		    !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
 			btrfs_free_reserved_extent(fs_info,
 						   ordered_extent->start,
 						   ordered_extent->disk_len, 1);
+			if (ret && btrfs_test_opt(fs_info, DISCARD))
+				btrfs_discard_extent(fs_info,
+				ordered_extent->start, ordered_extent->disk_len,
+				NULL);
+		}
 	}
 
 
-- 
2.17.1

