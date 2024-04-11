Return-Path: <linux-btrfs+bounces-4163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9F68A20A6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 23:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19331F23E76
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 21:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DD82BD0D;
	Thu, 11 Apr 2024 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="M4fmfpRw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC599205E2B
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 21:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869599; cv=none; b=ZpuCgk4Ei6a6GuSaF7/y6CP1EgeEVYOWn32510QmsIDRx3ym708Dh2wyXD69fOipgxqnzASvU+A5a8rpopYwM8UPHJ3w6qoRMFHtIqaf2zQGxN1dVI8dYG8RK6otRe+tFwhXKmU2ovYR6dhhYwQuD9ZutAlM065PA1EWh9KANoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869599; c=relaxed/simple;
	bh=cK2G6rR0JuxU+1S+n52uBEMLTgH2nQCs0DzKFoTRAfw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EvAVZy4urzjfPYv58cYNz+umWDn/bgCeFTAt+iCNl+ogaYJtRsFLAijckg/11YTANimpirJc1P/7bD6NgH5n9ZwDVL06RJ3Gxe9xKSfdrphUv5sqHnrWBVjxkB/asGhXZfagDvHP+7q3lDWr3A3CSLAi/rT8vSydVjD1B91RU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=M4fmfpRw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4346b686dbdso1054681cf.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1712869596; x=1713474396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=INRulvS+nqxi/ICl9+Q3OIDjEo2WYGvUSUopp+/V/sE=;
        b=M4fmfpRwybasmxC1SWyRuc9OSUT+XII7EcCthldzkkIMBds45IE0jd9bvNQLqXACQk
         tKdnpO5KusMwEtmFBousOle8/pJLAI3NfcYZUgtXkV/J222hDLIe6305MB5YYjnxEXeW
         eqGYVYMZ9C3hH+5lcP1uP1bwmM/rTwlxwJQ18AbCO6h17K1UdbznjF6AgC1nHgXyUuTE
         2GDo/lQEDsgCFsHuGC2Ya7CKR4I6cEziRkZzDrvjZqWIommGZMwVAHX4g9w5S8FVblu9
         9BET8vS2gEugPNZyeETjHEsxU1n7XRyQaQNfReJ65XxPK4PgoBwSKuVlLVKJ7Z1n4Sdt
         7rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869596; x=1713474396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INRulvS+nqxi/ICl9+Q3OIDjEo2WYGvUSUopp+/V/sE=;
        b=MYTvUO5bRkCyBFmLavsG0wbU3iqH16ffbhXN+8sX8su4d7OyUDjM3cbaE9zzZSl9no
         BIv3MAoeMNAov9me5rPbd4klbF6g0/hFcn9ErqZd2bpcjCl78tBqchJXfUoELf3/QyOe
         2W9yPiFGXfzoY/bcJFuf6etAbqgOJ3AZaHuc2rSR/dSqrqCYLceR4443+ra6i3n9p6KW
         FKN17TrIRexN0XznShS4KK9uTRn9yocBHt23uxl69iuZiBFFRl24Tl2YwC9ETlFtLGGs
         eP6qTVxBQp4gkMUb9CgJfzMFNoDdk9hu4jcsh1xLvvPaeEBTYWYx2WGwlovm3s6/bx27
         BhjA==
X-Gm-Message-State: AOJu0YyMZ815C0CxQ+pkwyMleGJ4WaYgIR3hRaWqMPeYvcVaFwhzCCQW
	DibDdP+t0LqUp3rHI2awaPKsqvT1SLZTrZ/1pHNNjWqEVUTbcF5A77XxwvRx2UcmMKlCBVPd79a
	d
X-Google-Smtp-Source: AGHT+IFFuvtGaCgw/BcZ8HGAM1eqk0OWlWhTZxzS/lV+DQ9iO1qMzFEbu/+sqb7kBljiybUmoKs+vA==
X-Received: by 2002:a05:622a:1821:b0:434:a317:2df4 with SMTP id t33-20020a05622a182100b00434a3172df4mr890333qtc.25.1712869596331;
        Thu, 11 Apr 2024 14:06:36 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id g25-20020ac84dd9000000b00434368a34a5sm1350913qtw.64.2024.04.11.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 14:06:35 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: check delayed refs when we're checking if a ref exists
