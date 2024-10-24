Return-Path: <linux-btrfs+bounces-9141-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B629AEBE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102C81F246D5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57931F9EA5;
	Thu, 24 Oct 2024 16:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rI94Vxto"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A121F80D3
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787083; cv=none; b=C+LXR2NlESZzQCoRNcklPFSO9OnXYKb/V1ECokJ+Ka4uzDAJBKYNL8vgfTNPH528FkrAyLNsds8f44X0W9u0LXPfAilXTUW8KkYLwQdiBnfor/uiHdLwA5y0QAIlhkDprl3+5TTQXpT/crY9mca+uaQH2YJU6nGmqftRGrPQb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787083; c=relaxed/simple;
	bh=nJ5X3l70LaR3P9EOCbzGKZehTh+HlYcQrqbGYyK5nsc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiZoMDWq8orzZWogZGi4BH8vKYGsIjnZjh3FHHvnqw69OhKsAlxt+RHrNSrEdj3jJdllROi01BOBkRqjFU/bAEJBJn3desRbXtFEA+PzV3B/N7GLE1J6OMtNH6wwrKQwsXrFgJ+NOO0WVgwK7oC4o889qaalM8VmmGEQTbG6rn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rI94Vxto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6418C4CEE4
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787082;
	bh=nJ5X3l70LaR3P9EOCbzGKZehTh+HlYcQrqbGYyK5nsc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rI94Vxto+BH5dslkNt2F17JShggMamcsiFi06neWHcqyr/jGs+GpmGSPuIzTMiL7E
	 gc6A64paXS/blQc3fHiXovOTHgADJJ6RVr7iYiDlIYNKY2cca8PJLkzA0otfNh44RA
	 YbyXyqICizGhOaaBf+3X7mIEpCX3prntzCq+OuH6Ga+xsxnuUlY7C4w7qRkIfGW73C
	 6M6uR8Cesfgjh+eiWPqM4Rqetv+Q4kq8hagdgkEcjzOZf+teU+ZUEGvsfo06wutK//
	 ZMgiM5RMLyTmyiYVHNaAotZbzXHtLU2s3pwpXdJnL8FyYygpzQB42wlXqMbkN18jKq
	 1Rk8liqLazuXA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/18] btrfs: pass fs_info to btrfs_cleanup_ref_head_accounting
Date: Thu, 24 Oct 2024 17:24:20 +0100
Message-Id: <5f1e86a4efb9673c2270b09aa6b87f35e0c7d113.1729784713.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

One of the following patches in the series will need to access fs_info at
btrfs_cleanup_ref_head_accounting(), so pass a fs_info argument to it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 5 +++--
 fs/btrfs/delayed-ref.h | 3 ++-
 fs/btrfs/extent-tree.c | 9 +++++----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 81f7a515dd0e..e81aa112d137 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -624,7 +624,8 @@ void btrfs_unselect_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 	btrfs_delayed_ref_unlock(head);
 }
 
-void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
+void btrfs_delete_ref_head(struct btrfs_fs_info *fs_info,
+			   struct btrfs_delayed_ref_root *delayed_refs,
 			   struct btrfs_delayed_ref_head *head)
 {
 	lockdep_assert_held(&delayed_refs->lock);
@@ -1294,7 +1295,7 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
 		if (head->must_insert_reserved)
 			pin_bytes = true;
 		btrfs_free_delayed_extent_op(head->extent_op);
-		btrfs_delete_ref_head(delayed_refs, head);
+		btrfs_delete_ref_head(fs_info, delayed_refs, head);
 		spin_unlock(&head->lock);
 		spin_unlock(&delayed_refs->lock);
 		mutex_unlock(&head->mutex);
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index acd142b01c12..c3749e6cc374 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -374,7 +374,8 @@ static inline void btrfs_delayed_ref_unlock(struct btrfs_delayed_ref_head *head)
 {
 	mutex_unlock(&head->mutex);
 }
-void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
+void btrfs_delete_ref_head(struct btrfs_fs_info *fs_info,
+			   struct btrfs_delayed_ref_root *delayed_refs,
 			   struct btrfs_delayed_ref_head *head);
 
 struct btrfs_delayed_ref_head *btrfs_select_ref_head(
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 40f16deb1c0f..33f911476a4d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1900,7 +1900,7 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 		spin_unlock(&delayed_refs->lock);
 		return 1;
 	}
-	btrfs_delete_ref_head(delayed_refs, head);
+	btrfs_delete_ref_head(fs_info, delayed_refs, head);
 	spin_unlock(&head->lock);
 	spin_unlock(&delayed_refs->lock);
 
@@ -3333,13 +3333,14 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 static noinline int check_ref_cleanup(struct btrfs_trans_handle *trans,
 				      u64 bytenr)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_head *head;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	int ret = 0;
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
-	head = btrfs_find_delayed_ref_head(trans->fs_info, delayed_refs, bytenr);
+	head = btrfs_find_delayed_ref_head(fs_info, delayed_refs, bytenr);
 	if (!head)
 		goto out_delayed_unlock;
 
@@ -3357,7 +3358,7 @@ static noinline int check_ref_cleanup(struct btrfs_trans_handle *trans,
 	if (!mutex_trylock(&head->mutex))
 		goto out;
 
-	btrfs_delete_ref_head(delayed_refs, head);
+	btrfs_delete_ref_head(fs_info, delayed_refs, head);
 	head->processing = false;
 
 	spin_unlock(&head->lock);
@@ -3367,7 +3368,7 @@ static noinline int check_ref_cleanup(struct btrfs_trans_handle *trans,
 	if (head->must_insert_reserved)
 		ret = 1;
 
-	btrfs_cleanup_ref_head_accounting(trans->fs_info, delayed_refs, head);
+	btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
 	mutex_unlock(&head->mutex);
 	btrfs_put_delayed_ref_head(head);
 	return ret;
-- 
2.43.0


