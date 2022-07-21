Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84057CC98
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 15:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiGUNub (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 09:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiGUNu0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 09:50:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B48BC97
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 06:50:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 25C803412A;
        Thu, 21 Jul 2022 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658411411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npPK0/AvXiNC6l3OGlILHinaKAJBg6kMrjnHHzGAYBk=;
        b=ePJxkQMaRsFtkPs3m9mgUyDPftcL3zA+zTGiaiWdi7pPy3DkB15usjg5pZwglFR7XeWcY7
        h1vA6FHB6CPPr37paQIWekonrRvpZKqaWf+z5T6CGPEJcUjQXuwvoaDnacFjoyZdPEfSFk
        Ju/9dJzu9H7lLsbz+jjt7W3CQleP84g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8B4913A1B;
        Thu, 21 Jul 2022 13:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oFcnNpJZ2WIPMgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Jul 2022 13:50:10 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/3] btrfs: use btrfs_find_inode in find_next_inode
Date:   Thu, 21 Jul 2022 16:50:06 +0300
Message-Id: <20220721135006.3345302-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721135006.3345302-1-nborisov@suse.com>
References: <20220721135006.3345302-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Start using btrfs_find_inode in find_next_inode, now that the common
logic has been encapsulated in the former function. This simplifies the
body of find_next_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/relocation.c | 54 +++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a6dc827e75af..fdb99e2ce949 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -951,52 +951,36 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
  */
 static struct inode *find_next_inode(struct btrfs_root *root, u64 objectid)
 {
-	struct rb_node *node;
-	struct rb_node *prev;
-	struct btrfs_inode *entry;
-	struct inode *inode;
+	struct rb_node *node = NULL;
+	struct inode *inode = NULL;
 
 	spin_lock(&root->inode_lock);
-again:
-	node = root->inode_tree.rb_node;
-	prev = NULL;
-	while (node) {
-		prev = node;
-		entry = rb_entry(node, struct btrfs_inode, rb_node);
 
-		if (objectid < btrfs_ino(entry))
-			node = node->rb_left;
-		else if (objectid > btrfs_ino(entry))
-			node = node->rb_right;
-		else
-			break;
-	}
-	if (!node) {
-		while (prev) {
-			entry = rb_entry(prev, struct btrfs_inode, rb_node);
-			if (objectid <= btrfs_ino(entry)) {
-				node = prev;
+	do {
+		struct btrfs_inode *entry;
+
+		if (!node) {
+			node = btrfs_find_inode(root, objectid);
+			if (!node)
 				break;
-			}
-			prev = rb_next(prev);
 		}
-	}
-	while (node) {
+
 		entry = rb_entry(node, struct btrfs_inode, rb_node);
+		objectid = btrfs_ino(entry) + 1;
 		inode = igrab(&entry->vfs_inode);
-		if (inode) {
-			spin_unlock(&root->inode_lock);
-			return inode;
-		}
+		if (inode)
+			break;
 
-		objectid = btrfs_ino(entry) + 1;
-		if (cond_resched_lock(&root->inode_lock))
-			goto again;
+		if (cond_resched_lock(&root->inode_lock)) {
+			node = NULL;
+			continue;
+		}
 
 		node = rb_next(node);
-	}
+	} while(node);
+
 	spin_unlock(&root->inode_lock);
-	return NULL;
+	return inode;
 }
 
 /*
-- 
2.25.1

