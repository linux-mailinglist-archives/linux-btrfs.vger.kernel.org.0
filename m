Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D939F6A8BB6
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjCBWZT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCBWZS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22371ABD4
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9BE912237E;
        Thu,  2 Mar 2023 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mpVSJgcUEebwBqt616MqGmTtMD4rBecon2H5hNLJRQ=;
        b=oy0A65jX09PC60hB1oMMYxhjTIXsliCAovgWcC7eeC/AFht/0vhTrin8qzs7SVJN5ZEi5k
        efwTB+VfdnyYGe1s0ApjUwfdRfneDWxXY+ikk1brSjOy4XnUbAeDSGxM5KpzDh4eXPVpU7
        2PqSx+i8+nLdJMY6a9rGLH9iBjztq7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795916;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mpVSJgcUEebwBqt616MqGmTtMD4rBecon2H5hNLJRQ=;
        b=3mA6esVbs5auHf/nxSH1w0eQZl5rI+Gom4VKRG3IcW62/SO1YozpZrTdUSbKxK/KJwPP9K
        LQzxBh2BNTiyg0Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AC0913349;
        Thu,  2 Mar 2023 22:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NDEhBkwiAWSmSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:16 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 06/21] btrfs: wait ordered range before locking during truncate
Date:   Thu,  2 Mar 2023 16:24:51 -0600
Message-Id: <e9629218282f3e016517f1280b48c5d194fd7c40.1677793433.git.rgoldwyn@suse.com>
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

Check if truncate needs to wait for ordered range before calling
btrfs_truncate(). Instead of performing it in btrfs_truncate(), perform
the wait before the call.

Remove the no longer needed variable to perform writeback in
btrfs_truncate().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2c96c39975e0..02307789b0a8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -109,7 +109,7 @@ static const struct file_operations btrfs_dir_file_operations;
 static struct kmem_cache *btrfs_inode_cachep;
 
 static int btrfs_setsize(struct inode *inode, struct iattr *attr);
-static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback);
+static int btrfs_truncate(struct btrfs_inode *inode);
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct page *locked_page,
 				   u64 start, u64 end, int *page_started,
@@ -5084,7 +5084,7 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 	} else {
 		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 
-		if (btrfs_is_zoned(fs_info)) {
+		if (btrfs_is_zoned(fs_info) || (newsize < oldsize)) {
 			ret = btrfs_wait_ordered_range(inode,
 					ALIGN(newsize, fs_info->sectorsize),
 					(u64)-1);
@@ -5105,7 +5105,8 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 
 		inode_dio_wait(inode);
 
-		ret = btrfs_truncate(BTRFS_I(inode), newsize == oldsize);
+		ret = btrfs_truncate(BTRFS_I(inode));
+
 		if (ret && inode->i_nlink) {
 			int err;
 
@@ -8241,7 +8242,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	return ret;
 }
 
-static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
+static int btrfs_truncate(struct btrfs_inode *inode)
 {
 	struct btrfs_truncate_control control = {
 		.inode = inode,
@@ -8254,17 +8255,8 @@ static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback)
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
2.39.2

