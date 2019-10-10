Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D36D20A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 08:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfJJGOG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 02:14:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:60194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726664AbfJJGOG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 02:14:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27E85AF13
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2019 06:14:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/15[78]: Detect non-raid6 data chunks before doing the test
Date:   Thu, 10 Oct 2019 14:13:56 +0800
Message-Id: <20191010061356.28237-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When certain older mkfs.btrfs is used, btrfs/157 and btrfs/158 fails like
below:

  btrfs/157 2s ... - output mismatch (see xfstests-dev/results//btrfs/157.out.bad)
      --- tests/btrfs/157.out     2019-07-22 14:13:44.653333326 +0800
      +++ results//btrfs/157.out.bad      2019-10-10 13:58:58.625454478 +0800
      @@ -1,8 +1,9 @@
       QA output created by 157
       wrote 131072/131072 bytes at offset 0
       XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
      -wrote 65536/65536 bytes at offset 9437184
      -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
      +non-numeric offset argument -- 13631488
      +1048576
      ...

[CAUSE]
Btrfs/157 assumes there is only one RADI6 data chunk, and uses the
following grep to find the only RAID6 data chunk:

  $BTRFS_UTIL_PROG ins dump-tree -t 3 $SCRATCH_DEV |
  grep " DATA\|RAID6"

However that grep line can also matches SINGLE data profile. For older
mkfs which doesn't cleanup the SINGLE temporary chunks, it will cause
several lines of output, and screw up the output of
get_physical_stripe0()

[FIX]
Add an extra filter, check_data_chunk_profile() to make sure there is
only 1 data chunk and only 1 raid6 data chunk.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Currently it will skip the test if the assumption is not met, but in fact
the original failure detects a bug in my modification of mkfs.btrfs.

so I'm not completely sure if I should _fail or _notrun.
---
 tests/btrfs/157 | 14 ++++++++++++++
 tests/btrfs/158 | 14 ++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 7f75c407..78dcea21 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -51,6 +51,19 @@ _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_fs_feature raid56
 
+# Older mkfs.btrfs or regression could create SINGLE temporary chunks
+# Detect those before they screw up get_physical_stripe*() functions
+check_data_chunk_profile()
+{
+	nr_data_chunks=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 \
+		$SCRATCH_DEV | grep "type DATA" | wc -l)
+	nr_raid6_data_chunks=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 \
+		$SCRATCH_DEV | grep "type DATA.RAID6" | wc -l)
+	if [ $nr_data_chunks -ne $nr_raid6_data_chunks -o $nr_data_chunks -ne 1 ]; then
+		_notrun "non-raid6 data chunk detected"
+	fi
+}
+
 get_physical_stripe0()
 {
 	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
@@ -82,6 +95,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
 
 _scratch_unmount
 
+check_data_chunk_profile
 stripe_0=`get_physical_stripe0`
 stripe_1=`get_physical_stripe1`
 dev4=`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index 603e8bea..441a33e8 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -43,6 +43,19 @@ _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_fs_feature raid56
 
+# Older mkfs.btrfs or regression could create SINGLE temporary chunks
+# Detect those before they screw up get_physical_stripe*() functions
+check_data_chunk_profile()
+{
+	nr_data_chunks=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 \
+		$SCRATCH_DEV | grep "type DATA" | wc -l)
+	nr_raid6_data_chunks=$($BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 \
+		$SCRATCH_DEV | grep "type DATA.RAID6" | wc -l)
+	if [ $nr_data_chunks -ne $nr_raid6_data_chunks -o $nr_data_chunks -ne 1 ]; then
+		_notrun "non-raid6 data chunk detected"
+	fi
+}
+
 get_physical_stripe0()
 {
 	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
@@ -74,6 +87,7 @@ $XFS_IO_PROG -f -d -c "pwrite -S 0xaa 0 128K" -c "fsync" \
 
 _scratch_unmount
 
+check_data_chunk_profile
 stripe_0=`get_physical_stripe0`
 stripe_1=`get_physical_stripe1`
 dev4=`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
-- 
2.22.0

