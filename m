Return-Path: <linux-btrfs+bounces-13956-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 847DBAB4C75
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 09:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A11189681D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 07:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107F1E5718;
	Tue, 13 May 2025 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hUoMFTPY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hUoMFTPY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C61EB19F
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 07:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120100; cv=none; b=p48kEWk/zbLRHuOtk2jzLj6z/L+dt9s/TEPJHj/VCk/hJkb1l9z6KkWn80CQQ0lX47jgceOvTv1x9/nR5tMvNDkHstVGFa7jlqIJ3pJD0nxqbROUGMnIKfMVszBSlsksI1gkTt9BPJIMaNaWyUeOtXL+fhTyJ9j90K0O3WQbpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120100; c=relaxed/simple;
	bh=ZeDCdwLdkT63CDdyO8M5Bi6iUIgmanmbiluPQDL3I/s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gsgnbOTwX4ML6yBVRpjM7ReXTPUJDGdAG3MWy6pGfkXNYjlIn5NZP4y2s8fWipLneWpQm7efklDezL//o/ZTfbA+fWi6B4Gfw4omUNHwnZWK95MoBe2vJc4Fo5LdJ9XJaU4sxuhUHY41o/qPpIQTcEajW+lkNkT8vMsBGt9a910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hUoMFTPY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hUoMFTPY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 613B11F443;
	Tue, 13 May 2025 07:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747120096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fIij/+bT+V26uNWl+dCCFmIp52TkE6RltiM1T0pQGCk=;
	b=hUoMFTPYD6M6O2Baadzgdm6P2LiGaBgh2xt1sOegi9WaYFDSlrH0bOy09PcqlUdZWe+via
	k2IEFne0qUpfFNHZ/YzNssmOJvqLvZtf5BHSEnLxMQR0R7jlF7oI6LkLMIMW/STx0nb4xA
	oFHeAy7Kg7SFx8RqXDDMWGT4Y1YAVng=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hUoMFTPY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747120096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=fIij/+bT+V26uNWl+dCCFmIp52TkE6RltiM1T0pQGCk=;
	b=hUoMFTPYD6M6O2Baadzgdm6P2LiGaBgh2xt1sOegi9WaYFDSlrH0bOy09PcqlUdZWe+via
	k2IEFne0qUpfFNHZ/YzNssmOJvqLvZtf5BHSEnLxMQR0R7jlF7oI6LkLMIMW/STx0nb4xA
	oFHeAy7Kg7SFx8RqXDDMWGT4Y1YAVng=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 598031365D;
	Tue, 13 May 2025 07:08:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aC1PB9/vImjDUwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 13 May 2025 07:08:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/220: do not use nologreplay when possible
Date: Tue, 13 May 2025 16:37:49 +0930
Message-ID: <20250513070749.265519-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 613B11F443
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action

[BUG]
If the system is using mount from util-linux 2.41 or newer, the test
case will fail with the following error:

  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 btrfs-vm 6.15.0-rc5-custom+ #238 SMP PREEMPT_DYNAMIC Wed May  7 14:10:51 ACST 2025
  MKFS_OPTIONS  -- /dev/mapper/test-scratch1
  MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

  btrfs/220 6s ... - output mismatch (see /home/adam/xfstests/results//btrfs/220.out.bad)
      --- tests/btrfs/220.out	2022-05-11 11:25:30.749999997 +0930
      +++ /home/adam/xfstests/results//btrfs/220.out.bad	2025-05-13 16:26:18.068521503 +0930
      @@ -1,2 +1,4 @@
       QA output created by 220
      +mount warning:
      +      * btrfs: Deprecated parameter 'nologreplay'
       Silence is golden
      ...
      (Run 'diff -u /home/adam/xfstests/tests/btrfs/220.out /home/adam/xfstests/results//btrfs/220.out.bad'  to see the entire diff)
  Ran: btrfs/220
  Failures: btrfs/220
  Failed 1 of 1 tests

[CAUSE]
The newer mount command provides the extra ability to show warning during
mount.

Although btrfs still supports "nologreplay" mount option to keep
consistency with other filesystems, we will output a warning and
encourage users to use "rescue=nologreplay" instead.

During "nologreplay" mount option test, normally we will mount use
the newer "rescue=nologreplay" mount option if the kernel supports.

But the following two call sites are still unconditionally utilizing
the deprecated "nologreplay" mount option directly:

- Expected failure when using nologreplay and rw mount

- Mount option verification that "nologreplay" is converted to
  "rescue=nologreplay"

The second call site caused the above mount warning message and fail the
test case.

[FIX]
If the kernel supports "rescue=nologreplay" we should not utilized
"nologreplay" at all.

This will avoid the mount warning on the deprecated and discouraged
"nologreplay" mount option.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/220 | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/220 b/tests/btrfs/220
index 59d72a97..4e91b9a7 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -202,16 +202,13 @@ test_non_revertible_options()
 {
 	test_mount_opt "degraded" "degraded"
 
-	# nologreplay should be used only with readonly
-	test_should_fail "nologreplay"
-
 	if [ "$enable_rescue_nologreplay" = true ]; then
 		#rescue=nologreplay should be used only with readonly
 		test_should_fail "rescue=nologreplay"
-
-		test_mount_opt "nologreplay,ro" "ro,rescue=nologreplay"
 		test_mount_opt "rescue=nologreplay,ro" "ro,rescue=nologreplay"
 	else
+		# nologreplay should be used only with readonly
+		test_should_fail "nologreplay"
 		test_mount_opt "nologreplay,ro" "ro,nologreplay"
 	fi
 
-- 
2.49.0


