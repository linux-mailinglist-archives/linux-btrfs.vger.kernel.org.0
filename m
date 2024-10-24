Return-Path: <linux-btrfs+bounces-9139-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB269AEBE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD52E1F23B59
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9417F1F80AD;
	Thu, 24 Oct 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFfaIS4H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45A1F8911
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787080; cv=none; b=JCtkhZFzbVAs0GF6ENuLjYBDleCfqMRz5m9oNVwOGoUtM0GzZrS9B1oWybP4ftYPkKgyQDPyfTZfkbFj34KnK7bwRd13Zld8JqGQ98mjcF/8vozO/uq5UTs3aBU0MgnpnLH7VinTBeT18a77O57RA8hznfD8DGCGdbLcjpbwcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787080; c=relaxed/simple;
	bh=tIEXAMiiyzCNNviFnqKb9GcIDIuV+rg7CMCHNF70ch0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwbazHHlnjP5uS5cJJ4S87osBEw2+ZFEET6OyYB537baV6qVc2XmTGhUWPkuVqwxbCaA5ybNvf9yZhBqHb3BJpi03ya5qx5ehMMv6FqLTnUkZrdvOSVDeMZE0eOIMGwdKYUmK3nWcCT0v8fy/Q6v45eF/JkHDRb1ceWkfKUyEnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFfaIS4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A797DC4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787080;
	bh=tIEXAMiiyzCNNviFnqKb9GcIDIuV+rg7CMCHNF70ch0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EFfaIS4HNkx2E704j8osihBm7VPKAh5kL1tA6hhqzBk0+P46wMHiqtIKivlVKma+j
	 l6vEJQBV6Wt77qqrC7QBsf+IC54TUQxTzqSwC5O82I29DqnQ2lRCBRielHyO/xPkMX
	 9eFsWO6Zu9DftUXoAAEKxuUKfbk2WCVsn4ClopSzV3Zq1oTrssHF3Q9EppSAeXIcb3
	 OsIU4iEiV04UQQoJCyWNSNV6hDyRUL4tYiBeBlomLlBSFtlr9+nFmTRbzcRsmESj7f
	 GjDw9KITipj6yp85OTrdcrCwDKH3p+uJaoFHXs+Xy5AARjIxAnS5k1Ts9EsZ11qLMB
	 fPCdURjfuvQ/A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/18] btrfs: move delayed ref head unselection to delayed-ref.c
Date: Thu, 24 Oct 2024 17:24:18 +0100
Message-Id: <024e3f6fb496a05a691765d97e25220f325cf4f8.1729784713.git.fdmanana@suse.com>
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

The unselect_delayed_ref_head() at extent-tree.c doesn't really belong in
that file as it's a delayed refs specific detail and therefore should be
at delayed-ref.c. Further its inverse, btrfs_select_ref_head(), is at
delayed-ref.c, so it only makes sense to have it there too.

So move unselect_delayed_ref_head() into delayed-ref.c and rename it to
btrfs_unselect_ref_head() so that its name closely matches its inverse
(btrfs_select_ref_head()).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 10 ++++++++++
 fs/btrfs/delayed-ref.h |  2 ++
 fs/btrfs/extent-tree.c | 16 +++-------------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 9174c6dbbce5..ffa06f931fa8 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -612,6 +612,16 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 	return head;
 }
 
+void btrfs_unselect_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
+			     struct btrfs_delayed_ref_head *head)
+{
+	spin_lock(&delayed_refs->lock);
+	head->processing = false;
+	delayed_refs->num_heads_ready++;
+	spin_unlock(&delayed_refs->lock);
+	btrfs_delayed_ref_unlock(head);
+}
+
 void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 			   struct btrfs_delayed_ref_head *head)
 {
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 956fbe5d6984..d70de7ee63e5 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -378,6 +378,8 @@ void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 
 struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 		struct btrfs_delayed_ref_root *delayed_refs);
+void btrfs_unselect_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
+			     struct btrfs_delayed_ref_head *head);
 
 int btrfs_check_delayed_seq(struct btrfs_fs_info *fs_info, u64 seq);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f5320a9cdf8f..2e00267ad362 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1807,16 +1807,6 @@ select_delayed_ref(struct btrfs_delayed_ref_head *head)
 	return ref;
 }
 
-static void unselect_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
-				      struct btrfs_delayed_ref_head *head)
-{
-	spin_lock(&delayed_refs->lock);
-	head->processing = false;
-	delayed_refs->num_heads_ready++;
-	spin_unlock(&delayed_refs->lock);
-	btrfs_delayed_ref_unlock(head);
-}
-
 static struct btrfs_delayed_extent_op *cleanup_extent_op(
 				struct btrfs_delayed_ref_head *head)
 {
@@ -1891,7 +1881,7 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 
 	ret = run_and_cleanup_extent_op(trans, head);
 	if (ret < 0) {
-		unselect_delayed_ref_head(delayed_refs, head);
+		btrfs_unselect_ref_head(delayed_refs, head);
 		btrfs_debug(fs_info, "run_delayed_extent_op returned %d", ret);
 		return ret;
 	} else if (ret) {
@@ -1953,7 +1943,7 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 		if (ref->seq &&
 		    btrfs_check_delayed_seq(fs_info, ref->seq)) {
 			spin_unlock(&locked_ref->lock);
-			unselect_delayed_ref_head(delayed_refs, locked_ref);
+			btrfs_unselect_ref_head(delayed_refs, locked_ref);
 			return -EAGAIN;
 		}
 
@@ -2001,7 +1991,7 @@ static int btrfs_run_delayed_refs_for_head(struct btrfs_trans_handle *trans,
 
 		btrfs_free_delayed_extent_op(extent_op);
 		if (ret) {
-			unselect_delayed_ref_head(delayed_refs, locked_ref);
+			btrfs_unselect_ref_head(delayed_refs, locked_ref);
 			btrfs_put_delayed_ref(ref);
 			return ret;
 		}
-- 
2.43.0


