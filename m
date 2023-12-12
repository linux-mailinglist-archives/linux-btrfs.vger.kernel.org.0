Return-Path: <linux-btrfs+bounces-832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA180E1E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 03:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB201C21770
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Dec 2023 02:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD493B654;
	Tue, 12 Dec 2023 02:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iSij7eZa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iSij7eZa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0738111
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Dec 2023 18:29:00 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 773122230E
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702348139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hUm3osjwieKBkujsOltOHRfdiIRWin0t7jgthoX/aU=;
	b=iSij7eZaCrVjw7Xw4VicBVyVJRsjr960XCjBApfQ7HrYHWvY0MThzQdpaUMUaCoTOtsOX0
	ywf5+gBAPGbnZJxjdG27+96VsLBSKaMg5jJLWHw76gnCygz6k5C37EfhZlLsWRjtV2mQ3X
	czvKAs0RepjrHKDYFsu7Cr3A3sRcFjw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1702348139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hUm3osjwieKBkujsOltOHRfdiIRWin0t7jgthoX/aU=;
	b=iSij7eZaCrVjw7Xw4VicBVyVJRsjr960XCjBApfQ7HrYHWvY0MThzQdpaUMUaCoTOtsOX0
	ywf5+gBAPGbnZJxjdG27+96VsLBSKaMg5jJLWHw76gnCygz6k5C37EfhZlLsWRjtV2mQ3X
	czvKAs0RepjrHKDYFsu7Cr3A3sRcFjw=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C34D13463
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:28:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QG60BmrFd2WtHQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Dec 2023 02:28:58 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs: migrate get_eb_page_index() and get_eb_offset_in_page() to folios
Date: Tue, 12 Dec 2023 12:58:36 +1030
Message-ID: <252dc97900df5a9a15f46f802830e156dc9e544c.1702347666.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702347666.git.wqu@suse.com>
References: <cover.1702347666.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *******************
X-Spam-Score: 19.09
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=iSij7eZa;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=fail (smtp-out1.suse.de: domain of wqu@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=wqu@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-7.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DMARC_POLICY_ALLOW(0.00)[suse.com,quarantine];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[99.99%];
	 ARC_NA(0.00)[];
	 R_SPF_FAIL(0.00)[-all];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 WHITELIST_DMARC(-7.00)[suse.com:D:+];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -7.01
X-Rspamd-Queue-Id: 773122230E
X-Spam-Flag: NO

These two functions are still using the old page based code, which is
not going to handle larger folios at all.

The migration itself is going to involve the following changes:

- PAGE_SIZE -> folio_size()
- PAGE_SHIFT -> folio_shift()
- get_eb_page_index() -> get_eb_folio_index()
- get_eb_offset_in_page() -> get_eb_offset_in_folio()

And since we're going to support larger folios, although above straight
convert is good enough, this patch would add extra comments in the
involved functions to explain why the same single line code can now
cover 3 cases:

- folio_size == PAGE_SIZE, sectorsize == PAGE_SIZE, nodesize >= PAGE_SIZE
  The common, non-subpage case with per-page folio.

- folio_size > PAGE_SIZE, sectorsize == PAGE_SIZE, nodesize >= PAGE_SIZE
  The incoming larger folio, non-subpage case.

- folio_size == PAGE_SIZE, sectorsize < PAGE_SIZE, nodesize < PAGE_SIZE
  The existing subpage case, we won't larger folio anyway.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/accessors.c |  80 +++++++++++++++------------
 fs/btrfs/ctree.c     |  13 ++---
 fs/btrfs/disk-io.c   |   2 +-
 fs/btrfs/extent_io.c | 126 ++++++++++++++++++++++---------------------
 fs/btrfs/extent_io.h |  40 +++++++++-----
 5 files changed, 145 insertions(+), 116 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 8f7cbb7154d4..3b3fcd2477a8 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -59,29 +59,32 @@ void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *e
 u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 			       const void *ptr, unsigned long off)	\
 {									\
+	struct extent_buffer *eb = token->eb;				\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long idx = get_eb_page_index(member_offset);	\
-	const unsigned long oip = get_eb_offset_in_page(token->eb,	\
-							member_offset);	\
+	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
+	const unsigned long oil = get_eb_offset_in_folio(eb,		\
+							 member_offset);\
+	const int unit_size = folio_size(eb->folios[0]);		\
+	const int unit_shift = folio_shift(eb->folios[0]);		\
 	const int size = sizeof(u##bits);				\
 	u8 lebytes[sizeof(u##bits)];					\
-	const int part = PAGE_SIZE - oip;				\
+	const int part = unit_size - oil;				\
 									\
 	ASSERT(token);							\
 	ASSERT(token->kaddr);						\
 	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
 	if (token->offset <= member_offset &&				\
-	    member_offset + size <= token->offset + PAGE_SIZE) {	\
-		return get_unaligned_le##bits(token->kaddr + oip);	\
+	    member_offset + size <= token->offset + unit_size) {	\
+		return get_unaligned_le##bits(token->kaddr + oil);	\
 	}								\
 	token->kaddr = folio_address(token->eb->folios[idx]);		\
-	token->offset = idx << PAGE_SHIFT;				\
-	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE ) \
-		return get_unaligned_le##bits(token->kaddr + oip);	\
+	token->offset = idx << unit_shift;				\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oil + size <= unit_size) \
+		return get_unaligned_le##bits(token->kaddr + oil);	\
 									\
-	memcpy(lebytes, token->kaddr + oip, part);			\
+	memcpy(lebytes, token->kaddr + oil, part);			\
 	token->kaddr = folio_address(token->eb->folios[idx + 1]);	\
-	token->offset = (idx + 1) << PAGE_SHIFT;			\
+	token->offset = (idx + 1) << unit_shift;			\
 	memcpy(lebytes + part, token->kaddr, size - part);		\
 	return get_unaligned_le##bits(lebytes);				\
 }									\
@@ -89,18 +92,20 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off)		\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long oip = get_eb_offset_in_page(eb, member_offset); \
-	const unsigned long idx = get_eb_page_index(member_offset);	\
+	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
+	const unsigned long oil = get_eb_offset_in_folio(eb,		\
+							 member_offset);\
+	const int unit_size = folio_size(eb->folios[0]);		\
 	char *kaddr = folio_address(eb->folios[idx]);			\
 	const int size = sizeof(u##bits);				\
-	const int part = PAGE_SIZE - oip;				\
+	const int part = unit_size - oil;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
-	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE)	\
-		return get_unaligned_le##bits(kaddr + oip);		\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oil + size <= unit_size)	\
+		return get_unaligned_le##bits(kaddr + oil);		\
 									\
