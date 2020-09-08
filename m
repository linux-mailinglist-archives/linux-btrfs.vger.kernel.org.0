Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1E3260FC1
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbgIHK2Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 06:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbgIHK1g (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Sep 2020 06:27:36 -0400
Received: from falcondesktop.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9778A21532;
        Tue,  8 Sep 2020 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560856;
        bh=pKgloIj1ZcfnbfD0dgxStqh/2rwwQRONIg6xtwtAOvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=GIIis5drbcf/NaNnklzOs0OREq06sjrMmeTLCEb1FonkX3l+FlrPp/sqJbIFpZWVY
         tsyxOQTW7j5G2BHyCOtOehtAmBlGUUEBfvq1wOMqtUfroMjO67fdVVClVaCAjio+1Y
         ysDJSfvllUIDLPFe+ZlznEUuYbPTwzoOV6i0Gsm4=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 4/5] btrfs: rename btrfs_punch_hole_range() to a more generic name
Date:   Tue,  8 Sep 2020 11:27:23 +0100
Message-Id: <7e911d8b38d65c426738e53ac205eac94105c87f.1599560101.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1599560101.git.fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
In-Reply-To: <cover.1599560101.git.fdmanana@suse.com>
References: <cover.1599560101.git.fdmanana@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The function btrfs_punch_hole_range() is now used to replace all the file
extents in a given file range with an extent described in the given struct
btrfs_replace_extent_info argument. This extent can either be an existing
extent that is being cloned or it can be a new extent (namely a prealloc
extent). When that argument is NULL it only punches a hole (drop alls the
existing extents) in the file range.

So rename the function to btrfs_replace_file_extents().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h   | 2 +-
 fs/btrfs/file.c    | 4 ++--
 fs/btrfs/inode.c   | 2 +-
 fs/btrfs/reflink.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0b1dadd44e53..74ddff3529df 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3074,7 +3074,7 @@ int __btrfs_drop_extents(struct btrfs_trans_handle *trans,
 int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *root, struct inode *inode, u64 start,
 		       u64 end, int drop_cache);
-int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
+int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			   const u64 start, const u64 end,
 			   struct btrfs_replace_extent_info *extent_info,
 			   struct btrfs_trans_handle **trans_out);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7ac0a20119f3..241b34e44a6c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2659,7 +2659,7 @@ static int btrfs_insert_clone_extent(struct btrfs_trans_handle *trans,
  * extents without inserting a new one, so we must abort the transaction to avoid
  * a corruption.
  */
-int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
+int btrfs_replace_file_extents(struct inode *inode, struct btrfs_path *path,
 			   const u64 start, const u64 end,
 			   struct btrfs_replace_extent_info *extent_info,
 			   struct btrfs_trans_handle **trans_out)
@@ -3007,7 +3007,7 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		goto out;
 	}
 
-	ret = btrfs_punch_hole_range(inode, path, lockstart, lockend, NULL,
+	ret = btrfs_replace_file_extents(inode, path, lockstart, lockend, NULL,
 				     &trans);
 	btrfs_free_path(path);
 	if (ret)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a67b80979c48..9f6fb0ff33e7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9624,7 +9624,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	if (!path)
 		return ERR_PTR(-ENOMEM);
 
-	ret = btrfs_punch_hole_range(inode, path, file_offset,
+	ret = btrfs_replace_file_extents(inode, path, file_offset,
 				     file_offset + len - 1, &extent_info,
 				     &trans);
 	btrfs_free_path(path);
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index dc8b5397e198..39b3269e5760 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -463,7 +463,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			clone_info.file_offset = new_key.offset;
 			clone_info.extent_buf = buf;
 			clone_info.is_new_extent = false;
-			ret = btrfs_punch_hole_range(inode, path, drop_start,
+			ret = btrfs_replace_file_extents(inode, path, drop_start,
 					new_key.offset + datal - 1, &clone_info,
 					&trans);
 			if (ret)
@@ -533,7 +533,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		btrfs_release_path(path);
 		path->leave_spinning = 0;
 
-		ret = btrfs_punch_hole_range(inode, path, last_dest_end,
+		ret = btrfs_replace_file_extents(inode, path, last_dest_end,
 				destoff + len - 1, NULL, &trans);
 		if (ret)
 			goto out;
-- 
2.26.2

