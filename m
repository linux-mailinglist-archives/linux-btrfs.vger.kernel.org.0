Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB416754863
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jul 2023 13:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGOLJA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jul 2023 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjGOLI7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jul 2023 07:08:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66484B5
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jul 2023 04:08:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 252C221FC0;
        Sat, 15 Jul 2023 11:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689419337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bBSDI0O6oMLG1WWgDMSrznGjbCTMQFvw2neWNutg3Y4=;
        b=Gmtthm3H5QBkuwExlrSX6JUnpSvEz66cBW/4wNqAv4MKl02Le+7yh3UNIpnxjtixXjQ6QA
        CoDMSK+yPjNDCoTSBrcsFIdcTAIcqc9kI3J2Z8hD4JD6t8c7yW8Tb58TCPLUnFhndxZiZ7
        F5iOdxq/33lABprW9i/3Ol3n5u8DcRQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B0D5133F7;
        Sat, 15 Jul 2023 11:08:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QGJEGUd+smRcZwAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 15 Jul 2023 11:08:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3 3/8] btrfs: refactor extent buffer bitmaps operations
Date:   Sat, 15 Jul 2023 19:08:29 +0800
Message-ID: <3e45696c9e23c3a3a5376208db734e813a685db6.1689418958.git.wqu@suse.com>
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
Currently we handle extent bitmaps manually in
extent_buffer_bitmap_set() and extent_buffer_bitmap_clear().

Although with various helpers like eb_bitmap_offset() it's still a little
messy to read.  The code seems to be a copy of bitmap_set(), but with
all the cross-page handling embedded into the code.

[ENHANCEMENT]
This patch would enhance the readability by introducing two helpers:

- memset_extent_buffer()
  To handle the byte aligned range, thus all the cross-page handling is
  done there.

- extent_buffer_get_byte()
  This for the first and the last byte operations, which only need to
  grab one byte, thus no need for any cross-page handling.

So we can split both extent_buffer_bitmap_set() and
extent_buffer_bitmap_clear() into 3 parts:

- Handle the first byte
  If the range fits inside the first byte, we can exit early.

- Handle the byte aligned part
  This is the part which can have cross-page operations, and it would
  be handled by memset_extent_buffer().

- Handle the last byte

This refactoring does not only make the code a little easier to read,
but also makes later folio/page switch much easier, as the switch only
needs to be done inside memset_extent_buffer() and extent_buffer_get_byte().

Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 141 ++++++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 74 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a845a90d46f7..4acc6d05c467 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4229,32 +4229,30 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 	}
 }
 
-void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
-		unsigned long len)
+static void memset_extent_buffer(const struct extent_buffer *eb, int c,
+				 unsigned long start, unsigned long len)
 {
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	unsigned long i = get_eb_page_index(start);
+	unsigned long cur = start;
 
+	while (cur < start + len) {
+		unsigned long index = get_eb_page_index(cur);
+		unsigned int offset = get_eb_offset_in_page(eb, cur);
+		unsigned int cur_len = min(start + len - cur, PAGE_SIZE - offset);
+		struct page *page = eb->pages[index];
+
+		assert_eb_page_uptodate(eb, page);
+		memset(page_address(page) + offset, c, cur_len);
+
+		cur += cur_len;
+	}
+}
+
+void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
+			   unsigned long len)
+{
 	if (check_eb_range(eb, start, len))
 		return;
-
-	offset = get_eb_offset_in_page(eb, start);
-
-	while (len > 0) {
-		page = eb->pages[i];
-		assert_eb_page_uptodate(eb, page);
-
-		cur = min(len, PAGE_SIZE - offset);
-		kaddr = page_address(page);
-		memset(kaddr + offset, 0, cur);
-
-		len -= cur;
-		offset = 0;
-		i++;
-	}
+	return memset_extent_buffer(eb, 0, start, len);
 }
 
 void copy_extent_buffer_full(const struct extent_buffer *dst,
@@ -4371,6 +4369,15 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
 }
 
