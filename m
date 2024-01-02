Return-Path: <linux-btrfs+bounces-1183-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF438216EF
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 05:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3573CB21022
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jan 2024 04:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27123C3;
	Tue,  2 Jan 2024 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BsiCsy7x";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BsiCsy7x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6B20F8;
	Tue,  2 Jan 2024 04:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5AE01FCD6;
	Tue,  2 Jan 2024 04:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704170273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BytSYxweRFYtMsAI0gXf9A7xfIoeUNTdJ/U7gV33Aeo=;
	b=BsiCsy7x/2reCsc/2QlvWGAiVz8ny6KL7Gv8DkqtIiidXXzJiLPW+kVbMOI/Vlk6GNabDm
	cKAa6jAwqrK8zyYzFIdQuPW8HZ430voDp7BEfBVaQJkFjkIeE827p17qPt0ki9lZ++SGna
	95hQJV9WPOoGeF7AcCnYeHX15u5/q3c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704170273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BytSYxweRFYtMsAI0gXf9A7xfIoeUNTdJ/U7gV33Aeo=;
	b=BsiCsy7x/2reCsc/2QlvWGAiVz8ny6KL7Gv8DkqtIiidXXzJiLPW+kVbMOI/Vlk6GNabDm
	cKAa6jAwqrK8zyYzFIdQuPW8HZ430voDp7BEfBVaQJkFjkIeE827p17qPt0ki9lZ++SGna
	95hQJV9WPOoGeF7AcCnYeHX15u5/q3c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 011BE13AC6;
	Tue,  2 Jan 2024 04:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uUvdIx+Tk2XQRQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 02 Jan 2024 04:37:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/260: detect subpage's limited compression support
Date: Tue,  2 Jan 2024 15:07:32 +1030
Message-ID: <20240102043732.143225-1-wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.90
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Flag: NO

[FALSE FAILURE]
When running test case btrfs/260 on a 64K page system (aarch64 with
64K page size config) and with 4K sector size, the test case would
always fail like this:

  FSTYP         -- btrfs
  PLATFORM      -- Linux/aarch64 btrfs-aarch64 6.7.0-rc5-custom+ #1 SMP PREEMPT_DYNAMIC Thu Dec 28 08:24:38 ACDT 2023
  MKFS_OPTIONS  -- -s 4k /dev/mapper/test-scratch1
  MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/test-scratch1 /mnt/scratch

  btrfs/260       - output mismatch (see ~/xfstests-dev/results//btrfs/260.out.bad)
      --- tests/btrfs/260.out	2023-12-28 10:39:36.510027101 +1030
      +++ ~/xfstests-dev/results//btrfs/260.out.bad	2024-01-02 15:02:12.917656055 +1030
      @@ -1,2 +1,8 @@
       QA output created by 260
      +file "/mnt/scratch/fragment" offset 0 doesn't have expected string "compression 2"
      +file "/mnt/scratch/fragment" offset 32768 doesn't have expected string "compression 2"
      +file "/mnt/scratch/fragment" offset 65536 doesn't have expected string "compression 2"
      +file "/mnt/scratch/fragment" offset 0 doesn't have expected string "compression 3"
      +file "/mnt/scratch/fragment" offset 32768 doesn't have expected string "compression 3"
      +file "/mnt/scratch/fragment" offset 65536 doesn't have expected string "compression 3"
      ...
      (Run 'diff -u ~/xfstests-dev/tests/btrfs/260.out ~/xfstests-dev/results//btrfs/260.out.bad'  to see the entire diff)
  Ran: btrfs/260
  Failures: btrfs/260
  Failed 1 of 1 tests

[CAUSE]
Since the introduce of btrfs subpage support, compression support is
always limited.

The big limitation is, the range can only be compressed if it's page
aligned (not sector aligned).
This limitation is caused by the delalloc implementation for now, and I
believe it can be resolved in the long time.

[FIX]
Introduce a new helper, _require_btrfs_compress_extent_size(), to make
sure btrfs can compress certain sized extent.

If such extent can not be compressed, just skip the test case.
Now on x86_64 the test case can pass as usual, while on 64K page sized
system (and 4K sector size) it would be skipped.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs    | 24 ++++++++++++++++++++++++
 tests/btrfs/260 |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index f91f8dd8..c3e801fa 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -775,3 +775,27 @@ _has_btrfs_sysfs_feature_attr()
 
 	test -e /sys/fs/btrfs/features/$feature_attr
 }
+
+# Btrfs subpage support can not compress extent smaller than a page (at least
+# for now).
+# Make sure we can detect the situation correctly.
+_require_btrfs_compress_extent_size()
+{
+	local extent_size=$1
+
+	_scratch_mkfs >>$seqres.full 2>&1
+	_scratch_mount -o compress
+
+	$XFS_IO_PROG -f -c "pwrite -b ${extent_size} 0 ${extent_size}" \
+			$SCRATCH_MNT/foo &> /dev/null
+	sync
+	$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foo | tail -n 1 > $tmp.fiemap
+	_scratch_unmount
+
+	# 0x8 means encoded (in our case compressed), 0x1 means the last extent.
+	if ! grep -q "0x9" $tmp.fiemap; then
+		rm -f -- $tmp.fiemap
+		_notrun "Compression for extent size $extent_size not supported, maybe subpage?"
+	fi
+	rm -f -- $tmp.fiemap
+}
diff --git a/tests/btrfs/260 b/tests/btrfs/260
index 111a3bd6..81ff599c 100755
--- a/tests/btrfs/260
+++ b/tests/btrfs/260
@@ -83,6 +83,11 @@ check_hole()
 # Needs 4K sectorsize as the test is crafted using that sectorsize
 _require_btrfs_support_sectorsize 4096
 
+# The test case needs to create compressed extents in 16K size
+# (before compression). Some subpage page size (64K, 32K) can not handle
+# it yet.
+_require_btrfs_compress_extent_size 16K
+
 _scratch_mkfs -s 4k >> $seqres.full 2>&1
 
 # Initial data is compressed using lzo
-- 
2.42.0


