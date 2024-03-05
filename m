Return-Path: <linux-btrfs+bounces-3004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAD28713E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 03:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008D7B24AE1
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 02:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B1528E3C;
	Tue,  5 Mar 2024 02:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GoDynFKX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SWx9bxLS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2892942C;
	Tue,  5 Mar 2024 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709606929; cv=none; b=bJE7zRDzl+KgtzKCfP7Vu7tNdCIWiV9jevCh/6GeenKBmw39m0dzN8crWTZJo01JIrkYOnktLu9zcTBiKtUVMTNwQ/MO9m5MfyZJyL7mAU6PiM+d0PuJkIAQqAWLFp26K4D3VLbNbSoP/tbIlkE5i+wCXta1c6c9mWvqTekgc9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709606929; c=relaxed/simple;
	bh=JiA9kzeN609txgE8z4GSqVv0/0AubIr+K76ucAH9UJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=noxxqKBHA9rDJOMhtwmxszkYWwRHMIL0u8/9mWX1p8+0yMaslJAgEauDfi7CEfr+2pOeD85qwlchHVoh3CZrSinTg/t4lKxi+Tasgse9UH8SkLcEHZ6CeKG+yCUQUrEZ2CPSdEaMR4+yjcO730QRPaezFJwkWMvAtiei3vCrcb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GoDynFKX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SWx9bxLS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5200B386DE;
	Tue,  5 Mar 2024 02:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709606924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+Y03Au7QrI5K9RTyoPMPBjTzhHyEv6BVHwGhrK8ff2I=;
	b=GoDynFKXlbFfW8wwZhxtNrSU50kOC99hj2dTecMGAf6R/YrHWi1NIi7QOpbNXUxwme7oaI
	JNwFzGmoR+g9gTUpPNdqPKR+YbPrLsErpbdAFfAuzaz+pTWhHhYV8X3wil3JZPK4RRcQZS
	VlFWGLvgfx6dX6YD1KEsH9wKZ0dj54A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709606922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=+Y03Au7QrI5K9RTyoPMPBjTzhHyEv6BVHwGhrK8ff2I=;
	b=SWx9bxLStQAPtui7V4RVTtOEny1DQZHyujvWfPbk+MT14CkAyUsp89Lg+Bt5XUKmL+J7EI
	OBr2Pxo19anPv/BZ84JWE6OWkzRYLNJn/gZW+P9SKWOzxi5DK1TRe6ZSi26yqX0OImjuls
	XPBb9hP87a9TnM4iudX/eiYE7DDQQGQ=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 721D413419;
	Tue,  5 Mar 2024 02:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xKwDCwiI5mXhFAAAn2gu4w
	(envelope-from <wqu@suse.com>); Tue, 05 Mar 2024 02:48:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: WA AM <waautomata@gmail.com>,
	stable@vger.kernel.org,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCH] btrfs: scrub: fix false alerts on zoned device scrubing
Date: Tue,  5 Mar 2024 13:18:22 +1030
Message-ID: <91a3647a1f2657b89bd63c12fa466c6c70965d22.1709606883.git.wqu@suse.com>
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
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SWx9bxLS
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
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
	 RCPT_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: 5200B386DE
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
Signed-off-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c4bd0e60db59..e1b67baa4072 100644
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
+		ret = btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
+		if (ret == -ENOENT)
+			break;
+		if (ret < 0) {
+			spin_lock(&sctx->stat_lock);
+			sctx->stat.super_errors++;
+			spin_unlock(&sctx->stat_lock);
+			break;
+		}
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
-- 
2.44.0


