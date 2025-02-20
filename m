Return-Path: <linux-btrfs+bounces-11667-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A11AA3DD82
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 15:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133D13B7735
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF08A1F76C0;
	Thu, 20 Feb 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WWqCvBpl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cUUhu+my"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E51D63D2
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063450; cv=none; b=olQ1xrAoC5rbc/JdsHgqgKUcevQCJILZZ6IoCvCtrzqUuzzsJkQqY/BBga88OPLEuze5JLyIjAi/bm41eT+NwKHXesH9wBRtfGgY5TwXQauSjeGu6OBRPBJmSaytCro/4T/SrL8/omPCuL6GVJDeVGSwYBWVjly3RLQNGYGcoqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063450; c=relaxed/simple;
	bh=AIaovNgiaq8lOnvtpM7U66/mO+cGQ/qjshhhc4+CWCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIpqpigUQwQOqvL1hVbVOJ4pEhs9RlBjddTf/p2mn8KsOnW0SEtX/tbV3jv+4fc/kQO5SZTvjNIQP6gF16Vda6/sobW2V65dcwPthPeger/MExZli39nQCiatx87ERZxoq3ECvmCCIqnuOo2n1xJA0qz6sbWcY3amU49Qd/My9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WWqCvBpl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cUUhu+my; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F295A1F388;
	Thu, 20 Feb 2025 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740063446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oSaY3vDCvLYSA/Kh8OgXvQHSePeoZAn1q7aFrNXRwjE=;
	b=WWqCvBplN2jXvaq5FqXeRYcQK/Sm9X5+ejnsp9hQ8Hg8KkNxNngdaZ6KBtWtXV1us0qHVF
	2h8aioc1DC53w7PcLsvP17ybcWGV6JPOSsHVEzk3cpa2tLO7KRFa1BeIJamSTEJpbHAg9i
	4N7r9phyiqhUO8EWhfBzKBhzqBuUDI8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cUUhu+my
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740063445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oSaY3vDCvLYSA/Kh8OgXvQHSePeoZAn1q7aFrNXRwjE=;
	b=cUUhu+myIE+XwbD6yIM7iCEtrMi0+cq577je4xY4V/34e8ujW0rqrJ6+ZwrmEP3dNwjHn7
	NQk8IoWzuR6daSOyhV18zx1armR2eFjFB+yf6pqJt59zZfXbQ/8+yLjJQQ/O1MliSx9A4e
	mWCrZR1PYfIb6HGseKw+3sqOYbIg6LM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDC1213A42;
	Thu, 20 Feb 2025 14:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g0+KNdRCt2cdYgAAD6G6ig
	(envelope-from <neelx@suse.com>); Thu, 20 Feb 2025 14:57:24 +0000
From: Daniel Vacek <neelx@suse.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Anand Jain <anand.jain@oracle.com>,
	Daniel Vacek <neelx@suse.com>
Subject: [PATCH] fstests: btrfs/314: fix the failure when SELinux is enabled
Date: Thu, 20 Feb 2025 15:57:23 +0100
Message-ID: <20250220145723.1526907-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F295A1F388
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

When SELinux is enabled this test fails unable to receive a file with
security label attribute:

    --- tests/btrfs/314.out
    +++ results//btrfs/314.out.bad
    @@ -17,5 +17,6 @@
     At subvol TEST_DIR/314/tempfsid_mnt/snap1
     Receive SCRATCH_MNT
     At subvol snap1
    +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
     Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
    -Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
    +Recv:	d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
    ...

Setting the security label file attribute fails due to the default mount
option implied by fstests:

MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch

See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")

fstests by default mount test and scratch devices with forced SELinux
context to get rid of the additional file attributes when SELinux is
enabled. When a test mounts additional devices from the pool, it may need
to honor this option to keep on par. Otherwise failures may be expected.

Moreover this test is perfectly fine labeling the files so let's just
disable the forced context for this one.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 tests/btrfs/314 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/314 b/tests/btrfs/314
index 76dccc41..cc1a2264 100755
--- a/tests/btrfs/314
+++ b/tests/btrfs/314
@@ -21,6 +21,10 @@ _cleanup()
 
 . ./common/filter.btrfs
 
+# Disable the forced SELinux context. We are fine testing the
+# security labels with this test when SELinux is enabled.
+SELINUX_MOUNT_OPTIONS=
+
 _require_scratch_dev_pool 2
 _require_btrfs_fs_feature temp_fsid
 
@@ -38,7 +42,7 @@ send_receive_tempfsid()
 	# Use first 2 devices from the SCRATCH_DEV_POOL
 	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
 	_scratch_mount
-	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
+	_mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
 
 	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
 	_btrfs subvolume snapshot -r ${src} ${src}/snap1
-- 
2.48.1


