Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C913A7D04D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346648AbjJSWal (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 18:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235560AbjJSWaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 18:30:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF0C130
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 15:30:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7703D21A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697754631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+Q9nezLpsg+URhe1ssECB72DOay3J8MQGWKq3d5KO0=;
        b=oY6BqRee80Z1YrBUe+1njLdvVY4VKsL8jCnTkmj51K6VO28DbO6yPS8VtsEkTdub6+PfPC
        1VmOUM4NfzpRqq7l5bJOOOym/52IpjgNE4dAWg8LcY74KEsWM9t/YYcp2QGFTJ9qWWeP0N
        +ILVB8EGOB1E+22YPoqtW+Rnh/zKrCA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A99961357F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0KouGgauMWXzWgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/9] btrfs-progs: remove filetype parameter of btrfs_add_link()
Date:   Fri, 20 Oct 2023 09:00:02 +1030
Message-ID: <c3b626c5960905ae1d4dbc1e8e9053220d2cdea6.1697754500.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697754500.git.wqu@suse.com>
References: <cover.1697754500.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
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
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_add_link() utilized @filetype parameter to insert the
DIR_ITEM/DIR_INDEX.

However for all call sites of btrfs_add_link() we already have the
proper inode number of the child, and can grab the imode of that inode,
then convert it to filetype.

Thus no need to grab the @filetype parameter.

This is still true for repair code, where if we hit a inode without its
INODE_ITEM, the repair is always done by inserting a new INODE_ITEM
first, then do btrfs_add_link(), thus we should still be able to grab
the imode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          |  2 +-
 check/mode-common.c   |  4 ++--
 check/mode-lowmem.c   | 18 ++++++++----------
 convert/main.c        |  2 +-
 kernel-shared/ctree.h |  2 +-
 kernel-shared/inode.c | 23 ++++++++++++++++++++---
 6 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/check/main.c b/check/main.c
index b53ce9327fb4..4beeb0adae76 100644
--- a/check/main.c
+++ b/check/main.c
@@ -2456,7 +2456,7 @@ static int reset_nlink(struct btrfs_trans_handle *trans,
 	list_for_each_entry(backref, &rec->backrefs, list) {
 		ret = btrfs_add_link(trans, root, rec->ino, backref->dir,
 				     backref->name, backref->namelen,
-				     backref->filetype, &backref->index, 0);
+				     &backref->index, 0);
 		if (ret < 0)
 			goto out;
 	}
diff --git a/check/mode-common.c b/check/mode-common.c
index 647b65cb3f03..1f42743c390a 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -464,7 +464,7 @@ int link_inode_to_lostfound(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 	ret = btrfs_add_link(trans, root, ino, lost_found_ino,
-			     namebuf, name_len, filetype, NULL, 0);
+			     namebuf, name_len, NULL, 0);
 	/*
 	 * Add ".INO" suffix several times to handle case where
 	 * "FILENAME.INO" is already taken by another file.
@@ -481,7 +481,7 @@ int link_inode_to_lostfound(struct btrfs_trans_handle *trans,
 			 ".%llu", ino);
 		name_len += count_digits(ino) + 1;
 		ret = btrfs_add_link(trans, root, ino, lost_found_ino, namebuf,
-				     name_len, filetype, NULL, 0);
+				     name_len, NULL, 0);
 	}
 	if (ret < 0) {
 		errno = -ret;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 66a9c84415a8..275f6d16ebc7 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -1007,8 +1007,7 @@ out:
  * returns not 0 means on error;
  */
 static int repair_ternary_lowmem(struct btrfs_root *root, u64 dir_ino, u64 ino,
-			  u64 index, char *name, int name_len, u8 filetype,
-			  int err)
+			  u64 index, char *name, int name_len, int err)
 {
 	struct btrfs_trans_handle *trans;
 	int stage = 0;
@@ -1042,19 +1041,19 @@ static int repair_ternary_lowmem(struct btrfs_root *root, u64 dir_ino, u64 ino,
 		if (ret)
 			goto out;
 		ret = btrfs_add_link(trans, root, ino, dir_ino, name, name_len,
-			       filetype, &index, 1);
+				     &index, 1);
 		goto out;
 	}
 out:
 	btrfs_commit_transaction(trans, root);
 
 	if (ret)
