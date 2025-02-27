Return-Path: <linux-btrfs+bounces-11888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB93A4758D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 06:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374EF170629
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2025 05:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59696215183;
	Thu, 27 Feb 2025 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NCDI+h+X";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NCDI+h+X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8381EB5F2
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 05:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635717; cv=none; b=axx5GD6b7h+i4LaOe5aEC0T3p0OTEYd/zVXt5EIadU8BPHsI4bmmm1Hy6ZQO4U0n4mc9wJLKWLWCfJlfcW50KsbrBTPFq3mMSUVgWfQfuhaS+5yF2JwX6Ga3Tj48UaAcrd9bSB1t8GDWNsWo1tzU7L8WAnFcyEdEHmV0bkNPzQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635717; c=relaxed/simple;
	bh=fVjyhviJxkdrJBzCSmMukavoH5zEdmQUKdWMAER1LZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJiWf5Xs8yklpWTdKjz0fxQykorkVn0FXkRdcOEur7HtaoHNvZrNYo6J/FMLpGezsQO/8T3vPkaq7eqMHV2a6ggapp+r+dO0qDtyKtuhDS2UKvDGpRkeNIKCrLxBacsV2f41gAmIgNpDEkQqMJSpE2Jkf+K3MMhNgeHzfDTOC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NCDI+h+X; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NCDI+h+X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54EDF1F38F;
	Thu, 27 Feb 2025 05:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9QIe7BBpCfyu3f39k3PTijSvbPVGTjj30e9JDFZYsY=;
	b=NCDI+h+X3SO41+jjYgiGTVdvkoTY7HY1I125nUNHB1rdAyxYm9MGN5sEb8MN53wf4A8xLY
	cJYk5J/WMWrdEYtwuB6w1XdfSGHfjsbe6PX2uNjuCLovDENcd4f0kPCFSKek02awHPGMp/
	Lgyp39voIxrlFtb14C6lXHtl9fd78+c=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740635708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9QIe7BBpCfyu3f39k3PTijSvbPVGTjj30e9JDFZYsY=;
	b=NCDI+h+X3SO41+jjYgiGTVdvkoTY7HY1I125nUNHB1rdAyxYm9MGN5sEb8MN53wf4A8xLY
	cJYk5J/WMWrdEYtwuB6w1XdfSGHfjsbe6PX2uNjuCLovDENcd4f0kPCFSKek02awHPGMp/
	Lgyp39voIxrlFtb14C6lXHtl9fd78+c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4963E1376A;
	Thu, 27 Feb 2025 05:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kLRJAzv+v2ebUgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 27 Feb 2025 05:55:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/8] btrfs: subpage: do not hold subpage spin lock when clearing folio writeback
Date: Thu, 27 Feb 2025 16:24:40 +1030
Message-ID: <5d724635289a10a39164b767bdbee81e9e82e7d7.1740635497.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740635497.git.wqu@suse.com>
References: <cover.1740635497.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
When testing subpage block size btrfs (block size < page size), I hit
the following spin lock hang on x86_64, with the experimental 2K block
size support:

  <TASK>
  _raw_spin_lock_irq+0x2f/0x40
  wait_subpage_spinlock+0x69/0x80 [btrfs]
  btrfs_release_folio+0x46/0x70 [btrfs]
  folio_unmap_invalidate+0xcb/0x250
  folio_end_writeback+0x127/0x1b0
  btrfs_subpage_clear_writeback+0xef/0x140 [btrfs]
  end_bbio_data_write+0x13a/0x3c0 [btrfs]
  btrfs_bio_end_io+0x6f/0xc0 [btrfs]
  process_one_work+0x156/0x310
  worker_thread+0x252/0x390
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xef/0x250
  ? finish_task_switch.isra.0+0x8a/0x250
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x34/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

[CAUSE]
It's a self deadlock with the following sequence:

 btrfs_subpage_clear_writeback()
 |- spin_lock_irqsave(&subpage->lock);
 |- folio_end_writeback()
    |- folio_end_dropbehind_write()
       |- folio_unmap_invalidate()
          |- btrfs_release_folio()
             |- wait_subpage_spinlock()
                |- spin_lock_irq(&subpage->lock);
                   !! DEADLOCK !!

We're trying to acquire the same spin lock already held by ourselves.

[FIX]
Move the folio_end_writeback() call out of the spin lock critical
section.

And since we no longer have all the bitmap operation and the writeback
flag clearing happening inside the critical section, we must do extra
checks to make sure only the last one clearing the writeback bitmap can
clear the folio writeback flag.

Fixes: 3470da3b7d87 ("btrfs: subpage: introduce helpers for writeback status")
Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index ebb40f506921..bedb5fac579b 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -466,15 +466,21 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							writeback, start, len);
+	bool was_writeback;
+	bool last = false;
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
+	was_writeback = !subpage_test_bitmap_all_zero(fs_info, folio, writeback);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	if (subpage_test_bitmap_all_zero(fs_info, folio, writeback)) {
+	if (subpage_test_bitmap_all_zero(fs_info, folio, writeback) &&
+	    was_writeback) {
 		ASSERT(folio_test_writeback(folio));
-		folio_end_writeback(folio);
+		last = true;
 	}
 	spin_unlock_irqrestore(&subpage->lock, flags);
+	if (last)
+		folio_end_writeback(folio);
 }
 
 void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
-- 
2.48.1


