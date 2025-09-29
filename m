Return-Path: <linux-btrfs+bounces-17261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07017BA937F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 14:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE047A8F5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E483A305955;
	Mon, 29 Sep 2025 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GyZhV8Br";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TWqr/Aic"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31D270ED9
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759149694; cv=none; b=uyE90xv46hUHxCkxOjS7wcZbXjljAG6tUOb/CHEv1BYSvjSQX9/3tBSfIUK8PzDGMfxlKYie2GhmxTnIzeEkJxa30tFY1jnJ2/ZPb+S4lbPzgClLNC8hgGy9MQ/n2WxACCgQzRsJzR5/Wh/Clw2EKdNCNicRCEUztOolYInitrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759149694; c=relaxed/simple;
	bh=t7MKOe8jCOuI9RAUgePempfByzt0xA8esgLdNHf2PuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZY07CRN19ro/P5f7CDQzFk3edT/Vfg5TE/mXwEHH73PqY3vwE+K0P0cc9DwnsCngefJ6cTMjf6bpnlmuGGgz8KSGmTXX4ija7d+Uv7wrwg7lTtrypP2T15/4xBV/Lwrr4LL3582p+AxFi02aoX2idjOwNhEGXg1oqv8sl+h3wOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GyZhV8Br; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TWqr/Aic; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 931F633340;
	Mon, 29 Sep 2025 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759149677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jACuTDLM7RqYvBcg8YJEqHiHbYhsuRgmcqPcdSzKXS8=;
	b=GyZhV8BrjhVfxWmYBkeEC8XeF7yNAi35vLFkulmNBp4yEXCFwg+EUhRyN6I0NtvivlV7Bn
	/F2UYL+lp7BLHgWbF90esciQtzlu5RGjctmiSYxG0aLxczoOSwctJgsbCGgs1wyRoO7tkZ
	mX5n2OOtHcG+8RdcuaQsijsEybvPU8Y=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="TWqr/Aic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759149676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jACuTDLM7RqYvBcg8YJEqHiHbYhsuRgmcqPcdSzKXS8=;
	b=TWqr/AicgFGGA0xsoSGxaaHft8U6VtkrHiLX7D+NjiEDAMwg5YfvP3ChGclmY3qR3NhmXZ
	U0Wycwi+e1K5VahoRxiM4P5lNDem0BHSwdbDX7JIaXiATgZXyqIfrm/w1YwBrwUh+bsxR/
	4gO4kUutJNxfJkJ7lJ1xroNplcZBpsA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C8EF13A21;
	Mon, 29 Sep 2025 12:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t+9LImx+2mhYCwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 29 Sep 2025 12:41:16 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: subpage: rename macro variables to avoid shadowing
Date: Mon, 29 Sep 2025 14:41:15 +0200
Message-ID: <20250929124115.1192886-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
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
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 931F633340
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

When compiling with -Wshadow there are warnings in the subpage helper
macros that are used in functions like btrfs_subpage_dump_bitmap() or
btrfs_subpage_clear_and_test_dirty() that also use 'bfs' (for struct
btrfs_folio_state) or blocks_per_folio.

Add '__' to the macro variables and unify naming in all subpage macros.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/subpage.c | 43 +++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 01bf58fa92aa2e..0a4a1ee81e6392 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -194,12 +194,11 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 #define subpage_calc_start_bit(fs_info, folio, name, start, len)	\
 ({									\
 	unsigned int __start_bit;					\
-	const unsigned int blocks_per_folio =				\
-			   btrfs_blocks_per_folio(fs_info, folio);	\
+	const unsigned int __bpf = btrfs_blocks_per_folio(fs_info, folio); \
 									\
 	btrfs_subpage_assert(fs_info, folio, start, len);		\
 	__start_bit = offset_in_folio(folio, start) >> fs_info->sectorsize_bits; \
-	__start_bit += blocks_per_folio * btrfs_bitmap_nr_##name;	\
+	__start_bit += __bpf * btrfs_bitmap_nr_##name;			\
 	__start_bit;							\
 })
 
@@ -338,24 +337,20 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 
 #define subpage_test_bitmap_all_set(fs_info, folio, name)		\
 ({									\
-	struct btrfs_folio_state *bfs = folio_get_private(folio);	\
-	const unsigned int blocks_per_folio =				\
-				btrfs_blocks_per_folio(fs_info, folio); \
+	struct btrfs_folio_state *__bfs = folio_get_private(folio);	\
+	const unsigned int __bpf = btrfs_blocks_per_folio(fs_info, folio); \
 									\
-	bitmap_test_range_all_set(bfs->bitmaps,				\
-			blocks_per_folio * btrfs_bitmap_nr_##name,	\
-			blocks_per_folio);				\
+	bitmap_test_range_all_set(__bfs->bitmaps,			\
+				  __bpf * btrfs_bitmap_nr_##name, __bpf); \
 })
 
 #define subpage_test_bitmap_all_zero(fs_info, folio, name)		\
 ({									\
-	struct btrfs_folio_state *bfs = folio_get_private(folio);	\
-	const unsigned int blocks_per_folio =				\
-				btrfs_blocks_per_folio(fs_info, folio); \
+	struct btrfs_folio_state *__bfs = folio_get_private(folio);	\
+	const unsigned int __bpf = btrfs_blocks_per_folio(fs_info, folio); \
 									\
-	bitmap_test_range_all_zero(bfs->bitmaps,			\
-			blocks_per_folio * btrfs_bitmap_nr_##name,	\
-			blocks_per_folio);				\
+	bitmap_test_range_all_zero(__bfs->bitmaps,			\
+				   __bpf * btrfs_bitmap_nr_##name, __bpf); \
 })
 
 void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
@@ -672,27 +667,23 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
 
 #define GET_SUBPAGE_BITMAP(fs_info, folio, name, dst)			\
 {									\
-	const unsigned int blocks_per_folio =				\
-				btrfs_blocks_per_folio(fs_info, folio);	\
-	const struct btrfs_folio_state *bfs = folio_get_private(folio);	\
+	const unsigned int __bpf = btrfs_blocks_per_folio(fs_info, folio); \
+	const struct btrfs_folio_state *__bfs = folio_get_private(folio); \
 									\
-	ASSERT(blocks_per_folio <= BITS_PER_LONG);			\
-	*dst = bitmap_read(bfs->bitmaps,				\
-			   blocks_per_folio * btrfs_bitmap_nr_##name,	\
-			   blocks_per_folio);				\
+	ASSERT(__bpf <= BITS_PER_LONG);					\
+	*dst = bitmap_read(__bfs->bitmaps,				\
+			   __bpf * btrfs_bitmap_nr_##name, __bpf);	\
 }
 
 #define SUBPAGE_DUMP_BITMAP(fs_info, folio, name, start, len)		\
 {									\
 	unsigned long bitmap;						\
-	const unsigned int blocks_per_folio =				\
-				btrfs_blocks_per_folio(fs_info, folio);	\
+	const unsigned int __bpf = btrfs_blocks_per_folio(fs_info, folio); \
 									\
 	GET_SUBPAGE_BITMAP(fs_info, folio, name, &bitmap);		\
 	btrfs_warn(fs_info,						\
 	"dumping bitmap start=%llu len=%u folio=%llu " #name "_bitmap=%*pbl", \
-		   start, len, folio_pos(folio),			\
-		   blocks_per_folio, &bitmap);				\
+		   start, len, folio_pos(folio), __bpf, &bitmap);	\
 }
 
 /*
-- 
2.51.0


