Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9130949EFA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 01:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbiA1A2L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 19:28:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47264 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344995AbiA1A1Y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 19:27:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B783212CA;
        Fri, 28 Jan 2022 00:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643329642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/MsAhRjM9KOl/KjjYKjfeiOO3x3t2jI0t9NmYtqz94=;
        b=Fur0Qd9PzdzeIfExhVP2nZ9l0EEVxkrlHZvlKB4zXayVZHcUV3PckO4eaE3kA/ntvIaT/i
        wWY7btxjmv6Oe/DFVUhuhoH1CrWvEELsLgJduq4YlPXR0vyq2ebBim5bR+gOCOGd5gvyJd
        7SRrjIoVRNim8YNN8EVY+OG4OJjNBqM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0CF4139F7;
        Fri, 28 Jan 2022 00:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yBgJG2k482FQQAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 28 Jan 2022 00:27:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: test defrag with compressed extents
Date:   Fri, 28 Jan 2022 08:27:01 +0800
Message-Id: <20220128002701.11971-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128002701.11971-1-wqu@suse.com>
References: <20220128002701.11971-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a long existing bug in btrfs defrag code that it will always
try to defrag compressed extents, even they are already at max capacity.

This will not reduce the number of extents, but only waste IO/CPU.

The kernel fix is titled:

  btrfs: defrag: don't defrag extents which is already at its max capacity

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use fiemap output to compare the difference
  Now no need to use _get_file_extent_sector() helper at all.

- Remove unnecessary mount options

- Enlarge the write size to 16M
  To be future proof

- Shorten the subject
---
 tests/btrfs/257     | 57 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/257.out |  2 ++
 2 files changed, 59 insertions(+)
 create mode 100755 tests/btrfs/257
 create mode 100644 tests/btrfs/257.out

diff --git a/tests/btrfs/257 b/tests/btrfs/257
new file mode 100755
index 00000000..bacd0c23
--- /dev/null
+++ b/tests/btrfs/257
@@ -0,0 +1,57 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 257
+#
+# Make sure btrfs defrag ioctl won't defrag compressed extents which are already
+# at their max capacity.
+#
+. ./common/preamble
+_begin_fstest auto quick defrag
+
+# Import common functions.
+. ./common/filter
+. ./common/btrfs
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+
+_scratch_mount -o compress
+
+# Btrfs uses 128K as max extent size for compressed extents, this would result
+# several compressed extents all at their max size
+$XFS_IO_PROG -f -c "pwrite -S 0xee 0 16m" -c sync \
+	$SCRATCH_MNT/foobar >> $seqres.full
+
+old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
+
+echo "=== File extent layout before defrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" > $tmp.before
+
+$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foobar" >> $seqres.full
+sync
+
+new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
+
+echo "=== File extent layout before defrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" > $tmp.after
+
+if [ $new_csum != $old_csum ]; then
+	echo "file content changed"
+fi
+
+diff -q $tmp.before $tmp.after || echo "compressed extents get defragged"
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/257.out b/tests/btrfs/257.out
new file mode 100644
index 00000000..cc3693f3
--- /dev/null
+++ b/tests/btrfs/257.out
@@ -0,0 +1,2 @@
+QA output created by 257
+Silence is golden
-- 
2.34.1

