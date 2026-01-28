Return-Path: <linux-btrfs+bounces-21138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Pe7BmJ3eWkSxQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21138-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 03:41:38 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC189C5C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 03:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 435313063D62
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 02:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9F929B200;
	Wed, 28 Jan 2026 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X1F1UxJ1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X1F1UxJ1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730192BEFEB
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769567873; cv=none; b=Brc82R6tGUjj5QUPteLXrqTxDT23nJkQa+CFPB54OBvuUW8DkiY7FKS8eCOseVyHjOlT8KSF14y7LeYPVoRBS7gmsrLfE6lOYv9Ju8BUXatS8X4yYMaePkb2GzczaOLfDNcA6TOSy1BhMJiIphhflaibP0VFSX/uJwQoRLYK378=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769567873; c=relaxed/simple;
	bh=PvriWESOZixcPxiPQVrPc4W4GjVs06nsmxAZ2QALupU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ8rdh8bWdJ2BEgTnIQSbWfY9BZY40YKnpJEAJR66rtWNqzW7ZSyN85gHuMliCocTWngQERA0uDRi23EL/n2cvmZwZ2JIc+QE7SiAMMa5XsX7jpUUDvZuiZ+7gaOzKi90svSfc1Gp5fEFM0c2Mgy0+VAeAW8qII38zB61w2bEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X1F1UxJ1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X1F1UxJ1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CCF333774
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769567862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZR2App273Rd519nZWiZJIgVTww7n3VE40VBTJSrMeA=;
	b=X1F1UxJ1/BR3nmFJAAwfLh12n+5N3x+cSJKoUBWTohoU3+bzrIE5HACR14RwdTpHNpSX3N
	5yq1RqKEAPDnNvKtcLrK1b8Uon7BtqWnZjigb5vHmlhAmzg2HAvs/OhK1hfF48BfDXyIoe
	1CNJLTnCN/P6aiUYsyRBI3d4e0zI5sM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=X1F1UxJ1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769567862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZR2App273Rd519nZWiZJIgVTww7n3VE40VBTJSrMeA=;
	b=X1F1UxJ1/BR3nmFJAAwfLh12n+5N3x+cSJKoUBWTohoU3+bzrIE5HACR14RwdTpHNpSX3N
	5yq1RqKEAPDnNvKtcLrK1b8Uon7BtqWnZjigb5vHmlhAmzg2HAvs/OhK1hfF48BfDXyIoe
	1CNJLTnCN/P6aiUYsyRBI3d4e0zI5sM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97C183EA61
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qMYVEnV2eWkbZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 02:37:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 9/9] btrfs: get rid of compressed_bio::compressed_folios[]
Date: Wed, 28 Jan 2026 13:07:08 +1030
Message-ID: <d32033d13692c66cae6951521b839b0fe8831adb.1769566870.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769566870.git.wqu@suse.com>
References: <cover.1769566870.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
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
	TAGGED_FROM(0.00)[bounces-21138-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7BC189C5C5
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


