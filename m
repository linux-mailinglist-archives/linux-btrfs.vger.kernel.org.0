Return-Path: <linux-btrfs+bounces-16840-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE05B58777
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 00:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923C72080AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 22:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366B22C0F6E;
	Mon, 15 Sep 2025 22:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f1qdX1Vw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="f1qdX1Vw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9DA2BF3DB
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 22:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975069; cv=none; b=tPHOI5/y6d8uuLQNs6TaKlO1IsAFjvuvmC2Rj1M2dVq20X1fUgu3w4gPU8Dnt3qZZxAIMLzhm9xUdOUBmnEywnCFrdlkrUNr8xUvnjXwO2ia7ispbvqQqlIhEWbh1/i+gI9weJL/LmUVkjCXf5EeiX8gjWuc7rR9I7MY5868Kl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975069; c=relaxed/simple;
	bh=oiYkKD23ZR1OJaKpN9FO4AEOUo34MVhFwEYOT2/bR+g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=U6k1KEK7zuITIDwmqtQWOdOxdvg5FvcevGIZjaS7bBEvs/69vcR7T2FpTcFASFTDNdtVfXXIlHb9waoOzEpy+vmoKCc+Kr/s52awclnWu4jtxVfSkhbhHZATOtlShmr2EUXZWzRJSQm4eyLHL6IfrlHhdFvaUJUUroHHsBl79WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f1qdX1Vw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=f1qdX1Vw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 140971F8B6
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 22:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757975065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iiRESpXvF7MzA06d9p22RH2GJBkLv0HpBdRNR930Qe8=;
	b=f1qdX1VwGTTI+YPKOLZcWXvvFTAaDVKqNDN7WHPUO628eRzbWOoZh3OnNvLKiSAKG5CRsp
	H5bMvIq0b9dZ6k53S/sXdbynfOi73wMwAGLqcs+yilqHntCZlI4RsQzQXe6LzzJgpzsqxz
	6+w5uObszSMKrCgCKWYxXDGjvYG87Vk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=f1qdX1Vw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757975065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iiRESpXvF7MzA06d9p22RH2GJBkLv0HpBdRNR930Qe8=;
	b=f1qdX1VwGTTI+YPKOLZcWXvvFTAaDVKqNDN7WHPUO628eRzbWOoZh3OnNvLKiSAKG5CRsp
	H5bMvIq0b9dZ6k53S/sXdbynfOi73wMwAGLqcs+yilqHntCZlI4RsQzQXe6LzzJgpzsqxz
	6+w5uObszSMKrCgCKWYxXDGjvYG87Vk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 509271372E
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 22:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O7kUBRiSyGigdQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 22:24:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tree-checker: fix the incorrect inode ref size check
Date: Tue, 16 Sep 2025 07:54:06 +0930
Message-ID: <b01a9d93d21d7be986b45b84baffc3237e5ec3e5.1757975029.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 140971F8B6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[BUG]
Inside check_inode_ref(), we need to make sure every structure,
including the btrfs_inode_extref header, is covered by the item.

But our code is incorrectly using "sizeof(iref)", where @iref is just a
pointer.

This means "sizeof(iref)" will always be "sizeof(void *)", which is much
smaller than "sizeof(struct btrfs_inode_extref)".

This will allow some bad inode extrefs to sneak in, defeating
tree-checker.

[FIX]
Fix the typo by calling "sizeof(*iref)", which is the same as
"sizeof(struct btrfs_inode_extref)", and will be the correct behavior we
want.

Fixes: 71bf92a9b877 ("btrfs: tree-checker: Add check for INODE_REF")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 0b3d9d11f098..c2aac08055fb 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1756,10 +1756,10 @@ static int check_inode_ref(struct extent_buffer *leaf,
 	while (ptr < end) {
 		u16 namelen;
 
-		if (unlikely(ptr + sizeof(iref) > end)) {
+		if (unlikely(ptr + sizeof(*iref) > end)) {
 			inode_ref_err(leaf, slot,
 			"inode ref overflow, ptr %lu end %lu inode_ref_size %zu",
-				ptr, end, sizeof(iref));
+				ptr, end, sizeof(*iref));
 			return -EUCLEAN;
 		}
 
-- 
2.50.1


