Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F64AEE4A
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 10:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiBIJll (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 04:41:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbiBIJeU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 04:34:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA11E05B1E6
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 01:34:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2FE221F39A
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644398615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJ6ACL/KIpo8ArqNybW2v8pHCm9PZPgGRsN2AYIm99c=;
        b=D/bQusPgvkDY8Xofxqp8mHlXs04Ken33nrv8wnxKYkVHskULvPkt84bTAH1W2Hmpdb15sq
        46iHbsVb8y67gb3Hi+tKx4nHHYj/Fng4BJf2QxpPPbo/EJPGTNgkcCqIhcntZQSHAOhTLn
        n8A+pO+y+06w1XWECOf023ZhsvI6rdk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84B5613522
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WKfEExaIA2I7QAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Feb 2022 09:23:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/3] btrfs: introduce IO_TREE_AUTODEFRAG owner type
Date:   Wed,  9 Feb 2022 17:23:13 +0800
Message-Id: <128e9e0b4c18d95f1f973e57b9ddb53428a6e95f.1644398069.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644398069.git.wqu@suse.com>
References: <cover.1644398069.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will add an extent_io_tree into inode_defrag, and adds a new
owner type, IO_TREE_AUTODEFRAG.

This patch only adds such member, no yet utilize it.

This provides the basis for later accurate and partial file scan for
autodefrag.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-io-tree.h |  1 +
 fs/btrfs/file.c           | 17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 04083ee5ae6e..7bf2e2e810a4 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -64,6 +64,7 @@ enum {
 	IO_TREE_LOG_CSUM_RANGE,
 	IO_TREE_SELFTEST,
 	IO_TREE_DEVICE_ALLOC_STATE,
+	IO_TREE_AUTODEFRAG,
 };
 
 struct extent_io_tree {
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5c012db0a5cb..2d49336b0321 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -32,6 +32,10 @@
 #include "subpage.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
+
+/* Reuse DIRTY flag for autodefrag */
+#define EXTENT_FLAG_AUTODEFRAG	EXTENT_FLAG_DIRTY
+
 /*
  * when auto defrag is enabled we
  * queue up these defrag structs to remember which
@@ -53,6 +57,9 @@ struct inode_defrag {
 	/* last offset we were able to defrag */
 	u64 last_offset;
 
+	/* Target ranges for autodefrag */
+	struct extent_io_tree targets;
+
 	/* if we've wrapped around back to zero once already */
 	int cycled;
 };
@@ -153,6 +160,7 @@ int btrfs_add_inode_defrag(struct btrfs_inode *inode)
 	defrag->ino = btrfs_ino(inode);
 	defrag->transid = inode->root->last_trans;
 	defrag->root = root->root_key.objectid;
+	extent_io_tree_init(fs_info, &defrag->targets, IO_TREE_AUTODEFRAG, NULL);
 
 	spin_lock(&fs_info->defrag_inodes_lock);
 	if (!test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags)) {
@@ -162,9 +170,12 @@ int btrfs_add_inode_defrag(struct btrfs_inode *inode)
 		 * IN_DEFRAG flag. At the case, we may find the existed defrag.
 		 */
 		ret = __btrfs_add_inode_defrag(inode, defrag);
-		if (ret)
+		if (ret) {
+			extent_io_tree_release(&defrag->targets);
 			kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
+		}
 	} else {
+		extent_io_tree_release(&defrag->targets);
 		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 	}
 	spin_unlock(&fs_info->defrag_inodes_lock);
@@ -196,6 +207,7 @@ static void btrfs_requeue_inode_defrag(struct btrfs_inode *inode,
 		goto out;
 	return;
 out:
+	extent_io_tree_release(&defrag->targets);
 	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 }
 
@@ -254,6 +266,7 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
 	while (node) {
 		rb_erase(node, &fs_info->defrag_inodes);
 		defrag = rb_entry(node, struct inode_defrag, rb_node);
+		extent_io_tree_release(&defrag->targets);
 		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 
 		cond_resched_lock(&fs_info->defrag_inodes_lock);
@@ -315,12 +328,14 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		defrag->cycled = 1;
 		btrfs_requeue_inode_defrag(BTRFS_I(inode), defrag);
 	} else {
+		extent_io_tree_release(&defrag->targets);
 		kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 	}
 
 	iput(inode);
 	return 0;
 cleanup:
+	extent_io_tree_release(&defrag->targets);
 	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 	return ret;
 }
-- 
2.35.0

