Return-Path: <linux-btrfs+bounces-13186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830EA94D95
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 10:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1807A6E25
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 07:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115CE20E718;
	Mon, 21 Apr 2025 08:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uL4/jQOr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uL4/jQOr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7251519A0
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Apr 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222414; cv=none; b=XpRFPLDkgKrsvnNr0LCDZCrf9xfVJ205k5a/ofh9E1fkdae0s5AcqVziudsS1x6Q2m+4yVuCYHVaG/2uvFbFK/ulfi2HlYioPfGmXrEm73m2RJ8/2CSngilJURAulUnVb2urCmG+lsqMDFuP7oYzjeL71QcD0raBGOnTsca/ES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222414; c=relaxed/simple;
	bh=nO0hVZFtILrIliSijNzjcy/B0ceRIBHv0gNg3jgMOFM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iHKnZWjMSCEeKFNXYAIXI2thTYGj1ghQPYfsX+pvX3U89mDuivm5zulBFfouaGNfuzYY+bzKkdVUclE9raALR16cw4CV6kGAtQkq4cz9N9G100Uq2zeIavn4/ND6TGynDOHXlexGOckIAUtY8fxghS+My6FmTOb76NFpqPRYmiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uL4/jQOr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uL4/jQOr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 727441F455;
	Mon, 21 Apr 2025 08:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745222403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2VfMIEdgfwYGWmqGl0NlsuWHCyqVPE1PiGnefHZezqs=;
	b=uL4/jQOrNHsYqrh6dxwQs5TOGDisj6JKMvuJ3bzW3Yp7u0B2DmymFD4bf9O7sOyc0/hdom
	T77vetv2t3Ew2VDYzdWD04LcaLubtJzjRSOsA6fE9bPb3MaI0Eqn7POUpWbh9b49S7U57W
	Pk8icoPWAdYniVa7J38uK3nZxHYOmZg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="uL4/jQOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745222403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2VfMIEdgfwYGWmqGl0NlsuWHCyqVPE1PiGnefHZezqs=;
	b=uL4/jQOrNHsYqrh6dxwQs5TOGDisj6JKMvuJ3bzW3Yp7u0B2DmymFD4bf9O7sOyc0/hdom
	T77vetv2t3Ew2VDYzdWD04LcaLubtJzjRSOsA6fE9bPb3MaI0Eqn7POUpWbh9b49S7U57W
	Pk8icoPWAdYniVa7J38uK3nZxHYOmZg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66C7613A3D;
	Mon, 21 Apr 2025 08:00:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VT/YCQL7BWjUXwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 21 Apr 2025 08:00:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/253: fix false alert due to _set_fs_sysfs_attr changes
Date: Mon, 21 Apr 2025 17:29:40 +0930
Message-ID: <20250421075940.75774-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 727441F455
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[FALSE FAILURE]
Test btrfs/253 now fails like the following:

btrfs/253 2s ... - output mismatch (see ~/xfstests/results//btrfs/253.out.bad)
    --- tests/btrfs/253.out	2022-05-11 11:25:30.753333331 +0930
    +++ ~/xfstests/results//btrfs/253.out.bad	2025-04-20 17:28:39.139180394 +0930
    @@ -5,6 +5,7 @@
     Calculate request size so last memory allocation cannot be completely fullfilled.
     Third allocation.
     Force allocation of system block type must fail.
    +./common/rc: line 5213: echo: write error: No space left on device
     Verify first allocation.
     Verify second allocation.
     Verify third allocation.
    ...
    (Run 'diff -u ~/xfstests/tests/btrfs/253.out ~/xfstests/results//btrfs/253.out.bad'  to see the entire diff)

[CAUSE]
Since commit 0a9011ae6a36 ("fstests: common/rc: set_fs_sysfs_attr:
redirect errors to stdout") the function _set_fs_sysfs_attr() always
output everything into stdout, thus the stderr redirection makes no
sense anymore.

And the expected failure will cause output difference and fail the test.

[FIX]
Use the helper _set_sysfs_policy_must_fail() instead, which will handle
the failure.
And update the golden output to include the expected ENOSPC error
message.

Fixes: 0a9011ae6a36 ("fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- use _set_sysfs_policy_must_fail() helper instead
---
 tests/btrfs/253     | 3 ++-
 tests/btrfs/253.out | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/253 b/tests/btrfs/253
index adbc6bfb..96ab140f 100755
--- a/tests/btrfs/253
+++ b/tests/btrfs/253
@@ -25,6 +25,7 @@
 #       value is in megabytes.
 #
 . ./common/preamble
+. ./common/sysfs
 _begin_fstest auto
 
 seq=`basename $0`
@@ -228,7 +229,7 @@ alloc_size "Data" FOURTH_DATA_SIZE_MB
 # Force chunk allocation of system block type must fail.
 #
 echo "Force allocation of system block type must fail."
-_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1 2>/dev/null
+_set_sysfs_policy_must_fail ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1
 
 #
 # Verification of initial allocation.
diff --git a/tests/btrfs/253.out b/tests/btrfs/253.out
index 6eea60f0..5aa75d54 100644
--- a/tests/btrfs/253.out
+++ b/tests/btrfs/253.out
@@ -5,6 +5,7 @@ Second allocation.
 Calculate request size so last memory allocation cannot be completely fullfilled.
 Third allocation.
 Force allocation of system block type must fail.
+No space left on device
 Verify first allocation.
 Verify second allocation.
 Verify third allocation.
-- 
2.47.1


