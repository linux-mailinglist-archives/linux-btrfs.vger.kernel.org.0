Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1D43D6772
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 21:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhGZSim (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 14:38:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59306 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhGZSil (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 14:38:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D35131FD4C;
        Mon, 26 Jul 2021 19:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627327148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VDm8t/arnFDwuhck8YJWwJyzf5vjD9JpmNDkkgDyu7g=;
        b=WfQqCQMFtUAGSxiaSH19hh/hWTpSTM/2CK6ZRxZlerbMH5k6nyBDP+mfUc2hdEvTuaSH2o
        hDNtlc5qi1/xmrWhlysNv8IVkPfTDLUIx1X+dohW/pyoAeLgO+deEXshNr7uyhYBybnPoZ
        uYSWTIPjRyugjRiiYKjv/unG5m9eD7U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD85913B58;
        Mon, 26 Jul 2021 19:19:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MdVtIasK/2AmJAAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Mon, 26 Jul 2021 19:19:07 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: dir-item: Introduce btrfs_lookup_match_dir
Date:   Mon, 26 Jul 2021 16:19:09 -0300
Message-Id: <20210726191909.31910-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_search_slot is called in multiple places in dir-item.c to search
to a dir entry, and then calling btrfs_match_dir_name to return a
btrfs_dir_item struct.

In order to reduce the number of callers of btrfs_search_slot, create a
common function that check's if the dir key, and if found call
btrfs_match_dir_item_name.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/dir-item.c | 77 +++++++++++++++++++++++----------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 98b63ebed539..06ad692889cc 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -170,6 +170,25 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 	return 0;
 }
 
+static struct btrfs_dir_item *
+btrfs_lookup_match_dir(struct btrfs_trans_handle *trans,
+			struct btrfs_root *root, struct btrfs_path *path,
+			struct btrfs_key *key, const char *name,
+			int name_len, int mod)
+{
+	int ret;
+	int ins_len = mod < 0 ? -1 : 0;
+	int cow = mod != 0;
+
+	ret = btrfs_search_slot(trans, root, key, path, ins_len, cow);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	if (ret > 0)
+		return ERR_PTR(-ENOENT);
+
+	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
+}
+
 /*
  * lookup a directory item based on name.  'dir' is the objectid
  * we're searching in, and 'mod' tells us if you plan on deleting the
@@ -181,23 +200,18 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 					     const char *name, int name_len,
 					     int mod)
 {
-	int ret;
 	struct btrfs_key key;
-	int ins_len = mod < 0 ? -1 : 0;
-	int cow = mod != 0;
+	struct btrfs_dir_item *di;
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-
 	key.offset = btrfs_name_hash(name, name_len);
 
-	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
-	if (ret < 0)
-		return ERR_PTR(ret);
-	if (ret > 0)
+	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
 		return NULL;
 
-	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
+	return di;
 }
 
 int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
@@ -211,7 +225,6 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 	int slot;
 	struct btrfs_path *path;
 
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -220,20 +233,21 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 	key.type = BTRFS_DIR_ITEM_KEY;
 	key.offset = btrfs_name_hash(name, name_len);
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-
-	/* return back any errors */
-	if (ret < 0)
-		goto out;
+	di = btrfs_lookup_match_dir(NULL, root, path, &key, name, name_len, 0);
+	if (IS_ERR(di)) {
+		ret = PTR_ERR(di);
+		/* nothing found, we're safe */
+		if (ret == -ENOENT) {
+			ret = 0;
+			goto out;
+		}
 
-	/* nothing found, we're safe */
-	if (ret > 0) {
-		ret = 0;
-		goto out;
+		/* return back any errors */
+		if (ret < 0)
+			goto out;
 	}
 
 	/* we found an item, look for our name in the item */
-	di = btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
 	if (di) {
 		/* our exact name was found */
 		ret = -EEXIST;
@@ -274,21 +288,13 @@ btrfs_lookup_dir_index_item(struct btrfs_trans_handle *trans,
 			    u64 objectid, const char *name, int name_len,
 			    int mod)
 {
-	int ret;
 	struct btrfs_key key;
-	int ins_len = mod < 0 ? -1 : 0;
-	int cow = mod != 0;
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = objectid;
 
-	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
-	if (ret < 0)
-		return ERR_PTR(ret);
-	if (ret > 0)
-		return ERR_PTR(-ENOENT);
-	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
+	return btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
 }
 
 struct btrfs_dir_item *
@@ -345,21 +351,18 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
 					  const char *name, u16 name_len,
 					  int mod)
 {
-	int ret;
 	struct btrfs_key key;
-	int ins_len = mod < 0 ? -1 : 0;
-	int cow = mod != 0;
+	struct btrfs_dir_item *di;
 
 	key.objectid = dir;
 	key.type = BTRFS_XATTR_ITEM_KEY;
 	key.offset = btrfs_name_hash(name, name_len);
-	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
-	if (ret < 0)
-		return ERR_PTR(ret);
-	if (ret > 0)
+
+	di = btrfs_lookup_match_dir(trans, root, path, &key, name, name_len, mod);
+	if (IS_ERR(di) && PTR_ERR(di) == -ENOENT)
 		return NULL;
 
-	return btrfs_match_dir_item_name(root->fs_info, path, name, name_len);
+	return di;
 }
 
 /*
-- 
2.26.2

