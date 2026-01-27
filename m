Return-Path: <linux-btrfs+bounces-21103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM0cIsBKeGkKpQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21103-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 06:18:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E20339008A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 06:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCE6E3055952
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 05:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A566329384;
	Tue, 27 Jan 2026 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XENBzRAH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dDjNQsTB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC72415B971
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 05:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769491039; cv=none; b=iH11HTMrDPamOmJk7Ptey4n0Wdk7fJgA5kTR4md8TxZ6Kx5eYiNh7U+EqyoF02HV3R6i8b8LP74mKptM7atOQ4sC95ta//5/CJKlNreK0QTcAo1JZYX1RMIja19y/R5B2KVGZr+QHn6GBkT/cAfLV9PMk+/P1dyoN+Z9G41n174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769491039; c=relaxed/simple;
	bh=WTF1m52iqisP3SFPK+SDBvKd4tCSGzoy1eLL6dVpzlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mu3cqnE/8oXSwg5FUwE0ZQJDi7mvxugduiFtLOLkEq/0SeHxXSMHIZadxp98wDwoCxqXOwHvqJwRnM1Dgo0YTvboUlY6RuiES4JvGX8LpYkaGq4CdIl8SFKvAbi/kwEEXAFRTeMxK0rgxDnaz/tfpS+Mb9ivlKJ7uhQDLzmln5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XENBzRAH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dDjNQsTB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC97C5BCD0;
	Tue, 27 Jan 2026 05:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769491036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MjW3oKEZSQibc72ru5QKGjJ89FaiLlqUfRk+NLSinUU=;
	b=XENBzRAH0/XmkNmdSMG24Os2hiFAIitcDRYB/8C+XUtSIZpITXJAHrguALoP6hQapmM0i8
	g0ICrwl+8TuFYHb5uQnxHb7szzTGZkZXWoyePN9+NVS9g73SIUfAQ8A5Vvpl8lCid5lyx8
	9M62cmdNwR8U+DGBplmr/xqxciaiATg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dDjNQsTB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1769491035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MjW3oKEZSQibc72ru5QKGjJ89FaiLlqUfRk+NLSinUU=;
	b=dDjNQsTBNMJmPbZK7/KVTK0IS+KifKuQd2l8YKHLFwKtUUgyTZVHB42H0XpcqKAPH4fvlt
	XgqOb5ZLRQYj2aYgG7GkifHqK9O5dWY4yIVmiIV3XNdBBYHyEmfTFSsD7bxVPDcxx2dDrU
	2ESOlitTn9pFhsGAs8gBtOOtVIhS//k=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7008F13712;
	Tue, 27 Jan 2026 05:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4krCBlpKeGlBbwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 27 Jan 2026 05:17:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] btrfs: do not ASSERT() when the fs flips RO inside btrfs_repair_io_failure()
Date: Tue, 27 Jan 2026 15:46:55 +1030
Message-ID: <f21d342502c5ab027f38945fe06cda99af759784.1769491014.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21103-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: E20339008A
X-Rspamd-Action: no action

[BUG]
There is a bug report that when btrfs hits ENOSPC error in a critical
path, btrfs flips RO (this part is expected, although the ENOSPC bug
still needs to be addressed).

The problem is after the RO flip, if we trigger a read repair, we can
hit the ASSERT() inside btrfs_repair_io_failure() like the following:

 BTRFS info (device vdc): relocating block group 30408704 flags metadata|raid1
 ------------[ cut here ]------------
 BTRFS: Transaction aborted (error -28)
 WARNING: fs/btrfs/extent-tree.c:3235 at __btrfs_free_extent.isra.0+0x453/0xfd0, CPU#1: btrfs/383844
 Modules linked in: kvm_intel kvm irqbypass
 [...]
 ---[ end trace 0000000000000000 ]---
 BTRFS info (device vdc state EA): 2 enospc errors during balance
 BTRFS info (device vdc state EA): balance: ended with status: -30
 BTRFS error (device vdc state EA): parent transid verify failed on logical 30556160 mirror 2 wanted 8 found 6
 BTRFS error (device vdc state EA): bdev /dev/nvme0n1 errs: wr 0, rd 0, flush 0, corrupt 10, gen 0
 [...]
 assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
 ------------[ cut here ]------------
 assertion failed: !(fs_info->sb->s_flags & SB_RDONLY) :: 0, in fs/btrfs/bio.c:938
 kernel BUG at fs/btrfs/bio.c:938!
 Oops: invalid opcode: 0000 [#1] SMP NOPTI
 CPU: 0 UID: 0 PID: 868 Comm: kworker/u8:13 Tainted: G        W        N  6.19.0-rc6+ #4788 PREEMPT(full)
 Tainted: [W]=WARN, [N]=TEST
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
 Workqueue: btrfs-endio simple_end_io_work
 RIP: 0010:btrfs_repair_io_failure.cold+0xb2/0x120
 Code: 82 e8 18 52 fc ff 0f 0b 41 b8 aa 03 00 00 48 c7 c1 f7 2b 07 83 31 d2 48 c7 c6 88 68 fb 82 48 c7 c7 f0 54 fa 82 e8 f4 51 fc ff <0f> 0b 41 b8 b4 03 00 00 48 c7 c1 f7 2b 07 83 31 d2 48 c7 c6 3d 2c
 RSP: 0000:ffffc90001d2bcf0 EFLAGS: 00010246
 RAX: 0000000000000051 RBX: 0000000000001000 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffffffff8305cf42 RDI: 00000000ffffffff
 RBP: 0000000000000002 R08: 00000000fffeffff R09: ffffffff837fa988
 R10: ffffffff8327a9e0 R11: 6f69747265737361 R12: ffff88813018d310
 R13: ffff888168b8a000 R14: ffffc90001d2bd90 R15: ffff88810a169000
 FS:  0000000000000000(0000) GS:ffff8885e752c000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 ------------[ cut here ]------------

[CAUSE]
The cause of -ENOSPC error during the test case btrfs/124 is still
unknown, although it's known that we still have cases where metadata can
be over-committed but can not be fulfilled correctly, thus if we hit
such ENOSPC error inside a critical path, we have no choice but abort
the current transaction.

This will mark the fs read-only.

The problem is inside the btrfs_repair_io_failure() path that we require
the fs not to be mount read-only. This is normally fine, but if we are
doing a read-repair meanwhile the fs flips RO due to a critical error,
we can enter btrfs_repair_io_failure() with super block set to
read-only, thus triggering the above crash.

[FIX]
Just replace the ASSERT() with a proper return if the fs is already
read-only.

Reported-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-btrfs/20260126045555.GB31641@lst.de/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index d3475d179362..b0e9c46ff25b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -928,7 +928,6 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
 	struct bio *bio = NULL;
 	int ret = 0;
 
-	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
 	/* Basic alignment checks. */
@@ -940,6 +939,13 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 fileoff,
 	ASSERT(step <= length);
 	ASSERT(is_power_of_2(step));
 
+	/*
+	 * The fs either mounted RO or hit critical errors, no need
+	 * to continue repairing.
+	 */
+	if (unlikely(sb_rdonly(fs_info->sb)))
+		return 0;
+
 	if (btrfs_repair_one_zone(fs_info, logical))
 		return 0;
 
-- 
2.52.0


