Return-Path: <linux-btrfs+bounces-10632-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831089FA303
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2024 01:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE5316707A
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Dec 2024 00:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0714802;
	Sun, 22 Dec 2024 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U8bWw8YP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OH8D5XfG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D0184
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2024 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734826268; cv=none; b=YO2M6U0j5OyDSoVkzDdUkaOMmv4vRJd3MVDYPv+LPUhqw9BNiuQET9YfvIMqykjyUmxxzzZKVlf1Hn8COaCWqGa9FqP73Ve+D2qqpjq8Bpy6b4OaEZ/zQPhF1rVDT1uKtEIemU9M7o6ETkY92SMGIWeNvYY9s0ROlRJ1DluY1Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734826268; c=relaxed/simple;
	bh=/RGSYOqtFPCvmto6Dkl40GLQSCDAsA+WWwd/HKUpVGs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WdIrBZvHmhtUMW3pRhdfc6u0JJLdtAWR515sHZmQOoxHl9C4qPUmB0BY8pRzabixFwQC/j2dplEfqHTCthJsWHxpNzSdHW4MonjblODJCAvHF1WHELvA0Rt10NjqNndvQamaMOIqW6HHWXTEFSRy9Z67SRQEZlnYxjGY+6PxzkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U8bWw8YP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OH8D5XfG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DEBC22882
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2024 00:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734826256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f4JaMD+LeYz1a+Bt14ki8L2vyNW8FT1YTHQovuP5H4s=;
	b=U8bWw8YP4tCl3kqdCFNWoKB+wu19CI0hEkU+xtCkwmkgcGot/zg6zsjOqhY434xvoI+cNs
	2/DaRdEUmACf1LHh6f8lqhxJDkvwnlIJ7Xc8aCMkL+dKvdtiksF0MDA89uI1adFgnRVmlo
	ss9zcTzUc37Po9X5QdZCPEbuhO9fqCQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734826255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f4JaMD+LeYz1a+Bt14ki8L2vyNW8FT1YTHQovuP5H4s=;
	b=OH8D5XfG0nziul9ODFzZLG8x2xqBo/fV3pC0zORnww9yq70ShWMXcah7Vo7a0MoAXg9Fgv
	KjFZ4RD3i7pmRPJ9go7pR/2RSVCKH9sdJDjtK8BBeJs75rLugYa4gcQw9P8KSSEyXpGJoq
	J7QSOVwtaRZdYWS+9IBOnrBy6QImKzI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A5E5134E4
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2024 00:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sQZIAw5ZZ2ecIAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2024 00:10:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: docs: extra notes about read-only scrub on read-write fs
Date: Sun, 22 Dec 2024 10:40:32 +1030
Message-ID: <077b7ef71095dfaf92e605c515e384033fdc0dd5.1734826227.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
There is a bug report that read-only scrub on a read-write fs still
causes writes into the fs, and that will be caught if there is a
read-only block device among the storage stack.

This will cause a kernel warning on failed transaction commit:

 BTRFS info (device dm-3): first mount of filesystem e18f0c40-88de-413f-9d7e-dcc8136ad6dd
 BTRFS info (device dm-3): using crc32c (crc32c-intel) checksum algorithm
 BTRFS info (device dm-3): using free-space-tree
 BTRFS info (device dm-3): scrub: started on devid 1
 Trying to write to read-only block-device md127
 btrfs_dev_stat_inc_and_print: 362 callbacks suppressed
 BTRFS error (device dm-3): bdev /dev/mapper/data errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device dm-3): bdev /dev/mapper/data errs: wr 2, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device dm-3): bdev /dev/mapper/data errs: wr 3, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device dm-3): bdev /dev/mapper/data errs: wr 4, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device dm-3): bdev /dev/mapper/data errs: wr 5, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device dm-3): bdev /dev/mapper/data errs: wr 6, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device dm-3): bdev /dev/mapper/data errs: wr 7, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device dm-3): bdev /dev/mapper/data errs: wr 8, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device dm-3): bdev /dev/mapper/data errs: wr 9, rd 0, flush 0, corrupt 0, gen 0
 BTRFS error (device dm-3): bdev /dev/mapper/data errs: wr 10, rd 0, flush 0, corrupt 0, gen 0
 BTRFS: error (device dm-3) in btrfs_commit_transaction:2523: errno=-5 IO failure (Error while writing out transaction)
 BTRFS info (device dm-3 state E): forced readonly
 BTRFS warning (device dm-3 state E): Skipping commit of aborted transaction.
 BTRFS error (device dm-3 state EA): Transaction aborted (error -5)
 BTRFS: error (device dm-3 state EA) in cleanup_transaction:2017: errno=-5 IO failure
 BTRFS warning (device dm-3 state EA): failed setting block group ro: -5
 BTRFS info (device dm-3 state EA): scrub: not finished on devid 1 with status: -5

[CAUSE]
The root cause is inside btrfs_inc_block_group_ro(), where we need to
hold a transaction handle, to prevent the transaction to be committed,
until we hold ro_block_group_mutex.

This will cause an empty transaction by itself, thus even if we can mark
the block group read-only without any extra workload, we still need to
commit the new and empty transaction.

Unfortunately this means RO scrub on RW filesystem will always cause the
fs to be updated.

[FIX]
The best fix is to make btrfs to avoid empty commit transaction, but
even with that done, read-only scrub on rw mount can still cause real
metadata updates (e.g. allocate new chunks and update device error
statistics).

It will be very complex to make read-only scrub to be fully read-only
on a read-write btrfs.

Thankfully read-only scrub on read-write mount with read-only device in
the storage stack is pretty rare, thus a documentation update should be
enough.

Issue: #934
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-scrub.rst    |  6 ++++++
 Documentation/ch-scrub-intro.rst | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/btrfs-scrub.rst b/Documentation/btrfs-scrub.rst
index 86c39b20cbde..539b67924b39 100644
--- a/Documentation/btrfs-scrub.rst
+++ b/Documentation/btrfs-scrub.rst
@@ -89,6 +89,12 @@ start [-BdrRf] <path>|<device>
         -r
                 run in read-only mode, do not attempt to correct anything, can
                 be run on a read-only filesystem
+
+		Note that a read-only scrub on a read-write filesystem can
+		still cause write into the filesystem due to some internal
+		limitations.
+		Only a read-only scrub on a read-only fs can avoid writes from
+		scrub.
         -R
                 raw print mode, print full data instead of summary
         -f
diff --git a/Documentation/ch-scrub-intro.rst b/Documentation/ch-scrub-intro.rst
index 2276bc263223..58afb466eb12 100644
--- a/Documentation/ch-scrub-intro.rst
+++ b/Documentation/ch-scrub-intro.rst
@@ -46,6 +46,16 @@ read-write mounted filesystem.
    used, with expert guidance, to rebuild certain corrupted filesystem structures
    in the absence of any good replica.
 
+.. note::
+   Read-only scrub on read-write filesystem will cause some write into the
+   filesystem.
+
+   This is due to the design limitation to prevent race between marking block
+   group read-only and writing back block group items.
+
+   To avoid any writes from scrub, one has to run read-only scrub on read-only
+   filesystem.
+
 The user is supposed to run it manually or via a periodic system service. The
 recommended period is a month but it could be less. The estimated device bandwidth
 utilization is about 80% on an idle filesystem.
-- 
2.47.1


