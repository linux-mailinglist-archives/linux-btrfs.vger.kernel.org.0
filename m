Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3776E17DEDC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 12:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCILmr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 07:42:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44922 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCILmr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 07:42:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029BdEsp161760;
        Mon, 9 Mar 2020 11:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=xgzy9XpcKJkgUCl2uDoF5VYzTNvaxft1p+bO6vebv5c=;
 b=TI+1CtZU7/oByAm7ZlQzimuD2sQVTZFZt74B9fgiajAKI95d3xlu8oeuLYX0+GdZEEKe
 dgGPXcEKjar+j88hX+kKo1VV1hu+4cxHuxrU14y8tz2tB4BQqmAn/vw2kXn0F/lN5wXY
 Bi5rfugV71q6oDEUZdgtIPD7HTloyQMQrO/mQYI339/gdCjeVA8mcjGftt3STmwdcPRH
 PmIPxBVdHvqbn066G6DPgPERQcj4NcjG7w+NMkSYEhmZ9fhWH1vpadZOUmSVPnfdXStC
 lKqo5mHFFrSnjWUp0QM6IBV7FAC87sL/TYm0Eg2ovlaWX7r0DZA4eSmlVU4uFH3hj7TG ig== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ym48spbmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 11:42:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 029BaphJ001911;
        Mon, 9 Mar 2020 11:40:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2ymnays4kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Mar 2020 11:40:45 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 029BeiNf011377;
        Mon, 9 Mar 2020 11:40:44 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Mar 2020 04:40:44 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fstests: btrfs/177 fix for nodesize 64K and type single
Date:   Mon,  9 Mar 2020 19:40:36 +0800
Message-Id: <20200309114036.5266-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200309114036.5266-1-anand.jain@oracle.com>
References: <20200309114036.5266-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9554 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=38 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003090082
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9554 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=38 priorityscore=1501 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090082
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the blockgroup type single with nodesize 64K, the relocation of the bg
containing the swapfile is not being attempted during the resize. So due
to this the resize is successful and does not generate the required
'Text file busy' error message as in the golden output and so the testcase
fails.

Fix this by replacing the mkfs created chunk with the bigger kernel created
chunk using balance, and then fill it up to the full. Upsize to 3x of fssize
once instead of first to 2G and then to 3G. Also drop the unnecessary downsize
to 2G step.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/177     | 34 +++++++++++++++++++++++-----------
 tests/btrfs/177.out |  6 ++----
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/tests/btrfs/177 b/tests/btrfs/177
index a627c2ab1666..67f8dbc1a590 100755
--- a/tests/btrfs/177
+++ b/tests/btrfs/177
@@ -39,30 +39,42 @@ devsize=$(blockdev --getsize64 $SCRATCH_DEV)
 [ "$devsize" -lt "$minsize" ] && \
 	_notrun "Scratch device $SCRATCH_DEV $devsize must be at least $minsize"
 
-# First, create a 1GB filesystem and fill it up.
-_scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
+# First, create a 1GB filesystem.
+fssize=$((1024 * 1024 * 1024))
+_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
 _scratch_mount
-dd if=/dev/zero of="$SCRATCH_MNT/fill" bs=1024k >> $seqres.full 2>&1
-# Now add more space and create a swap file. We know that the first 1GB of the
-# filesystem was used, so the swap file must be in the new part of the
+
+# Create a small file and run balance so we shall deal with the chunk
+# size as allocated by the kernel, mkfs allocated chunks are smaller.
+dd if=/dev/zero of="$SCRATCH_MNT/fill" bs=4096 count=1 >> $seqres.full 2>&1
+_run_btrfs_balance_start "$SCRATCH_MNT"
+
+# Now fill it up.
+dd if=/dev/zero of="$SCRATCH_MNT/refill" bs=4096 >> $seqres.full 2>&1
+
+# Now add more space and create a swap file. We know that the first $fssize
+# of the filesystem was used, so the swap file must be in the new part of the
 # filesystem.
-$BTRFS_UTIL_PROG filesystem resize 2G "$SCRATCH_MNT" | _filter_scratch
+$BTRFS_UTIL_PROG filesystem resize $((3 * fssize)) "$SCRATCH_MNT" | \
+							_filter_scratch
 _format_swapfile "$swapfile" $((32 * 1024 * 1024))
 swapon "$swapfile"
-# Add even more space which we know is unused.
-$BTRFS_UTIL_PROG filesystem resize 3G "$SCRATCH_MNT" | _filter_scratch
+
 # Free up the first 1GB of the filesystem.
 rm -f "$SCRATCH_MNT/fill"
+rm -f "$SCRATCH_MNT/refill"
+
 # Get rid of empty block groups and also make sure that balance skips block
 # groups containing active swap files.
 _run_btrfs_balance_start "$SCRATCH_MNT"
-# Shrink away the unused space.
-$BTRFS_UTIL_PROG filesystem resize 2G "$SCRATCH_MNT" | _filter_scratch
+
 # Try to shrink away the area occupied by the swap file, which should fail.
 $BTRFS_UTIL_PROG filesystem resize 1G "$SCRATCH_MNT" 2>&1 | grep -o "Text file busy"
+
 swapoff "$swapfile"
+
 # It should work again after swapoff.
-$BTRFS_UTIL_PROG filesystem resize 1G "$SCRATCH_MNT" | _filter_scratch
+$BTRFS_UTIL_PROG filesystem resize $fssize "$SCRATCH_MNT" | _filter_scratch
 
 status=0
 exit
diff --git a/tests/btrfs/177.out b/tests/btrfs/177.out
index 6ced01da9f61..63aca0e5362d 100644
--- a/tests/btrfs/177.out
+++ b/tests/btrfs/177.out
@@ -1,6 +1,4 @@
 QA output created by 177
-Resize 'SCRATCH_MNT' of '2G'
-Resize 'SCRATCH_MNT' of '3G'
-Resize 'SCRATCH_MNT' of '2G'
+Resize 'SCRATCH_MNT' of '3221225472'
 Text file busy
-Resize 'SCRATCH_MNT' of '1G'
+Resize 'SCRATCH_MNT' of '1073741824'
-- 
2.18.1

