Return-Path: <linux-btrfs+bounces-13378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6693EA9A421
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 09:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9883E3A725F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 07:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A5021FF3D;
	Thu, 24 Apr 2025 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fA08nMos";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fA08nMos"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EBD1F5434
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479774; cv=none; b=TVHgZvZsHbCn4PSdJIfT6qG5dLw0GiTrwLkp/3h8nu9JKhMB3aq1DuxjsZJC6fo/UErZCSbF1u16WW+jPpIjG+DG9httu1GArtVNIF+BAaWoID6v1l6B4GFcOugJ5JNDEZVgZCBXD8D2zHYk2C6jQBeYvgoPMDPK9NQNGDQAWmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479774; c=relaxed/simple;
	bh=rTLZDHQlHGF4nrELvtHc5IEO3zv5JeLzdj6sRrdWqiY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rCr/tvhdheHJLRFzGgnVyCrP8cqKZCgPG6UVML16EftEmt8PbUvzTvlxA1JGUfVsIPmms3YjcZMeey5hxl2RJnDL+vD0V2YTELWO9/TvwczdK44FfR31C++EO/Pn8bUOmt8OOoz4RFZ2CJGt5W2v6GcPPVXYY0XKaHeXrnASswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fA08nMos; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fA08nMos; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6A1FA1F38E;
	Thu, 24 Apr 2025 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745479770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MGIT4eSuaisorNyHz1fSrUhmFWkmMf6DPUbOpC64dJs=;
	b=fA08nMosQJtsUeA6O247ZPCORlszQAaENMK3RdY7tnlKr9dU0uXkkQNGRnsrrX4yBSYer+
	LJBagWFOd+QBXPcZz7X0Z2nKj0c/PcNQM6opa8IprONWOzV6CL3u8wDtBMa/G4QxfjR8zj
	YJlPa5ddGm6wuKX8IJ4VvcbbyR3sYA4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=fA08nMos
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745479770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MGIT4eSuaisorNyHz1fSrUhmFWkmMf6DPUbOpC64dJs=;
	b=fA08nMosQJtsUeA6O247ZPCORlszQAaENMK3RdY7tnlKr9dU0uXkkQNGRnsrrX4yBSYer+
	LJBagWFOd+QBXPcZz7X0Z2nKj0c/PcNQM6opa8IprONWOzV6CL3u8wDtBMa/G4QxfjR8zj
	YJlPa5ddGm6wuKX8IJ4VvcbbyR3sYA4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BB381393C;
	Thu, 24 Apr 2025 07:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xm7rBlnoCWiUdAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 24 Apr 2025 07:29:29 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/315: fix golden output mismatch caused by newer util-linux
Date: Thu, 24 Apr 2025 16:59:07 +0930
Message-ID: <20250424072907.256692-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A1FA1F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
The test case is doomed in day one by using a local filter, which
requires stupid catch-up game against util-linux.

Meanwhile we already have a much better filter, _filter_error_mount().
That helper can already handle the newer v2.41 output.

Let's use the superior common filter and update the golden output to:

  mount: File exists.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove the cursed local filter and use the generic one instead
---
 tests/btrfs/315     | 22 ++--------------------
 tests/btrfs/315.out |  2 +-
 2 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/tests/btrfs/315 b/tests/btrfs/315
index e6589abe..9071e152 100755
--- a/tests/btrfs/315
+++ b/tests/btrfs/315
@@ -19,6 +19,7 @@ _cleanup()
 }
 
 . ./common/filter.btrfs
+. ./common/filter
 
 _require_scratch_dev_pool 3
 _require_btrfs_fs_feature temp_fsid
@@ -28,25 +29,6 @@ _scratch_dev_pool_get 3
 # mount point for the tempfsid device
 tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
 
-_filter_mount_error()
-{
-	# There are two different errors that occur at the output when
-	# mounting fails; as shown below, pick out the common part. And,
-	# remove the dmesg line.
-
-	# mount: <mnt-point>: mount(2) system call failed: File exists.
-
-	# mount: <mnt-point>: fsconfig system call failed: File exists.
-	# dmesg(1) may have more information after failed mount system call.
-
-	# For util-linux v2.4 and later:
-	# mount: <mountpoint>: mount system call failed: File exists.
-
-	grep -v dmesg | _filter_test_dir | \
-		sed -e "s/mount(2)\|fsconfig//g" \
-		    -e "s/mount\( system call failed:\)/\1/"
-}
-
 seed_device_must_fail()
 {
 	echo ---- $FUNCNAME ----
@@ -57,7 +39,7 @@ seed_device_must_fail()
 	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
 
 	_scratch_mount 2>&1 | _filter_scratch
-	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_mount_error
+	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_error_mount
 }
 
 device_add_must_fail()
diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
index 3ea7a35a..ae77d4fd 100644
--- a/tests/btrfs/315.out
+++ b/tests/btrfs/315.out
@@ -1,7 +1,7 @@
 QA output created by 315
 ---- seed_device_must_fail ----
 mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
-mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
+mount: File exists
 ---- device_add_must_fail ----
 wrote 9000/9000 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.49.0


