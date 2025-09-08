Return-Path: <linux-btrfs+bounces-16717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF00B4892C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678B93ABC6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BB02FB98A;
	Mon,  8 Sep 2025 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN6L1E25"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB42FB0BE
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325232; cv=none; b=fkD8/H9KC0sBZwc869FN+LbeIMlU8rIq+JSf1jMJqSalijOxe6ci8i/maNoRsl9XzapRhZ/6hcxnOs+BDkGcpbyMkr+5O4uro7ruygVBiVpMWybSyc+su3Z8VI5ELzboMucMOCMgeX8utgY2EgoiNLQA/598eHaEdaZCXOKlGUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325232; c=relaxed/simple;
	bh=kBZo2HYQFKQbAAhAZvHEmx4YlLe9brfHWWNl8xJRMic=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwVF9VTsZnns3nJb4lrtVoiRVY8DTLvkV91NcIL9IQNHSo7LhRuKb9aCfuy5wD3TxEBGdXWie8FyGSVZ8EFZhgUJy2rwRbiV59ubb9G3u9aJ2H2e3WsvlQXA/aCOvdfe0EcMDFR/SAEAkSonRVbXpivIqoCDJgAJdFtI4xXAivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN6L1E25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF152C4CEFA
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325232;
	bh=kBZo2HYQFKQbAAhAZvHEmx4YlLe9brfHWWNl8xJRMic=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NN6L1E25+J9K+qaBOoQ6ABH/+cDHrFzTkzkdTvFoyNBtkLre3WMNUL5DGL7AqoJkl
	 mmQ6V7v0gkfOQRGwByOxBds+rBeXpQmbyiCkT1Kf44L5jMkqC0tE4Q0TQgy/ycMjJN
	 6wYWTxWs0YsXGzQFIMpFGGfLYI2hQwCS2nWk0wOYr4GBOEpDRH+I0Dwqsf+AH+MJT2
	 C0WqA/SmoeMzynGuV0VFK8n4KwPji6Oa/kQgX+Iw3EhA5jmlKD61WC6Wo2LL4CUCKr
	 FgQ8xB88PK9Cc37kElCUVUfdD2fc4vG9n9IJln2XYnMLlVoDpncD8ecwqVxSU7/Iaw
	 vGDyFc+HLu7xQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 23/33] btrfs: avoid unnecessary path allocation at fixup_inode_link_count()
Date: Mon,  8 Sep 2025 10:53:17 +0100
Message-ID: <54dae2b85242d006836e4e25ff8e34380535fb26.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to allocate a path as our single caller already has a
path that we can use. So pass the caller's path and use it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b4e901da9e8b..5754333ae732 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1728,19 +1728,15 @@ static int count_inode_refs(struct btrfs_inode *inode, struct btrfs_path *path)
  * will free the inode.
  */
 static noinline int fixup_inode_link_count(struct walk_control *wc,
+					   struct btrfs_path *path,
 					   struct btrfs_inode *inode)
 {
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = inode->root;
-	struct btrfs_path *path;
 	int ret;
 	u64 nlink = 0;
 	const u64 ino = btrfs_ino(inode);
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
 	ret = count_inode_refs(inode, path);
 	if (ret < 0)
 		goto out;
@@ -1776,7 +1772,7 @@ static noinline int fixup_inode_link_count(struct walk_control *wc,
 	}
 
 out:
-	btrfs_free_path(path);
+	btrfs_release_path(path);
 	return ret;
 }
 
@@ -1821,7 +1817,7 @@ static noinline int fixup_inode_link_counts(struct walk_control *wc,
 			break;
 		}
 
-		ret = fixup_inode_link_count(wc, inode);
+		ret = fixup_inode_link_count(wc, path, inode);
 		iput(&inode->vfs_inode);
 		if (ret)
 			break;
-- 
2.47.2


