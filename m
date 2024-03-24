Return-Path: <linux-btrfs+bounces-3524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A7B887ED9
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0C31C20A05
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 20:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C79101EE;
	Sun, 24 Mar 2024 20:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ezJZUzV0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ezJZUzV0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE1FD52F
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Mar 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711311682; cv=none; b=Fuw4EPf6TBas2DiEdE7wQvKfdN9cT8plSAfZTYwXHtOCbyt3lyipV7Fk2QnrMrPnxAIW+8tr7No0Fb70q/3tvO8zBX6y8LLdYlFiui3MkL/tb+vJP2DCBefRKTCBgjMOPwiK0Bh30kqoej84mrMShrCuJFp8jzmI1dpeXgJpk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711311682; c=relaxed/simple;
	bh=8fiCl/Yc5o8pzIBJ+XBff/h/3dSH4uTcUyVq/LHAUVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCdglkOhBgGcMLNfWPo8zVTkEZAzKnF/v6Cwk8HWx/pTqzqbfY7OyHf4fLZQ/GmpnCDYFJPbPM9cOm7JN7wCAwpgBaALHqVb8t+ttR5gEgUBhur/sAJsS6ydv02KmyVThTL5RRuN+BNlcHUb2CfvnbICVXZcb+ZZVYPOQu/3LEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ezJZUzV0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ezJZUzV0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10A3F20FCB;
	Sun, 24 Mar 2024 20:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711311671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GPLN4Uh+0LRKDAQPbNphhkZ5GHXRZig7nvSwc1LMhnI=;
	b=ezJZUzV0XyO0b2rM9eExQrAJ4LoMrF0s/uTI2IUhmeTW9RIK88LbmTscJr8pqvIJq2wm0j
	I0l3nL6aeCkMIPgze9a42ES7vcVzRVqeby41Bi9ynPgHyErzfBGZDbjRYwAH2Y4V0tLiHn
	Zi/WBydy2PcWra3Un1eQpQBCsRs2G64=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711311671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GPLN4Uh+0LRKDAQPbNphhkZ5GHXRZig7nvSwc1LMhnI=;
	b=ezJZUzV0XyO0b2rM9eExQrAJ4LoMrF0s/uTI2IUhmeTW9RIK88LbmTscJr8pqvIJq2wm0j
	I0l3nL6aeCkMIPgze9a42ES7vcVzRVqeby41Bi9ynPgHyErzfBGZDbjRYwAH2Y4V0tLiHn
	Zi/WBydy2PcWra3Un1eQpQBCsRs2G64=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EB9E813A71;
	Sun, 24 Mar 2024 20:21:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Q/1vKjWLAGaJaQAAn2gu4w
	(envelope-from <wqu@suse.com>); Sun, 24 Mar 2024 20:21:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Julian Taylor <julian.taylor@1und1.de>
Subject: [PATCH] btrfs: fallback to single page allocation to avoid bulk allocation latency
Date: Mon, 25 Mar 2024 06:50:47 +1030
Message-ID: <9ec01e023cc34e5729dd4a86affd5158f87c7a83.1711311627.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

[BUG]
There is a recent report that when memory pressure is high (including
cached pages), btrfs can spend most of its time on memory allocation in
btrfs_alloc_page_array().

[CAUSE]
For btrfs_alloc_page_array() we always go alloc_pages_bulk_array(), and
even if the bulk allocation failed we still retry but with extra
memalloc_retry_wait().

If the bulk alloc only returned one page a time, we would spend a lot of
time on the retry wait.

[FIX]
Instead of always trying the same bulk allocation, fallback to single
page allocation if the initial bulk allocation attempt doesn't fill the
whole request.

Even if this means a higher chance of memory allocation failure.

Reported-by: Julian Taylor <julian.taylor@1und1.de>
Link: https://lore.kernel.org/all/8966c095-cbe7-4d22-9784-a647d1bf27c3@1und1.de/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7441245b1ceb..d49e7f0384ed 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -681,33 +681,22 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 			   gfp_t extra_gfp)
 {
+	const gfp_t gfp = GFP_NOFS | extra_gfp;
 	unsigned int allocated;
 
-	for (allocated = 0; allocated < nr_pages;) {
-		unsigned int last = allocated;
-
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
-			for (int i = 0; i < allocated; i++) {
-				__free_page(page_array[i]);
-				page_array[i] = NULL;
-			}
-			return -ENOMEM;
-		}
-
-		memalloc_retry_wait(GFP_NOFS);
+	allocated = alloc_pages_bulk_array(GFP_NOFS | gfp, nr_pages, page_array);
+	for (; allocated < nr_pages; allocated++) {
+		page_array[allocated] = alloc_page(gfp);
+		if (unlikely(!page_array[allocated]))
+			goto enomem;
 	}
 	return 0;
+enomem:
+	for (int i = 0; i < allocated; i++) {
+		__free_page(page_array[i]);
+		page_array[i] = NULL;
+	}
+	return -ENOMEM;
 }
 
 /*
-- 
2.44.0


