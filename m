Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBC4D12F66C
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2020 10:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgACJx3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jan 2020 04:53:29 -0500
Received: from mail.synology.com ([211.23.38.101]:50548 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725972AbgACJx3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Jan 2020 04:53:29 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jan 2020 04:53:27 EST
From:   ethanwu <ethanwu@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1578044739; bh=DbfJeGGDGsoT0KBsrih4KPc3KNaPV92btTy+pgwq5Fk=;
        h=From:To:Cc:Subject:Date;
        b=eYHlGcw6pH9G/cv7cR2DlGPnWbdLcRcnKJtQQT85JbnBUOannRklSeijPc6qfiu8Q
         K2DJlqOWIv17w9Ryu8pAp//Wr7pw9hhgnIpNX2ddZEIV+ucj2JqaB6l0+6duZqeaPk
         n66FhYeT3RAL5OPqrTVBHuj/B+OBOzHaeuNhoYQ8=
To:     linux-btrfs@vger.kernel.org
Cc:     ethanwu <ethanwu@synology.com>
Subject: [PATCH] btrfs: add extra ending condition for indirect data backref resolution
Date:   Fri,  3 Jan 2020 17:44:41 +0800
Message-Id: <1578044681-25562-1-git-send-email-ethanwu@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs has two types of data backref.
For BTRFS_EXTENT_DATA_REF_KEY type of backref, we don't have the
exact block number. Therefore, we need to call resolve_indirect_refs
which uses btrfs_search_slot to locate the leaf block. After that,
we need to walk through the leafs to search for the EXTENT_DATA items
that have disk bytenr matching the extent item(add_all_parents).

The only conditions we'll stop searching are
1. We find different object id or type is not EXTENT_DATA
2. We've already got all the refs we want(total_refs)

Take the following EXTENT_ITEM as example:
item 11 key (40831553536 EXTENT_ITEM 4194304) itemoff 15460 itemsize 95
    extent refs 24 gen 7302 flags DATA
    extent data backref root 257 objectid 260 offset 65536 count 5 #backref entry 1
    extent data backref root 258 objectid 265 offset 0 count 9 #backref entry 2
    shared data backref parent 394985472 count 10 #backref entry 3

If we want to search for backref entry 1, total_refs here would be 24 rather
than its count 5.

The reason to use 24 is because some EXTENT_DATA in backref entry 3 block
394985472 also points to EXTENT_ITEM 40831553536, if this block also belongs to
root 257 and lies between these 5 items of backref entry 1,
and we use total_refs = 5, we'll end up missing some refs from backref
entry 1.

But using total_refs=24 is not accurate. We'll never find extent data keys in
backref entry 2, since we searched root 257 not 258. We'll never reach block
394985472 either if this block is not a leaf in root 257.
As a result, the loop keeps on going until we reach the end of that inode.

Since we're searching for parent block of this backref entry 1,
we're 100% sure we'll never find any EXTENT_DATA beyond (65536 + 4194304) that
matching this entry. If there's any EXTENT_DATA with offset beyond this range
using this extent item, its backref must be stored at different backref entry.
That EXTENT_DATA will be handled when we process that backref entry.

Fix this by breaking from loop if we reach offset + (size of EXTENT_ITEM).

btrfs send use backref to search for clone candidate.
Without this patch, performance drops when running following script.
This script creates a 10G file with all of its extent size 64K.
Then it generates shared backref for each data extent, and
those backrefs could not be found when doing btrfs_resolve_indirect_refs.

item 87 key (11843469312 EXTENT_ITEM 65536) itemoff 10475 itemsize 66
    refs 3 gen 74 flags DATA
    extent data backref root 256 objectid 260 offset 10289152 count 2
    # This shared backref couldn't be found when resolving
    # indirect ref from snapshot of sub 256
    shared data backref parent 2303049728 count 1

btrfs subvolume create /volume1/sub1
for i in `seq 1 163840`; do dd if=/dev/zero of=/volume1/sub1/file bs=64K count=1 seek=$((i-1)) conv=notrunc oflag=direct 2>/dev/null; done
btrfs subvolume snapshot /volume1/sub1 /volume1/sub2
for i in `seq 1 163840`; do dd if=/dev/zero of=/volume1/sub1/file bs=4K count=1 seek=$(((i-1)*16+10)) conv=notrunc oflag=direct 2>/dev/null; done
btrfs subvolume snapshot -r /volume1/sub1 /volume1/snap1
time btrfs send /volume1/snap1 | btrfs receive /volume2

without this patch
real 69m48.124s
user 0m50.199s
sys  70m15.600s

with this patch
real 1m31.498s
user 0m35.858s
sys  2m55.544s

Signed-off-by: ethanwu <ethanwu@synology.com>
---
 fs/btrfs/backref.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e5d8531..ae64995 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -412,7 +412,7 @@ static int add_indirect_ref(const struct btrfs_fs_info *fs_info,
 static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 			   struct ulist *parents, struct prelim_ref *ref,
 			   int level, u64 time_seq, const u64 *extent_item_pos,
-			   u64 total_refs, bool ignore_offset)
+			   u64 total_refs, bool ignore_offset, u64 num_bytes)
 {
 	int ret = 0;
 	int slot;
@@ -458,6 +458,9 @@ static int add_all_parents(struct btrfs_root *root, struct btrfs_path *path,
 		fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
 		disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
 
+		if (key_for_search->type == BTRFS_EXTENT_DATA_KEY &&
+		    key.offset >= key_for_search->offset + num_bytes)
+		       break;
 		if (disk_byte == wanted_disk_byte) {
 			eie = NULL;
 			old = NULL;
@@ -504,7 +507,7 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path, u64 time_seq,
 				struct prelim_ref *ref, struct ulist *parents,
 				const u64 *extent_item_pos, u64 total_refs,
-				bool ignore_offset)
+				bool ignore_offset, u64 num_bytes)
 {
 	struct btrfs_root *root;
 	struct btrfs_key root_key;
@@ -575,7 +578,8 @@ static int resolve_indirect_ref(struct btrfs_fs_info *fs_info,
 	}
 
 	ret = add_all_parents(root, path, parents, ref, level, time_seq,
-			      extent_item_pos, total_refs, ignore_offset);
+			      extent_item_pos, total_refs, ignore_offset,
+			      num_bytes);
 out:
 	path->lowest_level = 0;
 	btrfs_release_path(path);
@@ -610,7 +614,8 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 				 struct btrfs_path *path, u64 time_seq,
 				 struct preftrees *preftrees,
 				 const u64 *extent_item_pos, u64 total_refs,
-				 struct share_check *sc, bool ignore_offset)
+				 struct share_check *sc, bool ignore_offset,
+				 u64 num_bytes)
 {
 	int err;
 	int ret = 0;
@@ -655,7 +660,7 @@ static int resolve_indirect_refs(struct btrfs_fs_info *fs_info,
 		}
 		err = resolve_indirect_ref(fs_info, path, time_seq, ref,
 					   parents, extent_item_pos,
-					   total_refs, ignore_offset);
+					   total_refs, ignore_offset, num_bytes);
 		/*
 		 * we can only tolerate ENOENT,otherwise,we should catch error
 		 * and return directly.
@@ -1127,6 +1132,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	struct extent_inode_elem *eie = NULL;
 	/* total of both direct AND indirect refs! */
 	u64 total_refs = 0;
