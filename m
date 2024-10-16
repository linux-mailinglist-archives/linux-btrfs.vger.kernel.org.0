Return-Path: <linux-btrfs+bounces-8959-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ED19A0C75
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484571C21E8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68988208D8D;
	Wed, 16 Oct 2024 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3R8szQa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94621206971
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088428; cv=none; b=ot5TXEhmElyhRQSkz4Vv9n6adsumE26qKvBcFJZKmbv2EYRg8qYqIYRtI/9DMB8TXUOKY0XE2sxLMWf847yexe0Gu7VIA1hlFDfleIiTOsY2oubHmoNYsMDG+9hvubEI1i0bQWik+Elw7sfgVdvM6KHnpqdpAPFEn6sKisu4Bgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088428; c=relaxed/simple;
	bh=kxPosLO7kCCEqa0S1klbJv2hO8XtsWTO4hCAu+6oBCY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMcayYS2A+xup1dyM+13lecYcmeNTWBafjPnXoKED4pdTlaDwJmibwiJti/o4m4Z35rZAkpT3t2UW0vck8TBj4s1uNwtXGBSEKXCqPyxS5KYoE+Zqzp921bIvgsfAjiWT66yXjEiVkBunnBCsTrHo8jJ3HpHpBox5dbj7XA1uRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3R8szQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95776C4CEC5
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088428;
	bh=kxPosLO7kCCEqa0S1klbJv2hO8XtsWTO4hCAu+6oBCY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h3R8szQaHyYP4AUllovtVwfe1A5DFxMDhvHu1hqHvNTDpRyx7GTtMbusm9XWl0G6y
	 csyVtaanFEsC/aL/hCuLta0sGqjprppwKrtujpoXyKxy8k2MkG4QYnSv9fZUbcOixm
	 dd0fuxGWx2/l9E33e+d7elxdObCP8CeSnUHoLCu8309Md395InShiGC350joTxMUM6
	 YbC8LtzMvQAHO/tzx3LjNYlVnvXnrYZ+2zM0uyglOkzkKA6G/dfyq6BlU2QBPqJJ7+
	 +mXZPplsCDgpMgEG8i7Zuih8V+Z9zxOqXbjPF6Vh2KX1fAA/+i3otkFHOCIKuaflsX
	 T5SjFFBNKs+8Q==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: remove redundant level argument from read_block_for_search()
Date: Wed, 16 Oct 2024 15:20:20 +0100
Message-Id: <9d4bff651960da766b8d302c784ebf67ed1c54eb.1729075703.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729075703.git.fdmanana@suse.com>
References: <cover.1729075703.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The level parameter passed to read_block_for_search() always matches the
level of the extent buffer passed in the "eb_ret" parameter, which we are
also extracting into the "parent_level" local variable.

So remove the level parameter and instead use the "parent_level" variable
which in fact has a better (it's the level of the parent node from which
we are reading a child node/leaf).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 4f34208126f7..428c5650559a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1508,7 +1508,7 @@ static noinline void unlock_up(struct btrfs_path *path, int level,
  */
 static int
 read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
-		      struct extent_buffer **eb_ret, int level, int slot,
+		      struct extent_buffer **eb_ret, int slot,
 		      const struct btrfs_key *key)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -1542,7 +1542,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	tmp = find_extent_buffer(fs_info, blocknr);
 	if (tmp) {
 		if (p->reada == READA_FORWARD_ALWAYS)
-			reada_for_search(fs_info, p, level, slot, key->objectid);
+			reada_for_search(fs_info, p, parent_level, slot, key->objectid);
 
 		/* first we do an atomic uptodate check */
 		if (btrfs_buffer_uptodate(tmp, gen, 1) > 0) {
@@ -1568,7 +1568,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 		}
 
 		if (!p->skip_locking) {
-			btrfs_unlock_up_safe(p, level + 1);
+			btrfs_unlock_up_safe(p, parent_level + 1);
 			tmp_locked = true;
 			btrfs_tree_read_lock(tmp);
 			btrfs_release_path(p);
@@ -1595,12 +1595,12 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	}
 
 	if (!p->skip_locking) {
-		btrfs_unlock_up_safe(p, level + 1);
+		btrfs_unlock_up_safe(p, parent_level + 1);
 		ret = -EAGAIN;
 	}
 
 	if (p->reada != READA_NONE)
-		reada_for_search(fs_info, p, level, slot, key->objectid);
+		reada_for_search(fs_info, p, parent_level, slot, key->objectid);
 
 	tmp = btrfs_find_create_tree_block(fs_info, blocknr, check.owner_root, check.level);
 	if (IS_ERR(tmp)) {
@@ -2236,7 +2236,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			goto done;
 		}
 
-		err = read_block_for_search(root, p, &b, level, slot, key);
+		err = read_block_for_search(root, p, &b, slot, key);
 		if (err == -EAGAIN && !p->nowait)
 			goto again;
 		if (err) {
@@ -2363,7 +2363,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
 			goto done;
 		}
 
-		err = read_block_for_search(root, p, &b, level, slot, key);
+		err = read_block_for_search(root, p, &b, slot, key);
 		if (err == -EAGAIN && !p->nowait)
 			goto again;
 		if (err) {
@@ -4969,8 +4969,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		next = c;
-		ret = read_block_for_search(root, path, &next, level,
-					    slot, &key);
+		ret = read_block_for_search(root, path, &next, slot, &key);
 		if (ret == -EAGAIN && !path->nowait)
 			goto again;
 
@@ -5013,8 +5012,7 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		if (!level)
 			break;
 
-		ret = read_block_for_search(root, path, &next, level,
-					    0, &key);
+		ret = read_block_for_search(root, path, &next, 0, &key);
 		if (ret == -EAGAIN && !path->nowait)
 			goto again;
 
-- 
2.43.0


