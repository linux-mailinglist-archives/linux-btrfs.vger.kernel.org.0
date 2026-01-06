Return-Path: <linux-btrfs+bounces-20173-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D460ACF94F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 17:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AE93300A9B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F279A33342C;
	Tue,  6 Jan 2026 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FKVFck0b";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TEjjSjqx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A73C330B3A
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716493; cv=none; b=U55rFeKAiRSyJx0rX5yie0i6XRqI95UWJTY81CGzZBGV01UQIjHV4XBqqb2sxsdv3fF29jI9kK4DCz8Qr8Aoi10w+Gc/E70gDxqQnUaxHaXefBuJdqN6af7luJ6zcas+Eum7ElStjufOTkqcRDARigcPCnu1di1LCH017Iw+Zow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716493; c=relaxed/simple;
	bh=7Ws5yoKiyAYC6uSl1NNdBAPL+imgpzdEL6awNvXnPaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruvJ14BDZpCbYuzEbqzbXd6sZ9FeQapDWBThFIwhhRg/JxPVcO1i79uGDS5U0GkTxlvj9S3dHJ3bV9axiKXSnKXPr05lio36leOGggsFkP3m5BkGufYN9MU6xLgBtRcZtcAzUV391i1JccxWSYZXf/Hn/wEsG9bE1ZaOnNiBKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FKVFck0b; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TEjjSjqx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED2455BCD9;
	Tue,  6 Jan 2026 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6B2uXJocrtf8o9Dp+RFjdLV4AJExVul3F1u5pjVEX2E=;
	b=FKVFck0bVIIFGqMVfCjYMWNBQS5fJ5uIyrAVGJ5AVujF9+ubDNfmsTcWEtohfvurKeSw1k
	IRmqPrgEXQtq1hlpQPZjBww7wcUNyEK5pb7MX1+GOhKm3P8746iSbNbPqotCt7iY7IP6Oy
	/OwoRZo4180bpAMisvpETn4pdD+l+/U=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767716489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6B2uXJocrtf8o9Dp+RFjdLV4AJExVul3F1u5pjVEX2E=;
	b=TEjjSjqxRLlpyNPlaFqhOp2EsnuabX27DLDST1n9VUXOyAE462hZZoVZIenUuUmr1j4yaq
	r27jbvgc6HOucOgVz4Gs0pDr9hwSLVW7vNUNcYwtzVVyoxtJwTTiJhja+5CykgkKK4R+z0
	dIO9N++Ig3nFGdu7rou0ZBTi7oOLUfw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7DAB3EA63;
	Tue,  6 Jan 2026 16:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7rGWOIk2XWnYWQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 06 Jan 2026 16:21:29 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 12/12] btrfs: zstd: remove local variable nr_dest_folios in zstd_compress_folios()
Date: Tue,  6 Jan 2026 17:20:35 +0100
Message-ID: <3af91c534b1567e237a35d17241028f7c4d2b4dd.1767716314.git.dsterba@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1767716314.git.dsterba@suse.com>
References: <cover.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.978];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

The value of *out_folios does not change and nr_dest_folios is only a
local copy, we can remove it. This saves 8 bytes of stack.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/zstd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 75294302fe0530..40cc2a479be63e 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -408,10 +408,9 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 	struct folio *in_folio = NULL;  /* The current folio to read. */
 	struct folio *out_folio = NULL; /* The current folio to write to. */
 	unsigned long len = *total_out;
-	const unsigned long nr_dest_folios = *out_folios;
 	const u64 orig_end = start + len;
 	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
-	unsigned long max_out = nr_dest_folios * min_folio_size;
+	unsigned long max_out = *out_folios * min_folio_size;
 	unsigned int cur_len;
 
 	workspace->params = zstd_get_btrfs_parameters(workspace->req_level, len);
@@ -485,7 +484,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 		if (workspace->out_buf.pos == workspace->out_buf.size) {
 			*total_out += min_folio_size;
 			max_out -= min_folio_size;
-			if (nr_folios == nr_dest_folios) {
+			if (nr_folios == *out_folios) {
 				ret = -E2BIG;
 				goto out;
 			}
@@ -549,7 +548,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
 
 		*total_out += min_folio_size;
 		max_out -= min_folio_size;
-		if (nr_folios == nr_dest_folios) {
+		if (nr_folios == *out_folios) {
 			ret = -E2BIG;
 			goto out;
 		}
-- 
2.51.1


