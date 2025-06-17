Return-Path: <linux-btrfs+bounces-14736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0354BADD5EB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393B62C7B34
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26A02EE28F;
	Tue, 17 Jun 2025 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hxyut/ie"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41572EE28A
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176799; cv=none; b=pwQBLhuubHzLY80hgoc35dGcznHt5qQvxsiBxX7ZOfLKociAwNPbw64R3JXPZalk+T4CVPJDeA+klujNM4/H5k1A0yqXhBFsKu4ma+SXv3ZXZ3fY7DJNXJ8PFIPLbwpfM32ac1Dmi7m0Ltrjd+qgbet2VPRzCFJIHyor6lAFS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176799; c=relaxed/simple;
	bh=t0e25Fj6TM3bJZJ3pNXx7FHCLNNzXUNT9MplIXybZWw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qlo9IkRQwDEyUdrAnlhTim0THmCspdDrkeCj3cxBfW+fkcZXs1InMD/DBOuqUWwC5LonR3IpJIy+bDYehklEXpHegVVK4Xh/zYMEZGqTmW7+ycy6T4YL92oRoYuvJMzM/luXFbP9uM1VVj5Ka1n87eE+XYhc2KAOdHmQhYPjhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hxyut/ie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39564C4CEE7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176798;
	bh=t0e25Fj6TM3bJZJ3pNXx7FHCLNNzXUNT9MplIXybZWw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Hxyut/ieBohkWHesYJz+rZYgAMlg0nod+K+Ws3uftYHH7dkHzCSCx9+QG2s2v9r5L
	 UQorQIK+8bR769q65p4Dr933cLaOXba2TNZ/+YA7E0IwO7aaAg/KzJsIczN9LsIsUo
	 4wcbrgSdjrk21utH2IylbN6iSZlK4SYSUZDZzMUS8Nn5MWieP2W8DCIzJqoVrNkkql
	 MeJeUTgvFen7Yhdm7Tq/o8U3qe97voBEbqF6RAHW61+Cs03EwPoX/UzxFlO3Nrv7hQ
	 eJuW8yk0i4TFkjFGoK1yWROp5YEwjKEbGHbiRSj8YCdport9owOsL+jFx600UimDbH
	 Kvf28OIfZuJJA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/16] btrfs: remove pointless out label from add_free_space_extent()
Date: Tue, 17 Jun 2025 17:13:02 +0100
Message-ID: <4e86d9839a9bf0f95cadb3787437334c13c10db7.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

All we do under the label is to return, so there's no point in having it,
just return directly whenever we get an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index cba097dbdebb..1f76860ec61e 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -900,7 +900,7 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_search_prev_slot(trans, root, &key, path, -1, 1);
 	if (ret)
-		goto out;
+		return ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
@@ -923,7 +923,7 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 	if (found_end == start) {
 		ret = btrfs_del_item(trans, root, path);
 		if (ret)
-			goto out;
+			return ret;
 		new_key.objectid = found_start;
 		new_key.offset += key.offset;
 		new_extents--;
@@ -940,7 +940,7 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_search_prev_slot(trans, root, &key, path, -1, 1);
 	if (ret)
-		goto out;
+		return ret;
 
 	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 
@@ -964,7 +964,7 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 	if (found_start == end) {
 		ret = btrfs_del_item(trans, root, path);
 		if (ret)
-			goto out;
+			return ret;
 		new_key.offset += key.offset;
 		new_extents--;
 	}
@@ -974,14 +974,10 @@ static int add_free_space_extent(struct btrfs_trans_handle *trans,
 	/* Insert the new key (cases 1-4). */
 	ret = btrfs_insert_empty_item(trans, root, path, &new_key, 0);
 	if (ret)
-		goto out;
+		return ret;
 
 	btrfs_release_path(path);
-	ret = update_free_space_extent_count(trans, block_group, path,
-					     new_extents);
-
-out:
-	return ret;
+	return update_free_space_extent_count(trans, block_group, path, new_extents);
 }
 
 EXPORT_FOR_TESTS
-- 
2.47.2


