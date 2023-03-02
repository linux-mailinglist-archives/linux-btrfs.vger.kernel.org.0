Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438076A8BC0
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCBWZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCBWZn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47BB28874
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 662FA2237D;
        Thu,  2 Mar 2023 22:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gpu09xd6U5oQFkn+SQpqbDOt7WLajxoD4F1GGmazUog=;
        b=FrQ/sVCKfLTs+0UWkWTEH3IB+Mm254ISFFst0GeFUySPQt59Yhkcx4+FX0qsXJ9H0Hs5mU
        Ho5dIUs12f3W1Pls+vUUuAcMeLqIfT5ywPsQg00pot2iDWiAy6GoFeM0DbeyOcKhp03afY
        r4fuNlQ+M5gD+bB+/AjpbzZovHpry1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gpu09xd6U5oQFkn+SQpqbDOt7WLajxoD4F1GGmazUog=;
        b=fSe6Kt2uaKaRe+mxAwdf0PetAP9qo80grE6ACgx2+MouD3UZaRPMUyTar5BWU5K+ljlQv3
        B+nwYkTWNyJGB4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F01AF13349;
        Thu,  2 Mar 2023 22:25:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OKffLGQiAWTfSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:40 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 16/21] btrfs: lock extent before pages in encoded write
Date:   Thu,  2 Mar 2023 16:25:01 -0600
Message-Id: <747c039e512fbfa55d862e57e727a9d10a4859db.1677793433.git.rgoldwyn@suse.com>
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

Lock the extent range while performing direct encoded writes, as opposed
to individual pages.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 52 +++++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 729def5969d8..70cf852a3efd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10289,37 +10289,18 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	pages = kvcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL_ACCOUNT);
 	if (!pages)
 		return -ENOMEM;
-	for (i = 0; i < nr_pages; i++) {
-		size_t bytes = min_t(size_t, PAGE_SIZE, iov_iter_count(from));
-		char *kaddr;
-
-		pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
-		if (!pages[i]) {
-			ret = -ENOMEM;
-			goto out_pages;
-		}
-		kaddr = kmap_local_page(pages[i]);
-		if (copy_from_iter(kaddr, bytes, from) != bytes) {
-			kunmap_local(kaddr);
-			ret = -EFAULT;
-			goto out_pages;
-		}
-		if (bytes < PAGE_SIZE)
-			memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
-		kunmap_local(kaddr);
-	}
 
 	for (;;) {
 		struct btrfs_ordered_extent *ordered;
 
 		ret = btrfs_wait_ordered_range(&inode->vfs_inode, start, num_bytes);
 		if (ret)
-			goto out_pages;
+			goto out;
 		ret = invalidate_inode_pages2_range(inode->vfs_inode.i_mapping,
 						    start >> PAGE_SHIFT,
 						    end >> PAGE_SHIFT);
 		if (ret)
-			goto out_pages;
+			goto out;
 		lock_extent(io_tree, start, end, &cached_state);
 		ordered = btrfs_lookup_ordered_range(inode, start, num_bytes);
 		if (!ordered &&
@@ -10331,6 +10312,26 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		cond_resched();
 	}
 
+	for (i = 0; i < nr_pages; i++) {
+		size_t bytes = min_t(size_t, PAGE_SIZE, iov_iter_count(from));
+		char *kaddr;
+
+		pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
+		if (!pages[i]) {
+			ret = -ENOMEM;
+			goto out_pages;
+		}
+		kaddr = kmap_local_page(pages[i]);
+		if (copy_from_iter(kaddr, bytes, from) != bytes) {
+			kunmap_local(kaddr);
+			ret = -EFAULT;
+			goto out_pages;
+		}
+		if (bytes < PAGE_SIZE)
+			memset(kaddr + bytes, 0, PAGE_SIZE - bytes);
+		kunmap_local(kaddr);
+	}
+
 	/*
 	 * We don't use the higher-level delalloc space functions because our
 	 * num_bytes and disk_num_bytes are different.
@@ -10389,8 +10390,6 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	if (start + encoded->len > inode->vfs_inode.i_size)
 		i_size_write(&inode->vfs_inode, start + encoded->len);
 
-	unlock_extent(io_tree, start, end, &cached_state);
-
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
 	if (btrfs_submit_compressed_write(inode, start, num_bytes, ins.objectid,
@@ -10400,6 +10399,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 		ret = -EIO;
 		goto out_pages;
 	}
+
+	unlock_extent(io_tree, start, end, &cached_state);
+
 	ret = orig_count;
 	goto out;
 
@@ -10419,14 +10421,14 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	 */
 	if (!extent_reserved)
 		btrfs_free_reserved_data_space_noquota(fs_info, disk_num_bytes);
-out_unlock:
-	unlock_extent(io_tree, start, end, &cached_state);
 out_pages:
 	for (i = 0; i < nr_pages; i++) {
 		if (pages[i])
 			__free_page(pages[i]);
 	}
 	kvfree(pages);
+out_unlock:
+	unlock_extent(io_tree, start, end, &cached_state);
 out:
 	if (ret >= 0)
 		iocb->ki_pos += encoded->len;
-- 
2.39.2

