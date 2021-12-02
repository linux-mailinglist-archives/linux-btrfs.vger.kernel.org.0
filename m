Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109F2466176
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 11:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356975AbhLBKeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 05:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356984AbhLBKeL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 05:34:11 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17D2C061756
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 02:30:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E7336CE21E2
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966F4C53FCD
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638441045;
        bh=nMUliZflM3jlUb/Qotz/AL1IPH3zx0ltY0oeCCAt688=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aks64HpN8H9rJK3H2mx3puEclnl3cYwK9EpKt7xDP8JgPyJUOQBFRPvffao9NDMjZ
         SnNJ8BxD/AyM/+hO7XV0u6qGI2PbxMpy/huXl0nYlFbJoc5Ds5gr+rA4xwiMcJAYTL
         2uPj6zjlzDbceLuqQCOrvyngelPAXjhWDvz0LqT8iyG+T74t95SHf72YH415AF9cbW
         45y8/w4LsrIllb0H8ONEGgCGa7H2CFKtvRVGqmuBw7SARUDknzlss//3yvcHf7/AyP
         MnIW/1ntnZpJBjsReymfF73sL11+/wSaAIt21syyaoF/Gmf159Jffeixv/jQ19553f
         aLPMuZ/vlK+Yg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: try to unlock parent nodes earlier when inserting a key
Date:   Thu,  2 Dec 2021 10:30:36 +0000
Message-Id: <6b19d8920fb24d301a43eee0628d7c3789546b30.1638440535.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638440535.git.fdmanana@suse.com>
References: <cover.1638440535.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When inserting a new key, we release the write lock on the leaf's parent
only after doing the binary search on the leaf. This is because if the
key ends up at slot 0, we will have to update the key at slot 0 of the
parent node. The same reasoning applies to any other upper level nodes
when their slot is 0. We also need to keep the parent locked in case the
leaf does not have enough free space to insert the new key/item, because
in that case we will split the leaf and we will need to add a new key to
the parent due to a new leaf resulting from the split operation.

However if the leaf has enough space for the new key and the key does not
end up at slot 0 of the leaf we could release our write lock on the parent
before doing the binary search on the leaf to figure out the destination
slot. That leads to reducing the amount of time other tasks are blocked
waiting to lock the parent, therefore increasing parallelism when there
are other tasks that are trying to access other leaves accessible through
the same parent. This also applies to other upper nodes besides the
immediate parent, when their slot is 0, since we keep locks on them until
we figure out if the leaf slot is slot 0 or not.

In fact, having the key ending at up slot 0 when is rare. Typically it
only happens when the key is less than or equals to the smallest, the
"left most", key of the entire btree, during a split attempt when we try
to push to the right sibling leaf or when the caller just wants to update
the item of an existing key. It's also very common that a leaf has enough
space to insert a new key, since after a split we move about half of the
keys from one into the new leaf.

So unlock the parent, and any other upper level nodes, when during a key
insertion we notice the key is greater then the first key in the leaf and
the leaf has enough free space. After unlocking the upper level nodes, do
the binary search using a low boundary of slot 1 and not slot 0, to figure
out the slot where the key will be inserted (or where the key already is
in case it exists and the caller wants to modify its item data).
This extra comparison, with the first key, is cheap and the key is very
likely already in a cache line because it immediatelly follows the header
of the extent buffer and we have recently read the level field of the
header (which in fact is the last field of the header).

The following fs_mark test was run on a non-debug kernel (debian's default
kernel config), with a 12 cores intel cpu, and using a nvme device:

  $ cat run-fsmark.sh
  #!/bin/bash

  DEV=/dev/nvme0n1
  MNT=/mnt/nvme0n1
  MOUNT_OPTIONS="-o ssd"
  MKFS_OPTIONS="-O no-holes -R free-space-tree"
  FILES=100000
  THREADS=$(nproc --all)
  FILE_SIZE=0

  echo "performance" | \
	tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

  mkfs.btrfs -f $MKFS_OPTIONS $DEV
  mount $MOUNT_OPTIONS $DEV $MNT

  OPTS="-S 0 -L 10 -n $FILES -s $FILE_SIZE -t $THREADS -k"
  for ((i = 1; i <= $THREADS; i++)); do
      OPTS="$OPTS -d $MNT/d$i"
  done

  fs_mark $OPTS

  umount $MNT

Before this change:

FSUse%        Count         Size    Files/sec     App Overhead
     0      1200000            0     165273.6          5958381
     0      2400000            0     190938.3          6284477
     0      3600000            0     181429.1          6044059
     0      4800000            0     173979.2          6223418
     0      6000000            0     139288.0          6384560
     0      7200000            0     163000.4          6520083
     1      8400000            0      57799.2          5388544
     1      9600000            0      66461.6          5552969
     2     10800000            0      49593.5          5163675
     2     12000000            0      57672.1          4889398

After this change:

FSUse%        Count         Size    Files/sec            App Overhead
     0      1200000            0     167987.3 (+1.6%)         6272730
     0      2400000            0     198563.9 (+4.0%)         6048847
     0      3600000            0     197436.6 (+8.8%)         6163637
     0      4800000            0     202880.7 (+16.6%)        6371771
     1      6000000            0     167275.9 (+20.1%)        6556733
     1      7200000            0     204051.2 (+25.2%)        6817091
     1      8400000            0      69622.8 (+20.5%)        5525675
     1      9600000            0      69384.5 (+4.4%)         5700723
     1     10800000            0      61454.1 (+23.9%)        5363754
     3     12000000            0      61908.7 (+7.3%)         5370196

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 137 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 118 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 9329c8a3c855..62066c034363 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1679,6 +1679,27 @@ static int finish_need_commit_sem_search(struct btrfs_path *path)
 	return 0;
 }
 
