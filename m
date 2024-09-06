Return-Path: <linux-btrfs+bounces-7870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5A696E90C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 07:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C162865BC
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 05:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B7B86250;
	Fri,  6 Sep 2024 05:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lNpvv8gr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lNpvv8gr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C73CF73
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599821; cv=none; b=Psk/Cm6FFQWYHPtesW4yYixiWoQA57nJ/D6kKJTB2icA1eeKP7hIiHPXtyFPlZv5ItrjfmNkuKS1zU9dZ4bjXk/o0yjb04dJwjVpZFkUpSm5kxkVtjK3ToQyz6fQjdiEXYJDclSa+RODkgMGwXUCJfrO9IM4CKfN2KMVcGlpUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599821; c=relaxed/simple;
	bh=aDevwAj8/r4LgHUE6vF9RATFhCch92FLaFsnbQFkAuQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cu90Pl38GbfaaD5nIo9H2DXSCjO93/U2xy9mlnhPzJ3uOpiZyuNoOdJ/NFVFH2ZsldaaU4vi7Jis+ceYre1Bg0nVqnAB9qzDSBldg0i84GP/3aYL4cfeUIqbqSTAkfIUhSQx8rEy0Sq3bPx0ff4uNvegev1umD5CvnUCx8zBijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lNpvv8gr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lNpvv8gr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 713CE1F88E
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725599817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEYvZM++balYg6+cO33NmqtqSZGKOkbCv0wFAVv93OI=;
	b=lNpvv8grChrqZjYcZ2Wo4vwtxyU29PFPEj1BLC5i/hm2xH0PXb5E37g8PJWyCiWEzSO+ZI
	nfWcY7SKY+Mm0faXF3JvAzX4Z5aLueBfJ6lRE8S0TK2aCZGFPloHcCWiudD8gHtgjW9QHc
	IBW+rwLXGNyhnj47TJnn55QuefhpLWU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lNpvv8gr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725599817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEYvZM++balYg6+cO33NmqtqSZGKOkbCv0wFAVv93OI=;
	b=lNpvv8grChrqZjYcZ2Wo4vwtxyU29PFPEj1BLC5i/hm2xH0PXb5E37g8PJWyCiWEzSO+ZI
	nfWcY7SKY+Mm0faXF3JvAzX4Z5aLueBfJ6lRE8S0TK2aCZGFPloHcCWiudD8gHtgjW9QHc
	IBW+rwLXGNyhnj47TJnn55QuefhpLWU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB2951395F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Sep 2024 05:16:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UMEFG0iQ2ma6DQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Sep 2024 05:16:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: zlib: make the compression path to handle sector size < page size
Date: Fri,  6 Sep 2024 14:46:20 +0930
Message-ID: <6b91a9dd123c0337f57df91255d930797e3339d8.1725599171.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725599171.git.wqu@suse.com>
References: <cover.1725599171.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 713CE1F88E
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Inside zlib_compress_folios(), each time we switch the input page cache,
the @start is increased by PAGE_SIZE.

But for the incoming compression support for sector size < page size
(previously we support compression only when the range is fully page
aligned), this is not going to handle the following case:

    0          32K         64K          96K
    |          |///////////||///////////|

@start has the initial value 32K, indicating the start filepos of the
to-be-compressed range.

And when grabbing the first page as input, we always call "start +=
PAGE_SIZE;".

But since @start is starting at 32K, it will be increased by 64K,
resulting it to be 96K for the next range, causing incorrect input range
and corruption for the future subpage compression.

Fix it by only increase @start by the input size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zlib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 100abc00b794..ddf0d5a448a7 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -194,7 +194,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 				pg_off = offset_in_page(start);
 				cur_len = btrfs_calc_input_length(orig_end, start);
 				data_in = kmap_local_folio(in_folio, pg_off);
-				start += PAGE_SIZE;
+				start += cur_len;
 				workspace->strm.next_in = data_in;
 				workspace->strm.avail_in = cur_len;
 			}
-- 
2.46.0


