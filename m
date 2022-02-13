Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41284B39FF
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Feb 2022 08:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiBMHnE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Feb 2022 02:43:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbiBMHnC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Feb 2022 02:43:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40123BC7
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Feb 2022 23:42:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2AD521F380
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 07:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644738176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G0Jisc/cgx296Xvz8tAfDDIaxg4DSywapo1sAC4iSfE=;
        b=T9LPqBFEz9h8aSbRgnxIzVOWUfuk27JIERBbX3UTZsoTVCf/XEay+W6F8KldEVTy/o0lAM
        G5uZCuiilKda10cHUEDNYI07vgNc4EgA2gUEo87ZZ035EY9lTRw0XsaziAcx+Zy5USaCW7
        VckWcZXZYJajg6e8sfDkq4v3di3aVC0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7894A1331A
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 07:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8O3UEH+2CGI+dAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Feb 2022 07:42:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: close the gap between inode_should_defrag() and autodefrag extent size threshold
Date:   Sun, 13 Feb 2022 15:42:33 +0800
Message-Id: <89590f880f22e04d07745866334d68e2a0a19684.1644737297.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644737297.git.wqu@suse.com>
References: <cover.1644737297.git.wqu@suse.com>
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

There is a big gap between inode_should_defrag() and autodefrag extent
size threshold.

For inode_should_defrag() it has a flexiable @small_write value. For
compressed extent is 16K, and for non-compressed extent it's 64K.

However for autodefrag extent size threshold, it's always fixed to the
default value (256K).

This means, the following write sequence will trigger autodefrag to
defrag ranges which didn't cause autodefrag:

 pwrite 0 8k
 sync
 pwrite 8k 128K
 sync

The later 128K write will also be considered as a defrag target (if
other conditions are met). While only that 8K write is really
triggering autodefrag.

Such behavior can cause extra IO for autodefrag.

This patch will close the gap, by copying the @small_write value into
inode_defrag, so that later autodefrag can use the same @small_write
value which triggered autodefrag.

With the existing transid value, this allows autodefrag really to scan
the ranges which triggered autodefrag.

Although this behavior change is mostly reducing the extent_thresh value
for autodefrag, I believe in the future we should allow users to specify
the autodefrag extent threshold through mount options, but that's an
other problem to consider in the future.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h |  2 +-
 fs/btrfs/file.c  | 14 +++++++++++++-
 fs/btrfs/inode.c |  4 ++--
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a5cf845cbe88..16956cca358e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3356,7 +3356,7 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 /* file.c */
 int __init btrfs_auto_defrag_init(void);
 void __cold btrfs_auto_defrag_exit(void);
-int btrfs_add_inode_defrag(struct btrfs_inode *inode);
+int btrfs_add_inode_defrag(struct btrfs_inode *inode, u32 extent_thresh);
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ada73f26b682..2795374b6a33 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -49,6 +49,15 @@ struct inode_defrag {
 
 	/* root objectid */
 	u64 root;
+
+	/*
+	 * The extent size threshold for autodefrag.
+	 *
+	 * This value is different for compressed/non-compressed extents,
+	 * thus needs to be passed from higher layer.
+	 * (aka, inode_should_defrag())
+	 */
+	u32 extent_thresh;
 };
 
 static int __compare_inode_defrag(struct inode_defrag *defrag1,
@@ -101,6 +110,8 @@ static int __btrfs_add_inode_defrag(struct btrfs_inode *inode,
 			 */
 			if (defrag->transid < entry->transid)
 				entry->transid = defrag->transid;
+			entry->extent_thresh = min(defrag->extent_thresh,
+						   entry->extent_thresh);
 			return -EEXIST;
 		}
 	}
@@ -125,7 +136,7 @@ static inline int __need_auto_defrag(struct btrfs_fs_info *fs_info)
  * insert a defrag record for this inode if auto defrag is
  * enabled
  */
-int btrfs_add_inode_defrag(struct btrfs_inode *inode)
+int btrfs_add_inode_defrag(struct btrfs_inode *inode, u32 extent_thresh)
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -148,6 +159,7 @@ int btrfs_add_inode_defrag(struct btrfs_inode *inode)
 	defrag->ino = btrfs_ino(inode);
 	defrag->transid = transid;
 	defrag->root = root->root_key.objectid;
+	defrag->extent_thresh = extent_thresh;
 
 	spin_lock(&fs_info->defrag_inodes_lock);
 	if (!test_bit(BTRFS_INODE_IN_DEFRAG, &inode->runtime_flags)) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 61e0df14e026..96ab8e6a63d1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -565,12 +565,12 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 }
 
 static inline void inode_should_defrag(struct btrfs_inode *inode,
-		u64 start, u64 end, u64 num_bytes, u64 small_write)
+		u64 start, u64 end, u64 num_bytes, u32 small_write)
 {
 	/* If this is a small write inside eof, kick off a defrag */
 	if (num_bytes < small_write &&
 	    (start > 0 || end + 1 < inode->disk_i_size))
-		btrfs_add_inode_defrag(inode);
+		btrfs_add_inode_defrag(inode, small_write);
 }
 
 /*
-- 
2.35.0

