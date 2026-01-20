Return-Path: <linux-btrfs+bounces-20745-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB7CD3BC3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 01:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F05E23043A54
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jan 2026 00:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E3C1FC0EA;
	Tue, 20 Jan 2026 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OIlQuGyO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OIlQuGyO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC90199FB0
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768867238; cv=none; b=OHRCkFdMAkSiK1ZlDH4kpTyed0jwSaMR/FgQ24K6VSlZ7gBxUN6HHLVD3DxfC1p/OZo1R6VO8lCU71kO9LEyGj421jBeq3qLeoZjQ+IPN6Rp3okGL1CxiteKOwk+hKPX6FiTet+0ez5G9H/6EAtFqk5KxvrL1u8ZtvpEnxWsFNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768867238; c=relaxed/simple;
	bh=sPN/urd6wFdDYu/qRYrKCs4bcUfEoRsQH/36neIQReY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8s4aJZe5Fo4f5XAVTRZnycRkz7m1JgH8X4oDsUlf/MS6fMDhbOh5CbKqMJL6MveKyxMFgUg6kMN2BsbbaPpkYXYcmcpjlrWgBRa8pM+TNf0l3gIm29hVIZ3vGFQdFaRQQU3aHilUbsU2pMLhtv8YVNNm4wXZyzasO/CLvfvS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OIlQuGyO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OIlQuGyO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6A285BCC5
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768867234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqR4vPAjcconKHf1b5h2DiJjteKbc5RtBt3WsjJJ4Fg=;
	b=OIlQuGyO9jJaqpehdiM7He7l+qKJekNbrlpJyT6JE3+qNQ2wl04qICZHA8Rufd22QMNeQm
	GjNOnBgNs99U6Nobm+YoOJ15prIsflfcluGRHlgF9q6QAjvvlTqToF/yW0xjyrIEVWb/XS
	UJEgZHu3zvBnt6OURUhp/g4OWpBoGxw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OIlQuGyO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768867234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqR4vPAjcconKHf1b5h2DiJjteKbc5RtBt3WsjJJ4Fg=;
	b=OIlQuGyO9jJaqpehdiM7He7l+qKJekNbrlpJyT6JE3+qNQ2wl04qICZHA8Rufd22QMNeQm
	GjNOnBgNs99U6Nobm+YoOJ15prIsflfcluGRHlgF9q6QAjvvlTqToF/yW0xjyrIEVWb/XS
	UJEgZHu3zvBnt6OURUhp/g4OWpBoGxw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A99AD3EA63
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6AciFqHFbmlsGwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Jan 2026 00:00:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: use folio_iter to handle zstd_decompress_bio()
Date: Tue, 20 Jan 2026 10:30:10 +1030
Message-ID: <f2968ddc9ea1cd53a03752308438672018228843.1768866942.git.wqu@suse.com>
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
X-Spam-Score: -3.01
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A6A285BCC5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Currently zstd_decompress_bio() is using
compressed_bio->compressed_folios[] array to grab each compressed folio.

However cb->compressed_folios[] is just a pointer to each folio of the
compressed bio, meaning we can just replace the compressed_folios[]
array by just grabbing the folio inside the compressed bio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zstd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index c9cddcfa337b..737bc49652b0 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -589,7 +589,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 {
 	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
-	struct folio **folios_in = cb->compressed_folios;
+	struct folio_iter fi;
 	size_t srclen = cb->compressed_len;
 	zstd_dstream *stream;
 	int ret = 0;
@@ -612,7 +612,11 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 		goto done;
 	}
 
-	workspace->in_buf.src = kmap_local_folio(folios_in[folio_in_index], 0);
+	bio_first_folio(&fi, &cb->bbio.bio, 0);
+	ASSERT(fi.folio);
+	ASSERT(folio_size(fi.folio) == blocksize);
+
+	workspace->in_buf.src = kmap_local_folio(fi.folio, 0);
 	workspace->in_buf.pos = 0;
 	workspace->in_buf.size = min_t(size_t, srclen, min_folio_size);
 
@@ -660,8 +664,9 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 				goto done;
 			}
 			srclen -= min_folio_size;
-			workspace->in_buf.src =
-				kmap_local_folio(folios_in[folio_in_index], 0);
+			bio_next_folio(&fi, &cb->bbio.bio);
+			ASSERT(fi.folio);
+			workspace->in_buf.src = kmap_local_folio(fi.folio, 0);
 			workspace->in_buf.pos = 0;
 			workspace->in_buf.size = min_t(size_t, srclen, min_folio_size);
 		}
-- 
2.52.0


