Return-Path: <linux-btrfs+bounces-15064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B07BCAECB26
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 05:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0222C18911F9
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Jun 2025 03:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B658E155A59;
	Sun, 29 Jun 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PSuIRMeP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PSuIRMeP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA51A288
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Jun 2025 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751167146; cv=none; b=Igs+WX2LRUghvA6wGt0vcNmesQvrRTVx5znGwkdPCeWmLN7kDnbyDj5UACC6QHgAFBSNuYPkLVsFIOPTPlQ0f3lNS2hKE04RnggHOLutmLUcVgtcLXFxexAqHBPcrFSu7L9TKWdH3mkRdQzKhcg+bDhSBf/IHvOolIahOVOMNjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751167146; c=relaxed/simple;
	bh=Ts4agRtsAcYu0xDrDKrBR1eFTdWQYlGFEJp2GA6a4/A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OAmtuZwbCyqww/cHDJCK0pMq1UjdsiQRLYLrIlAyU3u6BB2ifKPznzRTqz0Akyu6GnMZEqZ+Ig6m/ilg7U2ilCb2f3n6JFFUZ99JbbKKcr2NXtU4pkZ7LXp0iFSdSeRm8FIPIjI4X3GvGRl5eaMqYt4uW4tuTclBZSf/L1QOsjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PSuIRMeP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PSuIRMeP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5910B1F388
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Jun 2025 03:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751167135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h/DdXWITBJMT6KB10f+bfgsqSHUHm+ilNL1j+DYv4PU=;
	b=PSuIRMePqZEdFPXOyNU8Jg4QxbPmLT7Bx4ZjDzE5JNyisXGMFk2fqsp6TXTMrgkPZoQSjl
	p+PyGMLeEHs/OfuRdkdakdtOdKAbQNBIDHR/IbvznDq3mEOv4vsyFbZkd1UfqMAT0BOvPD
	TEBzJoa3753DhOFkxcHGDQ4su40un+k=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PSuIRMeP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751167135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h/DdXWITBJMT6KB10f+bfgsqSHUHm+ilNL1j+DYv4PU=;
	b=PSuIRMePqZEdFPXOyNU8Jg4QxbPmLT7Bx4ZjDzE5JNyisXGMFk2fqsp6TXTMrgkPZoQSjl
	p+PyGMLeEHs/OfuRdkdakdtOdKAbQNBIDHR/IbvznDq3mEOv4vsyFbZkd1UfqMAT0BOvPD
	TEBzJoa3753DhOFkxcHGDQ4su40un+k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A72D1373A
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Jun 2025 03:18:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iY4yEp6wYGifYAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 29 Jun 2025 03:18:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: remove btrfs_map_token structure
Date: Sun, 29 Jun 2025 12:48:36 +0930
Message-ID: <15273755597bab9aaa50ff3bbfec37b3073c1d71.1751167109.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5910B1F388
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

The structure is introduced by commit c979ffd78722 ("btrfs-progs: sync
accessors.[ch] from the kernel"), but no one is really utilizing it, as
in user space the whole extent buffer is just a contiguous user space
memory, no need to do any special page/folio related mapping.

Furthermore the kernel is also dropping the usage of btrfs_map_token,
replacing it with regular accessors.

So there is no need to keep the code and we can safely drop the
structure along with its helpers.

This time such removal does not only remove unused codes, but also
synchronise the codes with kernel.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/accessors.c | 37 -------------------------------------
 kernel-shared/accessors.h | 37 -------------------------------------
 2 files changed, 74 deletions(-)

diff --git a/kernel-shared/accessors.c b/kernel-shared/accessors.c
index 17cf13f601a8..16a4e944502e 100644
--- a/kernel-shared/accessors.c
+++ b/kernel-shared/accessors.c
@@ -26,17 +26,6 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
 	return true;
 }
 
-/*
- * MODIFIED:
- *  - We don't have eb->folios
- */
-void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *eb)
-{
-	token->eb = eb;
-	token->kaddr = eb->data;
-	token->offset = 0;
-}
-
 /*
  * MODIFIED:
  *  - We don't have eb->folios, simply wrap the set/get helpers.
@@ -52,11 +41,6 @@ void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *e
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
@@ -68,16 +52,6 @@ void btrfs_init_map_token(struct btrfs_map_token *token, struct extent_buffer *e
  */
 
 #define DEFINE_BTRFS_SETGET_BITS(bits)					\
-u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
-			       const void *ptr, unsigned long off)	\
-{									\
-	const unsigned long member_offset = (unsigned long)ptr + off;	\
-	const int size = sizeof(u##bits);				\
-	ASSERT(token);							\
-	ASSERT(token->kaddr);						\
-	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
-	return get_unaligned_le##bits(token->kaddr + member_offset);	\
-}									\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off)		\
 {									\
@@ -86,17 +60,6 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
 	return get_unaligned_le##bits(eb->data + member_offset);	\
 }									\
-void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
-			    const void *ptr, unsigned long off,		\
-			    u##bits val)				\
-{									\
-	unsigned long member_offset = (unsigned long)ptr + off;		\
-	const int size = sizeof(u##bits);				\
-	ASSERT(token);							\
-	ASSERT(token->kaddr);						\
-	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
-	put_unaligned_le##bits(val, token->kaddr + member_offset);	\
-}									\
 void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
 		      unsigned long off, u##bits val)			\
 {									\
diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
index 2d6bae536c54..8cb68f529fa8 100644
--- a/kernel-shared/accessors.h
+++ b/kernel-shared/accessors.h
@@ -14,14 +14,6 @@
 #define _static_assert(expr)   _Static_assert(expr, #expr)
 #endif
 
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
@@ -54,11 +46,6 @@ static inline void put_unaligned_le8(u8 val, void *p)
 			   sizeof(((type *)0)->member)))
 
 #define DECLARE_BTRFS_SETGET_BITS(bits)					\
-u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
-			       const void *ptr, unsigned long off);	\
-void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
-			    const void *ptr, unsigned long off,		\
-			    u##bits val);				\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off);		\
 void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
@@ -82,18 +69,6 @@ static inline void btrfs_set_##name(struct extent_buffer *eb, type *s, \
 	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
 }									\
-static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
-					 const type *s)			\
-{									\
-	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
-	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
-}									\
-static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
-					  type *s, u##bits val)		\
-{									\
-	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
-	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
-}
 
 /*
  * MODIFIED:
@@ -512,18 +487,6 @@ static inline void btrfs_set_item_##member(struct extent_buffer *eb,	\
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


