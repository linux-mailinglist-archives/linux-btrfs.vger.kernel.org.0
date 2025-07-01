Return-Path: <linux-btrfs+bounces-15180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AD0AF01B3
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 19:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9AE445A01
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DB327F4D5;
	Tue,  1 Jul 2025 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IGMqMEa2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IGMqMEa2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC027E071
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390668; cv=none; b=ZKUjqMgjT2FM/qYHXfRNhcb5G2tZ1BCBT0awUlrLzgeoy7ER6BRT0Eofbm4swQXmvdYMV5STwbE6BI8HnWqPcVzMpcA1KgDSlIniS0CoU7KMQ7Kq/C24n4ebl+6gwil4RDP3ypr9NQmpWqv0Q/QlTsz6qb2SC33pu5WpzeHj5fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390668; c=relaxed/simple;
	bh=pkYdQWsPoxLVOLE3j9bbD/uiammOD7VjcDwvCQTZ3II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/qdVD2/61x2TJwz2l9K8yBDWI+k3GmdO8zWkTpLnOLrIuwdb8G9udfUkVnVzQm0g84CUtDCnLc8iitXEI908AKV2+hOoDvqd5SzXBErAvnxlhu7mmqyWgITLcDq1Uo7bPdj6L7IMeOXtZHDSz+m4Z0JIoatGeLayfsvD9qL80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IGMqMEa2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IGMqMEa2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CED6D21179;
	Tue,  1 Jul 2025 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NReLb1AelnvAmQR9XF9XU2FruniGk2IgWZW9rsGFPgw=;
	b=IGMqMEa2Pxt3i4u2sr2Y+GTxxHZIT99yCwjaXV7FDkQE02FFQzLOA5jWQQVD9pttpFLjX8
	GlW6+MbYnlS4ZWC9/HpKkB9AA+A+PjGRvH4J8sG1wSjZ6b27Aq8f/nSfNIVQX+cRrRvFSx
	ZIRngkb4XXAONGT60Q40+bK/Q/v4txY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NReLb1AelnvAmQR9XF9XU2FruniGk2IgWZW9rsGFPgw=;
	b=IGMqMEa2Pxt3i4u2sr2Y+GTxxHZIT99yCwjaXV7FDkQE02FFQzLOA5jWQQVD9pttpFLjX8
	GlW6+MbYnlS4ZWC9/HpKkB9AA+A+PjGRvH4J8sG1wSjZ6b27Aq8f/nSfNIVQX+cRrRvFSx
	ZIRngkb4XXAONGT60Q40+bK/Q/v4txY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C750E13890;
	Tue,  1 Jul 2025 17:24:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id epKoMMAZZGhLRgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Jul 2025 17:24:16 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 7/7] btrfs: accessors: factor out split memcpy with two sources
Date: Tue,  1 Jul 2025 19:23:54 +0200
Message-ID: <1db66bf81b5790c6e14183a5c30a8abf6d1b1126.1751390044.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The case of a reading the bytes from 2 folios needs two memcpy()s, the
compiler does not emit calls but two inline loops.

Factoring out the code makes some improvement (stack, code) and in the
future will provide an optimized implementation as well. (The analogical
version with two destinations is not done as it increases stack usage
but can be done if needed.)

The address of the second folio is reordered before the first memcpy,
which leads to an optimization reusing the vmemmap_base and
page_offset_base (implementing folio_address()).

Stack usage reduction:

  btrfs_get_32                                           -8 (32 -> 24)
  btrfs_get_64                                           -8 (32 -> 24)

Code size reduction:

     text    data     bss     dec     hex filename
  1454279  115665   16088 1586032  183370 pre/btrfs.ko
  1454229  115665   16088 1585982  18333e post/btrfs.ko

  DELTA: -50

As this is the last patch in this series, here's the overall diff
starting and including commit "btrfs: accessors: simplify folio bounds
checks":

Stack:

  btrfs_set_16                                          -72 (88 -> 16)
  btrfs_get_32                                          -56 (80 -> 24)
  btrfs_set_8                                           -72 (88 -> 16)
  btrfs_set_64                                          -64 (88 -> 24)
  btrfs_get_8                                           -72 (80 -> 8)
  btrfs_get_16                                          -64 (80 -> 16)
  btrfs_set_32                                          -64 (88 -> 24)
  btrfs_get_64                                          -56 (80 -> 24)

  NEW (48):
	  report_setget_bounds                           48
  LOST/NEW DELTA:      +48
  PRE/POST DELTA:     -472

Code:

     text    data     bss     dec     hex filename
  1456601  115665   16088 1588354  183c82 pre/btrfs.ko
  1454229  115665   16088 1585982  18333e post/btrfs.ko

  DELTA: -2372

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index af11f547371815..f554c4f723617f 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -20,6 +20,15 @@ static void __cold report_setget_bounds(const struct extent_buffer *eb,
 		   (unsigned long)ptr, eb->start, member_offset, size);
 }
 
+/* Copy bytes from @src1 and @src2 to @dest. */
+static __always_inline void memcpy_split_src(char *dest, const char *src1,
+					     const char *src2, const size_t len1,
+					     const size_t total)
+{
+	memcpy(dest, src1, len1);
+	memcpy(dest + len1, src2, total - len1);
+}
+
 /*
  * Macro templates that define helpers to read/write extent buffer data of a
  * given size, that are also used via ctree.h for access to item members by
@@ -64,9 +73,9 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 		kaddr = folio_address(eb->folios[idx + 1]);		\
 		lebytes[1] = *kaddr;					\
 	} else {							\
-		memcpy(lebytes, kaddr, part);				\
-		kaddr = folio_address(eb->folios[idx + 1]);		\
-		memcpy(lebytes + part, kaddr, sizeof(u##bits) - part);	\
+		memcpy_split_src(lebytes, kaddr,			\
+				 folio_address(eb->folios[idx + 1]),	\
+				 part, sizeof(u##bits));		\
 	}								\
 	return get_unaligned_le##bits(lebytes);				\
 }									\
-- 
2.49.0


