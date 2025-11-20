Return-Path: <linux-btrfs+bounces-19205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F28FC72A94
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 08:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5820F34B36B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839343064A9;
	Thu, 20 Nov 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XB2KbH22";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XB2KbH22"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E40308F18
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763625142; cv=none; b=Nd1fH5pfw4bbFTFqsY0RxYNckh270bCLEetiMX/5uBlWG5ou31w46obxijt92IPbMPfgkOqCjks49jjbBYaCC/n2clVr7Nu097xR85e3MFzya5vYpebjlHQ5vI0EJWSLrNWKSpusA6Dv6qiF72GU/8VoQhFSs9D8OQsOHEdC2yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763625142; c=relaxed/simple;
	bh=23kQmplAhMlyf9LbIq+DbdvRWx0huUdpkFiY3Nl7syw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJilNqQHlgbFVKMBvGl8RgF7KrhnBRE/yD50gvtR+875TR5U35zqXXD3f+gzr/msKwn1gNhTEbT2eRL4pZaLIbhZ1tEwFeXIeXOrpHrq2DstwipCXuNNVarl5ppqC6tL1/rFwH03rIQsQGRFnK6t9NTVrsEmqP0VewjkXGNur2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XB2KbH22; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XB2KbH22; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1DF2208F6
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763625125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoqZ6Gp+3+D7jP13hC9XE+SliGxngOFuPoy1tPWDU/8=;
	b=XB2KbH22lNbGxvBnksv3cjZUjUQ2q92tvq7qd7pGq0sckm39hjszPEMBlXSG1F1d4+aZ/B
	jguU10Hy1nY9QHf9prgKVD14PycIMw7aCZrv3tEkYe2sS1LrS94rZcZawyxybnbQM5D2UX
	40Mm9ogUS0XY2zs+OsJX+o6bW8ZKjNU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XB2KbH22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763625125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoqZ6Gp+3+D7jP13hC9XE+SliGxngOFuPoy1tPWDU/8=;
	b=XB2KbH22lNbGxvBnksv3cjZUjUQ2q92tvq7qd7pGq0sckm39hjszPEMBlXSG1F1d4+aZ/B
	jguU10Hy1nY9QHf9prgKVD14PycIMw7aCZrv3tEkYe2sS1LrS94rZcZawyxybnbQM5D2UX
	40Mm9ogUS0XY2zs+OsJX+o6bW8ZKjNU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D2CE3EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IC5uNKTIHmmAQwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 07:52:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: replace for_each_set_bit() with for_each_set_bitmap()
Date: Thu, 20 Nov 2025 18:21:42 +1030
Message-ID: <db57ffaecde7a6c819ba34a0c71935793af682ca.1763620860.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763620860.git.wqu@suse.com>
References: <cover.1763620860.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D1DF2208F6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

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

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0f1bf9a4f0ae..87bf5ce17264 100644
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


