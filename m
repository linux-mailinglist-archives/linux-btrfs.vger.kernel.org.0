Return-Path: <linux-btrfs+bounces-12293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACD1A6234E
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 01:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9303BFC97
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 00:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94BBCA64;
	Sat, 15 Mar 2025 00:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="exsn3qxw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="exsn3qxw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4F2E338C
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999364; cv=none; b=ioR99E2ZGSi3RWHjdtXMCTuSjBw6+PoWDMnrwTaHa+jqcHYAQhUD/lAagEr+sLgCMVIO2AuXDxGzkYcfEuYTr1kPaJNeYDAAFkhqOuWZuk4rqOClUwyASgFI4iat5yB+uUqxDkpAavgYc1oxsOVxPD1obbKJg21aDkaDMXQBRT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999364; c=relaxed/simple;
	bh=AMo0teFZQPOplYGmrfNa7zZ761A95Mtq+7ue7N0AHMA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b34VRYOg+0Dk1LMSB0GtE5ZdVNfNQXC4bu/u5jh6wFLnwqy5HXsy0U2uGcYSdieOJ99TmpUE9OJobEZu+SGnoi3jwP3lYFk4FoTjJQiSfxdTvHVJZxX3HyJuAslJW8X2qVU0r7l9Ww11B2MPUO2dtDTrCqhdQcdZbiM6i9KyWOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=exsn3qxw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=exsn3qxw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39E4D1F388
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJGybrNsRbJ4jjB1ezrpKDXfpOKpkjP/4VV4kQqCIMk=;
	b=exsn3qxwy2Vo3T5TkjHhyOUTTTm9rAKFi8/ZBIu5qIXKqxKsWviOOVtVefOGsT1CJy3DAR
	gtW/JeG/RotGUGdcrEnvOvMqfyIoow8cRQhMYEPlbpyWgmKGafAj8ys4XNrWLOaL0Lsmed
	tXnUNVNp1ig/1YG1942+0xY07InnNM0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=exsn3qxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741999360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJGybrNsRbJ4jjB1ezrpKDXfpOKpkjP/4VV4kQqCIMk=;
	b=exsn3qxwy2Vo3T5TkjHhyOUTTTm9rAKFi8/ZBIu5qIXKqxKsWviOOVtVefOGsT1CJy3DAR
	gtW/JeG/RotGUGdcrEnvOvMqfyIoow8cRQhMYEPlbpyWgmKGafAj8ys4XNrWLOaL0Lsmed
	tXnUNVNp1ig/1YG1942+0xY07InnNM0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31F0613797
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uP/DM/7M1GegXAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 00:42:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/7] btrfs: send: remove the again label inside put_file_data()
Date: Sat, 15 Mar 2025 11:12:12 +1030
Message-ID: <8ccc8a146410fc48525cb5709c1521adf577838e.1741999217.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741999217.git.wqu@suse.com>
References: <cover.1741999217.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 39E4D1F388
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The again label is here to retry to get the folio for the current index.
When triggering that label, there is no increasement on the iterator.

So it can be replaced by a simple "continue" and remove the again label.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/send.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 0c8c58c4f29b..43c29295f477 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5280,7 +5280,6 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 		unsigned cur_len = min_t(unsigned, len,
 					 PAGE_SIZE - pg_offset);
 
-again:
 		folio = filemap_lock_folio(mapping, index);
 		if (IS_ERR(folio)) {
 			page_cache_sync_readahead(mapping,
@@ -5316,7 +5315,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 			if (folio->mapping != mapping) {
 				folio_unlock(folio);
 				folio_put(folio);
-				goto again;
+				continue;
 			}
 		}
 
-- 
2.48.1


