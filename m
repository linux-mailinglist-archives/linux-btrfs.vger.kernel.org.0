Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2818B74FF7A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 08:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjGLGjo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 02:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjGLGjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 02:39:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD919B6
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 23:38:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 626421FED2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689143885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eQ7urmrQd0bOWO8Og5l0MWwuHjZ29w4ctqmXVIcr2F8=;
        b=WwyN1kmeGuVGDW5K9SOqSf7f8l5+Y0k6+nJuNMAr+eCEmLY11+x2bZKMZZLjgmE9vQfj97
        3+yQkWMZ3CImwEK2+1NTrT4+19ZemfdgLHGw+Y7WAhI18kRGmHDSJ8NJGMLj+ldxHXGGTB
        /PGaLh+j1CBQXR1yekgL2E9ZyxI31L4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2C16133DD
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cMzvI0xKrmRhDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/6] btrfs: tests: enhance extent buffer bitmap tests
Date:   Wed, 12 Jul 2023 14:37:41 +0800
Message-ID: <0d3c0f7e8f49ba720a6ab42d599c250b39477b16.1689143654.git.wqu@suse.com>
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

Enhance extent bitmap tests for the following aspects:

- Remove unnecessary @len from __test_eb_bitmaps()
  We can fetch the length from extent buffer

- Explicitly distinguish bit and byte length
  Now every start/len inside bitmap tests would have either "byte_" or
  "bit_" prefix to make it more explicit.

- Better error reporting

  If we have mismatch bits, the error report would dump the following
  contents:

  * start bytenr
  * bit number
  * the full byte from bitmap
  * the full byte from the extent

  This is to save developers time so obvious problem can be found
  immediately

- Extract bitmap set/clear and check operation into two helpers
  This is to save some code lines, as we will have more tests to do.

- Add new tests

  The following tests are added, mostly for the incoming extent bitmap
  accessor refactor:

  * Set bits inside the same byte
  * Clear bits inside the same byte
  * Cross byte boundary set
  * Cross byte boundary clear
  * Cross multi-byte boundary set
  * Cross multi-byte boundary clear

  Those new tests have already saved my backend for the incoming extent
  buffer bitmap refactor.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tests/extent-io-tests.c | 161 +++++++++++++++++++++----------
 1 file changed, 108 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index f6bc6d738555..f97f344e28ab 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -319,86 +319,138 @@ static int test_find_delalloc(u32 sectorsize)
 	return ret;
 }
 
