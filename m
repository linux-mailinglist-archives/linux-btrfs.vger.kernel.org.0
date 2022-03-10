Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E713D4D51CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 20:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbiCJTXu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 14:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbiCJTXt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 14:23:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E667A4F9C6
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 11:22:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B9F6104D
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 19:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42C4C340E8
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 19:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646940165;
        bh=alBPzXFnIEb8aNA35R7NEAcklxyTS838McbxjdXKN/M=;
        h=Date:From:To:Subject:From;
        b=u/IbrcuRlDNroVRgtOmWAOZux42RjHulJMR3UUabgjD1TdrfYez/ayGzMsXDl9cEt
         frDxDYjV5lJYo0rkQ3avBh1DdXnuR8lPn2na+rgAhPJ8efqgZKQPCpiaeUDHmIjW4B
         M5A0BugRV/35rOrhCYqhSlMScL39AWCU2LFw7klC9HdsczLPHKM1dzP1BVV8LNKUcj
         8kMUlJjwcYYZWdaYWa8XPnKRXN1nIZ97m9T9MAkbmV2VIO9/dK0PLCgG6PdfJEbPcn
         2bO/xnoaN0/KzfGvu6wgdMRwfZ+TtZ/PSKRIA0Z71vnJ6enXPAhWZbC5BohmYlAGOP
         l3RATGQCoczNw==
Date:   Thu, 10 Mar 2022 11:22:45 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix fallocate to use file_modified to update
 permissions consistently
Message-ID: <20220310192245.GA8165@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Since the initial introduction of (posix) fallocate back at the turn of
the century, it has been possible to use this syscall to change the
user-visible contents of files.  This can happen by extending the file
size during a preallocation, or through any of the newer modes (punch,
zero range).  Because the call can be used to change file contents, we
should treat it like we do any other modification to a file -- update
the mtime, and drop set[ug]id privileges/capabilities.

The VFS function file_modified() does all this for us if pass it a
locked inode, so let's make fallocate drop permissions correctly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
Note: I plan to add fstests to test this behavior, but after the
generic/673 mess, I'm holding back on them until I can fix the three
major filesystems and clean up the xfs setattr_copy code.

https://lore.kernel.org/linux-ext4/20220310174410.GB8172@magnolia/T/#u
---
 fs/btrfs/file.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a0179cc62913..79e61c88b9e7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2918,8 +2918,9 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	return ret;
 }
 
-static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
+static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 {
+	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct extent_state *cached_state = NULL;
@@ -2951,6 +2952,10 @@ static int btrfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		goto out_only_mutex;
 	}
 
+	ret = file_modified(file);
+	if (ret)
+		goto out_only_mutex;
+
 	lockstart = round_up(offset, btrfs_inode_sectorsize(BTRFS_I(inode)));
 	lockend = round_down(offset + len,
 			     btrfs_inode_sectorsize(BTRFS_I(inode))) - 1;
@@ -3177,11 +3182,12 @@ static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 	return ret;
 }
 
-static int btrfs_zero_range(struct inode *inode,
+static int btrfs_zero_range(struct file *file,
 			    loff_t offset,
 			    loff_t len,
 			    const int mode)
 {
+	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	struct extent_map *em;
 	struct extent_changeset *data_reserved = NULL;
@@ -3202,6 +3208,12 @@ static int btrfs_zero_range(struct inode *inode,
 		goto out;
 	}
 
+	ret = file_modified(file);
+	if (ret) {
+		free_extent_map(em);
+		goto out;
+	}
+
 	/*
 	 * Avoid hole punching and extent allocation for some cases. More cases
 	 * could be considered, but these are unlikely common and we keep things
@@ -3391,7 +3403,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 		return -EOPNOTSUPP;
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
-		return btrfs_punch_hole(inode, offset, len);
+		return btrfs_punch_hole(file, offset, len);
 
 	/*
 	 * Only trigger disk allocation, don't trigger qgroup reserve
@@ -3446,7 +3458,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 		goto out;
 
 	if (mode & FALLOC_FL_ZERO_RANGE) {
-		ret = btrfs_zero_range(inode, offset, len, mode);
+		ret = btrfs_zero_range(file, offset, len, mode);
 		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 		return ret;
 	}
@@ -3528,6 +3540,9 @@ static long btrfs_fallocate(struct file *file, int mode,
 		cur_offset = last_byte;
 	}
 
+	if (!ret)
+		ret = file_modified(file);
+
 	/*
 	 * If ret is still 0, means we're OK to fallocate.
 	 * Or just cleanup the list and exit.
