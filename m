Return-Path: <linux-btrfs+bounces-19510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0ACA253E
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 05:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DE3C3059AC1
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 04:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362ED2FE580;
	Thu,  4 Dec 2025 04:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XmRFUzvl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XmRFUzvl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95952186284
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 04:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823291; cv=none; b=Kb/W8V6n8A7QRtrJMHV0CXu1qEop3LTG4eejw8H7xW8PZAc1+Qzb4F5hx+x3hDWkBa09EzM1+O1OqqXcnpMIQmfkYpFIymxFQAYSuzIWsVrLA3M8QWsj6Xyu1/af1fzahLC8OsKs3jbi6tCTWgGXc7/z7/iPsB4yTfXZ9DTtcm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823291; c=relaxed/simple;
	bh=zXXRsUaEREtCr5L2kro3mVXjnsf3ePNpQCi7wrf1CaM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tW8Q1R5UaO6EVEO6H0P5J8cBUe0nw7AAeTUn/x/+9LWLOTluPE7J2PXhwijeVSuhTGi0yNrasi2hM0SgP0FGGRnrh+4i3qt1oPso9LDU54x6AJHFQ3TQdMsaQxb26esiIVWD3EvhpTCG6UH4GoSovwkffJpDfj+JUBnXJNjeSMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XmRFUzvl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XmRFUzvl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81ED93388F;
	Thu,  4 Dec 2025 04:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764823287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gfCg3g9XyaCfW39BvXJ8opKW+E8jYL+WpWJXknQ5k2E=;
	b=XmRFUzvl16lUDEg5o65YwXTshIlQw6xDdottzBkoB0S/xjhp3F+WzEescXItlmchc27kW2
	jjxle27OMOZlVn0gcae0U4TLCjypTlgN/j5scxiCoyjI78aEWERDQIhPngmPVI9d8Jzuwc
	3Vd+PTXp7wMX8vbj2VydociX0xXGhHc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XmRFUzvl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764823287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gfCg3g9XyaCfW39BvXJ8opKW+E8jYL+WpWJXknQ5k2E=;
	b=XmRFUzvl16lUDEg5o65YwXTshIlQw6xDdottzBkoB0S/xjhp3F+WzEescXItlmchc27kW2
	jjxle27OMOZlVn0gcae0U4TLCjypTlgN/j5scxiCoyjI78aEWERDQIhPngmPVI9d8Jzuwc
	3Vd+PTXp7wMX8vbj2VydociX0xXGhHc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82EA73EA63;
	Thu,  4 Dec 2025 04:41:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JVqDEfYQMWncIQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 04 Dec 2025 04:41:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: add a new test case to verify quick qgroup inherit
Date: Thu,  4 Dec 2025 15:11:08 +1030
Message-ID: <20251204044108.181671-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 81ED93388F
X-Spam-Flag: NO
X-Spam-Score: -3.01

[BUG]
There is a bug report that simple quota exposed a bug in the quick
qgroup inherit, that if there is a multi-level qgroup parent
relationship, only the direct parent got updated.

[TEST CASE]
The test case will create the following subvolume and qgroups first:

- A new subvolume at '/subv1'
- Qgroup 1/1
- Qgroup 2/1

And subvolume '/subv1' is assgiend to qgroup 1/1, so 1/1 is the direct
parent.
Then qgroup 1/1 is also assigned to 2/1, so 2/1 is an indirect parent of
subvolume '/subv1'.

Then the trigger part is to creating a snapshot of '/subv1' and also
assigned the new snapshot into qgroup 1/1 during the snapshot creation.

Since 1/1 is the parent of '/subv1' and the new snapshot, and qgroup 1/1
fully owns '/subv1', we can do a quick inherit.

After the triggering part, just finish the test case and the fsck after
the test case should detect any qgroup inconsistency.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/339     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/339.out |  2 ++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/btrfs/339
 create mode 100644 tests/btrfs/339.out

diff --git a/tests/btrfs/339 b/tests/btrfs/339
new file mode 100755
index 00000000..6581b61b
--- /dev/null
+++ b/tests/btrfs/339
@@ -0,0 +1,45 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 339
+#
+# Make sure when doing a quick inherit for snapshot, all parent qgroups
+# including direct and indirect parents are properly updated.
+#
+. ./common/preamble
+_begin_fstest auto quick qgroup
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: qgroup: update all parent qgroups when doing quick inherit"
+
+# For the automatic fsck at unmount.
+_require_scratch
+_require_btrfs_qgroup_report
+
+# This will imply mkfs and enable regular qgroup.
+_require_scratch_qgroup
+_scratch_mount
+
+# Create a subvolume along with qgroups 1/1 and 2/1.
+# The subvolume qgroup is assgiend to 1/1, and 1/1 is assigned to 2/1.
+_btrfs subvolume create $SCRATCH_MNT/subv1
+subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT subv1)
+_btrfs qgroup create 1/1 $SCRATCH_MNT
+_btrfs qgroup create 2/1 $SCRATCH_MNT
+_btrfs qgroup assign 1/1 2/1 $SCRATCH_MNT
+_btrfs qgroup assign 0/$subvolid 1/1 $SCRATCH_MNT
+
+# All above assign should result quick update, no need for a full rescan
+echo "Before quick inherit:" >> $seqres.full
+_btrfs qgroup show -p --sync $SCRATCH_MNT >> $seqres.full
+
+# The next snapshot creation will create a snapshot and assign it to 1/1,
+# which is the same parent of the source subvolume, and we can do a quick inherit
+# without marking qgroup inconsistent.
+_btrfs subv snap -i 1/1 $SCRATCH_MNT/subv1 $SCRATCH_MNT/snap1
+echo "After quick inherit:" >> $seqres.full
+_btrfs qgroup show -p --sync $SCRATCH_MNT >> $seqres.full
+
+echo "Silence is golden"
+_exit 0
diff --git a/tests/btrfs/339.out b/tests/btrfs/339.out
new file mode 100644
index 00000000..293ea808
--- /dev/null
+++ b/tests/btrfs/339.out
@@ -0,0 +1,2 @@
+QA output created by 339
+Silence is golden
-- 
2.51.2


