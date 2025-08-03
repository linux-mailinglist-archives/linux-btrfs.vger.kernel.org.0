Return-Path: <linux-btrfs+bounces-15822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5BDB196E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 01:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4F91730AF
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Aug 2025 23:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F354218592;
	Sun,  3 Aug 2025 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LysxoFQ5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LysxoFQ5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC9986359
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754265195; cv=none; b=gCuoKrMyFpBzGWpC/RyYvZHwDFvVNGB2w2mIa+gn+uBAgjLKON4bhfJod69qsTcJNdJKQXqz7piWOePFh4HyDkF0GY9SczXWCuxNbBxwjYTBNPe8poDr59Is7HITSfFuRyWh945w3dFMPiBhz1rVsgAV2X7uunUiW3olpzuH610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754265195; c=relaxed/simple;
	bh=fNaETAiGPay4or4tX4m7lLOXOTMWSQZqsHu7fNnUgB4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xf5yWOwJdk7DFYEJkOmtYMHqlg/5SmL5YiWWklqXLYBcLxRrFwQ9GTW0TzzTToQHsoxBTmY/QsAi/W5XIZK1773+o5Lcoo2orIDQbWLr7Lmq+N5K2LcltvqDz6ZRKADT2yJwoC/72NAVDcUJC96Fwhb9RiTJm+susPXUI2GXMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LysxoFQ5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LysxoFQ5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9533B1F397
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754265180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/D1XRejygafTPLOubLYQ3krxEKLohoQtQkIHbDLOVaU=;
	b=LysxoFQ5i7OWex2H0webKfi4+jQywPRaoANXtL7EQQCFyjjS96Nx3MIQVKc+DTViZQTTCx
	vZtA+vNObdCj5AteTzxTxEeCIh8fup8J6m5FPTu8yueVymAmH2WmBYcewO2Ogq8v2R3O5x
	cmr/3CkyIqePAUlU+IPwkMLTtBYgHJ0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LysxoFQ5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754265180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/D1XRejygafTPLOubLYQ3krxEKLohoQtQkIHbDLOVaU=;
	b=LysxoFQ5i7OWex2H0webKfi4+jQywPRaoANXtL7EQQCFyjjS96Nx3MIQVKc+DTViZQTTCx
	vZtA+vNObdCj5AteTzxTxEeCIh8fup8J6m5FPTu8yueVymAmH2WmBYcewO2Ogq8v2R3O5x
	cmr/3CkyIqePAUlU+IPwkMLTtBYgHJ0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCE90139A2
	for <linux-btrfs@vger.kernel.org>; Sun,  3 Aug 2025 23:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCf9Ilv2j2hPZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 03 Aug 2025 23:52:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: misc-tests: do not try to mount a block device into different filesystems
Date: Mon,  4 Aug 2025 09:22:38 +0930
Message-ID: <100f57b7118c7dbb5b062faa47afd0d412006341.1754265134.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754265134.git.wqu@suse.com>
References: <cover.1754265134.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9533B1F397
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

Since kernel commit 40426dd147ff ("btrfs: use the super_block as holder
when mounting file systems"), the kernel will not allow a block device
belonging to two different filesystems.

This means a seed device can only be mounted through either the sprouted
fs, or the seed device, not both at the same time.

Although a seed device can still be shared between different sprouted
fs, only one of those fs can be mounted.

Considering the extra benefit (extra protection, better device events
handling), it's worthy to do the kernel behavior change.

Update the test case to follow the new limits.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/misc-tests/046-seed-multi-mount/test.sh | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tests/misc-tests/046-seed-multi-mount/test.sh b/tests/misc-tests/046-seed-multi-mount/test.sh
index 1ac80704f130..8c87e5b9ec09 100755
--- a/tests/misc-tests/046-seed-multi-mount/test.sh
+++ b/tests/misc-tests/046-seed-multi-mount/test.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# Verify that a seeding device can be mounted several times
+# Verify that a seeding device can be shared by different sprout filesystems.
 
 source "$TEST_TOP/common" || exit
 
@@ -74,21 +74,20 @@ nextdevice() {
 	if [ "$md5sum" != "$md5sum2" ]; then
 		_fail "file contents not same after remount"
 	fi
+	# Unmount the new device so that the seed device won't be mounted
+	# when the sprout fs is already mounted.
+	# This is to compensate for the new v6.17 kernel, as each different
+	# fs will have different holder for a block device, and a single block
+	# device can not belong to different mounted filesystems.
+	run_check_umount_test_dev
 }
 
-# Keep previous device(s) mounted, create a new filesystem from the seeding device
+# Create a new filesystem from the seeding device, with previous devices unmounted.
 nextdevice 2
 nextdevice 3
 nextdevice 4
 nextdevice 5
 
-# Final umount
-# Skip seeding device, loop device 1,
-run_check $SUDO_HELPER umount ${loopdevs[2]}
-run_check $SUDO_HELPER umount ${loopdevs[3]}
-run_check $SUDO_HELPER umount ${loopdevs[4]}
-run_check $SUDO_HELPER umount ${loopdevs[5]}
-
 cleanup_loopdevs
 
 rm -rf -- mnt[0-9]
-- 
2.50.1


