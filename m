Return-Path: <linux-btrfs+bounces-17725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0EBBD58DC
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 19:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2765F3A868F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 17:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624C3093AD;
	Mon, 13 Oct 2025 17:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb8GSxqC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014B3093A1
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377102; cv=none; b=mERTUlAhSOo0TMTqfa781BIAfYMgj5I4aQVkJOgC7msoNssiNvbJ5LaIFim4JLBKhjfV1/noXaKkqLdW/Ah1Va2Sm3j8Ln5O9A1ckCdK+2lgqCB8C8ilk4unXtGHu8z5rW1FtKy7XNvqlFHI78ZnLK77CxCF1r0VTTdQ7TkONec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377102; c=relaxed/simple;
	bh=Cbsm0bRuzw1lNnByfnNoLjTp8gl4u/o8R8kNrwjcLe8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUeWK/hDCh3ugS12XbwwVM/3n42ofTx73XwWwfQOKqzwY+k3X9h6okN4n/1kaesbUPlLgWG+uB5HX9xEMbSdiC41sc4U5ySynVCGT3RvcmvR5dt/SAS7WEMiKcFzhusrR+ZZb3mGK0NDihPmPagLSJvXyRHSqLA+n2SCsxs5JzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb8GSxqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CABCC4CEE7
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 17:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760377102;
	bh=Cbsm0bRuzw1lNnByfnNoLjTp8gl4u/o8R8kNrwjcLe8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Sb8GSxqC6iwOx+AVr72tuG7VXIotvgsM4hwJVyDk/0wCsdNVZHiTczt09ejPfsg82
	 tncwXKrgSaZi53n5n/aK/FJcKcw4xPg76VE0PM/aoK9r/Zd/DMjDHKNYjShfh/H8TE
	 FXxdgxmG8/lqGbndaC/SkRVOd/PeahuyakM2SnHT8NATqS8diixB0+USSGLRbe5hgH
	 hqA4PSyNY/5se/xw5apoLIB7rIwLbj1gglLaOFqR/5eGSxZ0I/ROQW3goTDZJA89JE
	 rbXFHi/x94ruiNFHG+JrFDkq0BON8xTaAPg/6gRPk27UmfNZEFVgkZW4DLj/6Gpuei
	 Y89STwuenZK5Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/16] btrfs: remove fs_info argument from shrink_delalloc() and flush_space()
Date: Mon, 13 Oct 2025 18:38:03 +0100
Message-ID: <9e29572e996c6254502b11e3c4bc1d3217cfcb77.1760376569.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1760376569.git.fdmanana@suse.com>
References: <cover.1760376569.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 55ecb6eac242..4c144b3a4a4c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -667,11 +667,11 @@ static inline u64 calc_reclaim_items_nr(const struct btrfs_fs_info *fs_info,
 /*
  * shrink metadata reservation for delalloc
  */
-static void shrink_delalloc(struct btrfs_fs_info *fs_info,
-			    struct btrfs_space_info *space_info,
+static void shrink_delalloc(struct btrfs_space_info *space_info,
 			    u64 to_reclaim, bool wait_ordered,
 			    bool for_preempt)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct btrfs_trans_handle *trans;
 	u64 delalloc_bytes;
 	u64 ordered_bytes;
@@ -798,10 +798,10 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
  * and may fail for various reasons. The caller is supposed to examine the
  * state of @space_info to detect the outcome.
  */
-static void flush_space(struct btrfs_fs_info *fs_info,
-		       struct btrfs_space_info *space_info, u64 num_bytes,
-		       enum btrfs_flush_state state, bool for_preempt)
+static void flush_space(struct btrfs_space_info *space_info, u64 num_bytes,
+			enum btrfs_flush_state state, bool for_preempt)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_trans_handle *trans;
 	int nr;
@@ -830,7 +830,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 	case FLUSH_DELALLOC_FULL:
 		if (state == FLUSH_DELALLOC_FULL)
 			num_bytes = U64_MAX;
-		shrink_delalloc(fs_info, space_info, num_bytes,
+		shrink_delalloc(space_info, num_bytes,
 				state != FLUSH_DELALLOC, for_preempt);
 		break;
 	case FLUSH_DELAYED_REFS_NR:
@@ -1149,7 +1149,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 
 	flush_state = FLUSH_DELAYED_ITEMS_NR;
 	do {
-		flush_space(fs_info, space_info, to_reclaim, flush_state, false);
+		flush_space(space_info, to_reclaim, flush_state, false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = false;
@@ -1312,7 +1312,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		to_reclaim >>= 2;
 		if (!to_reclaim)
 			to_reclaim = btrfs_calc_insert_metadata_size(fs_info, 1);
-		flush_space(fs_info, space_info, to_reclaim, flush, true);
+		flush_space(space_info, to_reclaim, flush, true);
 		cond_resched();
 		spin_lock(&space_info->lock);
 	}
@@ -1385,7 +1385,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 	spin_unlock(&space_info->lock);
 
 	while (!space_info->full) {
-		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
+		flush_space(space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = false;
@@ -1401,7 +1401,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 	}
 
 	while (flush_state < ARRAY_SIZE(data_flush_states)) {
-		flush_space(fs_info, space_info, U64_MAX,
+		flush_space(space_info, U64_MAX,
 			    data_flush_states[flush_state], false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
@@ -1507,8 +1507,7 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 
 	while (flush_state < states_nr) {
 		spin_unlock(&space_info->lock);
-		flush_space(fs_info, space_info, to_reclaim, states[flush_state],
-			    false);
+		flush_space(space_info, to_reclaim, states[flush_state], false);
 		flush_state++;
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
@@ -1545,8 +1544,6 @@ static void priority_reclaim_metadata_space(struct btrfs_space_info *space_info,
 static void priority_reclaim_data_space(struct btrfs_space_info *space_info,
 					struct reserve_ticket *ticket)
 {
-	struct btrfs_fs_info *fs_info = space_info->fs_info;
-
 	spin_lock(&space_info->lock);
 
 	/* We could have been granted before we got here. */
@@ -1557,7 +1554,7 @@ static void priority_reclaim_data_space(struct btrfs_space_info *space_info,
 
 	while (!space_info->full) {
 		spin_unlock(&space_info->lock);
-		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
+		flush_space(space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
 			spin_unlock(&space_info->lock);
-- 
2.47.2


