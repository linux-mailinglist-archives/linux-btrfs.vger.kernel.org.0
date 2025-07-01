Return-Path: <linux-btrfs+bounces-15179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8509AF01B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 19:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6153B1892DEE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4303A27FD5B;
	Tue,  1 Jul 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lkeHdgqs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lkeHdgqs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9D27F728
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390661; cv=none; b=JoPqlLSZJpEvKf6htdYZOde+IP+LzhTIHeOIddXOY0LnU9/WqRfZ0atK94tEXyZ/6GAwh39azB6RSFH74wqEesAcKL76a4n8rqpTBziC0/BG2MrUkxPxkvruKloU1J5K4NX0Ad/zgQssEeG5kTCfCY+WATHNX4uElg3LNGHqAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390661; c=relaxed/simple;
	bh=BMozkw8swB19AmS7YO+PIFeuCLqPVqQtTotdshZ942Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSWHBz8Kz0E2qiBGAjFm23q3Sl/kTe7mpzy6Qpmhqc96KX+6ISqrNIehkBowlOz9PKUNJZIfyHQ8dearf5xMxIA4ww4trUaEnxSOymuZHgAZv8TR4RKbyaPeaVrgb7iTC4VkPAeeFiHCVzzbRZxBuAVwrrLn+FCZgHt8DYBtFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lkeHdgqs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lkeHdgqs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 655A821188;
	Tue,  1 Jul 2025 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHNMToX3Zkgg1v6Fz5LHWkpwnbO6Mb2Yt3vom4Y/hRE=;
	b=lkeHdgqs6Q2C7wL5rha7M7SiuI6rdDwC1+x7dar5kBTpubJSO7eVdI1uZVCpPI8Yc0pRbM
	/VA7RMoPl1PKIGKHArWyBLwG/uUbMafbyu1wZQfoEvdcxb+xkbqXolbcty6LrpUu6cfczy
	seyUy3ODhdD3jtDOuHdSk7SCAGZeL2k=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHNMToX3Zkgg1v6Fz5LHWkpwnbO6Mb2Yt3vom4Y/hRE=;
	b=lkeHdgqs6Q2C7wL5rha7M7SiuI6rdDwC1+x7dar5kBTpubJSO7eVdI1uZVCpPI8Yc0pRbM
	/VA7RMoPl1PKIGKHArWyBLwG/uUbMafbyu1wZQfoEvdcxb+xkbqXolbcty6LrpUu6cfczy
	seyUy3ODhdD3jtDOuHdSk7SCAGZeL2k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ECA913890;
	Tue,  1 Jul 2025 17:24:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /74kF7wZZGhDRgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Jul 2025 17:24:12 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 5/7] btrfs: accessors: compile-time fast path for u16
Date: Tue,  1 Jul 2025 19:23:52 +0200
Message-ID: <198113696d29a3f31ee364533d224cdabae14382.1751390044.git.dsterba@suse.com>
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

Reading/writing 2 bytes (u16) may need 2 folios to be written to, each
time it's just one byte so using memcpy for that is an overkill.
Add a branch for the split case so that memcpy is now used for u32 and
u64. Another side effect is that the u16 types now don't need additional
stack space, everything fits to registers.

Stack usage is reduced:

  btrfs_get_16                                           -8 (32 -> 24)
  btrfs_set_16                                          -16 (32 -> 16)

Code size reduction:

     text    data     bss     dec     hex filename
  1454691  115665   16088 1586444  18350c pre/btrfs.ko
  1454459  115665   16088 1586212  183424 post/btrfs.ko

  DELTA: -232

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 547e9f8fb87d61..8df404b5f6a334 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -59,9 +59,15 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	    likely(sizeof(u##bits) <= part))				\
 		return get_unaligned_le##bits(kaddr + oil);		\
 									\
-	memcpy(lebytes, kaddr + oil, part);				\
-	kaddr = folio_address(eb->folios[idx + 1]);			\
-	memcpy(lebytes + part, kaddr, sizeof(u##bits) - part);		\
+	if (sizeof(u##bits) == 2) {					\
+		lebytes[0] = *(kaddr + oil);				\
+		kaddr = folio_address(eb->folios[idx + 1]);		\
+		lebytes[1] = *kaddr;					\
+	} else {							\
+		memcpy(lebytes, kaddr + oil, part);			\
+		kaddr = folio_address(eb->folios[idx + 1]);		\
+		memcpy(lebytes + part, kaddr, sizeof(u##bits) - part);	\
+	}								\
 	return get_unaligned_le##bits(lebytes);				\
 }									\
 void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
@@ -84,11 +90,16 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 		put_unaligned_le##bits(val, kaddr + oil);		\
 		return;							\
 	}								\
-									\
 	put_unaligned_le##bits(val, lebytes);				\
-	memcpy(kaddr + oil, lebytes, part);				\
-	kaddr = folio_address(eb->folios[idx + 1]);			\
-	memcpy(kaddr, lebytes + part, sizeof(u##bits) - part);		\
+	if (sizeof(u##bits) == 2) {					\
+		*(kaddr + oil) = lebytes[0];				\
+		kaddr = folio_address(eb->folios[idx + 1]);		\
+		*kaddr = lebytes[1];					\
+	} else {							\
+		memcpy(kaddr + oil, lebytes, part);			\
+		kaddr = folio_address(eb->folios[idx + 1]);		\
+		memcpy(kaddr, lebytes + part, sizeof(u##bits) - part);	\
+	}								\
 }
 
 DEFINE_BTRFS_SETGET_BITS(8)
-- 
2.49.0


