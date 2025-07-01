Return-Path: <linux-btrfs+bounces-15178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CE5AF01B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D77E520325
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CF727FB38;
	Tue,  1 Jul 2025 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OiCJ0+AR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OiCJ0+AR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A9727E7CF
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390660; cv=none; b=kcCQ23Ck4SsM2b5vn94nvtanIp1/hgQ9A4y1rMQLajwSsjJzqqFVGqZUE1avOEQDRcncuUettBbLbfHSErHP+A0tvO7Rp2ljxXTYA5/liIBxzFdbe3KPsLqthQYDHxoo0F0kC/Fcg6+yiIjCUVN5Pkf3W3AjlQMXxx/EZOVKQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390660; c=relaxed/simple;
	bh=7I6wHCVbxUqs0MPUwH+zlG0Ut0vAlrth7udaw42vH9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gt56nHZZY2X22g4UoHKMIMraz48JZ0k87IIvSqbwOSmf3kUmaogfgMXOcKItMcSEzBlXvjLMcJLHOy5R4P+VfxEX1c6JUVTbo7T9kg2E12o0ZArxwFl3qKSeGg3t25iqgaG1Y6jNyp+WyJK6lYh72T9dZE3q74+B+yfCC9D2EmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OiCJ0+AR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OiCJ0+AR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B11D1F452;
	Tue,  1 Jul 2025 17:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2UOJ9uProEjhZHK27sMCvY9OAWuOPshDjkt4VuMVpM=;
	b=OiCJ0+ARzu8Z2GUbaQg7uYKzhCiMDEfQqeR5AAF++wiSGV3xEzt2SbpP6BNmRZysqJLhPy
	+AKNytMOvpNFx/Ajn/G/ImsUjeevvQ6JA4RUfDmrG3ybxz73sRDDghFtNa88weAtaY7cmZ
	noN99HmzGF5TT2qcdbih57QSx8sFXTs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2UOJ9uProEjhZHK27sMCvY9OAWuOPshDjkt4VuMVpM=;
	b=OiCJ0+ARzu8Z2GUbaQg7uYKzhCiMDEfQqeR5AAF++wiSGV3xEzt2SbpP6BNmRZysqJLhPy
	+AKNytMOvpNFx/Ajn/G/ImsUjeevvQ6JA4RUfDmrG3ybxz73sRDDghFtNa88weAtaY7cmZ
	noN99HmzGF5TT2qcdbih57QSx8sFXTs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93C5E13890;
	Tue,  1 Jul 2025 17:24:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YEUTJL4ZZGhIRgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Jul 2025 17:24:14 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 6/7] btrfs: accessors: set target address at initialization
Date: Tue,  1 Jul 2025 19:23:53 +0200
Message-ID: <961fc10b1db0b70cdf723e510f0ddbafbdc25dd2.1751390044.git.dsterba@suse.com>
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

The target address for the read/write can be simplified as it's the same
expression for the first folio. This improves the generated code as the
folio address does not have to be cached on stack.

Stack usage reduction:

  btrfs_set_32                                           -8 (32 -> 24)
  btrfs_set_64                                           -8 (32 -> 24)
  btrfs_get_16                                           -8 (24 -> 16)

Code size reduction:

     text    data     bss     dec     hex filename
  1454459  115665   16088 1586212  183424 pre/btrfs.ko
  1454279  115665   16088 1586032  183370 post/btrfs.ko

  DELTA: -180

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 8df404b5f6a334..af11f547371815 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -47,7 +47,7 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
 	const unsigned long oil = get_eb_offset_in_folio(eb,		\
 							 member_offset);\
-	char *kaddr = folio_address(eb->folios[idx]);			\
+	char *kaddr = folio_address(eb->folios[idx]) + oil;		\
 	const int part = eb->folio_size - oil;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
@@ -57,14 +57,14 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	}								\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 || sizeof(u##bits) == 1 ||	\
 	    likely(sizeof(u##bits) <= part))				\
-		return get_unaligned_le##bits(kaddr + oil);		\
+		return get_unaligned_le##bits(kaddr);			\
 									\
 	if (sizeof(u##bits) == 2) {					\
-		lebytes[0] = *(kaddr + oil);				\
+		lebytes[0] = *kaddr;					\
 		kaddr = folio_address(eb->folios[idx + 1]);		\
 		lebytes[1] = *kaddr;					\
 	} else {							\
-		memcpy(lebytes, kaddr + oil, part);			\
+		memcpy(lebytes, kaddr, part);				\
 		kaddr = folio_address(eb->folios[idx + 1]);		\
 		memcpy(lebytes + part, kaddr, sizeof(u##bits) - part);	\
 	}								\
@@ -77,7 +77,7 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	const unsigned long idx = get_eb_folio_index(eb, member_offset);\
 	const unsigned long oil = get_eb_offset_in_folio(eb,		\
 							 member_offset);\
-	char *kaddr = folio_address(eb->folios[idx]);			\
+	char *kaddr = folio_address(eb->folios[idx]) + oil;		\
 	const int part = eb->folio_size - oil;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
@@ -87,16 +87,16 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	}								\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 || sizeof(u##bits) == 1 ||	\
 	    likely(sizeof(u##bits) <= part)) {				\
-		put_unaligned_le##bits(val, kaddr + oil);		\
+		put_unaligned_le##bits(val, kaddr);			\
 		return;							\
 	}								\
 	put_unaligned_le##bits(val, lebytes);				\
 	if (sizeof(u##bits) == 2) {					\
-		*(kaddr + oil) = lebytes[0];				\
+		*kaddr = lebytes[0];					\
 		kaddr = folio_address(eb->folios[idx + 1]);		\
 		*kaddr = lebytes[1];					\
 	} else {							\
-		memcpy(kaddr + oil, lebytes, part);			\
+		memcpy(kaddr, lebytes, part);				\
 		kaddr = folio_address(eb->folios[idx + 1]);		\
 		memcpy(kaddr, lebytes + part, sizeof(u##bits) - part);	\
 	}								\
-- 
2.49.0


