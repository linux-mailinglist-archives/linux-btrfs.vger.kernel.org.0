Return-Path: <linux-btrfs+bounces-2663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD18B860D59
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 09:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197CD1F25897
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557422616;
	Fri, 23 Feb 2024 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RFXc8hxg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RFXc8hxg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D981B26E;
	Fri, 23 Feb 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678683; cv=none; b=P+4QyeQPjQjHMPe6K1ArMxfIiU2Ay9vUYGzCq9G5Bu9s0aQb5uX58SZWMHkLyN5evcb9Yzav20x2Ig8L1opTNGHivDlVoalFKp5ljCrSJvDOj6qWJAA4W923H48mtyETE/77+FAxmmG10nJ1kHXoDr3Uab++naAPZ2cWqzlraPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678683; c=relaxed/simple;
	bh=SQW76QkyMK9hJWR0WhIpehsh9HGkOmcHPKMHgXfSTNk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lOH8jXNdEug9jNyqQjjYRwokLDk5hA7uvpOYpZVg1DZ+t6fRwGU7m4quq2LqxShsqKs1TwoES49n9HxlZVsPd6RIuKx3zrXU+V63Ra5Es3VmFK5wHg1llsKaRz/weeragt7xd5EuGBsgzZHx6z8vl5+RcMXFHS6pMlOZKvSvzd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RFXc8hxg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RFXc8hxg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08C0521FD0;
	Fri, 23 Feb 2024 08:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708678679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NwLEgcXKyhDCZ1E1QGn7pBJFfD9SZ0hkOseylp5pv2g=;
	b=RFXc8hxgn/E/X5FdUAkDOk+f6GqFkWkf6JOTmX851MsZ/miymS4I0dgcBLzvieMrjqFFGM
	M7+zinMThQ1aXzpJ3msW46WowoQh8AaYSmWC3znrdXGZe7Uvwf4DLDJ1dXUlsvY5+N/JGz
	aUR+x38QGKdwEJjNrelxCLEeh9d3pA4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708678679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NwLEgcXKyhDCZ1E1QGn7pBJFfD9SZ0hkOseylp5pv2g=;
	b=RFXc8hxgn/E/X5FdUAkDOk+f6GqFkWkf6JOTmX851MsZ/miymS4I0dgcBLzvieMrjqFFGM
	M7+zinMThQ1aXzpJ3msW46WowoQh8AaYSmWC3znrdXGZe7Uvwf4DLDJ1dXUlsvY5+N/JGz
	aUR+x38QGKdwEJjNrelxCLEeh9d3pA4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D16913776;
	Fri, 23 Feb 2024 08:57:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nMzfMBVe2GVMOQAAn2gu4w
	(envelope-from <wqu@suse.com>); Fri, 23 Feb 2024 08:57:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: add a test case to make sure inconsitent qgroup won't leak reserved data space
Date: Fri, 23 Feb 2024 19:27:40 +1030
Message-ID: <20240223085740.138791-1-wqu@suse.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
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
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

There is a kernel regression caused by commit e15e9f43c7ca ("btrfs:
introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup
accounting"), where if qgroup is inconsistent (not that hard to trigger)
btrfs would leak its qgroup data reserved space, and cause a warning at
unmount time.

The test case would verify the behavior by:

- Enable qgroup first

- Intentionally mark qgroup inconsistent
  This is done by taking a snapshot and assign it to a higher level
  qgroup, meanwhile the source has no higher level qgroup.

- Trigger a large enough write to cause qgroup data space leak

- Unmount and check the dmesg for the qgroup rsv leak warning

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/303     | 60 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/303.out |  2 ++
 2 files changed, 62 insertions(+)
 create mode 100755 tests/btrfs/303
 create mode 100644 tests/btrfs/303.out

diff --git a/tests/btrfs/303 b/tests/btrfs/303
new file mode 100755
index 00000000..44dbaeab
--- /dev/null
+++ b/tests/btrfs/303
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 303
+#
+# Make sure btrfs qgroup won't leak its reserved data space if qgroup is
+# marked inconsistent.
+#
+# This exercises a regression introduced in v6.1 kernel by the following commit:
+#
+# e15e9f43c7ca ("btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup accounting")
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup
+
+_supported_fs btrfs
+_require_scratch
+
+_fixed_by_kernel_commit eb96e221937a \
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: qgroup: always free reserved space for extent records"
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
+$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+
+$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 >> $seqres.full
+
+# This would mark qgroup inconsistent, as the snapshot belows to a different
+# higher level qgroup, we have to do full rescan on both source and snapshot.
+# This can be very slow for large subvolumes, so btrfs only marks qgroup
+# inconsitent and let users to determine when to do a full rescan
+$BTRFS_UTIL_PROG subvolume snapshot -i 1/0 $SCRATCH_MNT/subv1 $SCRATCH_MNT/snap1 >> $seqres.full
+
+# This write would lead to a qgroup extent record holding the reserved 128K.
+# And for unpatched kernels, the reserved space would not be freed properly
+# due to qgroup is inconsistent.
+_pwrite_byte 0xcd 0 128K $SCRATCH_MNT/foobar >> $seqres.full
+
+# The qgroup leak detection is only triggered at unmount time.
+_scratch_unmount
+
+# Check the dmesg warning for data rsv leak.
+#
+# If CONFIG_BTRFS_DEBUG is enabled, we would have a kernel wanring with
+# backtrace, but for release builds, it's just a warning line.
+# So here we manually check the warning message.
+if _dmesg_since_test_start | grep -q "leak"; then
+	_fail "qgroup data reserved space leaked"
+fi
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
new file mode 100644
index 00000000..d48808e6
--- /dev/null
+++ b/tests/btrfs/303.out
@@ -0,0 +1,2 @@
+QA output created by 303
+Silence is golden
-- 
2.42.0


