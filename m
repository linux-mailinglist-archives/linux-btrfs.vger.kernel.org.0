Return-Path: <linux-btrfs+bounces-6979-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7553B947537
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 08:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1781F220BC
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 06:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6931428E3;
	Mon,  5 Aug 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KPQl3nhl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KPQl3nhl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A812B6C
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839224; cv=none; b=J34Tos23RdbmJUFy3iB30pz8/JH9mYIUnvR9LtEyA7PIffxrZafLPDgKi8zUhr2yPmMvWZTYH2aQI8ffCXo74orda8NjgEmHSPO5TH6qGAjZen82MF35PYelfa2ETByFIeFwfV68fUm+1pVaXI9aBuAKh7JmM2HLzjnB/7fCfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839224; c=relaxed/simple;
	bh=GCfM1L+aAfY2aVNca3r/RzdmPDP2iRq5J/y7ntlPe5Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tkvXzL1t+DFAHkgPBZTopfoS2tSvFElQjeTWnTHYULvXAg0tRZZhPh3UNFLjRk4Lyxs42T2Kd8xIi6NW4Ju+V1W2wBAZC2IDfEOhI6fGJ4ZHh6eKOwkM155L849IexK+JOpEbHu7GhFf4Zp8nTSvmATCXX1pyCFPCTDXuPn7F2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KPQl3nhl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KPQl3nhl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25F981FD09
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 06:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722839217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=awyQQwld2DRDfVVWJ6NrYjXxbY0uDNiuYREncb3F/NQ=;
	b=KPQl3nhlmn+n7Cj42q0x18ygOlcKdVKLSR9nq4tj83MUBhdJNZNSnSI/hwZbieBYkDVhdy
	yhZOFCksRWVJ0JlYz/EG3ygEiWsj12bcbSLcgzdOOFiTIZ9wMPsib6CTP9PvMal9+yuci6
	OaiLlwX+cp1bdaxet6dojanHbn7xmdI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KPQl3nhl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722839217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=awyQQwld2DRDfVVWJ6NrYjXxbY0uDNiuYREncb3F/NQ=;
	b=KPQl3nhlmn+n7Cj42q0x18ygOlcKdVKLSR9nq4tj83MUBhdJNZNSnSI/hwZbieBYkDVhdy
	yhZOFCksRWVJ0JlYz/EG3ygEiWsj12bcbSLcgzdOOFiTIZ9wMPsib6CTP9PvMal9+yuci6
	OaiLlwX+cp1bdaxet6dojanHbn7xmdI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46A9B13254
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2024 06:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P45TALBwsGasOwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 05 Aug 2024 06:26:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: make btrfs_is_subpage() to return false directly for 4K page size
Date: Mon,  5 Aug 2024 15:56:30 +0930
Message-ID: <bc8baf98c9c9357423178d4fab6b945bcb959f1d.1722839158.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 25F981FD09
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Btrfs only supports sectorsize 4K, 8K, 16K, 32K, 64K for now, thus for
systems with 4K page size, there is no way the fs is subpage (sectorsize
< PAGE_SIZE).

So here we define btrfs_is_subpage() different according to the
PAGE_SIZE:

- PAGE_SIZE > 4K
  We may hit real subpage cases, define btrfs_is_subpage() as a regular
  function and do the usual checks.

- PAGE_SIZE == 4K (no smaller PAGE_SIZE support AFAIK)
  There is no way the fs is subpage, so just define btrfs_is_subpage()
  as an inline function which always return false.

This saves some bytes for x86_64 debug builds:

	   text	   data	    bss	    dec	    hex	filename
Before:	1484452	 168693	  25776	1678921	 199e49	fs/btrfs/btrfs.ko
After:	1476605	 168445	  25776	1670826	 197eaa	fs/btrfs/btrfs.ko

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 2 ++
 fs/btrfs/subpage.h | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 8ddd5fcbeb93..631d96f1e905 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -64,6 +64,7 @@
  *   This means a slightly higher tree locking latency.
  */
 
+#if PAGE_SIZE > SZ_4K
 bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space *mapping)
 {
 	if (fs_info->sectorsize >= PAGE_SIZE)
@@ -85,6 +86,7 @@ bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space
 		return true;
 	return false;
 }
+#endif
 
 void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sectorsize)
 {
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 249396e118d0..5532cc4fac50 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -5,6 +5,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
+#include <linux/sizes.h>
 
 struct address_space;
 struct folio;
@@ -88,7 +89,15 @@ enum btrfs_subpage_type {
 	BTRFS_SUBPAGE_DATA,
 };
 
+#if PAGE_SIZE > SZ_4K
 bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space *mapping);
+#else
+static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
+				    struct address_space *mapping)
+{
+	return false;
+}
+#endif
 
 void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sectorsize);
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
-- 
2.45.2


