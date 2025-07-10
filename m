Return-Path: <linux-btrfs+bounces-15434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99312B00FE6
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 01:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D3E645A7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F8C307AC5;
	Thu, 10 Jul 2025 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t8qyaQH6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t8qyaQH6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB0B306DD3
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191515; cv=none; b=E0+ExjqqDtifVQXY2fe9hlPzShy+KXMcbC2N+w/bDWTZAXRqLN9L5FCsx5+S9Cacm/OD0HPFOVQRqsNHfHb5COmOfmV88lwAFWGw9hzSLWnnDbTVBFC0Bcu0ySIV+qCcjzyroBo5ctE8L3ilIaYSS6Gy4fkVZP6Kh6HK8D6kk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191515; c=relaxed/simple;
	bh=Pfyvj0DswOZVOtAgMHxN0xPdmHStWQtPgvyae5DJ9L0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XhUtHGsLGVGoE/eGg6dS8kJ9ffHSNVL1lEqxDRjPquCgi+4Zat9x7UyEdUvjS5y32obKETOSyCyg2Wui2BjJ7sHLauKYQG5Xmoc0mbzk12ZogDzZbzOapUrGftFQ7ooIPsqq9oNcDBJhpAg7FpNOWX+fs+XyI+jBj+2aRJOJtKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t8qyaQH6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t8qyaQH6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2348A1F38C;
	Thu, 10 Jul 2025 23:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752191511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f0OXafT/ST9O3LhTsts6tDQPcFhvU8PVesRTsFgBd3U=;
	b=t8qyaQH6YWb3WXF8I2cTnEXOGSbjNnQXKcSWQvpsm3Re031NgtJVEZgSP1jNMaVqMQovFl
	YK+58dXwYeMxq3nw6zXmKRjGUu8i6415WjdpRdgcL4M40CoM0cMedE9dAWLHXZ6prNokos
	Zp4tgwSlWZ3RV3rlTPFUpVQqE7GKUjQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752191511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=f0OXafT/ST9O3LhTsts6tDQPcFhvU8PVesRTsFgBd3U=;
	b=t8qyaQH6YWb3WXF8I2cTnEXOGSbjNnQXKcSWQvpsm3Re031NgtJVEZgSP1jNMaVqMQovFl
	YK+58dXwYeMxq3nw6zXmKRjGUu8i6415WjdpRdgcL4M40CoM0cMedE9dAWLHXZ6prNokos
	Zp4tgwSlWZ3RV3rlTPFUpVQqE7GKUjQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AFFA136CB;
	Thu, 10 Jul 2025 23:51:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KTymLRVScGhOUAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 10 Jul 2025 23:51:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/282: use timed writes to make sure scrub has enough run time
Date: Fri, 11 Jul 2025 09:21:46 +0930
Message-ID: <20250710235146.136358-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

