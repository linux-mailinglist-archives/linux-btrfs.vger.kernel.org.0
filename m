Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7303B17EF97
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 05:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCJEWn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 00:22:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57176 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgCJEWm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 00:22:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A4MfQM010484;
        Tue, 10 Mar 2020 04:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=x5H/FiFzNPu50ioZuu49isBRRkJTQ0/Ea+N4oqG3+xw=;
 b=TrtPnXJM8QOgBv4XHI6QUiP6nMBnoTMB6FRDHDbEyxIHxzxU71L53aKC0Pe/Xsbxfo0r
 cj1jyq4tjqlZuJt4M3J5nztnKVUMvT2GDtpHuh5y4T38Jh8csl79PprCoAYK4T6fd9WA
 sp+4Vh7NCO7QDeNEtqzl3QDc4KVGV2IxTuyjzpTpcEVBKMXoDSA10LBCOXgNO2/aY0sq
 m8vedk+BCZnUESS/uEXbcGHlB/wknyAxy9Cl4mdlvPrqligZ/6PLHjOgRhBUp7DYs5hQ
 +Lma4/RPTIe2vSlm5sFG//BSDG2sXqiCbtW2GNUmTafjPniEghmHC1k0i7am6Zj2jzvi Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ym31uat0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 04:22:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02A4GtQw008912;
        Tue, 10 Mar 2020 04:22:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2ymnb2gcju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 04:22:41 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02A4MeB6025279;
        Tue, 10 Mar 2020 04:22:40 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Mar 2020 21:22:40 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] fstests: btrfs/177 fix for nodesize 64K and type single
Date:   Tue, 10 Mar 2020 12:22:32 +0800
Message-Id: <1583814152-15603-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20200309114036.5266-3-anand.jain@oracle.com>
References: <20200309114036.5266-3-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=38 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=38
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100029
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
no change, just fix conflict with the v2 1/2 patch changes

 tests/btrfs/177     | 34 +++++++++++++++++++++++-----------
 tests/btrfs/177.out |  6 ++----
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/tests/btrfs/177 b/tests/btrfs/177
index f7c2436ee7e4..69b9a539500a 100755
--- a/tests/btrfs/177
+++ b/tests/btrfs/177
@@ -36,30 +36,42 @@ swapfile="$SCRATCH_MNT/swap"
 
 _require_scratch_size $((3 * 1024 * 1024)) #kB
 
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
1.8.3.1

