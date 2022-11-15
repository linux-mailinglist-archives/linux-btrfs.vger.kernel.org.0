Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F276F62A0F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiKOSBo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbiKOSBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FC7108
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:00:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E6451F8E9;
        Tue, 15 Nov 2022 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufWE0JtJ3U7iLRpbLE7tVDsUSR8tOxLV0WNy8paVL0M=;
        b=Ysf4bqA9BK6H8V0RNSPfaJhwiadx9G1yKV2v3o+YD9Nxs8j2nx2+jKuz+6ev1z363PWvdI
        MBy6dFMcjQdWBTonqZvi0wd7MqOGdEsWRvGwMEOJ2q7e+CZEDw9S9R8n4ODw9AOEMIFJk3
        Es5CBAGf28ttUoJiL5q5J5rfLG3VKhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535244;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufWE0JtJ3U7iLRpbLE7tVDsUSR8tOxLV0WNy8paVL0M=;
        b=SGtjC50FiRkgjGa0d/iw1nWnVngN43eZ5TenG6bH0lHj85tplTAYsPdA+wWxsUyMLdJz+5
        d1f9mtUHPGgrjFCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2281F13A91;
        Tue, 15 Nov 2022 18:00:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5wNgAMzTc2OSZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:00:44 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 03/16] btrfs: wait ordered range before locking during truncate
Date:   Tue, 15 Nov 2022 12:00:21 -0600
Message-Id: <07644d32ba3e517e26199b4b78f81636655a7702.1668530684.git.rgoldwyn@suse.com>
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

Check if truncate needs to wait for ordered range before calling
btrfs_truncate(). Instead of performing it in btrfs_truncate(), perform
the wait before the call.

Remove the no longer needed variable to perform writeback in
btrfs_truncate().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 29c1748adacf..1044a34a20e6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -124,7 +124,7 @@ static const struct file_operations btrfs_dir_file_operations;
 static struct kmem_cache *btrfs_inode_cachep;
 
 static int btrfs_setsize(struct inode *inode, struct iattr *attr);
-static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback);
+static int btrfs_truncate(struct btrfs_inode *inode);
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
@@ -5240,7 +5240,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 	} else {
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 
-		if (btrfs_is_zoned(fs_info)) {
+		if (btrfs_is_zoned(fs_info) || (newsize < oldsize)) {
 			ret = btrfs_wait_ordered_range(inode,
 					ALIGN(newsize, fs_info->sectorsize),
 					(u64)-1);
@@ -5261,7 +5261,8 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 
 		inode_dio_wait(inode);
 
-		ret = btrfs_truncate(BTRFS_I(inode), newsize == oldsize);
+		ret = btrfs_truncate(BTRFS_I(inode));
+
 		if (ret && inode->i_nlink) {
 			int err;
 
@@ -8627,7 +8628,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	return ret;
 }
 
-static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
+static int btrfs_truncate(struct btrfs_inode *inode)
 {
 	struct btrfs_truncate_control control = {
 		.inode = inode,
@@ -8640,17 +8641,8 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
 	struct btrfs_block_rsv *rsv;
 	int ret;
 	struct btrfs_trans_handle *trans;
-	u64 mask = fs_info->sectorsize - 1;
 	u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
 
-	if (!skip_writeback) {
-		ret = btrfs_wait_ordered_range(&inode->vfs_inode,
-					       inode->vfs_inode.i_size & (~mask),
-					       (u64)-1);
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * Yes ladies and gentlemen, this is indeed ugly.  We have a couple of
 	 * things going on here:
-- 
2.35.3

