Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC3A41BBE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 02:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbhI2Aqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 20:46:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41482 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243396AbhI2Aqp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 20:46:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3C2F1FDAD;
        Wed, 29 Sep 2021 00:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632876304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8GiJTcCWiJ7fVQPubzu3LTO3SDn3OOa0wRSBJ8T9Bcw=;
        b=stEv3HoI4LHX5MV0U3sIpN+KNkHh2WLcswkZnbsUWryMlzqdguWj535B/iO6Qlbw8jplJP
        D7WUZ1MZwLm1wlKwfdaEKQNfz5Z8UY7PQeQzP/snXn0mFKfUX34EKv/OL53jQrQRhnJ69E
        L5EYN67YjwoALTLdXFP6ekVWvtoo4Zw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E02C213EB4;
        Wed, 29 Sep 2021 00:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R7PfKQ+3U2FKVQAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 29 Sep 2021 00:45:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/248: test if btrfs receive can handle clone command on inodes with different NODATASUM flags
Date:   Wed, 29 Sep 2021 08:44:46 +0800
Message-Id: <20210929004446.12654-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The planned fix is titled "btrfs-progs: receive: fallback to buffered
copy if clone failed".

The test case itself will create two send streams, and the 2nd stream is
an incremental stream with a clone command in it.

Using different mount options we are able to create a situation where
clone source and destination have different NODATASUM flags, which is
prohibited inside btrfs.

The planned fix will make btrfs receive to fall back to buffered write
to copy the data from the source file.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/248     | 74 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/248.out |  2 ++
 2 files changed, 76 insertions(+)
 create mode 100755 tests/btrfs/248
 create mode 100644 tests/btrfs/248.out

diff --git a/tests/btrfs/248 b/tests/btrfs/248
new file mode 100755
index 00000000..964d3e85
--- /dev/null
+++ b/tests/btrfs/248
@@ -0,0 +1,74 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 248
+#
+# Make sure btrfs receive can still handle clone stream even if the source
+# and destination has different NODATASUM flags
+#
+. ./common/preamble
+_begin_fstest quick send
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
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
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount -o datasum
+
+# Create the initial subvolume with a file
+$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/parent >> $seqres.full
+$XFS_IO_PROG -f -c "pwrite 0 1m" $SCRATCH_MNT/parent/source \
+	> /dev/null
+sync
+$BTRFS_UTIL_PROG prop set $SCRATCH_MNT/parent ro true
+$BTRFS_UTIL_PROG send -q $SCRATCH_MNT/parent -f $tmp.parent_stream
+_scratch_unmount
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount -o datasum
+
+# Then create a new subvolume with cloned file from above send stream
+$BTRFS_UTIL_PROG receive -q -f $tmp.parent_stream $SCRATCH_MNT
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/parent $SCRATCH_MNT/dest \
+	>> $seqres.full
+$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/parent/source 4k 0 128K" \
+	$SCRATCH_MNT/dest/new > /dev/null
+$BTRFS_UTIL_PROG prop set $SCRATCH_MNT/dest ro true
+$BTRFS_UTIL_PROG send -q $SCRATCH_MNT/dest -p $SCRATCH_MNT/parent \
+	-f $tmp.clone_stream
+
+_scratch_unmount
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount -o datasum
+
+# Now try to receive both streams
+$BTRFS_UTIL_PROG receive -q -f $tmp.parent_stream $SCRATCH_MNT/
+
+# Remount to NODATASUM, so that the 2nd stream will get all its inodes to have
+# NODATASUM flags due to mount option
+_scratch_remount nodatasum
+
+# Patched receive may warn about the clone failure, so here we redirect all
+# output
+$BTRFS_UTIL_PROG receive -q -f $tmp.clone_stream $SCRATCH_MNT/ \
+	>> $seqres.full 2>&1
+
+# We check the destination file's csum to verify if the clone is done properly
+_md5_checksum $SCRATCH_MNT/dest/new
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/248.out b/tests/btrfs/248.out
new file mode 100644
index 00000000..b49cfad7
--- /dev/null
+++ b/tests/btrfs/248.out
@@ -0,0 +1,2 @@
+QA output created by 248
+d48858312a922db7eb86377f638dbc9f
-- 
2.33.0

