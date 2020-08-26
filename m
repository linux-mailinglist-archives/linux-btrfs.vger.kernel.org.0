Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B652C2529F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 11:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgHZJ0w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Aug 2020 05:26:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:48960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgHZJ0t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08E64AD39
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 09:27:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: Only require sector size alignment for parent eb bytenr
Date:   Wed, 26 Aug 2020 17:26:43 +0800
Message-Id: <20200826092643.113881-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
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
which is not correct.

One example is like this:

0	1G  1G+4K		2G 2G+4K
	|   |///////////////////|//|  <- A chunk starts at 1G+4K
            |   |	<- A tree block get reserved at bytenr 1G+4K

Then we have a valid tree block at bytenr 1G+4K, but not aligned to
nodesize (16K).

Such chunk is not ideal, but current kernel can handle it pretty well.
We may warn about such tree block in the future, but not reject them.

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
Changelog:
v2:
- Make the commit message more clear on how such case is caused
  The only reason is converted fs, which could create chunk starts at
  sector aligned only bytenr.
---
 fs/btrfs/extent-tree.c | 13 +++++++------
 fs/btrfs/print-tree.c  | 12 +++++++-----
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 73973e6e8ba6..068755468472 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -402,10 +402,10 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
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
@@ -416,10 +416,10 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
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
@@ -429,8 +429,9 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
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
2.28.0

