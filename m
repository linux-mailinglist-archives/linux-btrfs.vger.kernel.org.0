Return-Path: <linux-btrfs+bounces-14548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE33AAD1551
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 00:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3DE1887A1E
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Jun 2025 22:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D5225CC73;
	Sun,  8 Jun 2025 22:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gV4tlwID"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474C25A2C9
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Jun 2025 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749422621; cv=none; b=o7zLFOt6LUwQR1jvsojErz7l8Vux56k3E39MtTdwiJem0pq69asqPrOFUMBuYe/nJLNvdZ5dbCbalM458OwGai79Wq8a6kUotZndUsUHJmRo88N09zx7Ykkx1+QBGkVm9EQJzW4IZT3ivdMelHHtR0+Mw0vsf2P0YHXGykomuNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749422621; c=relaxed/simple;
	bh=9myU2Nu4aumWfTNj9W1OiXfhcDiFByVX+6i8NWx8T5s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egANIMyT80jHJt2vph0IMSBujWZeygqQErTDTzBtUhbkNf0+iXLEghAsa341qczRzEngU7294VCqXnJDOu8RZIj1pL+/h8yoJrptuApPlGjSYzl+ZpZEy8QBhTYHfsC4MsGoBt52CVWW/9LWGB5Jeb8aI3PW5pV8lNqvqSaxlZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gV4tlwID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FE9C4CEEE
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Jun 2025 22:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749422621;
	bh=9myU2Nu4aumWfTNj9W1OiXfhcDiFByVX+6i8NWx8T5s=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gV4tlwID1Yo4GBxAljbuwOvhbTOkIRZWSQ2uBeKbZWSLgyYXVdDXMEK4au1TtOB79
	 JVjPNQKeDwReZj7AGx4/3Ihr1GJ3z0VNaKECEwfkBEWSdVRguvBxovl1qIaxjqSeFP
	 OEs20ZHRua279pUSoD38ljNpB0d54A7XFcY+dEPoYQIqCn1FuwGyX+RmFNS6dEgNdD
	 Q1Hy7mLnWWvPwpxcqdJIEqOT2mHg2yACWC6+Cq5WmYfofntY/9/mt9pJwD37EBI2eK
	 8naWRowpSsWpGR7atmYRFCe/pkcuGcBjO4QEdxlWVMVQDZRy+MHhjrO7fRySdA/6bj
	 44s4R8PnfLJvA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: always abort transaction on failure to add block group to free space tree
Date: Sun,  8 Jun 2025 23:43:33 +0100
Message-ID: <20a997cb29109932af1b61614df099785ea6c76b.1749421865.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1749421865.git.fdmanana@suse.com>
References: <cover.1749421865.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Only one of the callers of __add_block_group_free_space() aborts the
transaction if the call fails, while the others don't do it and it's
either never done up the call chain or much higher in the call chain.

So make sure we abort the transaction at __add_block_group_free_space()
if it fails, which brings a couple benefits:

1) If some call chain never aborts the transaction, we avoid having some
   metadata inconsistency because BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE is
   cleared when we enter __add_block_group_free_space() and therefore
   __add_block_group_free_space() is never called again to add the block
   group items to the free space tree, since the function is only called
   when that flag is set in a block group;

2) If the call chain already aborts the transaction, then we get a better
   trace that points to the exact step from __add_block_group_free_space()
   which failed, which is better for analysis.

So abort the transaction at __add_block_group_free_space() if any of its
steps fails.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 9eb9858e8e99..af005fb4b676 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1431,12 +1431,17 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 	set_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED, &block_group->runtime_flags);
 
 	ret = add_new_free_space_info(trans, block_group, path);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
 
-	return __add_to_free_space_tree(trans, block_group, path,
-					block_group->start,
-					block_group->length);
+	ret = __add_to_free_space_tree(trans, block_group, path,
+				       block_group->start, block_group->length);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+
+	return 0;
 }
 
 int add_block_group_free_space(struct btrfs_trans_handle *trans,
@@ -1461,9 +1466,6 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 	}
 
 	ret = __add_block_group_free_space(trans, block_group, path);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
-
 out:
 	btrfs_free_path(path);
 	mutex_unlock(&block_group->free_space_lock);
-- 
2.47.2


