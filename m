Return-Path: <linux-btrfs+bounces-16945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9132FB87476
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 00:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4A35821F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 22:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F1E2FFDDD;
	Thu, 18 Sep 2025 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qN+Abdoj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qN+Abdoj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4E2F3632
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758235435; cv=none; b=NLXbJzEVQgq5ZWPagh6f1XIIEW/SN0T+oiiCxB5pYRlY8GnRwYkfbXxNmboN5OEjUHxkWX6E8CfRpRXHmWhcxToPK0nDiZCXlQXnKU1tMATgCQv/G88/jJdL8Bld18eD4giV0X0ByUmyZEeVCNBRmeuGxPYyiP+6hXFQE2cIhu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758235435; c=relaxed/simple;
	bh=+VRc+PXiVcZtWssiHv9Si6LAtL/v9Q+LMtLwW67DI5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHATSjsJC1YIaPWSL1LqsUoCO8F5LQM747JHWvxC0faboRaDAz5Lm8i7Eyr7QdzLwsTjAEe3GUxrAgZAnytvaZOCVK3B3xuQpekUnwACbbzHt3mNQLbfuxR0gYAUky3MZeF5s+cslb+r2J3BrQzW0CLBlutOVxYqc0TicwkLPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qN+Abdoj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qN+Abdoj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE0983368A;
	Thu, 18 Sep 2025 22:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758235431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olqhF6sZOV3bfIQt4DsyoEFZk8gKKlynwxc7naHjumA=;
	b=qN+AbdojOI8/BCYR0eTFYuNfc3IicjbkvgFSgLSu/Rdc0wePJEhSdEcQVdTvXQjcTuQC2p
	W6uBxBlGLlu6PwQtRMy32sxvXAxTTct7YMc61O/YYwdOYz5majn5VRzJJw4ojqFtFMQXgn
	ZH5fA5vXYpxOHtGunoyA/ppzO9VvT4Q=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758235431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olqhF6sZOV3bfIQt4DsyoEFZk8gKKlynwxc7naHjumA=;
	b=qN+AbdojOI8/BCYR0eTFYuNfc3IicjbkvgFSgLSu/Rdc0wePJEhSdEcQVdTvXQjcTuQC2p
	W6uBxBlGLlu6PwQtRMy32sxvXAxTTct7YMc61O/YYwdOYz5majn5VRzJJw4ojqFtFMQXgn
	ZH5fA5vXYpxOHtGunoyA/ppzO9VvT4Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C642C13A39;
	Thu, 18 Sep 2025 22:43:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oGdJIiaLzGj4XAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 18 Sep 2025 22:43:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH 1/3] btrfs/012 btrfs/136: skip the test if ext* doesn't support the block size
Date: Fri, 19 Sep 2025 08:13:25 +0930
Message-ID: <20250918224327.12979-2-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250918224327.12979-1-wqu@suse.com>
References: <20250918224327.12979-1-wqu@suse.com>
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

If not, since the only extra parameter for mkfs is the block size, we
know it's some block size ext* not yet supported, and skip the test
case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/012 | 3 +++
 tests/btrfs/136 | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index f41d7e4e..665831b9 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -42,6 +42,9 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
 	_notrun "Could not create ext4 filesystem"
 # Manual mount so we don't use -t btrfs or selinux context
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
+if [ $? -ne 0 ]; then
+	_notrun "block size $BLOCK_SIZE is not supported by ext4"
+fi
 
 echo "populating the initial ext fs:" >> $seqres.full
 mkdir "$SCRATCH_MNT/$BASENAME"
diff --git a/tests/btrfs/136 b/tests/btrfs/136
index 65bbcf51..6b4b52e4 100755
--- a/tests/btrfs/136
+++ b/tests/btrfs/136
@@ -45,6 +45,9 @@ $MKFS_EXT4_PROG -F -t ext3 -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
 
 # mount and populate non-extent file
 mount -t ext3 $SCRATCH_DEV $SCRATCH_MNT
+if [ $? -ne 0 ]; then
+	_notrun "block size $BLOCK_SIZE is not supported by ext3"
+fi
 populate_data "$SCRATCH_MNT/ext3_ext4_data/ext3"
 _scratch_unmount
 
-- 
2.51.0


