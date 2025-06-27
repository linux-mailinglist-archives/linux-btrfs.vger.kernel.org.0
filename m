Return-Path: <linux-btrfs+bounces-15053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1229AEB96E
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 16:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFEE64200B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01D42DCC0D;
	Fri, 27 Jun 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P7lmEYdp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P7lmEYdp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308A2DBF74
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033053; cv=none; b=DVxxu5jhGeBQM/zANQ8gwEOjeKGgUA3udgogYVG4Zdd/O8DqCUK0CU1QiRdAbJQ40znnAdGfOKneDST5pIiK7ENxyDo1F46KbumICVZR4iflNYyws+XyuC07GO+48s0aF//Gt0GSB4O4f+JzpK6XJzmbbQd2CNZqquVmK3+CoUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033053; c=relaxed/simple;
	bh=B1hs057JImXsb02n8NTEP+ziHNXKnUiUNuypIYRjNzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrvDDxa2mD+E1e09zaB4ND/y4tpCJdgvxJTmcgnGqf7LFrrjhsYmMy1EcuLrzBYT6gTe3r2c7zwIR/14/JiVQ29mvs77ajlQaFBzUV6uDAwM82E4ygaAGoR4lKl5pOQiGXFDzkzDG5GSs3QiiU24icSE4/eTH2aSG/Dp9OCh0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P7lmEYdp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P7lmEYdp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76EFC21157;
	Fri, 27 Jun 2025 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751033047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nun0T6NGI/f9i/J1oYeUTu85DQDdStb66yuN8m53Q44=;
	b=P7lmEYdpFL8JfZvdwUSZlCuf9z9H8rlbnEPVrsYeKhukkg/CZxGbs6S2AQXQqs/7hAgoAM
	m4B6UORxtK3AypmGOAEUIae3teRQ38xYZKDGMSdDSy6DJ8gIlG9W4n54maFvdInV2bXBEO
	fkVNjbASD4e0lRBNQaxbZTyfi7pLOJc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=P7lmEYdp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751033047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nun0T6NGI/f9i/J1oYeUTu85DQDdStb66yuN8m53Q44=;
	b=P7lmEYdpFL8JfZvdwUSZlCuf9z9H8rlbnEPVrsYeKhukkg/CZxGbs6S2AQXQqs/7hAgoAM
	m4B6UORxtK3AypmGOAEUIae3teRQ38xYZKDGMSdDSy6DJ8gIlG9W4n54maFvdInV2bXBEO
	fkVNjbASD4e0lRBNQaxbZTyfi7pLOJc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F8E713786;
	Fri, 27 Jun 2025 14:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GHs6G9ekXmgFSAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 27 Jun 2025 14:04:07 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: accessors: delete token versions of set/get helpers
Date: Fri, 27 Jun 2025 16:03:53 +0200
Message-ID: <a7f51e27606c24c063007273d0189bad487b921f.1751032655.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751032655.git.dsterba@suse.com>
References: <cover.1751032655.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 76EFC21157
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

