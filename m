Return-Path: <linux-btrfs+bounces-15176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F2AF01AE
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 19:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA7587A54A3
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jul 2025 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4033327F4D5;
	Tue,  1 Jul 2025 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nTT82JVd";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KRnu5TZ5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5AF22B585
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Jul 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751390654; cv=none; b=fPCnxMXJPRDRUbufY25WR1lyTXxO0eozL0qg/SVkelfqEyZbzyQb3dzyczqRL/vywyKmOwKfSw+G9O5WspGpdTTyDkgA2WQN/ob+ORx1ru8KsBcwkltRSiBlYTnMMyQN5U0EKyjqdsRAGGhjk0Dt6y3tiSe2kUcvTr2ggQZOJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751390654; c=relaxed/simple;
	bh=Vf47a4Cx9PXV8uTj/i32/fy9ArP344qZJPMHr7AM4Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJESbVJcokDNHGpgAwm5j+G23zGqjE9lBfi9miQWKZ0K+1q6ymMKTlkZ3Pm0kPMU8ku37uzNysF3zfJicV2sUhjKQxod1xEwJK5XRRjmzYHcYrMJvza3dbzS3Rpot1yejmLUl1EfrT+8nnOJW3gHzhERhZMe5evXS1oBmlVD8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nTT82JVd; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KRnu5TZ5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4DD91F453;
	Tue,  1 Jul 2025 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6zwf+2yPZQHYvRxCtjr70pzfNnTSR4W1K4e6rRP8yo=;
	b=nTT82JVdkgfNdWIGp864tlSZ58HdqFWNYhiodvoSZktU96tvm6T7m0XJEqQa7ZM6P/X5T6
	GtFPKgwvPAmAT5bRUZqXPVabZQe6yaaJ0wrEmjzYTy/4EuNZ0CQhuNAoox8AIqURRnXuHM
	CsF801kZ0N3dNmco3XkMSw917gSy6Ag=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KRnu5TZ5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751390647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6zwf+2yPZQHYvRxCtjr70pzfNnTSR4W1K4e6rRP8yo=;
	b=KRnu5TZ5aySOrZz9fkfug4wPp9hr6b2Rf1nSkfitVhoVaQ2+B+L/kZ454/9TjVZ47blgdQ
	Ffxq+iaiw2etIubnXvV+WdT1mFSgewCJAaDMY+IBDW9z+fc+wBSkzy25ki5TNOStKFBUIX
	Rne6H0cNJn08R31Jph8o9LS9NE33OmI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD48C13890;
	Tue,  1 Jul 2025 17:24:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W5ADNrcZZGg7RgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 01 Jul 2025 17:24:07 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/7] btrfs: accessors: inline eb bounds check and factor out the error report
Date: Tue,  1 Jul 2025 19:23:50 +0200
Message-ID: <a4b1c3cd286c9217d277e67af4c11a321af6863a.1751390044.git.dsterba@suse.com>
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E4DD91F453
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

There's a check in each set/get helper if the requested range is within
extent buffer bounds, and if it's not then report it. This was in an
ASSERT statement so with CONFIG_BTRFS_ASSERT this crashes right away, on
other configs this is only reported but reading out of the bounds is
done anyway. There are currently no known reports of this particular
condition failing.

There are some drawbacks though. The behaviour dependence on the
assertions being compiled in or not and a less visible effect of
inlining report_setget_bounds() into each helper.

As the bounds check is expected to succeed almost always it's ok to
inline it but make the report a function and move it out of the helper
completely (__cold puts it to a different section). This also skips
reading/writing the requested range in case it fails.

This improves stack usage significantly:

  btrfs_get_16                                         -48 (80 -> 32)
  btrfs_get_32                                         -48 (80 -> 32)
  btrfs_get_64                                         -48 (80 -> 32)
  btrfs_get_8                                          -48 (72 -> 24)
  btrfs_set_16                                         -56 (88 -> 32)
  btrfs_set_32                                         -56 (88 -> 32)
  btrfs_set_64                                         -56 (88 -> 32)
  btrfs_set_8                                          -48 (80 -> 32)

  NEW (48):
	  report_setget_bounds                                     48
  LOST/NEW DELTA:      +48
  PRE/POST DELTA:     -360

Same as .ko size:

     text    data     bss     dec     hex filename
  1456079  115665   16088 1587832  183a78 pre/btrfs.ko
  1454951  115665   16088 1586704  183610 post/btrfs.ko

  DELTA: -1128

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/accessors.c b/fs/btrfs/accessors.c
index 2e90b9b14e73f4..a7b6b2d7bde224 100644
--- a/fs/btrfs/accessors.c
+++ b/fs/btrfs/accessors.c
@@ -9,20 +9,15 @@
 #include "fs.h"
 #include "accessors.h"
 
-static bool check_setget_bounds(const struct extent_buffer *eb,
-				const void *ptr, unsigned off, int size)
+static void __cold report_setget_bounds(const struct extent_buffer *eb,
+					const void *ptr, unsigned off, int size)
 {
-	const unsigned long member_offset = (unsigned long)ptr + off;
+	unsigned long member_offset = (unsigned long)ptr + off;
 
-	if (unlikely(member_offset + size > eb->len)) {
-		btrfs_warn(eb->fs_info,
-		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
-			(member_offset > eb->len ? "start" : "end"),
-			(unsigned long)ptr, eb->start, member_offset, size);
-		return false;
-	}
-
-	return true;
+	btrfs_warn(eb->fs_info,
+		   "bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
+		   (member_offset > eb->len ? "start" : "end"),
+		   (unsigned long)ptr, eb->start, member_offset, size);
 }
 
 /*
@@ -56,7 +51,10 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	const int part = eb->folio_size - oil;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
-	ASSERT(check_setget_bounds(eb, ptr, off, sizeof(u##bits)));	\
+	if (unlikely(member_offset + sizeof(u##bits) > eb->len)) {	\
+		report_setget_bounds(eb, ptr, off, sizeof(u##bits));	\
+		return 0;						\
+	}								\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 || likely(sizeof(u##bits) <= part))	\
 		return get_unaligned_le##bits(kaddr + oil);		\
 									\
@@ -76,7 +74,10 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	const int part = eb->folio_size - oil;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
-	ASSERT(check_setget_bounds(eb, ptr, off, sizeof(u##bits)));	\
+	if (unlikely(member_offset + sizeof(u##bits) > eb->len)) {	\
+		report_setget_bounds(eb, ptr, off, sizeof(u##bits));	\
+		return;							\
+	}								\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 ||				\
 	    likely(sizeof(u##bits) <= part)) {				\
 		put_unaligned_le##bits(val, kaddr + oil);		\
-- 
2.49.0


