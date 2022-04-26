Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C9850FA24
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Apr 2022 12:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236625AbiDZKWk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Apr 2022 06:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348653AbiDZKWV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Apr 2022 06:22:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEDF12612
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Apr 2022 02:51:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CFA451F388;
        Tue, 26 Apr 2022 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650966676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=RJPMHv1wOucwoYABDchsSD5U5IFtkzL8wA6ddjLfW0A=;
        b=VSlZqMB5UQ2KMLQPINUiDYCDZ+OOcd0Am981jQ12w045qCXFBUjwFtG9CF98I+GNMCleM5
        FOJkQEetYOlf+FtiveVFPg5jEQSCpCo1s+Ny4ePWeLGgANXKmr6ZRERRG9xmtlyeZm8ikN
        NQBu1TQb1aJA7kPTkzOG5iU70RLhBtE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A035E13223;
        Tue, 26 Apr 2022 09:51:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rgRcJZTAZ2KDQgAAMHmgww
        (envelope-from <gniebler@suse.com>); Tue, 26 Apr 2022 09:51:16 +0000
From:   Gabriel Niebler <gniebler@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Gabriel Niebler <gniebler@suse.com>
Subject: [PATCH v2] btrfs: Turn name_cache radix tree into XArray in send_ctx
Date:   Tue, 26 Apr 2022 11:51:01 +0200
Message-Id: <20220426095101.8516-1-gniebler@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

… and adjust all usages of this object to use the XArray API for the sake
of consistency.

XArray API provides array semantics, so it is notionally easier to use and
understand, and it also takes care of locking for us.

None of this makes a real difference in this particular patch, but it does
in other places where similar replacements are or have been made and we
want to be consistent in our usage of data structures in btrfs.

Signed-off-by: Gabriel Niebler <gniebler@suse.com>
---

Changes from v1:
 - Let commit message begin with "btrfs: "

---
 fs/btrfs/send.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7d1642937274..19e39cdae0bb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -10,7 +10,6 @@
 #include <linux/mount.h>
 #include <linux/xattr.h>
 #include <linux/posix_acl_xattr.h>
-#include <linux/radix-tree.h>
 #include <linux/vmalloc.h>
 #include <linux/string.h>
 #include <linux/compat.h>
