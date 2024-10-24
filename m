Return-Path: <linux-btrfs+bounces-9140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A05DB9AEBE4
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF071F23129
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0491F9427;
	Thu, 24 Oct 2024 16:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot6BwN+f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6A41F8EE5
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787081; cv=none; b=THoYNufrpG1uRE++VXm1DHrrsrD3utTm7jy6WIJqWJ+aXZU745xaioLcMOkgnkcp4k3VH8tY9wJB5/LpmowS95yF2Q6uhWpG5kaE+BZpgNJ2CaJDFH3H2+hNu0m4zNRPsIyqahLAKKVQVs8rggbG1+kdnPRCk41q/tDhVRBVnbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787081; c=relaxed/simple;
	bh=3oNvzDD1N0APhcjg8LWU7bEItuMxnC7zTwqYg4DnNbU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uvP+rwklBGu+H+k6rKf1xtOZsl7srs4mJS3UESugkgfZotyV+jgzC5f9y6xD/vfUGSoxJVAs2Ym04/He/gW6KlUoaVMrTu0e/M7N8hEPqNKki6CidbwyA7VTTc+v3Cq82EeUQenonTUjwDzLNe9QZpSKdiwjbXIXQ4lzXfTucL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot6BwN+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE729C4CEE4
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787081;
	bh=3oNvzDD1N0APhcjg8LWU7bEItuMxnC7zTwqYg4DnNbU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ot6BwN+f0WOa5v3kFIA3Wst53e4g8DLGOayO/XSAHhZc+JVeA9w04zKxo0TPg5wRZ
	 4EEbUzZjtSTfbXkcCivxmfpvkJphNHHAOILfMrLUzw6ACMYI+99n2nd2sHEW3ih35b
	 ZEhbtuBclNMsnisSpQAzAAehRG01kPyczGSE3F/YzBiObDUIb9nejbaikifCep/3nG
	 7EmPeTuiVkELzXWSF8WAtL45A+FFFywc7m82KTr7QXUu7SC5yQzpSyc+C1SVd/jh33
	 0fwNgHYl8Sm7uYtaiO1tepOB5LPRyhkaVtY8+C2fL7uYcpo6SAICtcuDKgf9YusBXS
	 53fnWp9G9ptWQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/18] btrfs: pass fs_info to functions that search for delayed ref heads
Date: Thu, 24 Oct 2024 17:24:19 +0100
Message-Id: <a71b0c3ba37e54d47b8b30a0c2f17100418e291b.1729784713.git.fdmanana@suse.com>
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

