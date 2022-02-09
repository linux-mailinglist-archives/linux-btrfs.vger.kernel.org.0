Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6524AEE3D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 10:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbiBIJlf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 04:41:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239659AbiBIJeU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 04:34:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F05DE05BA5B
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 01:34:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 223AB1F391
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644398614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zy9IUpJhJjF3HffcDjFVfOneLxYUmO5wGlTL2SjFEzE=;
        b=Y45xR+VvjuUCJsEmkghskuugt1prnPoQWlIEjua24rAJkgKCNvR2V82w/iJrjUnXdjXnMA
        Ak084dYMgtjkuYv/hHJOm7D1uNuHsblnrLGxUhMjJNUJZjqciRAH581uFfpsde+jBvE++l
        F+bXNLEr4duHKnGrmYdY6qdLDVaWCdU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7788913522
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 09:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4C2vEBWIA2I7QAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Feb 2022 09:23:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/3] btrfs: remove an unused parameter of btrfs_add_inode_defrag()
Date:   Wed,  9 Feb 2022 17:23:12 +0800
Message-Id: <cbaaa45620bc7a089554eb10ad7a2e6c67fc56ea.1644398069.git.wqu@suse.com>
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

Since commit 543eabd5e192 ("Btrfs: don't auto defrag a file when doing
directIO"), there is no more caller passing a transaction handler to
btrfs_add_inode_defrag().

So the @trans parameter of btrfs_add_inode_defrag() is unnecessary and
we can just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h |  3 +--
 fs/btrfs/file.c  | 11 ++---------
 fs/btrfs/inode.c |  2 +-
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ac222a9ce166..a5cf845cbe88 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3356,8 +3356,7 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
 void __cold btrfs_auto_defrag_exit(void);
-int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
-			   struct btrfs_inode *inode);
+int btrfs_add_inode_defrag(struct btrfs_inode *inode);
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f5de8ab9787e..5c012db0a5cb 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -133,13 +133,11 @@ static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
  * insert a defrag record for this inode if auto defrag is
  * enabled
  */
-int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
-			   struct btrfs_inode *inode)
+int btrfs_add_inode_defrag(struct btrfs_inode *inode)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct inode_defrag *defrag;
-	u64 transid;
 	int ret;
 
 	if (!__need_auto_defrag(fs_info))
@@ -148,17 +146,12 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
 		return 0;
 
-	if (trans)
-		transid = trans->transid;
-	else
-		transid = inode->root->last_trans;
-
 	defrag = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
 	if (!defrag)
 		return -ENOMEM;
 
 	defrag->ino = btrfs_ino(inode);
-	defrag->transid = transid;
+	defrag->transid = inode->root->last_trans;
 	defrag->root = root->root_key.objectid;
 
 	spin_lock(&fs_info->defrag_inodes_lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 94342ad74171..2049f3ea992d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -570,7 +570,7 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 	/* If this is a small write inside eof, kick off a defrag */
 	if (num_bytes < small_write &&
 	    (start > 0 || end + 1 < inode->disk_i_size))
-		btrfs_add_inode_defrag(NULL, inode);
+		btrfs_add_inode_defrag(inode);
 }
 
 /*
-- 
2.35.0

