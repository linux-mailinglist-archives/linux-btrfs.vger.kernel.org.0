Return-Path: <linux-btrfs+bounces-12848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E23A7E8C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE1E189EF3E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92F7253B50;
	Mon,  7 Apr 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMrE7W5C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17E253353
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047397; cv=none; b=HUAZ9sN25cKDr3i0+OD6llTgxu4mxrXk6CwsLqM+kzxr6CV+bvN0vy4JBLU1E/YspSIDwD039LcTDOxOy8Kv0DFcd49844yX2qs0nSA6fO+ao2fhVmomSSWy5ujZ9GLQ+XGjyBQWI9r4QzPGQiiBD/g7IBCW9tYZ+EQYy8Ftjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047397; c=relaxed/simple;
	bh=unMBKUMEv9z3NKc1ErEXv7QyaSA1O1KNa/bgA/SROeQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRtm6WJZ1F6qJ1AhNKc2s9/yTS/qaOZpeeh7rtZmB3SCdgWnRsm8OUqZ6rnuEn8AGjqITK0ChWLke6e0DH2PvcsJZf+xYXxavwSoUCeKb0Q3CI2rTuWqXkbuLByUc0LhpABRw7d+JCqlF6V9dwwKid0Fa1AbhtkeJBONVicz+1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMrE7W5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84519C4CEDD
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047397;
	bh=unMBKUMEv9z3NKc1ErEXv7QyaSA1O1KNa/bgA/SROeQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DMrE7W5CSzCXLNiEx1SpwPAUY7cQEXeGnLlgxaU/8fCCXVgmho/v3F26kEPbRfHbi
	 2tzy3rXZHo/cqDA6rFm2yEH1wNGCOOoGkME9Sod+29d3Jdg6FqzPtPYrTqWPptyuLf
	 84NCdNIP6a4amAO8QR9KjFpL7uMvZPnQLVevhNNaJf/lXyWpx5wTsTpyG9WSBxSufG
	 w6xa4B8UWqn5rRYqSOPP1QWqHhnSgMdEEv8HkuMbCEe5RT8Q/z91uI74GL5Hlmvsq6
	 MptQmaT7UIuqW6XIRZB/YBpk3H2RPzujEnBj+oL8Q+4/gUewDWfE7WH9cjfsI6oVsv
	 ZSKThF+2Ia50w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/16] btrfs: directly grab inode at __btrfs_debug_check_extent_io_range()
Date: Mon,  7 Apr 2025 18:36:17 +0100
Message-Id: <38625dad0acc6260fcefb0a15d359c4a3d4fe9b4.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We've tested that we are dealing with io tree that is associated to an
inode (its owner is IO_TREE_INODE_IO), so there's no need to call
btrfs_extent_io_tree_to_inode() in a separate line and we just assign
tree->inode to the local inode variable when we declare it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index abf0f83a15cb..6330071cc73f 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -59,13 +59,12 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 						       struct extent_io_tree *tree,
 						       u64 start, u64 end)
 {
-	const struct btrfs_inode *inode;
+	const struct btrfs_inode *inode = tree->inode;
 	u64 isize;
 
 	if (tree->owner != IO_TREE_INODE_IO)
 		return;
 
-	inode = btrfs_extent_io_tree_to_inode(tree);
 	isize = i_size_read(&inode->vfs_inode);
 	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
 		btrfs_debug_rl(inode->root->fs_info,
-- 
2.45.2


