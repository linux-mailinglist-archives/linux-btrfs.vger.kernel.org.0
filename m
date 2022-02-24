Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39B4C2BB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 13:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbiBXM31 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 07:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiBXM3Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 07:29:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1754B269A83
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 04:28:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C8F402113D
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645705727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+kR2Nj1jB4nbc1U4UvK8kRw/XHxgrb5YBlnpZtkG/3o=;
        b=Lv6PPeVsdQrfMj4spiftszfwi3I5JHxNTcdEo3Ovq+6eSiBIGokcSTWvy7pUAbnTKYmB/b
        lSka7DcsPkEaSY5KGOhHf89vCGLIOTcnpTGuHJQvez8xYW5Ed6Ttav8kxkzNt4tF5jW6IW
        HinHKwKiN53PiKwOeNufqR8prJNUwTs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BC5E13AD9
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cM/HNP55F2LhAgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 12:28:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: refactor __btrfs_run_defrag_inode()
Date:   Thu, 24 Feb 2022 20:28:36 +0800
Message-Id: <254935398057591304da107b5e5d9967976b1265.1645705266.git.wqu@suse.com>
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

This refactor involves:

- Use while () loop to replace open-coded loop

- Add extra comments on btrfs_get_fs_root()/btrfs_iget() calls

- Add extra comment on the meaning of range.start

- Move @root, @inode and @range into the loop

- Initial @range to 0 at its declaration
  So we don't need to reset it to zero.

There is one behavior change:

- Now we check @cur against @isize from last iteration.
  And the initial dummy @isize is set to (u64)-1 so we can always
  initial the loop.

  This slightly enlarge the race window where isize can be changed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 85 ++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7d096c3f9127..5b11a8c72114 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -247,57 +247,62 @@ void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info)
 static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 				    struct inode_defrag *defrag)
 {
-	struct btrfs_root *inode_root;
-	struct inode *inode;
-	struct btrfs_ioctl_defrag_range_args range;
 	int ret = 0;
+	/* Initially we don't have the inode, use -1 as dummy isize */
+	u64 isize = (u64)-1;
 	u64 cur = 0;
 
-again:
-	if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
-		goto cleanup;
-	if (!__need_auto_defrag(fs_info))
-		goto cleanup;
+	while (cur < isize) {
+		struct btrfs_ioctl_defrag_range_args range = { 0 };
+		struct btrfs_root *inode_root;
+		struct inode *inode;
 
-	/* get the inode */
-	inode_root = btrfs_get_fs_root(fs_info, defrag->root, true);
-	if (IS_ERR(inode_root)) {
-		ret = PTR_ERR(inode_root);
-		goto cleanup;
-	}
+		if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
+			break;
+		if (!__need_auto_defrag(fs_info))
+			break;
 
-	inode = btrfs_iget(fs_info->sb, defrag->ino, inode_root);
-	btrfs_put_root(inode_root);
-	if (IS_ERR(inode)) {
-		ret = PTR_ERR(inode);
-		goto cleanup;
-	}
+		/* Check if the root is still there and grab it */
+		inode_root = btrfs_get_fs_root(fs_info, defrag->root, true);
+		if (IS_ERR(inode_root)) {
+			ret = PTR_ERR(inode_root);
+			break;
+		}
 
-	if (cur >= i_size_read(inode)) {
-		iput(inode);
-		goto cleanup;
-	}
+		/* Check if the inode is still there and grab it */
+		inode = btrfs_iget(fs_info->sb, defrag->ino, inode_root);
+		btrfs_put_root(inode_root);
+		if (IS_ERR(inode)) {
+			ret = PTR_ERR(inode);
+			break;
+		}
 
-	/* do a chunk of defrag */
-	clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
-	memset(&range, 0, sizeof(range));
-	range.len = (u64)-1;
-	range.start = cur;
-	range.extent_thresh = defrag->extent_thresh;
+		isize = i_size_read(inode);
 
-	sb_start_write(fs_info->sb);
-	ret = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
-				       BTRFS_DEFRAG_BATCH);
-	sb_end_write(fs_info->sb);
-	iput(inode);
+		/* do a chunk of defrag */
+		clear_bit(BTRFS_INODE_IN_DEFRAG, &BTRFS_I(inode)->runtime_flags);
+		range.len = (u64)-1;
+		range.start = cur;
+		range.extent_thresh = defrag->extent_thresh;
 
-	if (ret < 0)
-		goto cleanup;
+		sb_start_write(fs_info->sb);
+		ret = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
+				       BTRFS_DEFRAG_BATCH);
+		sb_end_write(fs_info->sb);
+		iput(inode);
 
-	cur = max(cur + fs_info->sectorsize, range.start);
-	goto again;
+		if (ret < 0)
+			break;
 
-cleanup:
+		/*
+		 * Range.start is the last scanned bytenr.
+		 *
+		 * And just in case the last scanned bytenr doesn't get
+		 * increased at all, at least start from the next sector
+		 * of current bytenr.
+		 */
+		cur = max(cur + fs_info->sectorsize, range.start);
+	}
 	kmem_cache_free(btrfs_inode_defrag_cachep, defrag);
 	return ret;
 }
-- 
2.35.1

