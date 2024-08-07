Return-Path: <linux-btrfs+bounces-7024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8161894A9F8
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 16:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357C4281A10
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2024 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257861FC4;
	Wed,  7 Aug 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="hlF3Tfg2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CE92AF10
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Aug 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040454; cv=none; b=YcHZJzdrSH7JdP4/fyVfa8H4lPE13v/8tA8BT8VcsfdrDwwAmCgrnCaNQEra3DwNQwbnZiiL8DG3HNy56H2q2jrh85JGJO/PKbVjlCPlXs3V6DusTAe+tiYmWvEWdKnBpTEkEgNmKiWQFPFY7VKzRJWrkkJEetfIU9wB5iWA2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040454; c=relaxed/simple;
	bh=ovcTjWE+8mK1+4VFuQKXTGhVx5gvU+vfRRz+cMSn5HI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJ2RZUkpiIhNL4eaB3nsnAJWJ/FkS4kKkpRBLSqd+NZ1bOwLJeSURWktwEDSYXmSZ1624WGKnccKZYVFjrNS1zoXFYpO+bfgbpMm6VdIt9VkwoBj07CymjFia+j9QQNhaE2B24Xq6rxPHbEP1qLR97KwoQxwQTDqd1hje7PfkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=hlF3Tfg2; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db1657c0fdso1135635b6e.1
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2024 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723040451; x=1723645251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3A2suzVXizxfUfPrnFRAhodlwbWz8qmOGysIhJsq2Y=;
        b=hlF3Tfg2/uG7Pwox3kMtTvpPQll+BGL21ZUDakBd3TZPJDhJWg7BqaAxMJHp5zGYJq
         3UkusFhug2eUYlkk6oc0X/U4Ccf/uUiH+ASLJIluUk8Qy7r+PmyONVwd4JLoBygUZi9q
         tLVA9A8sPs0KLitPH+r4Vsyag8HiaBheVtqRuxmstYlBsHD2i7hM3EvYR/4wUORmyEog
         UAckbbwT4bZjYNOqPRZHEoj/ZofhuaCq7AoMDoaavbEWf8SUXeQ1+bHWQ9+FBG7KH8y1
         LHqyMCXLD22DkBRjP6Nw5m0t2rrzavZQ9j4VP+zvhBGAwXhi0EvhhnbExVHCUIZv4oNi
         Duiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723040451; x=1723645251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3A2suzVXizxfUfPrnFRAhodlwbWz8qmOGysIhJsq2Y=;
        b=UGBuCiyiVQWRH6aJ93a4Q2m35md6QmiFNfzkPL+3SPyes5IK7d5+d0KmgHLWLylfrT
         SplePvNdyHPq1nJgQgUZfP041gDEdFt899lLbuOLmFS+FAIRRioJj1HrfUtS+Mt//47t
         /zirB3eYWd7rzWtOdYKcML4Uebu37grcA5R0xMSNSXZPWr9C/++joSUDxa2hYlEBgcqh
         JBN9TdcQ6MbokQkKbFP1n4ET/bT38NfdVxpeqjlCXF6n4cj9SBy2gEdsGBRRHsrrVSs1
         oLvb10r3bvvJMIMTEF082cMIGS8iutNwMr8aLfg8D3UjYogzeh+U+VZd8kqp9mIWb2x/
         pumA==
X-Gm-Message-State: AOJu0YxZ++2oEj9SGMA2BYIAy8Zmy3mufcT6Yw4GEGsKsb9I2YSNEq4Q
	eqJ2kwOG7WBgKWVNzVP5/JoaldSCv9x1Ghbt9ViQYOWUebZYmJkKv/h4oZLE6uYWmmIaczMkC4l
	j
X-Google-Smtp-Source: AGHT+IHJM2u/wK8dyAi0TWxZhlcIpZw5TNWn2AqN6aYUd4mj6tu6YYwaylaz+HLVeG2q+hDXR1tWxA==
X-Received: by 2002:a05:6808:2212:b0:3d5:60b3:d9ca with SMTP id 5614622812f47-3db5583b506mr22761046b6e.43.1723040451306;
        Wed, 07 Aug 2024 07:20:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c79b1fdsm57092766d6.53.2024.08.07.07.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:20:50 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH][RESEND] btrfs: check delayed refs when we're checking if a ref exists
Date: Wed,  7 Aug 2024 10:20:47 -0400
Message-ID: <f64b44109b568df8a12daa8ee21fec172ef9cb26.1723040386.git.josef@toxicpanda.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Fixes: 78c52d9eb6b7 ("btrfs: check for refs on snapshot delete resume")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
I dropped the ball on this, I've rebased it and I'm re-sending it just to make
sure people know I'm going to merge this.  If there are any questions let me
know, otherwise I'll push this into our for-next branch tomorrow.

 fs/btrfs/delayed-ref.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h |  2 ++
 fs/btrfs/extent-tree.c | 51 ++++++++++++++++++++++++++++----
 3 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 2ac9296edccb..06a9e0542d70 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1134,6 +1134,73 @@ btrfs_find_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs, u64 byt
 	return find_ref_head(delayed_refs, bytenr, false);
 }
 
+static int find_comp(struct btrfs_delayed_ref_node *entry, u64 root, u64 parent)
+{
+	int type = parent ? BTRFS_SHARED_BLOCK_REF_KEY : BTRFS_TREE_BLOCK_REF_KEY;
+
+	if (type < entry->type)
+		return -1;
+	if (type > entry->type)
+		return 1;
+
+	if (type == BTRFS_TREE_BLOCK_REF_KEY) {
+		if (root < entry->ref_root)
+			return -1;
+		if (root > entry->ref_root)
+			return 1;
+	} else {
+		if (parent < entry->parent)
+			return -1;
+		if (parent > entry->parent)
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
index ef15e998be03..05f634eb472d 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -389,6 +389,8 @@ void btrfs_dec_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info);
 int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush);
 bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info);
+bool btrfs_find_delayed_tree_ref(struct btrfs_delayed_ref_head *head,
+				 u64 root, u64 parent);
 
 static inline u64 btrfs_delayed_ref_owner(struct btrfs_delayed_ref_node *node)
 {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index ff9f0d41987e..feec49e6f9c8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5472,23 +5472,62 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
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
 				    btrfs_root_id(root), level, 0);
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


