Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A384D3086
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 14:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiCINwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 08:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiCINwR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 08:52:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1B41637EE
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 05:51:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64A231F380;
        Wed,  9 Mar 2022 13:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646833877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=On7IDz/ZVVnhjGrGaMhtxZZxzhwKSns2i7e/ugFlPOc=;
        b=hrhdYnRFTMXWneCb/Vh3M1P68/jd+S54UfiNsIP16Z8xVnSCe7h2vsL/DXdUJnDptu9ea/
        pIRaMn9HIJJFfmeIilygaWff3GQTb2vq8nKtpbv9drL5Kz12OgQ2N2eV3iOqarL7sum9Ro
        XpQZnqZOGaCIEfmuLE4U5xa0csXOxYE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34F8D13E8A;
        Wed,  9 Mar 2022 13:51:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OJMaC9WwKGL1LQAAMHmgww
        (envelope-from <gniebler@suse.com>); Wed, 09 Mar 2022 13:51:17 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4 14/14] btrfs: Use btrfs_for_each_slot in btrfs_listxattr
Date:   Wed,  9 Mar 2022 14:50:51 +0100
Message-Id: <20220309135051.5738-15-gniebler@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309135051.5738-1-gniebler@suse.com>
References: <20220309135051.5738-1-gniebler@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function can be simplified by refactoring to use the new iterator macro.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---
 fs/btrfs/xattr.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 99abf41b89b9..b96ffd775b41 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -271,10 +271,12 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 
 ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
+	struct btrfs_key found_key;
 	struct btrfs_key key;
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	struct btrfs_path *path;
+	int iter_ret = 0;
 	int ret = 0;
 	size_t total_size = 0, size_left = size;
 
@@ -293,44 +295,23 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
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
 		if (found_key.objectid != key.objectid)
 			break;
 		if (found_key.type > BTRFS_XATTR_ITEM_KEY)
 			break;
 		if (found_key.type < BTRFS_XATTR_ITEM_KEY)
-			goto next_item;
+			continue;
 
 		di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
 		item_size = btrfs_item_size(leaf, slot);
@@ -350,8 +331,8 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 				goto next;
 
 			if (!buffer || (name_len + 1) > size_left) {
-				ret = -ERANGE;
-				goto err;
+			        iter_ret = -ERANGE;
+				break;
 			}
 
 			read_extent_buffer(leaf, buffer, name_ptr, name_len);
@@ -363,12 +344,13 @@ ssize_t btrfs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 			cur += this_len;
 			di = (struct btrfs_dir_item *)((char *)di + this_len);
 		}
-next_item:
-		path->slots[0]++;
 	}
-	ret = total_size;
 
-err:
+	if (iter_ret < 0)
+		ret = iter_ret;
+	else
+		ret = total_size;
+
 	btrfs_free_path(path);
 
 	return ret;
-- 
2.35.1