Once upon a time there was a need to cache address of extent buffer
pages, as it was a costly operation (map_private_extent_buffer(),
cfed81a04eb555 ("Btrfs: add the ability to cache a pointer into the
eb")).  This was not even due to use of HIGHMEM, this had been removed
before that due to possible locking issues ( a65917156e3459 ("Btrfs:
stop using highmem for extent_buffers")).

Over the time the amount of work in the set/get helpers got reduced and
became quite straightforward bounds checking with an unaligned
read/write, commit db3756c879773c ("btrfs: remove unused
map_private_extent_buffer").

The actual caching of the page_address()/folio_address() in the token
was more work for very little gain. This depended on subsequent access
into the same page/folio, otherwise the cached pointer had to be
updated.

For metadata-heavy operations this showed up in the 'perf top' profile
where the btrfs_get_token_32 calls were at the top, on my testing
machine consuming about 2-3%. The other generic 32/64 bit helpers also
appeared in the profile with similar fraction.

After removing use of the token helpers we can remove them completely,
this leads to reduction of btrfs.ko by 6.7KiB on release config.

   text    data     bss     dec     hex filename
1463289  115665   16088 1595042  1856a2 pre/btrfs.ko
1456601  115665   16088 1588354  183c82 post/btrfs.ko

DELTA: -6688

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.c | 78 --------------------------------------------
 fs/btrfs/accessors.h | 37 ---------------------
 2 files changed, 115 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index e3716516ca3876..5cfb0801700e6c 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -25,13 +25,6 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
 	return true;
 }
 
-void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *eb)
-{
-	token->eb = eb;
-	token->kaddr = folio_address(eb->folios[0]);
-	token->offset = 0;
-}
-
 /*
  * Macro templates that define helpers to read/write extent buffer data of a
  * given size, that are also used via ctree.h for access to item members by
@@ -41,11 +34,6 @@ void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *e
  * - btrfs_set_8 (for 8/16/32/64)
  * - btrfs_get_8 (for 8/16/32/64)
  *
- * Generic helpers with a token (cached address of the most recently accessed
- * page):
- * - btrfs_set_token_8 (for 8/16/32/64)
- * - btrfs_get_token_8 (for 8/16/32/64)
- *
  * The set/get functions handle data spanning two pages transparently, in case
  * metadata block size is larger than page.  Every pointer to metadata items is
  * an offset into the extent buffer page array, cast to a specific type.  This
@@ -57,37 +45,6 @@ void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *e
  */
 
 #define DEFINE_BTRFS_SETGET_BITS(bits)					\
-u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
-			       const void *ptr, unsigned long off)	\
-{									\
-	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long idx = get_eb_folio_index(token->eb, member_offset); \
-	const unsigned long oil = get_eb_offset_in_folio(token->eb,	\
-							 member_offset);\
-	const int unit_size = token->eb->folio_size;			\
-	const int unit_shift = token->eb->folio_shift;			\
-	const int size = sizeof(u##bits);				\
-	u8 lebytes[sizeof(u##bits)];					\
-	const int part = unit_size - oil;				\
-									\
-	ASSERT(token);							\
-	ASSERT(token->kaddr);						\
-	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
-	if (token->offset <= member_offset &&				\
-	    member_offset + size <= token->offset + unit_size) {	\
-		return get_unaligned_le##bits(token->kaddr + oil);	\
-	}								\
-	token->kaddr = folio_address(token->eb->folios[idx]);		\
-	token->offset = idx << unit_shift;				\
-	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oil + size <= unit_size) \
-		return get_unaligned_le##bits(token->kaddr + oil);	\
-									\
-	memcpy(lebytes, token->kaddr + oil, part);			\
-	token->kaddr = folio_address(token->eb->folios[idx + 1]);	\
-	token->offset = (idx + 1) << unit_shift;			\
-	memcpy(lebytes + part, token->kaddr, size - part);		\
-	return get_unaligned_le##bits(lebytes);				\
-}									\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off)		\
 {									\
@@ -110,41 +67,6 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	memcpy(lebytes + part, kaddr, size - part);			\
 	return get_unaligned_le##bits(lebytes);				\
 }									\
-void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
-			    const void *ptr, unsigned long off,		\
-			    u##bits val)				\
-{									\
-	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const unsigned long idx = get_eb_folio_index(token->eb, member_offset); \
-	const unsigned long oil = get_eb_offset_in_folio(token->eb,	\
-							 member_offset);\
-	const int unit_size = token->eb->folio_size;			\
-	const int unit_shift = token->eb->folio_shift;			\
-	const int size = sizeof(u##bits);				\
-	u8 lebytes[sizeof(u##bits)];					\
-	const int part = unit_size - oil;				\
-									\
-	ASSERT(token);							\
-	ASSERT(token->kaddr);						\
-	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
-	if (token->offset <= member_offset &&				\
-	    member_offset + size <= token->offset + unit_size) {	\
-		put_unaligned_le##bits(val, token->kaddr + oil);	\
-		return;							\
-	}								\
-	token->kaddr = folio_address(token->eb->folios[idx]);		\
-	token->offset = idx << unit_shift;				\
-	if (INLINE_EXTENT_BUFFER_PAGES == 1 ||				\
-	    oil + size <= unit_size) {					\
-		put_unaligned_le##bits(val, token->kaddr + oil);	\
-		return;							\
-	}								\
-	put_unaligned_le##bits(val, lebytes);				\
-	memcpy(token->kaddr + oil, lebytes, part);			\
-	token->kaddr = folio_address(token->eb->folios[idx + 1]);	\
-	token->offset = (idx + 1) << unit_shift;			\
-	memcpy(token->kaddr, lebytes + part, size - part);		\
-}									\
 void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 		      unsigned long off, u##bits val)			\
 {									\
diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 15ea6348800b08..99b3ced12805bb 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -16,14 +16,6 @@
 
 struct extent_buffer;
 
-struct btrfs_map_token {
-	struct extent_buffer *eb;
-	char *kaddr;
-	unsigned long offset;
-};
-
-void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *eb);
-
 /*
  * Some macros to generate set/get functions for the struct fields.  This
  * assumes there is a lefoo_to_cpu for every type, so lets make a simple one
@@ -56,11 +48,6 @@ static inline void put_unaligned_le8(u8 val, void *p)
 			    sizeof_field(type, member)))
 
 #define DECLARE_BTRFS_SETGET_BITS(bits)					\
-u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
-			       const void *ptr, unsigned long off);	\
-void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
-			    const void *ptr, unsigned long off,		\
-			    u##bits val);				\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off);		\
 void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
@@ -83,18 +70,6 @@ static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
 {									\
 	static_assert(sizeof(u##bits) == sizeof_field(type, member));	\
 	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
-}									\
-static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
-					 const type *s)			\
-{									\
-	static_assert(sizeof(u##bits) == sizeof_field(type, member));	\
-	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
-}									\
-static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
-					  type *s, u##bits val)		\
-{									\
-	static_assert(sizeof(u##bits) == sizeof_field(type, member));	\
-	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
 }
 
 #define BTRFS_SETGET_HEADER_FUNCS(name, type, member, bits)		\
@@ -479,18 +454,6 @@ static inline void btrfs_set_item_##member(const struct extent_buffer *eb,	\
 					   int slot, u32 val)			\
 {										\
 	btrfs_set_raw_item_##member(eb, btrfs_item_nr(eb, slot), val);		\
-}										\
-static inline u32 btrfs_token_item_##member(struct btrfs_map_token *token,	\
-					    int slot)				\
-{										\
-	struct btrfs_item *item = btrfs_item_nr(token->eb, slot);		\
-	return btrfs_token_raw_item_##member(token, item);			\
-}										\
-static inline void btrfs_set_token_item_##member(struct btrfs_map_token *token,	\
-						 int slot, u32 val)		\
-{										\
-	struct btrfs_item *item = btrfs_item_nr(token->eb, slot);		\
-	btrfs_set_token_raw_item_##member(token, item, val);			\
 }
 
 BTRFS_ITEM_SETGET_FUNCS(offset)
-- 
2.49.0


