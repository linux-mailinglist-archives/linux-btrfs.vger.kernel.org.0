Return-Path: <linux-btrfs+bounces-14741-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAAAADD647
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688E41942385
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9142F7433;
	Tue, 17 Jun 2025 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAXPh5TR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA22F7425
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176804; cv=none; b=acypO0fobrYJblepAJgr2hDAAHfccxgDtHYIGnNbp0jTcs6RzNcpIgyq41SNW2F5wSW7xkBn0El8aFOUoqsf6s260lxQlUaQgTkKaHhhXdYmZMzXuhu3Uu+erIWYSEJ+NgnCVPDCS46h/HjWvj+/17f2s+CCVKHxeQLOa8u+dho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176804; c=relaxed/simple;
	bh=2FBCrB1XBI9WyPef17csLNzlHUIYibsKHggKoLVsc3w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KD0ocH71tcVea2DBqlqfMmnv/0j6SH6hvQTSirWw+kVZMAMjBJ3Oe1BVnlFJSaK5dc8iy51cyBxJ2nwmsxvFYcuO94nuNF/Wd3MxvRiykOg9x5Ijrm3hLSOALLCO3qSd3fGXy8SGfnzaCuNQmbo5rfegAFR8ZPlP8gnhMVgunFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAXPh5TR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8CBC4CEE3
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176803;
	bh=2FBCrB1XBI9WyPef17csLNzlHUIYibsKHggKoLVsc3w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rAXPh5TRHeD3ECzEo3oljXalVf+utAe2pXk+DKhbEjWNfjsxPhzFPc8GmbTE4Jb8D
	 k3/ugpYFm5P28LTtz/uxc0lHbcdSR0xAROBX8DB0t4aTvAG1rUx8oZjjQYdRtmbXBc
	 PWaKgIcqLjCs1rmNxFg/FD0LWpTPgGjCqUeXXkeg4kQKkqmADXnH9Xtjca28yMqlHD
	 KxSzvrDyF7fP+0xpd4LvLqwK1OgEMJse7HzLhLkk5VQ0qO/t2Rx780QF0XLLE7lQlu
	 l89B5GiOYGYrBeTxQrkEJZH80rbqy178s2+sIq1PB2dfYLxRzNsTXpebMsuPKIf6H4
	 oyqpEwRhd1aKA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/16] btrfs: turn remove argument of modify_free_space_bitmap() to boolean
Date: Tue, 17 Jun 2025 17:13:07 +0100
Message-ID: <2c5bd7d845d7f667dcb653c1d9977f5625ef84cd.1750075579.git.fdmanana@suse.com>
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

The argument is used as a boolean, so switch its type from int to bool.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index a0b51543e83e..b85927232860 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -606,7 +606,7 @@ static int free_space_next_bitmap(struct btrfs_trans_handle *trans,
 static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 				    struct btrfs_block_group *block_group,
 				    struct btrfs_path *path,
-				    u64 start, u64 size, int remove)
+				    u64 start, u64 size, bool remove)
 {
 	struct btrfs_root *root = btrfs_free_space_root(block_group);
 	struct btrfs_key key;
@@ -812,7 +812,7 @@ int __btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
 
 	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
 		return modify_free_space_bitmap(trans, block_group, path,
-						start, size, 1);
+						start, size, true);
 	} else {
 		return remove_free_space_extent(trans, block_group, path,
 						start, size);
@@ -1000,7 +1000,7 @@ int __btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
 
 	if (flags & BTRFS_FREE_SPACE_USING_BITMAPS) {
 		return modify_free_space_bitmap(trans, block_group, path,
-						start, size, 0);
+						start, size, false);
 	} else {
 		return add_free_space_extent(trans, block_group, path, start,
 					     size);
-- 
2.47.2


