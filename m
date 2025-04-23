Return-Path: <linux-btrfs+bounces-13300-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CBEA98CB0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5AA1B648D0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810B927CB17;
	Wed, 23 Apr 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1f0Zv5E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58A927CB33
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418010; cv=none; b=f8Yn1Xtrqx3VOKCSfMdDvu07kLtM5V1oahIKuKaxgaTAedmGkgdTks4kuE8IEonvq/LhOZlPEKb85pc9KZuo0pNYsvAD2wXNZ6ml4gkfnfIzzp6DtPiW4QN+ikUP+ziJSQ2U7pXRehuZ1A9k1RQow1nPX+rcRoIoNakh3kMNcI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418010; c=relaxed/simple;
	bh=/8Rj5n2o39kkjsvLcLtjgVd6WclkjED4bY5NAYxn/Ps=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dnfj1nqXBaetfCmjN+uoMxXdGHbq7IVIluwZ0grKhuOLGpf3q2pKykoq88+34OGHh90rrM0lINP0YmxzUiBHNIhLELOFyTkvYsBzbvXNTvB+sgv1x/xsKAc1uPEvud2RcOOTtUQaFp3Y7NaVGmCm1f9O30bNYqlpemQireWxf5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1f0Zv5E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA40FC4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418009;
	bh=/8Rj5n2o39kkjsvLcLtjgVd6WclkjED4bY5NAYxn/Ps=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n1f0Zv5EQ3epjqvM3kQG16THvlyM/E/5+UXEeqaR4Il2WUQNzuJWXodudcbWcm6cx
	 /beImHAgJhTNZSfWfbUVlHUb7UcVC4TB8vm0oHBl5PtpV7MKuO03zre41e0aoaEfuQ
	 UcgRriSV8QmUwctGJYjbnQLqT/mGi0devqYHMGNay8GOkZxgHq8MBnDID13FsfgHAx
	 8xG4rXIP49NNcQdvUAWW1SNgKqPbMqQ5Rfx7EJb7j0i8V4444RXl/2jp+YA2hA/Li9
	 M2mIZJHrDhM4gP5n8Tw0yH9y+gjQUQeuo43SpD2/dBjK8VY9422DA1u67XYk7SwapK
	 JzW1K+9EF+LrQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/22] btrfs: add missing error return to btrfs_clear_extent_bit_changeset()
Date: Wed, 23 Apr 2025 15:19:43 +0100
Message-Id: <936623cfcdec988a0244ac39de3cf3ac14572c13.1745401627.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have a couple error branches where we have an error stored in the 'err'
variable and then jump to the 'out' label, however we don't return that
error, we just return 0. Normally this is not a problem since those error
branches call extent_io_tree_panic() which triggers a BUG() call, however
it's possible to have rather exotic kernel config with CONFIG_BUG disabled
in which case the BUG() call does nothing and we fallthrough. So make sure
to return the error, not just to fix that exotic case but also to make the
code less confusing. While at it also rename the 'err' variable to 'ret'
since this is the style we prefer and use more widely.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index b3811bbbd53b..35c8824add34 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -604,7 +604,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 	struct extent_state *cached;
 	struct extent_state *prealloc = NULL;
 	u64 last_end;
-	int err;
+	int ret = 0;
 	int clear = 0;
 	int wake;
 	int delete = (bits & EXTENT_CLEAR_ALL_BITS);
@@ -690,10 +690,10 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 		prealloc = alloc_extent_state_atomic(prealloc);
 		if (!prealloc)
 			goto search_again;
-		err = split_state(tree, state, prealloc, start);
+		ret = split_state(tree, state, prealloc, start);
 		prealloc = NULL;
-		if (err) {
-			extent_io_tree_panic(tree, state, "split", err);
+		if (ret) {
+			extent_io_tree_panic(tree, state, "split", ret);
 			goto out;
 		}
 		if (state->end <= end) {
@@ -711,9 +711,9 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 		prealloc = alloc_extent_state_atomic(prealloc);
 		if (!prealloc)
 			goto search_again;
-		err = split_state(tree, state, prealloc, end + 1);
-		if (err) {
-			extent_io_tree_panic(tree, state, "split", err);
+		ret = split_state(tree, state, prealloc, end + 1);
+		if (ret) {
+			extent_io_tree_panic(tree, state, "split", ret);
 			prealloc = NULL;
 			goto out;
 		}
@@ -748,7 +748,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 	if (prealloc)
 		btrfs_free_extent_state(prealloc);
 
-	return 0;
+	return ret;
 
 }
 
-- 
2.47.2


