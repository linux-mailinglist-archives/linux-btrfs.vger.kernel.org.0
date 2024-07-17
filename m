Return-Path: <linux-btrfs+bounces-6512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D021C9337FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 09:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521141F2249A
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2024 07:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD21BF3A;
	Wed, 17 Jul 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jAXdx7NK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jAXdx7NK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D420182B5;
	Wed, 17 Jul 2024 07:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201251; cv=none; b=evoGKSf6JBQ3m4auOMuxgspEgstqTc6iXrcSWX3QGJupD1Ger6dTCehYSPQfFu8HOlWGcIvybKJWrmenJeQH5ddYZVlkgO4TfxNGX4Vso8nTQ99sNkuhepsP7C0S1Zbqw+gA/ooddsc9/q+PMwSggPkKp51dKF9UZipZRltsHeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201251; c=relaxed/simple;
	bh=RTf69nJA+LYxKZljIKwgVqh9G9MtWHx3bUySq+f5tb4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PE8ZxLKuIjmzOPljAakSr21uq9zDzqCMu7rMW4QgoZU6Eo8/yGkrWPUYemZVMaxeTisauaP9bpJ6wBTk5C3/4sokFGcEOLveoi4Udlzf0CxU8JgoLJ63v2Lwt1utADIzvDfHk2BpoltbkQgAr7HKQ2WisQGyUPY4g4kNZbgnqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jAXdx7NK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jAXdx7NK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92F811FB61;
	Wed, 17 Jul 2024 07:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721201247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qPcLr1Ek6+T5z3/pqieAQ2BmsmHct7e+UyYfjIbpagQ=;
	b=jAXdx7NKyPeKfHoOauTGtB8Oq947AuCp+j4vGqw6OWZS5oqKuTMySofHbxBE2XktQbPT3u
	QSlXpWVr6OqCLGLvRcORGYudaWfEmWqRHyq0dlAnABoV8bFjD0KJ7o4/0FrVruURB03x9/
	JjEpDBosXqwT6wFE+mqgwbwlr6/kP4A=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1721201247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qPcLr1Ek6+T5z3/pqieAQ2BmsmHct7e+UyYfjIbpagQ=;
	b=jAXdx7NKyPeKfHoOauTGtB8Oq947AuCp+j4vGqw6OWZS5oqKuTMySofHbxBE2XktQbPT3u
	QSlXpWVr6OqCLGLvRcORGYudaWfEmWqRHyq0dlAnABoV8bFjD0KJ7o4/0FrVruURB03x9/
	JjEpDBosXqwT6wFE+mqgwbwlr6/kP4A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7224D136E5;
	Wed, 17 Jul 2024 07:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9qtLC15yl2b3fQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 17 Jul 2024 07:27:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/012: fix a false alert due to socket/pipe files
Date: Wed, 17 Jul 2024 16:57:00 +0930
Message-ID: <20240717072700.93025-1-wqu@suse.com>
X-Mailer: git-send-email 2.45.2
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
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

[BUG]
On my Archlinux VM, the test btrfs/012 always fail with the following
output diff:

     QA output created by 012
    +File /etc/pacman.d/gnupg/S.dirmngr is a socket while file /mnt/scratch/etc/pacman.d/gnupg/S.dirmngr is a socket
    +File /etc/pacman.d/gnupg/S.gpg-agent is a socket while file /mnt/scratch/etc/pacman.d/gnupg/S.gpg-agent is a socket
    +File /etc/pacman.d/gnupg/S.gpg-agent.browser is a socket while file /mnt/scratch/etc/pacman.d/gnupg/S.gpg-agent.browser is a socket
    +File /etc/pacman.d/gnupg/S.gpg-agent.extra is a socket while file /mnt/scratch/etc/pacman.d/gnupg/S.gpg-agent.extra is a socket
    +File /etc/pacman.d/gnupg/S.gpg-agent.ssh is a socket while file /mnt/scratch/etc/pacman.d/gnupg/S.gpg-agent.ssh is a socket
    +File /etc/pacman.d/gnupg/S.keyboxd is a socket while file /mnt/scratch/etc/pacman.d/gnupg/S.keyboxd is a socket
    ...

[CAUSE]
It's a false alerts.

When diff hits two files which are not directory/softlink/regular files
(aka, socket/pipe/char/block files), they are all treated as
non-comparable.
In that case, diff would just do the above message.

And with Archlinux, pacman (the package manager) maintains its gpg
directory inside "/etc/pacman.d/gnupg", and the test case uses
"/etc" as the source directory to populate the target ext4 fs.

And the socket files inside "/etc/pacman.d/gnupg" is causing the false
alerts.

