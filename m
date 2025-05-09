Return-Path: <linux-btrfs+bounces-13846-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C9AB09C1
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 07:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FF71C03E23
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 05:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2318268C69;
	Fri,  9 May 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tenmgMZl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tenmgMZl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF60B1FF5E3
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746769038; cv=none; b=cSpcFKUt/FqX5pfIzSaiFuF/3kV1Ojd7HVr9y0fQhGfdF11YMoxuKcz4OOlRJh9IHGYf4MNQUt/qGMDbp7N4djBivfHToPU8n65MWvYAU4qqsemq5sWzoWzfc3xRqrWP100CVie4Rh+D/d8Y2b/QJOf0ltL540dnhN9pwjcY+9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746769038; c=relaxed/simple;
	bh=OztqAdof0+4d44BR5LJBLQgw7G0EwuTpechlDVXSr7Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BFMzpE57Ax/7txvvQR1NmaJdjqQ6Kg+OzpDxKbrgq5h6+J0yp1G7BAL3UofkmfwNqGAhKn0brcMDKl8J8dFl9SL9r8SFulzVYNdTdQRt/+MG88/c+P9n76UoQ8DHk2fv66cABo3204Rvc/n9W7L0VOYlFuiZ5ymr0v7OlmTieRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tenmgMZl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tenmgMZl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DEB31F38A;
	Fri,  9 May 2025 05:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746769033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=epVwbicIwOBla5zRcwbqv8Ew4j6OkHnF9FuOJuDUv1Q=;
	b=tenmgMZlO/GLZ8lex9CdFeO7guWMJi2pWWOkWUi3eZNrV+lG52b67MhdgpgyQpFoWK1Xuc
	Xw4PdBn8DjAjPD4ViXLem8jA6JqXnu+NA0xEXXkUdnqS9urbDwmAxUXCZHNcsW74Km+15e
	NTff0GiPORmTpWNSOybuqkLfSDphuNE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746769033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=epVwbicIwOBla5zRcwbqv8Ew4j6OkHnF9FuOJuDUv1Q=;
	b=tenmgMZlO/GLZ8lex9CdFeO7guWMJi2pWWOkWUi3eZNrV+lG52b67MhdgpgyQpFoWK1Xuc
	Xw4PdBn8DjAjPD4ViXLem8jA6JqXnu+NA0xEXXkUdnqS9urbDwmAxUXCZHNcsW74Km+15e
	NTff0GiPORmTpWNSOybuqkLfSDphuNE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77C8A13515;
	Fri,  9 May 2025 05:37:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qznoDoiUHWhKKAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 09 May 2025 05:37:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/020: use device pool to avoid busy TEST_DEV
Date: Fri,  9 May 2025 15:07:09 +0930
Message-ID: <20250509053709.100446-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80

[BUG]
There is an internal report about btrfs/020 failure, the 020.full looks
like this:

  ERROR: ioctl(DEV_REPLACE_START) failed on "/opt/test/020.5968.mnt": Read-only file system

  Performing full device TRIM /dev/loop8 (256.00MiB) ...
  _check_btrfs_filesystem: filesystem on /dev/loop0 is inconsistent
  *** fsck.btrfs output ***
  ERROR: /dev/loop0 is currently mounted, use --force if you really intend to check the filesystem
  Opening filesystem to check...
  *** end fsck.btrfs output
  *** mount output ***
  [...]
  /dev/loop0 on /opt/test type btrfs (rw,relatime,seclabel,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/)
  *** end mount output

[CAUSE]
Unfortunately I can not reproduce the situation here, but it looks like
by somehow we didn't unmount the TEST_DEV before checking it.

This may or may not be caused by the fact we're using loop back devices
on TEST_MNT.

[FIX]
For this particluar test case, we really do not need to use TEST_MNT and
create complex loopback devices.

We can just ask for 3 devices from the device pool, use 2 for the raid1
fs, and then use the spare one for dev replace.

This should greately simplify the test case setup and cleanup, thus
avoid the above busy TEST_DEV and false test failure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/020 | 51 +++++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/tests/btrfs/020 b/tests/btrfs/020
index 7e5c6fd7..8c05196b 100755
--- a/tests/btrfs/020
+++ b/tests/btrfs/020
@@ -12,44 +12,27 @@
 . ./common/preamble
 _begin_fstest auto quick replace volume
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-	$UMOUNT_PROG $loop_mnt
-	_destroy_loop_device $loop_dev1
-	losetup -d $loop_dev2 >/dev/null 2>&1
-	_destroy_loop_device $loop_dev3
-	rm -rf $loop_mnt
-	rm -f $fs_img1 $fs_img2 $fs_img3
-}
-
 . ./common/filter
 
-_require_test
-_require_loop
+_require_scratch_dev_pool 3
+
+_fixed_by_kernel_commit bbb651e469d9 \
+	"Btrfs: don't allow the replace procedure on read only filesystems"
+
+_scratch_dev_pool_get 2
+_spare_dev_get
+
+_scratch_pool_mkfs -m raid1 -d raid1 >> $seqres.full 2>&1
+_scratch_mount -o ro
+
+$BTRFS_UTIL_PROG replace start -B 2 $SPARE_DEV $SCRATCH_MNT >> $seqres.full 2>&1 && \
+	echo "FAIL: Device replaced on RO btrfs"
+
+_scratch_unmount
+_spare_dev_put
+_scratch_dev_pool_put
 
 echo "Silence is golden"
 
-loop_mnt=$TEST_DIR/$seq.$$.mnt
-fs_img1=$TEST_DIR/$seq.$$.img1
-fs_img2=$TEST_DIR/$seq.$$.img2
-fs_img3=$TEST_DIR/$seq.$$.img3
-mkdir $loop_mnt
-$XFS_IO_PROG -f -c "truncate 256m" $fs_img1 >>$seqres.full 2>&1
-$XFS_IO_PROG -f -c "truncate 256m" $fs_img2 >>$seqres.full 2>&1
-$XFS_IO_PROG -f -c "truncate 256m" $fs_img3 >>$seqres.full 2>&1
-
-loop_dev1=`_create_loop_device $fs_img1`
-loop_dev2=`_create_loop_device $fs_img2`
-loop_dev3=`_create_loop_device $fs_img3`
-
-_mkfs_dev -m raid1 -d raid1 $loop_dev1 $loop_dev2 >>$seqres.full 2>&1
-_mount -o ro $loop_dev1 $loop_mnt
-
-$BTRFS_UTIL_PROG replace start -B 2 $loop_dev3 $loop_mnt >>$seqres.full 2>&1 && \
-_fail "FAIL: Device replaced on RO btrfs"
-
 status=0
 exit
-- 
2.47.1


