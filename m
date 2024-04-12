Return-Path: <linux-btrfs+bounces-4196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704418A31C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 17:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6FE2824E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF900148823;
	Fri, 12 Apr 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsLBZZey"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ECC1487F0
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712934211; cv=none; b=O1WEo1FXRnU7XmSUoJLI0B7SVhnkGPLdGNzpF30m9lRQX7bPplhddpMHFudttlW3OF+zIM6Clj6Ho9KX+vQEHXunsPL/TG2eh84nhz9e3O0Db+ruQW5uwojhotdO9CC7GTM7eEoDhZSnWkW0w5AitiOJ77tpda9KRTPMh0J5TOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712934211; c=relaxed/simple;
	bh=GpLwSi/xgn0Cnu29Wac2kau0tUCw78yhYAJugtiyD4E=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luO077IfgwkYarQ154Od2DHx00fJ0zdBTWpdkz+i15T8bFSk0NT5FkQ5vfA3qGtn2/mnYbZbzpkKaVmWNlkfXeZ7CuwSXtCm+6ISX7gDWfZD8ai17rlDOU6xqbCYNyaal9Nknxgh6d8/EBpjLCjoPpzBfqRIwrQQbKlt24fvjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsLBZZey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761CAC113CC
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Apr 2024 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712934211;
	bh=GpLwSi/xgn0Cnu29Wac2kau0tUCw78yhYAJugtiyD4E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QsLBZZeyCiWSOa6uIia1a3OqZGU8GeVmTSkLCQWiYHDqCtNec63eOYl/AoCPpfY5W
	 KZgIAhol8VtfgcMOKOulZp8n6M+8tqky4b/krmCxmDF8QLy1QVMpJ976awsuc8LMLE
	 beQ9ymGe6U4mZNjusu82WkbeDrBXcATtrUESYhLjEJAc0f4MQJcEpRT1CI5VeU54i9
	 8+Oo7rmLoUQEb2HZZpJZ3wNCDT6VvxG2VD/DomBPi0wB2/BN59x7NKf+9fS1bhbgAQ
	 RR2GT2opqfg+VvyBD2mDJI0Fmu8m+v9VYVQmE+a6Aqsex8H/OxdHMFBwW6lqVSZkgp
	 YzUxv3aOYJ75g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs: open code csum_exist_in_range()
Date: Fri, 12 Apr 2024 16:03:20 +0100
Message-Id: <43c7b46211cc26f0f47ccd8bca522d70e4e563b8.1712933006.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712933003.git.fdmanana@suse.com>
References: <cover.1712933003.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The csum_exist_in_range() function is now too trivial and is only used in
one place, so open code it in its single caller.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1d78e07d082b..f23511428e74 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1737,15 +1737,6 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 	return 1;
 }
 
-static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
-					u64 bytenr, u64 num_bytes, bool nowait)
-{
-	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, bytenr);
-
-	return btrfs_lookup_csums_list(csum_root, bytenr, bytenr + num_bytes - 1,
-				       NULL, nowait);
-}
-
 static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 			   const u64 start, const u64 end)
 {
@@ -1860,6 +1851,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_root *root = inode->root;
 	struct btrfs_file_extent_item *fi;
+	struct btrfs_root *csum_root;
 	u64 extent_end;
 	u8 extent_type;
 	int can_nocow = 0;
@@ -1920,7 +1912,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	if (args->free_path) {
 		/*
 		 * We don't need the path anymore, plus through the
-		 * csum_exist_in_range() call below we will end up allocating
+		 * btrfs_lookup_csums_list() call below we will end up allocating
 		 * another path. So free the path to avoid unnecessary extra
 		 * memory usage.
 		 */
@@ -1941,8 +1933,11 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	 * Force COW if csums exist in the range. This ensures that csums for a
 	 * given extent are either valid or do not exist.
 	 */
-	ret = csum_exist_in_range(root->fs_info, args->disk_bytenr, args->num_bytes,
-				  nowait);
+
+	csum_root = btrfs_csum_root(root->fs_info, args->disk_bytenr);
+	ret = btrfs_lookup_csums_list(csum_root, args->disk_bytenr,
+				      args->disk_bytenr + args->num_bytes - 1,
+				      NULL, nowait);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
 		goto out;
-- 
2.43.0


