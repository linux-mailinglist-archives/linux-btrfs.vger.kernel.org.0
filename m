Return-Path: <linux-btrfs+bounces-15329-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1705BAFCE51
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 16:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8534A1684E7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686752DE216;
	Tue,  8 Jul 2025 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EFocJMnq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EFocJMnq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42A235371
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986579; cv=none; b=j2gYRe/zasWrNl7ZgsGMUXzgAY36mDqpTMkldR0Gsf5AqjjlHxbuySpE8+rP9lR5QsX10cSj5KChB6M2GWCtEg2Wd9tdCIftmoB3ZLzggqGOck6Jgor1LwSYV+qt/xMcvvjer73vI/HszBmARM8KdFUBhZceT6fs/KqFLDquqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986579; c=relaxed/simple;
	bh=qJnuS81/8TzqFF3vl6Tl5pG0iKkDpSZzU5J0Y1e0sxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I00ZriCBk3kCw5RsBL5/Lg/jnPTmrrBaNLivmgUVfMemfZZpiGVw/NK/4dmRfNy6I6PzfQXmgRAK71gvb4jfHUqMFcWjNfCkeZHPLsgnkp2rhZDHyc6VOEfbfuC6ByaveaNqnw7mxb6+XtbHm6jC214BA773Z9EsLKEns+6aoLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EFocJMnq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EFocJMnq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D01071F38D;
	Tue,  8 Jul 2025 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751986575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0ghi5pS+YJhfwMyG8uBV8UOhKyUqwktcyPVB1qeMWTI=;
	b=EFocJMnqKzkif4s0co44OEHoJXkUoNTZjdaQXlKzB7ye+1XAVOtAU5Bh6JDTWYogetnuU2
	p4+hEWfsW7spHFQQIMr8y+Q9WVloJy9a9FdPj/wdxAdEqbpmp45cxH0L1XGs+IX1C1tvy0
	MivjlApLrdo+XDwXGteWazM1UdHnLFo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EFocJMnq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751986575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0ghi5pS+YJhfwMyG8uBV8UOhKyUqwktcyPVB1qeMWTI=;
	b=EFocJMnqKzkif4s0co44OEHoJXkUoNTZjdaQXlKzB7ye+1XAVOtAU5Bh6JDTWYogetnuU2
	p4+hEWfsW7spHFQQIMr8y+Q9WVloJy9a9FdPj/wdxAdEqbpmp45cxH0L1XGs+IX1C1tvy0
	MivjlApLrdo+XDwXGteWazM1UdHnLFo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3C9613A68;
	Tue,  8 Jul 2025 14:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UVUFL48xbWhiUgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 08 Jul 2025 14:56:15 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use clear_and_wake_up_bit() where open coded
Date: Tue,  8 Jul 2025 16:56:13 +0200
Message-ID: <20250708145613.20769-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D01071F38D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

There are two cases open coding the clear and wake up pattern, we can
use the helper.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 685ee685ce92..6192e1f58860 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2060,10 +2060,7 @@ static void end_bbio_meta_write(struct btrfs_bio *bbio)
 	}
 
 	buffer_tree_clear_mark(eb, PAGECACHE_TAG_WRITEBACK);
-	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
-	smp_mb__after_atomic();
-	wake_up_bit(&eb->bflags, EXTENT_BUFFER_WRITEBACK);
-
+	clear_and_wake_up_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
 	bio_put(&bbio->bio);
 }
 
@@ -3682,9 +3679,7 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 
 static void clear_extent_buffer_reading(struct extent_buffer *eb)
 {
-	clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
-	smp_mb__after_atomic();
-	wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
+	clear_and_wake_up_bit(EXTENT_BUFFER_READING, &eb->bflags);
 }
 
 static void end_bbio_meta_read(struct btrfs_bio *bbio)
-- 
2.49.0


