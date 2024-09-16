Return-Path: <linux-btrfs+bounces-8077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4257297A96E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 00:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A156B1F22CB8
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 22:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BAC14F9EA;
	Mon, 16 Sep 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bZXTxKvz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HL6+5N5V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4B14B965
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726527516; cv=none; b=B0kDctgvaSgdSV9AAEF7Ze+v9REVmwWFzI0oK953vOdw1A0/AQEnr8TvzhBGzz8M35yegQndJ2tfBWMoByefbQjXNZeTKzl8pZFDgQqHTjLJGVhru0Aj7ph7+Q3kTNtZZUJQBwfB5eM1tJDrn1SpC2Mj/erNgscm6WTPfWHNllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726527516; c=relaxed/simple;
	bh=Ww9RvrsN5trpkoEiI27akmOH2Sn0wZ93Fon9WPXvDnk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a5TzBLmUT4LYh6mlay3r4Xfdi6s4PCH08QNWg2ssC6BwmfSfYLlp8JeO52sET2qqodmJpKLv+dV/pRzIKsaFWWJZLy3+1ASXOBWB4e1DvZ0jG/H++WiDGfEmYLNU/ycd2yykafwtQUQOsrwRHemu2479VmXCbC2GZSJgybZCDwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bZXTxKvz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HL6+5N5V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF1301FDED
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 22:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726527512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0DdksfJBSNRnqiBOvLdnpECScENUTrs1HB8d5QfyAKQ=;
	b=bZXTxKvze07d8DiwWyXYvLGr/K9EulQQVq/n8AboiPhBvHHmbsDi+2Rz6Xb2TALJEVXvn8
	YzhUBuRGsevuDSFVQ75vvv3dME9HxDgQMuNNRrPiQj8IJ3peyX6oXX2HUkEvHhcVjEDgwp
	L2z1+2xxCErmBtostydH1udeSLfj338=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HL6+5N5V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726527510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0DdksfJBSNRnqiBOvLdnpECScENUTrs1HB8d5QfyAKQ=;
	b=HL6+5N5VAO481Igs3p4DxI9g2BwpTKQDkl3sTWaSs/l9AS2ioKKG5zEfgt+RFxhr+w8kGx
	vSbPOhYiQSF0JtHLENX5+2cn+Xbi+9JMBAxBl018/wQGa74Jkescg5BLbeNa+66dfdFWQR
	baOmKbsop2GHyWWhIpW8V+GNjtNQOn4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0058A139CE
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 22:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AxSnLBW46GYcQAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 22:58:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: allow compression even if the range is not page aligned
Date: Tue, 17 Sep 2024 08:28:12 +0930
Message-ID: <05299dac9e4379aff3f24986b4ca3fafb04d5d6a.1726527472.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF1301FDED
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Previously for btrfs with sector size smaller than page size (subpage),
we only allow compression if the range is fully page aligned.

This is to work around the asynchronous submission of compressed range,
which delayed the page unlock and writeback into a workqueue,
furthermore asynchronous submission can lock multiple sector range
across page boundary.

Such asynchronous submission makes it very hard to co-operate with other
regular writes.

With the recent changes to the subpage folio unlock path, now
asynchronous submission of compressed pages can co-operate with regular
submission, so enable sector perfect compression if it's an experimental
build.

The ETA for moving this feature out of experimental is 6.15, and I hope
all remaining corner cases can be exposed before that.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
This is the final enablement patch for sector perfect compression
support. (Previously compression is only page perfect, which means it's
only block perfect for sector size == page size).

This patch relies on all the previous various small fixes (some are
already merged into for-next branch), the recommended (and local)
sequence of the unmerged fixes are (in git log order):

 btrfs: allow compression even if the range is not page aligned
 btrfs: mark all dirty sectors as locked inside writepage_delalloc()
 btrfs: move the delalloc range bitmap search into extent_io.c
 btrfs: do not assume the full page range is not dirty in extent_writepage_io()
 btrfs: make extent_range_clear_diryt_for_io() to handle sector size < page size cases
 btrfs: wait for writeback if sector size is smaller than page size
 btrfs: compression: add an ASSERT() to ensure the read-in length is sane
 btrfs: zstd: make the compression path to handle sector size < page size
 btrfs: zlib: make the compression path to handle sector size < page size

And the following patches already in for-next are also needed:

 btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from CONFIG_BTRFS_DEBUG
 btrfs: only unlock the to-be-submitted ranges inside a folio
 btrfs: merge btrfs_folio_unlock_writer() into btrfs_folio_end_writer_lock()
 btrfs: make compression path to be subpage compatible
 btrfs: merge btrfs_orig_bbio_end_io() into btrfs_bio_end_io()
---
 fs/btrfs/inode.c | 41 +++++++----------------------------------
 1 file changed, 7 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d53b9e4ca13e..fbb303f7ccaa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -832,32 +832,16 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 		return 0;
 	}
 	/*
-	 * Special check for subpage.
+	 * Only enable sector perfect compression for experimental builds.
 	 *
-	 * We lock the full page then run each delalloc range in the page, thus
-	 * for the following case, we will hit some subpage specific corner case:
+	 * This is a big feature change for subpage cases, and can hit
+	 * different corner cases, so only limit this feature for
+	 * experimental build for now.
 	 *
-	 * 0		32K		64K
-	 * |	|///////|	|///////|
-	 *		\- A		\- B
-	 *
-	 * In above case, both range A and range B will try to unlock the full
-	 * page [0, 64K), causing the one finished later will have page
-	 * unlocked already, triggering various page lock requirement BUG_ON()s.
-	 *
-	 * So here we add an artificial limit that subpage compression can only
-	 * if the range is fully page aligned.
-	 *
-	 * In theory we only need to ensure the first page is fully covered, but
-	 * the tailing partial page will be locked until the full compression
-	 * finishes, delaying the write of other range.
-	 *
-	 * TODO: Make btrfs_run_delalloc_range() to lock all delalloc range
-	 * first to prevent any submitted async extent to unlock the full page.
-	 * By this, we can ensure for subpage case that only the last async_cow
-	 * will unlock the full page.
+	 * ETA for moving this out of experimental builds is 6.15.
 	 */
-	if (fs_info->sectorsize < PAGE_SIZE) {
+	if (fs_info->sectorsize < PAGE_SIZE &&
+	    !IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL)) {
 		if (!PAGE_ALIGNED(start) ||
 		    !PAGE_ALIGNED(end + 1))
 			return 0;
@@ -1002,17 +986,6 @@ static void compress_file_range(struct btrfs_work *work)
 	   (start > 0 || end + 1 < inode->disk_i_size))
 		goto cleanup_and_bail_uncompressed;
 
-	/*
-	 * For subpage case, we require full page alignment for the sector
-	 * aligned range.
-	 * Thus we must also check against @actual_end, not just @end.
-	 */
-	if (blocksize < PAGE_SIZE) {
-		if (!PAGE_ALIGNED(start) ||
-		    !PAGE_ALIGNED(round_up(actual_end, blocksize)))
-			goto cleanup_and_bail_uncompressed;
-	}
-
 	total_compressed = min_t(unsigned long, total_compressed,
 			BTRFS_MAX_UNCOMPRESSED);
 	total_in = 0;
-- 
2.46.0


