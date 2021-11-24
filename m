Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E172845B499
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 07:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239354AbhKXGzt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 01:55:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:52118 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbhKXGzt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 01:55:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D5B5B2195D;
        Wed, 24 Nov 2021 06:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637736757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ZRvQvNamCIZDlHsesCFWN/ht4h87pR7NgUjqIz5SbSw=;
        b=aqMxSbSxXmigRtLBXO9oHbD2ZvASMHnjyWldNaD8dyb+1ieCD+qUUxyK9dtSfw1i4pLgBY
        BzKh+PITxBblCo0JLtsRKRPhmKzFL7W1GSXes3wvYyBCLzBjFjuR5mboFbAovluBLtOVbI
        PNg+1S7CZx9KD0P3uzjE5+le9dGo1Jo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E82F013240;
        Wed, 24 Nov 2021 06:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BIWEKzThnWGiBQAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 24 Nov 2021 06:52:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/049: add regression test for compress-force mount options
Date:   Wed, 24 Nov 2021 14:52:19 +0800
Message-Id: <20211124065219.33409-1-wqu@suse.com>
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
---
 tests/btrfs/049     | 56 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/049.out |  6 +++++
 2 files changed, 62 insertions(+)
 create mode 100755 tests/btrfs/049

diff --git a/tests/btrfs/049 b/tests/btrfs/049
new file mode 100755
index 00000000..264e576f
--- /dev/null
+++ b/tests/btrfs/049
@@ -0,0 +1,56 @@
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
+workload()
+{
+	local compression
+	compression=$1
+
+	echo "=== Testing compress-force=$compression ==="
+	_scratch_mkfs -s "$pagesize">> $seqres.full
+	_scratch_mount -o compress-force="$compression"
+	$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 $pagesize" \
+		"$SCRATCH_MNT/file" > /dev/null
+	md5sum "$SCRATCH_MNT/file" > "$tmp.$compression"
+
+	# When unpatched, compress-force=lzo would crash at data writeback
+	_scratch_cycle_mount
+
+	# Make sure the content matches
+	md5sum -c "$tmp.$compression" | _filter_scratch
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
index cb0061b3..258f3c09 100644
--- a/tests/btrfs/049.out
+++ b/tests/btrfs/049.out
@@ -1 +1,7 @@
 QA output created by 049
+=== Testing compress-force=lzo ===
+SCRATCH_MNT/file: OK
+=== Testing compress-force=zstd ===
+SCRATCH_MNT/file: OK
+=== Testing compress-force=zlib ===
+SCRATCH_MNT/file: OK
-- 
2.34.0

