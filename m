Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28353E0841
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbhHDStt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 14:49:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39570 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239055AbhHDStr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 14:49:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32E12222ED;
        Wed,  4 Aug 2021 18:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628102974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rRsycK7Oj2BSBfmsGE+1jES0lQihLv0tkwk9gFaK21w=;
        b=U+UHfE8cqFkYGxu9s5jatl4nq7UMFTcMYiLAoTY72okvmeOX1qnQ+cd1j2uZ5CI06G/oH6
        YPIrf242q+f/jz2G4SzwGNWKU0aC5xlFdCVBSOJfQLgm3zSyLYCuycbz/2DfQoKMQtK3Bb
        JH7Nov7Se1ver6EbFgQO+H3KpCxOwc4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE22B13D24;
        Wed,  4 Aug 2021 18:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CGR+KTzhCmGFOQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Wed, 04 Aug 2021 18:49:32 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 7/7] btrfs: ioctl: Simplify btrfs_ioctl_get_subvol_info
Date:   Wed,  4 Aug 2021 15:48:54 -0300
Message-Id: <20210804184854.10696-8-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804184854.10696-1-mpdesouza@suse.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

By using btrfs_find_item we can simplify the code. Also, remove the
-ENOENT error condition, since it'll never hit. If find_item returns 0,
it means it found the desired objectid and type, so it won't reach the -ENOENT
condition.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ioctl.c | 56 +++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index d09eaa83b5d2..2c57bea16c92 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2685,6 +2685,7 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	unsigned long item_off;
 	unsigned long item_len;
 	struct inode *inode;
+	u64 treeid;
 	int slot;
 	int ret = 0;
 
@@ -2702,15 +2703,15 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	fs_info = BTRFS_I(inode)->root->fs_info;
 
 	/* Get root_item of inode's subvolume */
-	key.objectid = BTRFS_I(inode)->root->root_key.objectid;
-	root = btrfs_get_fs_root(fs_info, key.objectid, true);
+	treeid = BTRFS_I(inode)->root->root_key.objectid;
+	root = btrfs_get_fs_root(fs_info, treeid, true);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
 		goto out_free;
 	}
 	root_item = &root->root_item;
 
-	subvol_info->treeid = key.objectid;
+	subvol_info->treeid = treeid;
 
 	subvol_info->generation = btrfs_root_generation(root_item);
 	subvol_info->flags = btrfs_root_flags(root_item);
@@ -2737,44 +2738,31 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	subvol_info->rtime.sec = btrfs_stack_timespec_sec(&root_item->rtime);
 	subvol_info->rtime.nsec = btrfs_stack_timespec_nsec(&root_item->rtime);
 
-	if (key.objectid != BTRFS_FS_TREE_OBJECTID) {
+	if (treeid != BTRFS_FS_TREE_OBJECTID) {
 		/* Search root tree for ROOT_BACKREF of this subvolume */
-		key.type = BTRFS_ROOT_BACKREF_KEY;
-		key.offset = 0;
-		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
+		ret = btrfs_find_item(fs_info->tree_root, path, treeid,
+					BTRFS_ROOT_BACKREF_KEY, 0, &key);
 		if (ret < 0) {
 			goto out;
-		} else if (path->slots[0] >=
-			   btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(fs_info->tree_root, path);
-			if (ret < 0) {
-				goto out;
-			} else if (ret > 0) {
-				ret = -EUCLEAN;
-				goto out;
-			}
+		} else if (ret > 0) {
+			ret = -EUCLEAN;
+			goto out;
 		}
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
-		btrfs_item_key_to_cpu(leaf, &key, slot);
-		if (key.objectid == subvol_info->treeid &&
-		    key.type == BTRFS_ROOT_BACKREF_KEY) {
-			subvol_info->parent_id = key.offset;
-
-			rref = btrfs_item_ptr(leaf, slot, struct btrfs_root_ref);
-			subvol_info->dirid = btrfs_root_ref_dirid(leaf, rref);
-
-			item_off = btrfs_item_ptr_offset(leaf, slot)
-					+ sizeof(struct btrfs_root_ref);
-			item_len = btrfs_item_size_nr(leaf, slot)
-					- sizeof(struct btrfs_root_ref);
-			read_extent_buffer(leaf, subvol_info->name,
-					   item_off, item_len);
-		} else {
-			ret = -ENOENT;
-			goto out;
-		}
+
+		subvol_info->parent_id = key.offset;
+
+		rref = btrfs_item_ptr(leaf, slot, struct btrfs_root_ref);
+		subvol_info->dirid = btrfs_root_ref_dirid(leaf, rref);
+
+		item_off = btrfs_item_ptr_offset(leaf, slot)
+				+ sizeof(struct btrfs_root_ref);
+		item_len = btrfs_item_size_nr(leaf, slot)
+				- sizeof(struct btrfs_root_ref);
+		read_extent_buffer(leaf, subvol_info->name,
+				   item_off, item_len);
 	}
 
 	if (copy_to_user(argp, subvol_info, sizeof(*subvol_info)))
-- 
2.31.1

