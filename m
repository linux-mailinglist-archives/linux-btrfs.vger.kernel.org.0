Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCAD1E3EB1
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgE0KK6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:10:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:60608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgE0KK6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:10:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49C4AAB5C;
        Wed, 27 May 2020 10:10:59 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Open code key_search
Date:   Wed, 27 May 2020 13:10:53 +0300
Message-Id: <20200527101053.7340-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function wraps the optimisation implemented by d7396f07358a,
however this optimisation is really used in only one place -
btrfs_search_slot. Just open code the optimisation and also add a
comment explaining how it works since it's not clear just by looking
at the code - the key point here is it depends on an internal invariant
that BTRFS' btree provides, namely intermediate pointers always contain
the key at slot0 at the child node. So in the case of exact match we
can safely assume that the given key will always be in slot 0 on lower
levels.

Furthermore this results in a reduction of btrfs_search_slot's size:

./scripts/bloat-o-meter ctree.orig fs/btrfs/ctree.o
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-75 (-75)
Function                                     old     new   delta
btrfs_search_slot                           2783    2708     -75
Total: Before=50423, After=50348, chg -0.15%

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 92775554d1cc..3ab307b4b294 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2488,19 +2488,6 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
 	return ret;
 }

-static int key_search(struct extent_buffer *b, const struct btrfs_key *key,
-		      int *prev_cmp, int *slot)
-{
-	if (*prev_cmp != 0) {
-		*prev_cmp = btrfs_bin_search(b, key, slot);
-		return *prev_cmp;
-	}
-
-	*slot = 0;
-
-	return 0;
-}
-
 int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path *path,
 		u64 iobjectid, u64 ioff, u8 key_type,
 		struct btrfs_key *found_key)
@@ -2770,9 +2757,23 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			}
 		}

-		ret = key_search(b, key, &prev_cmp, &slot);
-		if (ret < 0)
-			goto done;
+		/*
+		 * If btrfs_bin_search returns an exact match (prev_cmp == 0)
+		 * we can safely assume the target key will always be in
+		 * slot 0 on lower levels due to the invariants BTRFS' btree
+		 * provides, namely that a btrfs_key_ptr entry always points
+		 * to the lowest key in the child node, thus we can skip
+		 * searching lower levels
+		 */
+		if (prev_cmp == 0) {
+			slot = 0;
+			ret = 0;
+		} else {
+			ret = btrfs_bin_search(b, key, &slot);
+			prev_cmp = ret;
+			if (ret < 0)
+				goto done;
+		}

 		if (level == 0) {
 			p->slots[level] = slot;
@@ -2896,7 +2897,6 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 	int level;
 	int lowest_unlock = 1;
 	u8 lowest_level = 0;
-	int prev_cmp = -1;

 	lowest_level = p->lowest_level;
 	WARN_ON(p->nodes[0] != NULL);
@@ -2929,12 +2929,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 		 */
 		btrfs_unlock_up_safe(p, level + 1);

-		/*
-		 * Since we can unwind ebs we want to do a real search every
-		 * time.
-		 */
-		prev_cmp = -1;
-		ret = key_search(b, key, &prev_cmp, &slot);
+		ret = btrfs_bin_search(b, key, &slot);
 		if (ret < 0)
 			goto done;

--
2.17.1

