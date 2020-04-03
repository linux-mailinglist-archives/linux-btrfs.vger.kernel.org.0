Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C30E19D7EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390883AbgDCNoj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 09:44:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgDCNoj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 09:44:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 71F92ABD1;
        Fri,  3 Apr 2020 13:44:37 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [RESEND PATCH] btrfs: Remove received information from snapshot on ro->rw switch
Date:   Fri,  3 Apr 2020 16:44:36 +0300
Message-Id: <20200403134436.9095-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently when a read-only snapshot is received and subsequently its
ro property is set to false i.e. switched to rw-mode the
received_uuid/stime/rtime/stransid/rtransid of that subvol remains
intact. However, once the received volume is switched to RW mode we
cannot guaranteee that it contains the same data, so it makes sense
to remove those fields which indicate this volume was ever
send/received. Additionally, sending such volume can cause conflicts
due to the presence of received_uuid.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Suggested-by: David Sterba <dsterba@suse.cz>
---

I've been carrying this patch in my tree for around 2.5 years. It stems from
multiple reports on the mailing list about people changing the RO->RW mode on
a received snapshot and getting unexpected behavior. AFAIR this patch resolved
that.


 fs/btrfs/ioctl.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 40b729dce91c..39840b654600 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1873,6 +1873,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	struct btrfs_trans_handle *trans;
 	u64 root_flags;
 	u64 flags;
+	bool clear_received_state = false;
 	int ret = 0;

 	if (!inode_owner_or_capable(inode))
@@ -1917,6 +1918,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 			btrfs_set_root_flags(&root->root_item,
 				     root_flags & ~BTRFS_ROOT_SUBVOL_RDONLY);
 			spin_unlock(&root->root_item_lock);
+			clear_received_state = true;
 		} else {
 			spin_unlock(&root->root_item_lock);
 			btrfs_warn(fs_info,
@@ -1933,6 +1935,31 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 		goto out_reset;
 	}

+	if (clear_received_state) {
+	        if (!btrfs_is_empty_uuid(root->root_item.received_uuid)) {
+			struct btrfs_root_item *root_item = &root->root_item;
+
+	                ret = btrfs_uuid_tree_remove(trans,
+	                                root->root_item.received_uuid,
+	                                BTRFS_UUID_KEY_RECEIVED_SUBVOL,
+	                                root->root_key.objectid);
+
+	                if (ret && ret != -ENOENT) {
+	                        btrfs_abort_transaction(trans, ret);
+	                        btrfs_end_transaction(trans);
+	                        goto out_reset;
+	                }
+
+	                memset(root_item->received_uuid, 0, BTRFS_UUID_SIZE);
+			btrfs_set_root_stransid(root_item, 0);
+			btrfs_set_root_rtransid(root_item, 0);
+			btrfs_set_stack_timespec_sec(&root_item->stime, 0);
+			btrfs_set_stack_timespec_nsec(&root_item->stime, 0);
+			btrfs_set_stack_timespec_sec(&root_item->rtime, 0);
+			btrfs_set_stack_timespec_nsec(&root_item->rtime, 0);
+	        }
+	}
+
 	ret = btrfs_update_root(trans, fs_info->tree_root,
 				&root->root_key, &root->root_item);
 	if (ret < 0) {
--
2.17.1

