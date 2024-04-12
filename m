Return-Path: <linux-btrfs+bounces-4187-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5868A2FF7
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80C9285A18
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A19E542;
	Fri, 12 Apr 2024 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="v3BAnRJf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD78785926
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930110; cv=none; b=KTCX6K67XfBsV1MFjkFZlc58GCuqO0eF0obEukZpFH80mszRLHD66O3JuTrgWrMPmGDoZzL8TAKqq3bKU/mcMLI83TxwKJqpBHsvxN0vJHaghLtjYLKJ0UJ5uUCpMKCIyT/RZxcNDWyiTcTwUnmifW/5upO7Rxz9QNZb4LbRaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930110; c=relaxed/simple;
	bh=4VAmKDv9j9C8Jyq2Nu+GlV7dxjFf6Fu37j8TpurlRCk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GIxzombWXXRskf03gn8dpX80m3dkF4u6D+Lk6azvrLQKWV4itm5Un6ud5eUwTI/lxsGCcH+0QIwuRtaQTtB3tp3Tqqi3sNPy2Lu3R/97chL05QSQ7PVbDl2j3oujhG2CtOvNDUNIOQedBF9ft/mvvdMsG9g2Czh22mgZwYDuq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=v3BAnRJf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4346b686dbdso4661201cf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1712930106; x=1713534906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpbPqk8h8IasN0QaHnUzUvrcMugCGOMGfa2AXXkM5yE=;
        b=v3BAnRJfc0Ne0CBz/M3IHBf0Qtatzh/G1rNWCvVrWwZkfNSUdRxpTOTLVDnGVDITVO
         X/25q9o0/S/xX1vzrKqgSTe8ImpN2RfnEdWefiQtpcsUXkpQqRZz81V0woOUb2Y+Cr7x
         gxfemMg1QBMd3CSTzK9rSJVBUvg6hyX0s6z1hyT1jEUJHNCPg4TwOGrjO9yPgjx/YKEK
         ebE9NZ6uEhHzPQsdCUqS7utlvhnxc/6sdMqzso3jTkoBsn9xUAw49l1h8tEBRBijp3kN
         6UyfaRgzuqJSecssfuXMT8B0DS5ZkMi7FwdUMuYfdMLcd0H6j7utjG/wkEaHDxRkLlJx
         ZJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712930106; x=1713534906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpbPqk8h8IasN0QaHnUzUvrcMugCGOMGfa2AXXkM5yE=;
        b=jS8lnks34pZ6KZccByM9mNZaqjOPmevuN2v/8M/bgO/IH7W8hxQVLXGeBQgZ3fH1XA
         xDwa624Fg/HJsbR1NDgBWrwF8dnnYgJFFWGoL3+PQQKt62b3z7tKmKl97E0F6OoGAIpu
         H/zLsP2eqfWZ0ZyaKpkATEnyj1lRUwgt8aJuwhjvh4JrTrB1R75Zw1dg2CVQQKpIkwYs
         VK4HF7kb10mzrHSnkNBRGzufJ/9VcT64h3DtcbYBqSCjz//k8WWd+3bmKrljjnTdcH8F
         /Wb2aKf1HHSli19NRF/Gkk129Fc5PO6H087V6heD572rlo8CRc2M600R5iQQGNfU2bfs
         ObNg==
X-Gm-Message-State: AOJu0YyKSNyobjsvLle7gNSt9t0BfbF/daRT2xV4MT3CUV6tDRVD1/hP
	5/eM/+UGhY6ep1V5BZvqNx+ZxYrf7YlLEYyh2E/S0eJ4DrM+uvrDRwKjjTzhnrMXRz6ZLKYSrZ4
	h
X-Google-Smtp-Source: AGHT+IGLSBt8lqr+zl8+u8INr21vrSEN81+MMsCZErRmx86J2nA0X3ahhjcl1bzoc3gQ+aNfUdh0Jg==
X-Received: by 2002:a05:622a:13c6:b0:434:4b60:800e with SMTP id p6-20020a05622a13c600b004344b60800emr3357693qtk.58.1712930106396;
        Fri, 12 Apr 2024 06:55:06 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y14-20020ac8524e000000b004364fd7a9d9sm2246475qtn.58.2024.04.12.06.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 06:55:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: check delayed refs when we're checking if a ref exists
Date: Fri, 12 Apr 2024 09:55:01 -0400
Message-ID: <3937cbcdf53440dcda98b64ce5e0e1cf8b15803d.1712929998.git.josef@toxicpanda.com>
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
for subvolume a and one for subvolume b, and it belongs to subvolume a
(btrfs_header_owner(block 1) == subvolume a).

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
having multiple deleted snapshots pending when we unmount.  We noticed
this in production because our shutdown path stops the container on the
system, which deletes a bunch of subvolumes, and then reboots the box.
This gives us plenty of opportunities to hit this issue.  Looking at the
history we've seen this occasionally in production, but we had a big
spike recently thanks to faster machines getting jobs with multiple
subvolumes in the job.

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
v1->v2:
- Fixed up style nits pointed out by Filipe.
- Fixed up the changelog to fix some wrong words and make things more clear.

 fs/btrfs/delayed-ref.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h |  2 ++
 fs/btrfs/extent-tree.c | 51 +++++++++++++++++++++++++++----
 3 files changed, 116 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index e44e62cf76bc..8c0970980acb 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1297,6 +1297,75 @@ btrfs_find_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs, u64 byt
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
+	lockdep_assert_held(&head->mutex);
+
+	spin_lock(&head->lock);
+	node = head->ref_tree.rb_root.rb_node;
+	while (node) {
+		struct btrfs_delayed_ref_node *entry;
+		int ret;
+
+		entry = rb_entry(node, struct btrfs_delayed_ref_node, ref_node);
+		ret = find_comp(entry, root, parent);
+		if (ret < 0) {
+			node = node->rb_left;
+		} else if (ret > 0) {
+			node = node->rb_right;
+		} else {
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
index 42314604906a..b21998c1e33f 100644
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
+		/*
+		 * If we get 0 then we found our reference, return 1, else
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
+	exists = btrfs_find_delayed_tree_ref(head, root->root_key.objectid, parent);
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


