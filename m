Return-Path: <linux-btrfs+bounces-2285-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C7F84FB69
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 19:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2AC1F251ED
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5593284A26;
	Fri,  9 Feb 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3rZlYMD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E4183CAA
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501659; cv=none; b=sGb/ZT7cc4qzf3bNr7aSbMLP1CNJdAlcIHBMSbK+FVCb0JjZd0YO7NIfImGaTPxOUwyTYQTlhujbtHAzcMAuEZnVTJYNjdGPJVOPPgxhrsCBjC+cQssozttrBMP8En4cJJwmToMEZu1cOQZeaukMPPDEhbCRNKIr+zqtTgsVG7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501659; c=relaxed/simple;
	bh=g8FIVfnxfN4OOTwx8ehxAwYyT2OBUMITeKorUcsRj1Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4TslIOLZrX8W1tFF+r5/1gDEPHvIi/BrdlbTo7vG8gdTR/QcY/XVKl78x6aeEth+gFfKerCLxUy8inds5cMTRaZTsFS/Y9NpN/8PjWfIli8OWufuL5NJFTMXHR1LDy4ADj+Y6TSVOMBSXOgAftegi4mziLJWR5h+MBy/m8voFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3rZlYMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE58C43390
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501658;
	bh=g8FIVfnxfN4OOTwx8ehxAwYyT2OBUMITeKorUcsRj1Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B3rZlYMDPBDA97sJ9jPChMkA87KzIOFph/oSA1phwiJHv0IHy6b2HRCNfAhFW3e94
	 S0Ff3gZegWFujfP9qXT6QqMezO1UI1MKcLLvSDA4Ee276togb8r32EVtFMgAt12/ik
	 Op607yTiPcu30NWDfaUzu5Yu8X4+ImzdI57Pamr6PNWgMldrn+wZfi6xyjwDOfOKYr
	 +QSuvMR3sPuwMlrHlO64s0uNBACbn58RliseHd0rGqdTdCmfmO1T2KPFw8+RZiP34P
	 F8HROKjKULmNpevf+4lrFoP4OvlQaVOKel0R1h+bkRSN2bbmXVkR5jj+eMBRTrrqT/
	 a4wQmrA483L+A==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs: rename btrfs_add_delalloc_inodes() to singular form
Date: Fri,  9 Feb 2024 18:00:46 +0000
Message-Id: <2e26e61c8974a2c7e7ba1b2e14e771395bfa4a57.1707491248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707491248.git.fdmanana@suse.com>
References: <cover.1707491248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The function btrfs_add_delalloc_inodes() adds a single inode its root's
list of delalloc inodes, so it doesn't make any sense at all for the
function's name to be plural. Rename it to the singular form
btrfs_add_delalloc_inode() to avoid any confusion.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3a19e30676e8..b273fdbd63cd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2385,7 +2385,7 @@ void btrfs_merge_delalloc_extent(struct btrfs_inode *inode, struct extent_state
 	spin_unlock(&inode->lock);
 }
 
-static void btrfs_add_delalloc_inodes(struct btrfs_inode *inode)
+static void btrfs_add_delalloc_inode(struct btrfs_inode *inode)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -2472,7 +2472,7 @@ void btrfs_set_delalloc_extent(struct btrfs_inode *inode, struct extent_state *s
 			inode->defrag_bytes += len;
 		if (do_list && !test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
 					 &inode->runtime_flags))
-			btrfs_add_delalloc_inodes(inode);
+			btrfs_add_delalloc_inode(inode);
 		spin_unlock(&inode->lock);
 	}
 
-- 
2.40.1


