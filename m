Return-Path: <linux-btrfs+bounces-14471-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3916ACE751
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 01:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889497A8C33
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 23:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85AB274649;
	Wed,  4 Jun 2025 23:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hRTlMEu5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hRTlMEu5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0895F79D0
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749081348; cv=none; b=ksJ8hNjdUUBz2LhH9NEL9RLBcdNoNdo/8wUVAeEefeTlHbXNtSkfu+cidAmArTgAHsi0Nsk1XjcvDcljEu1Nx+eNCYsx3OxplNZMcqgQ8upqNVoBRRlJrN8VTrqOvjOfOUu9mUXYTc3n2rH5N7WIkAssVwfNsBtFzJp4L4O2EDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749081348; c=relaxed/simple;
	bh=487lMXqsA8opQPvnqgZoh2SJB6hMupvwyiV88ZwxLLQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GK/GDVxOXlHYksrIjzV68SMQYcuhvronfWx6Di3hzJXN6s86yfUW9IHNSzuasbss9zkZeQdlsSB4AIlx6/dR6EBShdSFfNpqjRSzdtLyQx8CAhIYihqbT8oe6y3DLZGojIQ/rlKoSMULliovRTSn7TcCHzeukOCoGFYK/KP7HtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hRTlMEu5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hRTlMEu5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 20B792074F;
	Wed,  4 Jun 2025 23:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749081343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lNrO3yJebky8p4+PW5ypvBCJlSheqWJcBXHyjpfr9VQ=;
	b=hRTlMEu5i5BIw2OBIXxlcy7PucRIOAZE39N1IbmVB5mOVlLMCqH4QFMu1iZmcFzsIlur02
	lS4Ox93ZFFziiCPalP3JAwYm8utBHgzWMQlPe7ickYIrutymLtC8c9DlehdBzlyy7kLMBE
	SjS6PoCs8/iygAlhEX+jGDF8Bqjp9AI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749081343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lNrO3yJebky8p4+PW5ypvBCJlSheqWJcBXHyjpfr9VQ=;
	b=hRTlMEu5i5BIw2OBIXxlcy7PucRIOAZE39N1IbmVB5mOVlLMCqH4QFMu1iZmcFzsIlur02
	lS4Ox93ZFFziiCPalP3JAwYm8utBHgzWMQlPe7ickYIrutymLtC8c9DlehdBzlyy7kLMBE
	SjS6PoCs8/iygAlhEX+jGDF8Bqjp9AI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E5781336F;
	Wed,  4 Jun 2025 23:55:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wDXfM/3cQGjWKwAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 04 Jun 2025 23:55:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: generic/741: make cleanup to handle test failure properly
Date: Thu,  5 Jun 2025 09:25:24 +0930
Message-ID: <20250604235524.26356-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
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
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

[BUG]
When I was tinkering the bdev open holder parameter, it caused a bug
that it no longer rejects mounting the underlying device of a
device-mapper.

And the test case properly detects the regression:

generic/741 1s ... umount: /mnt/test: target is busy.
_check_btrfs_filesystem: filesystem on /dev/mapper/test-test is inconsistent
(see /home/adam/xfstests/results//generic/741.full for details)
Trying to repair broken TEST_DEV file system
_check_btrfs_filesystem: filesystem on /dev/mapper/test-scratch1 is inconsistent
(see /home/adam/xfstests/results//generic/741.full for details)
- output mismatch (see /home/adam/xfstests/results//generic/741.out.bad)
    --- tests/generic/741.out	2024-04-06 08:10:44.773333344 +1030
    +++ /home/adam/xfstests/results//generic/741.out.bad	2025-06-05 09:18:03.675049206 +0930
    @@ -1,3 +1,2 @@
     QA output created by 741
    -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
    -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
    +rm: cannot remove '/mnt/test/extra_mnt': Device or resource busy
    ...
    (Run 'diff -u /home/adam/xfstests/tests/generic/741.out /home/adam/xfstests/results//generic/741.out.bad'  to see the entire diff)

The problem is, all later test will fail, because the $SCRATCH_DEV is
still mounted at $extra_mnt:

 TEST_DEV=/dev/mapper/test-test is mounted but not on TEST_DIR=/mnt/test - aborting
 Already mounted result:
 /dev/mapper/test-test /mnt/test /dev/mapper/test-test /mnt/test

[CAUSE]
The test case itself is doing two expected-to-fail mounts, but the
cleanup function is only doing unmount once, if the mount succeeded
unexpectedly, the $SCRATCH_DEV will be mounted at $extra_mnt forever.

[ENHANCEMENT]
To avoid screwing up later test cases, do the $extra_mnt cleanup twice
to handle the unexpected mount success.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/generic/741 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/741 b/tests/generic/741
index cac7045e..c15dc434 100755
--- a/tests/generic/741
+++ b/tests/generic/741
@@ -13,6 +13,10 @@ _begin_fstest auto quick volume tempfsid
 # Override the default cleanup function.
 _cleanup()
 {
+	# If by somehow the fs mounted the underlying device (twice), we have
+	# to  make sure $extra_mnt is not mounted, or TEST_DEV can not be
+	# unmounted for fsck.
+	_unmount $extra_mnt &> /dev/null
 	_unmount $extra_mnt &> /dev/null
 	rm -rf $extra_mnt
 	_unmount_flakey
-- 
2.49.0


