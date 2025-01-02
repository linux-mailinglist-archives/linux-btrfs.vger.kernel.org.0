Return-Path: <linux-btrfs+bounces-10677-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415599FF619
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 05:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389DB3A3373
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 04:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFDA188A0C;
	Thu,  2 Jan 2025 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RK7hzZkq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VeWp++W4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B233CD299
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735792062; cv=none; b=FdCzifTHRY3w7XW8zkETjbb55HLz8QoGvlP8l+P0Z+loOVc8HF/huClIGHnIqQyPL4r2bz8y9kOkOu3aJ8wIUllXelRc7ycxEufX65+9O42fObUu5FPhyLnGM11Nb+znypHNJASwEwqJqfbgHKDXpGS6zo/uhX/WpQ6ZfDNHTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735792062; c=relaxed/simple;
	bh=rybeRW/Pp7OIrBcdDHQIJ9oVnJsLkjdaSyn2DahZrS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qGj25A4wdoRZkS+qAFpBDRSrV1vZMc3zMuyPinaGcOsifjYq/srMn//jknboFRItIWehITc6y+QJT8c9ZDaLrtSVeTZQKbyjgnLiBtWThHjKGqDqLiXtqYlkrJZvVmNwzDsOj3FmY/u4zZk9bACIctX+oXFr67ZUHmkZ98nYyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RK7hzZkq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VeWp++W4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C802B1F37C;
	Thu,  2 Jan 2025 04:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1735792058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Cq/gXPDduIPfYP8XZCzh275sN86VMyipSd+3MhR33WM=;
	b=RK7hzZkqiQTW8N45Z3O/jp6FsKhUUCy6PZZVnj+T2d/0aqLoAgyJsbIi9BJg3sh3I4qeRO
	JN6wV8Zatz27vHzTpKL1exxOrVeugdZslfn9HKPJKaMTQEzlu2a1dmt4zPOQoYajXGofUh
	uxhadNVZ8USYgj3zRh0sBHcllS9PR1g=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VeWp++W4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1735792057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Cq/gXPDduIPfYP8XZCzh275sN86VMyipSd+3MhR33WM=;
	b=VeWp++W4fkN6oQs5mjfLBNSD+zKufL+rhkAeQEvwTaHdSi0Y/LT9MrxqVXpdCm0IEnKnUP
	xlRlG7AjL71V1lutTEiNvcKt6KEKpr3PpXZSPN5BK7mJxGbPflv9IFTlRcm2b52h5YWbSu
	l/PkqfcyA7hgpy+gjU2x3gsRnLV8iSc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C75DA13418;
	Thu,  2 Jan 2025 04:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UZbnIbgVdmdCCQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 02 Jan 2025 04:27:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: avoid NULL pointer dereference if no valid extent tree
Date: Thu,  2 Jan 2025 14:57:11 +1030
Message-ID: <80137af65712e7c2a8ac301b7b9a3901e8bdb44d.1735792000.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C802B1F37C
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TAGGED_RCPT(0.00)[339e9dbe3a2ca419b85d];
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
Syzbot reported a crash with the following call trace:

 BTRFS info (device loop0): scrub: started on devid 1
 BUG: kernel NULL pointer dereference, address: 0000000000000208
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 106e70067 P4D 106e70067 PUD 107143067 PMD 0
 Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 1 UID: 0 PID: 689 Comm: repro Kdump: loaded Tainted: G           O       6.13.0-rc4-custom+ #206
 Tainted: [O]=OOT_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
 RIP: 0010:find_first_extent_item+0x26/0x1f0 [btrfs]
 Call Trace:
  <TASK>
  scrub_find_fill_first_stripe+0x13d/0x3b0 [btrfs]
  scrub_simple_mirror+0x175/0x260 [btrfs]
  scrub_stripe+0x5d4/0x6c0 [btrfs]
  scrub_chunk+0xbb/0x170 [btrfs]
  scrub_enumerate_chunks+0x2f4/0x5f0 [btrfs]
  btrfs_scrub_dev+0x240/0x600 [btrfs]
  btrfs_ioctl+0x1dc8/0x2fa0 [btrfs]
  ? do_sys_openat2+0xa5/0xf0
  __x64_sys_ioctl+0x97/0xc0
  do_syscall_64+0x4f/0x120
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>

[CAUSE]
The reproducer is using a corrupted image where extent tree root is
corrupted, thus forcing to use "rescue=all,ro" mount option to mount the
image.

Then it triggered a scrub, but since scrub relies on extent tree to find
where the data/metadata extents are, scrub_find_fill_first_stripe()
relies on an non-empty extent root.

But unfortunately scrub_find_fill_first_stripe() doesn't really expect
an NULL pointer for extent root, it use extent_root to grab fs_info and
triggered a NULL pointer dereference.

[FIX]
Add an extra check for a valid extent root at the beginning of
scrub_find_fill_first_stripe().

The new error path is introduced by 42437a6386ff ("btrfs: introduce
mount option rescue=ignorebadroots"), but that's pretty old, and later
commit b979547513ff ("btrfs: scrub: introduce helper to find and fill
sector info for a scrub_stripe") changed how we do scrub.

So for kernels older than 6.6, the fix will need manual backport.

Reported-by: syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/67756935.050a0220.25abdd.0a12.GAE@google.com/
Fixes: 42437a6386ff ("btrfs: introduce mount option rescue=ignorebadroots")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 204c928beaf9..531312efee8d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1541,6 +1541,10 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	u64 extent_gen;
 	int ret;
 
+	if (unlikely(!extent_root)) {
+		btrfs_err(fs_info, "no valid extent root for scrub");
+		return -EUCLEAN;
+	}
 	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
 				   stripe->nr_sectors);
 	scrub_stripe_reset_bitmaps(stripe);
-- 
2.47.1


