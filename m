Return-Path: <linux-btrfs+bounces-21099-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBS4Ex8teGl7oQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21099-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:12:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CFC8F71D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 04:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B2663017240
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 03:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39F2FF16F;
	Tue, 27 Jan 2026 03:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hg4iCwOO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hg4iCwOO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B122FD7A7
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483488; cv=none; b=hgSvB6CQ5lHyALvTa444o9kNUis+H/WKUFCL9w4SPM4/PYxkYg0NMxyHFOR8dWIn5B5zthoJmyJa8B/4G74m2ySd+ihat1fey0N/0H7SvjzsgWp+t86s8RcAVIWsoBerQoqjc87i+cpXFLjmaY+SG5F0wN69IuE96GiPW0Rek08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483488; c=relaxed/simple;
	bh=PvriWESOZixcPxiPQVrPc4W4GjVs06nsmxAZ2QALupU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcGzA2st1gp+nN7ZUMznQJLqTH2WYGrTp/JZHJmDthzabJFKBZtcGk/KXWJpWAZEbMCDem7gGMKa+//EYNClRVHNx/TdpMz+CyHsIAeNN5uAKpEfo225qaULkEIZXWmvjHwD5JsiY63WGRdvta+5BrNbLkU3lpAVxu1+j8VEtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hg4iCwOO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hg4iCwOO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68F065BCD9
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769483477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZR2App273Rd519nZWiZJIgVTww7n3VE40VBTJSrMeA=;
	b=Hg4iCwOOYDG1nNYsWvsUbzLsRgAIYK406B4x/jCtQ6Tv0Gw5eTJTqrgJy2zCjhvqLL71NT
	QJ5I1YrY25a3JiLONqigigvbWKW1M7J4I3assNNh2A03h0wKKVkehAqYIjKUj/l63OZuo5
	sAcWCgoisnNHW//Ff/IzrYnsoaFwEN4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Hg4iCwOO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769483477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZR2App273Rd519nZWiZJIgVTww7n3VE40VBTJSrMeA=;
	b=Hg4iCwOOYDG1nNYsWvsUbzLsRgAIYK406B4x/jCtQ6Tv0Gw5eTJTqrgJy2zCjhvqLL71NT
	QJ5I1YrY25a3JiLONqigigvbWKW1M7J4I3assNNh2A03h0wKKVkehAqYIjKUj/l63OZuo5
	sAcWCgoisnNHW//Ff/IzrYnsoaFwEN4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B45F13712
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yDaaAtQseGnFewAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 03:11:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 9/9] btrfs: get rid of compressed_bio::compressed_folios[]
Date: Tue, 27 Jan 2026 13:40:42 +1030
Message-ID: <6a307460d479ced80b9b19952ccd311c4df656ea.1769482298.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769482298.git.wqu@suse.com>
References: <cover.1769482298.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21099-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: E3CFC8F71D
X-Rspamd-Action: no action

Now there is no one utilizing that member, we can safely remove it along
with compressed_bio::nr_folios member.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 1 -
 fs/btrfs/compression.h | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 205f6828c1e6..ebada0b64846 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -300,7 +300,6 @@ static void end_bbio_compressed_write(struct btrfs_bio *bbio)
 	/* Note, our inode could be gone now. */
 	bio_for_each_folio_all(fi, &bbio->bio)
 		btrfs_free_compr_folio(fi.folio);
-	kfree(cb->compressed_folios);
 	bio_put(&cb->bbio.bio);
 }
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 2d3a28b26997..65b8bc4bbe0b 100644
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


