Return-Path: <linux-btrfs+bounces-13881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D10AAB33D4
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 11:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAC4172ABD
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97DB25B68F;
	Mon, 12 May 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D7rPGHZ+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D7rPGHZ+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06626255F5F
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 09:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042773; cv=none; b=HbvCrCJ8yV/N1J8CsxT5Vmc8E8xID1n/iJtJxgDuS0G4RCjTgDZ93ixSv/XrLZ5LMCxWpq1zvXnIiYGQGo+mJl12b32Xd7sJmQJEJVlZtjpHRUqKDcSPMsSFG0mCiCYvWaOLjNIUfinVMrTt5p5UsM6ti1IzqBoUfEKAtJycqcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042773; c=relaxed/simple;
	bh=0U/6r77ztBk40ItNqYITD5/h9UDzZBN6JmgWs3ackuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zs+yVekqycQeXkO0zcr47IQtJewMGccxXaYyBKhC3a4ZXY1WKWREGLak9S4/Drgmg5DQeIU151FPaLCtY/uZt6xQpLpIieZqAJqRIL5jG3Uvwdh6ySeb9DZg0CE3vBa0c8VwnWQfqREVNSiBncxPSEb9mZ2HPc/tdO4O7egRwBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D7rPGHZ+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D7rPGHZ+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3EEDC21184;
	Mon, 12 May 2025 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747042769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hRcmQVsUFRLP87p1BSv7HcogrgPbJQ/TuFr3mIaMYf8=;
	b=D7rPGHZ+jxm6trm+iQhT+KjC0+KgGo0EfFq9ID7igHbme8jxxyblBjeMBHS8XBw4vqnmtQ
	vrUI/r06I1MN7AlV9rYtnXi3gpo2bLMTsaCcp9XVAmBZgITCGwk603ClMD5QPfExw73JK8
	CCyeTffJwl6Z80DoStFE78z2s3dy4Ao=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747042769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hRcmQVsUFRLP87p1BSv7HcogrgPbJQ/TuFr3mIaMYf8=;
	b=D7rPGHZ+jxm6trm+iQhT+KjC0+KgGo0EfFq9ID7igHbme8jxxyblBjeMBHS8XBw4vqnmtQ
	vrUI/r06I1MN7AlV9rYtnXi3gpo2bLMTsaCcp9XVAmBZgITCGwk603ClMD5QPfExw73JK8
	CCyeTffJwl6Z80DoStFE78z2s3dy4Ao=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AB80137D2;
	Mon, 12 May 2025 09:39:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C3L5L8/BIWhMPQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 12 May 2025 09:39:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
Date: Mon, 12 May 2025 19:09:10 +0930
Message-ID: <20250512093910.390688-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]

There is a kernel bug report that scrub will trigger a NULL pointer
dereference when rescue=idatacsums mount option is provided.

Add a test case for such situation, to verify kernel can gracefully
reject scrub when  there is no csum tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changelog:
v2:
- Strictly require the scrub to fail
  Suggested by Filipe
---
 tests/btrfs/336     | 35 +++++++++++++++++++++++++++++++++++
 tests/btrfs/336.out |  2 ++
 2 files changed, 37 insertions(+)
 create mode 100755 tests/btrfs/336
 create mode 100644 tests/btrfs/336.out

diff --git a/tests/btrfs/336 b/tests/btrfs/336
new file mode 100755
index 00000000..f6691bae
--- /dev/null
+++ b/tests/btrfs/336
@@ -0,0 +1,35 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 336
+#
+# Make sure read-only scrub won't cause NULL pointer dereference with
+# rescue=idatacsums mount option
+#
+. ./common/preamble
+_begin_fstest auto scrub quick
+
+_fixed_by_kernel_commit 6aecd91a5c5b \
+	"btrfs: avoid NULL pointer dereference if no valid extent tree"
+
+_require_scratch
+_scratch_mkfs >> $seqres.full
+
+_try_scratch_mount "-o ro,rescue=ignoredatacsums" > /dev/null 2>&1 ||
+	_notrun "rescue=ignoredatacsums mount option not supported"
+
+# For unpatched kernel this will cause NULL pointer dereference and crash the kernel.
+$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
+# For patched kernel scrub will be gracefully rejected.
+if [ $? -eq 0 ]; then
+	echo "read-only scrub should fail but didn't"
+fi
+
+_scratch_unmount
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
new file mode 100644
index 00000000..9263628e
--- /dev/null
+++ b/tests/btrfs/336.out
@@ -0,0 +1,2 @@
+QA output created by 336
+Silence is golden
-- 
2.47.1


