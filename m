Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD3657CCA7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiGUNue (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 09:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiGUNu1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 09:50:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E69BCBC
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 06:50:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 92E561F8F9;
        Thu, 21 Jul 2022 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658411410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfkbMJdt6xI4buRaRNDdPK/wQJt6Rmy5payxSexnvdA=;
        b=UgVna7sjpncsy/zOfXeBZNptQVeyaI8lzmGQXOx1it8kNj9xJVRy/hiHcMzVy6FG013ylD
        BI+mgXzZDZtxGCmvTpA9dK9kn/UTRf3Bcq1wrx5U1+u7AFZgQUCXaYgBQaMSRGVOoaUMTZ
        uQE+eBvjjQJeT4OC5LJjfF9B8tQBNv4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6267913A1B;
        Thu, 21 Jul 2022 13:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GLBeFZJZ2WIPMgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Jul 2022 13:50:10 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: introduce btrfs_find_inode
Date:   Thu, 21 Jul 2022 16:50:04 +0300
Message-Id: <20220721135006.3345302-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721135006.3345302-1-nborisov@suse.com>
References: <20220721135006.3345302-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function holds common code for searching the root's inode rb tree.
It will be used to reduce code duplication in future patches.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h |  1 +
 fs/btrfs/inode.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0ae7f6530da1..fc0a0ab01761 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3311,6 +3311,7 @@ int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 		       struct btrfs_inode *dir, struct btrfs_inode *inode,
 		       const char *name, int name_len);
+struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid);
 int btrfs_add_link(struct btrfs_trans_handle *trans,
 		   struct btrfs_inode *parent_inode, struct btrfs_inode *inode,
 		   const char *name, int name_len, int add_backref, u64 index);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5fc831a8eba1..c11169ba28b2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4587,6 +4587,50 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	return ret;
 }
 
+/**
+ * btrfs_find_inode - returns the rb_node pointing to the inode with an ino
+ * equal or larger than @objectid
+ *
+ * @root:      root which is going to be searched for an inode
+ * @objectid:  ino being searched for, if no exact match can be found the
+ *             function returns the first largest inode
+ *
+ * Returns the rb_node pointing to the specified inode or returns NULL if no
+ * match is found.
+ *
+ */
+struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid)
+{
+	struct rb_node *node = root->inode_tree.rb_node;
+	struct rb_node *prev = NULL;
+	struct btrfs_inode *entry;
+
+	lockdep_assert_held(&root->inode_lock);
+
+	while (node) {
+		prev = node;
+		entry = rb_entry(node, struct btrfs_inode, rb_node);
+
+		if (objectid < btrfs_ino(entry))
+			node = node->rb_left;
+		else if (objectid > btrfs_ino(entry))
+			node = node->rb_right;
+		else
+			break;
+	}
+
+	if (!node) {
+		while (prev) {
+			entry = rb_entry(prev, struct btrfs_inode, rb_node);
+			if (objectid <= btrfs_ino(entry))
+				return prev;
+			prev = rb_next(prev);
+		}
+	}
+
+	return node;
+}
+
 /* Delete all dentries for inodes belonging to the root */
 static void btrfs_prune_dentries(struct btrfs_root *root)
 {
-- 
2.25.1

