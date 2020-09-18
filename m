Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8926F909
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 11:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIRJP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 05:15:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIRJP4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 05:15:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600420555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=VLll/ZeNUZ6POyzM8SoDTdJ3OEdBU+ljHkn9+QP7j0w=;
        b=C9v2ehVGfX+5z2zRIGbALHeTvO9Wt8CpF4FU5KJVbGQGEl2pr1GYZSoQMXcQlYfw5bebZ5
        8fEG/ye+2PCTIm+sFU8ZNcsMKpoKyPlLewiQTDh9i5OUFxcl0i4lnDLjPt8Plx5RRyW2Fo
        tTJLQWGf+8O0M4F7+Npz1T7o/Ro2/Rc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B340AD39;
        Fri, 18 Sep 2020 09:16:29 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/5] btrfs: Sink inode argument in insert_ordered_extent_file_extent
Date:   Fri, 18 Sep 2020 12:15:51 +0300
Message-Id: <20200918091553.29584-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918091553.29584-1-nborisov@suse.com>
References: <20200918091553.29584-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5bcc9307b0f9..7554d7049195 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2534,7 +2534,6 @@ static void btrfs_release_delalloc_bytes(struct btrfs_fs_info *fs_info,
 }
 
 static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
-					     struct inode *inode,
 					     struct btrfs_ordered_extent *oe)
 {
 	struct btrfs_file_extent_item stack_fi;
@@ -2554,8 +2553,9 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
 	/* Encryption and other encoding is reserved and all 0 */
 
-	return insert_reserved_file_extent(trans, BTRFS_I(inode), oe->file_offset,
-					   &stack_fi, oe->qgroup_rsv);
+	return insert_reserved_file_extent(trans, BTRFS_I(oe->inode),
+					   oe->file_offset, &stack_fi,
+					   oe->qgroup_rsv);
 }
 
 /*
@@ -2652,8 +2652,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 						logical_len);
 	} else {
 		BUG_ON(root == fs_info->tree_root);
-		ret = insert_ordered_extent_file_extent(trans, inode,
-							ordered_extent);
+		ret = insert_ordered_extent_file_extent(trans, ordered_extent);
 		if (!ret) {
 			clear_reserved_extent = false;
 			btrfs_release_delalloc_bytes(fs_info,
-- 
2.17.1

