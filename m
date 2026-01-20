Return-Path: <linux-btrfs+bounces-20746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D6AD3BC3D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 01:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7343630490B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D31DF25F;
	Tue, 20 Jan 2026 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qU1iFRLs";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qU1iFRLs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0575199FB0
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867241; cv=none; b=TTxj1n9KBT1Kru+q/xCeJXcV1iOSWZd4p8/WiS4uLzly5uAokS8HFeGhqzirXQ9/lqqjCLDiYdANHNCr3hazDjeYgWS57MGzdAyne6JpIr5L9tOeNuTXDCVyUaclY/QD6TivCUdY57+o54DptvlTaSe/2fvNmcsw4OBJ+6DMJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867241; c=relaxed/simple;
	bh=0HFBiAE0tR8ECHpWDjQby4yVMeMwd7jO/qD3XBwL1SM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVh3vSEhlv1LG3sfXI7G7XFYcb8O7nmt+8gFDUysLTEdkSKNYnCRswP0q0qBaAHiCyNyWEpVr1EpRCNNZEAvv+okOF8RQXbNZmXwAAaK1dJ7A6gxvA1zs3JxsgaS5v25J18mXKNPhQnEq0eXE3F+ra8mZsb7OyVToEAkAWs9cww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qU1iFRLs; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qU1iFRLs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F7A0337BE
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768867233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67RqQOgzxrXgB8x1K44rOrbn1TWbgx9yIKx9toOhcss=;
	b=qU1iFRLsbh/kbQS4PK/qB3Ek0HFy9Urq9di2e2qxMulIrXFEJqdVjJLheIOnz6jnfC6XaZ
	xhX3Ai5404DU1+2+e6iqCWJ3pf3vU9FGKApA0ockC06y5LL018539oNtvhhf4PsAQ+DfQy
	MMAkXWX39PRjmh2G6afhCYoUc0IAcn4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qU1iFRLs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768867233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67RqQOgzxrXgB8x1K44rOrbn1TWbgx9yIKx9toOhcss=;
	b=qU1iFRLsbh/kbQS4PK/qB3Ek0HFy9Urq9di2e2qxMulIrXFEJqdVjJLheIOnz6jnfC6XaZ
	xhX3Ai5404DU1+2+e6iqCWJ3pf3vU9FGKApA0ockC06y5LL018539oNtvhhf4PsAQ+DfQy
	MMAkXWX39PRjmh2G6afhCYoUc0IAcn4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1206A3EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mH63LJ/FbmlsGwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: use folio_iter to handle zlib_decompress_bio()
Date: Tue, 20 Jan 2026 10:30:09 +1030
Message-ID: <41aeb34f3762084a1b302430dbbadc2a3158a3ee.1768866942.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768866942.git.wqu@suse.com>
References: <cover.1768866942.git.wqu@suse.com>
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
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 0F7A0337BE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Currently zlib_decompress_bio() is using
compressed_bio->compressed_folios[] array to grab each compressed folio.

However cb->compressed_folios[] is just a pointer to each folio of the
compressed bio, meaning we can just replace the compressed_folios[]
array by just grabbing the folio inside the compressed bio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zlib.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 10ed48d4a846..6871476e6ebf 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -338,18 +338,22 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
+	struct folio_iter fi;
 	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
 	int ret = 0, ret2;
 	int wbits = MAX_WBITS;
 	char *data_in;
 	size_t total_out = 0;
-	unsigned long folio_in_index = 0;
 	size_t srclen = cb->compressed_len;
-	unsigned long total_folios_in = DIV_ROUND_UP(srclen, min_folio_size);
 	unsigned long buf_start;
-	struct folio **folios_in = cb->compressed_folios;
 
-	data_in = kmap_local_folio(folios_in[folio_in_index], 0);
+	bio_first_folio(&fi, &cb->bbio.bio, 0);
+
+	/* We must have at least one folio here, and has the correct size. */
+	ASSERT(fi.folio);
+	ASSERT(folio_size(fi.folio) == min_folio_size);
+
+	data_in = kmap_local_folio(fi.folio, 0);
 	workspace->strm.next_in = data_in;
 	workspace->strm.avail_in = min_t(size_t, srclen, min_folio_size);
 	workspace->strm.total_in = 0;
@@ -404,12 +408,13 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		if (workspace->strm.avail_in == 0) {
 			unsigned long tmp;
 			kunmap_local(data_in);
-			folio_in_index++;
-			if (folio_in_index >= total_folios_in) {
+			bio_next_folio(&fi, &cb->bbio.bio);
+			if (!fi.folio) {
 				data_in = NULL;
 				break;
 			}
-			data_in = kmap_local_folio(folios_in[folio_in_index], 0);
+			ASSERT(folio_size(fi.folio) == min_folio_size);
+			data_in = kmap_local_folio(fi.folio, 0);
 			workspace->strm.next_in = data_in;
 			tmp = srclen - workspace->strm.total_in;
 			workspace->strm.avail_in = min(tmp, min_folio_size);
-- 
2.52.0


