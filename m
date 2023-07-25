Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB2760610
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 04:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGYC5r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 22:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGYC5q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 22:57:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A98FE66
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 19:57:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 02B8B21AE4
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690253863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xVwlN+MO/BMY6RexaD50SNHQYko7SXaC1BMtrSoBCE=;
        b=Tv/yE7dv5LmBNcCU+ACh/zMWLU787Y7E2y02CZ+EBMgK1ToejJSc1plT6PGbdcdwMmMced
        AFhAt1EeQS3GiX3KvC+3v9Dw8Uoc7NaBEO5htxpx9SgyfrgIzMqaqF9Lsr5kvenMjZwOcg
        SH3o/gjeh5suWtfl+mGEE404ipko7vc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49EF013487
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:57:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QBlmBCY6v2R1JAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 02:57:42 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/2] btrfs: utilize the physically/virtually continuous extent buffer memory
Date:   Tue, 25 Jul 2023 10:57:22 +0800
Message-ID: <cf5c609a79a8f12f7ec262b62c7988ba2cfd2e3a.1690249862.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690249862.git.wqu@suse.com>
References: <cover.1690249862.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since the extent buffer pages are either physically or virtually
continuous, let's benefit from the new feature.

This involves the following changes:

- Extent buffer accessors
  Now read/write/memcpy/memmove_extent_buffer() functions are just
  a wrapper of memcpy()/memmove().

  The cross-page handling are handled by hardware MMU.

- csum_tree_block()
  We can directly go crypto_shash_digest(), as we don't need to handle
  page boundaries anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |  18 +---
 fs/btrfs/extent_io.c | 233 ++++++-------------------------------------
 fs/btrfs/extent_io.h |  10 ++
 3 files changed, 42 insertions(+), 219 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b4495d4c1533..8ca12ca2dc32 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -75,24 +75,14 @@ static void btrfs_free_csum_hash(struct btrfs_fs_info *fs_info)
 static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
-	const int num_pages = num_extent_pages(buf);
-	const int first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	char *kaddr;
-	int i;
+	void *eb_addr = btrfs_get_eb_addr(buf);
 
