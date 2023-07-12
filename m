Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C256474FF7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 08:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjGLGjs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 02:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjGLGjW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 02:39:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC2210C
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 23:38:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54BDE1FEED
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689143889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7GtzjxV9Z34Mpi6yuH7t8kuUDU/mHWJhD37QUclnS8=;
        b=j0tfsHS7rkv6nLzeVHA+J4EVB1lfreSXenZx2A7ufQIcoSxDOL3L9BoBWNeM54lxoPrLoS
        MNIDuXVMkVzBN5zBUbeJgWFw0mHJ/1CNby9QChNMY0QiatLJF33VaAG0D6/Dnc41SWHxnN
        8bz2pF+qaAJscmhCszznCzACpzbg51Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0953133DD
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cLBlH1BKrmRhDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/6] btrfs: refactor copy_extent_buffer_full()
Date:   Wed, 12 Jul 2023 14:37:45 +0800
Message-ID: <57345cca098e7545ea332c3035c5f0fec4276905.1689143655.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689143654.git.wqu@suse.com>
References: <cover.1689143654.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]
copy_extent_buffer_full() currently does different handling for regular
and subpage cases, for regular cases it does a page by page copying.
For subpage cases, it just copy the content.

This is fine for the page based extent buffer code, but for the incoming
folio conversion, it can be a burden to add a new branch just to handle
all the different combinations (subpage vs regular, one single folio vs
multi pages).

[ENHANCE]
Instead of handling the different combinations, just go one single
handling for all cases, utilizing write_extent_buffer() to do the
copying.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4db90ede8219..c84e64181acb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4239,24 +4239,19 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
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
+		int index = get_eb_page_index(cur);
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