-static int check_eb_bitmap(unsigned long *bitmap, struct extent_buffer *eb,
-			   unsigned long len)
+static int check_eb_bitmap(unsigned long *bitmap, struct extent_buffer *eb)
 {
 	unsigned long i;
 
-	for (i = 0; i < len * BITS_PER_BYTE; i++) {
+	for (i = 0; i < eb->len * BITS_PER_BYTE; i++) {
 		int bit, bit1;
 
 		bit = !!test_bit(i, bitmap);
 		bit1 = !!extent_buffer_test_bit(eb, 0, i);
 		if (bit1 != bit) {
-			test_err("bits do not match");
+			u8 has;
+			u8 expect;
+
+			read_extent_buffer(eb, &has, i / BITS_PER_BYTE, 1);
+			expect = bitmap_get_value8(bitmap, ALIGN(i, BITS_PER_BYTE));
+
+			test_err("bits not match, start byte 0 bit %lu, byte %lu has 0x%02x expect 0x%02x",
+				 i, i / BITS_PER_BYTE, has, expect);
 			return -EINVAL;
 		}
 
 		bit1 = !!extent_buffer_test_bit(eb, i / BITS_PER_BYTE,
 						i % BITS_PER_BYTE);
 		if (bit1 != bit) {
-			test_err("offset bits do not match");
+			u8 has;
+			u8 expect;
+
+			read_extent_buffer(eb, &has, i / BITS_PER_BYTE, 1);
+			expect = bitmap_get_value8(bitmap, ALIGN(i, BITS_PER_BYTE));
+
+			test_err("bits not match, start byte %lu bit %lu, byte %lu has 0x%02x expect 0x%02x",
+				 i / BITS_PER_BYTE, i % BITS_PER_BYTE,
+				 i / BITS_PER_BYTE, has, expect);
 			return -EINVAL;
 		}
 	}
 	return 0;
 }
 
-static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb,
-			     unsigned long len)
+static int test_bitmap_set(const char *name, unsigned long *bitmap,
+			   struct extent_buffer *eb,
+			   unsigned long byte_start, unsigned long bit_start,
+			   unsigned long bit_len)
+{
+	int ret;
+
+	bitmap_set(bitmap, byte_start * BITS_PER_BYTE + bit_start, bit_len);
+	extent_buffer_bitmap_set(eb, byte_start, bit_start, bit_len);
+	ret = check_eb_bitmap(bitmap, eb);
+	if (ret < 0)
+		test_err("%s test failed", name);
+	return ret;
+}
+
+static int test_bitmap_clear(const char *name, unsigned long *bitmap,
+			     struct extent_buffer *eb,
+			     unsigned long byte_start, unsigned long bit_start,
+			     unsigned long bit_len)
+{
+	int ret;
+
+	bitmap_clear(bitmap, byte_start * BITS_PER_BYTE + bit_start, bit_len);
+	extent_buffer_bitmap_clear(eb, byte_start, bit_start, bit_len);
+	ret = check_eb_bitmap(bitmap, eb);
+	if (ret < 0)
+		test_err("%s test failed", name);
+	return ret;
+}
+static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb)
 {
 	unsigned long i, j;
+	unsigned long byte_len = eb->len;
 	u32 x;
 	int ret;
 
-	memset(bitmap, 0, len);
-	memzero_extent_buffer(eb, 0, len);
-	if (memcmp_extent_buffer(eb, bitmap, 0, len) != 0) {
-		test_err("bitmap was not zeroed");
-		return -EINVAL;
-	}
-
-	bitmap_set(bitmap, 0, len * BITS_PER_BYTE);
-	extent_buffer_bitmap_set(eb, 0, 0, len * BITS_PER_BYTE);
-	ret = check_eb_bitmap(bitmap, eb, len);
-	if (ret) {
-		test_err("setting all bits failed");
+	ret = test_bitmap_clear("clear all run 1", bitmap, eb, 0, 0,
+				byte_len * BITS_PER_BYTE);
+	if (ret < 0)
 		return ret;
-	}
 
-	bitmap_clear(bitmap, 0, len * BITS_PER_BYTE);
-	extent_buffer_bitmap_clear(eb, 0, 0, len * BITS_PER_BYTE);
-	ret = check_eb_bitmap(bitmap, eb, len);
-	if (ret) {
-		test_err("clearing all bits failed");
+	ret = test_bitmap_set("set all", bitmap, eb, 0, 0,
+			      byte_len * BITS_PER_BYTE);
+	if (ret < 0)
+		return ret;
+
+	ret = test_bitmap_clear("clear all run 2", bitmap, eb, 0, 0,
+				byte_len * BITS_PER_BYTE);
+	if (ret < 0)
+		return ret;
+
+	ret = test_bitmap_set("same byte set", bitmap, eb, 0, 2, 4);
+	if (ret < 0)
+		return ret;
+
+	ret = test_bitmap_clear("same byte partial clear", bitmap, eb, 0, 4, 1);
+	if (ret < 0)
+		return ret;
+
+	ret = test_bitmap_set("cross byte set", bitmap, eb, 2, 4, 8);
+	if (ret < 0)
+		return ret;
+
+	ret = test_bitmap_set("cross multi byte set", bitmap, eb, 4, 4, 24);
+	if (ret < 0)
+		return ret;
+
+	ret = test_bitmap_clear("cross byte clear", bitmap, eb, 2, 6, 4);
+	if (ret < 0)
+		return ret;
+
+	ret = test_bitmap_clear("cross multi byte clear", bitmap, eb, 4, 6, 20);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* Straddling pages test */
-	if (len > PAGE_SIZE) {
-		bitmap_set(bitmap,
-			(PAGE_SIZE - sizeof(long) / 2) * BITS_PER_BYTE,
-			sizeof(long) * BITS_PER_BYTE);
-		extent_buffer_bitmap_set(eb, PAGE_SIZE - sizeof(long) / 2, 0,
-					sizeof(long) * BITS_PER_BYTE);
-		ret = check_eb_bitmap(bitmap, eb, len);
-		if (ret) {
-			test_err("setting straddling pages failed");
+	if (byte_len > PAGE_SIZE) {
+		ret = test_bitmap_set("cross page set", bitmap, eb,
+				      PAGE_SIZE - sizeof(long) / 2, 0,
+				      sizeof(long) * BITS_PER_BYTE);
+		if (ret < 0)
 			return ret;
-		}
 
-		bitmap_set(bitmap, 0, len * BITS_PER_BYTE);
-		bitmap_clear(bitmap,
-			(PAGE_SIZE - sizeof(long) / 2) * BITS_PER_BYTE,
-			sizeof(long) * BITS_PER_BYTE);
-		extent_buffer_bitmap_set(eb, 0, 0, len * BITS_PER_BYTE);
-		extent_buffer_bitmap_clear(eb, PAGE_SIZE - sizeof(long) / 2, 0,
-					sizeof(long) * BITS_PER_BYTE);
-		ret = check_eb_bitmap(bitmap, eb, len);
-		if (ret) {
-			test_err("clearing straddling pages failed");
+		ret = test_bitmap_set("cross page set all", bitmap, eb, 0, 0,
+				      byte_len * BITS_PER_BYTE);
+		if (ret < 0)
+			return ret;
+
+		ret = test_bitmap_clear("cross page clear", bitmap, eb,
+				PAGE_SIZE - sizeof(long) / 2, 0,
+				sizeof(long) * BITS_PER_BYTE);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	/*
@@ -406,9 +458,12 @@ static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb,
 	 * something repetitive that could miss some hypothetical off-by-n bug.
 	 */
 	x = 0;
-	bitmap_clear(bitmap, 0, len * BITS_PER_BYTE);
-	extent_buffer_bitmap_clear(eb, 0, 0, len * BITS_PER_BYTE);
-	for (i = 0; i < len * BITS_PER_BYTE / 32; i++) {
+	ret = test_bitmap_clear("clear all run 3", bitmap, eb, 0, 0,
+				byte_len * BITS_PER_BYTE);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < byte_len * BITS_PER_BYTE / 32; i++) {
 		x = (0x19660dULL * (u64)x + 0x3c6ef35fULL) & 0xffffffffU;
 		for (j = 0; j < 32; j++) {
 			if (x & (1U << j)) {
@@ -418,7 +473,7 @@ static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb,
 		}
 	}
 
-	ret = check_eb_bitmap(bitmap, eb, len);
+	ret = check_eb_bitmap(bitmap, eb);
 	if (ret) {
 		test_err("random bit pattern failed");
 		return ret;
@@ -456,7 +511,7 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	ret = __test_eb_bitmaps(bitmap, eb, nodesize);
+	ret = __test_eb_bitmaps(bitmap, eb);
 	if (ret)
 		goto out;
 
@@ -473,7 +528,7 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 		goto out;
 	}
 
-	ret = __test_eb_bitmaps(bitmap, eb, nodesize);
+	ret = __test_eb_bitmaps(bitmap, eb);
 out:
 	free_extent_buffer(eb);
 	kfree(bitmap);
-- 
2.41.0

