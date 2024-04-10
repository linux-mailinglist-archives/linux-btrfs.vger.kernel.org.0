Return-Path: <linux-btrfs+bounces-4103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF03289F0DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 13:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05361C204FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Apr 2024 11:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDC15E81B;
	Wed, 10 Apr 2024 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5E5YX3O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D815E80D
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748533; cv=none; b=VnJ4cY/+UmuL0/pxvVOqrt8BmaeEW/jNseJheazJlBr+pvRl0leNR97A7RMiN2iX+tcwSkkyOTDqLWZySMOj/iFTfb3cSqUN4D4woBdY5GxODlP1KG/f6vWuKNAXlxKldq+cUMGxBVpOgShKeJvWY1mMex0MzKsJ/0KD+eM102c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748533; c=relaxed/simple;
	bh=g2W3101eV13B/UgB2JaIdmMCpGCnuK0rfSn8Sw6uT2k=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHWd54oAJGfWipR/xn7nxLT0OixtC2VclQ2zi1ehH0GvzotnQrj5Id1kePACo6qoLUBS1NqdLfhskljZ71pCzxnmsXuC07X7kM6dfAxogIJ8JQiIRYXHUNSX2Y65InfGe+hCfIDl2XgSHZZKL9aH9vFHSXikWtDvUPV4knc7QD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5E5YX3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C626C433C7
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Apr 2024 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712748532;
	bh=g2W3101eV13B/UgB2JaIdmMCpGCnuK0rfSn8Sw6uT2k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=u5E5YX3Oji5ZUCGQObfQwK75gvtTdkpJ7rGzRz1q0bU9TybiM0uT9PaFyd3hHNcph
	 DS0O+rbLiDKlHAF+70y6QuKixMXF/gzs7k1vufxKzIuhHP79UINv418W2UT8cxSMJC
	 6HuvxJOEAgWlkf8YOIhV7+ASTDTHezHjuHVuAFnAZXHRCOQpy3AK2LlsjFooPmQhzw
	 6WRQfFFDDOjr29HITvY5tLdt8S2rJ1/IWSDErDiz/E5+yyV+QVpfI28gRjCV1Yg7J3
	 K8fLhJEtUd3MOpU2+mx492VbZT0wc5a737Q6pWt7rXXK18EQcmG3Geake2zjofkbsv
	 Y0VU9AGqTGCzQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/11] btrfs: pass the extent map tree's inode to clear_em_logging()
Date: Wed, 10 Apr 2024 12:28:37 +0100
Message-Id: <70c2fbda7aee6c8161fc79c63d155df576a57dc3.1712748143.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712748143.git.fdmanana@suse.com>
References: <cover.1712748143.git.fdmanana@suse.com>
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


