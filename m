Return-Path: <linux-btrfs+bounces-3940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881F5899091
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 23:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007AD1F2A05C
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5195E13BC3B;
	Thu,  4 Apr 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RmpTlK/x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="endfxQ4m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F082D90
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Apr 2024 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712267020; cv=none; b=qTjJ00QlJ+YpK+t7O9kCPxD8RmbNFZylkGTkoP66EZsBp0LgyMrp+YWDGGkMzBDYp1yozXuIWnJfEUXwE4lV0tfBwwOcoWtM8kpl6zfUpFEMgx6O5fsBx7In4PmvoAqdYmA5gFYfUeLUMnstZ1lw8nUkyJy6YzqBDh29D7yNvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712267020; c=relaxed/simple;
	bh=XSaPGujhZcMO6/PW7ZzA0xM3w3dlKK/pXub1M/qt+Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=puxNwvndQ+sS01P92MlKl4R368HGvt+NBgf6JHFuCooABsrmQW8PUeI8jpzZnAp1qzAkXbl6VGA0yMglevbg4osX4xJ9JAFm3ExibwjyboMM4wq7dHSUVv6i1mwzfwqjRlh2FFU2KzImqsKEmTf3+cXSetjxLWZWY9j6rn4menY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RmpTlK/x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=endfxQ4m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE200219D0;
	Thu,  4 Apr 2024 21:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712267016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Rr0i390481EMohSB3hRudVpWm9ZyqBaYs/QCRjFXZx4=;
	b=RmpTlK/xyzAFxEcRv94iWnUToy3ztEUN19+EN8ehprmyTSIDLoVQMnYw2eYgztYzDQ17pj
	vZGbr5opcZ1MC3pOQtFnQZ4qVxwQ/gBw3aYvAYVh8oqwOJihTrEcxHpswKEGaWi/UeMJNr
	ZZ1LDtXvEgdy+/OT2R//dYJnDcPrFic=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=endfxQ4m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712267014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Rr0i390481EMohSB3hRudVpWm9ZyqBaYs/QCRjFXZx4=;
	b=endfxQ4mH9DjvdO+LwTcAcZT/gc2MaTVU7+rwK+lPTxMEJG7RxTVLouMGySwbm2NULdpTE
	DSniyxFUR5coeeyFo2MSV6A3zBkCzVsXpPxx0eHJdmLmFKEfTaf419JiT3TaySKIT13+HI
	msU7DE3EeMoYWQtSiiKwJ41rq7hkLas=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 96DAB139E8;
	Thu,  4 Apr 2024 21:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +SruEwUfD2YBDAAAn2gu4w
	(envelope-from <wqu@suse.com>); Thu, 04 Apr 2024 21:43:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Julian Taylor <julian.taylor@1und1.de>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: do not wait for short bulk allocation
Date: Fri,  5 Apr 2024 08:13:11 +1030
Message-ID: <78e109cdbec7b11b1832822143d483509abb059e.1712266967.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DE200219D0
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]

[BUG]
There is a recent report that when memory pressure is high (including
cached pages), btrfs can spend most of its time on memory allocation in
btrfs_alloc_page_array() for compressed read/write.

[CAUSE]
For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
even if the bulk allocation failed (fell back to single page
allocation) we still retry but with extra memalloc_retry_wait().

If the bulk alloc only returned one page a time, we would spend a lot of
time on the retry wait.

The behavior was introduced in commit 395cb57e8560 ("btrfs: wait between
incomplete batch memory allocations").

[FIX]
Although the commit mentioned that other filesystems do the wait, it's
not the case at least nowadays.

All the mainlined filesystems only call memalloc_retry_wait() if they
failed to allocate any page (not only for bulk allocation).
If there is any progress, they won't call memalloc_retry_wait() at all.

For example, xfs_buf_alloc_pages() would only call memalloc_retry_wait()
if there is no allocation progress at all, and the call is not for
metadata readahead.

So I don't believe we should call memalloc_retry_wait() unconditionally
for short allocation.

This patch would only call memalloc_retry_wait() if failed to allocate
any page for tree block allocation (which goes with __GFP_NOFAIL and may
not need the special handling anyway), and reduce the latency for
btrfs_alloc_page_array().

Reported-by: Julian Taylor <julian.taylor@1und1.de>
Tested-by: Julian Taylor <julian.taylor@1und1.de>
Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de/
Fixes: 395cb57e8560 ("btrfs: wait between incomplete batch memory allocations")
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v3:
- Remove wait part completely
  For NOFAIL metadata allocation, the allocation itself should not fail.
  For regular allocation, we can afford the failure anyway.

v2:
- Still use bulk allocation function
  Since alloc_pages_bulk_array() would fall back to single page
  allocation by itself, there is no need to go alloc_page() manually.

- Update the commit message to indicate other fses do not call
  memalloc_retry_wait() unconditionally
  In fact, they only call it when they need to retry hard and can not
  really fail.
---
 fs/btrfs/extent_io.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bbdcb7475cea..48476f8fcf79 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -712,31 +712,21 @@ int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array,
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 			   gfp_t extra_gfp)
 {
+	const gfp_t gfp = GFP_NOFS | extra_gfp;
 	unsigned int allocated;
 
 	for (allocated = 0; allocated < nr_pages;) {
 		unsigned int last = allocated;
 
-		allocated = alloc_pages_bulk_array(GFP_NOFS | extra_gfp,
-						   nr_pages, page_array);
-
-		if (allocated == nr_pages)
-			return 0;
-
-		/*
-		 * During this iteration, no page could be allocated, even
-		 * though alloc_pages_bulk_array() falls back to alloc_page()
-		 * if  it could not bulk-allocate. So we must be out of memory.
-		 */
-		if (allocated == last) {
+		allocated = alloc_pages_bulk_array(gfp, nr_pages, page_array);
+		if (unlikely(allocated == last)) {
+			/* Fail and do cleanup. */
 			for (int i = 0; i < allocated; i++) {
 				__free_page(page_array[i]);
 				page_array[i] = NULL;
 			}
 			return -ENOMEM;
 		}
-
-		memalloc_retry_wait(GFP_NOFS);
 	}
 	return 0;
 }
-- 
2.44.0


