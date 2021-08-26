Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBC13F8C6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbhHZQoA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 12:44:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38100 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243135AbhHZQnt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 12:43:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BFAF31FE95;
        Thu, 26 Aug 2021 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629996180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOpOaHwibazhuWAgBwQn2kWcDPEOrE8UJJ0Xd2oPoaE=;
        b=IQmm2R3lEgzEOMBRhPCOv2Nx1sZ2tVSIJk3pIwacEVq3gKAGLUVhxFMajzYI3umD6zZMmO
        Q3Tqrh7kApTobkScwT4jEpzohB0oMADP0EJ8/Wr6CVB36gdxE2+0kodPAZRF64Oq5pF6t0
        JVBEoocYs5DoG3H0kEvxvq7IaA50hNM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3C2713B20;
        Thu, 26 Aug 2021 16:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EDnYGpPEJ2EVIQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Thu, 26 Aug 2021 16:42:59 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 8/8] btrfs: xattr: Use btrfs_for_each_slot macro in btrfs_listxattr
Date:   Thu, 26 Aug 2021 13:40:54 -0300
Message-Id: <20210826164054.14993-9-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826164054.14993-1-mpdesouza@suse.com>
References: <20210826164054.14993-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function can be simplified by using the iterator like macro.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/xattr.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 8a4514283a4b..f85febba1891 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -274,10 +274,12 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
 	struct btrfs_key key;
+	struct btrfs_key found_key;
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_path *path;
 	int ret = 0;
+	int iter_ret = 0;
 	size_t total_size = 0, size_left = size;
 
 	/*
@@ -295,44 +297,22 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	path->reada = READA_FORWARD;
 
 	/* search for our xattrs */
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto err;
-
-	while (1) {
+	btrfs_for_each_slot(root, &key, &found_key, path, iter_ret) {
 		struct extent_buffer *leaf;
 		int slot;
 		struct btrfs_dir_item *di;
-		struct btrfs_key found_key;
 		u32 item_size;
 		u32 cur;
 
 		leaf = path->nodes[0];
 		slot = path->slots[0];
 
-		/* this is where we start walking through the path */
-		if (slot >= btrfs_header_nritems(leaf)) {
-			/*
-			 * if we've reached the last slot in this leaf we need
-			 * to go to the next leaf and reset everything
-			 */
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto err;
-			else if (ret > 0)
-				break;
-			continue;
-		}
-
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
-
 		/* check to make sure this item is what we want */
-		if (found_key.objectid != key.objectid)
-			break;
-		if (found_key.type > BTRFS_XATTR_ITEM_KEY)
+		if (found_key.objectid != key.objectid ||
+		    found_key.type > BTRFS_XATTR_ITEM_KEY)
 			break;
 		if (found_key.type < BTRFS_XATTR_ITEM_KEY)
-			goto next_item;
+			continue;
 
 		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
 		item_size = btrfs_item_size_nr(leaf, slot);
@@ -365,9 +345,13 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			cur += this_len;
 			di = (struct btrfs_dir_item *)((char *)di + this_len);
 		}
-next_item:
-		path->slots[0]++;
 	}
+
+	if (iter_ret < 0) {
+		ret = iter_ret;
+		goto err;
+	}
+
 	ret = total_size;
 
 err:
-- 
2.31.1

