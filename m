Return-Path: <linux-btrfs+bounces-2290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63F84FB6E
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 19:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFC61F2A218
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 18:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D385C77;
	Fri,  9 Feb 2024 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3DEoBrV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE0485299
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501663; cv=none; b=V5RZg7BYmTVir6PzgLv/rWYF145OMFY8BPAfbtCrIFmOd9O2s5/eVPJ+whZ5X/YNASIpPXbD730gFkv25OvmfN9aqnLGQj3BLiHiC/t2abo8HNRQ/ItdnF2FvxybxWO8gx5wd6VKAAFZkHGyfeYEmRNQalv7eqSeWrIWwnepHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501663; c=relaxed/simple;
	bh=2IZfJdIsVZJIUW+bdoqC1ZpNFMBcvsjpRvvn/AljRRQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mp4Zkndi0Tsy9llBM1rph+P0UhKNg7onfLYTHSGnHiKIE8+YFEFNe3KO0NYcsOyr/U0Jmf9zmX8H9CktY6bHXO5EOfyifUsxW6CT69M7p3lgFRTe0mGNQSTcE4oQC+N6XH1zDEDcpYa7x5Kite2JMVdcV77mTd6fdPhLEu9NM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3DEoBrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27344C433F1
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501663;
	bh=2IZfJdIsVZJIUW+bdoqC1ZpNFMBcvsjpRvvn/AljRRQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=N3DEoBrVTvepfG7eELOpBX0i65lBs+4iV++vcoly3/ruNZDU+tqovSnDxyr7sbRo1
	 35sKD22PDyNbYGWbecHRM+dULhr8I79qjsKh9GUjkY6+crT7SooaGY3laQe50RV/6N
	 BfeU6oPsvpJCV4q+0Q8r3JrpecKHUvL4dMLlsRqIKRh7nnLHbHbiLea4lL8iqARw/I
	 ollZcxh1raysJc7UMpSvRYEssV0/yNC0QyW2ZIbYDgntcVKw55Oy/6JI8KkdfKP4ku
	 dhwucTMr/vF7oLnNTPINvA80pFUXif51Gxd6SVUZbf92gcQdraW5VHBq1MgCEzUsg7
	 GHRyabyqksSUQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs: remove do_list variable at btrfs_clear_delalloc_extent()
Date: Fri,  9 Feb 2024 18:00:51 +0000
Message-Id: <c943cf4b01e5e27d04c0cf8dbf58d9f2ff8119af.1707491248.git.fdmanana@suse.com>
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

The "do_list" variable has a rather confusing name, so remove it and
directly use btrfs_is_free_space_inode() instead.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 17b6ab71584a..5bb61d4aa2cb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2525,7 +2525,6 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 	if ((state->state & EXTENT_DELALLOC) && (bits & EXTENT_DELALLOC)) {
 		struct btrfs_root *root = inode->root;
 		u64 new_delalloc_bytes;
-		bool do_list = !btrfs_is_free_space_inode(inode);
 
 		spin_lock(&inode->lock);
 		btrfs_mod_outstanding_extents(inode, -num_extents);
@@ -2545,7 +2544,8 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 			return;
 
 		if (!btrfs_is_data_reloc_root(root) &&
-		    do_list && !(state->state & EXTENT_NORESERVE) &&
+		    !btrfs_is_free_space_inode(inode) &&
+		    !(state->state & EXTENT_NORESERVE) &&
 		    (bits & EXTENT_CLEAR_DATA_RESV))
 			btrfs_free_reserved_data_space_noquota(fs_info, len);
 
@@ -2562,7 +2562,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 		 * and are therefore protected against concurrent calls of this
 		 * function and btrfs_set_delalloc_extent().
 		 */
-		if (do_list && new_delalloc_bytes == 0)
+		if (!btrfs_is_free_space_inode(inode) && new_delalloc_bytes == 0)
 			btrfs_del_delalloc_inode(inode);
 	}
 
-- 
2.40.1