Date: Thu, 11 Apr 2024 17:06:31 -0400
Message-ID: <dc43a26265d37c71a53d6415ae2d352035fa6847.1712869574.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the patch 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete
resume") I added some code to handle file systems that had been
corrupted by a bug that incorrectly skipped updating the drop progress
key while dropping a snapshot.  This code would check to see if we had
already deleted our reference for a child block, and skip the deletion
if we had already.

Unfortunately there is a bug, as the check would only check the on-disk
references.  I made an incorrect assumption that blocks in an already
deleted snapshot that was having the deletion resume on mount wouldn't
be modified.

If we have 2 pending deleted snapshots that share blocks, we can easily
modify the rules for a block.  Take the following example

subvolume a exists, and subvolume b is a snapshot of subvolume a.  They
share references to block 1.  Block 1 will have 2 full references, one
for subvolume a and one for subvolume b, and it blocks to subvolume a.

When deleting subvolume a, we will drop our full reference for block 1,
and because we are the owner we will drop our full reference for all of
block 1's children, convert block 1 to FULL BACKREF, and add a shared
reference to all of block 1's children.

Then we will start the snapshot deletion of subvolume b.  We look up the
extent info for block 1, which checks delayed refs and tells us that
FULL BACKREF is set, so sets parent to the bytenr of block 1.  However
because this is a resumed snapshot deletion, we call into
check_ref_exists().  Because check_ref_exists() only looks at the disk,
it doesn't find the shared backref for the child of block 1, and thus
returns 0 and we skip deleting the reference for the child of block 1
and continue.  This orphans the child of block 1.

The fix is to lookup the delayed refs, similar to what we do in
btrfs_lookup_extent_info().  However we only care about whether the
reference exists or not.  If we fail to find our reference on disk, go
look up the bytenr in the delayed refs, and if it exists look for an
existing ref in the delayed ref head.  If that exists then we know we
can delete the reference safely and carry on.  If it doesn't exist we
know we have to skip over this block.

This bug has existed since I introduced this fix, however requires
having multiple deleted snapshots pending when we unmount.  Previously
this was difficult to do, because we committed the transaction on
snapshot delete.  However a recent change to that code removed the
delete, so it was much easier to reproduce this issue.  We noticed this
in production because our shutdown path stops the container on the
system, which deletes a bunch of subvolumes, and then reboots the box.
This gives us plenty of opportunities to hit this issue.  Looking at the
history we've seen this occasionally in production, but we had a big
spike recently thanks to faster machines getting put onto kernels with
the fix to no longer commit the transaction on subvolume delete.

Chris Mason wrote a reproducer which does the following

mount /dev/nvme4n1 /btrfs
btrfs subvol create /btrfs/s1
simoop -E -f 4k -n 200000 -z /btrfs/s1
while(true) ; do
	btrfs subvol snap /btrfs/s1 /btrfs/s2
	simoop -f 4k -n 200000 -r 10 -z /btrfs/s2
	btrfs subvol snap /btrfs/s2 /btrfs/s3
	btrfs balance start -dusage=80 /btrfs
	btrfs subvol del /btrfs/s2 /btrfs/s3
	umount /btrfs
	btrfsck /dev/nvme4n1 || exit 1
	mount /dev/nvme4n1 /btrfs
done

On the second loop this would fail consistently, with my patch it has
been running for hours and hasn't failed.

I also used dm-log-writes to capture the state of the failure so I could
debug the problem.  Using the existing failure case to test my patch
validated that it fixes the problem.

Fixes: 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete resume")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h |  2 ++
 fs/btrfs/extent-tree.c | 51 ++++++++++++++++++++++++++++----
 3 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index e44e62cf76bc..2d43cb4b2106 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1297,6 +1297,73 @@ btrfs_find_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs, u64 byt
 	return find_ref_head(delayed_refs, bytenr, false);
 }
 
