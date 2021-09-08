Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D625D403AF8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 15:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbhIHNwq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 09:52:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38326 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhIHNwp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 09:52:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F07B822279;
        Wed,  8 Sep 2021 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631109096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=f+nmeiL9ojNW1G9Jnh9Tzxv66oVxgo0ZJpXxczh7+xc=;
        b=EfP2GjwtI5X4U6tN8iBPPpuNqnlm2CX2gkGrzs+H8TS5+MFM46TCn9AldFP3ERvTXcNu3+
        HOp8DLa9lVZuwbcak2FBBhZJAthFLkMBhAXEdy+qvC4H6jqoKQ/h+a8DvQ7pT5fWYL/6at
        gHMoqq4MB+E9IpkOmcMJFpHvuQwf9uY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B00B413A8B;
        Wed,  8 Sep 2021 13:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id C0wUKOi/OGHWKgAAGKfGzw
        (envelope-from <nborisov@suse.com>); Wed, 08 Sep 2021 13:51:36 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>, David Sterba <dsterba@suse.cz>
Subject: [PATCH v2] btrfs: Remove received information from snapshot on ro->rw switch
Date:   Wed,  8 Sep 2021 16:51:35 +0300
Message-Id: <20210908135135.1474055-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Preserving the received_uuid (and related fields) after transitioning the
snapshot from RO to RW and then changing the snapshot has a potential for
causing send to fail in many unexpected ways if we later turn it back to
RO and use it for an incremental send operation.

A recent example, in the thread to which the Link tag below points to, we
had a user with a filesystem that had multiple snapshots with the same
received_uuid but with different content due to a transition from RO to RW
and then back to RO. When an incremental send was attempted using two of
those snapshots, it resulted in send emitting a clone operation that was
intended to clone from the parent root to the send root - however because
both roots had the same received_uuid, the receiver ended up picking the
send root as the source root for the clone operation, which happened to
result in the clone operation to fail with -EINVAL, due to the source and
destination offsets being the same (and on the same root and file). In this
particular case there was no harm, but we could end up in a case where the
clone operation succeeds but clones wrong data due to picking up an
incorrect root - as in the case of multiple snapshots with the same
received_uuid, it has no way to know which one is the correct one if they
have different content.

Link: https://lore.kernel.org/linux-btrfs/CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com/
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Suggested-by: David Sterba <dsterba@suse.cz>
---
 fs/btrfs/ioctl.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 9eb0c1eb568e..67709d274489 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1927,9 +1927,11 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root_item *root_item = &root->root_item;
 	struct btrfs_trans_handle *trans;
 	u64 root_flags;
 	u64 flags;
+	bool clear_received_state = false;
 	int ret = 0;
 
 	if (!inode_owner_or_capable(file_mnt_user_ns(file), inode))
@@ -1960,9 +1962,9 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 	if (!!(flags & BTRFS_SUBVOL_RDONLY) == btrfs_root_readonly(root))
 		goto out_drop_sem;
 
-	root_flags = btrfs_root_flags(&root->root_item);
+	root_flags = btrfs_root_flags(root_item);
 	if (flags & BTRFS_SUBVOL_RDONLY) {
-		btrfs_set_root_flags(&root->root_item,
+		btrfs_set_root_flags(root_item,
 				     root_flags | BTRFS_ROOT_SUBVOL_RDONLY);
 	} else {
 		/*
@@ -1971,9 +1973,10 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 		 */
 		spin_lock(&root->root_item_lock);
 		if (root->send_in_progress == 0) {
-			btrfs_set_root_flags(&root->root_item,
+			btrfs_set_root_flags(root_item,
 				     root_flags & ~BTRFS_ROOT_SUBVOL_RDONLY);
 			spin_unlock(&root->root_item_lock);
+			clear_received_state = true;
 		} else {
 			spin_unlock(&root->root_item_lock);
 			btrfs_warn(fs_info,
@@ -1984,14 +1987,40 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
 		}
 	}
 
-	trans = btrfs_start_transaction(root, 1);
+	/*
+	 * 1 item for updating the uuid root in the root tree
+	 * 1 item for actually removing the uuid record in the uuid tree
+	 */
+	trans = btrfs_start_transaction(root, 2);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		goto out_reset;
 	}
 
-	ret = btrfs_update_root(trans, fs_info->tree_root,
-				&root->root_key, &root->root_item);
+	if (clear_received_state &&
+	    !btrfs_is_empty_uuid(root_item->received_uuid)) {
+
+		ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
+					     BTRFS_UUID_KEY_RECEIVED_SUBVOL,
+					     root->root_key.objectid);
+
+		if (ret && ret != -ENOENT) {
+			btrfs_abort_transaction(trans, ret);
+			btrfs_end_transaction(trans);
+			goto out_reset;
+		}
+
+		memset(root_item->received_uuid, 0, BTRFS_UUID_SIZE);
+		btrfs_set_root_stransid(root_item, 0);
+		btrfs_set_root_rtransid(root_item, 0);
+		btrfs_set_stack_timespec_sec(&root_item->stime, 0);
+		btrfs_set_stack_timespec_nsec(&root_item->stime, 0);
+		btrfs_set_stack_timespec_sec(&root_item->rtime, 0);
+		btrfs_set_stack_timespec_nsec(&root_item->rtime, 0);
+	}
+
+	ret = btrfs_update_root(trans, fs_info->tree_root, &root->root_key,
+				root_item);
 	if (ret < 0) {
 		btrfs_end_transaction(trans);
 		goto out_reset;
-- 
2.25.1