-		error("fail to repair inode %llu name %s filetype %u",
-		      ino, name, filetype);
+		error("fail to repair inode %llu name %s",
+		      ino, name);
 	else
-		printf("%s ref/dir_item of inode %llu name %s filetype %u\n",
+		printf("%s ref/dir_item of inode %llu name %s\n",
 		       stage == 2 ? "Delete" : "Add",
-		       ino, name, filetype);
+		       ino, name);
 
 	return ret;
 }
@@ -1212,8 +1211,7 @@ end:
 	if (tmp_err && opt_check_repair) {
 		ret = repair_ternary_lowmem(root, ref_key->offset,
 					    ref_key->objectid, index, namebuf,
-					    name_len, btrfs_inode_type(mode),
-					    tmp_err);
+					    name_len, tmp_err);
 		if (!ret) {
 			need_research = 1;
 			goto begin;
@@ -1619,7 +1617,7 @@ static int repair_dir_item(struct btrfs_root *root, struct btrfs_key *di_key,
 
 	if (err & ~(INODE_ITEM_MISMATCH | INODE_ITEM_MISSING)) {
 		ret = repair_ternary_lowmem(root, dirid, ino, index, namebuf,
-					    name_len, filetype, err);
+					    name_len, err);
 		if (!ret) {
 			err &= ~(DIR_INDEX_MISMATCH | DIR_INDEX_MISSING);
 			err &= ~(DIR_ITEM_MISMATCH | DIR_ITEM_MISSING);
diff --git a/convert/main.c b/convert/main.c
index 16c517422259..c1047bacbe01 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -841,7 +841,7 @@ static int create_image(struct btrfs_root *root,
 		goto out;
 	}
 	ret = btrfs_add_link(trans, root, ino, BTRFS_FIRST_FREE_OBJECTID, name,
-			     strlen(name), BTRFS_FT_REG_FILE, NULL, 0);
+			     strlen(name), NULL, 0);
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to link ino %llu to '/%s' in root %llu: %m",
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 03fd25368181..501feaa08a0a 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1227,7 +1227,7 @@ int btrfs_change_inode_flags(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 ino, u64 flags);
 int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   u64 ino, u64 parent_ino, char *name, int namelen,
-		   u8 type, u64 *index, int ignore_existed);
+		   u64 *index, int ignore_existed);
 int btrfs_unlink(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		 u64 ino, u64 parent_ino, u64 index, const char *name,
 		 int namelen, int add_orphan);
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index ba8c8ad02a78..43ab685a45e1 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -178,11 +178,12 @@ out:
  */
 int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   u64 ino, u64 parent_ino, char *name, int namelen,
-		   u8 type, u64 *index, int ignore_existed)
+		   u64 *index, int ignore_existed)
 {
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_inode_item *inode_item;
+	u32 imode;
 	u32 nlink;
 	u64 inode_size;
 	u64 ret_index = 0;
@@ -192,6 +193,22 @@ int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	if (!path)
 		return -ENOMEM;
 
+	key.objectid = ino;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret > 0) {
+		ret = -ENOENT;
+		/* fallthrough */
+	}
+	if (ret < 0)
+		goto out;
+
+	inode_item = btrfs_item_ptr(path->nodes[0], path->slots[0],
+				    struct btrfs_inode_item);
+	imode = btrfs_inode_mode(path->nodes[0], inode_item);
+	btrfs_release_path(path);
+
 	if (index && *index) {
 		ret_index = *index;
 	} else {
@@ -237,7 +254,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 	ret = btrfs_insert_dir_item(trans, root, name, namelen, parent_ino,
-				    &key, type, ret_index);
+				    &key, fs_umode_to_ftype(imode), ret_index);
 	if (ret < 0)
 		goto out;
 
@@ -580,7 +597,7 @@ int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	if (ret)
 		goto out;
 	ret = btrfs_add_link(trans, root, ret_ino, parent_ino, name, namelen,
-			     BTRFS_FT_DIR, NULL, 0);
+			     NULL, 0);
 	if (ret)
 		goto out;
 out:
-- 
2.42.0

