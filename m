Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B7B4E7031
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 10:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358498AbiCYJop (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 05:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358522AbiCYJoo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 05:44:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91A86242
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 02:43:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 02E171F745
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648201388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYeV9ahU9Jew5+x+UBzdKBsJDvWGyNhHu/etn5ya9/4=;
        b=Q/Oa7EKn4Kltru7AJMMyAgJzWgh+mJohoogXwQEeWDA+V1Wbs0+f7D2fhkdKPEFkXaO6H2
        MEQNNUTSqdZzo1xwR5NKS9ferRjEeeEgttRG5x8xYi1c2yj0vN1d16AAEbWMOl2S4k6hzH
        jvCGxoWmz/g0oXY7Imt7tadV2saUcSo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A12E132E9
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QOCJCquOPWInCAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 09:43:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/2] btrfs: introduce a pure data checksum checking helper
Date:   Fri, 25 Mar 2022 17:42:48 +0800
Message-Id: <9b69fcc642594113c8a0dcd9aabbd65739bc8253.1648201268.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648201268.git.wqu@suse.com>
References: <cover.1648201268.git.wqu@suse.com>
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

Although we have several data csum verification code, we never have a
function really just to verify checksum for one sector.

Function check_data_csum() do extra work for error reporting, thus it
requires a lot of extra things like file offset, bio_offset etc.

Function btrfs_verify_data_csum() is even worse, it will utizlie page
checked flag, which means it can not be utilized for direct IO pages.

Here we introduce a new helper, btrfs_check_data_sector(), which really
only accept a sector in page, and expected checksum pointer.

We use this function to implement check_data_csum(), and export it for
incoming patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/inode.c | 48 ++++++++++++++++++++++++++++++++++++------------
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 09b7b0b2d016..dd26f6995925 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3254,6 +3254,8 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 				   int mirror_num, unsigned long bio_flags);
+int btrfs_check_data_sector(struct btrfs_fs_info *fs_info, struct page *page,
+			    u32 pgoff, u8 *csum_expected);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 179d479b72e9..3ba1315784f6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3254,6 +3254,37 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 				       finish_ordered_fn, uptodate);
 }
 
+/*
+ * Just verify one sector of csum, without any extra handling.
+ *
+ * Functions like btrfs_verify_data_csum() have extra handling like setting
+ * page flags which is not suitable for call sites like direct IO.
+ *
+ * This pure csum checking allows us to utilize it for call sites which need
+ * to handle page for both buffered and direct IO.
+ */
+int btrfs_check_data_sector(struct btrfs_fs_info *fs_info, struct page *page,
+			    u32 pgoff, u8 *csum_expected)
+{
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	char *kaddr;
+	const u32 len = fs_info->sectorsize;
+	const u32 csum_size = fs_info->csum_size;
+	u8 csum[BTRFS_CSUM_SIZE];
+
+	ASSERT(pgoff + len <= PAGE_SIZE);
+
+	kaddr = kmap_atomic(page);
+	shash->tfm = fs_info->csum_shash;
+
+	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
+	kunmap_atomic(kaddr);
+
+	if (memcmp(csum, csum_expected, csum_size))
+		return -EIO;
+	return 0;
+}
+
 /*
  * check_data_csum - verify checksum of one sector of uncompressed data
  * @inode:	inode
@@ -3264,14 +3295,15 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
  * @start:	logical offset in the file
  *
  * The length of such check is always one sector size.
+ *
+ * When csum mismatch detected, we will also report the error and fill the
+ * corrupted range with zero. (thus it needs the extra parameters)
  */
 static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 			   u32 bio_offset, struct page *page, u32 pgoff,
 			   u64 start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	char *kaddr;
 	const u32 len = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
 	unsigned int offset_sectors;
@@ -3283,17 +3315,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
 	csum_expected = ((u8 *)bbio->csum) + offset_sectors * csum_size;
 
-	kaddr = kmap_atomic(page);
-	shash->tfm = fs_info->csum_shash;
-
-	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
-	kunmap_atomic(kaddr);
-
-	if (memcmp(csum, csum_expected, csum_size))
-		goto zeroit;
+	if (!btrfs_check_data_sector(fs_info, page, pgoff, csum_expected))
+		return 0;
 
-	return 0;
-zeroit:
 	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
 				    bbio->mirror_num);
 	if (bbio->device)
-- 
2.35.1

