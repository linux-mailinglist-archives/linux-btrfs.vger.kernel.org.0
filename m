Return-Path: <linux-btrfs+bounces-20164-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C55CF957A
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0F773019893
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A13329378;
	Tue,  6 Jan 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vV0d/ZZH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vV0d/ZZH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8D313558
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716455; cv=none; b=RqhiuIK1qELdsXMXB37lnzgl6hgQONm4QGFQcHV3YjYNjJrYLHlmQJLgicf0vhlYO5xhjG0m+xJ46kmzH41wAtmIZxBlE7bRkXgWnnQcanS+UIknQcdqBMMqnSGGUTGKslbfqskD72spghOqj7+7Mrr06FNBt2SmiGwUTGqdvZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716455; c=relaxed/simple;
	bh=eHI1NiEdgGtkXslDLWJvqPWLFch5vw8n2JWvrmwNoMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A46MongQQkagGfpx6ibDwHhOa/QM0bk5GtgwysJyp1G2utcs10d6qF7mhz9RChdpjscmk+jnRBk5AJQKqChJz47JX/DhO5vLcCY0gte90p4kutZmVNXLfMpsRa5kNh7XJ5c2MuLvZG89bUrO6NQphOXP90ZNr/2mvRzq3Bys6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vV0d/ZZH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vV0d/ZZH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 370BC5BCD0;
	Tue,  6 Jan 2026 16:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRFSBThkoo5NJ/fGtTsjAS5M48eKkRT4oa/dQa6/Nqk=;
	b=vV0d/ZZHx5fcw6EITHLZQksGQSiLYix+O5v+GzVL7d+rqLol6typcNkLsH/H5JCvp5zisw
	qiTaSUF5DFUnijCJKLNZ61MXUFM/DoFXNm+DwrGU4tECFPjdxkbCgRQIt+i/Y2elsypUEs
	zOHHejLg04Fy5eDsoqyS1Yq1LimhA78=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRFSBThkoo5NJ/fGtTsjAS5M48eKkRT4oa/dQa6/Nqk=;
	b=vV0d/ZZHx5fcw6EITHLZQksGQSiLYix+O5v+GzVL7d+rqLol6typcNkLsH/H5JCvp5zisw
	qiTaSUF5DFUnijCJKLNZ61MXUFM/DoFXNm+DwrGU4tECFPjdxkbCgRQIt+i/Y2elsypUEs
	zOHHejLg04Fy5eDsoqyS1Yq1LimhA78=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 316623EA63;
	Tue,  6 Jan 2026 16:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b8wMDGQ2XWmnWQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:20:52 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 04/12] btrfs: read eb folio index right before loops
Date: Tue,  6 Jan 2026 17:20:27 +0100
Message-ID: <447e5571c40fef2bd83cc8c1580b2747c9eb41a3.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.980];
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

There are generic helpers to access extent buffer folio data of any
length, potentially iterating over a few of them. This is a slow path,
either we use the type based accessors or the eb folio allocation is
contiguous and we can use the memcpy/memcmp helpers.

The initialization of 'i' is done at the beginning though it may not be
needed. Move it right before the folio loop, this has minor effect on
generated code in __write_extent_buffer().

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bbc55873cb1678..97cf1ad91e5780 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3960,7 +3960,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	size_t cur;
 	size_t offset;
 	char *dst = (char *)dstv;
-	unsigned long i = get_eb_folio_index(eb, start);
+	unsigned long i;
 
 	if (check_eb_range(eb, start, len)) {
 		/*
@@ -3977,7 +3977,7 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	}
 
 	offset = get_eb_offset_in_folio(eb, start);
-
+	i = get_eb_folio_index(eb, start);
 	while (len > 0) {
 		char *kaddr;
 
@@ -4000,7 +4000,7 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 	size_t cur;
 	size_t offset;
 	char __user *dst = (char __user *)dstv;
-	unsigned long i = get_eb_folio_index(eb, start);
+	unsigned long i;
 	int ret = 0;
 
 	WARN_ON(start > eb->len);
@@ -4013,7 +4013,7 @@ int read_extent_buffer_to_user_nofault(const struct extent_buffer *eb,
 	}
 
 	offset = get_eb_offset_in_folio(eb, start);
-
+	i = get_eb_folio_index(eb, start);
 	while (len > 0) {
 		char *kaddr;
 
@@ -4041,7 +4041,7 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 	size_t offset;
 	char *kaddr;
 	char *ptr = (char *)ptrv;
-	unsigned long i = get_eb_folio_index(eb, start);
+	unsigned long i;
 	int ret = 0;
 
 	if (check_eb_range(eb, start, len))
@@ -4051,7 +4051,7 @@ int memcmp_extent_buffer(const struct extent_buffer *eb, const void *ptrv,
 		return memcmp(ptrv, eb->addr + start, len);
 
 	offset = get_eb_offset_in_folio(eb, start);
-
+	i = get_eb_folio_index(eb, start);
 	while (len > 0) {
 		cur = min(len, unit_size - offset);
 		kaddr = folio_address(eb->folios[i]);
@@ -4111,7 +4111,7 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 	size_t offset;
 	char *kaddr;
 	const char *src = (const char *)srcv;
-	unsigned long i = get_eb_folio_index(eb, start);
+	unsigned long i;
 	/* For unmapped (dummy) ebs, no need to check their uptodate status. */
 	const bool check_uptodate = !test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
@@ -4127,7 +4127,7 @@ static void __write_extent_buffer(const struct extent_buffer *eb,
 	}
 
 	offset = get_eb_offset_in_folio(eb, start);
-
+	i = get_eb_folio_index(eb, start);
 	while (len > 0) {
 		if (check_uptodate)
 			assert_eb_folio_uptodate(eb, i);
@@ -4213,7 +4213,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 	size_t cur;
 	size_t offset;
 	char *kaddr;
-	unsigned long i = get_eb_folio_index(dst, dst_offset);
+	unsigned long i;
 
 	if (check_eb_range(dst, dst_offset, len) ||
 	    check_eb_range(src, src_offset, len))
@@ -4223,6 +4223,7 @@ void copy_extent_buffer(const struct extent_buffer *dst,
 
 	offset = get_eb_offset_in_folio(dst, dst_offset);
 
+	i = get_eb_folio_index(dst, dst_offset);
 	while (len > 0) {
 		assert_eb_folio_uptodate(dst, i);
 
-- 
2.51.1


