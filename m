Return-Path: <linux-btrfs+bounces-22092-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEPNJJA1omnR0wQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22092-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 01:23:44 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1791BF645
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 01:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF09A3058E07
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 00:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CBE2367B3;
	Sat, 28 Feb 2026 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cDNk0rNX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cDNk0rNX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B077368978
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238221; cv=none; b=PBktDk3P5yB6yT5mErO+apBH5qCeFHMbf/lvfPvcrADJWT7nhx6Sk8m/cfYE0XBh/ARA9HBqFwg9JuWQ5bgqU5ziTMo6A27G7tixJL92dpdYWMW5DYHyAUd9opea+nHuwHORTv3ZodToAtNwojLMifEmLhmikbwCUYyrpN0VsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238221; c=relaxed/simple;
	bh=/wYIO3EGZchpbL0lmvE/8Ds3Lrz0Ypsc9utka5LD1P4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQTqyT6PyktPnKWUtCS2SSqSuhBXD5cwM+P+EUoktbx4jBfS0MsOkFkLIxfeqQKJy95BHhR715dTMj3wE37UIK3poJVMbsjOe7RMYWZjRhmtvNSIMHFcn4bARmhF8yyacJ5RVIZMt2XypzqHBvtct2pJS6aIcxlo0kEoeuYK49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cDNk0rNX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cDNk0rNX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 848813F9C4
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772238212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnDkTsBYg6YqYWqVUJUdYkJ7T3U/Z64e9L2SV+tiuOc=;
	b=cDNk0rNXDKZHaGtkwYYs4XC3974eziT8bI9tXiO1eg2X4jPoBW6rfPh5KquMPhZL0E5ANg
	7kuIR2OnFQ1lE43IgrQ+lR+9zE8pEOzES8cF/P6S5S8znW6ihWSV6aJyRSY6pAEa/4lZcC
	vfaoq0IwOKvNKjD+Gg3cvX0bpPxq0BE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1772238212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnDkTsBYg6YqYWqVUJUdYkJ7T3U/Z64e9L2SV+tiuOc=;
	b=cDNk0rNXDKZHaGtkwYYs4XC3974eziT8bI9tXiO1eg2X4jPoBW6rfPh5KquMPhZL0E5ANg
	7kuIR2OnFQ1lE43IgrQ+lR+9zE8pEOzES8cF/P6S5S8znW6ihWSV6aJyRSY6pAEa/4lZcC
	vfaoq0IwOKvNKjD+Gg3cvX0bpPxq0BE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF61E3EA65
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2KkDIIM1omkgbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 00:23:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix the incorrect freeing of a compression folio in btrfs_submit_compressed_read()
Date: Sat, 28 Feb 2026 10:53:11 +1030
Message-ID: <e215406b40140104da3357b3d5bfd18ee7dfecff.1772238005.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772238005.git.wqu@suse.com>
References: <cover.1772238005.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22092-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F1791BF645
X-Rspamd-Action: no action

[BUG]
Commit dafcfa1c8e37 ("btrfs: get rid of compressed_folios[] usage for
compressed read") changed how we allocate folios for a compressed read.

Previously we allocate an array of folios for the compressed read.
But now we require all folios to be allocated and freed by
btrfs_alloc_compr_folios() and btrfs_free_compr_folios() to use the
cached folio pool.

Unfortunately we only use btrfs_alloc_compr_folio() but not pairing it
with btrfs_free_compr_folio().

This can lead to problems as a compr folio has maintained its own RCU
list, not releasing it from the RCU list can lead to various problems.

[FIX]
Use btrfs_free_compr_folio() to replace the regular folio_put() call.

Fixes: dafcfa1c8e37 ("btrfs: get rid of compressed_folios[] usage for compressed read")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 192f133d9eb5..dd004b1cc4ef 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -576,7 +576,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 
 		ret = bio_add_folio(&cb->bbio.bio, folio, cur_len, 0);
 		if (unlikely(!ret)) {
-			folio_put(folio);
+			btrfs_free_compr_folio(folio);
 			ret = -EINVAL;
 			goto out_free_bio;
 		}
-- 
2.53.0


