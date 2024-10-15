Return-Path: <linux-btrfs+bounces-8926-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D2599DF6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 09:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0D61C21009
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157F18BC21;
	Tue, 15 Oct 2024 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="q6Rl19xF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59179474
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2024 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978110; cv=none; b=HBtriocLW4xBrPicsINuHqHD1frjQbfKgEkNobxH1uZsfA8KfOX7uHbA/6N8XCX+I+t6yohMrHoLsepE71At/kYnW9z6RfinMgm3EhGbk0wJqT8cg8J1D7ZIczCHAH9/gJu5l12tWkzsDaviDArVDa2QJdd3CDciuI/w+80YfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978110; c=relaxed/simple;
	bh=34BHm7U4DyFhFgZoFXbjh6jlKSq2OBQF3dZ8mlKqB6U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FeaEx8gFuTdKGP1UAtcy7t8sQNlQIRZpCdxAK/H6iV+Bi86ulR/PqtKbUOoCYgqweX2Z6SbR4rtHLwUYNvIWG5MMqDoXTeHP7Phy9MKRhjYP9exEQs53MmcaLbc1nWNMFspfKraldkJO9HL11CWWBYaVbYSyxy3HKu5YYCV7pNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=q6Rl19xF; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1728978101; bh=34BHm7U4DyFhFgZoFXbjh6jlKSq2OBQF3dZ8mlKqB6U=;
	h=From:To:Cc:Subject:Date;
	b=q6Rl19xFtCNTSLRxs+VrRr8J7txYiS8J3YjCtCGLeDCN+dwuVwpYrAGmOjAh5a1PJ
	 TadZ3lhc8X4nHTWuBUa6eEClbX8zicuKePh4Y+UBz+/SBjskb1bc56npSsvQuvwxyS
	 NpnDAAGOogGgvg8qK6UMqpcPISNEt6xY0WzB214g=
To: linux-btrfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH v3] btrfs: reduce lock contention when eb cache miss for btree search
Date: Tue, 15 Oct 2024 15:41:37 +0800
Message-Id: <20241015074137.26067-1-robbieko@synology.com>
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

From: Robbie Ko <robbieko@synology.com>

When crawling btree, if an eb cache miss occurs, we change to use
the eb read lock and release all previous locks (include parent lock)
to reduce lock contention.

If a eb cache miss occurs in a leaf and needs to execute IO, before
this change we released locks only from level 2 and up and we
read a leaf's content from disk while holding a lock on its parent
(level 1), causing the unnecessary lock contention on the parent,
after this change we release locks from level 1 and up, but we lock
level 0, and read leaf's content from disk.

Because we have prepared the check parameters and the read lock
of eb we hold, we can ensure that no race will occur during the check
and cause unexpected errors.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
v3: Improve the change log, and change variable named
v2: Add skip_locking handle
 fs/btrfs/ctree.c | 101 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0cc919d15b14..dc1d4e05214a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1515,12 +1515,14 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	struct btrfs_tree_parent_check check = { 0 };
 	u64 blocknr;
 	u64 gen;
-	struct extent_buffer *tmp;
-	int ret;
+	struct extent_buffer *tmp = NULL;
+	int ret = 0;
 	int parent_level;
-	bool unlock_up;
+	int err;
+	bool read_tmp = false;
+	bool tmp_locked = false;
+	bool path_released = false;
 
-	unlock_up = ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]);
 	blocknr = btrfs_node_blockptr(*eb_ret, slot);
 	gen = btrfs_node_ptr_generation(*eb_ret, slot);
 	parent_level = btrfs_header_level(*eb_ret);
@@ -1551,68 +1553,105 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			 */
 			if (btrfs_verify_level_key(tmp,
 					parent_level - 1, &check.first_key, gen)) {
-				free_extent_buffer(tmp);
-				return -EUCLEAN;
+				ret = -EUCLEAN;
+				goto out;
 			}
 			*eb_ret = tmp;
