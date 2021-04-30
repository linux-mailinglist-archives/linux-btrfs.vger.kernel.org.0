Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5736F799
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 11:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhD3JLl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 05:11:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41618 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhD3JLl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 05:11:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13U99sMJ148091;
        Fri, 30 Apr 2021 09:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=x24y6zgKarQ2MFYB/3ge9q3Y0NMhl8K8rn2nWzUg+4g=;
 b=mV5vSGDdq7IqUzyasab9idC+BO8wUk4tTAYUbLpyVMTtAWqSr7Idh7hqb/Yjy8jLT8Lx
 BVBkAphjv74GswB8vo3ZO8y9IabCMP6N+Q4A7M5qFDHIvKXfyMuKQqNQAAIlTnmmn0AC
 Ex3fqGeTTvOiaE6FFM/c5hfrPx1enGbfMFJDM0dyk6RXVV4Fn0nyCKIDUEwU18Z2+9YM
 qUlpCoIaBjDDUPRsmXlK2PJMXGt0f2QnE4A8RFtxBsdKF6IAi2H49sUqvMqozChbB+ns
 UHDr3j3rVFjoCtvKP6YHwF0KbRMpXu/WNxs4qJd8PjAjwbJ3CT2ldUiH6Ah9Wzr7NiMU vA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 385ahby3ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 09:10:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13U9A0pg077803;
        Fri, 30 Apr 2021 09:10:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 384b5bqjnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 09:10:51 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13U9AoOn081397;
        Fri, 30 Apr 2021 09:10:51 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 384b5bqjnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 09:10:50 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13U9AnUV021010;
        Fri, 30 Apr 2021 09:10:49 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Apr 2021 09:10:48 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>,
        Chris Murphy <lists@colorremedies.com>
Subject: [PATCH] btrfs: fix unmountable seed device after fstrim
Date:   Fri, 30 Apr 2021 17:10:28 +0800
Message-Id: <c7715d09a67f212e0ecb5fea2d598513912092f4.1619443900.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q-5mvvCE2Nq7mYVljCLH9lD6AX62PBev
X-Proofpoint-ORIG-GUID: q-5mvvCE2Nq7mYVljCLH9lD6AX62PBev
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104300067
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following test case reproduces an issue of wrongly freeing the in-use
block on the readonly seed device when fstrim is called on the rw sprout
device. As shown below.

create a seed device and add a sprout device to it
	mkfs.btrfs -fq -dsingle -msingle /dev/loop0
	btrfstune -S 1 /dev/loop0
	mount /dev/loop0 /btrfs
	btrfs dev add -f /dev/loop1 /btrfs

  BTRFS info (device loop0): relocating block group 290455552 flags system
  BTRFS info (device loop0): relocating block group 1048576 flags system
  BTRFS info (device loop0): disk added /dev/loop1

	umount /btrfs
mount the sprout device and run fstrim
	mount /dev/loop1 /btrfs
	fstrim /btrfs
	umount /btrfs

now try to mount the seed device, and it fails...
	mount /dev/loop0 /btrfs

  mount: /btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.

  BTRFS error (device loop0): bad tree block start, want 5292032 have 0
  BTRFS warning (device loop0): couldn't read-tree root
  BTRFS error (device loop0): open_ctree failed

Block 5292032 is missing on the readonly seed device.

From the dump-tree of the seed device taken before the fstrim. Block
5292032 belonged to the block group starting at 5242880

<snip>
 item 3 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16169 itemsize 24
	block group used 114688 chunk_objectid 256 flags METADATA
<snip>

From the dump-tree of the sprout device (taken before the fstrim).
fstrim used the block-group 5242880 to find the free space to free.

<snip>

 item 1 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16226 itemsize 24
	block group used 32768 chunk_objectid 256 flags METADATA
<snip>


bpf tracing the fstrim command finds the missing block 5292032 within the
range of the discarded blocks...

  kprobe:btrfs_discard_extent {
    printf("free start %llu end %llu num_bytes %llu\n", arg1, arg1+arg2, arg2);
  }

btrfs_discard_extent(..., start, num_bytes, ...):

 free start 5259264 end 5406720 num_bytes 147456
<snip>

Fix this by avoiding the discard command to the readonly seed device.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reported-by: Chris Murphy <lists@colorremedies.com>
---

A xfstests case to follow.

 fs/btrfs/extent-tree.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7a28314189b4..0d19bd213715 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1340,12 +1340,19 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
 			u64 bytes;
+			struct btrfs_device *device = stripe->dev;
 
-			if (!stripe->dev->bdev) {
+			if (!device->bdev) {
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
 
+			/*
+			 * Skip sending discard command to a non-writeable device.
+			 */
+			if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
+				continue;
+
 			ret = do_discard_extent(stripe, &bytes);
 			if (!ret) {
 				discarded_bytes += bytes;
-- 
2.29.2

