Return-Path: <linux-btrfs+bounces-8317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E7A989872
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 01:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239A21C20F59
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Sep 2024 23:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1642617E8E2;
	Sun, 29 Sep 2024 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l8lfdcxq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l8lfdcxq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB9C4A0F;
	Sun, 29 Sep 2024 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727653866; cv=none; b=jmAKtpX4VXiYnkfpGdF1C+cSGUn7r3lfM3NsSUsKrtZQXGznAFewKrO4C5K9TzibGLTtXhO75iQXbhnb/xqA1zfqoGDftErFl+EOhT2T15e8UoizXxdC+ESPadoqB+6tYiR/gAcAR528l32rtnTqle4jDLgu6fqXhhSAoSxVXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727653866; c=relaxed/simple;
	bh=/BsrCrWq1URQlY5fe1bnedL18iDPB/mGz3SxHyeiZMY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=i4IIHcVcRzs1dYHbZXs7U3lGHe4UReU9I6ro3jGnXNibikYtD2aVlIi6p594noQZr8199QnbqTmfRR8c0LhLAjfP3GDrpTHmPMBFtPuzQuodJV8DTmHVU/jz1B+8Zqqf5NYv73/riIq2X8sHVkxNpG8RuwcLT8USZw0r8FK6RVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l8lfdcxq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l8lfdcxq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2927B1F7D9;
	Sun, 29 Sep 2024 23:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727653861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lIw1wNj8boXvBzPfau/5v6jbPYE0ZRQ1xpq8FQ11hXk=;
	b=l8lfdcxqPvzYk8Z3gBZaadsXujN9haO8pYr8cfO3laysAKftvyO/qXbPLK40VxaIM7f0Yx
	nBEZNrGvExAvF1JQqgoDwkn5QUBO0pl8Gi5QJme+o7k3e6i98EXtTFN1ebJRZa9RuaMnav
	Blt1a3lnJtiGxWcWaniNsjmYco/4tI0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=l8lfdcxq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727653861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lIw1wNj8boXvBzPfau/5v6jbPYE0ZRQ1xpq8FQ11hXk=;
	b=l8lfdcxqPvzYk8Z3gBZaadsXujN9haO8pYr8cfO3laysAKftvyO/qXbPLK40VxaIM7f0Yx
	nBEZNrGvExAvF1JQqgoDwkn5QUBO0pl8Gi5QJme+o7k3e6i98EXtTFN1ebJRZa9RuaMnav
	Blt1a3lnJtiGxWcWaniNsjmYco/4tI0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E25E139A9;
	Sun, 29 Sep 2024 23:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DnmxOOPn+WagEAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 29 Sep 2024 23:50:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: generic/563: use fs blocksize to do the writes
Date: Mon, 30 Sep 2024 09:20:38 +0930
Message-ID: <20240929235038.24497-1-wqu@suse.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2927B1F7D9
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[FALSE ALERTS]
If the system has a page size larger than 4K, and the fs block size
matches the page size, test case generic/563 will fail:

    --- tests/generic/563.out	2024-04-25 18:13:45.178550333 +0930
    +++ /home/adam/xfstests-dev/results//generic/563.out.bad	2024-09-30 09:09:16.155312379 +0930
    @@ -3,7 +3,8 @@
     read is in range
     write is in range
     write -> read/write
    -read is in range
    +read has value of 8388608
    +read is NOT in range -33792 .. 33792
     write is in range
    ...

Both Ext4 and btrfs fail with 64K block size and 64K page size

[CAUSE]
The test case writes the 8MiB file using the default block size xfs_io
pwrite, which is 4KiB.

Since the fs block size is 64K, such 4KiB write is unaligned inside a
block, causing the fs to read out the full page.

Thus the pwrite will cause the fs to read out every page, resulting the
above 8MiB+ read value.

[FIX]
Fix the test case by using the fs block size to avoid such unaligned
buffered write.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/generic/563 | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/generic/563 b/tests/generic/563
index 0a8129a6..e8db8acf 100755
--- a/tests/generic/563
+++ b/tests/generic/563
@@ -94,6 +94,8 @@ sminor=$((0x`stat -L -c %T $LOOP_DEV`))
 _mkfs_dev $LOOP_DEV >> $seqres.full 2>&1
 _mount $LOOP_DEV $SCRATCH_MNT || _fail "mount failed"
 
+blksize=$(_get_block_size "$SCRATCH_MNT")
+
 drop_io_cgroup=
 grep -q -w io $cgdir/cgroup.subtree_control || drop_io_cgroup=1
 
@@ -103,7 +105,7 @@ echo "+io" > $cgdir/cgroup.subtree_control || _fail "subtree control"
 echo "read/write"
 reset
 switch_cg $cgdir/$seq-cg
-$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" -c fsync \
+$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" -c fsync \
 	$SCRATCH_MNT/file >> $seqres.full 2>&1
 switch_cg $cgdir
 $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
@@ -114,9 +116,9 @@ check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
 echo "write -> read/write"
 reset
 switch_cg $cgdir/$seq-cg
-$XFS_IO_PROG -c "pwrite 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
+$XFS_IO_PROG -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
 switch_cg $cgdir/$seq-cg-2
-$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
+$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file \
 	>> $seqres.full 2>&1
 switch_cg $cgdir
 $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
@@ -134,7 +136,7 @@ reset
 switch_cg $cgdir/$seq-cg
 $XFS_IO_PROG -c "pread 0 $iosize" $SCRATCH_MNT/file >> $seqres.full 2>&1
 switch_cg $cgdir/$seq-cg-2
-$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite 0 $iosize" $SCRATCH_MNT/file \
+$XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b $blksize 0 $iosize" $SCRATCH_MNT/file \
 	>> $seqres.full 2>&1
 switch_cg $cgdir
 $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
-- 
2.46.0


