Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580C7517DA4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiECGzs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiECGxx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5915FDE
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD283210E4;
        Tue,  3 May 2022 06:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4En+KBaa49xhWnWyqXPihxY4/PWZc2XOk1ADnB+VY0=;
        b=LUhxHFk76Yg3uFRe+5/FmgIoQrmU4iAjBWSAtvfyGTUBO/8px3m2PeJmO+mxA3AnVdsJjS
        DK/MIeoH93z9mPPQi1zz80bOObYNfi7/1vMCZQ18GMni+JJvIC9roIcl9JwDwAbhYEpSEc
        IS31/ZH5/cyYh7JhR0aW0MN0e5prjQg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B10113AA3;
        Tue,  3 May 2022 06:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IFyRH6rQcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 03 May 2022 06:50:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/13] btrfs: remove duplicated parameters from submit_data_read_repair()
Date:   Tue,  3 May 2022 14:49:48 +0800
Message-Id: <f6aa1986ab6dd9b1f6b544445d8ce2f51661d6b2.1651559986.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651559986.git.wqu@suse.com>
References: <cover.1651559986.git.wqu@suse.com>
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

The function submit_data_read_repair() is only called for buffered data
read path, thus those members can be calculated using bvec directly:

- start
  start = page_offset(bvec->bv_page) + bvec->bv_offset;

- end
  end = start + bvec->bv_len - 1;

- page
  page = bvec->bv_page;

- pgoff
  pgoff = bvec->bv_offset;

Thus we can safely replace those 4 parameters with just one bio_vec.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0ae4ee7f344d..240277cdccd2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2740,13 +2740,16 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 
 static blk_status_t submit_data_read_repair(struct inode *inode,
 					    struct bio *failed_bio,
-					    u32 bio_offset, struct page *page,
-					    unsigned int pgoff,
-					    u64 start, u64 end,
+					    u32 bio_offset,
+					    const struct bio_vec *bvec,
 					    int failed_mirror,
 					    unsigned int error_bitmap)
 {
+	const unsigned int pgoff = bvec->bv_offset;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct page *page = bvec->bv_page;
+	const u64 start = page_offset(bvec->bv_page) + bvec->bv_offset;
+	const u64 end = start + bvec->bv_len - 1;
 	const u32 sectorsize = fs_info->sectorsize;
 	const int nr_bits = (end + 1 - start) >> fs_info->sectorsize_bits;
 	int error = 0;
@@ -3106,10 +3109,8 @@ static void end_bio_extent_readpage(struct bio *bio)
 			 * submit_data_read_repair() will handle all the good
 			 * and bad sectors, we just continue to the next bvec.
 			 */
-			submit_data_read_repair(inode, bio, bio_offset, page,
-						start - page_offset(page),
-						start, end, mirror,
-						error_bitmap);
+			submit_data_read_repair(inode, bio, bio_offset, bvec,
+						mirror, error_bitmap);
 
 			ASSERT(bio_offset + len > bio_offset);
 			bio_offset += len;
-- 
2.36.0