@@ -128,7 +127,7 @@ struct send_ctx {
 	struct list_head new_refs;
 	struct list_head deleted_refs;
 
-	struct radix_tree_root name_cache;
+	struct xarray name_cache;
 	struct list_head name_cache_list;
 	int name_cache_size;
 
@@ -262,14 +261,14 @@ struct orphan_dir_info {
 struct name_cache_entry {
 	struct list_head list;
 	/*
-	 * radix_tree has only 32bit entries but we need to handle 64bit inums.
-	 * We use the lower 32bit of the 64bit inum to store it in the tree. If
-	 * more then one inum would fall into the same entry, we use radix_list
-	 * to store the additional entries. radix_list is also used to store
-	 * entries where two entries have the same inum but different
+	 * On 32bit kernels, XArray has only 32bit indices, but we need to
+	 * handle 64bit inums. We use the lower 32bit of the 64bit inum to store
+	 * it in the tree. If more than one inum would fall into the same entry,
+	 * we use inum_aliases to store the additional entries. inum_aliases is
+	 * also used to store entries with the same inum but different
 	 * generations.
 	 */
-	struct list_head radix_list;
+	struct list_head inum_aliases;
 	u64 ino;
 	u64 gen;
 	u64 parent_ino;
@@ -2019,9 +2018,9 @@ static int did_overwrite_first_ref(struct send_ctx *sctx, u64 ino, u64 gen)
 }
 
 /*
- * Insert a name cache entry. On 32bit kernels the radix tree index is 32bit,
+ * Insert a name cache entry. On 32bit kernels the XArray index is 32bit,
  * so we need to do some special handling in case we have clashes. This function
- * takes care of this with the help of name_cache_entry::radix_list.
+ * takes care of this with the help of name_cache_entry::inum_aliases.
  * In case of error, nce is kfreed.
  */
 static int name_cache_insert(struct send_ctx *sctx,
@@ -2030,8 +2029,7 @@ static int name_cache_insert(struct send_ctx *sctx,
 	int ret = 0;
 	struct list_head *nce_head;
 
-	nce_head = radix_tree_lookup(&sctx->name_cache,
-			(unsigned long)nce->ino);
+	nce_head = xa_load(&sctx->name_cache, (unsigned long)nce->ino);
 	if (!nce_head) {
 		nce_head = kmalloc(sizeof(*nce_head), GFP_KERNEL);
 		if (!nce_head) {
@@ -2040,14 +2038,15 @@ static int name_cache_insert(struct send_ctx *sctx,
 		}
 		INIT_LIST_HEAD(nce_head);
 
-		ret = radix_tree_insert(&sctx->name_cache, nce->ino, nce_head);
+		ret = xa_insert(&sctx->name_cache, nce->ino, nce_head,
+				GFP_KERNEL);
 		if (ret < 0) {
 			kfree(nce_head);
 			kfree(nce);
 			return ret;
 		}
 	}
-	list_add_tail(&nce->radix_list, nce_head);
+	list_add_tail(&nce->inum_aliases, nce_head);
 	list_add_tail(&nce->list, &sctx->name_cache_list);
 	sctx->name_cache_size++;
 
@@ -2059,15 +2058,14 @@ static void name_cache_delete(struct send_ctx *sctx,
 {
 	struct list_head *nce_head;
 
-	nce_head = radix_tree_lookup(&sctx->name_cache,
-			(unsigned long)nce->ino);
+	nce_head = xa_load(&sctx->name_cache, (unsigned long)nce->ino);
 	if (!nce_head) {
 		btrfs_err(sctx->send_root->fs_info,
 	      "name_cache_delete lookup failed ino %llu cache size %d, leaking memory",
 			nce->ino, sctx->name_cache_size);
 	}
 
-	list_del(&nce->radix_list);
+	list_del(&nce->inum_aliases);
 	list_del(&nce->list);
 	sctx->name_cache_size--;
 
@@ -2075,7 +2073,7 @@ static void name_cache_delete(struct send_ctx *sctx,
 	 * We may not get to the final release of nce_head if the lookup fails
 	 */
 	if (nce_head && list_empty(nce_head)) {
-		radix_tree_delete(&sctx->name_cache, (unsigned long)nce->ino);
+		xa_erase(&sctx->name_cache, (unsigned long)nce->ino);
 		kfree(nce_head);
 	}
 }
@@ -2086,11 +2084,11 @@ static struct name_cache_entry *name_cache_search(struct send_ctx *sctx,
 	struct list_head *nce_head;
 	struct name_cache_entry *cur;
 
-	nce_head = radix_tree_lookup(&sctx->name_cache, (unsigned long)ino);
+	nce_head = xa_load(&sctx->name_cache, (unsigned long)ino);
 	if (!nce_head)
 		return NULL;
 
-	list_for_each_entry(cur, nce_head, radix_list) {
+	list_for_each_entry(cur, nce_head, inum_aliases) {
 		if (cur->ino == ino && cur->gen == gen)
 			return cur;
 	}
@@ -7534,7 +7532,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
 	INIT_LIST_HEAD(&sctx->new_refs);
 	INIT_LIST_HEAD(&sctx->deleted_refs);
-	INIT_RADIX_TREE(&sctx->name_cache, GFP_KERNEL);
+	xa_init_flags(&sctx->name_cache, GFP_KERNEL);
 	INIT_LIST_HEAD(&sctx->name_cache_list);
 
 	sctx->flags = arg->flags;
-- 
2.35.3

