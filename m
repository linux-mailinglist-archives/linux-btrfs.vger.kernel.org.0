Return-Path: <linux-btrfs+bounces-1637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71B6838684
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 06:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04DFBB23ABF
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 05:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE202109;
	Tue, 23 Jan 2024 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="myErJ7Ad";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kJWYTQyQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AB91FCC;
	Tue, 23 Jan 2024 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705986367; cv=none; b=l+nNYe9GM2i4W+BQ5X3eDUXMxCr/6VT7DAP8Bdzeb+MSi5D4nU11krwdgqnPdyzuhygG3MfutBjxZewuZV16QXaxBXQasyr2fo3YQDtp/iPPzW8KV2zZVNN9bGSBwnjmZH9j5bCWaEFlh2Fw0plFeubNA4aZLMSAYo6HKVBgClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705986367; c=relaxed/simple;
	bh=PgCLPnx5f3O9X27rpqwdpRlF+oHUvDg28fBczZEWNeE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=e2sE5bTLDlqIsOQ7zxnX/hnKRYKiqw1foKmn9+kxBVcFC5elFBLJWFSVkqYtMlZshmEPQN724gK0i04lZVbOF3KdPKTyjj2FR8rQ93YAOzic1dl2FVWFbWVO5AAxdW3i4pRg/q87+3fCrR3jldssWVydTA39/xqenQT2/sMzZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=myErJ7Ad; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kJWYTQyQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1B321F7A9;
	Tue, 23 Jan 2024 05:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705986363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Shn2i5q0+F3k0lsMXQ1tLtWyw5sKWMY2EUy1PVQKdLY=;
	b=myErJ7Adl96KJXhQcX8vDbQCWJFZaJ7vMTLOzweD8HWNrc7nZHGrxclgEWhlLJbF3fMQDF
	2ZA7mvHwdfc/8lb4GXX+og+hwlccOmWGypZsIqxap1tBywdq6QORIco2F/jgV7TndtAe1a
	QQjqcZmF6cocUbdiSOf6BGSguBJEXhI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705986362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Shn2i5q0+F3k0lsMXQ1tLtWyw5sKWMY2EUy1PVQKdLY=;
	b=kJWYTQyQw51RsfWjdvIrNfjm5+4C6RUSqiOHi2CsIazCfsS1Oe940fEHpT+WDD4VdOmG5Z
	IkTjskuK+uWUKlmumJf2UxKGfqjECLlnbzn3ict9D/VvLV5A/WMusfVQ7qn/AV2jYRyEdj
	SPpc6YkmhZP+i86aRFITPJuibsKza6Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B771136A4;
	Tue, 23 Jan 2024 05:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n/VBFzlJr2UNPgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 23 Jan 2024 05:06:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: verify subpage reflinking of a compressed inline extent
