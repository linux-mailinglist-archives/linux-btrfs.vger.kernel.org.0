Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35A577AD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Jul 2022 08:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiGRGTR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Jul 2022 02:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiGRGSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Jul 2022 02:18:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A54EE083;
        Sun, 17 Jul 2022 23:18:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 96D031F37C;
        Mon, 18 Jul 2022 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658125122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8VXF2PFckDcBGR8Rxa3Ic4eso0ozHqOE6T4Vho0+3AY=;
        b=iqkCaUpuT/Bg+xi9J2ctzLKOG+qwwVg5NI5md6uSEsAFUD27pIzHfUmqTkG8awMmeptMfr
        8oyNNOy4KyLHzQDtjjELnxpFrjj5lvXpMdo7A9UPdhd/LkNae+x17mHqBJve88bDgzelWV
        WZxN+sh5/2i6CtsGySs7gsz7qhOGZdc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7165513754;
        Mon, 18 Jul 2022 06:18:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CcYxDkH71GKKWAAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 18 Jul 2022 06:18:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCH RFC] fstests: btrfs: add a tests case to make sure btrfs can handle certain interleaved free space correctly
Date:   Mon, 18 Jul 2022 14:18:23 +0800
Message-Id: <20220718061823.26147-1-wqu@suse.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a future-proof test mostly for future zoned raid-stripe-tree
(RST) and P/Q COW based RAID56 implementation.

Unlike regular devices, zoned device can not do overwrite without
resetting (reclaim) a whole zone.

And for the RST and P/Q COW based RAID56, the idea is to CoW the parity
stripe to other location.

But all above behaviors introduce some limitation, if we fill the fs,
then free half of the space interleaved.

- For basic zoned btrfs (aka SINGLE profile for now)
  Normally this means we have no free space at all.

  Thankfully zoned btrfs has GC and reserved zones to reclaim those
  half filled zones.
  In theory we should be able to do new writes.

- For future RST with P/Q CoW for RAID56, on non-zoned device.
  This is more complex, in this case, we should have the following
  full stripe layout for every full stripe:
          0                           64K
  Disk A  |XXXXXXXXXXXXXXXXXXXXXXXXXXX| (Data 1)
  Disk B  |                           | (Data 2)
  Disk C  |XXXXXXXXXXXXXXXXXXXXXXXXXXX| (P stripe)

  Although in theory we can write into Disk B, but we have to find
  a free space for the new Parity.

  But all other full stripe are like this, which means we're deadlocking
  to find a pure free space without sub-stripe writing.

  This means, even for non-zoned btrfs, we still need GC and reserved
  space to handle P/Q CoW properly.

Another thing specific to this test case is, to reduce the runtime, I
use 256M as the mkfs size for each device.
(A full run with KASAN enabled kernel already takes over 700 seconds)

So far this can only works for non-zoned disks, as 256M is too small for
zoned devices to have enough zones.

Thus need extra advice from zoned device guys.

Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/261     | 129 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/261.out |   2 +
 2 files changed, 131 insertions(+)
 create mode 100755 tests/btrfs/261
 create mode 100644 tests/btrfs/261.out

diff --git a/tests/btrfs/261 b/tests/btrfs/261
new file mode 100755
index 00000000..01da4759
--- /dev/null
+++ b/tests/btrfs/261
@@ -0,0 +1,129 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 261
+#
+# Make sure all supported profiles (including future zoned RAID56) have proper
+# way to handle fs with interleaved filled space, and can still write data
+# into the fs.
+#
+# This is mostly inspired by some discussion on P/Q COW for RAID56, even for
+# regular devices, this can be problematic if we fill the fs then delete
+# half of the extents interleavedly. Without proper GC and extra reserved
+# space, such CoW P/Q way should run out of space (even one data stripe is
+# free, there is no place to CoW its P/Q).
+#
+. ./common/preamble
+_begin_fstest auto enospc raid
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
+# we check scratch dev after each loop
+_require_scratch_nocheck
+_require_scratch_dev_pool 4
+
+fill_fs()
+{
+	for (( i = 0;; i += 2 )); do
+		$XFS_IO_PROG -f -c "pwrite 0 64K" $SCRATCH_MNT/file_$i \
+			&> /dev/null
+		if [ $? -ne 0 ]; then
+			break
+		fi
+		$XFS_IO_PROG -f -c "pwrite 0 64K" $SCRATCH_MNT/file_$(($i + 1)) \
+			&> /dev/null
+		if [ $? -ne 0 ]; then
+			break
+		fi
+
+		# Only sync after data 1M writes.
+		if [ $(( $i % 8)) -eq 0 ]; then
+			sync
+		fi
+	done
+
+	# Sync what hasn't yet synced.
+	sync
+	
+	echo "fs filled with $i full stripe write" >> $seqres.full
+
+	# Delete half of the files created above, which should leave
+	# the fs half empty. For RAID56 this would leave all of its full
+	# stripes to be have one full data stripe, one free data stripe,
+	# and one P/Q stripe still in use.
+	rm -rf -- $SCRATCH_MNT/file_*[02468]
+	
+	# Sync to make sure above deleted files really got freed.
+	sync
+}
+
+run_test()
+{
+	local profile=$1
+	local nr_dev=$2
+
+	echo "=== profile=$profile nr_dev=$nr_dev ===" >> $seqres.full
+	_scratch_dev_pool_get $nr_dev
+	# -b is for each device.
+	# Here we use 256M to reduce the runtime.
+	_scratch_pool_mkfs -b 256M -m$profile -d$profile >>$seqres.full 2>&1
+	# make sure we created btrfs with desired options
+	if [ $? -ne 0 ]; then
+		echo "mkfs $mkfs_opts failed"
+		return
+	fi
+	_scratch_mount >>$seqres.full 2>&1
+
+	fill_fs
+
+	# Now try to write 4M data, with the fs half empty we should be
+	# able to do that.
+	# For zoned devices, this will test if the GC and reserved zones
+	# can handle such cases properly.
+	$XFS_IO_PROG -f -c "pwrite 0 4M" -c sync $SCRATCH_MNT/final_write \
+		>> $seqres.full 2>&1
+	if [ $? -ne 0 ]; then
+		echo "The final write failed"
+	fi
+
+	_scratch_unmount
+	# we called _require_scratch_nocheck instead of _require_scratch
+	# do check after test for each profile config
+	_check_scratch_fs
+	echo  >> $seqres.full
+	_scratch_dev_pool_put
+}
+
+# Here we don't use _btrfs_profile_configs as that doesn't include
+# the number of devices, but for full stripe writes for RAID56, we
+# need to ensure nr_data must be 2, so here we manually specify
+# the profile and number of devices.
+run_test "single" "1"
+
+# Zoned only support
+if _scratch_btrfs_is_zoned; then
+	exit
+fi
+
+run_test "raid0" "2"
+run_test "raid1" "2"
+run_test "raid10" "4"
+run_test "raid5" "3"
+run_test "raid6" "4"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
new file mode 100644
index 00000000..679ddc0f
--- /dev/null
+++ b/tests/btrfs/261.out
@@ -0,0 +1,2 @@
+QA output created by 261
+Silence is golden
-- 
2.36.1

