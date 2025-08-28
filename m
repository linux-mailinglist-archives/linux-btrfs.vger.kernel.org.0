Return-Path: <linux-btrfs+bounces-16506-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FCDB3AD09
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 23:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5633B07C1
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 21:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CED2BEFFE;
	Thu, 28 Aug 2025 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a1+Pkym0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a1+Pkym0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20429ACC0
	for <linux-btrfs@vger.kernel.org>; Thu, 28 Aug 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418068; cv=none; b=frMMpwMWL1jlwhptfImco7Wtx/HAZFeyLeaMJ4B8/oZPa80T9d1NJyi2ja2OaJFKPcg1tkVKo4DK43qWrEP308eFSAbvEAoyhBw5A00XFUS/f6fSvt9n8944typjSBfg5NupRYjXmfBQnZ38rrtqpDYsfc82FZOLjX3yjNutV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418068; c=relaxed/simple;
	bh=G0AbwKg2zmNN9hJ7+x1oqPTo5jTFCQY4s6ZProlB5iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8BznYYGryzpW3XaajFrBnH/SeAwMGCjDAHIK2qz3vpPN46D9gjMtjAimQfEKX1/nM7u7N4cjT3/QwFRSaPYrBTGBM+nUpGEdagqQmOlZ7ZF0byUP6cThO9B/6bEB8pnr0ewYA696Yi0w+ygpuImMUsILZWPC3CNwI7tBeQrkBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a1+Pkym0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a1+Pkym0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F02520EFC;
	Thu, 28 Aug 2025 21:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756418064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJVdXqVWlJBDZaX64BE+wIMS7cdXnX5779dBdhBkFag=;
	b=a1+Pkym0QrY4LDInXEHJ+8o/J7Q1EtrcAAPdKO/0MbvdDgClpoSn8S/+CWGLl+4QBufxhs
	YSBPOSY8mhl/MrRevX9Ft98z1s2IhcDdecAHr3gCduRqqK6qYFm4/37mxzGq1s5AJsfPNE
	FR9qG8AGzVW2bu3p8UF/BWd/xo7uu20=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756418064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJVdXqVWlJBDZaX64BE+wIMS7cdXnX5779dBdhBkFag=;
	b=a1+Pkym0QrY4LDInXEHJ+8o/J7Q1EtrcAAPdKO/0MbvdDgClpoSn8S/+CWGLl+4QBufxhs
	YSBPOSY8mhl/MrRevX9Ft98z1s2IhcDdecAHr3gCduRqqK6qYFm4/37mxzGq1s5AJsfPNE
	FR9qG8AGzVW2bu3p8UF/BWd/xo7uu20=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47B861368B;
	Thu, 28 Aug 2025 21:54:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LbB8ERDQsGhYLwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 28 Aug 2025 21:54:24 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: use cached extent buffer folio address everywhere
Date: Thu, 28 Aug 2025 23:53:55 +0200
Message-ID: <c0a6e91d0363b0f936d364093a4330d8046f4e42.1756417687.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756417687.git.dsterba@suse.com>
References: <cover.1756417687.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80

Now that the eb folio address is cached, use it instead of calling
folio_address(). This avoids reading data from the vmemmap_base array
and using local pointers in eb that are possibly in the same or a near
cacheline.

This saves noticeable amount of .ko size (x86_64 release config):

     text	   data	    bss	    dec	    hex	filename
  1649205	 136841	  15592	1801638	 1b7da6	pre/btrfs.ko
  1639267	 136841	  15592	1791700	 1b56d4	post/btrfs.ko

  DELTA: -9938

Several core functions also have nice stack savings (selection);

  btrfs_get_16                                     -8 (16 -> 8)
  btrfs_get_32                                     -8 (24 -> 16)
  btrfs_get_64                                     -8 (24 -> 16)

Some functions have been inlined completely: btrfs_header_generation,
btrfs_header_bytenr, btrfs_header_owner, btrfs_header_level.

The use of folio_address() is hidden in all the accessors. The
translation of folio to its address involves looking up vmemmap_base,
bit shifts and dereference of page_offset_base. An example:

  3e:   4a 8b 44 d7 78          mov    0x78(%rdi,%r10,8),%rax
  43:   48 2b 05 00 00 00 00    sub    0x0(%rip),%rax        # 4a <btrfs_get_8+0x4a>
                        46: R_X86_64_PC32       vmemmap_base-0x4
  4a:   49 21 c9                and    %rcx,%r9
  4d:   48 83 c2 01             add    $0x1,%rdx
  51:   48 c1 f8 06             sar    $0x6,%rax
  55:   8b 4f 08                mov    0x8(%rdi),%ecx
  58:   48 c1 e0 0c             shl    $0xc,%rax
  5c:   48 03 05 00 00 00 00    add    0x0(%rip),%rax        # 63 <btrfs_get_8+0x63>
                        5f: R_X86_64_PC32       page_offset_base-0x4

