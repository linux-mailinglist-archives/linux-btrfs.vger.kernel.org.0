Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B344AD1FF
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Feb 2022 08:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347967AbiBHHOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Feb 2022 02:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347951AbiBHHOd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Feb 2022 02:14:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A706C0401EF;
        Mon,  7 Feb 2022 23:14:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15DB41F37C;
        Tue,  8 Feb 2022 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644304471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UpUyOCgCV9RMkwpOiIB8/DceVNHkGWBLbrsvzZgBKqs=;
        b=fb5AEXUXalkSeJ62RvuUh2U5eyelyjBUcTpivuEFjqoZbp62RsKfq5YW4VfWcxyoVpYJK6
        HvHltsGiMUT2amjA2kA/2y4D2xPxhVh0V6wSmowVsaIaLAxBUmEAompIFFehHDv5oB0DGo
        V29IPifKgdH8AZZzGiV2qGtr+hvZbCE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2330B13483;
        Tue,  8 Feb 2022 07:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nB24NlUYAmIjIQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 08 Feb 2022 07:14:29 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add test case to make sure autodefrag works even the extent maps are read from disk
Date:   Tue,  8 Feb 2022 15:14:27 +0800
Message-Id: <20220208071427.19171-1-wqu@suse.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a long existing problem that extent_map::generation is not
populated (thus always 0) if its read from disk.

This can prevent btrfs autodefrag from working as it relies on
extent_map::generation.
If it's always 0, then autodefrag will not consider the range as a
defrag target.

The test case itself will verify the behavior by:

- Create a fragmented file
  By writing backwards with OSYNC
  This will also queue the file for autodefrag.

- Drop all cache
  Including the extent map cache, meaning later read will
  all get extent map by reading from on-disk file extent items.

- Trigger autodefrag and verify the file layout
  If defrag works, the new file layout should differ from the original
  one.

The kernel fix is titled:

  btrfs: populate extent_map::generation when reading from disk

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/259     | 64 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/259.out |  2 ++
 2 files changed, 66 insertions(+)
 create mode 100755 tests/btrfs/259
 create mode 100644 tests/btrfs/259.out

diff --git a/tests/btrfs/259 b/tests/btrfs/259
new file mode 100755
index 00000000..577e4ce4
--- /dev/null
+++ b/tests/btrfs/259
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 259
+#
+# Make sure autodefrag can still defrag the file even their extent maps are
+# read from disk
+#
+. ./common/preamble
+_begin_fstest auto quick defrag
+
+# Override the default cleanup function.
+# _cleanup()
+# {
+# 	cd /
+# 	rm -r -f $tmp.*
+# }
+
+# Import common functions.
+# . ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+# Need 4K sectorsize, as the autodefrag threshold is only 64K,
+# thus 64K sectorsize will not work.
+_require_btrfs_support_sectorsize 4096
+_scratch_mkfs -s 4k >> $seqres.full
+_scratch_mount -o datacow,autodefrag
+
+# Create fragmented write
+$XFS_IO_PROG -f -s -c "pwrite 24k 8k" -c "pwrite 16k 8k" \
+		-c "pwrite 8k 8k" -c "pwrite 0 8k" \
+		"$SCRATCH_MNT/foobar" >> $seqres.full
+sync
+
+echo "=== Before autodefrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $tmp.before
+cat $tmp.before >> $seqres.full
+
+# Drop the cache (including extent map cache per-inode)
+echo 3 > /proc/sys/vm/drop_caches
+
+# Now trigger autodefrag
+_scratch_remount commit=1
+sleep 3
+sync
+
+echo "=== After autodefrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $tmp.after
+cat $tmp.after >> $seqres.full
+
+# The layout should differ if autodefrag is working
+diff $tmp.before $tmp.after > /dev/null && echo "autodefrag didn't defrag the file"
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/259.out b/tests/btrfs/259.out
new file mode 100644
index 00000000..bfbd2dea
--- /dev/null
+++ b/tests/btrfs/259.out
@@ -0,0 +1,2 @@
+QA output created by 259
+Silence is golden
-- 
2.34.1

