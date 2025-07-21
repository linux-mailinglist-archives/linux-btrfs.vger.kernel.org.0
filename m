Return-Path: <linux-btrfs+bounces-15597-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C5BB0C960
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 19:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AC51C213A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 17:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11F2E266E;
	Mon, 21 Jul 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rk/bFF1T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312802E1C7E
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118205; cv=none; b=A8W8PS+ts6i7wFVyQaXY6HuNBeSivHzMAHGb00PeYXwVQKcixlfxEVXcTFVRBRO42cMh2q82bIbEYCp4ze+TVSJ7mB3P+fr/y5ZwsJyQHg4Bbic9la88HYlndDUlhUCmwqxl4qVOvMFQhMw7lijSaRVNF1Ng18V8zR9XTqy5DkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118205; c=relaxed/simple;
	bh=dF6pm9H2WBIjjzQBBwNRppMTv8MzBalWpWaFKzf5zUM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVWnPkwn0jM9rojSL2qyn9Pnwq63LQ1STLuaJqzy1HJqvmecKsneKQPgofBuj6kYSJ48YekK7n8UshKQeGK2NJKShmtZqGgC0m0M7bj+skRkvR4EI1Y5Wg/fvKN+bgwzy0HlbYuqV3PjDgFDjHz6hNh6KuKN7ZrXoW91C28KKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rk/bFF1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E331C4CEF6
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753118204;
	bh=dF6pm9H2WBIjjzQBBwNRppMTv8MzBalWpWaFKzf5zUM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rk/bFF1TqQRIRNBqB6zRAdEcWx7pfAyUcJ3vgTKR04oXxAC+kH7gZ+u6f6/ZO1+/M
	 OeeK4sXNvDFKiMedluKYcvZbAEV+PjjpA1dw2EtWX/CNoFYOSnzzk5P9W2DCph9VWy
	 klV4zb4SRi1J826SxDbTib1vQ1T1XB4jmRQhjKL7JktZLXP5EZbigHSzv/Hauc802b
	 k5PhVxcSRTNigpdAylC7uVhEYaqdPfTuOocolYVfL7qp5yDtgobMPOm+9iFveQeNh2
	 tE7w36FQhg6Zvsl/ZB8WnPrjhZeEqFxESglW44kCMyU8aqWSvwdoWaeaP7zAWASf62
	 N34LEVAsPb7Fw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 01/10] btrfs: error on missing block group when unaccounting log tree extent buffers
Date: Mon, 21 Jul 2025 18:16:28 +0100
Message-ID: <12cbb2e324d08c343ba0344a317af7b55e4c39aa.1753117707.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1753117707.git.fdmanana@suse.com>
References: <cover.1753117707.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we only log an error message if we can't find the block group
for a log tree extent buffer when unaccounting it (while freeing a log
tree). A missing block group means something is seriously wrong and we
end up leaking space from the metadata space info. So return -ENOENT in
case we don't find the block group.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8ad6005257b8..45f2e13f5018 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2593,14 +2593,14 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 /*
  * Correctly adjust the reserved bytes occupied by a log tree extent buffer
  */
-static void unaccount_log_buffer(struct btrfs_fs_info *fs_info, u64 start)
+static int unaccount_log_buffer(struct btrfs_fs_info *fs_info, u64 start)
 {
 	struct btrfs_block_group *cache;
 
 	cache = btrfs_lookup_block_group(fs_info, start);
 	if (!cache) {
 		btrfs_err(fs_info, "unable to find block group for %llu", start);
-		return;
+		return -ENOENT;
 	}
 
 	spin_lock(&cache->space_info->lock);
@@ -2611,27 +2611,22 @@ static void unaccount_log_buffer(struct btrfs_fs_info *fs_info, u64 start)
 	spin_unlock(&cache->space_info->lock);
 
 	btrfs_put_block_group(cache);
+
+	return 0;
 }
 
 static int clean_log_buffer(struct btrfs_trans_handle *trans,
 			    struct extent_buffer *eb)
 {
-	int ret;
-
 	btrfs_tree_lock(eb);
 	btrfs_clear_buffer_dirty(trans, eb);
 	wait_on_extent_buffer_writeback(eb);
 	btrfs_tree_unlock(eb);
 
-	if (trans) {
-		ret = btrfs_pin_reserved_extent(trans, eb);
-		if (ret)
-			return ret;
-	} else {
-		unaccount_log_buffer(eb->fs_info, eb->start);
-	}
+	if (trans)
+		return btrfs_pin_reserved_extent(trans, eb);
 
-	return 0;
+	return unaccount_log_buffer(eb->fs_info, eb->start);
 }
 
 static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
-- 
2.47.2


