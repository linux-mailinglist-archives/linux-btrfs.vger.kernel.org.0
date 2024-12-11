Return-Path: <linux-btrfs+bounces-10235-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE39ECF15
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587291888150
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DFA1D7982;
	Wed, 11 Dec 2024 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkSGIalh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E7F1D63DE
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928820; cv=none; b=F1EYSL4OOy5AYLOxtVBvTUDVYJuufxNveS3JzgEX/7dlTAg3/HY3qx805lHFJI9xkQAu0p54KD0O26vIOyO8LpE5ldvhCuiVJeJBf5AjKGEqdVgyyZYAK4UfW33ahMMuPtXXAQ6KSDq9eUfDCUjdEyj9DOgl3zTQglXglptEVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928820; c=relaxed/simple;
	bh=Mnhn1ycT3BR2wHhbiKSpCZU+4nq13CqR7isYDP4qCbg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hJOyk8b95sOzna1x5PCHvdnQR9QzWamlJ8F4Yv95xowhEytCy4OC61NoWwD14BWJb8oI5XFvbb7WiuqYJ1raOxQEAWjwQB2UtYOcAyFCixA23O9txwguFFcg/EdQskQNWD8arwQMuUiS/e06UqEQ/t/AJORRgwKGf6nGx1yG3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkSGIalh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F10DC4CEDD
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928819;
	bh=Mnhn1ycT3BR2wHhbiKSpCZU+4nq13CqR7isYDP4qCbg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nkSGIalhSXYDSojdqq7RrwWD/oG9ewyQVkdVpDSZJVTGPZodQmWcIO2ciNU662VK5
	 1eCqChblqd0z455Bds/5FvpaNUM6Msq7cKAtK83oFGJ31TNgncE6Ph/6dwHJCDYpoZ
	 ifpQfw0+Bzw+ZmFGh4xUrWb2d/u7UiPT9rw+xiiitkPghwadSzzC8nhMe8Q0bng6Vi
	 0JtbX+HPlaeTCvXH+NNvilZS6/0h2V0Vz80JL5mNU3DD0K/TfX9NO0sxflb/ajoc5l
	 OZd2iWdubJyM9PeOBWlGVCZIX68lDQN8w6oJcsMeLYQDEtz8ypvd3TatNIHqguXiWW
	 ytfS/r2LqTKeA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs: simplify return logic at check_committed_ref()
Date: Wed, 11 Dec 2024 14:53:25 +0000
Message-Id: <81b8ad0b51003fe2d99e8ece25a7b5ba1dc1a644.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of setting the value to return in a local variable 'ret' and then
jumping into a label named 'out' that does nothing but return that value,
simplify everything by getting rid of the label and directly returning a
value.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 00e137c48a9b..51c49b2f4991 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2316,35 +2316,32 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
-		goto out;
+		return ret;
 	if (ret == 0) {
 		/*
 		 * Key with offset -1 found, there would have to exist an extent
 		 * item with such offset, but this is out of the valid range.
 		 */
-		ret = -EUCLEAN;
-		goto out;
+		return -EUCLEAN;
 	}
 
-	ret = -ENOENT;
 	if (path->slots[0] == 0)
-		goto out;
+		return -ENOENT;
 
 	path->slots[0]--;
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
 	if (key.objectid != bytenr || key.type != BTRFS_EXTENT_ITEM_KEY)
-		goto out;
+		return -ENOENT;
 
-	ret = 1;
 	item_size = btrfs_item_size(leaf, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 	expected_size = sizeof(*ei) + btrfs_extent_inline_ref_size(BTRFS_EXTENT_DATA_REF_KEY);
 
 	/* No inline refs; we need to bail before checking for owner ref. */
 	if (item_size == sizeof(*ei))
-		goto out;
+		return 1;
 
 	/* Check for an owner ref; skip over it to the real inline refs. */
 	iref = (struct btrfs_extent_inline_ref *)(ei + 1);
@@ -2357,11 +2354,11 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 
 	/* If extent item has more than 1 inline ref then it's shared */
 	if (item_size != expected_size)
-		goto out;
+		return 1;
 
 	/* If this extent has SHARED_DATA_REF then it's shared */
 	if (type != BTRFS_EXTENT_DATA_REF_KEY)
-		goto out;
+		return 1;
 
 	ref = (struct btrfs_extent_data_ref *)(&iref->offset);
 	if (btrfs_extent_refs(leaf, ei) !=
@@ -2369,11 +2366,9 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	    btrfs_extent_data_ref_root(leaf, ref) != btrfs_root_id(root) ||
 	    btrfs_extent_data_ref_objectid(leaf, ref) != objectid ||
 	    btrfs_extent_data_ref_offset(leaf, ref) != offset)
-		goto out;
+		return 1;
 
-	ret = 0;
-out:
-	return ret;
+	return 0;
 }
 
 int btrfs_cross_ref_exist(struct btrfs_root *root, u64 objectid, u64 offset,
-- 
2.45.2