+static inline int search_for_key_slot(struct extent_buffer *eb,
+				      int search_low_slot,
+				      const struct btrfs_key *key,
+				      int prev_cmp,
+				      int *slot)
+{
+	/*
+	 * If a previous call to btrfs_bin_search() on a parent node returned an
+	 * exact match (prev_cmp == 0), we can safely assume the target key will
+	 * always be at slot 0 on lower levels, since each key pointer
+	 * (struct btrfs_key_ptr) refers to the lowest key acessible from the
+	 * subtree it points to. Thus we can skip searching lower levels.
+	 */
+	if (prev_cmp == 0) {
+		*slot = 0;
+		return 0;
+	}
+
+	return generic_bin_search(eb, search_low_slot, key, slot);
+}
+
 /*
  * btrfs_search_slot - look for a key in a tree and perform necessary
  * modifications to preserve tree invariants.
@@ -1839,25 +1860,98 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			}
 		}
 
-		/*
-		 * If btrfs_bin_search returns an exact match (prev_cmp == 0)
-		 * we can safely assume the target key will always be in slot 0
-		 * on lower levels due to the invariants BTRFS' btree provides,
-		 * namely that a btrfs_key_ptr entry always points to the
-		 * lowest key in the child node, thus we can skip searching
-		 * lower levels
-		 */
-		if (prev_cmp == 0) {
-			slot = 0;
-			ret = 0;
-		} else {
-			ret = btrfs_bin_search(b, key, &slot);
-			prev_cmp = ret;
+		if (level == 0) {
+			int leaf_free_space = 0;
+			int search_low_slot = 0;
+
+			/*
+			 * If we are doing an insertion, the leaf has enough free
+			 * space and the destination slot for the key is not slot
+			 * 0, then we can unlock our write lock on the parent, and
+			 * any other upper nodes, before doing the binary search
+			 * on the leaf (with search_for_key_slot()), allowing other
+			 * tasks to lock the parent and any other upper nodes.
+			 */
+			if (ins_len > 0) {
+				struct btrfs_disk_key first_key;
+
+				/*
+				 * Cache the leaf free space, since we will need it
+				 * later and it will not change until then.
+				 */
+				leaf_free_space = btrfs_leaf_free_space(b);
+
+				/*
+				 * !p->locks[1] means we have a single node tree,
+				 * the leaf is the root of the tree.
+				 */
+				if (!p->locks[1] || leaf_free_space < ins_len)
+					goto leaf_search;
+
+				ASSERT(btrfs_header_nritems(b) > 0);
+				btrfs_item_key(b, &first_key, 0);
+
+				/*
+				 * Doing the extra comparison with the first key
+				 * is cheap, taking into account that the first
+				 * key is very likely already in a cache line
+				 * because it immediattely follows the extent
+				 * buffer's header and we have recently accessed
+				 * the header's level field.
+				 */
+				ret = comp_keys(&first_key, key);
+				if (ret < 0) {
+					/*
+					 * The first key is smaller than the key
+					 * we want to insert, so we are safe to
+					 * unlock all upper nodes and we have to
+					 * do the binary search.
+					 *
+					 * We do use btrfs_unlock_up_safe() and
+					 * not unlock_up() because the later does
+					 * not unlock nodes with a slot of 0.
+					 * We can safely unlock any node even if
+					 * its slot is 0 since in this case the
+					 * key does not end up at slot 0 of the
+					 * leaf and there's also no need to split
+					 * the leaf.
+					 */
+					btrfs_unlock_up_safe(p, 1);
+					search_low_slot = 1;
+				} else {
+					/*
+					 * The first key is >= then the key we
+					 * want to insert, so we can skip the
+					 * binary search as the target key will
+					 * be at slot 0.
+					 *
+					 * We can not unlock upper nodes when
+					 * the key is less than the first key,
+					 * because we will need to update the key
+					 * at slot 0 of the parent node and
+					 * possibly of other upper nodes too.
+					 * If the key matches the first key, then
+					 * we can unlock all the upper nodes,
+					 * using btrfs_unlock_up_safe() instead
+					 * of unlock_up() as stated above.
+					 */
+					if (ret == 0)
+						btrfs_unlock_up_safe(p, 1);
+					slot = 0;
+					/*
+					 * ret is already 0 or 1, matching the
+					 * result of a btrfs_bin_search() call,
+					 * so there is no need to adjust it.
+					 */
+					goto skip_leaf_search;
+				}
+			}
+leaf_search:
+			ret = search_for_key_slot(b, search_low_slot, key,
+						  prev_cmp, &slot);
 			if (ret < 0)
 				goto done;
-		}
-
-		if (level == 0) {
+skip_leaf_search:
 			p->slots[level] = slot;
 			/*
 			 * Item key already exists. In this case, if we are
@@ -1873,8 +1967,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				ASSERT(ins_len >= sizeof(struct btrfs_item));
 				ins_len -= sizeof(struct btrfs_item);
 			}
-			if (ins_len > 0 &&
-			    btrfs_leaf_free_space(b) < ins_len) {
+			if (ins_len > 0 && leaf_free_space < ins_len) {
 				if (write_lock_level < 1) {
 					write_lock_level = 1;
 					btrfs_release_path(p);
@@ -1895,6 +1988,12 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 					  min_write_lock_level, NULL);
 			goto done;
 		}
+
+		ret = search_for_key_slot(b, 0, key, prev_cmp, &slot);
+		if (ret < 0)
+			goto done;
+		prev_cmp = ret;
+
 		if (ret && slot > 0) {
 			dec = 1;
 			slot--;
-- 
2.33.0

