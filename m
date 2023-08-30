Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2B78D1FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Aug 2023 04:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbjH3CSW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 22:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbjH3CST (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 22:18:19 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1491AD;
        Tue, 29 Aug 2023 19:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693361897; x=1724897897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ks9e/tRRdXM6krWamnXsUSnBwLfPqfAeEqt3PUES7+A=;
  b=WnwQuJKMnbRJ8Y2O7w4AJ9MEEwhPooHmHUjC5Oxw4gQ6fZ9gy+yba9al
   F8DctaPT3aaIKQ+HepYkJ7rOnKuQIrA/4lpDSllDY2xCZpOBjeJ1QEz+z
   vT5CvyErTGIVhATvy+fnq+B9pKmSzdMNabW1cWNlPAsiBCpysuFJbmQ/P
   e6rvAB0sELA3z/9WsIislsir7uzwuRzrxN3xj373mMBgslHCUj96/0f68
   k3erpHjACcSYYDTQZZoMZwCCsHvThVDUqu0Oujqo/pk9UTFdzH9F73IBA
   kkpvYoaDWzI48jWfX6LUGPbMKEMh6Ftmgp1KEbSin2A18EslErLl/M2eA
   w==;
X-IronPort-AV: E=Sophos;i="6.02,212,1688400000"; 
   d="scan'208";a="242419704"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2023 10:18:17 +0800
IronPort-SDR: 6p5UotrpZ8a6WfQYoIyuEUPo36Wc7eWYx9X7F+G9r4Yn2H76icn9c2/dueq1AD3TFX3srPxz6x
 v+Ac8P/2nbo7/yDU+PmXc8SwmxY4/lpMIN9F06SzjGRSA6U9P4xK9uxrZj5pZCfYQcZ9/tMtv3
 JalKtrZyPfmQH1iKtfR+P3ViTU+DqPBmLrQ9WNqIhSmBtpw10Orj2Jw9NBfbFTNKmxGBjmTgwY
 wWldCRztAkbwqxrOKhEByVa7onhlOdWIXl5uqYoqgOmUsg01a827PoPf38XMSeodg2xycWDCKj
 Pts=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Aug 2023 18:25:37 -0700
IronPort-SDR: ExWahclu4hSTFjK/6VwrdClY6hYrAo1h8NfLgHvqp0GDbS9YPhBNY1ACZ2kWyexXkS4+Mi5yr5
 aLbdJYuEf1qy0SfNCdgn9FH/iJuAZYv2d+cw1O5TlmUvT/WyYDvKGVFOGHp/9Fvtkdw0OiBh9h
 IqjeD0imXzXJfcphRcH+Y6LBfJaZJvXa5JE2A9uk4Gy8o/Xszh0pP8DBYpkvFxfgv5wxsKDxgy
 LsZ3ieD4I/yF2PGmVPdaFWQ1m2+5ib6EuDAmKZru7dM7eu9qn+3Fm8ecN3fh7mGp+iJl0jR3F4
 +OI=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.11])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Aug 2023 19:18:16 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs/237: kick reclaim process with a small filesystem
Date:   Wed, 30 Aug 2023 11:17:52 +0900
Message-ID: <20230830021752.2079166-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit 3687fcb0752a ("btrfs: zoned: make auto-reclaim less
aggressive"), the reclaim process won't run unless the 75% (by default) of
the filesystem volume is allocated as block groups. As a result, btrfs/237
won't success when it is run with a large volume.

To run the reclaim process, we need to either fill the FS to the desired
level, or make a small FS so that the test write can go over the level.

Since the current test code expects the FS has only one data block group,
filling the FS is both cumbersome and need effort to rewrite the test code.
So, we take the latter method. We create a small (16 * zone size) FS. The
size is chosen to hold a minimal FS with DUP metadata setup.

However, creating a small FS is not enough. With SINGLE metadata setup, we
allocate 3 zones (one for each DATA, METADATA and SYSTEM), which is less
than 75% of 16 zones. We can tweak the threshold to 51% on regular btrfs
kernel config (!CONFIG_BTRFS_DEBUG), but that is still not enough to start
the reclaim process. So, this test requires CONFIG_BTRFS_DEBUG to set the
threshold to 1%.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 tests/btrfs/237 | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/237 b/tests/btrfs/237
index 3c660edbe27d..367019b6025d 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -43,7 +43,16 @@ get_data_bg_physical()
 	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
 }
 
-_scratch_mkfs >/dev/null 2>&1
+sdev="$(_short_dev $SCRATCH_DEV)"
+zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
+fssize=$((zone_size * 16))
+devsize=$(($(_get_device_size $SCRATCH_DEV) * 1024))
+# Create a minimal FS to kick the reclaim process
+if [[ $devsize -gt $fssize ]]; then
+	_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
+else
+	_scratch_mkfs >> $seqres.full 2>&1
+fi
 _scratch_mount -o commit=1 # 1s commit time to speed up test
 
 uuid=$($BTRFS_UTIL_PROG filesystem show $SCRATCH_DEV |grep uuid: |\
@@ -59,7 +68,15 @@ start_data_bg_phy=$((start_data_bg_phy >> 9))
 size=$(_zone_capacity $start_data_bg_phy)
 
 reclaim_threshold=75
-echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
+if [[ -f /sys/fs/btrfs/"$uuid"/allocation/data/bg_reclaim_threshold ]]; then
+	fs_fill=1
+	echo $fs_fill > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold ||
+		_notrun "Need CONFIG_BTRFS_DEBUG to lower the reclaim threshold"
+	echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/allocation/data/bg_reclaim_threshold
+else
+	echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
+fi
+
 fill_percent=$((reclaim_threshold + 2))
 rest_percent=$((90 - fill_percent)) # make sure we're not creating a new BG
 fill_size=$((size * fill_percent / 100))
-- 
2.42.0

