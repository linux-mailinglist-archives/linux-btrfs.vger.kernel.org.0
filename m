Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9D48E1C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 01:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbiANAvs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 19:51:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51598 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235723AbiANAvr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 19:51:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62E061F384
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642121506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbYmUjM+NclaFMHxFgEKGuy7CRrIwiERoceN54Inqko=;
        b=AJe/0mOap7O+rSN+zq347+5pO1C2Pq28Tq77Z0j87HoFgwyLXdLYaAW0X1ilnjXQtx0CLn
        2kNwlTD6Lxik70TUYgzqb2ALcig19bs9SNNxUkcuxifOpbD4IoT+BC9SAoXGlk2P7/67Bw
        vOUAfIRmM5CFm/zelxPwh/mU4+nUEBY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA4571344A
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qBnhGyHJ4GFWZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jan 2022 00:51:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs-progs: check: handle csum generation properly for `--init-csum-tree --init-extent-tree`
Date:   Fri, 14 Jan 2022 08:51:22 +0800
Message-Id: <20220114005123.19426-5-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114005123.19426-1-wqu@suse.com>
References: <20220114005123.19426-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When using `--init-csum-tree` with `--init-extent-tree`, csum tree
population will be done by iterating all file extent items.

This allow us to skip preallocated extents, but it still has the
folllwing problems:

- Inodes with NODATASUM

- Hole file extents

- Written preallocated extents
  We will generate csum for the whole extent, while other part may still
  be unwritten.

Make it to follow the same behavior of recently introduced
fill_csum_for_file_extent(), so we can generate correct csum.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-common.c | 53 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/check/mode-common.c b/check/mode-common.c
index 4c6dca2d5973..e487f2f0bb8e 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1225,6 +1225,7 @@ static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 	struct extent_buffer *node;
 	struct btrfs_file_extent_item *fi;
 	char *buf = NULL;
+	u64 skip_ino = 0;
 	u64 start = 0;
 	u64 len = 0;
 	int slot = 0;
@@ -1243,24 +1244,68 @@ static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 		goto out;
 	/* Iterate all regular file extents and fill its csum */
 	while (1) {
+		u8 type;
+
 		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 
-		if (key.type != BTRFS_EXTENT_DATA_KEY)
+		if (key.type != BTRFS_EXTENT_DATA_KEY &&
+		    key.type != BTRFS_INODE_ITEM_KEY)
+			goto next;
+
+		/* This item belongs to an inode with NODATASUM, skip it */
+		if (key.objectid == skip_ino)
 			goto next;
+
+		if (key.type == BTRFS_INODE_ITEM_KEY) {
+			struct btrfs_inode_item *ii;
+
+			ii = btrfs_item_ptr(path.nodes[0], path.slots[0],
+					    struct btrfs_inode_item);
+			/* Check if the inode has NODATASUM flag */
+			if (btrfs_inode_flags(path.nodes[0], ii) &
+			    BTRFS_INODE_NODATASUM)
+				skip_ino = key.objectid;
+			goto next;
+		}
 		node = path.nodes[0];
 		slot = path.slots[0];
 		fi = btrfs_item_ptr(node, slot, struct btrfs_file_extent_item);
-		if (btrfs_file_extent_type(node, fi) != BTRFS_FILE_EXTENT_REG)
+		type = btrfs_file_extent_type(node, fi);
+
+		/* Skip inline extents */
+		if (type == BTRFS_FILE_EXTENT_INLINE)
 			goto next;
-		start = btrfs_file_extent_disk_bytenr(node, fi);
-		len = btrfs_file_extent_disk_num_bytes(node, fi);
 
+		start = btrfs_file_extent_disk_bytenr(node, fi);
+		/* Skip holes */
+		if (start == 0)
+			goto next;
+		/*
+		 * Always generate the csum for the whole preallocated/regular
+		 * first, then remove the csum for preallocated range.
+		 *
+		 * This is to handle holes on regular extents like:
+		 * xfs_io -f -c "pwrite 0 8k" -c "sync" -c "punch 0 4k".
+		 *
+		 * This behavior will cost extra IO/CPU time, but there is
+		 * not other way to ensure the correctness.
+		 */
 		csum_root = btrfs_csum_root(gfs_info, start);
+		len = btrfs_file_extent_disk_num_bytes(node, fi);
 		ret = populate_csum(trans, csum_root, buf, start, len);
 		if (ret == -EEXIST)
 			ret = 0;
 		if (ret < 0)
 			goto out;
+
+		/* Delete the csum for the preallocated range */
+		if (type == BTRFS_FILE_EXTENT_PREALLOC) {
+			start += btrfs_file_extent_offset(node, fi);
+			len = btrfs_file_extent_num_bytes(node, fi);
+			ret = btrfs_del_csums(trans, start, len);
+			if (ret < 0)
+				goto out;
+		}
 next:
 		/*
 		 * TODO: if next leaf is corrupted, jump to nearest next valid
-- 
2.34.1

