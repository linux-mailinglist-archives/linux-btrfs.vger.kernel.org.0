Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C21FA65F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jun 2020 04:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFPCRu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 22:17:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:39564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgFPCRu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 22:17:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68670AE69
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Jun 2020 02:17:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: detect uninitialized btrfs_root::anon_dev for user visible subvolumes
Date:   Tue, 16 Jun 2020 10:17:35 +0800
Message-Id: <20200616021737.44617-3-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616021737.44617-1-wqu@suse.com>
References: <20200616021737.44617-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_root::anon_dev is an indicator for different subvolume namespaces.
Thus it should always be initialized to an anonymous block device.

Add a safe net to catch such uninitialized values.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 00647e8cf2df..195aac71fe32 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8697,6 +8697,7 @@ static int btrfs_getattr(const struct path *path, struct kstat *stat,
 {
 	u64 delalloc_bytes;
 	struct inode *inode = d_inode(path->dentry);
+	struct btrfs_root *root = BTRFS_I(inode)->root;
 	u32 blocksize = inode->i_sb->s_blocksize;
 	u32 bi_flags = BTRFS_I(inode)->flags;
 
@@ -8718,7 +8719,13 @@ static int btrfs_getattr(const struct path *path, struct kstat *stat,
 				  STATX_ATTR_NODUMP);
 
 	generic_fillattr(inode, stat);
-	stat->dev = BTRFS_I(inode)->root->anon_dev;
+	if (unlikely(!root->anon_dev)) {
+		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+		btrfs_warn(root->fs_info,
+		"uninitialized btrfs_root::anon_dev detected, root=%llu",
+			   root->root_key.objectid);
+	}
+	stat->dev = root->anon_dev;
 
 	spin_lock(&BTRFS_I(inode)->lock);
 	delalloc_bytes = BTRFS_I(inode)->new_delalloc_bytes;
-- 
2.27.0

