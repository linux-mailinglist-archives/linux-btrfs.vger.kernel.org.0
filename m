Return-Path: <linux-btrfs+bounces-21537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CfLF+iwiWndAgUAu9opvQ
	(envelope-from <linux-btrfs+bounces-21537-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 11:03:20 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E725010DEFD
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 11:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C933C3062212
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 09:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE236607A;
	Mon,  9 Feb 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bxi0Qqvm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Bxi0Qqvm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD28326924
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770631079; cv=none; b=B1aLUV06ak18XU6gY+cproj4OKL2Zmr6RinvhFisPGzfMLrSvat7ETXGOnfnAs3zmksNr2i9oQForhyjUV13rZeXU4MIl5sk1xKz2Q0lC9Fx0X4HwXJnTuwkTsF+TwntNOc/fHj7Qv2ojtGBlMJnBjTk8dSke7dvHod9KTEK60w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770631079; c=relaxed/simple;
	bh=2Wxk8TLvcCoJfdKe9wcl+yXk73vVH4FpAgzBAG40VYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=soaPO4dwJzGn1QwuR10ruYtcCfHzynAMxevyj4t5gh+Qh5DADtRC30GniZHEqog11Ao/p+9Fu/FWT9evOP72SHnhuTrE+hXAUxOGWbYLVY0nruVfyLGMTnCIcoE8WWEKycrOt6ECNMPaVbRqoWg5joirFdVgBwXASjF7bh+fErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bxi0Qqvm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Bxi0Qqvm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 384B05BCD8;
	Mon,  9 Feb 2026 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770631076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J1IDmlevR41VHdB6pPTz6i5TIBT+lC/nybHeFIRODII=;
	b=Bxi0QqvmV5v5dz9ZR5Vg9ZibxiNfCJlHBFZ1S30GMyfwiAPXICvFhtYr9pMLwiGF4GHOh3
	9JQjezUCg7N4vguceMfLyRDveCa7DRddl4r6ZuXaonFG3q65l7wogbopxghmfGYNxRyuy8
	L9EcQTTweVYTcismw9Rh5hifWOYA/fQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Bxi0Qqvm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770631076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J1IDmlevR41VHdB6pPTz6i5TIBT+lC/nybHeFIRODII=;
	b=Bxi0QqvmV5v5dz9ZR5Vg9ZibxiNfCJlHBFZ1S30GMyfwiAPXICvFhtYr9pMLwiGF4GHOh3
	9JQjezUCg7N4vguceMfLyRDveCa7DRddl4r6ZuXaonFG3q65l7wogbopxghmfGYNxRyuy8
	L9EcQTTweVYTcismw9Rh5hifWOYA/fQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76EA53EA64;
	Mon,  9 Feb 2026 09:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KtyfCKKviWn6OgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 09 Feb 2026 09:57:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3] fstests: btrfs: add a regression test for incorrect inode incompressible flag
Date: Mon,  9 Feb 2026 20:27:35 +1030
Message-ID: <20260209095735.130049-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21537-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: E725010DEFD
X-Rspamd-Action: no action

[BUG]
Since kernel commit 59615e2c1f63 ("btrfs: reject single block sized
compression early"), a single block write at file offset 0, which can
not be inlined due the inode size, will mark the inode incompressible.

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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove an unnessary sentence
  Which is confusing because I missed the "and" to connect the two
  sentences, and it's not needed after the first paragraph anyway.

- Use full "btrfs inspect-internal" group name instead

- Add missing punctures

v3:
- Properly commit the modification
  Facepalm
---
 tests/btrfs/343     | 48 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/343.out |  2 ++
 2 files changed, 50 insertions(+)
 create mode 100755 tests/btrfs/343
 create mode 100644 tests/btrfs/343.out

diff --git a/tests/btrfs/343 b/tests/btrfs/343
new file mode 100755
index 00000000..3781373c
--- /dev/null
+++ b/tests/btrfs/343
@@ -0,0 +1,48 @@
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
+_require_btrfs_command inspect-internal dump-tree
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
+# Dump the fstree into seqres.full for debug.
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV >> $seqres.full
+
+# Check the NOCOMPRESS flag of the inode.
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
+grep -A 4 -e "item .* key ($ino INODE_ITEM 0)" | grep -q NOCOMPRESS
+[ $? -eq 0 ] && echo "inode $ino has NOCOMPRESS flag"
+
+# Check the file extent at fileoffset 1m.
+$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV |\
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


