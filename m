Return-Path: <linux-btrfs+bounces-17277-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C10BAAAF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 00:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB243C40B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 22:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899EF223DD0;
	Mon, 29 Sep 2025 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uoJGSmvK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uoJGSmvK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94429433AD
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759184694; cv=none; b=g42LNrVcv4cuE2HXSvED2hLQvuMc9U25mCeBjtQFojf7CEmzGbOTQInY8ySK5SSnRu/vRx56UzqOkNiHNRcYoUWX/zrIr8xoLFmx+/FGfc9ntbXVcBJLr85LSZP8Vo1f1OsXRuoXywNoLwmCuwmXkDM5r0g0WkQgGVC4sBUjedA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759184694; c=relaxed/simple;
	bh=hi4WoYf8mfdry+y7JIZkxknUuZXLtY5O4RY9T70KENo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XV0sj3aamqtwu0MC6c4pX6+9TYntNFND7DOiv1xBTySXNWcSR+7/RK0zdglJ7c+pUcPe+IDl2Q7pLZkOd/mPcIjILvF7A857iubhW7lNNwln3nfztlF4hSS3r0ZetmAP/S45EyPuKOmZ7y8xOeiyB8yvUpSdvdh1RP2B5OXiKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uoJGSmvK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uoJGSmvK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 54BB11F45A;
	Mon, 29 Sep 2025 22:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759184689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eO+qq5ia4z51WAOS5eTWhUyUTThV4fH98k6x1V7oCqM=;
	b=uoJGSmvKgqJ6yJpCrp7QtfNIdCbW8DUfB65qouTD+5K65euTMXLdgeNxa6IJI4KTaRzfed
	6Hu6VqroI6c9pCnZJbvmWR1SW5TvunKGRz/bhOTGqoPRE3iv/y6K0pogr/A7MmzOe5LgJh
	JmhcxJvWGjfNQY2A/QqwaZy8XacrFvo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uoJGSmvK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759184689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eO+qq5ia4z51WAOS5eTWhUyUTThV4fH98k6x1V7oCqM=;
	b=uoJGSmvKgqJ6yJpCrp7QtfNIdCbW8DUfB65qouTD+5K65euTMXLdgeNxa6IJI4KTaRzfed
	6Hu6VqroI6c9pCnZJbvmWR1SW5TvunKGRz/bhOTGqoPRE3iv/y6K0pogr/A7MmzOe5LgJh
	JmhcxJvWGjfNQY2A/QqwaZy8XacrFvo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4114E13A21;
	Mon, 29 Sep 2025 22:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pOXlADAH22iDOgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 29 Sep 2025 22:24:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: syzbot+bde59221318c592e6346@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: do not use folio_test_partial_kmap() in ASSERT()s
Date: Tue, 30 Sep 2025 07:54:30 +0930
Message-ID: <035622656afa07c2f8aaaf35cf7f7dee65fb9fe2.1759184652.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[bde59221318c592e6346];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 54BB11F45A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[BUG]
Syzbot reported an ASSERT() triggered inside scrub:

  BTRFS info (device loop0): scrub: started on devid 1
  assertion failed: !folio_test_partial_kmap(folio) :: 0, in fs/btrfs/scrub.c:697
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/scrub.c:697!
  Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
  CPU: 0 UID: 0 PID: 6077 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
  RIP: 0010:scrub_stripe_get_kaddr+0x1bb/0x1c0 fs/btrfs/scrub.c:697
  Call Trace:
   <TASK>
   scrub_bio_add_sector fs/btrfs/scrub.c:932 [inline]
   scrub_submit_initial_read+0xf21/0x1120 fs/btrfs/scrub.c:1897
   submit_initial_group_read+0x423/0x5b0 fs/btrfs/scrub.c:1952
   flush_scrub_stripes+0x18f/0x1150 fs/btrfs/scrub.c:1973
   scrub_stripe+0xbea/0x2a30 fs/btrfs/scrub.c:2516
   scrub_chunk+0x2a3/0x430 fs/btrfs/scrub.c:2575
   scrub_enumerate_chunks+0xa70/0x1350 fs/btrfs/scrub.c:2839
   btrfs_scrub_dev+0x6e7/0x10e0 fs/btrfs/scrub.c:3153
   btrfs_ioctl_scrub+0x249/0x4b0 fs/btrfs/ioctl.c:3163
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:597 [inline]
   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  ---[ end trace 0000000000000000 ]---

Which doesn't make much sense, as all the folios we allocated for scrub
should not be highmem.

[CAUSE]
Thankfully syzbot has a detailed kernel config file, showing that
CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is set to y.

And that debug option will force all folio_test_partial_kmap() to return
true, to improve coverage on highmem tests.

But in our case we really just want to make sure the folios we allocated
are not highmem (and they are indeed not). Such incorrect result from
folio_test_partial_kmap() is just screwing up everything.

[FIX]
Replace folio_test_partial_kmap() to folio_test_highmem() so that we
won't bother those stupid highmem specific debug options.

Reported-by: syzbot+bde59221318c592e6346@syzkaller.appspotmail.com
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Upstream PR is not yet merged, thus no proper fixed tag available yet.
---
 fs/btrfs/scrub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4691d0bdb2e8..651b11884f82 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -694,7 +694,7 @@ static void *scrub_stripe_get_kaddr(struct scrub_stripe *stripe, int sector_nr)
 
 	/* stripe->folios[] is allocated by us and no highmem is allowed. */
 	ASSERT(folio);
-	ASSERT(!folio_test_partial_kmap(folio));
+	ASSERT(!folio_test_highmem(folio));
 	return folio_address(folio) + offset_in_folio(folio, offset);
 }
 
@@ -707,7 +707,7 @@ static phys_addr_t scrub_stripe_get_paddr(struct scrub_stripe *stripe, int secto
 
 	/* stripe->folios[] is allocated by us and no highmem is allowed. */
 	ASSERT(folio);
-	ASSERT(!folio_test_partial_kmap(folio));
+	ASSERT(!folio_test_highmem(folio));
 	/* And the range must be contained inside the folio. */
 	ASSERT(offset_in_folio(folio, offset) + fs_info->sectorsize <= folio_size(folio));
 	return page_to_phys(folio_page(folio, 0)) + offset_in_folio(folio, offset);
-- 
2.50.1


