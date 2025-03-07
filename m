Return-Path: <linux-btrfs+bounces-12092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B16A5693D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A4D3AB86F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 13:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00BF21A445;
	Fri,  7 Mar 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuwBP8lM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2244E219A67
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355075; cv=none; b=V+UQGNQln4Eg4He2GewWbXTsbl8nVr7EYdcYvYteMq5hO+1dorHpcaIdEaEel2Lz5IvsGDWNHvKPDgfOnZEi0Ymuz5Szeh/1gaTsIRNOU79nU6cHgoo5GVCCZSdE5wNo1HTjUz5z06tZjWak7rZqTA9eX0hP0wTBQG0WxcFmUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355075; c=relaxed/simple;
	bh=R4aJf3HibnujmQskK/+/9TyBF7bOJNV7BtFZa9JvCrs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UunhmAk/3JK5otm0wbr4eBfCeoKZlvhVdYc3o5U0Qkzy5nvdATqipHOOx7R+lvvDZT26n72VYPw5uC2NPinSFD1ko6Gg7ThaQ+4zo7YyTo4kG1sbJKo3X8l4sCGcAxrFfY2xFJYH9dXY6NTgpqEc9gmWWnsAn11Izu2H7edSJVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuwBP8lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6E5C4CEE5
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741355075;
	bh=R4aJf3HibnujmQskK/+/9TyBF7bOJNV7BtFZa9JvCrs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iuwBP8lMDbI0xcdU3o4+IWVrLjzoF+PAgk4D+lCUGCVshL5IRaK2r+Y3ulesU3Ize
	 +WW6GUHLJJ0fBxit3xxoK1g38q20XjIs4DyXL5wdMRBLSyPhWMLeMx7oAF0tRsmfVy
	 4qjcM3+sxRljDWwO7fGw0QUCKn3UAJaLfHhfoXGN+ES+fGl/r9DblhRQMcKWJdOi5k
	 P8zPN62B/F02TqQmMyrG5AaHto7tf1g9sv4GvI4wqfuo7eE8Icgoin4L66Frv91XOn
	 pUsFqgXRUY7VL0X56nuMn7pVOAra+j+3KDmeL9oXwZa+lgtvRrp00OiLqKsnN4EJ9y
	 Qaq2nE03Mz19g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs: remove unnecessary fs_info argument from create_reloc_inode()
Date: Fri,  7 Mar 2025 13:44:23 +0000
Message-Id: <2e652118cf9cb2587632a90a97a2dc3253f6b186.1741354479.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741354476.git.fdmanana@suse.com>
References: <cover.1741354476.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The fs_info can be taken from the given block group, so there is no need
to pass it as an argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5359cf2b79b5..33d3b5ca7ee0 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3763,9 +3763,9 @@ static void delete_orphan_inode(struct btrfs_trans_handle *trans,
  * the inode is in data relocation tree and its link count is 0
  */
 static noinline_for_stack struct inode *create_reloc_inode(
-					struct btrfs_fs_info *fs_info,
 					const struct btrfs_block_group *group)
 {
+	struct btrfs_fs_info *fs_info = group->fs_info;
 	struct btrfs_inode *inode = NULL;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root;
@@ -3989,7 +3989,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 		goto out;
 	}
 
-	rc->data_inode = create_reloc_inode(fs_info, rc->block_group);
+	rc->data_inode = create_reloc_inode(rc->block_group);
 	if (IS_ERR(rc->data_inode)) {
 		err = PTR_ERR(rc->data_inode);
 		rc->data_inode = NULL;
-- 
2.45.2


