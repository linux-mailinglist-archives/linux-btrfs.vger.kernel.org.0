Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F51408E0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 15:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241920AbhIMNbN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 09:31:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50752 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238976AbhIMNSs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 09:18:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D7271FFE0;
        Mon, 13 Sep 2021 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631539052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iBhQfNstU4BmU2perA7RNHxjovVx3JqoBj1xNXS7C60=;
        b=WeAwZ3AyPsNAjp38iejMembPL7XybGWg5C6V3zTK0oQu/Xhh8/wif5cDoGh0Fwol9xVR0w
        m4GHvvR1gOm1K5+4MQMoZOtWlcmD4hrZScPufErR9h/SscjAVcM6UoCJfUKB5dzEOuw28V
        BfPJgYnPfdsExkoPSC5IlJKNqjc+Wm8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 161DB13AB4;
        Mon, 13 Sep 2021 13:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GETiAmxPP2FNOwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Sep 2021 13:17:32 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/8] btrfs-progs: Add btrfs_uuid_tree_remove
Date:   Mon, 13 Sep 2021 16:17:26 +0300
Message-Id: <20210913131729.37897-6-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913131729.37897-1-nborisov@suse.com>
References: <20210913131729.37897-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It will be used to clear received data on RW snapshots that were
received.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 kernel-shared/ctree.h     |  3 ++
 kernel-shared/uuid-tree.c | 82 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 91a85796a678..158281a9fd67 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2860,6 +2860,9 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 			u64 subvol_id_cpu);
 
 int btrfs_is_empty_uuid(u8 *uuid);
+int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
+               u64 subid);
+
 
 static inline int is_fstree(u64 rootid)
 {
diff --git a/kernel-shared/uuid-tree.c b/kernel-shared/uuid-tree.c
index 51a7b5d9ff5d..0f0fbf667dda 100644
--- a/kernel-shared/uuid-tree.c
+++ b/kernel-shared/uuid-tree.c
@@ -120,3 +120,85 @@ int btrfs_is_empty_uuid(u8 *uuid)
 	}
 	return 1;
 }
+
+int btrfs_uuid_tree_remove(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
+		u64 subid)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *uuid_root = fs_info->uuid_root;
+	int ret;
+	struct btrfs_path *path = NULL;
+	struct btrfs_key key;
+	struct extent_buffer *eb;
+	int slot;
+	unsigned long offset;
+	u32 item_size;
+	unsigned long move_dst;
+	unsigned long move_src;
+	unsigned long move_len;
+
+	if (!uuid_root) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	btrfs_uuid_to_key(uuid, &key);
+	key.type = type;
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = btrfs_search_slot(trans, uuid_root, &key, path, -1, 1);
+	if (ret < 0) {
+		warning("error %d while searching for uuid item!", ret);
+		goto out;
+	}
+	if (ret > 0) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+
+	eb = path->nodes[0];
+	slot = path->slots[0];
+	offset = btrfs_item_ptr_offset(eb, slot);
+	item_size = btrfs_item_size_nr(eb, slot);
+	if (!IS_ALIGNED(item_size, sizeof(u64))) {
+		warning("uuid item with illegal size %lu!",	(unsigned long)item_size);
+		ret = -ENOENT;
+		goto out;
+	}
+	while (item_size) {
+		__le64 read_subid;
+
+		read_extent_buffer(eb, &read_subid, offset, sizeof(read_subid));
+		if (le64_to_cpu(read_subid) == subid)
+			break;
+		offset += sizeof(read_subid);
+		item_size -= sizeof(read_subid);
+	}
+
+	if (!item_size) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	item_size = btrfs_item_size_nr(eb, slot);
+	if (item_size == sizeof(subid)) {
+		ret = btrfs_del_item(trans, uuid_root, path);
+		goto out;
+	}
+
+	move_dst = offset;
+	move_src = offset + sizeof(subid);
+	move_len = item_size - (move_src - btrfs_item_ptr_offset(eb, slot));
+	memmove_extent_buffer(eb, move_dst, move_src, move_len);
+	btrfs_truncate_item(path, item_size - sizeof(subid), 1);
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
-- 
2.17.1

