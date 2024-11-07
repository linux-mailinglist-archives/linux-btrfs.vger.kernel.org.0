Return-Path: <linux-btrfs+bounces-9379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 510E39BFD30
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 05:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D571D1F229DF
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2024 04:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907F51422AB;
	Thu,  7 Nov 2024 04:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e4nhLaW1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e4nhLaW1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10799376
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Nov 2024 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730952332; cv=none; b=csOy+xnDynErdCxTSSBeEcu189lVJYnhOkm6CutwIlew1AvsSFolX0IyqL0uyjhJn81r/7ZVZGI6iGb5ZlrdFkJt6ROClxnz7JgRAMXyGA5xD6yRkmS5sSsLuH5w0xmtmv8SIUINxPq/qqWaGcfe2PesV/jTWM9e2oNTPDZo5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730952332; c=relaxed/simple;
	bh=aIwx51bKBzSnOwUwnv/LkCbb1EOwwfYjAQIZAPeCtZI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GjoXL9/OXPjGGKzWVaMOQbcn+rdnoKVEA0coUlJJDli0UMVRCWueCjvfoBdbfUseaNuG0EK0i2IfUuQK7caDTy2/csNrfHiQFeZeYIpKj3viXBQ1h3XB79b3R1Mmtf8AfkXDxhwmHuY+isj3pjXn7p52ah4fgCE5qqn2899tY+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e4nhLaW1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e4nhLaW1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 152A821C9D
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Nov 2024 04:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730952326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nj8eAGp6n1P9EF2bQEbm0L9IUdLgGZovuq/kbsS1ydA=;
	b=e4nhLaW13jgeuIgRx0BPdDJ3hN+qfZId0dtAoty1sgo2dkCSnd6zBRa88q32dx/CLiOAC5
	sFJm2Y6kTkxX2bSBkkWLT/xQsssPsA/8fRrjmnLTK/1q01pktx+2ZB69hSpRTKbVOa7Cy2
	Rcd89ZKU+asUdXauDn8V1VdJ8MWBw/o=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=e4nhLaW1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730952326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nj8eAGp6n1P9EF2bQEbm0L9IUdLgGZovuq/kbsS1ydA=;
	b=e4nhLaW13jgeuIgRx0BPdDJ3hN+qfZId0dtAoty1sgo2dkCSnd6zBRa88q32dx/CLiOAC5
	sFJm2Y6kTkxX2bSBkkWLT/xQsssPsA/8fRrjmnLTK/1q01pktx+2ZB69hSpRTKbVOa7Cy2
	Rcd89ZKU+asUdXauDn8V1VdJ8MWBw/o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44B8C1394A
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Nov 2024 04:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eM80AYU8LGeEGQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 07 Nov 2024 04:05:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: open-code btrfs_copy_from_user()
Date: Thu,  7 Nov 2024 14:35:07 +1030
Message-ID: <3fd6e78c94b60e15e11ee2d792ced71a367b764d.1730952267.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 152A821C9D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The function btrfs_copy_from_user() handles the folio dirtying for
buffered write. The original design is to allow that function to handle
multiple folios, but since commit "btrfs: make buffered write to copy one
page a time" there is no need to support multiple folios.

So here open-code btrfs_copy_from_user() to
copy_folio_from_iter_atomic() and flush_dcache_folio() calls.

The short-copy check and revert are still kept as-is.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 64 +++++++++++++------------------------------------
 1 file changed, 17 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fbb753300071..10d51c8dd360 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -37,52 +37,6 @@
 #include "file.h"
 #include "super.h"
 
-/*
- * Helper to fault in page and copy.  This should go away and be replaced with
- * calls into generic code.
- */
-static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
-					 struct folio *folio, struct iov_iter *i)
-{
-	size_t copied = 0;
-	size_t total_copied = 0;
-	int offset = offset_in_page(pos);
-
-	while (write_bytes > 0) {
-		size_t count = min_t(size_t, PAGE_SIZE - offset, write_bytes);
-		/*
-		 * Copy data from userspace to the current page
-		 */
-		copied = copy_folio_from_iter_atomic(folio, offset, count, i);
-
-		/* Flush processor's dcache for this page */
-		flush_dcache_folio(folio);
-
-		/*
-		 * if we get a partial write, we can end up with
-		 * partially up to date page.  These add
-		 * a lot of complexity, so make sure they don't
-		 * happen by forcing this copy to be retried.
-		 *
-		 * The rest of the btrfs_file_write code will fall
-		 * back to page at a time copies after we return 0.
-		 */
-		if (unlikely(copied < count)) {
-			if (!folio_test_uptodate(folio)) {
-				iov_iter_revert(i, copied);
-				copied = 0;
-			}
-			if (!copied)
-				break;
-		}
-
-		write_bytes -= copied;
-		total_copied += copied;
-		offset += copied;
-	}
-	return total_copied;
-}
-
 /*
  * Unlock folio after btrfs_file_write() is done with it.
  */
@@ -1268,7 +1222,23 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			break;
 		}
 
-		copied = btrfs_copy_from_user(pos, write_bytes, folio, i);
+		copied = copy_folio_from_iter_atomic(folio,
+				offset_in_folio(folio, pos), write_bytes, i);
+		flush_dcache_folio(folio);
+
+		/*
+		 * If we get a partial write, we can end up with partially
+		 * uptodate page. Although if sector size < page size we can
+		 * handle it, but if it's not sector aligned it can cause
+		 * a lot of complexity, so make sure they don't happen by
+		 * forcing retry this copy.
+		 */
+		if (unlikely(copied < write_bytes)) {
+			if (!folio_test_uptodate(folio)) {
+				iov_iter_revert(i, copied);
+				copied = 0;
+			}
+		}
 
 		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
 		dirty_sectors = round_up(copied + sector_offset,
-- 
2.47.0