Date: Tue, 23 Jan 2024 15:35:43 +1030
Message-ID: <20240123050543.30741-1-wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ****
X-Spam-Score: 5.00
X-Spamd-Result: default: False [5.00 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 NEURAL_SPAM_LONG(3.30)[0.942];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

[BUG]
Although subpage btrfs can not yet create a compressed inline file extent
(we support compressed file extent, but not inlined due to other
limits), subpage btrfs should still read the compressed inline content
correctly.

Two routines are involved for such read:

- Regular page read

- Reflinking an compressed inlined extent to non-zero file offset
  This would decompress the extent and fill the page cache.

The latter part turns out to be buggy from the introduction of
compression.
The interface is not handling subpage correctly, and can lead to -EIO
when doing reflinks if the target offset is not page aligned but only
sector aligned.

The fixes have arrived in v6.8-rc1.

[CAUSE]
The root cause is the bad page offset handling in various decompression
path.

[TEST CASE]
Since subpage btrfs can not create inline extent due to other limits, we
have to break the no-binary requirement.

This time we would create an xz compressed image, which contains a 4K
sector sized btrfs, and it contains a file with one compressed inline
extent.

The test case would:

- Use that binary dump to fill SCRATCH_DEV
- Verify we can read the file correctly
- Verify we can reflink the compressed inline extent correctly
- Verify the content of the reflinked file is correct

This has been tested on an aarch64 system with 64K page size.
For common x86_64, the test case would just be skipped.

The biggest concern here is, whether a binary image dump is allowed for
fstests, especially the scenario (subpage btrfs) doesn't have the way to
create inlined extents, but we still want to verify the read behavior.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/311        |  73 +++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.img.xz | Bin 0 -> 22368 bytes
 tests/btrfs/311.out    |   3 ++
 3 files changed, 76 insertions(+)
 create mode 100755 tests/btrfs/311
 create mode 100644 tests/btrfs/311.img.xz
 create mode 100644 tests/btrfs/311.out

diff --git a/tests/btrfs/311 b/tests/btrfs/311
new file mode 100755
index 00000000..b8c9463b
--- /dev/null
+++ b/tests/btrfs/311
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 311
+#
+# Make sure subpage btrfs can reflink a compressed inline extent to
+# an non-page aligned but sector aligned file offset
+#
+. ./common/preamble
+_begin_fstest auto quick clone compress
+
+. ./common/filter
+
+_require_command "$XZ_PROG" xz
+_supported_fs btrfs
+_require_scratch
+
+_fixed_by_kernel_commit  2c25716dcc25 \
+	"btrfs: zlib: fix and simplify the inline extent decompression"
+
+# This test requires subpage (sectorsize < PAGE_SIZE) btrfs, and a compressed
+# inline file extent, which is not yet possible to create under subpage btrfs.
+#
+# So here we have to use binary dump of a 4k sector sized btrfs here.
+pagesize=$(_get_page_size)
+if [ "$pagesize" -le "4096" ]; then
+	_notrun "This test case requires page size > 4096, got $pagesize"
+fi
+
+testcase="$0"
+if [ ! -f $testcase.img.xz ]; then
+	_fail "No binary image found"
+fi
+
+# Extra the binary dump to $SCRATCH_DEV
+$XZ_PROG --decompress --stdout $testcase.img.xz > $tmp.img
+dd if=$tmp.img of=$SCRATCH_DEV bs=1M status=none
+rm -f -- $tmp.img
+
+_scratch_mount
+
+# The correct md5 for the 4K file filled with "0xcd"
+md5sum_inline="5fed275e7617a806f94c173746a2a723"
+
+# The correct md5 for the 64K file with 60K hole then a 4K filled with "0xcd".
+md5sum_reflink="2fd82541f4790ea9730cd8b6c0f2fd9a"
+
+# Even subpage can not create compressed inline extents, read should happen without
+# any problem.
+result=$(_md5_checksum "$SCRATCH_MNT/inline")
+echo "initial read, md5sum=${result}" >> $seqres.full
+if [ "$result" != "$md5sum_inline" ]; then
+	_fail "initial read got incorrect content"
+fi
+
+# Now we reflink the compressed inline extent to an non-zero offset,
+# this would require us to decompress the content, and create a regular extent.
+#
+# For unpatched kernel, this would lead to an -EIO error.
+$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/inline 0 60k 4k" $SCRATCH_MNT/reflink | _filter_xfs_io
+
+# Make sure the reflinked file (which contains the decompressed contents) is correct.
+result=$(_md5_checksum "$SCRATCH_MNT/reflink")
+if [ "$result" != "$md5sum_reflink" ]; then
+	_fail "reflinked file has incorrect content"
+fi
+
+_scratch_unmount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/311.img.xz b/tests/btrfs/311.img.xz
new file mode 100644
index 0000000000000000000000000000000000000000..ccb8fc1b8da5868f374df1c01ea480715a60b262
GIT binary patch
literal 22368
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

literal 0
HcmV?d00001

diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
new file mode 100644
index 00000000..87a66bc4
--- /dev/null
+++ b/tests/btrfs/311.out
@@ -0,0 +1,3 @@
+QA output created by 311
+linked 4096/4096 bytes at offset 61440
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.43.0