One of the following patches in the series will need to access fs_info in
the function find_ref_head(), so pass a fs_info argument to it as well as
to the functions btrfs_select_ref_head() and btrfs_find_delayed_ref_head()
which call find_ref_head().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c     |  3 ++-
 fs/btrfs/delayed-ref.c | 12 ++++++++----
 fs/btrfs/delayed-ref.h |  4 +++-
 fs/btrfs/extent-tree.c | 10 +++++-----
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f8e1d5b2c512..04f53ca548e1 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1442,7 +1442,8 @@ static int find_parent_nodes(struct btrfs_backref_walk_ctx *ctx,
 		 */
 		delayed_refs = &ctx->trans->transaction->delayed_refs;
 		spin_lock(&delayed_refs->lock);
-		head = btrfs_find_delayed_ref_head(delayed_refs, ctx->bytenr);
+		head = btrfs_find_delayed_ref_head(ctx->fs_info, delayed_refs,
+						   ctx->bytenr);
 		if (head) {
 			if (!mutex_trylock(&head->mutex)) {
 				refcount_inc(&head->refs);
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index ffa06f931fa8..81f7a515dd0e 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -399,6 +399,7 @@ static struct btrfs_delayed_ref_head *find_first_ref_head(
  * is given, the next bigger entry is returned if no exact match is found.
  */
 static struct btrfs_delayed_ref_head *find_ref_head(
+		struct btrfs_fs_info *fs_info,
 		struct btrfs_delayed_ref_root *dr, u64 bytenr,
 		bool return_bigger)
 {
@@ -558,6 +559,7 @@ int btrfs_check_delayed_seq(struct btrfs_fs_info *fs_info, u64 seq)
 }
 
 struct btrfs_delayed_ref_head *btrfs_select_ref_head(
+		struct btrfs_fs_info *fs_info,
 		struct btrfs_delayed_ref_root *delayed_refs)
 {
 	struct btrfs_delayed_ref_head *head;
@@ -565,8 +567,8 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 
 	spin_lock(&delayed_refs->lock);
 again:
-	head = find_ref_head(delayed_refs, delayed_refs->run_delayed_start,
-			     true);
+	head = find_ref_head(fs_info, delayed_refs,
+			     delayed_refs->run_delayed_start, true);
 	if (!head && delayed_refs->run_delayed_start != 0) {
 		delayed_refs->run_delayed_start = 0;
 		head = find_first_ref_head(delayed_refs);
@@ -1188,11 +1190,13 @@ void btrfs_put_delayed_ref(struct btrfs_delayed_ref_node *ref)
  * head node if found, or NULL if not.
  */
 struct btrfs_delayed_ref_head *
-btrfs_find_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs, u64 bytenr)
+btrfs_find_delayed_ref_head(struct btrfs_fs_info *fs_info,
+			    struct btrfs_delayed_ref_root *delayed_refs,
+			    u64 bytenr)
 {
 	lockdep_assert_held(&delayed_refs->lock);
 
-	return find_ref_head(delayed_refs, bytenr, false);
+	return find_ref_head(fs_info, delayed_refs, bytenr, false);
 }
 
 static int find_comp(struct btrfs_delayed_ref_node *entry, u64 root, u64 parent)
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index d70de7ee63e5..acd142b01c12 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -367,7 +367,8 @@ void btrfs_merge_delayed_refs(struct btrfs_fs_info *fs_info,
 			      struct btrfs_delayed_ref_head *head);
 
 struct btrfs_delayed_ref_head *
-btrfs_find_delayed_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
+btrfs_find_delayed_ref_head(struct btrfs_fs_info *fs_info,
+			    struct btrfs_delayed_ref_root *delayed_refs,
 			    u64 bytenr);
 static inline void btrfs_delayed_ref_unlock(struct btrfs_delayed_ref_head *head)
 {
@@ -377,6 +378,7 @@ void btrfs_delete_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 			   struct btrfs_delayed_ref_head *head);
 
 struct btrfs_delayed_ref_head *btrfs_select_ref_head(
+		struct btrfs_fs_info *fs_info,
 		struct btrfs_delayed_ref_root *delayed_refs);
 void btrfs_unselect_ref_head(struct btrfs_delayed_ref_root *delayed_refs,
 			     struct btrfs_delayed_ref_head *head);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2e00267ad362..40f16deb1c0f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -182,7 +182,7 @@ int btrfs_lookup_extent_info(struct btrfs_trans_handle *trans,
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
-	head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
+	head = btrfs_find_delayed_ref_head(fs_info, delayed_refs, bytenr);
 	if (head) {
 		if (!mutex_trylock(&head->mutex)) {
 			refcount_inc(&head->refs);
@@ -2029,7 +2029,7 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 
 	do {
 		if (!locked_ref) {
-			locked_ref = btrfs_select_ref_head(delayed_refs);
+			locked_ref = btrfs_select_ref_head(fs_info, delayed_refs);
 			if (IS_ERR_OR_NULL(locked_ref)) {
 				if (PTR_ERR(locked_ref) == -EAGAIN) {
 					continue;
@@ -2231,7 +2231,7 @@ static noinline int check_delayed_ref(struct btrfs_root *root,
 
 	delayed_refs = &cur_trans->delayed_refs;
 	spin_lock(&delayed_refs->lock);
-	head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
+	head = btrfs_find_delayed_ref_head(root->fs_info, delayed_refs, bytenr);
 	if (!head) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_put_transaction(cur_trans);
@@ -3339,7 +3339,7 @@ static noinline int check_ref_cleanup(struct btrfs_trans_handle *trans,
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
-	head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
+	head = btrfs_find_delayed_ref_head(trans->fs_info, delayed_refs, bytenr);
 	if (!head)
 		goto out_delayed_unlock;
 
@@ -5474,7 +5474,7 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
 	 */
 	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
-	head = btrfs_find_delayed_ref_head(delayed_refs, bytenr);
+	head = btrfs_find_delayed_ref_head(root->fs_info, delayed_refs, bytenr);
 	if (!head)
 		goto out;
 	if (!mutex_trylock(&head->mutex)) {
-- 
2.43.0


