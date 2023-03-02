Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7D96A8BBD
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjCBWZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCBWZg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6919428874
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 24E6C2237D;
        Thu,  2 Mar 2023 22:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795934; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcYoCfnD6Ya4TIFGBn+KbSLGIKaOxfJrJ31n105TRSA=;
        b=XUp3CBUdBhSOJyTgIx3qRsedWNoUxCpgi+VPtQHmyiEOcPsJmDp6c2NMfejvZSIVgQmSaI
        r4RQ6OW6OtuqimZmGkqu76wYiqgxDIv+pvoZxw36jh/fIPglGmlvdep/oJs4iXoc3P1h4N
        hl/OVF6Vzu3eNl8M0ZvfrsKtjZxGb0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795934;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcYoCfnD6Ya4TIFGBn+KbSLGIKaOxfJrJ31n105TRSA=;
        b=ZWWE9ZwioCNY53K3c25EFxIJgax2tXbnwFCCmOlrBfFW11mjURIm+Ec39Z1V2K2+aNSPHj
        Xf++I7jyCLIIPMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C724813349;
        Thu,  2 Mar 2023 22:25:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fsSeJ10iAWTFSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:33 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 13/21] btrfs: Perform memory faults under locked extent
Date:   Thu,  2 Mar 2023 16:24:58 -0600
Message-Id: <1f8fe6c93e54b3bbf42c48c55884f3c7a56f1e94.1677793433.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677793433.git.rgoldwyn@suse.com>
References: <cover.1677793433.git.rgoldwyn@suse.com>
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

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

As a part of locking extents before pages, lock entire memfault region
while servicing faults.

Remove extent locking from page_mkwrite(), since it is part of the
fault.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c  | 18 +++++++++++++++++-
 fs/btrfs/inode.c |  6 ------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2e835096e3ce..fe1f63456142 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1973,8 +1973,24 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	goto out;
 }
 
+static vm_fault_t btrfs_fault(struct vm_fault *vmf)
+{
+	struct extent_state *cached_state = NULL;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	u64 page_start = round_down(vmf->pgoff, PAGE_SIZE);
+	u64 page_end = page_start + PAGE_SIZE - 1;
+	vm_fault_t ret;
+
+	lock_extent(io_tree, page_start, page_end, &cached_state);
+	ret = filemap_fault(vmf);
+	unlock_extent(io_tree, page_start, page_end, &cached_state);
+
+	return ret;
+}
+
 static const struct vm_operations_struct btrfs_file_vm_ops = {
-	.fault		= filemap_fault,
+	.fault		= btrfs_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= btrfs_page_mkwrite,
 };
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fb02b2b3ac2e..ed3553ff2c31 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8132,7 +8132,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
@@ -8187,11 +8186,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	}
 	wait_on_page_writeback(page);
 
-	lock_extent(io_tree, page_start, page_end, &cached_state);
 	ret2 = set_page_extent_mapped(page);
 	if (ret2 < 0) {
 		ret = vmf_error(ret2);
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		goto out_unlock;
 	}
 
@@ -8202,7 +8199,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start,
 			PAGE_SIZE);
 	if (ordered) {
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		unlock_page(page);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
 		btrfs_start_ordered_extent(ordered);
@@ -8235,7 +8231,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
 					&cached_state);
 	if (ret2) {
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		ret = VM_FAULT_SIGBUS;
 		goto out_unlock;
 	}
@@ -8255,7 +8250,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
 
-	unlock_extent(io_tree, page_start, page_end, &cached_state);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-- 
2.39.2

