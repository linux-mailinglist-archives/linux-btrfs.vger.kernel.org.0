Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4BA2D14D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 16:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgLGPeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 10:34:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:46452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgLGPeO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Dec 2020 10:34:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607355162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SIjzYj4Pzn4wR0UkP0MMfeaQ93ixO46s+Upet0GlLDA=;
        b=h6qSpTGiL8vRAPRvG8oNLtv9YaC6EaoprVZBK6cYwjmuhSJHfIe7DQ8sMBAJfwGg5XbHKE
        zPooY4UqbKmUPXfvhwN3Nc6mxjJphjmciZ4IPGiUeI1AF++3dxFgDU53VFhZwH3BrVvfYV
        OJk95/csF9Cwvw8ZR0dwFxnxLWdeljo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73398ADB3;
        Mon,  7 Dec 2020 15:32:42 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 6/6] btrfs: Remove new_dirid argument from btrfs_create_subvol_root
Date:   Mon,  7 Dec 2020 17:32:37 +0200
Message-Id: <20201207153237.1073887-7-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207153237.1073887-1-nborisov@suse.com>
References: <20201207153237.1073887-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's no longer used. While at it also remove new_dirid in create_subvol
as it's used in a single place and open code it. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h | 3 +--
 fs/btrfs/inode.c | 3 +--
 fs/btrfs/ioctl.c | 5 ++---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e8652c73c189..616a4c6fefc3 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3089,8 +3089,7 @@ int btrfs_set_extent_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			      struct extent_state **cached_state);
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *new_root,
-			     struct btrfs_root *parent_root,
-			     u64 new_dirid);
+			     struct btrfs_root *parent_root);
  void btrfs_set_delalloc_extent(struct inode *inode, struct extent_state *state,
 			       unsigned *bits);
 void btrfs_clear_delalloc_extent(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aea76abd83ba..b82c5bde6a3e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8577,8 +8577,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
  */
 int btrfs_create_subvol_root(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *new_root,
-			     struct btrfs_root *parent_root,
-			     u64 new_dirid)
+			     struct btrfs_root *parent_root)
 {
 	struct inode *inode;
 	int err;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 58b9a27559c0..db29c1b54daa 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -606,7 +606,6 @@ static noinline int create_subvol(struct inode *dir,
 	int err;
 	dev_t anon_dev = 0;
 	u64 objectid;
-	u64 new_dirid = BTRFS_FIRST_FREE_OBJECTID;
 	u64 index = 0;
 
 	root_item = kzalloc(sizeof(*root_item), GFP_KERNEL);
@@ -693,7 +692,7 @@ static noinline int create_subvol(struct inode *dir,
 	free_extent_buffer(leaf);
 	leaf = NULL;
 
-	btrfs_set_root_dirid(root_item, new_dirid);
+	btrfs_set_root_dirid(root_item, BTRFS_FIRST_FREE_OBJECTID);
 
 	key.objectid = objectid;
 	key.offset = 0;
@@ -716,7 +715,7 @@ static noinline int create_subvol(struct inode *dir,
 
 	btrfs_record_root_in_trans(trans, new_root);
 
-	ret = btrfs_create_subvol_root(trans, new_root, root, new_dirid);
+	ret = btrfs_create_subvol_root(trans, new_root, root);
 	btrfs_put_root(new_root);
 	if (ret) {
 		/* We potentially lose an unused inode item here */
-- 
2.25.1