[FAILURE]
Test case btrfs/282 still fails on some setup:

    output mismatch (see /opt/xfstests/results//btrfs/282.out.bad)
    --- tests/btrfs/282.out	2025-06-27 22:00:35.000000000 +0200
    +++ /opt/xfstests/results//btrfs/282.out.bad	2025-07-08 20:40:50.042410321 +0200
    @@ -1,3 +1,4 @@
     QA output created by 282
     wrote 2147483648/2147483648 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    +scrub speed 2152038400 Bytes/s is not properly throttled, target is 1076019200 Bytes/s
    ...
    (Run diff -u /opt/xfstests/tests/btrfs/282.out /opt/xfstests/results//btrfs/282.out.bad  to see the entire diff)

[CAUSE]
Checking the full output, it shows the scrub is running too fast:

Starting scrub on devid 1
scrub done for c45c8821-4e55-4d29-8172-f1bf30b7182c
Scrub started:    Tue Jul  8 20:40:47 2025
Status:           finished
Duration:         0:00:00 <<<
Total to scrub:   2.00GiB
Rate:             2.00GiB/s
Error summary:    no errors found
Starting scrub on devid 1
scrub done for c45c8821-4e55-4d29-8172-f1bf30b7182c
Scrub started:    Tue Jul  8 20:40:48 2025
Status:           finished
Duration:         0:00:01
Total to scrub:   2.00GiB
Rate:             2.00GiB/s
Error summary:    no errors found

The original run takes less than 1 seconds, making the scrub rate
calculation very unreliable, no wonder the speed limit is not able to
properly work.

[FIX]
Instead of using fixed 2GiB file size, let the test create a filler for
4 seconds with direct IO, this would more or less ensure the scrub will
take 4 seoncds to run.

With 4 seconds as run time, the scrub rate can be calculated more or
less reliably.

On my testing VM, the result looks like this:

Starting scrub on devid 1
scrub done for b542bdfb-7be4-44b3-add0-ad3621927e2b
Scrub started:    Fri Jul 11 09:13:31 2025
Status:           finished
Duration:         0:00:04
Total to scrub:   2.72GiB
Rate:             696.62MiB/s
Error summary:    no errors found
Starting scrub on devid 1
scrub done for b542bdfb-7be4-44b3-add0-ad3621927e2b
Scrub started:    Fri Jul 11 09:13:35 2025
Status:           finished
Duration:         0:00:08
Total to scrub:   2.72GiB
Rate:             348.31MiB/s
Error summary:    no errors found

However this exposed a new failure mode, that if the storage is too
fast, like the original report, that the initial 4 seconds write can
fill the fs and exit early.

In that case we have no other solution but skipping the test case.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/282     | 48 ++++++++++++++++++++++++++++++++++++++++-----
 tests/btrfs/282.out |  3 +--
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/tests/btrfs/282 b/tests/btrfs/282
index 3b4ad9ea..39d2d8c0 100755
--- a/tests/btrfs/282
+++ b/tests/btrfs/282
@@ -9,13 +9,19 @@
 . ./common/preamble
 _begin_fstest auto scrub
 
+_cleanup()
+{
+	[ -n "$mount_pid" ] && kill $mount_pid &> /dev/null
+	wait
+}
+
 . ./common/filter
 
 _wants_kernel_commit eb3b50536642 \
 	"btrfs: scrub: per-device bandwidth control"
 
-# We want at least 5G for the scratch device.
-_require_scratch_size $(( 5 * 1024 * 1024))
+# We want at least 10G for the scratch device.
+_require_scratch_size $(( 10 * 1024 * 1024))
 
 # Make sure we can create scrub progress data file
 if [ -e /var/lib/btrfs ]; then
@@ -36,9 +42,39 @@ if [ ! -f "${devinfo_dir}/scrub_speed_max" ]; then
 	_notrun "No sysfs interface for scrub speed throttle"
 fi
 
-# Create a 2G file for later scrub workload.
-# The 2G size is chosen to fit even DUP on a 5G disk.
-$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 2G" $SCRATCH_MNT/file | _filter_xfs_io
+# Create a NOCOW file and do direct IO for 4 seconds to measure the performance.
+#
+# The only way to reach real disk performance is direct IO without falling back
+# to buffered IO, thus requiring NOCOW.
+touch $SCRATCH_MNT/filler
+chattr +C $SCRATCH_MNT/filler
+$XFS_IO_PROG -d -c "pwrite -b 128K 0 1E" "$SCRATCH_MNT/filler" >> $seqres.full 2>&1 &
+filler_pid=$!
+sleep 4
+kill $filler_pid
+wait
+
+# Make sure we still have some space left, if we hit ENOSPC, this means the
+# storage is too fast and the filler didn't reach full 4 seconds write before
+# hitting ENOSPC. In that case we have no reliable way to calculate scrub speed
+# but skip the run.
+_pwrite_byte 0x00 0 1M $SCRATCH_MNT/foobar >> $seqres.full 2>&1
+if [ $? -ne 0 ]; then
+	_notrun "Storage too fast, unreliable scrub speed"
+fi
+
+# But above NOCOW file has no csum, thus it won't really cause much
+# verification workload. Use the filesize of above run to re-create a file with data
+# checksum.
+size=$(_get_filesize $SCRATCH_MNT/filler)
+rm $SCRATCH_MNT/filler
+# Make sure the file is deleted.
+sync
+
+# Recreate one with COW thus checksum.
+touch $SCRATCH_MNT/filler
+chattr -C $SCRATCH_MNT/filler
+$XFS_IO_PROG -c "pwrite -i /dev/urandom 0 $size" $SCRATCH_MNT/filler >> $seqres.full
 
 # Writeback above data, as scrub only verify the committed data.
 sync
@@ -83,6 +119,8 @@ if [ "$speed" -gt "$(( $target_speed * 11 / 10 ))" -o \
 	echo "scrub speed $speed Bytes/s is not properly throttled, target is $target_speed Bytes/s"
 fi
 
+echo "Silence is golden"
+
 # success, all done
 status=0
 exit
diff --git a/tests/btrfs/282.out b/tests/btrfs/282.out
index 8d53e7eb..9e837650 100644
--- a/tests/btrfs/282.out
+++ b/tests/btrfs/282.out
@@ -1,3 +1,2 @@
 QA output created by 282
-wrote 2147483648/2147483648 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Silence is golden
-- 
2.50.0


