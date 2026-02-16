Return-Path: <linux-btrfs+bounces-21681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EBMKCuTkmmSuwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21681-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 04:46:51 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D20140C81
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 04:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1307E3002501
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 03:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069102BE02A;
	Mon, 16 Feb 2026 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IpPQGslB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IpPQGslB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC84C97
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 03:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771213204; cv=none; b=CjgE6oHYzy3lmziUy0z2jOFlYThgvkGc8xvUBLvtF5KEw2VfQHGiM+cmoDSVdCSawFYbyhfFNi0f6/VuRzYFf9cpWXxkBX8jNeuVLInWQYR4OiumHZv75fCBNGXs0Zif2cPauWuL7EbV8/uHRYue69HNlYODLoJyOMdt9ew8Bds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771213204; c=relaxed/simple;
	bh=sDu5YUdsGEuzLEQti3RlqVnfHenKDZTD+qFdFuDG8Nw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c3wqw/zWllc6zDbWf/oSXHZeu46cK5m4fyYgK9CkAywgnRCWfdkYo6d9Z6jeJlXltZjsOaC/sW4mQoltw30SzHJeUWf2F0ZGQEh/Ge1z/YWl0Ynfdta4G7mVs+3JebkmkPYnVujohDJ4WwTgDkJn+8pLGCHVvnYkISsa4S0iGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IpPQGslB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IpPQGslB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from x1pro.suse.cz (unknown [IPv6:2a07:de40:6183:1a::1022])
	by smtp-out1.suse.de (Postfix) with ESMTP id CE5583F292;
	Mon, 16 Feb 2026 03:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771213201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uuTCG+DDjdHW2ZujpwEVXI3WsbElWyYF7Zr9tAYiodw=;
	b=IpPQGslBMzlrOB/rLrXuHuCdCiJ93TF64IRWU4y+c3TWIK3ksTw3UvjDpp0b3bz4E3Me6y
	qE35ACg/6z3eYz5N32ghdBpB3eco9xvsr/YhyKCCXKM03kr5980fTidZ6MHPTSoizQ9CDy
	cdrHzLjjOht73RuKIizF1lKMBAV00o8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IpPQGslB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771213201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=uuTCG+DDjdHW2ZujpwEVXI3WsbElWyYF7Zr9tAYiodw=;
	b=IpPQGslBMzlrOB/rLrXuHuCdCiJ93TF64IRWU4y+c3TWIK3ksTw3UvjDpp0b3bz4E3Me6y
	qE35ACg/6z3eYz5N32ghdBpB3eco9xvsr/YhyKCCXKM03kr5980fTidZ6MHPTSoizQ9CDy
	cdrHzLjjOht73RuKIizF1lKMBAV00o8=
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: add a test case for failed compressed inline attempt
Date: Mon, 16 Feb 2026 14:09:58 +1030
Message-ID: <20260216033958.83632-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: YES
X-Spamd-Bar: ++++++++++++++++
X-Spam-Level: ****************
X-Spam-Score: 16.69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.34 / 15.00];
	SPAM_FLAG(5.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-21681-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9D20140C81
X-Rspamd-Action: no action

[BUG]
There is a long existing behavior that if a compressed inline attempt
failed, the whole inode is marked incompressible.

Furthermore, the default threshold for compressed inline implies a
pretty high compression ratio (2K max inline vs 4K block size, thus 50%
compression ratio).

This makes btrfs to mark inodes incompressible prematurely.

[TEST]
The new test case is based on the previous btrfs/343 one, which will do:

- Create and mount the fs with compress,max_inline=4
  4 bytes will be too small for any header, thus all compressed inline
  writes should fail.

- Do the following operations:
  * Buffered write [0, blocksize / 2)
    Which can be inlined if using the default max_inline mount option
    and 4K fs block.
    But the new max_inline=4 will reject such compressed inline attempt.

    And such one block write should not trigger compression thus no
    compression ratio based check.

  * Sync
    For unpatched kernels, this will set the inode with NOCOMPRESS flag
    and reject all future compression on that inode.

  * Buffered write [1M, 2M)
    For unpatched kernels, the range will not be compressed due to the
    NOCOMPRESS flag.

- Unmount the fs

- Maker sure that:
  * The inode has no NOCOMPRESS flag
  * File extent at file offset 1M is being compressed

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/344     | 53 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/344.out |  2 ++
 2 files changed, 55 insertions(+)
 create mode 100755 tests/btrfs/344
 create mode 100644 tests/btrfs/344.out

diff --git a/tests/btrfs/344 b/tests/btrfs/344
new file mode 100755
index 00000000..4695104f
--- /dev/null
+++ b/tests/btrfs/344
@@ -0,0 +1,53 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 344
+#
+# Check if a failed inline attempt for compression write will mark
+# the whole inode as incompressible
+#
+. ./common/preamble
+_begin_fstest auto quick compress
+
+_require_scratch
+_require_btrfs_command inspect-internal dump-tree
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: do not mark inode incompressible after inline attempt failed"
+
+_scratch_mkfs >>$seqres.full 2>&1
+
+# This inline limit is too small for any header.
+# Thus all compressed inline attempt should fail.
+_scratch_mount "-o compress,max_inline=4"
+
+blocksize=$(_get_file_block_size $SCRATCH_MNT)
+
+# The initial half block write can be compressed, but the compressed
+# size will not meet the 4 bytes limits, thus it will not be inlined.
+#
+# Normally such single block write itself should not mark the inode
+# incompressible, no matter if there is an inline attempt or not.
+#
+# The 1M write should be compressed.
+$XFS_IO_PROG -f -c "pwrite 0 $(( $blocksize / 2 ))" -c sync \
+		-c "pwrite 1m 1m" $SCRATCH_MNT/foobar >> $seqres.full
+ino=$(stat -c "%i" $SCRATCH_MNT/foobar)
+_scratch_unmount
+
+# Dump the fs tree into seqres.full for debug.
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV >> $seqres.full
+
+# Check the NOCOMPRESS flag of the inode.
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
+grep -A 4 -e "item .* key ($ino INODE_ITEM 0)" | grep -q NOCOMPRESS
+[ $? -eq 0 ] && echo "inode $ino has NOCOMPRESS flag"
+
+# Check the file extent at file offset 1m.
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
+grep -A 4 -e "item .* key ($ino EXTENT_DATA 1048576)" | grep -q "compression 0"
+[ $? -eq 0 ] && echo "inode $ino file offset 1M is not compressed"
+
+echo "Silence is golden"
+_exit 0
diff --git a/tests/btrfs/344.out b/tests/btrfs/344.out
new file mode 100644
index 00000000..b950d5ae
--- /dev/null
+++ b/tests/btrfs/344.out
@@ -0,0 +1,2 @@
+QA output created by 344
+Silence is golden
-- 
2.51.2


