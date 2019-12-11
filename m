Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A2811A15F
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 03:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfLKCdt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 21:33:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:38932 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727561AbfLKCdt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 21:33:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02C97ACD9;
        Wed, 11 Dec 2019 02:22:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: btrfs/157 btrfs/158: Prevent stripe offset to pollute golden output
Date:   Wed, 11 Dec 2019 10:22:06 +0800
Message-Id: <20191211022207.15359-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test btrfs/157 and btrfs/158 are verifying the repair functionality of
supported RAID profile, thus it needs to corrupt the fs data manually using
physical offset of data.

However that physical offset of data is dependent on chunk layout, which
is further dependent on mkfs, so such physical offset is never reliable.

And btrfs-progs commit c501c9e3b816 ("btrfs-progs: mkfs: match devid
order to the stripe index") changed the mkfs stripe layout, the golden
output no longer matches the output.

This patch will remove the physical offset from golden output,
especially since we already have those offsets output in seqres.full.

Reported-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/157     | 5 +++--
 tests/btrfs/157.out | 4 ----
 tests/btrfs/158     | 4 ++--
 tests/btrfs/158.out | 4 ----
 4 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 7f75c407..9895f1fd 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -90,8 +90,9 @@ dev3=`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
 # step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
 echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
 
-$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_xfs_io
-$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_xfs_io
+# These stripe offset is mkfs dependent, don't pollute golden output
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 > /dev/null
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 > /dev/null
 
 # step 3: read foobar to repair the bitrot
 echo "step 3......repair the bitrot" >> $seqres.full
diff --git a/tests/btrfs/157.out b/tests/btrfs/157.out
index 08d592c4..d69c0f1d 100644
--- a/tests/btrfs/157.out
+++ b/tests/btrfs/157.out
@@ -1,10 +1,6 @@
 QA output created by 157
 wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 9437184
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 9437184
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 0200000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
 *
 0400000
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index 603e8bea..99ee7fb7 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -82,8 +82,8 @@ dev3=`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
 # step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
 echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
 
-$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_xfs_io
-$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_xfs_io
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 > /dev/null
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 > /dev/null
 
 # step 3: scrub filesystem to repair the bitrot
 echo "step 3......repair the bitrot" >> $seqres.full
diff --git a/tests/btrfs/158.out b/tests/btrfs/158.out
index 1f5ad3f7..95562f49 100644
--- a/tests/btrfs/158.out
+++ b/tests/btrfs/158.out
@@ -1,10 +1,6 @@
 QA output created by 158
 wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 9437184
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 9437184
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
 *
 0400000
-- 
2.23.0

