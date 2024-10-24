Return-Path: <linux-btrfs+bounces-9125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9BF9AE215
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 12:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF561C21D5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E763B1BD4FD;
	Thu, 24 Oct 2024 10:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cK4Cd7IF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cK4Cd7IF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9A91B0F17;
	Thu, 24 Oct 2024 10:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764335; cv=none; b=ZDkXkSAfZKyqLsXUmRBMsb4tKFZ3f0svbaxQYGDOlC1YmJWK83HDHnJQFK3DQEkPdQEDuAU4PP/XHSerkFl+CY/Xxryzcx0ObMPYapsBzYn7LqMlXTC+u5Zy3Y1Lm4UJMgIzHJHYg/uq8/V0kMhxg9Nz0/Pj2OizdOL3EH/xVqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764335; c=relaxed/simple;
	bh=jQmvmV1N65iyGPz5YbZFetjF2TCBWmN1kCLgRh+hNIg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lz5yDcFAI4sIZpWtEiSMhE2drOoVml9p62xR7VmXfu+xwyxudacArwdFVhNPyaJ9ghIVp6Ck0X6m58urfx3sTtGr+njWvh+cfXCO2KlHNkn1t+FfUzGEHumf6/NCDhOkpnp3CwuaqTFVbE82uxDzQRxQe+9lRoseGWqu0R9zYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cK4Cd7IF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cK4Cd7IF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95CF51FB40;
	Thu, 24 Oct 2024 10:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729764330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rpvjJPq/MbhsL/FDBvrhnVSYyKgN4mZRMfsNEM44BKc=;
	b=cK4Cd7IF8vQV5JNrhqAj+C8KYRtPrqzA0d44GYOVx8omigei++1cKrEb3WrEpI0w1R+EVS
	K89I79AdNzwIvuMSw0jpmJtRv2fC1yvOWa7zpjvtH+IzpdRmqMFH0ZF6gqkVboKmsOT0qj
	ygy/jo0n87c01gNYSXzagsxLTFETF3g=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cK4Cd7IF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729764330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rpvjJPq/MbhsL/FDBvrhnVSYyKgN4mZRMfsNEM44BKc=;
	b=cK4Cd7IF8vQV5JNrhqAj+C8KYRtPrqzA0d44GYOVx8omigei++1cKrEb3WrEpI0w1R+EVS
	K89I79AdNzwIvuMSw0jpmJtRv2fC1yvOWa7zpjvtH+IzpdRmqMFH0ZF6gqkVboKmsOT0qj
	ygy/jo0n87c01gNYSXzagsxLTFETF3g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80CA8136F5;
	Thu, 24 Oct 2024 10:05:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P5FNEOkbGmdqVgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 24 Oct 2024 10:05:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/330: enable the test case for both new and old APIs
Date: Thu, 24 Oct 2024 20:35:03 +1030
Message-ID: <65378a46dd8e00ddc6a485335a5ac43cfe7aba3b.1729764240.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 95CF51FB40
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
If the mount tool is utilizing the new fs-based API
(e.g. util-linux 2.40.2 from Archlinux), btrfs' per-subvolume RO/RW mount
is broken again:

  # mount -o subvol=subv1,ro /dev/test/scratch1 /mnt/test
  # mount -o rw,subvol=subv2 /dev/test/scratch1  /mnt/scratch
  # mount | grep mnt
  /dev/mapper/test-scratch1 on /mnt/test type btrfs (ro,relatime,discard=async,space_cache=v2,subvolid=256,subvol=/subv1)
  /dev/mapper/test-scratch1 on /mnt/scratch type btrfs (ro,relatime,discard=async,space_cache=v2,subvolid=257,subvol=/subv2)
  # touch /mnt/scratch/foobar
  touch: cannot touch '/mnt/scratch/foobar': Read-only file system

[CAUSE]
Btrfs has an extra remount hack to handle above case, which will
re-configure the super block to be RW on the first RW mount.

The initial promise is, the new fd-based API will not set ro FLAG, but
only MOUNT_ATTR_RDONLY, so that btrfs will skip the remount hack for new
API based mount request.

However it's not the case, the first RO subvolume mount will set ro flag
at fsconfig(), and also set MOUNT_ATTR_RDONLY attribute for the mount
point:

  # strace  mount -o subvol=subv1,ro /dev/test/scratch1 /mnt/test/
  ...
  fsconfig(3, FSCONFIG_SET_STRING, "source", "/dev/mapper/test-scratch1", 0) = 0
  fsconfig(3, FSCONFIG_SET_STRING, "subvol", "subv1", 0) = 0
  fsconfig(3, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
  fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
  fsmount(3, FSMOUNT_CLOEXEC, 0)          = 4
  mount_setattr(4, "", AT_EMPTY_PATH, {attr_set=MOUNT_ATTR_RDONLY, attr_clr=0, propagation=0 /* MS_??? */, userns_fd=0}, 32) = 0
  move_mount(4, "", AT_FDCWD, "/mnt/test", MOVE_MOUNT_F_EMPTY_PATH) = 0

This will result exactly the same behavior,  no matter if it's the new
API or not.

Furthermore we can even have corner cases like mounting the initial RO
subvolume using the old API, then mount the RW subvolume using the new
API.

So even using the new API, there is no guarantee to keep the
per-subvolume RO/RW mount feature.
We have to do the reconfigure anyway.

[FIX]
The kernel fix is already submitted, but for the test case part, we
should enable btrfs/330 for all mount tools, no matter the API it
utilizes.

The only difference for the new API based mount is the new
_fixed_by_kernel_commit call, to show the proper fix.

Now it can properly detects the broken feature.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/330 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/330 b/tests/btrfs/330
index 3545a116ecea..92cc498f2350 100755
--- a/tests/btrfs/330
+++ b/tests/btrfs/330
@@ -17,10 +17,13 @@ _cleanup()
 # Import common functions.
 . ./common/filter.btrfs
 
-_require_scratch
-
 $MOUNT_PROG -V | grep -q 'fd-based-mount'
-[ "$?" -eq 0 ] && _notrun "mount uses the new mount api"
+if [ "$?" -eq 0 ]; then
+	_fixed_by_kernel_commit xxxxxxxxxxxx \
+		"btrfs: fix per-subvolume RO/RW flags with new mount API"
+fi
+
+_require_scratch
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount
-- 
2.47.0


