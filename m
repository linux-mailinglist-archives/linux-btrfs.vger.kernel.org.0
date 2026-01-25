Return-Path: <linux-btrfs+bounces-21009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OtfHzqhdmmOTAEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21009-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 00:03:22 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC2283117
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 00:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FD7230ACCD1
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jan 2026 22:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A69310771;
	Sun, 25 Jan 2026 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bAicJgwQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bAicJgwQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87B31619E
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381392; cv=none; b=CwfJP9KbzYp5pJyTbu/CTI7yQKcFupBxu3+VcGs4cPkY1/S6tgsxbVWs1dpjOt2L+56w2XefTnXFXh+FiRk3ySrTXYz9t7XCNauEJlJvydnyPwXcU/HYdDgzlZYaQIRr/JwI4wqazoDTP7hrh9RfRKlfPt0n+lLmRQ0B3l3ystg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381392; c=relaxed/simple;
	bh=fcKl/9Puu5V5Qk5m893F/MFHYWxHO8Ppb+gYVWZrNAA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP0dwZFybVJPThrYCaIQO9ezUQgd1IqOL9ur1GCcF4SLxUECWAa3Xj15hXjJlLs4ImxtX2pR4whU7x9h+7Kk22eRw7UlKK4iELd713Mw0YL4eVHmzRugXVse1CpjpD0IhuewyFjIydOBPMPXuSyBgyGHT/h/tUoMnv4bYBg0Wlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bAicJgwQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bAicJgwQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5547933683
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTJffkD/e1lc+BNaEZQ8W6fnG8GefnGfMRM9olA8Alg=;
	b=bAicJgwQSyT4KMLak0TBfI8oK+sTU1qsYNGEO0EsMweXIrGgdGuXxxpk7rIF1vG9h6vOSl
	g2MVt4IaLxd89NxJEIV/n5gcmg7Waif44YiZP5mvqtxNXVqEuykvm+qEMtBoYYwFCssaiB
	l/5ucigF5E/Yv5eFWo5La3XmlMn+16s=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769381363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTJffkD/e1lc+BNaEZQ8W6fnG8GefnGfMRM9olA8Alg=;
	b=bAicJgwQSyT4KMLak0TBfI8oK+sTU1qsYNGEO0EsMweXIrGgdGuXxxpk7rIF1vG9h6vOSl
	g2MVt4IaLxd89NxJEIV/n5gcmg7Waif44YiZP5mvqtxNXVqEuykvm+qEMtBoYYwFCssaiB
	l/5ucigF5E/Yv5eFWo5La3XmlMn+16s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DA59139E9
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IHl2O/GddmnSTAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 22:49:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] btrfs: get rid of compressed_bio::compressed_folios[]
Date: Mon, 26 Jan 2026 09:18:48 +1030
Message-ID: <43875b1445e7b2411376c493e9f9c3f4707cf5cb.1769381237.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769381237.git.wqu@suse.com>
References: <cover.1769381237.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21009-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: CBC2283117
X-Rspamd-Action: no action

Now there is no one utilizing that member, we can safely remove it along
with compressed_bio::nr_folios member.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 2 --
 fs/btrfs/compression.h | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c7e2a1fcf5f8..67db96629210 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -240,7 +240,6 @@ static void end_bbio_compressed_read(struct btrfs_bio *bbio)
 	btrfs_bio_end_io(cb->orig_bbio, status);
 	bio_for_each_folio_all(fi, &bbio->bio)
 		btrfs_free_compr_folio(fi.folio);
-	kfree(cb->compressed_folios);
 	bio_put(&bbio->bio);
 }
 
@@ -301,7 +300,6 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 	/* Note, our inode could be gone now. */
 	bio_for_each_folio_all(fi, &bbio->bio)
 		btrfs_free_compr_folio(fi.folio);
-	kfree(cb->compressed_folios);
 	bio_put(&cb->bbio.bio);
 }
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index ecbcd0a8364a..4dcb75c78ade 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -42,12 +42,6 @@ static_assert((BTRFS_MAX_COMPRESSED % PAGE_SIZE) == 0);
 #define	BTRFS_ZLIB_DEFAULT_LEVEL		3
 
 struct compressed_bio {
-	/* Number of compressed folios in the array. */
-	unsigned int nr_folios;
-
-	/* The folios with the compressed data on them. */
-	struct folio **compressed_folios;
-
 	/* starting offset in the inode for our pages */
 	u64 start;
 
-- 
2.52.0