[FIX]
- Use fsstress to populate the fs
  That covers all kind of operations, including creating special files.
  And fsstress is very reproducible, with the seed saved to the full
  log, it's much easier to reproduce than using the distro dependent
  "/etc/" directory.

- Use fssum to save the digest and later verify the contents
  It does not only verify the contents but also other things like
  timestamps/xattrs/uid/gid/mode/etc.
  And it's more comprehensive than the content oriented diff tool.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/012     | 29 +++++++++++++++++------------
 tests/btrfs/012.out |  6 ++++++
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index a96efeff..d172d93f 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -23,13 +23,13 @@ _require_scratch_nocheck
 _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
 _require_command "$MKFS_EXT4_PROG" mkfs.ext4
 _require_command "$E2FSCK_PROG" e2fsck
+_require_fssum
 # ext4 does not support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
 _require_loop
 _require_extra_fs ext4
 
-SOURCE_DIR=/etc
-BASENAME=$(basename $SOURCE_DIR)
+BASENAME="stressdir"
 BLOCK_SIZE=`_get_block_size $TEST_DIR`
 
 # Create & populate an ext4 filesystem
@@ -38,17 +38,21 @@ $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
 # Manual mount so we don't use -t btrfs or selinux context
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
 
-_require_fs_space $SCRATCH_MNT $(du -s $SOURCE_DIR | ${AWK_PROG} '{print $1}')
+echo "populating the initial ext fs:" >> $seqres.full
+mkdir "$SCRATCH_MNT/$BASENAME"
+$FSSTRESS_PROG -w -d "$SCRATCH_MNT/$BASENAME" -n 20 -p 500 >> $seqres.full
 
-$TIMEOUT_PROG 10 cp -aRP $SOURCE_DIR $SCRATCH_MNT
+# Create the checksum to verify later.
+$FSSUM_PROG -A -f -w $tmp.original "$SCRATCH_MNT/$BASENAME"
 _scratch_unmount
 
 # Convert it to btrfs, mount it, verify the data
 $BTRFS_CONVERT_PROG $SCRATCH_DEV >> $seqres.full 2>&1 || \
 	_fail "btrfs-convert failed"
 _try_scratch_mount || _fail "Could not mount new btrfs fs"
-# (Ignore the symlinks which may be broken/nonexistent)
-diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/$BASENAME/ 2>&1
+
+echo "Checking converted btrfs against the original one:"
+$FSSUM_PROG -r $tmp.original $SCRATCH_MNT/$BASENAME
 
 # Old ext4 image file should exist & be consistent
 $E2FSCK_PROG -fn $SCRATCH_MNT/ext2_saved/image >> $seqres.full 2>&1 || \
@@ -58,13 +62,14 @@ $E2FSCK_PROG -fn $SCRATCH_MNT/ext2_saved/image >> $seqres.full 2>&1 || \
 mkdir -p $SCRATCH_MNT/mnt
 mount -o loop $SCRATCH_MNT/ext2_saved/image $SCRATCH_MNT/mnt || \
 	_fail "could not loop mount saved ext4 image"
-# Ignore the symlinks which may be broken/nonexistent
-diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/mnt/$BASENAME/ 2>&1
+
+echo "Checking saved ext2 image against the original one:"
+$FSSUM_PROG -r $tmp.original $SCRATCH_MNT/mnt/$BASENAME
 umount $SCRATCH_MNT/mnt
 
-# Now put some fresh data on the btrfs fs
+echo "genereating new data on the converted btrfs" >> $seqres.full
 mkdir -p $SCRATCH_MNT/new 
-$TIMEOUT_PROG 10 cp -aRP $SOURCE_DIR $SCRATCH_MNT/new
+$FSSTRESS_PROG -w -d "$SCRATCH_MNT/new" -n 20 -p 500 >> $seqres.full
 
 _scratch_unmount
 
@@ -78,8 +83,8 @@ $E2FSCK_PROG -fn $SCRATCH_DEV >> $seqres.full 2>&1 || \
 
 # Mount the un-converted ext4 device & check the contents
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
-# (Ignore the symlinks which may be broken/nonexistent)
-diff --no-dereference -r $SOURCE_DIR $SCRATCH_MNT/$BASENAME/ 2>&1
+echo "Checking rolled back ext2 against the original one:"
+$FSSUM_PROG -r $tmp.original $SCRATCH_MNT/$BASENAME
 
 _scratch_unmount
 
diff --git a/tests/btrfs/012.out b/tests/btrfs/012.out
index 7aa5ae94..8ea81fad 100644
--- a/tests/btrfs/012.out
+++ b/tests/btrfs/012.out
@@ -1 +1,7 @@
 QA output created by 012
+Checking converted btrfs against the original one:
+OK
+Checking saved ext2 image against the original one:
+OK
+Checking rolled back ext2 against the original one:
+OK
-- 
2.45.2