+	u64 num_bytes = SZ_256M;
 	struct preftrees preftrees = {
 		.direct = PREFTREE_INIT,
 		.indirect = PREFTREE_INIT,
@@ -1194,6 +1200,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 				goto again;
 			}
 			spin_unlock(&delayed_refs->lock);
+			num_bytes = head->num_bytes;
 			ret = add_delayed_refs(fs_info, head, time_seq,
 					       &preftrees, &total_refs, sc);
 			mutex_unlock(&head->mutex);
@@ -1215,6 +1222,7 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 		if (key.objectid == bytenr &&
 		    (key.type == BTRFS_EXTENT_ITEM_KEY ||
 		     key.type == BTRFS_METADATA_ITEM_KEY)) {
+			num_bytes = key.offset;
 			ret = add_inline_refs(fs_info, path, bytenr,
 					      &info_level, &preftrees,
 					      &total_refs, sc);
@@ -1236,7 +1244,8 @@ static int find_parent_nodes(struct btrfs_trans_handle *trans,
 	WARN_ON(!RB_EMPTY_ROOT(&preftrees.indirect_missing_keys.root.rb_root));
 
 	ret = resolve_indirect_refs(fs_info, path, time_seq, &preftrees,
-				    extent_item_pos, total_refs, sc, ignore_offset);
+				    extent_item_pos, total_refs, sc, ignore_offset,
+				    num_bytes);
 	if (ret)
 		goto out;
 
-- 
1.9.1

