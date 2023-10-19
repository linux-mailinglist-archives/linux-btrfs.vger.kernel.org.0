Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC37D04CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 00:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbjJSWai (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 18:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjJSWaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 18:30:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B9812A
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 15:30:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 327B81FD84
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697754630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x7T2wvuokN/Au2SbKnOsbU6BcRYGCeICPG0eSDq9tnM=;
        b=diyu5vwZ+MsuKq/MGDKgQ+91LKW80GDrR6NVtxyhVgZ+87CA4GoOj1KpdNq9nrfmcTMA60
        l4kpxXZIaVj4G+gztO9hie0BR1rzcl3rttqqq/p9MqeRSaqjpuI0n5FHLxwN7kfUH1V8Jj
        aXHIRQL3SsI/K+nc0Q0BcTZpfXhySbk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 641871357F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4KXLCAWuMWXzWgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/9] btrfs-progs: remove add_backref parameter from btrfs_add_link()
Date:   Fri, 20 Oct 2023 09:00:01 +1030
Message-ID: <5f466b0d24f29262f9b47394af4b07de080d96db.1697754500.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697754500.git.wqu@suse.com>
References: <cover.1697754500.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_add_link() has a parameter @add_backref, to indicate
if the operation should add an INODE_REF for the child inode.

However all call sites are passing 1 for @add_backref, and in fact if
intentionally passing 0 for @add_backref for most cases, it would only
lead to missing INODE_REF and cause inconsistency.

And for call sites that want to ignore existing INODE_REF, they would
have already pass 1 for @ignore_existed.

So we can safely remmove the @add_backref parameter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          |  2 +-
 check/mode-common.c   |  4 ++--
 check/mode-lowmem.c   |  2 +-
 convert/main.c        |  2 +-
 kernel-shared/ctree.h |  2 +-
 kernel-shared/inode.c | 52 +++++++++++++++++++++----------------------
 6 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/check/main.c b/check/main.c
index 8dfb6ba2a8e8..b53ce9327fb4 100644
--- a/check/main.c
+++ b/check/main.c
@@ -2456,7 +2456,7 @@ static int reset_nlink(struct btrfs_trans_handle *trans,
 	list_for_each_entry(backref, &rec->backrefs, list) {
 		ret = btrfs_add_link(trans, root, rec->ino, backref->dir,
 				     backref->name, backref->namelen,
-				     backref->filetype, &backref->index, 1, 0);
+				     backref->filetype, &backref->index, 0);
 		if (ret < 0)
 			goto out;
 	}
diff --git a/check/mode-common.c b/check/mode-common.c
index 34e5267bfd8c..647b65cb3f03 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -464,7 +464,7 @@ int link_inode_to_lostfound(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 	ret = btrfs_add_link(trans, root, ino, lost_found_ino,
-			     namebuf, name_len, filetype, NULL, 1, 0);
+			     namebuf, name_len, filetype, NULL, 0);
 	/*
 	 * Add ".INO" suffix several times to handle case where
 	 * "FILENAME.INO" is already taken by another file.
@@ -481,7 +481,7 @@ int link_inode_to_lostfound(struct btrfs_trans_handle *trans,
 			 ".%llu", ino);
 		name_len += count_digits(ino) + 1;
 		ret = btrfs_add_link(trans, root, ino, lost_found_ino, namebuf,
-				     name_len, filetype, NULL, 1, 0);
+				     name_len, filetype, NULL, 0);
 	}
 	if (ret < 0) {
 		errno = -ret;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index dd05fa47384f..66a9c84415a8 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -1042,7 +1042,7 @@ static int repair_ternary_lowmem(struct btrfs_root *root, u64 dir_ino, u64 ino,
 		if (ret)
 			goto out;
 		ret = btrfs_add_link(trans, root, ino, dir_ino, name, name_len,
-			       filetype, &index, 1, 1);
+			       filetype, &index, 1);
 		goto out;
 	}
 out:
diff --git a/convert/main.c b/convert/main.c
index c9e50c036f92..16c517422259 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -841,7 +841,7 @@ static int create_image(struct btrfs_root *root,
 		goto out;
 	}
 	ret = btrfs_add_link(trans, root, ino, BTRFS_FIRST_FREE_OBJECTID, name,
-			     strlen(name), BTRFS_FT_REG_FILE, NULL, 1, 0);
+			     strlen(name), BTRFS_FT_REG_FILE, NULL, 0);
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to link ino %llu to '/%s' in root %llu: %m",
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 2df8166970be..03fd25368181 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1227,7 +1227,7 @@ int btrfs_change_inode_flags(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 ino, u64 flags);
 int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   u64 ino, u64 parent_ino, char *name, int namelen,
-		   u8 type, u64 *index, int add_backref, int ignore_existed);
+		   u8 type, u64 *index, int ignore_existed);
 int btrfs_unlink(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		 u64 ino, u64 parent_ino, u64 index, const char *name,
 		 int namelen, int add_orphan);
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 1893e48001af..ba8c8ad02a78 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -178,7 +178,7 @@ out:
  */
 int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		   u64 ino, u64 parent_ino, char *name, int namelen,
