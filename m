Return-Path: <linux-btrfs+bounces-4148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B938A1C5C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581C01C22F2E
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8F1836EF;
	Thu, 11 Apr 2024 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNUUCIhn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD0617A92C
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852361; cv=none; b=oUIHBZTLUFn0ErvwK0YzbW16rOOvHkbdlmsVKuvb2s/EZo4dWhrI1BCoBCQR0I4VviGaMzGgsAYkc4r2+HkHCyAMnFLkKdsFITXk/vKw5as1QZchbeN2Qvis3blsEco+5QiG6QAfNDDs14StVl2rVNANxSs5JrZpfGMfx5VwaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852361; c=relaxed/simple;
	bh=O0Z5um7QpcTBedjY24YaUsXBJtWtbkRdf9MDiLMcJEI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J9quUzAbRhvNwQg63aG3gC/gEosj4vj3cA8zWx5IzphPX/HL+YVnw6pJmlMjQCF2i5ksmrw8+kunvE0tTCMMBFywFfCP4SdhTcn7LKQixy9wmRSObIxsF79ti/GVjEF7eN/4F26FD5g4yIG2xPSldRwLCz4YE2MPQt8MIUEOwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNUUCIhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87733C113CE
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852361;
	bh=O0Z5um7QpcTBedjY24YaUsXBJtWtbkRdf9MDiLMcJEI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VNUUCIhnO0vQvdbumcHpMYzRxvBKjaqoVAzfCMrz1T7e0dkO7u3EmhrwHaBj18ibY
	 DIAb/k8J/vEt9gt7Jh/SUlA9mc0xkLL3YO2SyFdfHgNt6PiGxYUyVXcAsdaQFIr5qG
	 mENa1Hg+DBu4HoHly40n+LQIebradvwFvCuA2DUmF1bo3z2ffQwnBYwPy7dI2qAT83
	 1u0cbxNlNBs2WgpOH206JqS8/ROTv+TDkSVkN1M1HlG+pLzv//YaJWA8ySqlshqwwU
	 tierQenfEYfLSY5pKdfzWPh7JnoSZsFCMTT3PnhH/vD3MbLCoBRnqaXW/syo08aUiZ
	 xzxkYrAslX3lQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/15] btrfs: pass the extent map tree's inode to clear_em_logging()
Date: Thu, 11 Apr 2024 17:18:59 +0100
Message-Id: <90d5c3c334dabaefb26b58488074213840434336.1712837044.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712837044.git.fdmanana@suse.com>
References: <cover.1712837044.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Extent maps are always associated to an inode's extent map tree, so
there's no need to pass the extent map tree explicitly to
clear_em_logging().

In order to facilitate an upcoming change that adds a shrinker for extent
maps, change clear_em_logging() to receive the inode instead of its extent
map tree.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 4 +++-
 fs/btrfs/extent_map.h | 2 +-
 fs/btrfs/tree-log.c   | 4 ++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index d0e0c4e5415e..7cda78d11d75 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -331,8 +331,10 @@ int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen)
 
 }
 
-void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em)
+void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em)
 {
+	struct extent_map_tree *tree = &inode->extent_tree;
+
 	lockdep_assert_held_write(&tree->lock);
 
 	em->flags &= ~EXTENT_FLAG_LOGGING;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index f287ab46e368..732fc8d7e534 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -129,7 +129,7 @@ void free_extent_map(struct extent_map *em);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
 int unpin_extent_cache(struct btrfs_inode *inode, u64 start, u64 len, u64 gen);
-void clear_em_logging(struct extent_map_tree *tree, struct extent_map *em);
+void clear_em_logging(struct btrfs_inode *inode, struct extent_map *em);
 struct extent_map *search_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
 int btrfs_add_extent_mapping(struct btrfs_inode *inode,
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d9777649e170..4a4fca841510 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4945,7 +4945,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 * private list.
 		 */
 		if (ret) {
-			clear_em_logging(tree, em);
+			clear_em_logging(inode, em);
 			free_extent_map(em);
 			continue;
 		}
@@ -4954,7 +4954,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 
 		ret = log_one_extent(trans, inode, em, path, ctx);
 		write_lock(&tree->lock);
-		clear_em_logging(tree, em);
+		clear_em_logging(inode, em);
 		free_extent_map(em);
 	}
 	WARN_ON(!list_empty(&extents));
-- 
2.43.0