+	memset(result, 0, BTRFS_CSUM_SIZE);
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
-	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
-	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
-			    first_page_part - BTRFS_CSUM_SIZE);
-
-	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
-		kaddr = page_address(buf->pages[i]);
-		crypto_shash_update(shash, kaddr, PAGE_SIZE);
-	}
-	memset(result, 0, BTRFS_CSUM_SIZE);
-	crypto_shash_final(shash, result);
+	crypto_shash_digest(shash, eb_addr + BTRFS_CSUM_SIZE,
+			    buf->len - BTRFS_CSUM_SIZE, result);
 }
 
 /*
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f40d48f641c0..98077bbefc48 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4126,100 +4126,39 @@ static inline int check_eb_range(const struct extent_buffer *eb,
 void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 			unsigned long start, unsigned long len)
 {
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	char *dst = (char *)dstv;
-	unsigned long i = get_eb_page_index(start);
+	void *eb_addr = btrfs_get_eb_addr(eb);
 
 	if (check_eb_range(eb, start, len))
 		return;
 
-	offset = get_eb_offset_in_page(eb, start);
-
-	while (len > 0) {
-		page = eb->pages[i];
-
-		cur = min(len, (PAGE_SIZE - offset));
-		kaddr = page_address(page);
-		memcpy(dst, kaddr + offset, cur);
-
-		dst += cur;
-		len -= cur;
-		offset = 0;
-		i++;
-	}
+	memcpy(dstv, eb_addr + start, len);
 }
 
 int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 				       void __user *dstv,
 				       unsigned long start, unsigned long len)
 {
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	char __user *dst = (char __user *)dstv;
-	unsigned long i = get_eb_page_index(start);
-	int ret = 0;
+	void *eb_addr = btrfs_get_eb_addr(eb);
+	int ret;
 
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
-	offset = get_eb_offset_in_page(eb, start);
-
-	while (len > 0) {
-		page = eb->pages[i];
-
-		cur = min(len, (PAGE_SIZE - offset));
-		kaddr = page_address(page);
-		if (copy_to_user_nofault(dst, kaddr + offset, cur)) {
-			ret = -EFAULT;
-			break;
-		}
-
-		dst += cur;
-		len -= cur;
-		offset = 0;
-		i++;
-	}
-
-	return ret;
+	ret = copy_to_user_nofault(dstv, eb_addr + start, len);
+	if (ret)
+		return -EFAULT;
+	return 0;
 }
 
 int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len)
 {
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	char *ptr = (char *)ptrv;
-	unsigned long i = get_eb_page_index(start);
-	int ret = 0;
+	void *eb_addr = btrfs_get_eb_addr(eb);
 
 	if (check_eb_range(eb, start, len))
 		return -EINVAL;
 
-	offset = get_eb_offset_in_page(eb, start);
-
-	while (len > 0) {
-		page = eb->pages[i];
-
-		cur = min(len, (PAGE_SIZE - offset));
-
-		kaddr = page_address(page);
-		ret = memcmp(ptr, kaddr + offset, cur);
-		if (ret)
-			break;
-
-		ptr += cur;
-		len -= cur;
-		offset = 0;
-		i++;
-	}
-	return ret;
+	return memcmp(ptrv, eb_addr + start, len);
 }
 
 /*
@@ -4253,67 +4192,20 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
 	}
 }
 
-static void __write_extent_buffer(const struct extent_buffer *eb,
-				  const void *srcv, unsigned long start,
-				  unsigned long len, bool use_memmove)
-{
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	char *src = (char *)srcv;
-	unsigned long i = get_eb_page_index(start);
-	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
-	const bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
-
-	WARN_ON(test_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags));
-
-	if (check_eb_range(eb, start, len))
-		return;
-
-	offset = get_eb_offset_in_page(eb, start);
-
-	while (len > 0) {
-		page = eb->pages[i];
-		if (check_uptodate)
-			assert_eb_page_uptodate(eb, page);
-
-		cur = min(len, PAGE_SIZE - offset);
-		kaddr = page_address(page);
-		if (use_memmove)
-			memmove(kaddr + offset, src, cur);
-		else
-			memcpy(kaddr + offset, src, cur);
-
-		src += cur;
-		len -= cur;
-		offset = 0;
-		i++;
-	}
-}
-
 void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 			 unsigned long start, unsigned long len)
 {
-	return __write_extent_buffer(eb, srcv, start, len, false);
+	void *eb_addr = btrfs_get_eb_addr(eb);
+
+	memcpy(eb_addr + start, srcv, len);
 }
 
 static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 				 unsigned long start, unsigned long len)
 {
-	unsigned long cur = start;
+	void *eb_addr = btrfs_get_eb_addr(eb);
 
-	while (cur < start + len) {
-		unsigned long index = get_eb_page_index(cur);
-		unsigned int offset = get_eb_offset_in_page(eb, cur);
-		unsigned int cur_len = min(start + len - cur, PAGE_SIZE - offset);
-		struct page *page = eb->pages[index];
-
-		assert_eb_page_uptodate(eb, page);
-		memset(page_address(page) + offset, c, cur_len);
-
-		cur += cur_len;
-	}
+	memset(eb_addr + start, c, len);
 }
 
 void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
@@ -4327,20 +4219,12 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 void copy_extent_buffer_full(const struct extent_buffer *dst,
 			     const struct extent_buffer *src)
 {
-	unsigned long cur = 0;
+	void *dst_addr = btrfs_get_eb_addr(dst);
+	void *src_addr = btrfs_get_eb_addr(src);
 
 	ASSERT(dst->len == src->len);
 
-	while (cur < src->len) {
-		unsigned long index = get_eb_page_index(cur);
-		unsigned long offset = get_eb_offset_in_page(src, cur);
-		unsigned long cur_len = min(src->len, PAGE_SIZE - offset);
-		void *addr = page_address(src->pages[index]) + offset;
-
-		write_extent_buffer(dst, addr, cur, cur_len);
-
-		cur += cur_len;
-	}
+	memcpy(dst_addr, src_addr, dst->len);
 }
 
 void copy_extent_buffer(const struct extent_buffer *dst,
@@ -4349,11 +4233,8 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 			unsigned long len)
 {
 	u64 dst_len = dst->len;
-	size_t cur;
-	size_t offset;
-	struct page *page;
-	char *kaddr;
-	unsigned long i = get_eb_page_index(dst_offset);
+	void *dst_addr = btrfs_get_eb_addr(dst);
+	void *src_addr = btrfs_get_eb_addr(src);
 
 	if (check_eb_range(dst, dst_offset, len) ||
 	    check_eb_range(src, src_offset, len))
@@ -4361,22 +4242,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 
 	WARN_ON(src->len != dst_len);
 
-	offset = get_eb_offset_in_page(dst, dst_offset);
-
-	while (len > 0) {
-		page = dst->pages[i];
-		assert_eb_page_uptodate(dst, page);
-
-		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
-
-		kaddr = page_address(page);
-		read_extent_buffer(src, kaddr + offset, src_offset, cur);
-
-		src_offset += cur;
-		len -= cur;
-		offset = 0;
-		i++;
-	}
+	memcpy(dst_addr + dst_offset, src_addr + src_offset, len);
 }
 
 /*
@@ -4524,72 +4390,29 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 			  unsigned long dst_offset, unsigned long src_offset,
 			  unsigned long len)
 {
-	unsigned long cur_off = 0;
+	void *eb_addr = btrfs_get_eb_addr(dst);
 
 	if (check_eb_range(dst, dst_offset, len) ||
 	    check_eb_range(dst, src_offset, len))
 		return;
 
-	while (cur_off < len) {
-		unsigned long cur_src = cur_off + src_offset;
-		unsigned long pg_index = get_eb_page_index(cur_src);
-		unsigned long pg_off = get_eb_offset_in_page(dst, cur_src);
-		unsigned long cur_len = min(src_offset + len - cur_src,
-					    PAGE_SIZE - pg_off);
-		void *src_addr = page_address(dst->pages[pg_index]) + pg_off;
-		const bool use_memmove = areas_overlap(src_offset + cur_off,
-						       dst_offset + cur_off, cur_len);
-
-		__write_extent_buffer(dst, src_addr, dst_offset + cur_off, cur_len,
-				      use_memmove);
-		cur_off += cur_len;
-	}
+	if (areas_overlap(dst_offset, src_offset, len))
+		memmove(eb_addr + dst_offset, eb_addr + src_offset, len);
+	else
+		memcpy(eb_addr + dst_offset, eb_addr + src_offset, len);
 }
 
 void memmove_extent_buffer(const struct extent_buffer *dst,
 			   unsigned long dst_offset, unsigned long src_offset,
 			   unsigned long len)
 {
-	unsigned long dst_end = dst_offset + len - 1;
-	unsigned long src_end = src_offset + len - 1;
+	void *eb_addr = btrfs_get_eb_addr(dst);
 
 	if (check_eb_range(dst, dst_offset, len) ||
 	    check_eb_range(dst, src_offset, len))
 		return;
 
-	if (dst_offset < src_offset) {
-		memcpy_extent_buffer(dst, dst_offset, src_offset, len);
-		return;
-	}
-
-	while (len > 0) {
-		unsigned long src_i;
-		size_t cur;
-		size_t dst_off_in_page;
-		size_t src_off_in_page;
-		void *src_addr;
-		bool use_memmove;
-
-		src_i = get_eb_page_index(src_end);
-
-		dst_off_in_page = get_eb_offset_in_page(dst, dst_end);
-		src_off_in_page = get_eb_offset_in_page(dst, src_end);
-
-		cur = min_t(unsigned long, len, src_off_in_page + 1);
-		cur = min(cur, dst_off_in_page + 1);
-
-		src_addr = page_address(dst->pages[src_i]) + src_off_in_page -
-			   cur + 1;
-		use_memmove = areas_overlap(src_end - cur + 1, dst_end - cur + 1,
-					    cur);
-
-		__write_extent_buffer(dst, src_addr, dst_end - cur + 1, cur,
-				      use_memmove);
-
-		dst_end -= cur;
-		src_end -= cur;
-		len -= cur;
-	}
+	memmove(eb_addr + dst_offset, eb_addr + src_offset, len);
 }
 
 #define GANG_LOOKUP_SIZE	16
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index f1505c3a05cc..f97707829ee5 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -134,6 +134,16 @@ static inline unsigned long get_eb_page_index(unsigned long offset)
 	return offset >> PAGE_SHIFT;
 }
 
+static inline void *btrfs_get_eb_addr(const struct extent_buffer *eb)
+{
+	/* For fallback vmapped extent buffer. */
+	if (eb->vaddr)
+		return eb->vaddr;
+
+	/* For physically continuous pages and subpage cases. */
+	return page_address(eb->pages[0]) + offset_in_page(eb->start);
+}
+
 /*
  * Structure to record how many bytes and which ranges are set/cleared
  */
-- 
2.41.0

