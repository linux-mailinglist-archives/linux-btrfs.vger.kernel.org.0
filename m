Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3193F6F54
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 08:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbhHYGUO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 02:20:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54078 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbhHYGUN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 02:20:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F9DE220E8;
        Wed, 25 Aug 2021 06:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629872367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vQexncvdJaSNQlHFxhSlxShkEc02UWk1vJ+MLNm2x30=;
        b=HOAVw9kd/5vr9SNgi1P7bm4OEL2s2/3e/lavvpMMvMqGTkfyW6hC0gu7lyBobERe/oTX4M
        IaITdomr77ziM+/IIohAkkBRU7AKNIL/LBgC55VDEfGHyFVnbVHD9TgBJ3mk1rayHCVwMf
        va9G/+Gzhn73LvnyRcN6iauQd/MwMF8=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 34DBB13732;
        Wed, 25 Aug 2021 06:19:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 5qisOO3gJWH+WwAAGKfGzw
        (envelope-from <wqu@suse.com>); Wed, 25 Aug 2021 06:19:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/246: add test case to make sure btrfs can create compressed inline extent
Date:   Wed, 25 Aug 2021 14:19:23 +0800
Message-Id: <20210825061923.13770-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs has the ability to inline small file extents into its metadata,
and such inlined extents can be further compressed if needed.

The new test case is for a regression caused by commit f2165627319f
("btrfs: compression: don't try to compress if we don't have enough
pages").

That commit prevents btrfs from creating compressed inline extents, even
"-o compress,max_inline=2048" is specified, only uncompressed inline
extents can be created.

The test case will use "btrfs inspect dump-tree" to verify the created
extent is both inlined and compressed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/246     | 50 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/246.out |  2 ++
 2 files changed, 52 insertions(+)
 create mode 100755 tests/btrfs/246
 create mode 100644 tests/btrfs/246.out

diff --git a/tests/btrfs/246 b/tests/btrfs/246
new file mode 100755
index 00000000..15bb064d
--- /dev/null
+++ b/tests/btrfs/246
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 246
+#
+# Make sure btrfs can create compressed inline extents
+#
+. ./common/preamble
+_begin_fstest auto quick compress
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+# For __populate_find_inode()
+. ./common/populate
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+_scratch_mkfs > /dev/null
+_scratch_mount -o compress,max_inline=2048
+
+# This should create compressed inline extent
+$XFS_IO_PROG -f -c "pwrite 0 2048" $SCRATCH_MNT/foobar > /dev/null
+ino=$(__populate_find_inode $SCRATCH_MNT/foobar)
+_scratch_unmount
+
+$BTRFS_UTIL_PROG inspect dump-tree -t 5 $SCRATCH_DEV | \
+	grep "($ino EXTENT_DATA 0" -A2 > $tmp.dump-tree
+echo "dump tree result for ino $ino:" >> $seqres.full
+cat $tmp.dump-tree >> $seqres.full
+
+grep -q "inline extent" $tmp.dump-tree || echo "no inline extent found"
+grep -q "compression 1" $tmp.dump-tree || echo "no compressed extent found"
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/246.out b/tests/btrfs/246.out
new file mode 100644
index 00000000..287f7983
--- /dev/null
+++ b/tests/btrfs/246.out
@@ -0,0 +1,2 @@
+QA output created by 246
+Silence is golden
-- 
2.31.1

