Return-Path: <linux-btrfs+bounces-16618-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89835B431CF
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 07:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19941188E38A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Sep 2025 05:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B3241C89;
	Thu,  4 Sep 2025 05:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GREV8ACG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kme/EdNu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9723ABB9
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Sep 2025 05:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756965217; cv=none; b=Hq7XrwfJltRAeNE412j3LyTmhz6Ot+wrsj2G7xqv2i6PR9L3D2W/as6afhqyka56/CeaFVxbXgcqJfG6JsvdsJiQGUwc0xvDZmb1sWCtikg+KJoywd+5HVLMAYEVvHRZmdRiiwt1wOs1ihRnpGoJ/ZK9r8OXTUhffyCequyU53w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756965217; c=relaxed/simple;
	bh=ahSXSg5cm5PHpthnZIQMVOsrP9ygX5CJ9kNUfKqj2B8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P1Fc+AlD3FjkSHPt7BkfLPbGSHed2zH0sRi8wO9PQ5Bsj4HjkataOTpy1mRx6LEh87bV7oIeLFvkJspN/EHp30dUZSvzqFxZ8IrS5BzLYg10FspMeuUAyh0DnrO1rCuuXCbRLE/RLpvv1v411LMmqxscz3Hokc1AT9ziz/PwhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GREV8ACG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kme/EdNu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C751F20A69;
	Thu,  4 Sep 2025 05:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756965213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R+F1Lqhu7xowP7OxGartlXgGjJvxN+Ml5ZK7Uwk655Y=;
	b=GREV8ACG/7nAEzsZd3SAADxyECNCkv+caCfKCrbcayAP3cn5QN4BUmrVKPpZP66+NrR+XZ
	6RS/L3+2nTX8k3Vvnct7wNCyQPKt5ZSmZ13LGPt+UD/zQxQqe8bLQKJRfh+7OFZwSBipsC
	ymTEmxP4s0+yOWMdibZlbeDmh0FCA/Y=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="kme/EdNu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756965212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=R+F1Lqhu7xowP7OxGartlXgGjJvxN+Ml5ZK7Uwk655Y=;
	b=kme/EdNuMwjGUthimb7DYpSxxjGgCs66y+5PfHimjfwjSVLlJvasxux3eMn7Ks1xt6If5k
	JSLjavxi8I2zCj0eYq7rITXioRlta/uHC2hJXcJkJRbIUH/kgYchkVl/b0ezltnw3pwS1y
	67lYC4C6NUl8nIhVPJsBtdb4txbs3gQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B96C81398A;
	Thu,  4 Sep 2025 05:53:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 29VWHVspuWjaTwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 04 Sep 2025 05:53:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: generic/228: do not rely on the bash core dump output
Date: Thu,  4 Sep 2025 15:23:05 +0930
Message-ID: <20250904055305.103753-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: C751F20A69
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

[BUG]
With bash 5.3.x, the test case generic/228 will always fail with the
following golden output mismatch:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc3-custom+ #281 SMP PREEMPT_DYNAMIC Thu Aug 28 11:15:21 ACST 2025
MKFS_OPTIONS  -- /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

generic/228 1s ... - output mismatch (see /home/adam/xfstests/results//generic/228.out.bad)
    --- tests/generic/228.out	2025-09-04 15:15:08.965000000 +0930
    +++ /home/adam/xfstests/results//generic/228.out.bad	2025-09-04 15:16:05.627457599 +0930
    @@ -1,6 +1,6 @@
     QA output created by 228
     File size limit is now set to 100 MB.
     Let us try to preallocate 101 MB. This should fail.
    -File size limit exceeded
    +File size limit exceeded   $XFS_IO_PROG -f -c 'falloc 0 101m' $TEST_DIR/ouch
     Let us now try to preallocate 50 MB. This should succeed.
     Test over.
    ...
    (Run 'diff -u /home/adam/xfstests/tests/generic/228.out /home/adam/xfstests/results//generic/228.out.bad'  to see the entire diff)
Ran: generic/228
Failures: generic/228
Failed 1 of 1 tests

[CAUSE]
The "File size limit exceeded" line is never from xfs_io, but the
coredump from bash itself.

And with latest 5.3.x bash, it added extra dump during such core dump
handling (even if we have explicitly skipped the coredump).

[FIX]
Instead of relying on bash to do the coredump, which is unreliable
between different bash versions as I have shown above, ignore the
SIGXFSZ signal so that xfs_io will do the error output, which is more
reliable than bash.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/generic/228     | 6 +++++-
 tests/generic/228.out | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/generic/228 b/tests/generic/228
index f1881f84..defa1e9f 100755
--- a/tests/generic/228
+++ b/tests/generic/228
@@ -50,7 +50,11 @@ flim=`ulimit -f`
 
 echo "File size limit is now set to 100 MB."
 echo "Let us try to preallocate 101 MB. This should fail."
-$XFS_IO_PROG -f -c 'falloc 0 101m' $TEST_DIR/ouch
+# xfs_io will fail with SIGXFSZ signal, if not handled it will trigger a coredump.
+# And in bash 5.3.x, bash will always output the command/script triggering the
+# coredump
+# Work around the new behavior by catcing the signal.
+bash -c "trap '' SIGXFSZ; $XFS_IO_PROG -f -c 'falloc 0 101m' $TEST_DIR/ouch"
 rm -f $TEST_DIR/ouch
 
 echo "Let us now try to preallocate 50 MB. This should succeed."
diff --git a/tests/generic/228.out b/tests/generic/228.out
index 842d4bb7..00d041f6 100644
--- a/tests/generic/228.out
+++ b/tests/generic/228.out
@@ -1,6 +1,6 @@
 QA output created by 228
 File size limit is now set to 100 MB.
 Let us try to preallocate 101 MB. This should fail.
-File size limit exceeded
+fallocate: File too large
 Let us now try to preallocate 50 MB. This should succeed.
 Test over.
-- 
2.51.0


