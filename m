Return-Path: <linux-btrfs+bounces-148-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B87B7EDB1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 06:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFE3280F9F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 05:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73503C8E7;
	Thu, 16 Nov 2023 05:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DMxL1vZ+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393818D
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Nov 2023 21:19:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4DF1204FF
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 05:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1700111964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Ux9s3EC7C0rb94NG23bXtaDDNeuJ6LWBJeK9s9WWznk=;
	b=DMxL1vZ+7b8lTT4lFvwocFNThJX7usSkYKCpueZMo0FPLWyirkNJRRrUiSGiBSfUIZF26n
	R3z3LdZ72V5oYprOphIQmfnDCBYhAdHjJpAzIORTouLHqMuSRuROQmzxQS0VA+VUf85irz
	k2GerulVAVVzONUADGc82vkDfub2YXw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12DF1138F4
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 05:19:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Cnq5MFumVWUeDAAAMHmgww
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 05:19:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: allow extent buffer helpers to skip cross-page handling
Date: Thu, 16 Nov 2023 15:49:06 +1030
Message-ID: <721bab821198fc9b49d2795b2028ed6c436ab886.1700111928.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 1.71
X-Spamd-Result: default: False [1.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.19)[-0.974];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

Currently btrfs extent buffer helpers are doing all the cross-page
handling, as there is no guarantee that all those eb pages are
contiguous.

However on systems with enough memory, there is a very high chance the
page cache for btree_inode are allocated with physically contiguous
pages.

In that case, we can skip all the complex cross-page handling, thus
speeding up the code.

This patch adds a new member, extent_buffer::addr, which is only set to
non-NULL if all the extent buffer pages are physically contiguous.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

This change would increase the code size for all extent buffer helpers,
and since there one more branch introduced, it may even slow down the
system if most ebs do not have physically contiguous pages.

But I still believe this is worthy trying, as my previous attempt to
use virtually contiguous pages are rejected due to possible slow down in
vm_map() call.

I don't have convincing benchmark yet, but so far no obvious performance
drop observed either.
---
 fs/btrfs/disk-io.c   |  9 +++++++-
 fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h |  7 ++++++
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5ac6789ca55f..7fc78171a262 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -80,8 +80,16 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 	char *kaddr;
 	int i;
 
+	memset(result, 0, BTRFS_CSUM_SIZE);
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
+
+	if (buf->addr) {
+		crypto_shash_digest(shash, buf->addr + offset_in_page(buf->start) + BTRFS_CSUM_SIZE,
+				    buf->len - BTRFS_CSUM_SIZE, result);
+		return;
+	}
+
 	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
 			    first_page_part - BTRFS_CSUM_SIZE);
@@ -90,7 +98,6 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 		kaddr = page_address(buf->pages[i]);
 		crypto_shash_update(shash, kaddr, PAGE_SIZE);
 	}
-	memset(result, 0, BTRFS_CSUM_SIZE);
 	crypto_shash_final(shash, result);
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 03cef28d9e37..004b0ba6b1c7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3476,6 +3476,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
+	bool page_contig = true;
 	int uptodate = 1;
 	int ret;
 
@@ -3562,6 +3563,14 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 		WARN_ON(btrfs_page_test_dirty(fs_info, p, eb->start, eb->len));
 		eb->pages[i] = p;
+
+		/*
+		 * Check if the current page is physically contiguous with previous eb
+		 * page.
+		 */
+		if (i && eb->pages[i - 1] + 1 != p)
+			page_contig = false;
+
 		if (!btrfs_page_test_uptodate(fs_info, p, eb->start, eb->len))
 			uptodate = 0;
 
@@ -3575,6 +3584,9 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 	if (uptodate)
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
+	/* All pages are physically contiguous, can skip cross page handling. */
+	if (page_contig)
+		eb->addr = page_address(eb->pages[0]) + offset_in_page(eb->start);
 again:
 	ret = radix_tree_preload(GFP_NOFS);
 	if (ret) {
@@ -4009,6 +4021,11 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 		return;
 	}
 
+	if (eb->addr) {
+		memcpy(dstv, eb->addr + start, len);
+		return;
+	}
+
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
@@ -4040,6 +4057,12 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 	WARN_ON(start > eb->len);
 	WARN_ON(start + len > eb->start + eb->len);
 
+	if (eb->addr) {
+		if (copy_to_user_nofault(dstv, eb->addr + start, len))
+			ret = EFAULT;
+		return ret;
+	}
+
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
@@ -4075,6 +4098,9 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	if (check_eb_range(eb, start, len))
 		return -EINVAL;
 
+	if (eb->addr)
+		return memcmp(ptrv, eb->addr + start, len);
+
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
@@ -4144,6 +4170,14 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 	if (check_eb_range(eb, start, len))
 		return;
 
+	if (eb->addr) {
+		if (use_memmove)
+			memmove(eb->addr + start, srcv, len);
+		else
+			memcpy(eb->addr + start, srcv, len);
+		return;
+	}
+
 	offset = get_eb_offset_in_page(eb, start);
 
 	while (len > 0) {
@@ -4176,6 +4210,11 @@ static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 {
 	unsigned long cur = start;
 
+	if (eb->addr) {
+		memset(eb->addr + start, c, len);
+		return;
+	}
+
 	while (cur < start + len) {
 		unsigned long index = get_eb_page_index(cur);
 		unsigned int offset = get_eb_offset_in_page(eb, cur);
@@ -4403,6 +4442,17 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 	    check_eb_range(dst, src_offset, len))
 		return;
 
+	if (dst->addr) {
+		const bool use_memmove = areas_overlap(src_offset,
+						       dst_offset, len);
+
+		if (use_memmove)
+			memmove(dst->addr + dst_offset, dst->addr + src_offset, len);
+		else
+			memcpy(dst->addr + dst_offset, dst->addr + src_offset, len);
+		return;
+	}
+
 	while (cur_off < len) {
 		unsigned long cur_src = cur_off + src_offset;
 		unsigned long pg_index = get_eb_page_index(cur_src);
@@ -4435,6 +4485,11 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 		return;
 	}
 
+	if (dst->addr) {
+		memmove(dst->addr + dst_offset, dst->addr + src_offset, len);
+		return;
+	}
+
 	while (len > 0) {
 		unsigned long src_i;
 		size_t cur;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 2171057a4477..a88374ad248f 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -77,6 +77,13 @@ struct extent_buffer {
 	unsigned long len;
 	unsigned long bflags;
 	struct btrfs_fs_info *fs_info;
+
+	/*
+	 * The address where the eb can be accessed without any cross-page handling.
+	 * This can be NULL if not possible.
+	 */
+	void *addr;
+
 	spinlock_t refs_lock;
 	atomic_t refs;
 	int read_mirror;
-- 
2.42.1


