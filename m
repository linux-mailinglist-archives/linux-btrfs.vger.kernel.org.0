Return-Path: <linux-btrfs+bounces-16713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C39B48927
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1CF3A67DD
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB362FAC08;
	Mon,  8 Sep 2025 09:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAjI1hyz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DF22F9C39
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325227; cv=none; b=tXLB4sFlabFmGCl9G6+N0MdTdzdUpTQuhi7a8xZ6wOeRTvHZoEIcr6gauRBRtoNevHLqAFGSsvlpn15m1O9i9YgioehgX47tP7jxhqYPN6awLGXaOiubdKcWib/f9BbvVvaRhIjBjqxDEUSL6yN8ZIDHjyBVmd6Ac63brsto30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325227; c=relaxed/simple;
	bh=ewkK3mvW1brfo6cjqRiYVtBhT1xQrntREYxD5Abz4IE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObaH1ntuBMP4fAeYqrdWETzp6QbF59d34t6CcB9p0Q6QUvzqZTENkJnu/KNuokUlnYP0L3MykUQtWo2HkXrbV33j75MoxvXiZ6cQkz/pulasjSqUf0SmdEeMXoThRE+QzgO31dbYQG9KMcIo+zPhkL4J1iD1hSlnY7PvH3054VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAjI1hyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E4CC4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325227;
	bh=ewkK3mvW1brfo6cjqRiYVtBhT1xQrntREYxD5Abz4IE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oAjI1hyzo/p0eNAFu65ut66uYi5H4FvMHTtVoVXU8rpleRtmYvpOOJP8HLwt5FxMV
	 RzmRuVfSGwrppXO8PX0RTUa0e1rAot/gvFOpHSSWR/t7XC8QII8Xas7Ab0tZD4y1il
	 6a9GEnB4iQDmNeqoQbwNZuLDL55SITCSRvSMn76OGDXd9LWg9TKVN/KDehOnzvzKSu
	 zWA6fTx3UGOi7If2fFJAWufBlQhlsLojtx8ZkX3LRqID5NNEFe+xPCWvqfquo8opX2
	 53RP1TxFveqv+AxJf9v1ppm0EVlPYMx46WTouGf9O57yiMcN7h3WDYPjDwJhFVVRxe
	 bf8IJkouab5cg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 18/33] btrfs: pass walk_control structure to overwrite_item()
Date: Mon,  8 Sep 2025 10:53:12 +0100
Message-ID: <2285bb3352d3d56c7036fb64527cea7ef0d5ddd8.1757271913.git.fdmanana@suse.com>
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

Instead of passing the transaction and subvolume root as arguments to
overwrite_item(), pass the walk_control structure as we can grab them
from the structure. This reduces the number of arguments passed and it's
going to be needed by an incoming change that improves error reporting
for log replay.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 01a0f7cbcd4b..2060f0d99f6e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -410,12 +410,13 @@ static int process_one_buffer(struct extent_buffer *eb,
  *
  * If the key isn't in the destination yet, a new item is inserted.
  */
-static int overwrite_item(struct btrfs_trans_handle *trans,
-			  struct btrfs_root *root,
+static int overwrite_item(struct walk_control *wc,
 			  struct btrfs_path *path,
 			  struct extent_buffer *eb, int slot,
 			  struct btrfs_key *key)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
 	int ret;
 	u32 item_size;
 	u64 saved_i_size = 0;
@@ -739,7 +740,7 @@ static noinline int replay_one_extent(struct walk_control *wc,
 
 	if (found_type == BTRFS_FILE_EXTENT_INLINE) {
 		/* inline extents are easy, we just overwrite them */
-		ret = overwrite_item(trans, root, path, eb, slot, key);
+		ret = overwrite_item(wc, path, eb, slot, key);
 		if (ret)
 			goto out;
 		goto update_inode;
@@ -1607,7 +1608,7 @@ static noinline int add_inode_ref(struct walk_control *wc,
 		goto out;
 
 	/* finally write the back reference in the inode */
-	ret = overwrite_item(trans, root, path, eb, slot, key);
+	ret = overwrite_item(wc, path, eb, slot, key);
 out:
 	btrfs_release_path(path);
 	kfree(name.name);
@@ -2657,7 +2658,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 				if (ret)
 					break;
 			}
-			ret = overwrite_item(trans, root, path, eb, i, &key);
+			ret = overwrite_item(wc, path, eb, i, &key);
 			if (ret)
 				break;
 
@@ -2721,7 +2722,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 
 		/* these keys are simply copied */
 		if (key.type == BTRFS_XATTR_ITEM_KEY) {
-			ret = overwrite_item(trans, root, path, eb, i, &key);
+			ret = overwrite_item(wc, path, eb, i, &key);
 			if (ret)
 				break;
 		} else if (key.type == BTRFS_INODE_REF_KEY ||
-- 
2.47.2