+static u8 *extent_buffer_get_byte(const struct extent_buffer *eb, unsigned long bytenr)
+{
+	unsigned long index = get_eb_page_index(bytenr);
+
+	if (check_eb_range(eb, bytenr, 1))
+		return NULL;
+	return page_address(eb->pages[index]) + get_eb_offset_in_page(eb, bytenr);
+}
+
 /*
  * Set an area of a bitmap to 1.
  *
@@ -4382,35 +4389,28 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long start,
 			      unsigned long pos, unsigned long len)
 {
+	unsigned int first_byte = start + BIT_BYTE(pos);
+	unsigned int last_byte = start + BIT_BYTE(pos + len - 1);
+	const bool same_byte = (first_byte == last_byte);
+	u8 mask = BITMAP_FIRST_BYTE_MASK(pos);
 	u8 *kaddr;
-	struct page *page;
-	unsigned long i;
-	size_t offset;
-	const unsigned int size = pos + len;
-	int bits_to_set = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
-	u8 mask_to_set = BITMAP_FIRST_BYTE_MASK(pos);
 
-	eb_bitmap_offset(eb, start, pos, &i, &offset);
-	page = eb->pages[i];
-	assert_eb_page_uptodate(eb, page);
-	kaddr = page_address(page);
+	if (same_byte)
+		mask &= BITMAP_LAST_BYTE_MASK(pos + len);
 
-	while (len >= bits_to_set) {
-		kaddr[offset] |= mask_to_set;
-		len -= bits_to_set;
-		bits_to_set = BITS_PER_BYTE;
-		mask_to_set = ~0;
-		if (++offset >= PAGE_SIZE && len > 0) {
-			offset = 0;
-			page = eb->pages[++i];
-			assert_eb_page_uptodate(eb, page);
-			kaddr = page_address(page);
-		}
-	}
-	if (len) {
-		mask_to_set &= BITMAP_LAST_BYTE_MASK(size);
-		kaddr[offset] |= mask_to_set;
-	}
+	/* Handle the first byte. */
+	kaddr = extent_buffer_get_byte(eb, first_byte);
+	*kaddr |= mask;
+	if (same_byte)
+		return;
+
+	/* Handle the byte aligned part. */
+	ASSERT(first_byte + 1 <= last_byte);
+	memset_extent_buffer(eb, 0xff, first_byte + 1, last_byte - first_byte - 1);
+
+	/* Handle the last byte. */
+	kaddr = extent_buffer_get_byte(eb, last_byte);
+	*kaddr |= BITMAP_LAST_BYTE_MASK(pos + len);
 }
 
 
@@ -4426,35 +4426,28 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 				unsigned long start, unsigned long pos,
 				unsigned long len)
 {
+	unsigned int first_byte = start + BIT_BYTE(pos);
+	unsigned int last_byte = start + BIT_BYTE(pos + len - 1);
+	const bool same_byte = (first_byte == last_byte);
+	u8 mask = BITMAP_FIRST_BYTE_MASK(pos);
 	u8 *kaddr;
-	struct page *page;
-	unsigned long i;
-	size_t offset;
-	const unsigned int size = pos + len;
-	int bits_to_clear = BITS_PER_BYTE - (pos % BITS_PER_BYTE);
-	u8 mask_to_clear = BITMAP_FIRST_BYTE_MASK(pos);
 
-	eb_bitmap_offset(eb, start, pos, &i, &offset);
-	page = eb->pages[i];
-	assert_eb_page_uptodate(eb, page);
-	kaddr = page_address(page);
+	if (same_byte)
+		mask &= BITMAP_LAST_BYTE_MASK(pos + len);
 
-	while (len >= bits_to_clear) {
-		kaddr[offset] &= ~mask_to_clear;
-		len -= bits_to_clear;
-		bits_to_clear = BITS_PER_BYTE;
-		mask_to_clear = ~0;
-		if (++offset >= PAGE_SIZE && len > 0) {
-			offset = 0;
-			page = eb->pages[++i];
-			assert_eb_page_uptodate(eb, page);
-			kaddr = page_address(page);
-		}
-	}
-	if (len) {
-		mask_to_clear &= BITMAP_LAST_BYTE_MASK(size);
-		kaddr[offset] &= ~mask_to_clear;
-	}
+	/* Handle the first byte. */
+	kaddr = extent_buffer_get_byte(eb, first_byte);
+	*kaddr &= ~mask;
+	if (same_byte)
+		return;
+
+	/* Handle the byte aligned part. */
+	ASSERT(first_byte + 1 <= last_byte);
+	memset_extent_buffer(eb, 0, first_byte + 1, last_byte - first_byte - 1);
+
+	/* Handle the last byte. */
+	kaddr = extent_buffer_get_byte(eb, last_byte);
+	*kaddr &= ~BITMAP_LAST_BYTE_MASK(pos + len);
 }
 
 static inline bool areas_overlap(unsigned long src, unsigned long dst, unsigned long len)
-- 
2.41.0