-	memcpy(lebytes, kaddr + oip, part);				\
+	memcpy(lebytes, kaddr + oil, part);				\
 	kaddr = folio_address(eb->folios[idx + 1]);			\
 	memcpy(lebytes + part, kaddr, size - part);			\
 	return get_unaligned_le##bits(lebytes);				\
@@ -109,53 +114,60 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 			    const void *ptr, unsigned long off,		\
 			    u##bits val)				\
 {									\
+	struct extent_buffer *eb = token->eb;				\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long idx = get_eb_page_index(member_offset);	\
-	const unsigned long oip = get_eb_offset_in_page(token->eb,	\
-							member_offset);	\
+	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
+	const unsigned long oil = get_eb_offset_in_folio(eb,		\
+							 member_offset);\
+	const int unit_size = folio_size(eb->folios[0]);		\
+	const int unit_shift = folio_shift(eb->folios[0]);		\
 	const int size = sizeof(u##bits);				\
 	u8 lebytes[sizeof(u##bits)];					\
-	const int part = PAGE_SIZE - oip;				\
+	const int part = unit_size - oil;				\
 									\
 	ASSERT(token);							\
 	ASSERT(token->kaddr);						\
 	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
 	if (token->offset <= member_offset &&				\
-	    member_offset + size <= token->offset + PAGE_SIZE) {	\
-		put_unaligned_le##bits(val, token->kaddr + oip);	\
+	    member_offset + size <= token->offset + unit_size) {	\
+		put_unaligned_le##bits(val, token->kaddr + oil);	\
 		return;							\
 	}								\
 	token->kaddr = folio_address(token->eb->folios[idx]);		\
-	token->offset = idx << PAGE_SHIFT;				\
-	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE) { \
-		put_unaligned_le##bits(val, token->kaddr + oip);	\
+	token->offset = idx << unit_shift;				\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 ||				\
+	    oil + size <= unit_size) {					\
+		put_unaligned_le##bits(val, token->kaddr + oil);	\
 		return;							\
 	}								\
 	put_unaligned_le##bits(val, lebytes);				\
-	memcpy(token->kaddr + oip, lebytes, part);			\
+	memcpy(token->kaddr + oil, lebytes, part);			\
 	token->kaddr = folio_address(token->eb->folios[idx + 1]);	\
-	token->offset = (idx + 1) << PAGE_SHIFT;			\
+	token->offset = (idx + 1) << unit_shift;			\
 	memcpy(token->kaddr, lebytes + part, size - part);		\
 }									\
 void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 		      unsigned long off, u##bits val)			\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long oip = get_eb_offset_in_page(eb, member_offset); \
-	const unsigned long idx = get_eb_page_index(member_offset);	\
+	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
+	const unsigned long oil = get_eb_offset_in_folio(eb,		\
+							 member_offset);\
+	const int unit_size = folio_size(eb->folios[0]);		\
 	char *kaddr = folio_address(eb->folios[idx]);			\
 	const int size = sizeof(u##bits);				\
-	const int part = PAGE_SIZE - oip;				\
+	const int part = unit_size - oil;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
-	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE) { \
-		put_unaligned_le##bits(val, kaddr + oip);		\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1 ||				\
+	    oil + size <= unit_size) {					\
+		put_unaligned_le##bits(val, kaddr + oil);		\
 		return;							\
 	}								\
 									\
 	put_unaligned_le##bits(val, lebytes);				\
-	memcpy(kaddr + oip, lebytes, part);				\
+	memcpy(kaddr + oil, lebytes, part);				\
 	kaddr = folio_address(eb->folios[idx + 1]);			\
 	memcpy(kaddr, lebytes + part, size - part);			\
 }
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e6c535cf3749..e65e012bac55 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -820,7 +820,8 @@ int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
 	}
 
 	while (low < high) {
-		unsigned long oip;
+		const int unit_size = folio_size(eb->folios[0]);
+		unsigned long oil;
 		unsigned long offset;
 		struct btrfs_disk_key *tmp;
 		struct btrfs_disk_key unaligned;
@@ -828,14 +829,14 @@ int btrfs_bin_search(struct extent_buffer *eb, int first_slot,
 
 		mid = (low + high) / 2;
 		offset = p + mid * item_size;
-		oip = offset_in_page(offset);
+		oil = get_eb_offset_in_folio(eb, offset);
 
-		if (oip + key_size <= PAGE_SIZE) {
-			const unsigned long idx = get_eb_page_index(offset);
+		if (oil + key_size <= unit_size) {
+			const unsigned long idx = get_eb_folio_index(eb, offset);
 			char *kaddr = folio_address(eb->folios[idx]);
 
-			oip = get_eb_offset_in_page(eb, offset);
-			tmp = (struct btrfs_disk_key *)(kaddr + oip);
+			oil = get_eb_offset_in_folio(eb, offset);
+			tmp = (struct btrfs_disk_key *)(kaddr + oil);
 		} else {
 			read_extent_buffer(eb, &unaligned, offset, key_size);
 			tmp = &unaligned;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a5ace9f6e790..05f797cf3b63 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -395,7 +395,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 
 	csum_tree_block(eb, result);
 	header_csum = folio_address(eb->folios[0]) +
-		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, csum));
+		get_eb_offset_in_folio(eb, offsetof(struct btrfs_header, csum));
 
 	if (memcmp(result, header_csum, csum_size) != 0) {
 		btrfs_warn_rl(fs_info,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c8b14ba362f6..299466602588 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4172,12 +4172,11 @@ static inline int check_eb_range(const struct extent_buffer *eb,
 void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 			unsigned long start, unsigned long len)
 {
+	const int unit_size = folio_size(eb->folios[0]);
 	size_t cur;
 	size_t offset;
-	struct page *page;
-	char *kaddr;
 	char *dst = (char *)dstv;
-	unsigned long i = get_eb_page_index(start);
+	unsigned long i = get_eb_folio_index(eb, start);
 
 	if (check_eb_range(eb, start, len)) {
 		/*
@@ -4193,13 +4192,13 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 		return;
 	}
 
-	offset = get_eb_offset_in_page(eb, start);
+	offset = get_eb_offset_in_folio(eb, start);
 
 	while (len > 0) {
-		page = folio_page(eb->folios[i], 0);
+		char *kaddr;
 
-		cur = min(len, (PAGE_SIZE - offset));
-		kaddr = page_address(page);
+		cur = min(len, unit_size - offset);
+		kaddr = folio_address(eb->folios[i]);
 		memcpy(dst, kaddr + offset, cur);
 
 		dst += cur;
@@ -4213,12 +4212,11 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 				       void __user *dstv,
 				       unsigned long start, unsigned long len)
 {
+	const int unit_size = folio_size(eb->folios[0]);
 	size_t cur;
 	size_t offset;
-	struct page *page;
-	char *kaddr;
 	char __user *dst = (char __user *)dstv;
-	unsigned long i = get_eb_page_index(start);
+	unsigned long i = get_eb_folio_index(eb, start);
 	int ret = 0;
 
 	WARN_ON(start > eb->len);
@@ -4230,13 +4228,13 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 		return ret;
 	}
 
-	offset = get_eb_offset_in_page(eb, start);
+	offset = get_eb_offset_in_folio(eb, start);
 
 	while (len > 0) {
-		page = folio_page(eb->folios[i], 0);
+		char *kaddr;
 
-		cur = min(len, (PAGE_SIZE - offset));
-		kaddr = page_address(page);
+		cur = min(len, unit_size - offset);
+		kaddr = folio_address(eb->folios[i]);
 		if (copy_to_user_nofault(dst, kaddr + offset, cur)) {
 			ret = -EFAULT;
 			break;
@@ -4254,12 +4252,12 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 			 unsigned long start, unsigned long len)
 {
+	const int unit_size = folio_size(eb->folios[0]);
 	size_t cur;
 	size_t offset;
-	struct page *page;
 	char *kaddr;
 	char *ptr = (char *)ptrv;
-	unsigned long i = get_eb_page_index(start);
+	unsigned long i = get_eb_folio_index(eb, start);
 	int ret = 0;
 
 	if (check_eb_range(eb, start, len))
@@ -4268,14 +4266,12 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	if (eb->addr)
 		return memcmp(ptrv, eb->addr + start, len);
 
-	offset = get_eb_offset_in_page(eb, start);
+	offset = get_eb_offset_in_folio(eb, start);
 
 	while (len > 0) {
-		page = folio_page(eb->folios[i], 0);
+		cur = min(len, unit_size - offset);
 
-		cur = min(len, (PAGE_SIZE - offset));
-
-		kaddr = page_address(page);
+		kaddr = folio_address(eb->folios[i]);
 		ret = memcmp(ptr, kaddr + offset, cur);
 		if (ret)
 			break;
@@ -4294,10 +4290,12 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
  * For regular sector size == PAGE_SIZE case, check if @page is uptodate.
  * For subpage case, check if the range covered by the eb has EXTENT_UPTODATE.
  */
-static void assert_eb_page_uptodate(const struct extent_buffer *eb,
-				    struct page *page)
+static void assert_eb_folio_uptodate(const struct extent_buffer *eb, int i)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
+	struct folio *folio = eb->folios[i];
+
+	ASSERT(folio);
 
 	/*
 	 * If we are using the commit root we could potentially clear a page
@@ -4311,11 +4309,13 @@ static void assert_eb_page_uptodate(const struct extent_buffer *eb,
 		return;
 
 	if (fs_info->nodesize < PAGE_SIZE) {
+		struct page *page = folio_page(folio, 0);
+
 		if (WARN_ON(!btrfs_subpage_test_uptodate(fs_info, page,
 							 eb->start, eb->len)))
 			btrfs_subpage_dump_bitmap(fs_info, page, eb->start, eb->len);
 	} else {
-		WARN_ON(!PageUptodate(page));
+		WARN_ON(!folio_test_uptodate(folio));
 	}
 }
 
@@ -4323,12 +4323,12 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 				  const void *srcv, unsigned long start,
 				  unsigned long len, bool use_memmove)
 {
+	const int unit_size = folio_size(eb->folios[0]);
 	size_t cur;
 	size_t offset;
-	struct page *page;
 	char *kaddr;
 	char *src = (char *)srcv;
-	unsigned long i = get_eb_page_index(start);
+	unsigned long i = get_eb_folio_index(eb, start);
 	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
 	const bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
@@ -4343,15 +4343,14 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 		return;
 	}
 
-	offset = get_eb_offset_in_page(eb, start);
+	offset = get_eb_offset_in_folio(eb, start);
 
 	while (len > 0) {
-		page = folio_page(eb->folios[i], 0);
 		if (check_uptodate)
-			assert_eb_page_uptodate(eb, page);
+			assert_eb_folio_uptodate(eb, i);
 
-		cur = min(len, PAGE_SIZE - offset);
-		kaddr = page_address(page);
+		cur = min(len, unit_size - offset);
+		kaddr = folio_address(eb->folios[i]);
 		if (use_memmove)
 			memmove(kaddr + offset, src, cur);
 		else
@@ -4373,6 +4372,7 @@ void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
 static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 				 unsigned long start, unsigned long len)
 {
+	const int unit_size = folio_size(eb->folios[0]);
 	unsigned long cur = start;
 
 	if (eb->addr) {
@@ -4381,13 +4381,13 @@ static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 	}
 
 	while (cur < start + len) {
-		unsigned long index = get_eb_page_index(cur);
-		unsigned int offset = get_eb_offset_in_page(eb, cur);
-		unsigned int cur_len = min(start + len - cur, PAGE_SIZE - offset);
-		struct page *page = folio_page(eb->folios[index], 0);
+		unsigned long index = get_eb_folio_index(eb, cur);
+		unsigned int offset = get_eb_offset_in_folio(eb, cur);
+		unsigned int cur_len = min(start + len - cur,
+					   unit_size - offset);
 
-		assert_eb_page_uptodate(eb, page);
-		memset_page(page, offset, c, cur_len);
+		assert_eb_folio_uptodate(eb, index);
+		memset(folio_address(eb->folios[index]) + offset, c, cur_len);
 
 		cur += cur_len;
 	}
@@ -4404,14 +4404,15 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 void copy_extent_buffer_full(const struct extent_buffer *dst,
 			     const struct extent_buffer *src)
 {
+	const int unit_size = folio_size(src->folios[0]);
 	unsigned long cur = 0;
 
 	ASSERT(dst->len == src->len);
 
 	while (cur < src->len) {
-		unsigned long index = get_eb_page_index(cur);
-		unsigned long offset = get_eb_offset_in_page(src, cur);
-		unsigned long cur_len = min(src->len, PAGE_SIZE - offset);
+		unsigned long index = get_eb_folio_index(src, cur);
+		unsigned long offset = get_eb_offset_in_folio(src, cur);
+		unsigned long cur_len = min(src->len, unit_size - offset);
 		void *addr = folio_address(src->folios[index]) + offset;
 
 		write_extent_buffer(dst, addr, cur, cur_len);
@@ -4425,12 +4426,12 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 			unsigned long dst_offset, unsigned long src_offset,
 			unsigned long len)
 {
+	const int unit_size = folio_size(dst->folios[0]);
 	u64 dst_len = dst->len;
 	size_t cur;
 	size_t offset;
-	struct page *page;
 	char *kaddr;
-	unsigned long i = get_eb_page_index(dst_offset);
+	unsigned long i = get_eb_folio_index(dst, dst_offset);
 
 	if (check_eb_range(dst, dst_offset, len) ||
 	    check_eb_range(src, src_offset, len))
@@ -4438,15 +4439,14 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 
 	WARN_ON(src->len != dst_len);
 
-	offset = get_eb_offset_in_page(dst, dst_offset);
+	offset = get_eb_offset_in_folio(dst, dst_offset);
 
 	while (len > 0) {
-		page = folio_page(dst->folios[i], 0);
-		assert_eb_page_uptodate(dst, page);
+		assert_eb_folio_uptodate(dst, i);
 
-		cur = min(len, (unsigned long)(PAGE_SIZE - offset));
+		cur = min(len, (unsigned long)(unit_size - offset));
 
-		kaddr = page_address(page);
+		kaddr = folio_address(dst->folios[i]);
 		read_extent_buffer(src, kaddr + offset, src_offset, cur);
 
 		src_offset += cur;
@@ -4505,18 +4505,18 @@ int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 
 	eb_bitmap_offset(eb, start, nr, &i, &offset);
 	page = folio_page(eb->folios[i], 0);
-	assert_eb_page_uptodate(eb, page);
+	assert_eb_folio_uptodate(eb, i);
 	kaddr = page_address(page);
 	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
 }
 
 static u8 *extent_buffer_get_byte(const struct extent_buffer *eb, unsigned long bytenr)
 {
-	unsigned long index = get_eb_page_index(bytenr);
+	unsigned long index = get_eb_folio_index(eb, bytenr);
 
 	if (check_eb_range(eb, bytenr, 1))
 		return NULL;
-	return folio_address(eb->folios[index]) + get_eb_offset_in_page(eb, bytenr);
+	return folio_address(eb->folios[index]) + get_eb_offset_in_folio(eb, bytenr);
 }
 
 /*
@@ -4601,6 +4601,7 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 			  unsigned long dst_offset, unsigned long src_offset,
 			  unsigned long len)
 {
+	const int unit_size = folio_size(dst->folios[0]);
 	unsigned long cur_off = 0;
 
 	if (check_eb_range(dst, dst_offset, len) ||
@@ -4619,11 +4620,12 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 
 	while (cur_off < len) {
 		unsigned long cur_src = cur_off + src_offset;
-		unsigned long pg_index = get_eb_page_index(cur_src);
-		unsigned long pg_off = get_eb_offset_in_page(dst, cur_src);
+		unsigned long folio_index = get_eb_folio_index(dst, cur_src);
+		unsigned long folio_off = get_eb_offset_in_folio(dst, cur_src);
 		unsigned long cur_len = min(src_offset + len - cur_src,
-					    PAGE_SIZE - pg_off);
-		void *src_addr = folio_address(dst->folios[pg_index]) + pg_off;
+					    unit_size - folio_off);
+		void *src_addr = folio_address(dst->folios[folio_index]) +
+				 folio_off;
 		const bool use_memmove = areas_overlap(src_offset + cur_off,
 						       dst_offset + cur_off, cur_len);
 
@@ -4657,20 +4659,20 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 	while (len > 0) {
 		unsigned long src_i;
 		size_t cur;
-		size_t dst_off_in_page;
-		size_t src_off_in_page;
+		size_t dst_off_in_folio;
+		size_t src_off_in_folio;
 		void *src_addr;
 		bool use_memmove;
 
-		src_i = get_eb_page_index(src_end);
+		src_i = get_eb_folio_index(dst, src_end);
 
-		dst_off_in_page = get_eb_offset_in_page(dst, dst_end);
-		src_off_in_page = get_eb_offset_in_page(dst, src_end);
+		dst_off_in_folio = get_eb_offset_in_folio(dst, dst_end);
+		src_off_in_folio = get_eb_offset_in_folio(dst, src_end);
 
-		cur = min_t(unsigned long, len, src_off_in_page + 1);
-		cur = min(cur, dst_off_in_page + 1);
+		cur = min_t(unsigned long, len, src_off_in_folio + 1);
+		cur = min(cur, dst_off_in_folio + 1);
 
-		src_addr = folio_address(dst->folios[src_i]) + src_off_in_page -
+		src_addr = folio_address(dst->folios[src_i]) + src_off_in_folio -
 					 cur + 1;
 		use_memmove = areas_overlap(src_end - cur + 1, dst_end - cur + 1,
 					    cur);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a5fd5cb20a3c..46050500529b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -121,29 +121,43 @@ struct btrfs_eb_write_context {
  *
  * Will handle both sectorsize == PAGE_SIZE and sectorsize < PAGE_SIZE cases.
  */
-static inline size_t get_eb_offset_in_page(const struct extent_buffer *eb,
-					   unsigned long offset)
+static inline size_t get_eb_offset_in_folio(const struct extent_buffer *eb,
+					    unsigned long offset)
 {
 	/*
-	 * For sectorsize == PAGE_SIZE case, eb->start will always be aligned
-	 * to PAGE_SIZE, thus adding it won't cause any difference.
+	 * 1) sectorsize == PAGE_SIZE and nodesize >= PAGE_SIZE case
+	 *    1.1) One large folio covering the whole eb
+	 *	   The eb->start is aligned to folio size, thus adding it
+	 *	   won't cause any difference.
+	 *    1.2) Several page sized folios
+	 *	   The eb->start is aligned to folio (page) size, thus
+	 *	   adding it won't cause any difference.
 	 *
-	 * For sectorsize < PAGE_SIZE, we must only read the data that belongs
-	 * to the eb, thus we have to take the eb->start into consideration.
+	 * 2) sectorsize < PAGE_SIZE and nodesize < PAGE_SIZE case
+	 *    In this case there would only be one page sized folio, and there
+	 *    may be several different extent buffers in the page/folio.
+	 *    We need to add eb->start to properly access the offset inside
+	 *    that eb.
 	 */
-	return offset_in_page(offset + eb->start);
+	return offset_in_folio(eb->folios[0], offset + eb->start);
 }
 
-static inline unsigned long get_eb_page_index(unsigned long offset)
+static inline unsigned long get_eb_folio_index(const struct extent_buffer *eb,
+					       unsigned long offset)
 {
 	/*
-	 * For sectorsize == PAGE_SIZE case, plain >> PAGE_SHIFT is enough.
+	 * 1) sectorsize == PAGE_SIZE and nodesize >= PAGE_SIZE case
+	 *    1.1) One large folio covering the whole eb.
+	 *	   the folio_shift would be large enough to always make us
+	 *	   return 0 as index.
+	 *    1.2) Several page sized folios
+	 *         The folio_shift() would be PAGE_SHIFT, giving us the correct
+	 *         index.
 	 *
-	 * For sectorsize < PAGE_SIZE case, we only support 64K PAGE_SIZE,
-	 * and have ensured that all tree blocks are contained in one page,
-	 * thus we always get index == 0.
+	 * 2) sectorsize < PAGE_SIZE and nodesize < PAGE_SIZE case
+	 *    The folio would only be page sized, and always give us 0 as index.
 	 */
-	return offset >> PAGE_SHIFT;
+	return offset >> folio_shift(eb->folios[0]);
 }
 
 /*
-- 
2.43.0


