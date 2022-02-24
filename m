Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C282C4C2BBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 13:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiBXM3c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 07:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbiBXM3Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 07:29:24 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA08B26836C
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 04:28:47 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4F27212B9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645705726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HeOppck5l0IV5Ij+JFDRe5f+tReMihAq4XoFcZqbXv8=;
        b=pHx295sx2VV5xWty8QTkXmsW0oro896gdKpDTS+lv+QiKQeHT42/oDqrlP+Wtq2engO3TZ
        rXrkMPvH//A84ErFiolVOcBfNSp49p7SORuGe+PyentNEdTiVy5fKzHBhXXT0x6VdGr/+L
        azaUnYRqhSvaTU9UOqVh6tiguANglB8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAABC13AD9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2PtaK/15F2LhAgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: remove unused parameter for btrfs_add_inode_defrag()
Date:   Thu, 24 Feb 2022 20:28:35 +0800
Message-Id: <61861f9dbd64f31796a22a1de617600a869fdf09.1645705266.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645705266.git.wqu@suse.com>
References: <cover.1645705266.git.wqu@suse.com>
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

Since commit 543eabd5e192 ("Btrfs: don't auto defrag a file when doing
directIO"), there is no more caller passing a transaction handler to
btrfs_add_inode_defrag().

So the @trans parameter of btrfs_add_inode_defrag() is unnecessary and
we can just remove it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h | 3 +--
 fs/btrfs/file.c  | 8 ++------
 fs/btrfs/inode.c | 2 +-
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 5e02bf13fd1b..c72790c3bd41 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3345,8 +3345,7 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
 void __cold btrfs_auto_defrag_exit(void);
-int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
-			   struct btrfs_inode *inode, u32 extent_thresh);
+int btrfs_add_inode_defrag(struct btrfs_inode *inode, u32 extent_thresh);
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9f455c96c974..7d096c3f9127 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -136,8 +136,7 @@ static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
  * insert a defrag record for this inode if auto defrag is
  * enabled
  */
-int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
-			   struct btrfs_inode *inode, u32 extent_thresh)
+int btrfs_add_inode_defrag(struct btrfs_inode *inode, u32 extent_thresh)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -151,10 +150,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 	if (test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags))
 		return 0;
 
-	if (trans)
-		transid = trans->transid;
-	else
-		transid = inode->root->last_trans;
+	transid = inode->root->last_trans;
 
 	defrag = kmem_cache_zalloc(btrfs_inode_defrag_cachep, GFP_NOFS);
 	if (!defrag)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b2b26d786fde..24125d5860be 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -560,7 +560,7 @@ static inline void inode_should_defrag(struct btrfs_inode *inode,
 	/* If this is a small write inside eof, kick off a defrag */
 	if (num_bytes < small_write &&
 	    (start > 0 || end + 1 < inode->disk_i_size))
-		btrfs_add_inode_defrag(NULL, inode, small_write);
+		btrfs_add_inode_defrag(inode, small_write);
 }
 
 /*
-- 
2.35.1

