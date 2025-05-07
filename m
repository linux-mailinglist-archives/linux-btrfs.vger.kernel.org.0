Return-Path: <linux-btrfs+bounces-13800-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7322CAAE7BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 19:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAFE91C28317
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 17:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EFE28C5CC;
	Wed,  7 May 2025 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN2l8pQ0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C628C84F
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638603; cv=none; b=LdWd2qepfOuQXHaSMZ+Xn8bCOgRC1pIXC8nmzKiWuIw2NPeZbCq0Nz8X+5Y9jysgj/MZjfd8MPdMKqsk5t4C2XB+9FjGM7lvto9OhooiDt2ry4UKJvS/7O1Kop6ELQ1DI8IiRuFGDVMzUXpBXOAigYTW9CbfyxBOQh438K2zy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638603; c=relaxed/simple;
	bh=6Pf3KtRc2cIIrqnWBppIm4/1zt1kGuLTpHswzAOfvy0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWWOmGZjN6FecyWW3yIdffrO0EpefFuO6Hw0t0cCjIDYW646a5NPYuz/Os4sY+5dN5trwsOWar5Mu2ZCR4WwPikzLWJfJ5aWqeJIyZyzuDN1T+SjHA23ijyLBW/yMfmCkSSMl1uCPBHUbp/wqFRsLO76MkYYwySKvvouOopUbU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN2l8pQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA3BC4CEEF
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746638603;
	bh=6Pf3KtRc2cIIrqnWBppIm4/1zt1kGuLTpHswzAOfvy0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LN2l8pQ0FBhJeK74Jo3Keplg15AlNqUtrseLlHH2iJ6S3YGe/NMxIdf+yONrxHfsI
	 rg/ZjiL9v4MExp1v8RwgtjaBPkOOxaRf9YtMTAfDumuSEBzc0N6T3oNwxh/GJFKjPA
	 cgMJ/YzDrfhGtYPMohEpwEwYMrIxnv8058lQQD0lqaUIt2y3Qa/VfGTGkfHAvjjCeu
	 ek1OQ3zow88EwF8DON3k3iWvO5qA0MQhz/xiQj9I+6TKPWYasEW8PzlwhUQ+P0CY6v
	 r6JFvQqrgoGafgsV9w+oCQr+MAUmCvrNJgl4+B+kzXyd0SHmD5SF2TzJMxE55pOekZ
	 p9NadmYgnI1SA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: check we grabbed inode reference when allocating an ordered extent
Date: Wed,  7 May 2025 18:23:14 +0100
Message-Id: <09f6ed294c200e2b060d523ccd3125aa93f66da4.1746638347.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746638347.git.fdmanana@suse.com>
References: <cover.1746638347.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When allocating an ordered extent we call igrab() to get a reference on
the inode and attach it to the ordered extent. For an ordered extent we
always must have an inode reference since we during its life cycle we
need to access the inode for several things like for example:

* Inserting the ordered extent right after allocating it, when calling
  insert_ordered_extent() - we need to lock the inode's ordered_tree_lock;

* In the bio submission path we need to add checksums to the ordered
  extent and we end up at btrfs_add_ordered_sum(), where again we need
  to grab the inode from the ordered extent to lock the inode's
  ordered_tree_lock;

* When finishing an ordered extent, at btrfs_finish_ordered_extent(), we
  need again to access its inode in order to lock the inode's
  ordered_tree_lock;

* Etc etc etc.

Every where we deal with an ordered extent we always expect its inode to
be not NULL, the only exception being btrfs_put_ordered_extent() where
we check if it's NULL before calling btrfs_add_delayed_iput(), even though
we have already assumed it's not NULL when calling the tracepoint
trace_btrfs_ordered_extent_put() since the tracepoint dereferences the
inode to extract its number and root without ever checking it's NULL.

The igrab() call can return NULL if the inode is about to be freed or is
being freed (its state has I_FREEING or I_WILL_FREE set), and that's why
there's such check at btrfs_put_ordered_extent(). The igrab() and NULL
check were introduced in commit 5fd02043553b ("Btrfs: finish ordered
extents in their own thread") but even back then we always needed and
assumed igrab() returned a non-NULL pointer, since for example when
removing an ordered extent, at btrfs_remove_ordered_extent(), we assumed
the inode pointer was not NULL in order to access the inode's ordered
extent tree.

In fact whenever we allocate an ordered extent we are holding an inode
reference and the inode is not being freed or going to be freed (which
happens in the final iput), and since we depend on the inode for the
life cycle of the ordered extent, just make ordered extent allocation
to fail in case igrab() returns NULL and trigger a warning, to make it
clear it's not expected. This allows to remove the confusing NULL inode
check at btrfs_put_ordered_extent().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index e44d3dd17caf..a6c5fc78bc4f 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -172,11 +172,8 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	}
 	entry = kmem_cache_zalloc(btrfs_ordered_extent_cache, GFP_NOFS);
 	if (!entry) {
-		if (!is_nocow)
-			btrfs_qgroup_free_refroot(inode->root->fs_info,
-						  btrfs_root_id(inode->root),
-						  qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
-		return ERR_PTR(-ENOMEM);
+		entry = ERR_PTR(-ENOMEM);
+		goto out;
 	}
 
 	entry->file_offset = file_offset;
@@ -186,7 +183,12 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	entry->disk_num_bytes = disk_num_bytes;
 	entry->offset = offset;
 	entry->bytes_left = num_bytes;
-	entry->inode = BTRFS_I(igrab(&inode->vfs_inode));
+	if (WARN_ON_ONCE(!igrab(&inode->vfs_inode))) {
+		kmem_cache_free(btrfs_ordered_extent_cache, entry);
+		entry = ERR_PTR(-ESTALE);
+		goto out;
+	}
+	entry->inode = inode;
 	entry->compress_type = compress_type;
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = qgroup_rsv;
@@ -209,6 +211,12 @@ static struct btrfs_ordered_extent *alloc_ordered_extent(
 	btrfs_mod_outstanding_extents(inode, 1);
 	spin_unlock(&inode->lock);
 
+out:
+	if (IS_ERR(entry) && !is_nocow)
+		btrfs_qgroup_free_refroot(inode->root->fs_info,
+					  btrfs_root_id(inode->root),
+					  qgroup_rsv, BTRFS_QGROUP_RSV_DATA);
+
 	return entry;
 }
 
@@ -622,8 +630,7 @@ void btrfs_put_ordered_extent(struct btrfs_ordered_extent *entry)
 		ASSERT(list_empty(&entry->root_extent_list));
 		ASSERT(list_empty(&entry->log_list));
 		ASSERT(RB_EMPTY_NODE(&entry->rb_node));
-		if (entry->inode)
-			btrfs_add_delayed_iput(entry->inode);
+		btrfs_add_delayed_iput(entry->inode);
 		list_for_each_entry_safe(sum, tmp, &entry->list, list)
 			kvfree(sum);
 		kmem_cache_free(btrfs_ordered_extent_cache, entry);
-- 
2.47.2


