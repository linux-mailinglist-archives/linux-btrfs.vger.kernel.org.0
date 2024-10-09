Return-Path: <linux-btrfs+bounces-8673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9553D995DA0
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 04:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F831F258EB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 02:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8241C5674D;
	Wed,  9 Oct 2024 02:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="aBVmL/ht"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5515C3
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439771; cv=none; b=cqgnvQGJb5QSsaWZGarH9u69cUm6fn7hUQrOVTINOguAh9If9WW7ftfetsXgXqY266nfOzToALZKgnsiS08BPOdXkdqFgtKwmXFMPGahizfIG7EmLP9jwpfNklqtNB2+pLspy2W5QcB3TB5kHE2sBv3OEvPU4gMjPqIR+w7BpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439771; c=relaxed/simple;
	bh=1wdrSBNu7UQ7E96Ij5ru/5YJBcL4DSpxfSKCitr6Gcs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=IUTFyT2a6ZFPKfAJU6vJ8wxapUhelX6s7571q3Ipq1ZDYK+DDeNhE6EVbZDY6COnq06nsUoWnLeKlDxjzMRqRO3epk8YWK+4shFo7Ki6RK7Yd8ZykXfuZrs0KGiwc7slTATiSoKmBmYbr+nxb0ew8QKqKQWkazaA2T+cQCbRZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=aBVmL/ht; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1728439311; bh=1wdrSBNu7UQ7E96Ij5ru/5YJBcL4DSpxfSKCitr6Gcs=;
	h=From:To:Cc:Subject:Date;
	b=aBVmL/htmcddVPMuuv8VIfeBXrqoUsnT4tobFlU7is5IPeZSmAZ2nHrDK8aZIbNJm
	 xvI8AnL4+ttE5i6eXTqDt5ViBLX+VBfVuBRGom/GtKaJR7XZaqpPcH8FBSqQRl8aLX
	 WxQSKxqRbfCIW7QQEuscI3e0w+gKGpRdi6268Ht0=
To: linux-btrfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH] btrfs: reduce lock contention when eb cache miss for btree search
Date: Wed,  9 Oct 2024 10:01:49 +0800
Message-Id: <20241009020149.23467-1-robbieko@synology.com>
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>

From: Robbie Ko <robbieko@synology.com>

When crawling btree, if an eb cache miss occurs, we change to use
the eb read lock and release all previous locks to reduce lock contention.

Because we have prepared the check parameters and the read lock
of eb we hold, we can ensure that no race will occur during the check
and cause unexpected errors.

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/ctree.c | 88 ++++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 36 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0cc919d15b14..0efbe61497f3 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1515,12 +1515,12 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	struct btrfs_tree_parent_check check = { 0 };
 	u64 blocknr;
 	u64 gen;
-	struct extent_buffer *tmp;
-	int ret;
+	struct extent_buffer *tmp = NULL;
+	int ret, err;
 	int parent_level;
-	bool unlock_up;
+	bool create = false;
+	bool lock = false;
 
-	unlock_up = ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]);
 	blocknr = btrfs_node_blockptr(*eb_ret, slot);
 	gen = btrfs_node_ptr_generation(*eb_ret, slot);
 	parent_level = btrfs_header_level(*eb_ret);
@@ -1551,52 +1551,66 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
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
+			btrfs_release_path(p);
+			goto out;
 		}
 
-		if (unlock_up)
-			btrfs_unlock_up_safe(p, level + 1);
+		ret = -EAGAIN;
+		btrfs_unlock_up_safe(p, level + 1);
+		btrfs_tree_read_lock(tmp);
+		lock = true;
+		btrfs_release_path(p);
 
 		/* now we're allowed to do a blocking uptodate check */
-		ret = btrfs_read_extent_buffer(tmp, &check);
-		if (ret) {
-			free_extent_buffer(tmp);
-			btrfs_release_path(p);
-			return ret;
+		err = btrfs_read_extent_buffer(tmp, &check);
+		if (err) {
+			ret = err;
+			goto out;
 		}
-
-		if (unlock_up)
-			ret = -EAGAIN;
-
 		goto out;
 	} else if (p->nowait) {
-		return -EAGAIN;
-	}
-
-	if (unlock_up) {
-		btrfs_unlock_up_safe(p, level + 1);
 		ret = -EAGAIN;
-	} else {
-		ret = 0;
+		btrfs_release_path(p);
+		goto out;
 	}
 
+	ret = -EAGAIN;
+	btrfs_unlock_up_safe(p, level + 1);
+
 	if (p->reada != READA_NONE)
 		reada_for_search(fs_info, p, level, slot, key->objectid);
 
-	tmp = read_tree_block(fs_info, blocknr, &check);
+	tmp = btrfs_find_create_tree_block(fs_info, blocknr, check.owner_root, check.level);
 	if (IS_ERR(tmp)) {
+		ret = PTR_ERR(tmp);
+		tmp = NULL;
 		btrfs_release_path(p);
-		return PTR_ERR(tmp);
+		goto out;
 	}
+	create = true;
+
+	btrfs_tree_read_lock(tmp);
+	lock = true;
+	btrfs_release_path(p);
+
+	/* now we're allowed to do a blocking uptodate check */
+	err = btrfs_read_extent_buffer(tmp, &check);
+	if (err) {
+		ret = err;
+		goto out;
+	}
+
 	/*
 	 * If the read above didn't mark this buffer up to date,
 	 * it will never end up being up to date.  Set ret to EIO now
@@ -1607,11 +1621,13 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 		ret = -EIO;
 
 out:
-	if (ret == 0) {
-		*eb_ret = tmp;
-	} else {
-		free_extent_buffer(tmp);
-		btrfs_release_path(p);
+	if (tmp) {
+		if (lock)
+			btrfs_tree_read_unlock(tmp);
+		if (create && ret && ret != -EAGAIN)
+			free_extent_buffer_stale(tmp);
+		else
+			free_extent_buffer(tmp);
 	}
 
 	return ret;
@@ -2198,7 +2214,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		}
 
 		err = read_block_for_search(root, p, &b, level, slot, key);
-		if (err == -EAGAIN)
+		if (err == -EAGAIN && !p->nowait)
 			goto again;
 		if (err) {
 			ret = err;
@@ -2325,7 +2341,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 		}
 
 		err = read_block_for_search(root, p, &b, level, slot, key);
-		if (err == -EAGAIN)
+		if (err == -EAGAIN && !p->nowait)
 			goto again;
 		if (err) {
 			ret = err;
-- 
2.17.1


