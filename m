Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206E54E7019
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 10:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357577AbiCYJjz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 05:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357541AbiCYJjy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 05:39:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73DC21A4
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 02:38:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A7D891F745
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648201098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=39hoC/HqZpz/+8OfE/6IJIMnwQczQVdPcnf8PWqiJy0=;
        b=A7fLbA+Qj5XitHiLNsbV7VEu2OCfxmzGbrfAY5L7v9O+hELu3h1mBFkSqAVdyapiYfmSHz
        q+ltV9znr5j/tIcjlOmYy0gcoJM+L5cIOMti2lGoPKlG0IfDR64k/1rsvhJ+wCq/R+3pPi
        Xr1vE+iasWs2W1dbDLUK5WCs9iJERzM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D82C132E9
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oxYREYmNPWLmBQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:38:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: replace a wrong memset() with memzero_page()
Date:   Fri, 25 Mar 2022 17:37:59 +0800
Message-Id: <8d6f911a0282eba76f9e05d6f1e7c6f091d4870b.1648199349.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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

The original code is not really setting the memory to 0x00 but 0x01.

To prevent such problem from happening, use memzero_page() instead.

Since we're here, also make @len const since it's just sectorsize.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 78a5145353e1..179d479b72e9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3272,7 +3272,7 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
-	u32 len = fs_info->sectorsize;
+	const u32 len = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
 	unsigned int offset_sectors;
 	u8 *csum_expected;
@@ -3287,11 +3287,11 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	shash->tfm = fs_info->csum_shash;
 
 	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
+	kunmap_atomic(kaddr);
 
 	if (memcmp(csum, csum_expected, csum_size))
 		goto zeroit;
 
-	kunmap_atomic(kaddr);
 	return 0;
 zeroit:
 	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
@@ -3299,9 +3299,8 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	if (bbio->device)
 		btrfs_dev_stat_inc_and_print(bbio->device,
 					     BTRFS_DEV_STAT_CORRUPTION_ERRS);
-	memset(kaddr + pgoff, 1, len);
+	memzero_page(page, pgoff, len);
 	flush_dcache_page(page);
-	kunmap_atomic(kaddr);
 	return -EIO;
 }
 
-- 
2.35.1