While in the new code it's:

  44:   48 8b 77 70             mov    0x70(%rdi),%rsi
  48:   8b 4f 08                mov    0x8(%rdi),%ecx
  4b:   48 83 c2 01             add    $0x1,%rdx
  4f:   4a 03 04 d6             add    (%rsi,%r10,8),%rax

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.c | 12 ++++++------
 fs/btrfs/accessors.h |  5 ++---
 fs/btrfs/ctree.c     |  2 +-
 fs/btrfs/disk-io.c   |  6 +++---
 fs/btrfs/extent_io.c | 25 ++++++++++++-------------
 5 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 1248aa2535d306..f1b47b9b5d9d80 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -56,7 +56,7 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
 	const unsigned long oif = get_eb_offset_in_folio(eb,		\
 							 member_offset);\
-	char *kaddr = folio_address(eb->folios[idx]) + oif;		\
+	char *kaddr = eb->faddr[idx] + oif;				\
 	const int part = eb->folio_size - oif;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
@@ -70,11 +70,11 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 									\
 	if (sizeof(u##bits) == 2) {					\
 		lebytes[0] = *kaddr;					\
-		kaddr = folio_address(eb->folios[idx + 1]);		\
+		kaddr = eb->faddr[idx + 1];				\
 		lebytes[1] = *kaddr;					\
 	} else {							\
 		memcpy_split_src(lebytes, kaddr,			\
-				 folio_address(eb->folios[idx + 1]),	\
+				 eb->faddr[idx + 1],			\
 				 part, sizeof(u##bits));		\
 	}								\
 	return get_unaligned_le##bits(lebytes);				\
@@ -86,7 +86,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
 	const unsigned long oif = get_eb_offset_in_folio(eb,		\
 							 member_offset);\
-	char *kaddr = folio_address(eb->folios[idx]) + oif;		\
+	char *kaddr = eb->faddr[idx] + oif;				\
 	const int part = eb->folio_size - oif;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
@@ -102,11 +102,11 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	put_unaligned_le##bits(val, lebytes);				\
 	if (sizeof(u##bits) == 2) {					\
 		*kaddr = lebytes[0];					\
-		kaddr = folio_address(eb->folios[idx + 1]);		\
+		kaddr = eb->faddr[idx + 1];				\
 		*kaddr = lebytes[1];					\
 	} else {							\
 		memcpy(kaddr, lebytes, part);				\
-		kaddr = folio_address(eb->folios[idx + 1]);		\
+		kaddr = eb->faddr[idx + 1];				\
 		memcpy(kaddr, lebytes + part, sizeof(u##bits) - part);	\
 	}								\
 }
diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 99b3ced12805bb..bf0e82e87214dc 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -75,14 +75,13 @@ static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
 #define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
 static inline u##bits btrfs_##name(const struct extent_buffer *eb)	\
 {									\
-	const type *p = folio_address(eb->folios[0]) +			\
-			offset_in_page(eb->start);			\
+	const type *p = eb->faddr[0] + offset_in_page(eb->start);	\
 	return get_unaligned_le##bits(&p->member);			\
 }									\
 static inline void btrfs_set_##name(const struct extent_buffer *eb,	\
 				    u##bits val)			\
 {									\
-	type *p = folio_address(eb->folios[0]) + offset_in_page(eb->start); \
+	type *p = eb->faddr[0] + offset_in_page(eb->start);		\
 	put_unaligned_le##bits(val, &p->member);			\
 }
 
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6f9465d4ce54ce..1b095570747756 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -779,7 +779,7 @@ int btrfs_bin_search(const struct extent_buffer *eb, int first_slot,
 
 		if (oil + key_size <= unit_size) {
 			const unsigned long idx = get_eb_folio_index(eb, offset);
-			char *kaddr = folio_address(eb->folios[idx]);
+			char *kaddr = eb->faddr[idx];
 
 			oil = get_eb_offset_in_folio(eb, offset);
 			tmp = (struct btrfs_disk_key *)(kaddr + oil);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7b06bbc4089878..a12544c3fe62b2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -88,7 +88,7 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 		first_page_part = fs_info->nodesize;
 		num_pages = 1;
 	} else {
-		kaddr = folio_address(buf->folios[0]);
+		kaddr = buf->faddr[0];
 		first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
 		num_pages = num_extent_pages(buf);
 	}
@@ -103,7 +103,7 @@ static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 	 * crypto_shash_update() already.
 	 */
 	for (i = 1; i < num_pages && INLINE_EXTENT_BUFFER_PAGES > 1; i++) {
-		kaddr = folio_address(buf->folios[i]);
+		kaddr = buf->faddr[i];
 		crypto_shash_update(shash, kaddr, PAGE_SIZE);
 	}
 	memset(result, 0, BTRFS_CSUM_SIZE);
@@ -393,7 +393,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 	}
 
 	csum_tree_block(eb, result);
-	header_csum = folio_address(eb->folios[0]) +
+	header_csum = eb->faddr[0] +
 		get_eb_offset_in_folio(eb, offsetof(struct btrfs_header, csum));
 
 	if (memcmp(result, header_csum, csum_size) != 0) {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4c906e5ea8ac70..c14ba0009c7a93 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3508,7 +3508,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
 	/* All pages are physically contiguous, can skip cross page handling. */
 	if (page_contig)
-		eb->addr = folio_address(eb->folios[0]) + offset_in_page(eb->start);
+		eb->addr = eb->faddr[0] + offset_in_page(eb->start);
 again:
 	xa_lock_irq(&fs_info->buffer_tree);
 	existing_eb = __xa_cmpxchg(&fs_info->buffer_tree,
@@ -3968,7 +3968,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 		char *kaddr;
 
 		cur = min(len, unit_size - offset);
-		kaddr = folio_address(eb->folios[i]);
+		kaddr = eb->faddr[i];
 		memcpy(dst, kaddr + offset, cur);
 
 		dst += cur;
@@ -4004,7 +4004,7 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 		char *kaddr;
 
 		cur = min(len, unit_size - offset);
-		kaddr = folio_address(eb->folios[i]);
+		kaddr = eb->faddr[i];
 		if (copy_to_user_nofault(dst, kaddr + offset, cur)) {
 			ret = -EFAULT;
 			break;
@@ -4040,7 +4040,7 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 
 	while (len > 0) {
 		cur = min(len, unit_size - offset);
-		kaddr = folio_address(eb->folios[i]);
+		kaddr = eb->faddr[i];
 		ret = memcmp(ptr, kaddr + offset, cur);
 		if (ret)
 			break;
@@ -4119,7 +4119,7 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 			assert_eb_folio_uptodate(eb, i);
 
 		cur = min(len, unit_size - offset);
-		kaddr = folio_address(eb->folios[i]);
+		kaddr = eb->faddr[i];
 		if (use_memmove)
 			memmove(kaddr + offset, src, cur);
 		else
@@ -4155,7 +4155,7 @@ static void memset_extent_buffer(const struct extent_buffer *eb, int c,
 		unsigned int cur_len = min(start + len - cur, unit_size - offset);
 
 		assert_eb_folio_uptodate(eb, index);
-		memset(folio_address(eb->folios[index]) + offset, c, cur_len);
+		memset(eb->faddr[index] + offset, c, cur_len);
 
 		cur += cur_len;
 	}
@@ -4181,7 +4181,7 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
 		unsigned long index = get_eb_folio_index(src, cur);
 		unsigned long offset = get_eb_offset_in_folio(src, cur);
 		unsigned long cur_len = min(src->len, unit_size - offset);
-		void *addr = folio_address(src->folios[index]) + offset;
+		void *addr = src->faddr[index] + offset;
 
 		write_extent_buffer(dst, addr, cur, cur_len);
 
@@ -4214,7 +4214,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 
 		cur = min(len, (unsigned long)(unit_size - offset));
 
-		kaddr = folio_address(dst->folios[i]);
+		kaddr = dst->faddr[i];
 		read_extent_buffer(src, kaddr + offset, src_offset, cur);
 
 		src_offset += cur;
@@ -4272,7 +4272,7 @@ bool extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 
 	eb_bitmap_offset(eb, start, nr, &i, &offset);
 	assert_eb_folio_uptodate(eb, i);
-	kaddr = folio_address(eb->folios[i]);
+	kaddr = eb->faddr[i];
 	return 1U & (kaddr[offset] >> (nr & (BITS_PER_BYTE - 1)));
 }
 
@@ -4282,7 +4282,7 @@ static u8 *extent_buffer_get_byte(const struct extent_buffer *eb, unsigned long
 
 	if (check_eb_range(eb, bytenr, 1))
 		return NULL;
-	return folio_address(eb->folios[index]) + get_eb_offset_in_folio(eb, bytenr);
+	return eb->faddr[index] + get_eb_offset_in_folio(eb, bytenr);
 }
 
 /*
@@ -4390,7 +4390,7 @@ void memcpy_extent_buffer(const struct extent_buffer *dst,
 		unsigned long folio_off = get_eb_offset_in_folio(dst, cur_src);
 		unsigned long cur_len = min(src_offset + len - cur_src,
 					    unit_size - folio_off);
-		void *src_addr = folio_address(dst->folios[folio_index]) + folio_off;
+		void *src_addr = dst->faddr[folio_index] + folio_off;
 		const bool use_memmove = areas_overlap(src_offset + cur_off,
 						       dst_offset + cur_off, cur_len);
 
@@ -4437,8 +4437,7 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 		cur = min_t(unsigned long, len, src_off_in_folio + 1);
 		cur = min(cur, dst_off_in_folio + 1);
 
-		src_addr = folio_address(dst->folios[src_i]) + src_off_in_folio -
-					 cur + 1;
+		src_addr = dst->faddr[src_i] + src_off_in_folio - cur + 1;
 		use_memmove = areas_overlap(src_end - cur + 1, dst_end - cur + 1,
 					    cur);
 
-- 
2.51.0


