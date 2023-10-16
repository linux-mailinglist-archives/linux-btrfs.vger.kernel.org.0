Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54D07C9E46
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 06:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjJPEjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 00:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjJPEjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 00:39:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D476E1
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Oct 2023 21:39:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4AA721C1A
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697431152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9yhJmXN4GFhMDS3CEDONz5SLQFv3u5n9PEq/eRXFgLE=;
        b=rsdDB9CKOopWDZTwSIig5c0VOVpIhip4LpX1VfDO6yoIUid7Dst39uYsO60kxnuo+39dig
        GECvHrubGOc9tJX/f7dLViVsImCuYxk82qVa80VBghl6BAf8A96q7QJxhH8wLnz/bUpb1l
        6GJ8hT5Twqk3bHIngdrYuZfsxuRQ9F0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D2CF138EF
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mL5HL2++LGUaFgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:11 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs-progs: enhance btrfs_mkdir() function
Date:   Mon, 16 Oct 2023 15:08:47 +1030
Message-ID: <7ebf559be3db3d25c6a1f29c8a7db8cded71094a.1697430866.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697430866.git.wqu@suse.com>
References: <cover.1697430866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[30.44%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_mkdir() is currently only utilized by btrfs check, to
create the lost+found directory.

However we're going to add extra callers for this function, to create
directories (and subvolumes) for the incoming "mkfs.btrfs --subvolume"
option.

Thus here we want extra checks for the @parent_ino:

- Make sure the parent inode exists
- Make sure the parent inode is indeed a directory

And since we're here, also convert the @path to a on-stack one to
prevent memory leakage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/inode.c | 53 +++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 3d420787c8f9..50bb460acc79 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -526,18 +526,41 @@ int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		char *name, int namelen, u64 parent_ino, u64 *ino, int mode)
 {
 	struct btrfs_dir_item *dir_item;
-	struct btrfs_path *path;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	struct btrfs_inode_item *iitem;
 	u64 ret_ino = 0;
 	int ret = 0;
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
 	if (ino && *ino)
 		ret_ino = *ino;
 
-	dir_item = btrfs_lookup_dir_item(NULL, root, path, parent_ino,
+	/* Make sure the parent inode exists and is a directory. */
+	key.objectid = parent_ino;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_lookup_inode(NULL, root, &path, &key, 0);
+	if (ret > 0) {
+		ret = -ENOENT;
+		/* Fallthrough */
+	}
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to lookup inode %llu in root %lld: %m",
+		      parent_ino, root->root_key.objectid);
+		goto out;
+	}
+	iitem = btrfs_item_ptr(path.nodes[0], path.slots[0], struct btrfs_inode_item);
+	if (!S_ISDIR(btrfs_inode_mode(path.nodes[0], iitem))) {
+		ret = -EUCLEAN;
+		errno = -ret;
+		error("inode %llu in root %lld is not a directory", parent_ino,
+		      root->root_key.objectid);
+		goto out;
+	}
+	btrfs_release_path(&path);
+
+	dir_item = btrfs_lookup_dir_item(NULL, root, &path, parent_ino,
 					 name, namelen, 0);
 	if (IS_ERR(dir_item)) {
 		ret = PTR_ERR(dir_item);
@@ -551,23 +574,19 @@ int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		 * Already have conflicting name, check if it is a dir.
 		 * Either way, no need to continue.
 		 */
-		btrfs_dir_item_key_to_cpu(path->nodes[0], dir_item, &found_key);
+		btrfs_dir_item_key_to_cpu(path.nodes[0], dir_item, &found_key);
 		ret_ino = found_key.objectid;
-		if (btrfs_dir_ftype(path->nodes[0], dir_item) != BTRFS_FT_DIR)
+		if (btrfs_dir_ftype(path.nodes[0], dir_item) != BTRFS_FT_DIR)
 			ret = -EEXIST;
 		goto out;
 	}
 
-	if (!ret_ino)
-		/*
-		 * This is *UNSAFE* if some leaf is corrupted,
-		 * only used as a fallback method. Caller should either
-		 * ensure the fs is OK or pass ino with unused inode number.
-		 */
+	if (!ret_ino) {
 		ret = btrfs_find_free_objectid(NULL, root, parent_ino,
 					       &ret_ino);
-	if (ret)
-		goto out;
+		if (ret)
+			goto out;
+	}
 	ret = btrfs_new_inode(trans, root, ret_ino, mode | S_IFDIR);
 	if (ret)
 		goto out;
@@ -576,7 +595,7 @@ int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	if (ret)
 		goto out;
 out:
-	btrfs_free_path(path);
+	btrfs_release_path(&path);
 	if (ret == 0 && ino)
 		*ino = ret_ino;
 	return ret;
-- 
2.42.0

