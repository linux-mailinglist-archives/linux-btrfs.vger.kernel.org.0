Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D261911A450
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2019 07:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfLKGIy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 01:08:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:36024 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfLKGIy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 01:08:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBB64QIq069348;
        Wed, 11 Dec 2019 06:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=pFCbrgRvpMm2+2ct2VRT8Y2KfthrNgk6Khmw7yk4e4E=;
 b=W6QgGjOJb31hi0J4Zh1Jj3E2R83lBvBjTAabxpojWuNkxFv8KuBAJA7aI8oj6gOcmOyk
 tvq3BIyB23sPIGAWmyC3jvu4a2pFTxydmh9m/N68aHk1TLrWuAG+BXdoopHdxleBYpTQ
 KF5Uny2oAkkLxuGlUsVcYDwasY8Fv8pe+kQVFiif3ZkK8E1i0R2dBdy4atQ4uGBQenoY
 Z9sw35+Mfj7psuE8MPfthZMCIzTHmNqT5xiHyWFmM9VGxLQZszg+/2gtKHjfgHtOvSXN
 XGkYAo0r3KDIDxkIRJZk0eG/Zq4/uTOLkKMrBxEpWOmYN0HNrR5QMbmiC25LFNvpyNUr Pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wrw4n7b0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 06:08:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBB64Njh024684;
        Wed, 11 Dec 2019 06:08:49 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wtqg98hxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Dec 2019 06:08:49 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xBB68mxH025206;
        Wed, 11 Dec 2019 06:08:48 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Dec 2019 22:08:47 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com
Subject: [PATCHi RFC] fstest: btrfs/158 fix miss-aligned stripe and device
Date:   Wed, 11 Dec 2019 14:08:39 +0800
Message-Id: <1576044519-28313-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <010f5b0e-939a-b2be-70a2-d8670d1696ab@suse.com>
References: <010f5b0e-939a-b2be-70a2-d8670d1696ab@suse.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912110053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9467 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912110053
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We changed the order of the allocation on the devices, and
so the test cases which are hard coded to find specific stripe
on the specific device gets failed. So fix it with the new layout.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Qu, Right we need to fix the dev in the test case as well.
    I saw your patches bit late. Here is what I had.. you may
    use it. So I am marking this patch as RFC.
Thanks.

 tests/btrfs/158     | 10 +++++-----
 tests/btrfs/158.out |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/btrfs/158 b/tests/btrfs/158
index 603e8bea9b7e..7f2066384f55 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -76,14 +76,14 @@ _scratch_unmount
 
 stripe_0=`get_physical_stripe0`
 stripe_1=`get_physical_stripe1`
-dev4=`echo $SCRATCH_DEV_POOL | awk '{print $4}'`
-dev3=`echo $SCRATCH_DEV_POOL | awk '{print $3}'`
+dev1=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
+dev2=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
 
 # step 2: corrupt the 1st and 2nd stripe (stripe 0 and 1)
-echo "step 2......simulate bitrot at offset $stripe_0 of device_4($dev4) and offset $stripe_1 of device_3($dev3)" >>$seqres.full
+echo "step 2......simulate bitrot at offset $stripe_0 of device_1($dev1) and offset $stripe_1 of device_2($dev2)" >>$seqres.full
 
-$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev4 | _filter_xfs_io
-$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev3 | _filter_xfs_io
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_0 64K" $dev1 | _filter_xfs_io
+$XFS_IO_PROG -f -d -c "pwrite -S 0xbb $stripe_1 64K" $dev2 | _filter_xfs_io
 
 # step 3: scrub filesystem to repair the bitrot
 echo "step 3......repair the bitrot" >> $seqres.full
diff --git a/tests/btrfs/158.out b/tests/btrfs/158.out
index 1f5ad3f76917..5cdaeb238c62 100644
--- a/tests/btrfs/158.out
+++ b/tests/btrfs/158.out
@@ -1,9 +1,9 @@
 QA output created by 158
 wrote 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 9437184
+wrote 65536/65536 bytes at offset 22020096
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 65536/65536 bytes at offset 9437184
+wrote 65536/65536 bytes at offset 1048576
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 0000000 aaaa aaaa aaaa aaaa aaaa aaaa aaaa aaaa
 *
-- 
1.8.3.1

