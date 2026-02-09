Return-Path: <linux-btrfs+bounces-21514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHvoMzJQiWkT6gQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21514-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 04:10:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFCC10B578
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 04:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B506300822C
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27C2F3C3F;
	Mon,  9 Feb 2026 03:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="N4NH1Sje";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cZrRTkuw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E21925BC
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770606632; cv=none; b=TWPfC3MT2TDH6IOqp/rtcKzMB+Evnrsa2MeaL2oUecwqVC2md7oKv9k3+GjwXm5z1qI8ogYDFqjtq4eFAsoqCW7SyjzLozCDf1CTqOndSQZbcanlG56gbFG+pKTTQ4itZTMoW5ar1pGz/xMhAndQ6/pWhG2brZl1hLVPXlfR/5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770606632; c=relaxed/simple;
	bh=TT3ht/WlKF3/C2tTnxEH/Xx4c0ZOMAKre48pfyc7XKE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Nb5FxgoILhw/9oTGBMgL95Ymfr0alwW39QwLmcl0FSgQzynuJExiMCzy/dAwDR//4v3FHyGvXOlMlsyrO1Ppy2AjkPVBIUqeY5lXn6gnU51JwCb06LEJ5xGuIqYNwhkJoeB+HspPvfLmZor2JeY6yaavAH4Vg1dfcg4jN4ZF8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=N4NH1Sje; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cZrRTkuw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2B813E709;
	Mon,  9 Feb 2026 03:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770606630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=d4exBQ2buxfC0z2xu7wQ/aKPihayKG0VEVA4QkoCtv4=;
	b=N4NH1SjeuXdLPY89x4Djp/XcrBHwhBk15s0WA9msqeie1Dn2zUe8dURIct/nF898k/0EKX
	SDZH8crM0SLvwZ3f8f6Nz8Q/juRmjMCsIcIfIJg43oT7RZNQ/XclhxF8bhhsscs/pmKnCu
	nor2t4CGVd7jQoeMAee5JN+jQdYQtfk=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cZrRTkuw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770606629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=d4exBQ2buxfC0z2xu7wQ/aKPihayKG0VEVA4QkoCtv4=;
	b=cZrRTkuwxSFozmfimW7HqCiKJz65JkRg67RUt7qGe9PI/L/lHSsZINXye8EywXfanhYJVE
	5vS/BDoNHZyRA7DX4Qz0jWQyhLTcbq/3B1hrNZ/pCZLgN2A3HjdZwruJfZ7hL+Gn5/4HKG
	v4mwwgfum6XSof+Fw9W9xF2rBVUL9IY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94A563EA63;
	Mon,  9 Feb 2026 03:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vBOMECRQiWmOaAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 09 Feb 2026 03:10:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: add a regression test for incorrect inode incompressible flag
Date: Mon,  9 Feb 2026 13:40:09 +1030
Message-ID: <20260209031009.28070-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-21514-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 2CFCC10B578
X-Rspamd-Action: no action

[BUG]
Since kernel commit 59615e2c1f63 ("btrfs: reject single block sized
compression early"), a single block write at file offset 0, which can
not be inlined due the inode size, will mark the inode incompressible.

This is not the expected behavior is caused by that commit.

[REGRESSION TEST]
The new regression test will do:

- Create and mount the fs with compression,max_inline=2k

- Do the following operations:
  * Truncate the inode to 2 * blocksize
    This will rule out any future inlined writes.

  * Buffered write [0, 2K)
    Which will not be inlined.

  * Sync
    For affected kernels, this will set the inode with NOCOMPRESS
    and reject all future compression on that inode.

  * Buffered write [1M, 2M)
    For affected kernels, the range will not be compressed due
    to the NOCOMPRESS flag.

- Unmount the fs

- Make sure that:
  * The inode has no NOCOMPRESS flag
  * File extent at file offset 1M is being compressed

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/343     | 47 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/343.out |  2 ++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/btrfs/343
 create mode 100644 tests/btrfs/343.out

diff --git a/tests/btrfs/343 b/tests/btrfs/343
new file mode 100755
index 00000000..78079eff
--- /dev/null
+++ b/tests/btrfs/343
@@ -0,0 +1,47 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 343
+#
+# A regression test to make sure a single-block write at file offset 0 won't
+# incorrectly mark the inode incompressible.
+#
+. ./common/preamble
+_begin_fstest auto quick compress
+
+_require_scratch
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix the inline compressed extent check in inode_need_compress()"
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount "-o compress,max_inline=2048"
+
+blocksize=$(_get_block_size $SCRATCH_MNT)
+
+# Create a sparse file which is 2 * blocksize, then try a small write at
+# file offset 0 which should not be inlined.
+# Sync so that [0, 2K) range is written, then write a larger range which
+# should be able to be compressed.
+$XFS_IO_PROG -f -c "truncate $((2 * $blocksize))" -c "pwrite 0 2k" -c sync \
+		-c "pwrite 1m 1m" $SCRATCH_MNT/foobar >> $seqres.full
+ino=$(stat -c "%i" $SCRATCH_MNT/foobar)
+_scratch_unmount
+
+# Dump the fstree into seqres.full for debug
+$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV >> $seqres.full
+
+# Check the NOCOMPRESS flag of the inode.
+$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV |\
+grep -A 4 -e "item .* key ($ino INODE_ITEM 0)" | grep -q NOCOMPRESS
+[ $? -eq 0 ] && echo "inode $ino has NOCOMPRESS flag"
+
+# Check the file extent at fileoffset 1m
+$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV |\
+grep -A 4 -e "item .* key ($ino EXTENT_DATA 1048576)" | grep -q "compression 0"
+[ $? -eq 0 ] && echo "inode $ino file offset 1M is not compressed"
+
+echo "Silence is golden"
+# success, all done
+_exit 0
diff --git a/tests/btrfs/343.out b/tests/btrfs/343.out
new file mode 100644
index 00000000..2eb30e4f
--- /dev/null
+++ b/tests/btrfs/343.out
@@ -0,0 +1,2 @@
+QA output created by 343
+Silence is golden
-- 
2.51.2


