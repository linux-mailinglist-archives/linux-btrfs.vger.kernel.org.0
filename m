Return-Path: <linux-btrfs+bounces-14928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E6FAE69D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 16:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69D81C232BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20AB2E1722;
	Tue, 24 Jun 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opWLHwHx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66532E11DD
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776159; cv=none; b=KX6FEMbHPCxD0+g0Zt8ZZ64dsOBhv8EfjJH+IPJVJ0FyH9xURuHvpdrb60EEpCpkBEfL1eEtlEdfwHbDbEepcbG7u5oePTHbeL4d9Gx1r3x9893lmhRgA8SeSCF2geiib9hjKostNFnmTvAmyX+m91DewE13NNMIQWpk8DszV5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776159; c=relaxed/simple;
	bh=01IBXC120vjv9Qy6b9SEbaSxcp8ioPKactC0JPMJv3o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ0WGOaAHs1/oHkgDrirf5f/mca5gh+mT+THbgNupxk3qzIJ0IMHJ1e5Pd+gLpVt/VI6W7fqtwtSc23zmzzVb7Xp5Bi1lz1d4CJBZ/9tq+oda1HM0wl2dXTCYPP9Y+6cj3Vx5HEgvHEVfDlGg0cGFawZ8SvDI/6kkxnOS3ms2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opWLHwHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8F9C4CEF0
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750776158;
	bh=01IBXC120vjv9Qy6b9SEbaSxcp8ioPKactC0JPMJv3o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=opWLHwHxP7wheWfdpjqUhhw28OcNp7dMm6N4MnJ+rz1YYQaL8eO+lF5m0vGFcJaNg
	 nvn4ZIWbaR2lhq6GXmO/v77CnSNBWcyq8YOuWn2rgLeQoLJ/n9VsSwE6mJ3YPl35wv
	 1JPkBJIaQOJsokdNQsRS+WHNjJYBb+DmDT4qZA6yFa+MHn30y6E3wAkiiOxJvXRF2C
	 8xojnjR10kSTGfY9y5mRb97fuOuye+fNRK5oZxGakT2R5qdg8u6BtFtegqYZw/c68s
	 6wWgl+WlTqFJnPhFalgB+U9sOgV8VraKxF8GV1n6CzCekPJOOpYZvEsWoRjyfARl9J
	 LizGLev/PxuqA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/12] btrfs: split btrfs_is_fsstree() into multiple if statements for readability
Date: Tue, 24 Jun 2025 15:42:22 +0100
Message-ID: <7984e152e4e0c6092d931f1229e21b7bf6dd9798.1750709411.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750709410.git.fdmanana@suse.com>
References: <cover.1750709410.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of a single if statement with multiple conditions, split it into
several if statements testing only one condition at a time and return true
or false immediately after. This makes it more immediate to reason.

The module's text size also slightly decreases, at least with gcc 14.2.0
on x86_64.

Before:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1897138	 161583	  16136	2074857	 1fa8e9	fs/btrfs/btrfs.ko

After:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1896976	 161583	  16136	2074695	 1fa847	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d51cc692f2c5..fe70b593c7cd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -723,11 +723,16 @@ int btrfs_leaf_free_space(const struct extent_buffer *leaf);
 
 static inline bool btrfs_is_fstree(u64 rootid)
 {
-	if (rootid == BTRFS_FS_TREE_OBJECTID ||
-	    ((s64)rootid >= (s64)BTRFS_FIRST_FREE_OBJECTID &&
-	      !btrfs_qgroup_level(rootid)))
+	if (rootid == BTRFS_FS_TREE_OBJECTID)
 		return true;
-	return false;
+
+	if ((s64)rootid < (s64)BTRFS_FIRST_FREE_OBJECTID)
+		return false;
+
+	if (btrfs_qgroup_level(rootid) != 0)
+		return false;
+
+	return true;
 }
 
 static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
-- 
2.47.2


