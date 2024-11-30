Return-Path: <linux-btrfs+bounces-9984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B929DEF3F
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2024 08:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46AD2B21A38
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Nov 2024 07:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565E7149C6A;
	Sat, 30 Nov 2024 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mn4R2m+z";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hwyAgYPM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746113C81B
	for <linux-btrfs@vger.kernel.org>; Sat, 30 Nov 2024 07:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732952620; cv=none; b=iYXRWh1VMTq2WzzP/vnt+WVeXGfvGbVIyPQDCRSOqDQhiSeeDMIxHDHrAB62VvSMNTAnd5v9gdvwBAjks03eVG7FXsI1dabPbcCIUR4SQ4P2KdK89k2T9LzrQQtpxMUWNGk+zSrMCNhKFiGGe06pMFC3UVPj8y96bvP0OU5fL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732952620; c=relaxed/simple;
	bh=vHOQ8olpj/0tCObua4ViR9Uwi8tt916vdjTvmU+c/HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ty5hsUq7dnWLpAoi5p3J+CQHuc9GEDZeO1j3VIsPsXfHg3yaehl+pCp0igxkXIyNAYZNnmfiC5OHsXnJEUbBUf8sVArwdz3U3Z2W7G3UwykFsBmAdkjkZ3T97kQkCeLcDyFCq3w542YsHhv2uVSJekXI4t+OlpaPQmthuNtzMOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mn4R2m+z; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hwyAgYPM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 25D681F38C;
	Sat, 30 Nov 2024 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732952615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zjyzO0gAbXSQtO/BAYQTK8FSHQ/NSLDKtnlFp2EidUk=;
	b=mn4R2m+zcvWbnBivtv4wie4dUHnaPMdn42k96CexOrEWeZnUiVhttTD1LAa4PKp/Kuo/sn
	5VGtYAlosUZYorsz1N0BYhT8KXOwGVQ/D/J9wT9kgbVvgwsvyY8jrXNrvou2qrjlTigTgb
	XS5w5KuiqK2r3aiN0pRmrhz+X8s290c=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hwyAgYPM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732952614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zjyzO0gAbXSQtO/BAYQTK8FSHQ/NSLDKtnlFp2EidUk=;
	b=hwyAgYPMTgKvUbXjTE+yRvsKgzjvcPVMQTjbzdpWxFjwzVQ3MKxAZS+e//JxevmABOxxUl
	iATqB7g3jIVrpAJln1X9GEo9caIYXDtpfRa9CIEIXEFyBmgTutPEI9V2BONgm3E8Fugy2B
	Z4CDYxQ5jI5R4YSWgMrc4949IaxeahE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C32613A15;
	Sat, 30 Nov 2024 07:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sq0bLyTCSmczYAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 30 Nov 2024 07:43:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: properly wait for writeback before buffered write
Date: Sat, 30 Nov 2024 18:13:15 +1030
Message-ID: <7fae80d0a144312c09e4e40ff3491b6ce77ee4f5.1732952536.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 25D681F38C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	TAGGED_RCPT(0.00)[aac7bff85be224de5156];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
Syzbot reported a crash where btrfs is call folio_start_writeback()
while the folio is already marked writeback:

------------[ cut here ]------------
kernel BUG at mm/page-writeback.c:3119!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.12.0-syzkaller-08446-g228a1157fb9f #0
Workqueue: btrfs-delalloc btrfs_work_helper
RIP: 0010:__folio_start_writeback+0xc06/0x1050 mm/page-writeback.c:3119
 <TASK>
 process_one_folio fs/btrfs/extent_io.c:187 [inline]
 __process_folios_contig+0x31c/0x540 fs/btrfs/extent_io.c:216
 submit_one_async_extent fs/btrfs/inode.c:1229 [inline]
 submit_compressed_extents+0xdb3/0x16e0 fs/btrfs/inode.c:1632
 run_ordered_work fs/btrfs/async-thread.c:245 [inline]
 btrfs_work_helper+0x56b/0xc50 fs/btrfs/async-thread.c:324
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace 0000000000000000 ]---

Furthermore syzbot bisected the cause to commit c87c299776e4
("btrfs: make buffered write to copy one page a time").

[CAUSE]
Unfortunately I'm not able to reproduce the bug with my usual debug
kernel config.
But thanks to the bisection result, I can take a deeper look into the
offending commit.

One of the change is to use FGP_STABLE to wait for folio writeback.
But unfortunately FGP_STABLE is not ensured to wait for writeback, it
only calls folio_wait_stable(), which only calls folio_wait_writeback()
if the address space has AS_STABLE_WRITES.

Normally that flag is only set if the super block has
SB_I_STABLE_WRITES, and that is normally set if the that block device
has integrity checks or requires stable writes feature (normally has
some kind of digest to check).

Although I'd argue btrfs should set such flag due to its data checksum,
for now we do not have that flag, meaning FGP_STABLE will not wait for
any folio writeback to finish.

This is going to cause races between buffered write and folio writeback,
leading to various data corruption/checksum mismatch.

[FIX]
Instead of fully rely on FGP_STABLE, manually do the folio writeback
wait, until we set the btrfs super block with SB_I_STABLE_WRITES
manually.

Reported-by: syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com
Fixes: c87c299776e4 ("btrfs: make buffered write to copy one page a time")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fbb753300071..8734f5fc681f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -911,6 +911,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
 			ret = PTR_ERR(folio);
 		return ret;
 	}
+	folio_wait_writeback(folio);
 	/* Only support page sized folio yet. */
 	ASSERT(folio_order(folio) == 0);
 	ret = set_folio_extent_mapped(folio);
-- 
2.47.1


