Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC44B497006
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Jan 2022 06:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbiAWFbx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Jan 2022 00:31:53 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35220 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiAWFbx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Jan 2022 00:31:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1D37C1F37B;
        Sun, 23 Jan 2022 05:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642915912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1eZVh3ZGuWWfWbzVUHJJU26MZGoSKs6qim5mP+THHzY=;
        b=NPRrUls6QWK/59CBeT01y9JNlaZ5Nb0ijG+XfR50fdJBvN3LIDDZPKjNivQOLYPqXvAoIT
        9Pqrwoz+D/rHhsWmpQii1LLT9m+MIbKlTkawoy8TdN5sjlTvpve8AWvxjKxZp4FukaQ82a
        9i3VpopR8MOUw3VpLsDboJiztVR7Hx4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C31A132C2;
        Sun, 23 Jan 2022 05:31:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jIlKOUbo7GEjRgAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 23 Jan 2022 05:31:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add test to verify the defrag behavior around preallocated extents
Date:   Sun, 23 Jan 2022 13:31:33 +0800
Message-Id: <20220123053133.26664-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recent v5.16 has some regression around btrfs autodefrag mount option,
and the extra scrutiny around defrag code exposes some questionable
behavior from the old code.

One behavior is to defrag extents along with the next preallocated
extent.

This behavior will cause extra IO and convert all the preallocated
extent to regular zero filled extents, rendering the preallocated extent
useless.

The kernel fix is titled:

  btrfs: defrag: don't try to merge regular extents with preallocated extents

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/255     | 81 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/255.out |  2 ++
 2 files changed, 83 insertions(+)
 create mode 100755 tests/btrfs/255
 create mode 100644 tests/btrfs/255.out

diff --git a/tests/btrfs/255 b/tests/btrfs/255
new file mode 100755
index 00000000..3d952c1f
--- /dev/null
+++ b/tests/btrfs/255
@@ -0,0 +1,81 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 255
+#
+# Make sure btrfs doesn't defrag preallocated extents, nor lone extents
+# before preallocated extents.
+#
+
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
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_require_scratch
+
+get_extent_disk_sector()
+{
+	local file=$1
+	local offset=$2
+
+	$XFS_IO_PROG -c "fiemap $offset" "$file" | _filter_xfs_io_fiemap |\
+	       	head -n1 | awk '{print $3}'
+}
+# Needs 4K sectorsize
+_scratch_mkfs -s 4k >> $seqres.full 2>&1
+
+# Need datacow to make the defragged extents to have different bytenr
+_scratch_mount -o datacow
+
+# Create a file with the following layout:
+# 0       4K        8K        16K
+# |<- R ->|<-- Preallocated ->|
+# R is regular extents.
+#
+# In this case it makes no sense to defrag any extent.
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c sync -c "falloc 4k 12k" \
+	"$SCRATCH_MNT/foobar" >> $seqres.full
+
+echo "=== Initial file extent layout ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+
+# Save the bytenr of both extents
+old_regular=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
+old_prealloc=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 4096)
+
+# Now defrag and write the defragged range back to disk
+$BTRFS_UTIL_PROG filesystem defrag "$SCRATCH_MNT/foobar" >> $seqres.full
+sync
+
+echo "=== File extent layout after defrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+
+new_regular=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
+new_prealloc=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 4096)
+
+if [ "$old_regular" -ne "$new_regular" ]; then
+	echo "the single lone sector get defragged"
+fi
+if [ "$old_prealloc" -ne "$new_prealloc" ]; then
+	echo "the preallocated extent get defragged"
+fi
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/255.out b/tests/btrfs/255.out
new file mode 100644
index 00000000..7eefb828
--- /dev/null
+++ b/tests/btrfs/255.out
@@ -0,0 +1,2 @@
+QA output created by 255
+Silence is golden
-- 
2.34.1