-		   u8 type, u64 *index, int add_backref, int ignore_existed)
+		   u8 type, u64 *index, int ignore_existed)
 {
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -205,33 +205,31 @@ int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		goto out;
 
 	/* Add inode ref */
-	if (add_backref) {
-		ret = btrfs_insert_inode_ref(trans, root, name, namelen,
-					     ino, parent_ino, ret_index);
-		if (ret < 0 && !(ignore_existed && ret == -EEXIST))
-			goto out;
+	ret = btrfs_insert_inode_ref(trans, root, name, namelen,
+				     ino, parent_ino, ret_index);
+	if (ret < 0 && !(ignore_existed && ret == -EEXIST))
+		goto out;
 
-		/* do not update nlinks if existed */
-		if (!ret) {
-			/* Update nlinks for the inode */
-			key.objectid = ino;
-			key.type = BTRFS_INODE_ITEM_KEY;
-			key.offset = 0;
-			ret = btrfs_search_slot(trans, root, &key, path, 1, 1);
-			if (ret) {
-				if (ret > 0)
-					ret = -ENOENT;
-				goto out;
-			}
-			inode_item = btrfs_item_ptr(path->nodes[0],
-				    path->slots[0], struct btrfs_inode_item);
-			nlink = btrfs_inode_nlink(path->nodes[0], inode_item);
-			nlink++;
-			btrfs_set_inode_nlink(path->nodes[0], inode_item,
-					      nlink);
-			btrfs_mark_buffer_dirty(path->nodes[0]);
-			btrfs_release_path(path);
+	/* do not update nlinks if existed */
+	if (!ret) {
+		/* Update nlinks for the inode */
+		key.objectid = ino;
+		key.type = BTRFS_INODE_ITEM_KEY;
+		key.offset = 0;
+		ret = btrfs_search_slot(trans, root, &key, path, 1, 1);
+		if (ret) {
+			if (ret > 0)
+				ret = -ENOENT;
+			goto out;
 		}
+		inode_item = btrfs_item_ptr(path->nodes[0],
+			    path->slots[0], struct btrfs_inode_item);
+		nlink = btrfs_inode_nlink(path->nodes[0], inode_item);
+		nlink++;
+		btrfs_set_inode_nlink(path->nodes[0], inode_item,
+				      nlink);
+		btrfs_mark_buffer_dirty(path->nodes[0]);
+		btrfs_release_path(path);
 	}
 
 	/* Add dir_item and dir_index */
@@ -582,7 +580,7 @@ int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	if (ret)
 		goto out;
 	ret = btrfs_add_link(trans, root, ret_ino, parent_ino, name, namelen,
-			     BTRFS_FT_DIR, NULL, 1, 0);
+			     BTRFS_FT_DIR, NULL, 0);
 	if (ret)
 		goto out;
 out:
-- 
2.42.0

