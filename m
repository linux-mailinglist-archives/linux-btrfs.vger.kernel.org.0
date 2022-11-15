Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F062A0FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238496AbiKOSCA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiKOSBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A8A1151
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:01:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D87D51F8E0;
        Tue, 15 Nov 2022 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=az/70XOTVDc5ZyO9DliOMVSP+U3oAe/sj3jWn6jkCUE=;
        b=jSRFH8WThvi2MXhVtCfS9fFd+TKYqvrSHKii2f1NIsMeONIxm+Wc4d1W3ciIqrQ725y2nh
        wfaBN10WeeM3wZq2x2Qr5us9g3n0KZe4CuN65dDUnKdcsAQhSLvaP4672vW3P5i2JMogG6
        nCK+E9h5AOL8VA26Tye+hnLH+5/Liqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535263;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=az/70XOTVDc5ZyO9DliOMVSP+U3oAe/sj3jWn6jkCUE=;
        b=msMgnYlXjIy1te5hsZOZRO6yFi4AVWWzCQ8T+syrbOB2Q+n0RYg9Su8GsE5glLCpru8ykm
        oXVslnNla17kdNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C5CF13A91;
        Tue, 15 Nov 2022 18:01:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oQJXGt/Tc2O2ZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:01:03 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 12/16] btrfs: Perform memory faults under locked extent
Date:   Tue, 15 Nov 2022 12:00:30 -0600
Message-Id: <68054cb6c0be33ef7c55ef8d4b5f4dda0a0d9cbf.1668530684.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668530684.git.rgoldwyn@suse.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
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
index 559214ded4eb..876e0d81b191 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1980,8 +1980,24 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	goto out;
 }
 
+static vm_fault_t btrfs_fault(struct vm_fault *vmf)
+{
+	struct extent_state *cached_state = NULL;
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	u64 page_start = vmf->pgoff;
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
index 070fb7071e39..b421260d52e2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8530,7 +8530,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	struct page *page = vmf->page;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_ordered_extent *ordered;
 	struct extent_state *cached_state = NULL;
 	struct extent_changeset *data_reserved = NULL;
@@ -8585,11 +8584,9 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	}
 	wait_on_page_writeback(page);
 
-	lock_extent(io_tree, page_start, page_end, &cached_state);
 	ret2 = set_page_extent_mapped(page);
 	if (ret2 < 0) {
 		ret = vmf_error(ret2);
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		goto out_unlock;
 	}
 
@@ -8600,7 +8597,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ordered = btrfs_lookup_ordered_range(BTRFS_I(inode), page_start,
 			PAGE_SIZE);
 	if (ordered) {
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		unlock_page(page);
 		up_read(&BTRFS_I(inode)->i_mmap_lock);
 		btrfs_start_ordered_extent(ordered, 1);
@@ -8633,7 +8629,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	ret2 = btrfs_set_extent_delalloc(BTRFS_I(inode), page_start, end, 0,
 					&cached_state);
 	if (ret2) {
-		unlock_extent(io_tree, page_start, page_end, &cached_state);
 		ret = VM_FAULT_SIGBUS;
 		goto out_unlock;
 	}
@@ -8653,7 +8648,6 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 
 	btrfs_set_inode_last_sub_trans(BTRFS_I(inode));
 
-	unlock_extent(io_tree, page_start, page_end, &cached_state);
 	up_read(&BTRFS_I(inode)->i_mmap_lock);
 
 	btrfs_delalloc_release_extents(BTRFS_I(inode), PAGE_SIZE);
-- 
2.35.3

