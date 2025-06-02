Return-Path: <linux-btrfs+bounces-14370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88ABACAC88
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A8817C597
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CF51FBCAA;
	Mon,  2 Jun 2025 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOu0sDwe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F3D1F8751
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860403; cv=none; b=XaA4K9g7Fjwff5rWvQ8YXoMQF8NIHgbKOGHXNwA/c1/9+9H/4jDEB90ndSSEJKTx+z60RdU4HiG+hRItjlHZOapHyQnjQm+t5ffWpfJ05Yl7rEuuLyeIs0XG7iC1Hq0UXLzgXxh+7aQTH4ss2iNToVPQo85dC7CEBNsOK4OsSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860403; c=relaxed/simple;
	bh=uv40mgwfpjxJHwoz6RT3+SfYca+bY/4Q2IbD3LJ4qH4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyGSTaFNKGLlsUOQ6LPEx0y5lH7mDjosVqJQYk9MZ3roYiDIvpE7rrEyvAL/fe5qMGwxEuik6emXBP6QuSlmNRHFnoGMKRwadBEdyW1rL4r0RkG22bsfjLTfDCNMBI6urniY+I+X5vYGoiltF5CzKoF9kHkm5EhDLZR6NVrq8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOu0sDwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022FCC4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860402;
	bh=uv40mgwfpjxJHwoz6RT3+SfYca+bY/4Q2IbD3LJ4qH4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OOu0sDweXm9UnckrEN6kHRLKytuPEvrEIqVsjhoRTr8oFbKjFWM0HMG8WKxkON19c
	 uYdJ/ZDKOJQZnSzpHmaikgjSf2h8sUDZtIsDU9rBQpO/bBVV3DnOjZBUwrwSs4/afK
	 I3w4Bzi4lSridYlM1raF/hu1y0QEqPd7i7VxmUSxmiezuJzxBIOkTUYy75vvt0U/DF
	 3QWzzXwoHxlJO6mBcrQE0T4sZKExP1/2R6zGGAIVOpr5TrMsKhfaptTncMYE9f1G1l
	 7pTZM65804C6tbBenNIvlde8iBHjqs6/K/yWGa3OXFKD8rrhObbS/jTYyVkoODxJZu
	 dOYkH8gB+tqqA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/14] btrfs: allocate scratch eb earlier at btrfs_log_new_name()
Date: Mon,  2 Jun 2025 11:33:01 +0100
Message-ID: <4a23cea22652b4c970c8f8d9829d719204cde83c.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of allocating the scratch eb after joining the log transaction,
allocate it before so that we're not delaying log commits for longer
than necessary, as allocating the scratch eb means allocating an
extent_buffer structure, which comes from a dedicated kmem_cache, plus
pages/folios to attach to the eb. Both of these allocations may take time
when we're under memory pressure.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 37da27acef95..a40afb44702c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7495,6 +7495,9 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	bool log_pinned = false;
 	int ret;
 
+	btrfs_init_log_ctx(&ctx, inode);
+	ctx.logging_new_name = true;
+
 	/*
 	 * this will force the logging code to walk the dentry chain
 	 * up for the file
@@ -7525,6 +7528,13 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	}
 	ret = 0;
 
+	/*
+	 * Now that we know we need to update the log, allocate the scratch eb
+	 * for the context before joining a log transaction below, as this can
+	 * take time and therefore we could delay log commits from other tasks.
+	 */
+	btrfs_init_log_ctx_scratch_eb(&ctx);
+
 	/*
 	 * If we are doing a rename (old_dir is not NULL) from a directory that
 	 * was previously logged, make sure that on log replay we get the old
@@ -7602,9 +7612,6 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 			goto out;
 	}
 
-	btrfs_init_log_ctx(&ctx, inode);
-	ctx.logging_new_name = true;
-	btrfs_init_log_ctx_scratch_eb(&ctx);
 	/*
 	 * We don't care about the return value. If we fail to log the new name
 	 * then we know the next attempt to sync the log will fallback to a full
@@ -7613,7 +7620,6 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 	 * inconsistent state after a rename operation.
 	 */
 	btrfs_log_inode_parent(trans, inode, parent, LOG_INODE_EXISTS, &ctx);
-	free_extent_buffer(ctx.scratch_eb);
 	ASSERT(list_empty(&ctx.conflict_inodes));
 out:
 	/*
@@ -7626,5 +7632,6 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 		btrfs_set_log_full_commit(trans);
 	if (log_pinned)
 		btrfs_end_log_trans(root);
+	free_extent_buffer(ctx.scratch_eb);
 }
 
-- 
2.47.2


