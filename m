Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4743C3E083B
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239065AbhHDStp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 14:49:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34828 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbhHDStk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 14:49:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A03B41FE1C;
        Wed,  4 Aug 2021 18:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628102965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhmuorOBPK9EjFUWgMNHJe/UF0seN4+kjM0msp4qREU=;
        b=ZkTo6fYTwc3ejNzv7ns+a4edZcfpBV1w5kn6r1ipfXGQD+Mc7iaWiMUoL89QGQ/DY3Qc3A
        q42c4EPKOmgVSohsowdJY0IuTSqwclECJikzm62WIhHHBWDF5Ph2VxznHcAeY8bF3dHdN4
        QUVH1RbPeg8NwagWC/jISD7MDrLs000=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5105413D24;
        Wed,  4 Aug 2021 18:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eAnmBjThCmGFOQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Wed, 04 Aug 2021 18:49:24 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 2/7] btrfs: backref: Use btrfs_find_item in btrfs_find_one_extref
Date:   Wed,  4 Aug 2021 15:48:49 -0300
Message-Id: <20210804184854.10696-3-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804184854.10696-1-mpdesouza@suse.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_find_one_extref is using btrfs_search_slot and iterating over the
slots, but in reality it only desires to find an extref, since there is
a break without any condition at the end of the while clause.

The function can be dramatically simplified by using btrfs_find_item, which
calls the btrfs_search_slot, compares if the objectid and type found
are the same of those passed as search key, and calls
btrfs_item_key_to_cpu if no error was found.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/backref.c | 64 ++++++++--------------------------------------
 1 file changed, 11 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 9e92faaafa02..57b955c8a875 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1588,67 +1588,25 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 			  struct btrfs_inode_extref **ret_extref,
 			  u64 *found_off)
 {
-	int ret, slot;
+	int ret;
 	struct btrfs_key key;
-	struct btrfs_key found_key;
 	struct btrfs_inode_extref *extref;
-	const struct extent_buffer *leaf;
 	unsigned long ptr;
 
-	key.objectid = inode_objectid;
-	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = start_off;
-
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	ret = btrfs_find_item(root, path, inode_objectid, BTRFS_INODE_EXTREF_KEY,
+			      start_off, &key);
 	if (ret < 0)
 		return ret;
+	else if (ret > 0)
+		return -ENOENT;
 
-	while (1) {
-		leaf = path->nodes[0];
-		slot = path->slots[0];
-		if (slot >= btrfs_header_nritems(leaf)) {
-			/*
-			 * If the item at offset is not found,
-			 * btrfs_search_slot will point us to the slot
-			 * where it should be inserted. In our case
-			 * that will be the slot directly before the
-			 * next INODE_REF_KEY_V2 item. In the case
-			 * that we're pointing to the last slot in a
-			 * leaf, we must move one leaf over.
-			 */
-			ret = btrfs_next_leaf(root, path);
-			if (ret) {
-				if (ret >= 1)
-					ret = -ENOENT;
-				break;
-			}
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
-
-		/*
-		 * Check that we're still looking at an extended ref key for
-		 * this particular objectid. If we have different
-		 * objectid or type then there are no more to be found
-		 * in the tree and we can exit.
-		 */
-		ret = -ENOENT;
-		if (found_key.objectid != inode_objectid)
-			break;
-		if (found_key.type != BTRFS_INODE_EXTREF_KEY)
-			break;
-
-		ret = 0;
-		ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
-		extref = (struct btrfs_inode_extref *)ptr;
-		*ret_extref = extref;
-		if (found_off)
-			*found_off = found_key.offset;
-		break;
-	}
+	ptr = btrfs_item_ptr_offset(path->nodes[0], path->slots[0]);
+	extref = (struct btrfs_inode_extref *)ptr;
+	*ret_extref = extref;
+	if (found_off)
+		*found_off = key.offset;
 
-	return ret;
+	return 0;
 }
 
 /*
-- 
2.31.1

