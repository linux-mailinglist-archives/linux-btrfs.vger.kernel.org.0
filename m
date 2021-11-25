Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388BE45D48D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Nov 2021 07:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347116AbhKYGLA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Nov 2021 01:11:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59216 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244689AbhKYGI7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Nov 2021 01:08:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 072A321954;
        Thu, 25 Nov 2021 06:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637820348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=X4vA0OfeWuSH0twumEAJxx4/BG9Em1XrSJdcCIfFMOg=;
        b=jLFzLWURpqxBTYmt+f7pQk/8T7U7rlMww0tbo34NT++bxRHqbTI+0oP03KEaBSALFpXHsE
        rzALnkVvlkkiWaaof/7CBGu/pNR2da4cxwN09HQ72HNmNkzxMOlbRsuuw5Tk7MD+xwxAZJ
        b3gSOH3/ix5g7QKVHGib4ucZKDKWbd8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19EFF13AE9;
        Thu, 25 Nov 2021 06:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q3lPNLonn2HXXAAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 25 Nov 2021 06:05:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3] fstests: btrfs/049: add regression test for compress-force mount options
Date:   Thu, 25 Nov 2021 14:05:29 +0800
Message-Id: <20211125060529.53289-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
compatible"), lzo compression no longer respects the max compressed page
limit, and can cause kernel crash.

The upstream fix is 6f019c0e0193 ("btrfs: fix a out-of-bound access in
copy_compressed_data_to_page()").

This patch will add such regression test for all possible compress-force
mount options, including lzo, zstd and zlib.

And since we're here, also make sure the content of the file matches
after a mount cycle.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Also test zlib and zstd
- Add file content verification check
v3:
- Use $tmp.good as a known good file source
- Also make sure we didn't get short read for the good copy
---
 tests/btrfs/049     | 67 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/049.out |  6 ++++
 2 files changed, 73 insertions(+)
 create mode 100755 tests/btrfs/049

diff --git a/tests/btrfs/049 b/tests/btrfs/049
new file mode 100755
index 00000000..c1f35dc9
--- /dev/null
+++ b/tests/btrfs/049
@@ -0,0 +1,67 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 049
+#
+# Test if btrfs will crash when using compress-force mount option against
+# incompressible data
+#
+. ./common/preamble
+_begin_fstest auto quick compress dangerous
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+ 	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+pagesize=$(get_page_size)
+
+# Read the content from urandom to a known safe location
+$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 $pagesize" "$tmp.good" > /dev/null
+
+# Make sure we didn't get short read
+if [ $(_get_filesize "$tmp.good") != "$pagesize" ]; then
+	_fail "Got a short read from /dev/urandom"
+fi
+
+workload()
+{
+	local compression=$1
+
+	echo "=== Testing compress-force=$compression ==="
+	_scratch_mkfs -s "$pagesize">> $seqres.full
+	_scratch_mount -o compress-force="$compression"
+	cp "$tmp.good" "$SCRATCH_MNT/$compression"
+
+	# When unpatched, compress-force=lzo would crash at data writeback
+	_scratch_cycle_mount
+
+	# Make sure the content matches
+	if [ "$(_md5_checksum $tmp.good)" != \
+	     "$(_md5_checksum $SCRATCH_MNT/$compression)" ]; then
+		_fail "Content of '$SCRATCH_MNT/file' mismatch with known good copy"
+	else
+		echo "OK"
+	fi
+	_scratch_unmount
+}
+
+workload lzo
+workload zstd
+workload zlib
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
index cb0061b3..41bffeaa 100644
--- a/tests/btrfs/049.out
+++ b/tests/btrfs/049.out
@@ -1 +1,7 @@
 QA output created by 049
+=== Testing compress-force=lzo ===
+OK
+=== Testing compress-force=zstd ===
+OK
+=== Testing compress-force=zlib ===
+OK
-- 
2.34.0

