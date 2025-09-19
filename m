Return-Path: <linux-btrfs+bounces-16958-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B31B88C5D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 12:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361336284D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC912F4A1F;
	Fri, 19 Sep 2025 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogMOjAKd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA902F5301
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276726; cv=none; b=kr2dEgRh2oT5cYQcWC7owLB0Zhwm9QxP9qxU6AX9g3tLKLoQV/8yXrlSczWJ2kSQJj2pmB+X5VjXs/nDUmZgT+TbzjcC7Wvrej8jl5Rf4L60l4YERQsaNTk2qYW/bpmjGetLDqvQayFCqQjpfE1v9Gq+CX8RVIPWa24mtEM+zow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276726; c=relaxed/simple;
	bh=LwiNCzQ/UbgsJstYnU3gGMG2QVHkhs4eCO7CC7IJr40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LvB0o9NYjcm6OYEEyw6cXcY/UpB0WaJSjH+D/nPonmRhvRDalQ3aSMVa9KfOiH9euNQhKYpF/8RXOTynrIsu8Wi1n9Ls/rkBDl2WH3QuE6wGNU7NSHyFzd9MVc03lE+jjdA6WyocHdujEw5vMRZNR0rsDbiHZyB8Zgxf7yxRa5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogMOjAKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D550C4CEFA
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758276726;
	bh=LwiNCzQ/UbgsJstYnU3gGMG2QVHkhs4eCO7CC7IJr40=;
	h=From:To:Subject:Date:From;
	b=ogMOjAKdfR+sfOmYRnFCtIVmLnRzj8s/3rglL7NbdmHw0esROVsWMbru00N17BQrN
	 Ly7BS1pjD/94EQD0/Qah2DAFjxolhPgW5+gLbiJO1bIVwvDPm23QwPyAwORRM7ICjM
	 BWikq2uftgHwBYoYMDxQ1ZhXOIF7zD9Fcfklz7eddO+OTxECQQuc45GzrQOpvoRt4G
	 JDPjyCV/Sw2YlRZ/KBb/7nyOwMEUl7hFtTGHZrr/JUtH98XoPhLMpDpOFiGaxOhlBP
	 XycG/bJhm8urceHpVdZfGU5AWzZUvDnPkrgEKq9RvD1UYDF2g/Zrmme2h2bHbV3Heu
	 6MNsLILD9Fjsw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: annotate btrfs_is_testing() as unlikely and make it return bool
Date: Fri, 19 Sep 2025 11:12:01 +0100
Message-ID: <eebf22439d2422d36703ab3bc7191f382605b8a4.1758272653.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We can annotate btrfs_is_testing() as unlikely since that's the most
expected scenario and it's desirable for the compiler to optimize for
the case we are not running the self tests. So add the annotation to
btrfs_is_testing() and while at it also make it return bool instead of
int.

Also make two of the existing callers use btrfs_is_testing() directly
instead of storing its result in a local variable.

On x86_64 with Debian's gcc 14.2.0-19 this resulted in a very tiny object
code reduction.

Before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1913263	 161567	  15592	2090422	 1fe5b6	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1913257	 161567	  15592	2090416	 1fe5b0	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 7 +++----
 fs/btrfs/disk-io.c     | 3 +--
 fs/btrfs/fs.h          | 8 ++++----
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 6170803d8a1b..481802efaa14 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1251,7 +1251,6 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 {
 	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	bool testing = btrfs_is_testing(fs_info);
 
 	spin_lock(&delayed_refs->lock);
 	while (true) {
@@ -1281,7 +1280,7 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 		spin_unlock(&delayed_refs->lock);
 		mutex_unlock(&head->mutex);
 
-		if (!testing && pin_bytes) {
+		if (!btrfs_is_testing(fs_info) && pin_bytes) {
 			struct btrfs_block_group *bg;
 
 			bg = btrfs_lookup_block_group(fs_info, head->bytenr);
@@ -1312,14 +1311,14 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 			btrfs_error_unpin_extent_range(fs_info, head->bytenr,
 				head->bytenr + head->num_bytes - 1);
 		}
-		if (!testing)
+		if (!btrfs_is_testing(fs_info))
 			btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
 		btrfs_put_delayed_ref_head(head);
 		cond_resched();
 		spin_lock(&delayed_refs->lock);
 	}
 
-	if (!testing)
+	if (!btrfs_is_testing(fs_info))
 		btrfs_qgroup_destroy_extent_records(trans);
 
 	spin_unlock(&delayed_refs->lock);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a9e82e062bd5..5c57f523f449 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -639,7 +639,6 @@ static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
 					   u64 objectid, gfp_t flags)
 {
 	struct btrfs_root *root;
-	bool dummy = btrfs_is_testing(fs_info);
 
 	root = kzalloc(sizeof(*root), flags);
 	if (!root)
@@ -696,7 +695,7 @@ static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
 	root->log_transid_committed = -1;
 	btrfs_set_root_last_log_commit(root, 0);
 	root->anon_dev = 0;
-	if (!dummy) {
+	if (!btrfs_is_testing(fs_info)) {
 		btrfs_extent_io_tree_init(fs_info, &root->dirty_log_pages,
 					  IO_TREE_ROOT_DIRTY_LOG_PAGES);
 		btrfs_extent_io_tree_init(fs_info, &root->log_csum_range,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index ba63a40b2bde..26b91edf239e 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -1126,9 +1126,9 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
 
 #define EXPORT_FOR_TESTS
 
-static inline int btrfs_is_testing(const struct btrfs_fs_info *fs_info)
+static inline bool btrfs_is_testing(const struct btrfs_fs_info *fs_info)
 {
-	return test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
+	return unlikely(test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state));
 }
 
 void btrfs_test_destroy_inode(struct inode *inode);
@@ -1137,9 +1137,9 @@ void btrfs_test_destroy_inode(struct inode *inode);
 
 #define EXPORT_FOR_TESTS static
 
-static inline int btrfs_is_testing(const struct btrfs_fs_info *fs_info)
+static inline bool btrfs_is_testing(const struct btrfs_fs_info *fs_info)
 {
-	return 0;
+	return false;
 }
 #endif
 
-- 
2.47.2


