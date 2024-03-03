Return-Path: <linux-btrfs+bounces-2986-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8652A86F3D7
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Mar 2024 07:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40318282E5D
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Mar 2024 06:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5675179F5;
	Sun,  3 Mar 2024 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XEXJaeNI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XEXJaeNI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735391869;
	Sun,  3 Mar 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709448800; cv=none; b=URQJBvpLm0vBySp1Zg7zlqSpviAvZ76i0t87i09FdZEJGHtyhbSG8Na8XQF0rOTpfx4xyporlc3ry0zRnM3Obe2DGG7Zv6E0EN9le8Uma32mZzhcN6baR+eMl45lai71smugXVeNiXkzOsTBKr+oU/ggJ6HsqP/EjesK0cxFiVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709448800; c=relaxed/simple;
	bh=JZYlh57dA/FGjvp/vNYvOfBSnBWJgCn4AEfwDQmrdd8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lpTXzzRMorNkvpCpQx6i8QOKSTvrrC8Vp15RL90593jtWAXhN4Swt9w0zSvOXdubKHqFTKc724a0EYfMyzpEuiXVbIDmHq6+Tcsh6uyYpHIGKgimW/gz/U9TTdiA/0ZQolvGW/kBos2+hWkePCzVJllel2LFDCxwWXjpuLAfipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XEXJaeNI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XEXJaeNI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 534BD38386;
	Sun,  3 Mar 2024 06:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709448791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cE5ZtzSla9kbiTxnqEwsKKvmr5RV35bJfa7H3lUceI8=;
	b=XEXJaeNIw3HBymcOeXiy62UNNi1mEYlLOg4Lhq284h3Ag/fJ+dP3BkM9I5IG17OBJb5m6B
	+fQ8ngGojWHxpNvar300YtvxuTfGdD60O6DPgzWZd3iNPA9ificab3PXwPNN/lvv5Nu8pe
	7TfPl+GygAGocDghyjGLJa5b34AjEg4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709448791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=cE5ZtzSla9kbiTxnqEwsKKvmr5RV35bJfa7H3lUceI8=;
	b=XEXJaeNIw3HBymcOeXiy62UNNi1mEYlLOg4Lhq284h3Ag/fJ+dP3BkM9I5IG17OBJb5m6B
	+fQ8ngGojWHxpNvar300YtvxuTfGdD60O6DPgzWZd3iNPA9ificab3PXwPNN/lvv5Nu8pe
	7TfPl+GygAGocDghyjGLJa5b34AjEg4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 12B25139D1;
	Sun,  3 Mar 2024 06:53:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id llTIL1Ue5GVoegAAn2gu4w
	(envelope-from <wqu@suse.com>); Sun, 03 Mar 2024 06:53:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/121: allow snapshot with invalid qgroup to return error
Date: Sun,  3 Mar 2024 17:22:51 +1030
Message-ID: <20240303065251.111868-1-wqu@suse.com>
X-Mailer: git-send-email 2.44.0
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

[BUG]
After incoming kernel commit "btrfs: qgroup: verify btrfs_qgroup_inherit
parameter", test case btrfs/121 would fail like this:

btrfs/121 1s ... [failed, exit status 1]- output mismatch (see /xfstests/results//btrfs/121.out.bad)
    --- tests/btrfs/121.out	2022-05-11 09:55:30.739999997 +0800
    +++ /xfstests/results//btrfs/121.out.bad	2024-03-03 13:33:38.076666665 +0800
    @@ -1,2 +1,3 @@
     QA output created by 121
    -Silence is golden
    +failed: '/usr/bin/btrfs subvolume snapshot -i 1/10 /mnt/scratch /mnt/scratch/snap1'
    +(see /xfstests/results//btrfs/121.full for details)
    ...
    (Run 'diff -u /xfstests/tests/btrfs/121.out /xfstests/results//btrfs/121.out.bad'  to see the entire diff)

[CAUSE]
The incoming kernel commit would do early qgroups validation before
subvolume/snapshot creation, and reject invalid qgroups immediately.

Meanwhile that test case itself still assume the ioctl would go on
without any error, thus the new behavior would break the test case.

[FIX]
Instead of relying on the snapshot creation ioctl return value, we just
completely ignore the output of that snapshot creation.
Then manually check if the fs is still read-write.

For different kernels (3 cases), they would lead to the following
results:

- Older unpatched kernel
  The filesystem would trigger a transaction abort (would be caught by
  dmesg filter), and also fail the "touch" command.

- Older but patched kernel
  The filesystem continues to create the snapshot, while still keeps the
  fs read-write.

- Latest kernel with qgroup validation
  The filesystem refuses to create the snapshot, while still keeps the
  fs read-write.

Both "older but patched" and "latest" kernels would still pass the test
case, even with different behaviors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/121 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/121 b/tests/btrfs/121
index f4d54962..15a54274 100755
--- a/tests/btrfs/121
+++ b/tests/btrfs/121
@@ -24,8 +24,14 @@ _require_scratch
 _scratch_mkfs >/dev/null
 _scratch_mount
 _run_btrfs_util_prog quota enable $SCRATCH_MNT
-# The qgroup '1/10' does not exist and should be silently ignored
-_run_btrfs_util_prog subvolume snapshot -i 1/10 $SCRATCH_MNT $SCRATCH_MNT/snap1
+# The qgroup '1/10' does not exist. The kernel should either gives an error
+# (newer kernel with invalid qgroup detection) or ignore it (older kernel with
+# above fix).
+# Either way, we just ignore the output completely, and we will check if the fs
+# is still RW later.
+$BTRFS_UTIL_PROG subvolume snapshot -i 1/10 $SCRATCH_MNT $SCRATCH_MNT/snap1 &> /dev/null
+
+touch $SCRATCH_MNT/foobar
 
 echo "Silence is golden"
 
-- 
2.42.0


