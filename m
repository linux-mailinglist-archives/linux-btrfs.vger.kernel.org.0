Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52FE515A0A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 06:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgBLFau (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 00:30:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:52300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgBLFat (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 00:30:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86EF5AC65
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 05:30:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Only require sector size alignment for parent eb bytenr
Date:   Wed, 12 Feb 2020 13:30:40 +0800
Message-Id: <20200212053040.23221-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
A completely sane converted fs will cause kernel warning at balance
time:

[ 1557.188633] BTRFS info (device sda7): relocating block group 8162107392 flags data
[ 1563.358078] BTRFS info (device sda7): found 11722 extents
[ 1563.358277] BTRFS info (device sda7): leaf 7989321728 gen 95 total ptrs 213 free space 3458 owner 2
[ 1563.358280] 	item 0 key (7984947200 169 0) itemoff 16250 itemsize 33
[ 1563.358281] 		extent refs 1 gen 90 flags 2
[ 1563.358282] 		ref#0: tree block backref root 4
[ 1563.358285] 	item 1 key (7985602560 169 0) itemoff 16217 itemsize 33
[ 1563.358286] 		extent refs 1 gen 93 flags 258
[ 1563.358287] 		ref#0: shared block backref parent 7985602560
[ 1563.358288] 			(parent 7985602560 is NOT ALIGNED to nodesize 16384)
[ 1563.358290] 	item 2 key (7985635328 169 0) itemoff 16184 itemsize 33
...
[ 1563.358995] BTRFS error (device sda7): eb 7989321728 invalid extent inline ref type 182
[ 1563.358996] ------------[ cut here ]------------
[ 1563.359005] WARNING: CPU: 14 PID: 2930 at 0xffffffff9f231766

Then with transaction abort, and obviously failed to balance the fs.

[CAUSE]
That mentioned inline ref type 182 is completely sane, it's
BTRFS_SHARED_BLOCK_REF_KEY, it's some extra check making kernel to
believe it's invalid.

Commit 64ecdb647ddb ("Btrfs: add one more sanity check for shared ref
type") introduced extra checks for backref type.

One of the requirement is, parent bytenr must be aligned to node size,
which is not correct, especially for converted fs or mixed fs.

One tree block can start at any bytenr aligned to sector size. Node size
should never be an alignment requirement.
Thus such bad check is causing above bug.

[FIX]
Change the alignment requirement from node size alignment to sector size
alignment.

Also, to make our lives a little easier, also output @iref when
btrfs_get_extent_inline_ref_type() failed, so we can locate the item
easier.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=205475
Fixes: 64ecdb647ddb ("Btrfs: add one more sanity check for shared ref type")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c | 13 +++++++------
 fs/btrfs/print-tree.c  | 12 +++++++-----
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0163fdd59f8f..5caec0e9c49a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -405,10 +405,10 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				/*
 				 * Every shared one has parent tree
 				 * block, which must be aligned to
-				 * nodesize.
+				 * sector size.
 				 */
 				if (offset &&
-				    IS_ALIGNED(offset, eb->fs_info->nodesize))
+				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
 					return type;
 			}
 		} else if (is_data == BTRFS_REF_TYPE_DATA) {
@@ -419,10 +419,10 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				/*
 				 * Every shared one has parent tree
 				 * block, which must be aligned to
-				 * nodesize.
+				 * sector size.
 				 */
 				if (offset &&
-				    IS_ALIGNED(offset, eb->fs_info->nodesize))
+				    IS_ALIGNED(offset, eb->fs_info->sectorsize))
 					return type;
 			}
 		} else {
@@ -432,8 +432,9 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 	}
 
 	btrfs_print_leaf((struct extent_buffer *)eb);
-	btrfs_err(eb->fs_info, "eb %llu invalid extent inline ref type %d",
-		  eb->start, type);
+	btrfs_err(eb->fs_info,
+		  "eb %llu iref 0x%lu invalid extent inline ref type %d",
+		  eb->start, (unsigned long)iref, type);
 	WARN_ON(1);
 
 	return BTRFS_REF_TYPE_INVALID;
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 61f44e78e3c9..68138e14f039 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -95,9 +95,10 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
 			 * offset is supposed to be a tree block which
 			 * must be aligned to nodesize.
 			 */
-			if (!IS_ALIGNED(offset, eb->fs_info->nodesize))
-				pr_info("\t\t\t(parent %llu is NOT ALIGNED to nodesize %llu)\n",
-					offset, (unsigned long long)eb->fs_info->nodesize);
+			if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
+				pr_info(
+		"\t\t\t(parent %llu is NOT ALIGNED to sectorsize %u)\n",
+					offset, eb->fs_info->sectorsize);
 			break;
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
@@ -112,8 +113,9 @@ static void print_extent_item(struct extent_buffer *eb, int slot, int type)
 			 * must be aligned to nodesize.
 			 */
 			if (!IS_ALIGNED(offset, eb->fs_info->nodesize))
-				pr_info("\t\t\t(parent %llu is NOT ALIGNED to nodesize %llu)\n",
-				     offset, (unsigned long long)eb->fs_info->nodesize);
+				pr_info(
+		"\t\t\t(parent %llu is NOT ALIGNED to sectorsize %u)\n",
+				     offset, eb->fs_info->sectorsize);
 			break;
 		default:
 			pr_cont("(extent %llu has INVALID ref type %d)\n",
-- 
2.25.0

