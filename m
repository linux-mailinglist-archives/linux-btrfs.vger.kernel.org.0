Return-Path: <linux-btrfs+bounces-15175-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B88FFAF01B5
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 19:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FB971883E72
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FE327F728;
	Tue,  1 Jul 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P8kqPTiy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P8kqPTiy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863522B585
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390648; cv=none; b=EqNhRj4tULRZJ9d28ddRq3bQB2ZaljzFWtCOeQXhoEaFj8sCIB/IHwdrmyjUZs43djTLFoDFl/DgE1eqN6fDyMAc/a+t6HqDx5J6N271sy45wue5LCY4KE4+dX/ruNuy4fKr8lR258mnC2gv1YWvs83huLJ3ggcrvwWZ2CiwTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390648; c=relaxed/simple;
	bh=xu9QsvtwZWRemxzWGYs7XNkHen/x0yRyB3O3NKJETNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhSZQ6ZZGv4wumv7IrxqO4alCsZQVdHEuZQDoqgOEAPoM8tcAKKuiK9ATy43YVk4NkgIOva3JKSA7I8ZtMbWIbJPXqw0dqqE5mP3Vb9X/7rOoWPB4oTuZhsN5ZhoROqif2zzmquH61bPzw3O8nnNm2wp/DMC1j3aSAh2WayeHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P8kqPTiy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P8kqPTiy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B13BF21188;
	Tue,  1 Jul 2025 17:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEWYEu8Q+iHioN3mx0Vce6w6XXn1g0hhmc/dJ9ZVRfI=;
	b=P8kqPTiyWeo0XKOSKEloq7CgKnTuk9tAyoMMZDElRtkUPIPPonNwlFD1rfd9oQEmkLy8MT
	rC//XdAfbCFF39PiMSscPrBHo7R2vtyHTeo5zm67KoI8HdO8cRzZbCCnxyDZ7J6ZfN489A
	V/+Bi48U4l76cloR7ZdqFzVrTaCo/NU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NEWYEu8Q+iHioN3mx0Vce6w6XXn1g0hhmc/dJ9ZVRfI=;
	b=P8kqPTiyWeo0XKOSKEloq7CgKnTuk9tAyoMMZDElRtkUPIPPonNwlFD1rfd9oQEmkLy8MT
	rC//XdAfbCFF39PiMSscPrBHo7R2vtyHTeo5zm67KoI8HdO8cRzZbCCnxyDZ7J6ZfN489A
	V/+Bi48U4l76cloR7ZdqFzVrTaCo/NU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAAEB13890;
	Tue,  1 Jul 2025 17:24:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XyOoKbEZZGg2RgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Jul 2025 17:24:01 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/7] btrfs: accessors: use type sizeof constants directly
Date: Tue,  1 Jul 2025 19:23:49 +0200
Message-ID: <eedbe03f6ee33939841d4bf895519304dfa1c59f.1751390044.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751390044.git.dsterba@suse.com>
References: <cover.1751390044.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Now unit_size is used only once, so use it directly in 'part'
calculation. Don't cache sizeof(type) in a variable. While this is a
compile-time constant, forcing the type 'int' generates worse code as it
leads to additional conversion from 32 to 64 bit type on x86_64.

The sizeof() is used only a few times and it does not make the code that
harder to read, so use it directly and let the compiler utilize the
immediate constants in the context it needs. The .ko code size slightly
increases (+50) but further patches will reduce that again.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index b54c8abe467a06..2e90b9b14e73f4 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -52,19 +52,17 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
 	const unsigned long oil = get_eb_offset_in_folio(eb,		\
 							 member_offset);\
-	const int unit_size = eb->folio_size;				\
 	char *kaddr = folio_address(eb->folios[idx]);			\
-	const int size = sizeof(u##bits);				\
-	const int part = unit_size - oil;				\
+	const int part = eb->folio_size - oil;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
-	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
+	ASSERT(check_setget_bounds(eb, ptr, off, sizeof(u##bits)));	\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 || likely(sizeof(u##bits) <= part))	\
 		return get_unaligned_le##bits(kaddr + oil);		\
 									\
 	memcpy(lebytes, kaddr + oil, part);				\
 	kaddr = folio_address(eb->folios[idx + 1]);			\
-	memcpy(lebytes + part, kaddr, size - part);			\
+	memcpy(lebytes + part, kaddr, sizeof(u##bits) - part);		\
 	return get_unaligned_le##bits(lebytes);				\
 }									\
 void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
@@ -74,13 +72,11 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
 	const unsigned long oil = get_eb_offset_in_folio(eb,		\
 							 member_offset);\
-	const int unit_size = eb->folio_size;				\
 	char *kaddr = folio_address(eb->folios[idx]);			\
-	const int size = sizeof(u##bits);				\
-	const int part = unit_size - oil;				\
+	const int part = eb->folio_size - oil;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
-	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
+	ASSERT(check_setget_bounds(eb, ptr, off, sizeof(u##bits)));	\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 ||				\
 	    likely(sizeof(u##bits) <= part)) {				\
 		put_unaligned_le##bits(val, kaddr + oil);		\
@@ -90,7 +86,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	put_unaligned_le##bits(val, lebytes);				\
 	memcpy(kaddr + oil, lebytes, part);				\
 	kaddr = folio_address(eb->folios[idx + 1]);			\
-	memcpy(kaddr, lebytes + part, size - part);			\
+	memcpy(kaddr, lebytes + part, sizeof(u##bits) - part);		\
 }
 
 DEFINE_BTRFS_SETGET_BITS(8)
-- 
2.49.0


