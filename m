Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5810754868
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGOLJH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 07:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjGOLJG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 07:09:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2480F269D
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 04:09:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3C7E1F86B
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689419343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACwQIQwTgNOCXDiDniOuKbg2s/7ei0+/Ot7cSKaTlus=;
        b=RMlxQ4W6XZctk7j5eedhPvoYqUI5WZ2YCNDjIiw1i9tmLvEFBr/p8EhzF3SuEQLKclNR7m
        jqfLQDq4f0rjUe68hyV1qtuwSqr9G20S0Z3Oqke2cLdlyDRAJoXl2MtL5Na3x4HxQuPHds
        2Dwxzu/MLB6TtfUO7BivAgSKuwaMgWs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 147AD133F7
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2P7lM05+smRcZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:09:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 8/8] btrfs: refactor main loop in memmove_extent_buffer()
Date:   Sat, 15 Jul 2023 19:08:34 +0800
Message-ID: <453f48d4816abde12f1d836cdf471a85f9667943.1689418958.git.wqu@suse.com>
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
Currently memove_extent_buffer() does a loop where it strop at any page
boundary inside [dst_offset, dst_offset + len) or [src_offset,
src_offset + len).

This is mostly allowing us to do copy_pages(), but if we're going to use
folios we will need to handle multi-page (the old behavior) or single
folio (the new optimization).

The current code would be a burden for future changes.

[ENHANCEMENT]
Instead of sticking with copy_pages(), here we utilize the new
__write_extent_buffer() helper to handle the writes.

Unlike the refactor in memcpy_extent_buffer(), we can not just rely on
the write_extent_buffer() and only handle page boundaries inside src
range.

The function write_extent_buffer() itself is still doing forward
writing, thus it can not handle the following case: (already in the
extent buffer memory operation tests, cross page overlapping run 2)

	Src	Page boundary
	|///////|
	    |///|////|
	    Dst

In above case, if we just following page boundary in the src range, we
have no need to do any split, just one __write_extent_buffer() with
@use_memmove = true.

But __write_extent_buffer() would split the dst range into two,
so it first copies the beginning part of the src range into the first half
of the dst range.
After this operation, the beginning of the dst range is already updated,
causing corruption.

So we have to follow the old behavior of handling both page boundaries.

And since we're the last caller of copy_pages(), we can remove it
completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 48 ++++++++++++++++----------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a9ab4d17530e..b8162725f054 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4442,28 +4442,6 @@ static inline bool areas_overlap(unsigned long src, unsigned long dst, unsigned
 	return distance < len;
 }
 
-static void copy_pages(struct page *dst_page, struct page *src_page,
-		       unsigned long dst_off, unsigned long src_off,
-		       unsigned long len)
-{
-	char *dst_kaddr = page_address(dst_page);
-	char *src_kaddr;
-	int must_memmove = 0;
-
-	if (dst_page != src_page) {
-		src_kaddr = page_address(src_page);
-	} else {
-		src_kaddr = dst_kaddr;
-		if (areas_overlap(src_off, dst_off, len))
-			must_memmove = 1;
-	}
-
-	if (must_memmove)
-		memmove(dst_kaddr + dst_off, src_kaddr + src_off, len);
-	else
-		memcpy(dst_kaddr + dst_off, src_kaddr + src_off, len);
-}
-
 void memcpy_extent_buffer(const struct extent_buffer *dst,
 			  unsigned long dst_offset, unsigned long src_offset,
 			  unsigned long len)
@@ -4494,23 +4472,26 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 			   unsigned long dst_offset, unsigned long src_offset,
 			   unsigned long len)
 {
-	size_t cur;
-	size_t dst_off_in_page;
-	size_t src_off_in_page;
 	unsigned long dst_end = dst_offset + len - 1;
 	unsigned long src_end = src_offset + len - 1;
-	unsigned long dst_i;
-	unsigned long src_i;
 
 	if (check_eb_range(dst, dst_offset, len) ||
 	    check_eb_range(dst, src_offset, len))
 		return;
+
 	if (dst_offset < src_offset) {
 		memcpy_extent_buffer(dst, dst_offset, src_offset, len);
 		return;
 	}
+
 	while (len > 0) {
-		dst_i = get_eb_page_index(dst_end);
+		unsigned long src_i;
+		size_t cur;
+		size_t dst_off_in_page;
+		size_t src_off_in_page;
+		void *src_addr;
+		bool use_memmove;
+
 		src_i = get_eb_page_index(src_end);
 
 		dst_off_in_page = get_eb_offset_in_page(dst, dst_end);
@@ -4518,9 +4499,14 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 
 		cur = min_t(unsigned long, len, src_off_in_page + 1);
 		cur = min(cur, dst_off_in_page + 1);
-		copy_pages(dst->pages[dst_i], dst->pages[src_i],
-			   dst_off_in_page - cur + 1,
-			   src_off_in_page - cur + 1, cur);
+
+		src_addr = page_address(dst->pages[src_i]) + src_off_in_page -
+			   cur + 1;
+		use_memmove = areas_overlap(src_end - cur + 1, dst_end - cur + 1,
+					    cur);
+
+		__write_extent_buffer(dst, src_addr, dst_end - cur + 1, cur,
+				      use_memmove);
 
 		dst_end -= cur;
 		src_end -= cur;
-- 
2.41.0