+static int find_comp(struct btrfs_delayed_ref_node *entry, u64 root, u64 parent)
+{
+	struct btrfs_delayed_tree_ref *ref;
+	int type = parent ? BTRFS_SHARED_BLOCK_REF_KEY : BTRFS_TREE_BLOCK_REF_KEY;
+
+	if (type < entry->type)
+		return -1;
+	if (type > entry->type)
+		return 1;
+
+	ref = btrfs_delayed_node_to_tree_ref(entry);
+	if (type == BTRFS_TREE_BLOCK_REF_KEY) {
+		if (root < ref->root)
+			return -1;
+		if (root > ref->root)
+			return 1;
+	} else {
+		if (parent < ref->parent)
+			return -1;
+		if (parent > ref->parent)
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Check to see if a given root/parent reference is attached to the head.  This
+ * only checks for BTRFS_ADD_DELAYED_REF references that match, as that
+ * indicates the reference exists for the given root or parent.  This is for
+ * tree blocks only.
+ *
+ * @head: the head of the bytenr we're searching.
+ * @root: the root objectid of the reference if it is a normal reference.
+ * @parent: the parent if this is a shared backref.
+ */
+bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
+				 u64 root, u64 parent)
+{
+	struct rb_node *node;
+	bool found = false;
+
+	spin_lock(&head->lock);
+	node = head->ref_tree.rb_root.rb_node;
+	while (node) {
+		struct btrfs_delayed_ref_node *entry;
+		int ret;
+
+		entry = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
+		ret = find_comp(entry, root, parent);
+		if (ret < 0)
+			node = node->rb_left;
+		else if (ret > 0)
+			node = node->rb_right;
+		else {
+			/*
+			 * We only want to count ADD actions, as drops mean the
+			 * ref doesn't exist.
+			 */
+			if (entry->action == BTRFS_ADD_DELAYED_REF)
+				found = true;
+			break;
+		}
+	}
+	spin_unlock(&head->lock);
+	return found;
+}
+
 void __cold btrfs_delayed_ref_exit(void)
 {
 	kmem_cache_destroy(btrfs_delayed_ref_head_cachep);
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index b291147cb8ab..34c34db01cc6 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -397,6 +397,8 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 void btrfs_migrate_to_delayed_refs_rsv(struct btrfs_fs_info *fs_info,
 				       u64 num_bytes);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
+bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
+				 u64 root, u64 parent);
 
 /*
  * helper functions to cast a node into its container
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 42314604906a..4d98bd247342 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5428,23 +5428,62 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root, u64 bytenr, u64 parent,
 			    int level)
 {
+	struct btrfs_delayed_ref_root *delayed_refs;
+	struct btrfs_delayed_ref_head *head;
 	struct btrfs_path *path;
 	struct btrfs_extent_inline_ref *iref;
 	int ret;
+	bool exists = false;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
-
+again:
 	ret = lookup_extent_backref(trans, path, &iref, bytenr,
 				    root->fs_info->nodesize, parent,
 				    root->root_key.objectid, level, 0);
+	if (ret != -ENOENT) {
+		/* If we get 0 then we found our reference, return 1, else
+		 * return the error if it's not -ENOENT;
+		 */
+		btrfs_free_path(path);
+		return (ret < 0 ) ? ret : 1;
+	}
+
+	/*
+	 * We could have a delayed ref with this reference, so look it up while
+	 * we're holding the path open to make sure we don't race with the
+	 * delayed ref running.
+	 */
+	delayed_refs = &trans->transaction->delayed_refs;
+	spin_lock(&delayed_refs->lock);
+	head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
+	if (!head)
+		goto out;
+	if (!mutex_trylock(&head->mutex)) {
+		/*
+		 * We're contended, means that the delayed ref is running, get a
+		 * reference and wait for the ref head to be complete and then
+		 * try again.
+		 */
+		refcount_inc(&head->refs);
+		spin_unlock(&delayed_refs->lock);
+
+		btrfs_release_path(path);
+
+		mutex_lock(&head->mutex);
+		mutex_unlock(&head->mutex);
+		btrfs_put_delayed_ref_head(head);
+		goto again;
+	}
+
+	exists = btrfs_find_delayed_tree_ref(head, root->root_key.objectid,
+					     parent);
+	mutex_unlock(&head->mutex);
+out:
+	spin_unlock(&delayed_refs->lock);
 	btrfs_free_path(path);
-	if (ret == -ENOENT)
-		return 0;
-	if (ret < 0)
-		return ret;
-	return 1;
+	return exists ? 1 : 0;
 }
 
 /*
-- 
2.43.0


