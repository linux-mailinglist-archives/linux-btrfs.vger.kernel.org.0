Return-Path: <linux-btrfs+bounces-19617-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A62CB2716
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 09:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9DBD311C932
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 08:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB1B3064BC;
	Wed, 10 Dec 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gKDYQ1V2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uoQEKSDY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989A3054D1
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765355599; cv=none; b=gnKzNe1b9g2q0ZIpbiDsxe4zmUJ8Sa1oL5Wn1jinELZzK89anUA1Jhxq7Fpgu0MmuWUJFn4eXPz5x5gHmu8KS8UoydN5yn9gRBq8u0TPrZWlcLXAKKyb1WX8VF/Q0vfTJ6qrnYRHjrGHeBXSsm+BnFhR2CfZP8LnTpaJgSDcq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765355599; c=relaxed/simple;
	bh=4+DwtzZB7NwAOnAySr/Zfs82xL4HlxVkgGpgQ/xL9bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvmbFnkvnqBu7GpZdQIfW3/eEL9FuBJep2blGNTuTTjukxJVqy7vBHoDtp6jnxdpPViaLZR+4etryX6hr5WK4zaXUzzNTo3t7GTkWx1bq5pS2YuB2NvqHRtIEKZDfp2aimT6C7daZenQaziqkB/vMSh/PbXn/RiDzClr3bUhGzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gKDYQ1V2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uoQEKSDY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 017DD5BDE1;
	Wed, 10 Dec 2025 08:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765355585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbRPOvzRSr7pRTP309hBFE9x3wR82yILjvX1yALttLg=;
	b=gKDYQ1V2fY5EkRMmr46ahxFBPqNDcTF1Ll+WbkpXGG8xePy/pYYH1xRLiu3Psq2BxTGDFG
	ON/2Us0wbWgV+OrfGk409J2+zdF0l0h+ZmeE2ICeXr5HaRyXuMER++4lZ+BUaFwcCx2I5z
	ekL9d8hzdP6sT0nGR9r3WZyIaa2fclI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uoQEKSDY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765355584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zbRPOvzRSr7pRTP309hBFE9x3wR82yILjvX1yALttLg=;
	b=uoQEKSDY3a+HVgvSJH4ub91leA7JMfcVLmMokNo3rUEMI2Rus8gDfqTOaNnsHGwFp9jQyx
	3r3G01gxcBkPnVuoGFxwh8De6FwRXkl5SKX9Ed2fwjrQ2yGOoGWa1KRgrG4Ey+PXL78wG6
	wLqaiF+nsAZ3ZXXIrbCzGEDPBLn7SmA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F05C03EA63;
	Wed, 10 Dec 2025 08:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WLLEKz4wOWnmHQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 10 Dec 2025 08:33:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH 2/2] btrfs: replace for_each_set_bit() with for_each_set_bitmap()
Date: Wed, 10 Dec 2025 19:02:34 +1030
Message-ID: <7f8a4203963b7d308fd2444ec61b943e4257d253.1765354917.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765354917.git.wqu@suse.com>
References: <cover.1765354917.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 017DD5BDE1
X-Spam-Flag: NO
X-Spam-Score: -3.01

Inside extent_io.c, there are several simple call sites doing things
like:

	for_each_set_bit(bit, bitmap, bitmap_size) {
		/* handle one fs block */
	}

The workload includes:

- set_bit()
  Inside extent_writepage_io().

  This can be replaced with a bitmap_set().

- btrfs_folio_set_lock()
- btrfs_mark_ordered_io_finished()
  Inside writepage_delalloc().

  Instead of calling it multiple times, we can pass a range into the
  function with one call.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 49606a01039e..11c2dee7d363 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1426,8 +1426,9 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
+	unsigned int start_bit;
+	unsigned int end_bit;
 	int ret = 0;
-	int bit;
 
 	/* Save the dirty bitmap as our submission bitmap will be a subset of it. */
 	if (btrfs_is_subpage(fs_info, folio)) {
@@ -1437,10 +1438,12 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		bio_ctrl->submit_bitmap = 1;
 	}
 
-	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, blocks_per_folio) {
-		u64 start = page_start + (bit << fs_info->sectorsize_bits);
+	for_each_set_bitrange(start_bit, end_bit, &bio_ctrl->submit_bitmap,
+			      blocks_per_folio) {
+		u64 start = page_start + (start_bit << fs_info->sectorsize_bits);
+		u32 len = (end_bit - start_bit) << fs_info->sectorsize_bits;
 
-		btrfs_folio_set_lock(fs_info, folio, start, fs_info->sectorsize);
+		btrfs_folio_set_lock(fs_info, folio, start, len);
 	}
 
 	/* Lock all (subpage) delalloc ranges inside the folio first. */
@@ -1557,10 +1560,13 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 				fs_info->sectorsize_bits,
 				blocks_per_folio);
 
-		for_each_set_bit(bit, &bio_ctrl->submit_bitmap, bitmap_size)
-			btrfs_mark_ordered_io_finished(inode, folio,
-				page_start + (bit << fs_info->sectorsize_bits),
-				fs_info->sectorsize, false);
+		for_each_set_bitrange(start_bit, end_bit, &bio_ctrl->submit_bitmap,
+				      bitmap_size) {
+			u64 start = page_start + (start_bit << fs_info->sectorsize_bits);
+			u32 len = (end_bit - start_bit) << fs_info->sectorsize_bits;
+
+			btrfs_mark_ordered_io_finished(inode, folio, start, len, false);
+		}
 		return ret;
 	}
 out:
@@ -1728,8 +1734,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		return ret;
 	}
 
-	for (cur = start; cur < end; cur += fs_info->sectorsize)
-		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
+	bitmap_set(&range_bitmap, (start - folio_pos(folio)) >> fs_info->sectorsize_bits,
+		   len >> fs_info->sectorsize_bits);
 	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range_bitmap,
 		   blocks_per_folio);
 
-- 
2.52.0


