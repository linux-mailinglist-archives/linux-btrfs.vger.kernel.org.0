Return-Path: <linux-btrfs+bounces-19797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3601CC458B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD68F30AECBC
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071EC2F12CA;
	Tue, 16 Dec 2025 16:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh6Vs33K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC532C0F9E
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902805; cv=none; b=EqYxdOvK8MBDIUbGe9MkvfCk3/mSTR41AJxLokHksC64c2oBT+l7/IdnwEM9orC1Q6gNp4FtB952mLbQECFKwUCxy3ojDD4kG5Mwi/kfMNQm4PKixSiBdHnKmkSY+i9VsO6hvsdeTG1fycVjnuFgeME1O8AiDHluUkGrFpOXTSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902805; c=relaxed/simple;
	bh=SO0ObHliQSTIj1uacrX0PjK5BlXBwzTBrFXdYHGa1hE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGBzDbFYQJckIbw5+9xgP1LVmw3k1O74DeyKmL1WneHMelBe351lrdYWDN0XYyGcrm2uKSXM9q4gVNNzxLuv2JYp180ImJtww16mPSgsyj7b4Hzm8ffmbz1qMeBcwpFCQ6TJhsKAu7OQ5/O1aZT25NqqKfunSsnHiLCLEjaSGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh6Vs33K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C35FC16AAE
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765902804;
	bh=SO0ObHliQSTIj1uacrX0PjK5BlXBwzTBrFXdYHGa1hE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hh6Vs33KxcSj4vrutkFNJn2QFz2kVd8bMJll54N/xH558Li7b4QvLAmYZ5tYbhBaj
	 Qi9lQPANKClFOrGWWRhfL5DbIUYa68dTxwThsiC3yLRd66mHltq6iagykiD+6KQPis
	 WDqj2II+QwAde0eJvKzJdr4lgKsBrGJS3yc+oNXv11ezJKSyz6y2kTjyqqVqrO0mun
	 15u1zFEhxw0ZQ1aPWthuLpemNcnj4j06MCGpR20DzkK/OHIKJlR/ZMZm1gCgj8KWUI
	 5wH3CrwhOWvv/VV4cMMcnISVuwSiWYhWQnzB7pmQNcelLgIuQ0bN13AiTZih06d+Je
	 OtauPeJ4cJFWw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: don't call btrfs_handle_fs_error() after failure to join transaction
Date: Tue, 16 Dec 2025 16:33:18 +0000
Message-ID: <e6a497f1873cb9d8f7c734ffc8d4ab31641a1164.1765899509.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1765899509.git.fdmanana@suse.com>
References: <cover.1765899509.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In btrfs_find_orphan_roots() we don't need to call btrfs_handle_fs_error()
if we fail to join a transaction. This is because we haven't done anything
yet regarding the current root and previous iterations of the loop dealt
with other roots, so there's nothing we need to undo. Instead log an error
message and return the error to the caller, which will result either in
a mount failure or remount failure (the only contextes it's called from).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/root-tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 40f9bc9485e8..a30c7bc3f0e5 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -264,8 +264,9 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 			trans = btrfs_join_transaction(tree_root);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
-				btrfs_handle_fs_error(fs_info, ret,
-					    "Failed to start trans to delete orphan item");
+				btrfs_err(fs_info,
+			  "failed to join transaction to delete orphan item: %d\n",
+					  ret);
 				return ret;
 			}
 			ret = btrfs_del_orphan_item(trans, tree_root, root_objectid);
-- 
2.47.2


