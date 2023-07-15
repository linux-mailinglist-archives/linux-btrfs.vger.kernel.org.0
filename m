Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE6754867
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGOLJG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGOLJF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 07:09:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6854B5
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 04:09:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A7F8A1F88B
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689419342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FRGnNRRkis7BXGD3FxNcX+XRVeI/vSrL7npJxfBlVYc=;
        b=UFRHX7hP8k68G7kY/JBHXRsLzKaBh5XbMkvgnJI0iD5KH+RQEDcxLPAXFFtnTGFoqxf08b
        b1yJ57AL3LwkAsyFm41mQINdmo04BzvnBggxBC03pgvJIbLzwJQ/Cc0IPtgZ3iOCgQeiec
        UDM8YtvEmvCak6X/w/huPEyUjJBFK/8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 059CD133F7
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kP9nME1+smRcZwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 11:09:01 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 7/8] btrfs: refactor main loop in memcpy_extent_buffer()
Date:   Sat, 15 Jul 2023 19:08:33 +0800
Message-ID: <9d946c4fc38ec02d165ed08f1346b1e5403d54cb.1689418958.git.wqu@suse.com>
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
Currently memcpy_extent_buffer() does a loop where it would stop at
any page boundary inside [dst_offset, dst_offset + len) or [src_offset,
src_offset + len).

This is mostly allowing us to do copy_pages(), but if we're going to use
folios we will need to handle multi-page (the old behavior) or single
folio (the new optimization).

The current code would be a burden for future changes.

[ENHANCEMENT]
There is a hidden pitfall of the naming memcpy_extent_buffer(), unlike
regular memcpy(), this function can handle overlapping ranges.

So here we extract write_extent_buffer() into a new internal helper,
__write_extent_buffer(), and add a new parameter @use_memmove, to
indicate whether we should use memmove() or regular memcpy().

Now we can go __write_extent_buffer() to handle writing into the dst
range, with proper overlapping detection.

This has a tiny change to the chance of calling memmove().
As the split only happens at the source range page boundaries, the
memcpy/memmove() range would be slightly larger than the old code,
thus slightly increase the chance we call memmove() other than memcopy().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 56 ++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d2a89b04c487..a9ab4d17530e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4175,8 +4175,9 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
 	}
 }
 
-void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
-			 unsigned long start, unsigned long len)
+static void __write_extent_buffer(const struct extent_buffer *eb,
+				  const void *srcv, unsigned long start,
+				  unsigned long len, bool use_memmove)
 {
 	size_t cur;
 	size_t offset;
@@ -4184,6 +4185,8 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 	char *kaddr;
 	char *src = (char *)srcv;
 	unsigned long i = get_eb_page_index(start);
+	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
+	const bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
 	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
 
@@ -4194,11 +4197,15 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 
 	while (len > 0) {
 		page = eb->pages[i];
-		assert_eb_page_uptodate(eb, page);
+		if (check_uptodate)
+			assert_eb_page_uptodate(eb, page);
 
 		cur = min(len, PAGE_SIZE - offset);
 		kaddr = page_address(page);
-		memcpy(kaddr + offset, src, cur);
+		if (use_memmove)
+			memmove(kaddr + offset, src, cur);
+		else
+			memcpy(kaddr + offset, src, cur);
 
 		src += cur;
 		len -= cur;
@@ -4207,6 +4214,12 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 	}
 }
 
+void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
+			 unsigned long start, unsigned long len)
+{
+	return __write_extent_buffer(eb, srcv, start, len, false);
+}
+
 static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 				 unsigned long start, unsigned long len)
 {
@@ -4455,34 +4468,25 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 			  unsigned long dst_offset, unsigned long src_offset,
 			  unsigned long len)
 {
-	size_t cur;
-	size_t dst_off_in_page;
-	size_t src_off_in_page;
-	unsigned long dst_i;
-	unsigned long src_i;
+	unsigned long cur_off = 0;
 
 	if (check_eb_range(dst, dst_offset, len) ||
 	    check_eb_range(dst, src_offset, len))
 		return;
 
-	while (len > 0) {
-		dst_off_in_page = get_eb_offset_in_page(dst, dst_offset);
-		src_off_in_page = get_eb_offset_in_page(dst, src_offset);
+	while (cur_off < len) {
+		unsigned long cur_src = cur_off + src_offset;
+		unsigned long pg_index = get_eb_page_index(cur_src);
+		unsigned long pg_off = get_eb_offset_in_page(dst, cur_src);
+		unsigned long cur_len = min(src_offset + len - cur_src,
+					    PAGE_SIZE - pg_off);
+		void *src_addr = page_address(dst->pages[pg_index]) + pg_off;
+		const bool use_memmove = areas_overlap(src_offset + cur_off,
+						       dst_offset + cur_off, cur_len);
 
-		dst_i = get_eb_page_index(dst_offset);
-		src_i = get_eb_page_index(src_offset);
-
-		cur = min(len, (unsigned long)(PAGE_SIZE -
-					       src_off_in_page));
-		cur = min_t(unsigned long, cur,
-			(unsigned long)(PAGE_SIZE - dst_off_in_page));
-
-		copy_pages(dst->pages[dst_i], dst->pages[src_i],
-			   dst_off_in_page, src_off_in_page, cur);
-
-		src_offset += cur;
-		dst_offset += cur;
-		len -= cur;
+		__write_extent_buffer(dst, src_addr, dst_offset + cur_off, cur_len,
+				      use_memmove);
+		cur_off += cur_len;
 	}
 }
 
-- 
2.41.0

