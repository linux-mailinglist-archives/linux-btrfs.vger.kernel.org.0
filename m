Return-Path: <linux-btrfs+bounces-16812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAC1B570DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 09:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EB23B7275
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Sep 2025 07:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8F2D23A8;
	Mon, 15 Sep 2025 07:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fZoPm04x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fZoPm04x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A794A2D1907
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Sep 2025 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920082; cv=none; b=gbzmcjfVJQ/0Y6w/HuNj7RDfD+NLQkWH9MufVlJUnvGX53ld+IKiygBDd3RFVYMLFOPfHpFZ4q/Xxu2GtlFwpRA1dB4tmm0qwDBMHGaTNgXYunGOEa0o2euRkCMxAJVHNd1OgLdL4E9Tiz/rVJjYzR/3FSUVrmubeFOQUwwAeq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920082; c=relaxed/simple;
	bh=900d0dgWoM98QKISuskXJWd15dtgPucL7vFw3lHpYPQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=opsGHXFB8PjtHkWys3Q4hKIfDo1eS1uELOmDu65BLL5V41W6k8AimOMGP0366uYn+RiNebPGDPdWmavwFVjtP6WQii2Q0Lej8jr8nTS2hIUae307RWODIpZI2HmMoPU2Fh83CU/Kt1AggRLUlBhfeQ6yfVqTJcc/SAsrVvUzgvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fZoPm04x; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fZoPm04x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF508336FA;
	Mon, 15 Sep 2025 07:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757920077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kGNremU5v22XDXa3cl4bxNtHj1V0yhztpMjpWPvRlaA=;
	b=fZoPm04xBSL7JdfclS/FF82cX9bDYhu5rf3wT48TmT1OIEJGLe8d61ZDWiPB+zsu5ET9ju
	1ZlIr8fKZRrW79Tr2KeJDx4wryR3zmVvFIhQZKoJLurMuioBifM6DFYGORZ6ruwKznesNd
	69WAJ4S0KrJpfVuOPVK9baXLCA31rN4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fZoPm04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1757920077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kGNremU5v22XDXa3cl4bxNtHj1V0yhztpMjpWPvRlaA=;
	b=fZoPm04xBSL7JdfclS/FF82cX9bDYhu5rf3wT48TmT1OIEJGLe8d61ZDWiPB+zsu5ET9ju
	1ZlIr8fKZRrW79Tr2KeJDx4wryR3zmVvFIhQZKoJLurMuioBifM6DFYGORZ6ruwKznesNd
	69WAJ4S0KrJpfVuOPVK9baXLCA31rN4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C27291372E;
	Mon, 15 Sep 2025 07:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gJ75IEy7x2h8TAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 15 Sep 2025 07:07:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/012: skip the test if ext4 doesn't support the block size
Date: Mon, 15 Sep 2025 16:37:39 +0930
Message-ID: <b498ac80e6a7f3b10c08a33da450c36abbeffcd8.1757920030.git.wqu@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: BF508336FA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[FALSE ALERT]
When testing btrfs bs > ps support, the test case btrfs/012 fails like
the following:

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
 Ran: btrfs/012
 Failures: btrfs/012
 Failed 1 of 1 tests

Please note that, this is based on an under-development local branch,
which is enabling bs > ps support for btrfs, with around 10 patches
beyodn the current development branch.

No mainline kernel can mount a btrfs with 8K block size with 4K page
size yet.

[CAUSE]
Currently ext4 doesn't support block size larger than page size, thus
at mkfs time it will output the following warning:

 Warning: blocksize 8192 not usable on most systems.
 mke2fs 1.47.3 (8-Jul-2025)
 Warning: 8192-byte blocks too big for system (max 4096), forced to continue

Furthermore at ext4 mount time it will fail with the following dmesg:

 EXT4-fs (loop0): bad block size 8192

[FIX]
Check if the mount of the newly created ext4 succeeded.
If not, since the only extra parameter for ext4 is the block size, we
know it's some block size ext4 not yet supported, and skip the test
case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/012 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index f41d7e4eb864..5d41f2e77210 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -43,6 +43,13 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
 # Manual mount so we don't use -t btrfs or selinux context
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
 
+# Btrfs and ext4 may have different supported block size.
+# If above mount fails it normally means the blocksize is causing problem,
+# and we should skip the test.
+if [ $? -ne 0 ]; then
+	_notrun "block size $BLOCK_SIZE is not supported by ext4"
+fi
+
 echo "populating the initial ext fs:" >> $seqres.full
 mkdir "$SCRATCH_MNT/$BASENAME"
 _run_fsstress -w -d "$SCRATCH_MNT/$BASENAME" -n 20 -p 500
-- 
2.50.1