-			return 0;
+			tmp = NULL;
+			ret = 0;
+			goto out;
 		}
 
 		if (p->nowait) {
-			free_extent_buffer(tmp);
-			return -EAGAIN;
+			ret = -EAGAIN;
+			goto out;
 		}
 
-		if (unlock_up)
+		if (!p->skip_locking) {
 			btrfs_unlock_up_safe(p, level + 1);
-
-		/* now we're allowed to do a blocking uptodate check */
-		ret = btrfs_read_extent_buffer(tmp, &check);
-		if (ret) {
-			free_extent_buffer(tmp);
+			tmp_locked = true;
+			btrfs_tree_read_lock(tmp);
 			btrfs_release_path(p);
-			return ret;
+			ret = -EAGAIN;
+			path_released = true;
 		}
 
-		if (unlock_up)
-			ret = -EAGAIN;
+		/* Now we're allowed to do a blocking uptodate check. */
+		err = btrfs_read_extent_buffer(tmp, &check);
+		if (err) {
+			ret = err;
+			goto out;
+		}
 
+		if (ret == 0) {
+			ASSERT(!tmp_locked);
+			*eb_ret = tmp;
+			tmp = NULL;
+		}
 		goto out;
 	} else if (p->nowait) {
-		return -EAGAIN;
+		ret = -EAGAIN;
+		goto out;
 	}
 
-	if (unlock_up) {
+	if (!p->skip_locking) {
 		btrfs_unlock_up_safe(p, level + 1);
 		ret = -EAGAIN;
-	} else {
-		ret = 0;
 	}
 
 	if (p->reada != READA_NONE)
 		reada_for_search(fs_info, p, level, slot, key->objectid);
 
-	tmp = read_tree_block(fs_info, blocknr, &check);
+	tmp = btrfs_find_create_tree_block(fs_info, blocknr, check.owner_root, check.level);
 	if (IS_ERR(tmp)) {
+		ret = PTR_ERR(tmp);
+		tmp = NULL;
+		goto out;
+	}
+	read_tmp = true;
+
+	if (!p->skip_locking) {
+		ASSERT(ret);
+		tmp_locked = true;
+		btrfs_tree_read_lock(tmp);
 		btrfs_release_path(p);
-		return PTR_ERR(tmp);
+		path_released = true;
+	}
+
+	/* Now we're allowed to do a blocking uptodate check. */
+	err = btrfs_read_extent_buffer(tmp, &check);
+	if (err) {
+		ret = err;
+		goto out;
 	}
+
 	/*
 	 * If the read above didn't mark this buffer up to date,
 	 * it will never end up being up to date.  Set ret to EIO now
 	 * and give up so that our caller doesn't loop forever
 	 * on our EAGAINs.
 	 */
-	if (!extent_buffer_uptodate(tmp))
+	if (!extent_buffer_uptodate(tmp)) {
 		ret = -EIO;
+		goto out;
+	}
 
-out:
 	if (ret == 0) {
+		ASSERT(!tmp_locked);
 		*eb_ret = tmp;
-	} else {
-		free_extent_buffer(tmp);
-		btrfs_release_path(p);
+		tmp = NULL;
+	}
+out:
+	if (tmp) {
+		if (tmp_locked)
+			btrfs_tree_read_unlock(tmp);
+		if (read_tmp && ret && ret != -EAGAIN)
+			free_extent_buffer_stale(tmp);
+		else
+			free_extent_buffer(tmp);
 	}
+	if (ret && !path_released)
+		btrfs_release_path(p);
 
 	return ret;
 }
@@ -2198,7 +2237,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		}
 
 		err = read_block_for_search(root, p, &b, level, slot, key);
-		if (err == -EAGAIN)
+		if (err == -EAGAIN && !p->nowait)
 			goto again;
 		if (err) {
 			ret = err;
@@ -2325,7 +2364,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 		}
 
 		err = read_block_for_search(root, p, &b, level, slot, key);
-		if (err == -EAGAIN)
+		if (err == -EAGAIN && !p->nowait)
 			goto again;
 		if (err) {
 			ret = err;
-- 
2.17.1


