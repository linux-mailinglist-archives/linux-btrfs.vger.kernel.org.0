Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAEC51123E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358712AbiD0HWc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358690AbiD0HWb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8A65DE71
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DA3771F380
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kpqua+aXAzVXUDipAA4UKhrz3+J9KGk5zRK8p4ZyS8k=;
        b=hRLzSoW5Ik8Jz1UB1wk3/imnKjU4AfWPlflFLGDJkJjtDVC9Fo4zUyyYBv2tdJJ3ziY8Vv
        N8tq4VLWDQq5bIGv45eYVoWcTiVuUuyfh7YmQUiVp38JsXuL21Qci0lLlSPBtPH+NIgxOQ
        y/HUfeFrYE1N3cBi20pkx9CN/LjWprQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C3C013A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wJmaOHbuaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 03/12] btrfs: remove duplicated parameters from submit_data_read_repair()
Date:   Wed, 27 Apr 2022 15:18:49 +0800
Message-Id: <5e2703629692c60feef18ff551c453c4ce1cf5f0.1651043617.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651043617.git.wqu@suse.com>
References: <cover.1651043617.git.wqu@suse.com>
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
---
 fs/btrfs/extent_io.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a3962df30603..1f273ef966bd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2734,13 +2734,16 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 
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
@@ -3100,10 +3103,8 @@ static void end_bio_extent_readpage(struct bio *bio)
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

