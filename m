Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242573D819C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhG0VTk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:19:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45968 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbhG0VR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:17:57 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0A6A42017C;
        Tue, 27 Jul 2021 21:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627420676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frYSfLVEsDV2Yukyj70wAHokIYWt5tbtqzv6kNoUs+c=;
        b=TK7/Kn8quor4ZRDZGOS9JC4owDVeL6sDiRjt2Ty1RTjBXNY8R5V8JOS0SC+HlKjUE4wo3g
        bXJXCA27VvT1RLGc4W5XAN4o9i8s4Drz/HnXjj9hoRF2YJQ+zTulu6iXoDw6Z+SH3lJoxG
        W6QRvTPwNSr86+xr/XzZC5TTZeQAAFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627420676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=frYSfLVEsDV2Yukyj70wAHokIYWt5tbtqzv6kNoUs+c=;
        b=P3Q73o4/OVF0iCuda9AIUdBeQAn+P121GnuZ3xfBOTNruNfV7Z6wUxnSrFvmCDCm2nCMc8
        t/w/6nhVe2HAprBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8FF88133DE;
        Tue, 27 Jul 2021 21:17:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Dt9GDwN4AGF7dQAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Tue, 27 Jul 2021 21:17:55 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/7] btrfs: Allocate btrfs_ioctl_get_subvol_info_args on stack
Date:   Tue, 27 Jul 2021 16:17:27 -0500
Message-Id: <2200f9340973d627ee304ac4470f5921061266f9.1627418762.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627418762.git.rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Instead of using kmalloc() to allocate btrfs_ioctl_get_subvol_info_args,
allocate btrfs_ioctl_get_subvol_info_args on stack.

sizeof(btrfs_ioctl_get_subvol_info_args) = 504

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ioctl.c | 55 +++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ba98e08a029..90b134b5a653 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2681,7 +2681,7 @@ static int btrfs_ioctl_ino_lookup_user(struct file *file, void __user *argp)
 /* Get the subvolume information in BTRFS_ROOT_ITEM and BTRFS_ROOT_BACKREF */
 static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 {
-	struct btrfs_ioctl_get_subvol_info_args *subvol_info;
+	struct btrfs_ioctl_get_subvol_info_args subvol_info = {0};
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_root *root;
 	struct btrfs_path *path;
@@ -2699,12 +2699,6 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	if (!path)
 		return -ENOMEM;
 
-	subvol_info = kzalloc(sizeof(*subvol_info), GFP_KERNEL);
-	if (!subvol_info) {
-		btrfs_free_path(path);
-		return -ENOMEM;
-	}
-
 	inode = file_inode(file);
 	fs_info = BTRFS_I(inode)->root->fs_info;
 
@@ -2717,32 +2711,32 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	}
 	root_item = &root->root_item;
 
-	subvol_info->treeid = key.objectid;
+	subvol_info.treeid = key.objectid;
 
-	subvol_info->generation = btrfs_root_generation(root_item);
-	subvol_info->flags = btrfs_root_flags(root_item);
+	subvol_info.generation = btrfs_root_generation(root_item);
+	subvol_info.flags = btrfs_root_flags(root_item);
 
-	memcpy(subvol_info->uuid, root_item->uuid, BTRFS_UUID_SIZE);
-	memcpy(subvol_info->parent_uuid, root_item->parent_uuid,
+	memcpy(subvol_info.uuid, root_item->uuid, BTRFS_UUID_SIZE);
+	memcpy(subvol_info.parent_uuid, root_item->parent_uuid,
 						    BTRFS_UUID_SIZE);
-	memcpy(subvol_info->received_uuid, root_item->received_uuid,
+	memcpy(subvol_info.received_uuid, root_item->received_uuid,
 						    BTRFS_UUID_SIZE);
 
-	subvol_info->ctransid = btrfs_root_ctransid(root_item);
-	subvol_info->ctime.sec = btrfs_stack_timespec_sec(&root_item->ctime);
-	subvol_info->ctime.nsec = btrfs_stack_timespec_nsec(&root_item->ctime);
+	subvol_info.ctransid = btrfs_root_ctransid(root_item);
+	subvol_info.ctime.sec = btrfs_stack_timespec_sec(&root_item->ctime);
+	subvol_info.ctime.nsec = btrfs_stack_timespec_nsec(&root_item->ctime);
 
-	subvol_info->otransid = btrfs_root_otransid(root_item);
-	subvol_info->otime.sec = btrfs_stack_timespec_sec(&root_item->otime);
-	subvol_info->otime.nsec = btrfs_stack_timespec_nsec(&root_item->otime);
+	subvol_info.otransid = btrfs_root_otransid(root_item);
+	subvol_info.otime.sec = btrfs_stack_timespec_sec(&root_item->otime);
+	subvol_info.otime.nsec = btrfs_stack_timespec_nsec(&root_item->otime);
 
-	subvol_info->stransid = btrfs_root_stransid(root_item);
-	subvol_info->stime.sec = btrfs_stack_timespec_sec(&root_item->stime);
-	subvol_info->stime.nsec = btrfs_stack_timespec_nsec(&root_item->stime);
+	subvol_info.stransid = btrfs_root_stransid(root_item);
+	subvol_info.stime.sec = btrfs_stack_timespec_sec(&root_item->stime);
+	subvol_info.stime.nsec = btrfs_stack_timespec_nsec(&root_item->stime);
 
-	subvol_info->rtransid = btrfs_root_rtransid(root_item);
-	subvol_info->rtime.sec = btrfs_stack_timespec_sec(&root_item->rtime);
-	subvol_info->rtime.nsec = btrfs_stack_timespec_nsec(&root_item->rtime);
+	subvol_info.rtransid = btrfs_root_rtransid(root_item);
+	subvol_info.rtime.sec = btrfs_stack_timespec_sec(&root_item->rtime);
+	subvol_info.rtime.nsec = btrfs_stack_timespec_nsec(&root_item->rtime);
 
 	if (key.objectid != BTRFS_FS_TREE_OBJECTID) {
 		/* Search root tree for ROOT_BACKREF of this subvolume */
@@ -2765,18 +2759,18 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 		btrfs_item_key_to_cpu(leaf, &key, slot);
-		if (key.objectid == subvol_info->treeid &&
+		if (key.objectid == subvol_info.treeid &&
 		    key.type == BTRFS_ROOT_BACKREF_KEY) {
-			subvol_info->parent_id = key.offset;
+			subvol_info.parent_id = key.offset;
 
 			rref = btrfs_item_ptr(leaf, slot, struct btrfs_root_ref);
-			subvol_info->dirid = btrfs_root_ref_dirid(leaf, rref);
+			subvol_info.dirid = btrfs_root_ref_dirid(leaf, rref);
 
 			item_off = btrfs_item_ptr_offset(leaf, slot)
 					+ sizeof(struct btrfs_root_ref);
 			item_len = btrfs_item_size_nr(leaf, slot)
 					- sizeof(struct btrfs_root_ref);
-			read_extent_buffer(leaf, subvol_info->name,
+			read_extent_buffer(leaf, subvol_info.name,
 					   item_off, item_len);
 		} else {
 			ret = -ENOENT;
@@ -2784,14 +2778,13 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 		}
 	}
 
-	if (copy_to_user(argp, subvol_info, sizeof(*subvol_info)))
+	if (copy_to_user(argp, &subvol_info, sizeof(subvol_info)))
 		ret = -EFAULT;
 
 out:
 	btrfs_put_root(root);
 out_free:
 	btrfs_free_path(path);
-	kfree(subvol_info);
 	return ret;
 }
 
-- 
2.32.0

