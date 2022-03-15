Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E704D9ACD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 13:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348127AbiCOMBw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 08:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348128AbiCOMBv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 08:01:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EFA52B31;
        Tue, 15 Mar 2022 05:00:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A25A91F391;
        Tue, 15 Mar 2022 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647345638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=69C8m+2kMy+wXHvAY++o/bQMj/PPOmUYdZehTfuze6Y=;
        b=NwdbHFZ1B7sogFEWdlZerRLDIWGwa1QWji6icvFsRRMZ1nqOsIVqSOtASyPLR4hKQ/YSqC
        0DI6YsQi6GcQwMP4jnrFoqR0w/NPUVbYJ6sw7d/EBAmuD1xyLNIwj7aEx6QWcw8Nx/UszB
        eb+BX0cwb3L/TWbRne67TNi6+yMFyCM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87EAF13B59;
        Tue, 15 Mar 2022 12:00:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6Gj9E+V/MGKHRgAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 15 Mar 2022 12:00:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: test that autdodefrag does not rewrite single extents
Date:   Tue, 15 Mar 2022 20:00:20 +0800
Message-Id: <20220315120020.68874-1-wqu@suse.com>
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

There is a report that btrfs autodefrag is defragging extents which only
have one single sector.

Such defragging will not reduce the number of extents, but only waste
IO.

The fix for it is titled:

  btrfs: avoid defragging extents whose next extents are not targets

Here we add a test case, which will create an inode with the following
layout:

  0                16K   20K                  64K
  |<-- Extent A -->|<-B->|<----- Extent C --->|
  |Gen 7           |Gen 9|Gen 7               |

And we trigger autodefrag with newer_than = 8, which means it will only
defrag extents newer than or equal to generation 8.

Currently only Extent B meets the condition, but it can not be merged
with Extent A nor Extent C, as they don't meet the generation 
requirement.

Unpatched kernel will defrag only Extent B, resulting no change in
fragmentation, while costs extra IO.

Patched kernel will not defrag anything.

Although this is still not the ideal case, as we can defrag the whole
64K range, but that's not what autodefrag can do with its generation 
limitation.

And such "perfect" defrag can cause way more IO than some users can
stand.

At least we should not only defrag extent B.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
Changelog:
v2:
- Use short and less confusing subject
- Remove unused _cleanup() override
- End every sentence with punctuation in comments
- Remove unnecessary -f option for xfs_io
- Fix the spell of "generation"
---
 tests/btrfs/262     | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/262.out |  2 +
 2 files changed, 94 insertions(+)
 create mode 100755 tests/btrfs/262
 create mode 100644 tests/btrfs/262.out

diff --git a/tests/btrfs/262 b/tests/btrfs/262
new file mode 100755
index 00000000..a25a588a
--- /dev/null
+++ b/tests/btrfs/262
@@ -0,0 +1,92 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 262
+#
+# Make sure btrfs autodefrag will not defrag ranges which won't reduce
+# defragmentation.
+#
+. ./common/preamble
+_begin_fstest auto quick defrag
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
+# Needs fixed 4K sector size, or the file layout will not match the expected
+# result.
+_require_btrfs_support_sectorsize 4096
+
+_scratch_mkfs >> $seqres.full
+
+_scratch_mount -o noautodefrag
+
+# Create the initial layout, with a large 64K extent for later fragments.
+$XFS_IO_PROG -f -c "pwrite 0 64K" -c sync "$SCRATCH_MNT/foobar" >> $seqres.full
+
+# Need to bump the generation by one, as autodefrag uses the last modified
+# generation of a subvolume. Without this generation bump, autodefrag will
+# defrag the whole file, not only the new write.
+touch "$SCRATCH_MNT/trash"
+sync
+
+# Remount to autodefrag.
+_scratch_remount autodefrag
+
+# Write a new sector, which should trigger autodefrag.
+$XFS_IO_PROG -c "pwrite 16K 4K" -c sync "$SCRATCH_MNT/foobar" >> $seqres.full
+
+echo "=== File extent layout before autodefrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+
+old_csum=$(_md5_checksum "$SCRATCH_MNT/foobar")
+old_ext_0=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
+old_ext_16k=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 16384)
+old_ext_20k=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 20480)
+
+# Trigger autodefrag.
+_scratch_remount commit=1
+sleep 3
+# Make sure the defragged range reach disk.
+sync
+
+echo "=== File extent layout after autodefrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+
+new_csum=$(_md5_checksum "$SCRATCH_MNT/foobar")
+new_ext_0=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
+new_ext_16k=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 16384)
+new_ext_20k=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 20480)
+
+# For extent at offset 0 and 20K, they are older than the target generation,
+# thus they should not be defragged.
+if [ "$new_ext_0" != "$old_ext_0" ]; then
+	echo "extent at offset 0 got defragged"
+fi
+if [ "$new_ext_20k" != "$old_ext_20k" ]; then
+	echo "extent at offset 20K got defragged"
+fi
+
+# For extent at offset 4K, it's a single sector, and its adjacent extents
+# are not targets, thus it should not be defragged.
+if [ "$new_ext_16k" != "$old_ext_16k" ]; then
+	echo "extent at offset 16K got defragged"
+fi
+
+# Defrag should not change file content.
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

