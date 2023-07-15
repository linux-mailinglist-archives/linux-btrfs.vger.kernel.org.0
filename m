Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E75754865
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 13:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGOLJE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 07:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGOLJD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 07:09:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6095235B7
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 04:09:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 206F621FC8;
        Sat, 15 Jul 2023 11:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689419340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0w85z6TobOd3Y6pi6/DSlZ2LC6wNFSZPpy75lkhukM=;
        b=CNohJrcp8la8GsHPCykBIFWoQjGNsnxIXNXmljzIVDSTtDTTXM8iOe0lSOmpMnOzrVjAbA
        L1MEEX0MKU4JU1MRJibrMi0FHHxm+8u640VomKB7KbKqCzr+OprelOGmcoA2n4Xuz8jFep
        xrDjc9i30P5AZ6LXYTRhljYubQsI394=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EEEB133F7;
        Sat, 15 Jul 2023 11:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wJWVMkp+smRcZwAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 15 Jul 2023 11:08:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3 5/8] btrfs: refactor main loop in copy_extent_buffer_full()
Date:   Sat, 15 Jul 2023 19:08:31 +0800
Message-ID: <4a36178ea553d61fa364d08062b43f5b33efa417.1689418958.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689418958.git.wqu@suse.com>
References: <cover.1689418958.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]
copy_extent_buffer_full() currently does different handling for regular
and subpage cases, for regular cases it does a page by page copying.
For subpage cases, it just copies the content.

This is fine for the page based extent buffer code, but for the incoming
folio conversion, it can be a burden to add a new branch just to handle
all the different combinations (subpage vs regular, one single folio vs
multi pages).

[ENHANCE]
Instead of handling the different combinations, just go one single
handling for all cases, utilizing write_extent_buffer() to do the
copying.

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aabb59cb3669..46f72e6623d6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4236,24 +4236,19 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 void copy_extent_buffer_full(const struct extent_buffer *dst,
 			     const struct extent_buffer *src)
 {
-	int i;
-	int num_pages;
+	unsigned long cur = 0;
 
 	ASSERT(dst->len == src->len);
 
-	if (dst->fs_info->nodesize >= PAGE_SIZE) {
-		num_pages = num_extent_pages(dst);
-		for (i = 0; i < num_pages; i++)
-			copy_page(page_address(dst->pages[i]),
-				  page_address(src->pages[i]));
-	} else {
-		size_t src_offset = get_eb_offset_in_page(src, 0);
-		size_t dst_offset = get_eb_offset_in_page(dst, 0);
+	while (cur < src->len) {
+		unsigned long index = get_eb_page_index(cur);
+		unsigned long offset = get_eb_offset_in_page(src, cur);
+		unsigned long cur_len = min(src->len, PAGE_SIZE - offset);
+		void *addr = page_address(src->pages[index]) + offset;
 
-		ASSERT(src->fs_info->nodesize < PAGE_SIZE);
-		memcpy(page_address(dst->pages[0]) + dst_offset,
-		       page_address(src->pages[0]) + src_offset,
-		       src->len);
+		write_extent_buffer(dst, addr, cur, cur_len);
+
+		cur += cur_len;
 	}
 }
 
-- 
2.41.0

