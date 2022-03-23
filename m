Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095014E5637
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245448AbiCWQVR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245441AbiCWQVO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 12:21:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DEE78FCA
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 09:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C44FC61865
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0E2C340F3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 16:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648052383;
        bh=VDfNHrN6fgL0zR2XROhkx6lGMuTcPcuAzQtmOWm+qfo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UOULBVRQswoKEgtwyeixwpoYuZfQAlOqe58VnOQ7b2ih2oJJK5pQ0NW9TTBpK0e3K
         OcY00V6qW2yIYncUoTFNgCY/fW5jRoaGLP0b66BjxGKm7adQm5HyI4MJBU2FA24uc6
         M7N5QNhDgLrqC2e0DqLDhDkEI2mmjxWcAgOP7f1P8/q8VK9PftRE5CZvqM3U6wvWoB
         TKZNEiP5pXZk47lwAB4Lm8S2MGb12edAuCtpSd5UXr2Dy8+I7D4qE0hIFBjdZ8rFMb
         +cdJnFHDCB40kY4/aY5gQ7him3d11wv7h22vR5VoJotS880C6acHie3Ej/Rw5qNnU/
         nHXEJ/RdxI+Gg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: stop allocating a path when checking if cross reference exists
Date:   Wed, 23 Mar 2022 16:19:26 +0000
Message-Id: <8f0daae1877cb41db1a46d3a8200eaea3857615d.1648051582.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648051582.git.fdmanana@suse.com>
References: <cover.1648051582.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_cross_ref_exist() we always allocate a path, but we really don't
need to because all its callers (only 2) already have an allocated path
that is not being used when they call btrfs_cross_ref_exist(). So change
btrfs_cross_ref_exist() to take a path as an argument and update both
its callers to pass in the unused path they have when they call
btrfs_cross_ref_exist().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h       | 3 ++-
 fs/btrfs/extent-tree.c | 9 ++-------
 fs/btrfs/inode.c       | 5 +++--
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 09b7b0b2d016..85216b9492d5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2783,7 +2783,8 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 				    u64 bytenr, u64 num_bytes);
 int btrfs_exclude_logged_extents(struct extent_buffer *eb);
 int btrfs_cross_ref_exist(struct btrfs_root *root,
-			  u64 objectid, u64 offset, u64 bytenr, bool strict);
+			  u64 objectid, u64 offset, u64 bytenr, bool strict,
+			  struct btrfs_path *path);
 struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
 					     u64 parent, u64 root_objectid,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f477035a2ac2..b451550fbb09 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2357,15 +2357,10 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 }
 
 int btrfs_cross_ref_exist(struct btrfs_root *root, u64 objectid, u64 offset,
-			  u64 bytenr, bool strict)
+			  u64 bytenr, bool strict, struct btrfs_path *path)
 {
-	struct btrfs_path *path;
 	int ret;
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
 	do {
 		ret = check_committed_ref(root, path, objectid,
 					  offset, bytenr, strict);
@@ -2376,7 +2371,7 @@ int btrfs_cross_ref_exist(struct btrfs_root *root, u64 objectid, u64 offset,
 	} while (ret == -EAGAIN);
 
 out:
-	btrfs_free_path(path);
+	btrfs_release_path(path);
 	if (btrfs_is_data_reloc_root(root))
 		WARN_ON(ret > 0);
 	return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c4b77017bf5c..f185d8f8b7fe 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1800,7 +1800,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 			ret = btrfs_cross_ref_exist(root, ino,
 						    found_key.offset -
-						    extent_offset, disk_bytenr, false);
+						    extent_offset, disk_bytenr,
+						    false, path);
 			if (ret) {
 				/*
 				 * ret could be -EIO if the above fails to read
@@ -7227,7 +7228,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 
 	ret = btrfs_cross_ref_exist(root, btrfs_ino(BTRFS_I(inode)),
 				    key.offset - backref_offset, disk_bytenr,
-				    strict);
+				    strict, path);
 	if (ret) {
 		ret = 0;
 		goto out;
-- 
2.33.0

