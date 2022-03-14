Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924034D7E30
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237818AbiCNJJa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbiCNJJS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF39F25E80
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:08:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4AC681F399
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SjDxlswy1I+/nTCdio1iY8X4sJopZMEqEPET5bn/k8k=;
        b=URwpb0kG/ax72GxXB/rEglxg3vWdWjxMBXQ4clvPFDkFiiSxQuTJ4H/1oPKZ11h5SS5gT5
        h/yjNv6Yr6MuIPi9G1frcv7V2KkuessQuaBSqdVxYge1sDpEI4vIGdVW2gP+t4kJgPTnSH
        mYdUJ9EbhpCkfdpJaI/dgR/F8ZIdDa0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D5D913ADA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8M3NGfcFL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:08:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 17/18] btrfs: remove the stripe boundary calcluation for encoded IO
Date:   Mon, 14 Mar 2022 17:07:30 +0800
Message-Id: <c1b71bed891a6df0500e9f0979e8208f1e72bd01.1647248613.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647248613.git.wqu@suse.com>
References: <cover.1647248613.git.wqu@suse.com>
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

In btrfs_encoded_read_regular_fill_pages(), we have a loop to handle the
bio split due to stripe boundary.

Since btrfs_map_bio() can handle it for us now, there is no need to
manually do the split anymore.

Just remove the related btrfs_get_io_geometry() call inside
btrfs_encoded_read_regular_fill_pages().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 66a6cb5d9572..ecf039c272fc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10331,7 +10331,6 @@ static int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 						 u64 disk_io_size,
 						 struct page **pages)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_encoded_read_private priv = {
 		.inode = inode,
 		.file_offset = file_offset,
@@ -10340,7 +10339,6 @@ static int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	};
 	unsigned long i = 0;
 	u64 cur = 0;
-	int ret;
 
 	init_waitqueue_head(&priv.wait);
 	/*
@@ -10348,25 +10346,9 @@ static int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	 * necessary.
 	 */
 	while (cur < disk_io_size) {
-		struct extent_map *em;
-		struct btrfs_io_geometry geom;
 		struct bio *bio = NULL;
-		u64 remaining;
+		u64 remaining = disk_io_size - cur;
 
-		em = btrfs_get_chunk_map(fs_info, disk_bytenr + cur,
-					 disk_io_size - cur);
-		if (IS_ERR(em)) {
-			ret = PTR_ERR(em);
-		} else {
-			ret = btrfs_get_io_geometry(fs_info, em, BTRFS_MAP_READ,
-						    disk_bytenr + cur, &geom);
-			free_extent_map(em);
-		}
-		if (ret) {
-			WRITE_ONCE(priv.status, errno_to_blk_status(ret));
-			break;
-		}
-		remaining = min(geom.len, disk_io_size - cur);
 		while (bio || remaining) {
 			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
 
-- 
2.35.1

