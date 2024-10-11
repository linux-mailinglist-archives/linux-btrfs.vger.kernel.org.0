Return-Path: <linux-btrfs+bounces-8841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B7F999B42
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 05:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3169B22E2D
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 03:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9014B1F4720;
	Fri, 11 Oct 2024 03:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="XaR5YwFR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461363D
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 03:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728618314; cv=none; b=BfzszczUtHX1goXGPkJZ/SX0+QF9uFzhH8aMXYBVBZKU0fng4jFLakFLrPpGfNGO7YH6fT1bIrv54YGvt7R38Ltd6K5sEenz87I1mONJMScB7sJiS5JakpQxODkHxbUpVPXtvyFf7vELrQ1AzfGJ/wExbBuSFm1KMCxPbIDP4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728618314; c=relaxed/simple;
	bh=JvGoxJbT17ry7Jzv1kKNAWwe1LaBN1nZlddsaSBDc/8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TQRt7/JUVZ/2PbgyeSjVkTrBkjqW4PG/tse6MMv8mGTylLTuNTJnpqbQE7OJ3CAo4Rxo5kJ9RKHOYeb8f0FeEQqm4rQqiG/7PF9BXLxSzew6jbGdcwi/5mac26ND9WNVWIZd3tYQEiHJUAPLXGbUCKftY2xO9et6eQteRtlF1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=XaR5YwFR; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
From: robbieko <robbieko@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1728618311; bh=JvGoxJbT17ry7Jzv1kKNAWwe1LaBN1nZlddsaSBDc/8=;
	h=From:To:Cc:Subject:Date;
	b=XaR5YwFRi+sz9DdOaAetpnFRV8TbeFi6l/+8uhuO3JD2kai1xPpi0/peUDz/FdOyd
	 y5hBpAoRdVv1UhRalFIxI88J4arkGF9jiFXDlPIdXP9omArQlqrFAzug4XuIcuCULk
	 Wf1kJYwHtITaiESv9uMJWYx+FzTXX1flZS4V9mSA=
To: linux-btrfs@vger.kernel.org
Cc: Robbie Ko <robbieko@synology.com>
Subject: [PATCH v2] btrfs: reduce lock contention when eb cache miss for btree search
Date: Fri, 11 Oct 2024 11:45:02 +0800
Message-Id: <20241011034502.24009-1-robbieko@synology.com>
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

v2:
* Add skip_locking handle

Signed-off-by: Robbie Ko <robbieko@synology.com>
---
 fs/btrfs/ctree.c | 104 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 72 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0cc919d15b14..ad3e734f09f6 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1515,12 +1515,15 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
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
+	bool create = false;
+	bool lock = false;
+	bool skip_locking = p->skip_locking;
+	bool path_released = false;
 
-	unlock_up = ((level + 1 < BTRFS_MAX_LEVEL) && p->locks[level + 1]);
 	blocknr = btrfs_node_blockptr(*eb_ret, slot);
 	gen = btrfs_node_ptr_generation(*eb_ret, slot);
 	parent_level = btrfs_header_level(*eb_ret);
@@ -1551,68 +1554,105 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
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
+		if (!skip_locking) {
 			btrfs_unlock_up_safe(p, level + 1);
-
-		/* now we're allowed to do a blocking uptodate check */
-		ret = btrfs_read_extent_buffer(tmp, &check);
-		if (ret) {
-			free_extent_buffer(tmp);
+			lock = true;
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
 
+		if (!ret) {
+			ASSERT(!lock);
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
+	if (!skip_locking) {
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
+	create = true;
+
+	if (!skip_locking) {
+		ASSERT(ret);
+		lock = true;
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
-	if (ret == 0) {
+	if (!ret) {
+		ASSERT(!lock);
 		*eb_ret = tmp;
-	} else {
-		free_extent_buffer(tmp);
-		btrfs_release_path(p);
+		tmp = NULL;
+	}
+out:
+	if (tmp) {
+		if (lock)
+			btrfs_tree_read_unlock(tmp);
+		if (create && ret && ret != -EAGAIN)
+			free_extent_buffer_stale(tmp);
+		else
+			free_extent_buffer(tmp);
 	}
+	if (ret && !path_released)
+		btrfs_release_path(p);
 
 	return ret;
 }
@@ -2198,7 +2238,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		}
 
 		err = read_block_for_search(root, p, &b, level, slot, key);
-		if (err == -EAGAIN)
+		if (err == -EAGAIN && !p->nowait)
 			goto again;
 		if (err) {
 			ret = err;
@@ -2325,7 +2365,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 		}
 
 		err = read_block_for_search(root, p, &b, level, slot, key);
-		if (err == -EAGAIN)
+		if (err == -EAGAIN && !p->nowait)
 			goto again;
 		if (err) {
 			ret = err;
-- 
2.17.1


