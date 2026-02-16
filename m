Return-Path: <linux-btrfs+bounces-21693-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EczD1CMk2mK6QEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21693-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 22:29:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC381147B6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 22:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 192603010BB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Feb 2026 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6072BEFED;
	Mon, 16 Feb 2026 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R8A7MCAG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R8A7MCAG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D01465B4
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Feb 2026 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771277388; cv=none; b=Fa56DROgNSlKlVyPk8X1k6feHNPByCt3VZHvcqUyA8RE73emvaCanIRSO48vfO0ojRiqz2gsnOSNh3LL51ZZcwVfO57ypzCRF2IvGy2dcI3j+ODsn0XRSx+IpKMk/Hpz02UyOrPr7OVUZ8b2E0YBTmQWa2LI92jcSH3umVJ1bPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771277388; c=relaxed/simple;
	bh=DAhREdvn3RMnxGI94j+argQTGO2Q+pRHd2QtT6Y4SXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmwqpozcni6l0g1pILWkrp5K6fU47V6+2SEIPQQHjOxwHFO/r836HL4S5scy+Euw3BhT7jNyp13J9kXcja1q8OND9uildXhaCoNIBWLQCC68MqLD1dX5x6Shs3+wX5TnD7lQvwWuxVsFtUs9B2w4ShQzRx5c7nPCaXXqyCF045M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R8A7MCAG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R8A7MCAG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 997CD5BF06;
	Mon, 16 Feb 2026 21:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771277385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e2w3L/U+ocul6V1pAaDdshnnM4Q2qUALMRONJ58xyzc=;
	b=R8A7MCAGtZy9/wGwglG+blkhh/cDHOJAM5G75m78YDwwljrAps872zDvdfP3xb8/9y+l1F
	xARYexxD4HXaz7G+r1IpLwduTTXKrqMgloYP6QoHPgLfbKn4alNWyArZ4rvSPq32yN9GXX
	53kv1OzuP4sRhs/JPI6ghy9FOVJWuwQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771277385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=e2w3L/U+ocul6V1pAaDdshnnM4Q2qUALMRONJ58xyzc=;
	b=R8A7MCAGtZy9/wGwglG+blkhh/cDHOJAM5G75m78YDwwljrAps872zDvdfP3xb8/9y+l1F
	xARYexxD4HXaz7G+r1IpLwduTTXKrqMgloYP6QoHPgLfbKn4alNWyArZ4rvSPq32yN9GXX
	53kv1OzuP4sRhs/JPI6ghy9FOVJWuwQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58D253EA62;
	Mon, 16 Feb 2026 21:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QjcvB0iMk2mtTwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 16 Feb 2026 21:29:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] fstests: btrfs: add a test case for failed compressed inline attempt
Date: Tue, 17 Feb 2026 07:59:24 +1030
Message-ID: <20260216212924.34590-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21693-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC381147B6E
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Minor grammar error fixes
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


