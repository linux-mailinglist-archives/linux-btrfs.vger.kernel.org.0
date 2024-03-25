Return-Path: <linux-btrfs+bounces-3570-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D2C88B472
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 23:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC99E1C3B366
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Mar 2024 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54207FBDB;
	Mon, 25 Mar 2024 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FbPwgFwi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FbPwgFwi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198B7F7C0
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Mar 2024 22:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406841; cv=none; b=YxOxtu4EY2dqmhyPmMbxEgwc7kkyKH/t+pOanjCC+Q/3mncXVDeo+XQJQ7BhSrp4w726gWQfDnpNcW3BM4vLSyfrhxJ2F1FrCl9CsNvhE6ctCxbOo756lMBCJXgzyvqMbP9SGw5ns4MCh6nE6ovducQ4IJ6d15aciNktX3L6uTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406841; c=relaxed/simple;
	bh=nARGTDnqXQs4ESgIz8Twrrhm8LvAYpAJZaLzGfHb76g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNp+Dfw/BSPyRuh87IAl/xH7ZdMVNdzIBOeBSeVU8PbDiW/q5qT8LJiqqAdsKm4NSpPRA3B5VxWJ+uehOc1qryOY2Nle/M9IkwYUb5NQWr512wNUYxtD+XmcBsu6OZsvzLNO9xeqN8o91sJdGCLV9xhQVc/5FnyJjICXyHRh1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FbPwgFwi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FbPwgFwi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B4F25CD16;
	Mon, 25 Mar 2024 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711406830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8nZOVY6PJk7pWHairUKnJN9XplVwE2CD0iC1aoP7dfM=;
	b=FbPwgFwiCVUqDos1G4kMqQaCp6vIHTPi4UI0ZLz9kVp8vaoSiaHOiEa0nB01rwqzz8lJgj
	btFKAcyixNDyhZ2QpeYdjDatkxwoYIiZ2qzQbS17m3hhAceB2ycznZ0GMfNMixELd8nkbr
	AtnGsDYAyppnBHRGDY5fwYnq58KBp+o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1711406830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8nZOVY6PJk7pWHairUKnJN9XplVwE2CD0iC1aoP7dfM=;
	b=FbPwgFwiCVUqDos1G4kMqQaCp6vIHTPi4UI0ZLz9kVp8vaoSiaHOiEa0nB01rwqzz8lJgj
	btFKAcyixNDyhZ2QpeYdjDatkxwoYIiZ2qzQbS17m3hhAceB2ycznZ0GMfNMixELd8nkbr
	AtnGsDYAyppnBHRGDY5fwYnq58KBp+o=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EFE5E13A2E;
	Mon, 25 Mar 2024 22:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pn5rK+z+AWa3FAAAn2gu4w
	(envelope-from <wqu@suse.com>); Mon, 25 Mar 2024 22:47:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Julian Taylor <julian.taylor@1und1.de>,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: do not wait for short bulk allocation
Date: Tue, 26 Mar 2024 09:16:46 +1030
Message-ID: <3484c7d6ad25872c59039702f4a7c08ae72771a2.1711406789.git.wqu@suse.com>
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
	 RCPT_COUNT_THREE(0.00)[3];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
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
v2:
- Still use bulk allocation function
  Since alloc_pages_bulk_array() would fall back to single page
  allocation by itself, there is no need to go alloc_page() manually.

- Update the commit message to indicate other fses do not call
  memalloc_retry_wait() unconditionally
  In fact, they only call it when they need to retry hard and can not
  really fail.
---
 fs/btrfs/extent_io.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7441245b1ceb..c96089b6f388 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -681,31 +681,27 @@ static void end_bbio_data_read(struct btrfs_bio *bbio)
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 			   gfp_t extra_gfp)
 {
+	const gfp_t gfp = GFP_NOFS | extra_gfp;
 	unsigned int allocated;
 
 	for (allocated = 0; allocated < nr_pages;) {
 		unsigned int last = allocated;
 
-		allocated = alloc_pages_bulk_array(GFP_NOFS | extra_gfp,
-						   nr_pages, page_array);
+		allocated = alloc_pages_bulk_array(gfp, nr_pages, page_array);
+		if (unlikely(allocated == last)) {
+			/* Can not fail, wait and retry. */
+			if (extra_gfp & __GFP_NOFAIL) {
+				memalloc_retry_wait(GFP_NOFS);
+				continue;
+			}
 
-		if (allocated == nr_pages)
-			return 0;
-
-		/*
-		 * During this iteration, no page could be allocated, even
-		 * though alloc_pages_bulk_array() falls back to alloc_page()
-		 * if  it could not bulk-allocate. So we must be out of memory.
-		 */
-		if (allocated == last) {
+			/* Allowed to fail, error out. */
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


