Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23C533B1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 12:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiEYK7o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 06:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiEYK7m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 06:59:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9D85EDE6
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 03:59:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 999A11F939;
        Wed, 25 May 2022 10:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653476380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6pbIBWZBoET/I9ctW3pYs7LiuphBF5fiG7QR710JeI=;
        b=egxMsNX3cuQxjH0K0kRwWbscWOcJ4HXXcQG0B0dQAIAMVa+lWpbmIE9FG2R4GvJ7TxunfJ
        IXJEWukk3Ps/HpkDfhgtkqz9yvKpOkIHHh1L1J58BNfEEDIMYIhL2fH3JyHPhXj0nMHwzM
        peXQUBKoRP8hoGWZPh7REFnnNr5p42U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F53D13ADF;
        Wed, 25 May 2022 10:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eNkoEhsMjmK0AQAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 25 May 2022 10:59:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/7] btrfs: make repair_io_failure available outside of extent_io.c
Date:   Wed, 25 May 2022 18:59:12 +0800
Message-Id: <bd074de49da76033bbc1883e3019abc7984b3287.1653476251.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653476251.git.wqu@suse.com>
References: <cover.1653476251.git.wqu@suse.com>
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

Remove the static so that the function can be used by the new read
repair code, and give it a btrfs_ prefix.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 19 ++++++++++---------
 fs/btrfs/extent_io.h |  3 +++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1bd1b1253f9d..1083d6cfa858 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2321,9 +2321,9 @@ int free_io_failure(struct extent_io_tree *failure_tree,
  * currently, there can be no more than two copies of every data bit. thus,
  * exactly one rewrite is required.
  */
-static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
-			     u64 length, u64 logical, struct page *page,
-			     unsigned int pg_offset, int mirror_num)
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			    u64 length, u64 logical, struct page *page,
+			    unsigned int pg_offset, int mirror_num)
 {
 	struct btrfs_device *dev;
 	struct bio_vec bvec;
@@ -2415,8 +2415,9 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
 	for (i = 0; i < num_pages; i++) {
 		struct page *p = eb->pages[i];
 
-		ret = repair_io_failure(fs_info, 0, start, PAGE_SIZE, start, p,
-					start - page_offset(p), mirror_num);
+		ret = btrfs_repair_io_failure(fs_info, 0, start, PAGE_SIZE,
+					      start, p, start - page_offset(p),
+					      mirror_num);
 		if (ret)
 			break;
 		start += PAGE_SIZE;
@@ -2466,9 +2467,9 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 		num_copies = btrfs_num_copies(fs_info, failrec->logical,
 					      failrec->len);
 		if (num_copies > 1)  {
-			repair_io_failure(fs_info, ino, start, failrec->len,
-					  failrec->logical, page, pg_offset,
-					  failrec->failed_mirror);
+			btrfs_repair_io_failure(fs_info, ino, start,
+					failrec->len, failrec->logical,
+					page, pg_offset, failrec->failed_mirror);
 		}
 	}
 
@@ -2626,7 +2627,7 @@ static bool btrfs_check_repairable(struct inode *inode,
 	 *
 	 * Since we're only doing repair for one sector, we only need to get
 	 * a good copy of the failed sector and if we succeed, we have setup
-	 * everything for repair_io_failure to do the rest for us.
+	 * everything for btrfs_repair_io_failure() to do the rest for us.
 	 */
 	ASSERT(failed_mirror);
 	failrec->failed_mirror = failed_mirror;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 956fa434df43..6cdcea1551a6 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -276,6 +276,9 @@ int btrfs_repair_one_sector(struct inode *inode,
 			    struct page *page, unsigned int pgoff,
 			    u64 start, int failed_mirror,
 			    submit_bio_hook_t *submit_bio_hook);
+int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
+			    u64 length, u64 logical, struct page *page,
+			    unsigned int pg_offset, int mirror_num);
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
-- 
2.36.1

