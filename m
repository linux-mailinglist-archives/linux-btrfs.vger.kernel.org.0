Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6758274FF80
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGLGjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 02:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGLGjV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 02:39:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EF6199E
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Jul 2023 23:38:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5480B1FED2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689143888; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oEvo/nPujCvbQSNXZJ0gGVWGN9fuFL9x9/9ShFLYjao=;
        b=LpRe7p/WjVUCMPmf0vDTqMPqNDeqf6aIJBAnDNk//WINqoNQBT/4FpYnv1IHsgGvb4RSG3
        35EpKc9CZNcEpgAFnOmg4+F68rrlnpLZLUKjHDIOpe+9F3Wn6Wx1pvAvV+dUBlXzhkqmDU
        ZQvL/UN3npr3+36mzWJm6m+dcE+GOE0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B51A4133DD
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GEyAIE9KrmRhDwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 06:38:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/6] btrfs: refactor memcpy_extent_buffer()
Date:   Wed, 12 Jul 2023 14:37:44 +0800
Message-ID: <825deca8e1421418b18d74d43088c81974f9cf69.1689143655.git.wqu@suse.com>
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
Currently memcpy_extent_buffer() goes a loop where it would stop at
any page boundary inside [dst_offset, dst_offset + len) or [src_offset,
src_offset + len).

This is mostly allowing us to go copy_pages(), but if we're going folio
we will need to handle multi-page (the old behavior) or single folio
(the new optimization).

The current code would be a burden for future changes.

[ENHANCEMENT]
Instead of sticking with copy_pages(), here we utilize
write_extent_buffer() to handle writing into the dst range.

Now we only need to handle the page boundaries inside the source range,
making later switch to folio much easier.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4e252fd7b78a..4db90ede8219 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4183,6 +4183,8 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 	struct page *page;
 	char *kaddr;
 	char *src = (char *)srcv;
+	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
+	bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 	unsigned long i = get_eb_page_index(start);
 
 	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
@@ -4194,7 +4196,8 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 
 	while (len > 0) {
 		page = eb->pages[i];
-		assert_eb_page_uptodate(eb, page);
+		if (check_uptodate)
+			assert_eb_page_uptodate(eb, page);
 
 		cur = min(len, PAGE_SIZE - offset);
 		kaddr = page_address(page);
@@ -4462,34 +4465,21 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 			  unsigned long dst_offset, unsigned long src_offset,
 			  unsigned long len)
 {
-	size_t cur;
-	size_t dst_off_in_page;
-	size_t src_off_in_page;
-	unsigned long dst_i;
-	unsigned long src_i;
+	unsigned long cur = src_offset;
 
 	if (check_eb_range(dst, dst_offset, len) ||
 	    check_eb_range(dst, src_offset, len))
 		return;
 
-	while (len > 0) {
-		dst_off_in_page = get_eb_offset_in_page(dst, dst_offset);
-		src_off_in_page = get_eb_offset_in_page(dst, src_offset);
+	while (cur < src_offset + len) {
+		int index = get_eb_page_index(cur);
+		unsigned long offset = get_eb_offset_in_page(dst, cur);
+		unsigned long cur_len = min(src_offset + len - cur, PAGE_SIZE - offset);
+		unsigned long offset_to_start = cur - src_offset;
+		void *src_addr = page_address(dst->pages[index]) + offset;
 
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
+		write_extent_buffer(dst, src_addr, dst_offset + offset_to_start, cur_len);
+		cur += cur_len;
 	}
 }
 
-- 
2.41.0

