Return-Path: <linux-btrfs+bounces-16662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B7B45D96
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D421C80009
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D130B539;
	Fri,  5 Sep 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pavEkqUK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D9830B531
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088655; cv=none; b=hWamNRAsWiSqDMqZCoeTmDHm154tsd31JpGEydFLdxwtMFjkP4sNANBPJgyQqtDsEpU0pmHJar4bZt0FqKEPKkIN3XnIjMVroG6tYVN1+ov5TGzMtBJcBSiDk5KyQCZZ64i8FqxG06bxUYPDhq8Sznv6vi4tdMTRaIwxuSyl6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088655; c=relaxed/simple;
	bh=ewkK3mvW1brfo6cjqRiYVtBhT1xQrntREYxD5Abz4IE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXJgg0wlIGSU10nlQ7Feirkylxy3ZDcsndbsyR/HXe4Q0j2Rqed59uW4M2bMAF/vSQUug8JMJvNqR6m9To8v+UvyoLgez7A3bV9cdW9YH2qgRTilGs+/cEFauFpPQdtnljBN8PvnR9yrbnVdFUZFM41N4LI/XCtHB+1AEm428xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pavEkqUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941CAC4CEF7
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088655;
	bh=ewkK3mvW1brfo6cjqRiYVtBhT1xQrntREYxD5Abz4IE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pavEkqUKeU0qeRz2PZKcfmQqNe3hz53YTwirfZHa27suW66aO2OiMa+zatvEeXDOq
	 IIut0zNfUyFhBlSWIT1DqCCtHlq2MLhyjLXrFwKez8NmrAJxjJhT4SQEAf1ld7Z5MZ
	 PiH9UMrN71J8jdx9gYnmKuKbErOYRxe6TLEEN3aY+srfPpvXW6Xre3rAO0z/ntYLeS
	 lsudvkpbC3B8JLiUxPGX4r5pQu/qXaf9lEofbLMst2bDeZCUOx8D0Assp0aCykwqoi
	 JYSjcoP2/6IwsE8nCcoOYLkoPKuTkj4YkB++J23hD7174izIJnbvWzXc/aLN2lvfza
	 3W2BBwdd1JaEQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 18/33] btrfs: pass walk_control structure to replay_one_extent()
Date: Fri,  5 Sep 2025 17:10:06 +0100
Message-ID: <5c0b2c62e173b2b9919c5afeb16fe6176ddf170b.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
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


