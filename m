Return-Path: <linux-btrfs+bounces-10248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EABD9ECF56
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 16:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755FC18811C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAC11D61A2;
	Wed, 11 Dec 2024 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9lKHsJk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AA11D5CC6
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733929520; cv=none; b=Y5rHndEmNgNEnOP7wKhXRr5s28RjWKu00m0GVxJJW+y7Hh+Rcuh9R6GQOO5lTv4MygETR21Jjdj/VdoJMDYs69xhtW+u0SEu1hV0jOWBQ5ccoDTFfgq1zOjf3XypmtZnL/DuSAUY3X5snZPnINvG4mJbzOoUpFJuW1OmASV1N2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733929520; c=relaxed/simple;
	bh=Mnhn1ycT3BR2wHhbiKSpCZU+4nq13CqR7isYDP4qCbg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VyrQxr9iXim4FsDcf8WkLVApOKoT4YVgAr1Os6z8CZVkYxiP4weWiSRwhwnipj6z5/PZJQjZu75RhwY98eqTZ0VIA89AjW7gyOhBgTgPZ5ddmohmTfseDUz8jgym3FW4xqc86NMokjF/T4AEJ0uZASxxw0O3D5SDSr72p7ef/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9lKHsJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E47C4CED4
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733929520;
	bh=Mnhn1ycT3BR2wHhbiKSpCZU+4nq13CqR7isYDP4qCbg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=o9lKHsJk3t5ruK0Vt0KnNpseNU2BxvQvgUolkJaLw4wqmwjyzESJ0XKCvWj4Uxf6z
	 YMLqh86MFbbKnTgbpX56VW27NE+OclTh5xHqpOwGrGbHWBEXQKLHNcP8YKPV8MZtrx
	 /1264F2CPetUJJK6QHjMXn8xBPaUi0gkmO/SW15Bpm+nYqPH2YpjKfmjAsPcq70IMk
	 wXj4P+1BoiRTFTZewO0iZ8A0eebBkofAmGXxNo3kj93l56YL/jYvjaLpDHWkQJyq5i
	 5Kevj4YbrjnxF7Vmr0ZYD24i0uoHndsuFHtcjrCrum1rJlO0+ZfOEBzbN9STNFtSFb
	 RShIrdqtfbWWw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/11] btrfs: simplify return logic at check_committed_ref()
Date: Wed, 11 Dec 2024 15:05:05 +0000
Message-Id: <81b8ad0b51003fe2d99e8ece25a7b5ba1dc1a644.1733929328.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733929327.git.fdmanana@suse.com>
References: <cover.1733929327.git.fdmanana@suse.com>
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


