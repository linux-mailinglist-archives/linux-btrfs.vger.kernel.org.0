Return-Path: <linux-btrfs+bounces-17326-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E136BB22F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 02:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E80F7B3806
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 00:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB68618B0F;
	Thu,  2 Oct 2025 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ttGgW2To";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ttGgW2To"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57018027
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759366643; cv=none; b=WYcLKYsI2BN9unVia7+Zrtfh2Wdbbg9KX4PZ13yIlYqXXxkc3D4PpaScvQJtLieroqLPah8XmmVwy1ZXwmtHUY7L2yhVxLek5aqM7OgqhD4XQtelItolRmB2Ny9apXZZd+jmjkHvuQ+WAl/NdQixXSb0OQM296NqqkVWcd9ujwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759366643; c=relaxed/simple;
	bh=MfL8dLiIRjcmfaOTbo19MAz8pA7aoinQtqCiR5LbtE8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYdzh3CAsUhonU4jMtMroohX85xKozd0xkzOEc9YK8GzuqKCNZZdW6z4E86SztFHWcse1LvCmqYgT2eR71jQKQxjYUVvvNMfrhEXHoZhrKDdCoOZsNcKovTvSL+HiL0czzVy+zICCxzWl4/n8EMZhFtloKHThGQ3IyJ1WDzOKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ttGgW2To; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ttGgW2To; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 006331F7DD;
	Thu,  2 Oct 2025 00:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759366633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zNGn/QxHTACs2CoJNmdJmZrYPXcnqCGM21xFM8FRyM=;
	b=ttGgW2ToMdKyF1+u0gbAkV3l7qMGDQ04SXaJVz1jwKXAqf+ipPJ7Nu0LGJhuYvDQe/2G8g
	YGf8BqNzH7rXjteii9G+G4Ew1xO74Z/N4JLxW9IAkMvlraFIPG/WLwa/TlBXUTL6qLoqOP
	A3lqIxENbugv8aE7oe3JqLEzw8U9fh8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759366633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zNGn/QxHTACs2CoJNmdJmZrYPXcnqCGM21xFM8FRyM=;
	b=ttGgW2ToMdKyF1+u0gbAkV3l7qMGDQ04SXaJVz1jwKXAqf+ipPJ7Nu0LGJhuYvDQe/2G8g
	YGf8BqNzH7rXjteii9G+G4Ew1xO74Z/N4JLxW9IAkMvlraFIPG/WLwa/TlBXUTL6qLoqOP
	A3lqIxENbugv8aE7oe3JqLEzw8U9fh8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF58113A42;
	Thu,  2 Oct 2025 00:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kL57K+fN3WgxVgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 02 Oct 2025 00:57:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2 1/3] btrfs/012 btrfs/136: skip the test if ext* doesn't support the block size
Date: Thu,  2 Oct 2025 10:26:46 +0930
Message-ID: <20251002005648.47021-2-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251002005648.47021-1-wqu@suse.com>
References: <20251002005648.47021-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[FALSE ALERT]
When testing btrfs bs > ps support, the test cases btrfs/012 and
btrfs/136 fail like the following:

 FSTYP         -- btrfs
 PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #285 SMP PREEMPT_DYNAMIC Mon Sep 15 14:40:01 ACST 2025
 MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
 MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

 btrfs/012       [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/012.out.bad)
     --- tests/btrfs/012.out	2024-07-17 16:27:18.790000343 +0930
     +++ /home/adam/xfstests/results//btrfs/012.out.bad	2025-09-15 16:32:55.185922173 +0930
     @@ -1,7 +1,11 @@
      QA output created by 012
     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
     +       dmesg(1) may have more information after failed mount system call.
     +mkdir: cannot create directory '/mnt/scratch/stressdir': File exists
     +umount: /mnt/scratch: not mounted.
      Checking converted btrfs against the original one:
     -OK
     ...
     (Run 'diff -u /home/adam/xfstests/tests/btrfs/012.out /home/adam/xfstests/results//btrfs/012.out.bad'  to see the entire diff)

 btrfs/136 3s ... - output mismatch (see /home/adam/xfstests/results//btrfs/136.out.bad)
     --- tests/btrfs/136.out	2022-05-11 11:25:30.743333331 +0930
     +++ /home/adam/xfstests/results//btrfs/136.out.bad	2025-09-19 07:00:00.395280850 +0930
     @@ -1,2 +1,10 @@
      QA output created by 136
     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
     +       dmesg(1) may have more information after failed mount system call.
     +umount: /mnt/scratch: not mounted.
     +mount: /mnt/scratch: wrong fs type, bad option, bad superblock on /dev/mapper/test-scratch1, missing codepage or helper program, or other error.
     +       dmesg(1) may have more information after failed mount system call.
     +umount: /mnt/scratch: not mounted.
     ...
     (Run 'diff -u /home/adam/xfstests/tests/btrfs/136.out /home/adam/xfstests/results//btrfs/136.out.bad'  to see the entire diff)

[CAUSE]
Currently ext* doesn't support block size larger than page size, thus
at mkfs time it will output the following warning:

 Warning: blocksize 8192 not usable on most systems.
 mke2fs 1.47.3 (8-Jul-2025)
 Warning: 8192-byte blocks too big for system (max 4096), forced to continue

Furthermore at ext* mount time it will fail with the following dmesg:

 EXT4-fs (loop0): bad block size 8192

[FIX]
Check if the mount of the newly created ext* succeeded.

If not and the block size is larger than page size, we know it's some
block size ext* not yet supported, and skip the test case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/012 | 3 +++
 tests/btrfs/136 | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index f41d7e4e..6914fba6 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -42,6 +42,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
 	_notrun "Could not create ext4 filesystem"
 # Manual mount so we don't use -t btrfs or selinux context
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
+if [ $? -ne 0 -a $BLOCK_SIZE -gt $(_get_page_size) ]; then
+	_notrun "block size $BLOCK_SIZE is not supported by ext4"
+fi
 
 echo "populating the initial ext fs:" >> $seqres.full
 mkdir "$SCRATCH_MNT/$BASENAME"
diff --git a/tests/btrfs/136 b/tests/btrfs/136
index 65bbcf51..fd24d3f8 100755
--- a/tests/btrfs/136
+++ b/tests/btrfs/136
@@ -45,6 +45,9 @@ $MKFS_EXT4_PROG -F -t ext3 -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
 
 # mount and populate non-extent file
 mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
+if [ $? -ne 0 -a $BLOCK_SIZE -gt $(_get_page_size) ]; then
+	_notrun "block size $BLOCK_SIZE is not supported by ext3"
+fi
 populate_data "$SCRATCH_MNT/ext3_ext4_data/ext3"
 _scratch_unmount
 
-- 
2.51.0


