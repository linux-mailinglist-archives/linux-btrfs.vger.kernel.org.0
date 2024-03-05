Return-Path: <linux-btrfs+bounces-3010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9C38718DE
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 10:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA68C28479C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A71054745;
	Tue,  5 Mar 2024 09:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UPt8ipyD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NTY+eH4G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B50537F6;
	Tue,  5 Mar 2024 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629328; cv=none; b=KpzLQ2Q4ov8C96igoYu5GPdBEfLkVg7F8V4zk1M/Qojct0VTWde2tPhiRooDxD6lMV2s9Om442gwczYT4P55n3NcMjd0B4VFVmSjGVKWIf2pcSiLd31pFdC4wtED8dX6cqWr29mMgf1t0JKx3mv7IH6wZ2LIyunTwrwGr3C8ZIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629328; c=relaxed/simple;
	bh=q4iz5XvKGS8mX0yLShC0dji2oYqS+82dz8XQc5a0bX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUrWYoimumb9fnMLSniT3D40W5chxAtnigtKmd2ffnEQK0H4+Y3LTycOF18VW52JNn68MAlZloTnPPGQhYh6Flhstd+Klh5tI0qXTpiE+RIjlCyGj04ovLHH+vMw1Nr13UeHvhP37pKqwknQ6Tb5zSYoJOoODS+qIv9UksYJdJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UPt8ipyD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NTY+eH4G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0265175AEA;
	Tue,  5 Mar 2024 09:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709629325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bvQOJ8aqJ6FwJTltWbV6SgHYpOqgmBSAKZ25Gzzex1w=;
	b=UPt8ipyD6ymcKfwep/iskO/4aXXlaBZ7EAf8awIJHUhC8xA5vIkzck6xFstMzRDuq2zy8f
	lLsvIXMAHHdq1CW1hI5t/8NwHRqJLHLM3sz6+ukYcxexisG3Bc6B4YLLFVIMxFFr9h5djN
	dpsUGhQprK8WNhbl1z4/oqs9+VTZqDg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709629324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bvQOJ8aqJ6FwJTltWbV6SgHYpOqgmBSAKZ25Gzzex1w=;
	b=NTY+eH4GjBFQEvx2ZTzzXWkEjqVwSAguLOX/8cUlR6A6zhhAZZ96ewrk/RElMNwrC48KU0
	m7D1WRMkhr00UjvEcF78Skt9pnLtQSONXXZ5R1y2nV4FNydPQsqyZPCXWXqNXgIbdNrppR
	vdzlLA+gPvmuVFVqtP0rCRgmcWh4Xv4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DFD9313466;
	Tue,  5 Mar 2024 09:02:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id noqXJYnf5mV2YAAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 05 Mar 2024 09:02:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: WA AM <waautomata@gmail.com>,
	stable@vger.kernel.org,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: scrub: fix false alerts on zoned device scrubing
Date: Tue,  5 Mar 2024 19:31:43 +1030
Message-ID: <cf93c10bb94755f1bee7e70b333db72ba9f0896b.1709629215.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NTY+eH4G
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,wdc.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,wdc.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 0265175AEA
X-Spam-Flag: NO

[BUG]
When using zoned devices (zbc), scrub would always report super block
errors like the following:

  # btrfs scrub start -fB /mnt/btrfs/
  Starting scrub on devid 1
  scrub done for b7b5c759-1baa-4561-a0ca-b8d0babcde56
  Scrub started:    Tue Mar  5 12:49:14 2024
  Status:           finished
  Duration:         0:00:00
  Total to scrub:   288.00KiB
  Rate:             288.00KiB/s
  Error summary:    super=2
    Corrected:      0
    Uncorrectable:  0
    Unverified:     0

[CAUSE]
Since the very beginning of scrub, we always go with btrfs_sb_offset()
to grab the super blocks.
This is fine for regular btrfs filesystems, but for zoned btrfs, super
blocks are stored in dedicated zones with a ring buffer like structure.

This means the old btrfs_sb_offset() is not able to give the correct
bytenr for us to grabbing the super blocks, thus except the primary
super block, the rest would be garbage and cause the above false alerts.

[FIX]
Instead of btrfs_sb_offset(), go with btrfs_sb_log_location() which is
zoned friendly, to grab the correct super block location.

This would introduce new error patterns, as btrfs_sb_log_location() can
fail with extra errors.

Here for -ENOENT we just end the scrub as there are no more super
blocks.
For other errors, we record it as a super block error and exit.

Reported-by: WA AM <waautomata@gmail.com>
Link: https://lore.kernel.org/all/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5Fv5gNXptPUKw@mail.gmail.com/
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)
---
Changelog:
v2:
- Use READ to replace the number 0
- Continue checking the next super block if we hit a non-ENOENT error

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c4bd0e60db59..201b547aac4c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2788,7 +2788,6 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 					   struct btrfs_device *scrub_dev)
 {
 	int	i;
-	u64	bytenr;
 	u64	gen;
 	int ret = 0;
 	struct page *page;
@@ -2812,7 +2811,17 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		gen = btrfs_get_last_trans_committed(fs_info);
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
-		bytenr = btrfs_sb_offset(i);
+		u64 bytenr;
+
+		ret = btrfs_sb_log_location(scrub_dev, i, READ, &bytenr);
+		if (ret == -ENOENT)
+			break;
+		if (ret < 0) {
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.super_errors++;
+			spin_unlock(&sctx->stat_lock);
+			continue;
+		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
-- 
2.44.0


