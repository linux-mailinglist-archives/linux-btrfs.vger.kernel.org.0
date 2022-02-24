Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01474C2C5F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 14:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbiBXNBA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 08:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiBXNAz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 08:00:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C4E70CEA;
        Thu, 24 Feb 2022 05:00:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C265A212B8;
        Thu, 24 Feb 2022 13:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645707624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=lBA++mc5SF8Y4WETgFfwwoyPxRe4iWtGpGa+kNNMrdI=;
        b=KqCwjp9wg1zgebekpi276u5JP7m/DTVYTK4jUP5oJV5OjZ6kjoDcWMV7V1ftLJDudxfcPm
        +ZNKBdPIm4AdWE5itGMBdtXMMCrdtQJtZKQoe/XaxfowI7O2ahoXD8zaCd6ZcjIw16sjev
        9HKPY82c/1xh1DplJYcgBEIKA0ByMaM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C812313AD9;
        Thu, 24 Feb 2022 13:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8j9yImeBF2ITFgAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 24 Feb 2022 13:00:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add test case to make sure autodefrag obeys small write extent threshold
Date:   Thu, 24 Feb 2022 21:00:20 +0800
Message-Id: <20220224130020.64199-1-wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs autodefrag used to only use default defrag extent size threshold,
which is not the same as the threshold to trigger autodefrag.
(The autodefrag triggering threshold is 64K for uncompressed write and
16K for compressed write, while the default defrag extent threshold is
256K).

This can lead to unexpected high IO.

This behavior is fixed by the upcoming patch, titled "btrfs: reduce
extent threshold for autodefrag".

This patch will add test case to verify the behavior by:

- Creating a file with mixed extent size.
  File offset 0 ~ 64K will be filled with two 32K extents, which should
  be defragged.
  While file offset 64K ~ 196K will be filled with two 64K extent,
  which should not be defragged.

- Trigger autodefrag

- Check if extent at offset 0 and offset 64K get defragged.

- Verify the checksum

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/262     | 102 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/262.out |   2 +
 2 files changed, 104 insertions(+)
 create mode 100755 tests/btrfs/262
 create mode 100644 tests/btrfs/262.out

diff --git a/tests/btrfs/262 b/tests/btrfs/262
new file mode 100755
index 00000000..5317576c
--- /dev/null
+++ b/tests/btrfs/262
@@ -0,0 +1,102 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 262
+#
+# Make sure btrfs autodefrag only defrag writes smaller than 64KiB
+# (which is considered as small writes)
+# This behavior will be introduced to v5.17 and backported to v5.16
+#
+# While older kernels (v5.15 and older) will not obey the threshold
+# but always use default threshold (256K) instead.
+#
+. ./common/preamble
+_begin_fstest defrag quick
+
+# Override the default cleanup function.
+# _cleanup()
+# {
+# 	cd /
+# 	rm -r -f $tmp.*
+# }
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+_require_xfs_io_command "fiemap" "ranged"
+
+# Needs 4K sectorsize, for larger sectorsize like 64K, no write will be
+# considered as small writes then.
+_require_btrfs_support_sectorsize 4096
+
+_scratch_mkfs -s 4k >> $seqres.full 2>&1
+
+# Need datacow to make the defragged extents to have different bytenr
+_scratch_mount -o datacow,autodefrag
+
+# Create the following file layout
+# 0       32K     64K     96K     128K     160K      192K
+# | Ext 1 | Ext 2 |     Ext 3     |       Ext 4      |
+#
+# Ext 1 and Ext 2 will be defragged as they are smaller than the 64K threshold
+# But Ext 3 and Ext 4 should not be defragged.
+$XFS_IO_PROG -f -s -c "pwrite -b 32K 0 64k" -c "pwrite -b 64K 64K 128K" \
+	"$SCRATCH_MNT/foobar" >> $seqres.full
+
+# Get the logical bytenr of Ext 1 and Ext 3
+old_ext1=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
+old_ext3=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 65536)
+
+old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
+echo "=== File extent layout before autodefrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+echo "old md5=$old_csum" >> $seqres.full
+
+# Now trigger autodefrag, autodefrag is triggered in the cleaner thread,
+# which will be woken up by commit thread
+_scratch_remount commit=1
+sleep 3
+
+# At remount time we may already trigger autodefrag, but if it didn't get
+# triggered, that sleep 3 will trigger autodefrag, and only mark the
+# target range dirty. We need to write back those ranges to reflect the
+# extent logical bytenr change.
+sync
+
+
+new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
+new_ext1=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
+new_ext3=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 65536)
+
+echo "=== File extent layout after autodefrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+echo "new md5=$new_csum" >> $seqres.full
+
+# Ext 1 should be defragged on all kernels
+if [ "$new_ext1" == "$old_ext1" ]; then
+	echo "The extent at offset 0 didn't get defragged"
+fi
+
+# Ext 3 should not be defragged on v5.17 and backported v5.16.
+# But older kernels (v5.15 and older) will not respect the small write
+# extent size threshold, and defrag them.
+if [ "$new_ext3" != "$old_ext3" ]; then
+	echo "The extent at offset 64K get defragged"
+fi
+
+# Defrag should not change file content
+if [ "$new_csum" != "$old_csum" ]; then
+	echo "file content changed"
+fi
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/262.out b/tests/btrfs/262.out
new file mode 100644
index 00000000..404badc3
--- /dev/null
+++ b/tests/btrfs/262.out
@@ -0,0 +1,2 @@
+QA output created by 262
+Silence is golden
-- 
2.34.1

