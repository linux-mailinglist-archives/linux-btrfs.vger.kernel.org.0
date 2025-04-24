Return-Path: <linux-btrfs+bounces-13356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB6AA9A0D8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 08:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA1F194480E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 06:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051D1DDA1B;
	Thu, 24 Apr 2025 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qxSWNqiF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qxSWNqiF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810891B043E
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745474799; cv=none; b=sfDLyGuTa2EyuSieF4lYQV8GmBSjuLII1cwW5PySb3D5B1QDwCxGB1CmWvXC/vRqE+hBFCigab9S/fZnEADXx8ln1K6IgjKtLxOmJ/W13Ph3EIW892wzXATGPUch1I8l5LerOhwvEMEHueQOp1Yl8nmziwmfHJAlbskoOXLXzXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745474799; c=relaxed/simple;
	bh=/cMDIczxFpyd1UElTwiBmQ+5L4E6hxErREUbnzbyxc4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DIZvk1Jw3QKOIafLzItIc7i1tp+W3Z4yFthebT7xoFJ99UX3/ykCvw/oNCk0YFQtIM9JaVjJLJ50OTI0pS0TJRE2QSBOndrcObAmkBY+WyF9Bz3j7G6Lr49BRTxftJyNsk6hJcTZmuLjdjWvBAsq5OipTU2SN1RILVNfQaf0ifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qxSWNqiF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qxSWNqiF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44D9D210F9;
	Thu, 24 Apr 2025 06:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745474795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GIo9TBe0g0RntxsYpQuKbiIUi+SG2CAW8MQOEj5SGRA=;
	b=qxSWNqiFvqN6kmvfGGAh18yKtgjPTUUYQQk6Q5ie7IswZxCGMiQxHFNUFQJqdL2/l0fCUA
	x67c51UCSPbW8Ixutmoi+2UnR6D3SyH05Jh6sDwKsUf3+vDUVjKWQcw/Xe4HTcamseRkun
	CeBTF7eQ+AQ37S40/cBFLO6xbWbKREY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qxSWNqiF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745474795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=GIo9TBe0g0RntxsYpQuKbiIUi+SG2CAW8MQOEj5SGRA=;
	b=qxSWNqiFvqN6kmvfGGAh18yKtgjPTUUYQQk6Q5ie7IswZxCGMiQxHFNUFQJqdL2/l0fCUA
	x67c51UCSPbW8Ixutmoi+2UnR6D3SyH05Jh6sDwKsUf3+vDUVjKWQcw/Xe4HTcamseRkun
	CeBTF7eQ+AQ37S40/cBFLO6xbWbKREY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 479081393C;
	Thu, 24 Apr 2025 06:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zI2WAurUCWioXgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 24 Apr 2025 06:06:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/315: fix golden output mismatch caused by newer util-linux
Date: Thu, 24 Apr 2025 15:36:08 +0930
Message-ID: <20250424060608.251847-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 44D9D210F9
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
With util-linux v2.41.0 and newer, test case btrfs/315 will fail like
the following:

btrfs/315 1s ... - output mismatch (see /home/adam/xfstests-dev/results//btrfs/315.out.bad)
    --- tests/btrfs/315.out	2025-04-24 15:31:28.684112371 +0930
    +++ /home/adam/xfstests-dev/results//btrfs/315.out.bad	2025-04-24 15:31:31.854883557 +0930
    @@ -1,7 +1,7 @@
     QA output created by 315
     ---- seed_device_must_fail ----
     mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
    -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
    +mount: TEST_DIR/315/tempfsid_mnt: () failed: File exists.
     ---- device_add_must_fail ----
     wrote 9000/9000 bytes at offset 0

[CAUSE]

With util-linux v2.41.0, the mount failure error message changed to the following:

  mount: /mnt/test/315/tempfsid_mnt: fsconfig() failed: File exists.

Thus the existing filter only striped the "fsconfig" part, leaving the
"()" without changing it to " system call".

[FIX]
The existing filter on error message is doomed from day one.
I'm fed up with the stupid catch-up game depending on util-linux, so
let's just stripe everything between "mount" and " failed", just leaving
the golden output to:

  mount failed: File exists.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/315     | 14 +++++++++-----
 tests/btrfs/315.out |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/315 b/tests/btrfs/315
index e6589abe..9b5bc789 100755
--- a/tests/btrfs/315
+++ b/tests/btrfs/315
@@ -30,9 +30,8 @@ tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
 
 _filter_mount_error()
 {
-	# There are two different errors that occur at the output when
-	# mounting fails; as shown below, pick out the common part. And,
-	# remove the dmesg line.
+	# There are different errors that occur at the output when
+	# mounting fails:
 
 	# mount: <mnt-point>: mount(2) system call failed: File exists.
 
@@ -41,10 +40,15 @@ _filter_mount_error()
 
 	# For util-linux v2.4 and later:
 	# mount: <mountpoint>: mount system call failed: File exists.
+	#
+	# For util-linux v2.41 and later:
+	# mount: <mountpoint>: fsconfig() failed: File exists.
+	#
+	# Instead of playing the stupid catchup game, removed everything
+	# between ":" and "failed:".
 
 	grep -v dmesg | _filter_test_dir | \
-		sed -e "s/mount(2)\|fsconfig//g" \
-		    -e "s/mount\( system call failed:\)/\1/"
+		sed -e "s/: TEST_DIR\/315\/tempfsid_mnt: .* failed:/ failed:/g"
 }
 
 seed_device_must_fail()
diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
index 3ea7a35a..fb493e90 100644
--- a/tests/btrfs/315.out
+++ b/tests/btrfs/315.out
@@ -1,7 +1,7 @@
 QA output created by 315
 ---- seed_device_must_fail ----
 mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
-mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
+mount failed: File exists.
 ---- device_add_must_fail ----
 wrote 9000/9000 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.49.0


