Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD8436F9B1
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Apr 2021 14:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhD3MBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Apr 2021 08:01:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34422 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhD3MBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Apr 2021 08:01:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UC0HGB183175;
        Fri, 30 Apr 2021 12:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=O83CaXT+8Vh3+/fPIEB4j5k0Gz3S7TQuDbeEWFeKkZM=;
 b=bilTs0reZ1rtBSXyOfy8GtUIZNEAX+p1hf4fd+cSBJz6mBR2zAicwdy7JXB5gac24reV
 ehVtoHa+5K0iASkFDGAWqz64iRk+r4D6Eb/BXube7PHgf+GsN+tfsh4mSCxOPauRSd+d
 7pGHNEh2CRmd+xB1cFMzUhT4w+WSljwF7wxF0S9EdTO1e87P//XJblO4z2/s4Rf17LWX
 1QOoyLiNmA+lbagDzZ2aC67SdS0Z7iB8avFA9BO5TueSIx1OxEKlhyK4UW5FF3FHE3wR
 h9nfwuZS8UeBGflVSDhM3JsDRUsYSi6vNwQQ/7+T8uIwrDct27SU/NdCHt6CzC3zF5+v 0w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 385aeq7fh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 12:00:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UBu0kO096292;
        Fri, 30 Apr 2021 12:00:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 384b5bw168-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 12:00:16 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13UBu1dU096672;
        Fri, 30 Apr 2021 12:00:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 384b5bw13q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 12:00:15 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13UC0ELo008791;
        Fri, 30 Apr 2021 12:00:14 GMT
Received: from fed2.sg.oracle.com (/10.191.34.198)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Apr 2021 05:00:13 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, fdmanana@suse.com,
        Chris Murphy <lists@colorremedies.com>
Subject: [PATCH] btrfs: fix unmountable seed device after fstrim
Date:   Fri, 30 Apr 2021 19:59:51 +0800
Message-Id: <d6fcae756c5ce47da3527e5db4760d676420d950.1619783910.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <c7715d09a67f212e0ecb5fea2d598513912092f4.1619443900.git.anand.jain@oracle.com>
References: <c7715d09a67f212e0ecb5fea2d598513912092f4.1619443900.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: M0k5ilgruiGZZAwSPwA8pvS3aiuCCpcq
X-Proofpoint-GUID: M0k5ilgruiGZZAwSPwA8pvS3aiuCCpcq
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300088
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The following test case reproduces an issue of wrongly freeing in-use
blocks on the readonly seed device when fstrim is called on the rw sprout
device. As shown below.

Create a seed device and add a sprout device to it:
	$ mkfs.btrfs -fq -dsingle -msingle /dev/loop0
	$ btrfstune -S 1 /dev/loop0
	$ mount /dev/loop0 /btrfs
	$ btrfs dev add -f /dev/loop1 /btrfs
	BTRFS info (device loop0): relocating block group 290455552 flags system
	BTRFS info (device loop0): relocating block group 1048576 flags system
	BTRFS info (device loop0): disk added /dev/loop1
	$ umount /btrfs

Mount the sprout device and run fstrim:
	$ mount /dev/loop1 /btrfs
	$ fstrim /btrfs
	$ umount /btrfs

Now try to mount the seed device, and it fails:
	$ mount /dev/loop0 /btrfs
	mount: /btrfs: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.

Block 5292032 is missing on the readonly seed device.
	$ dmesg -kt | tail
	<snip>
	BTRFS error (device loop0): bad tree block start, want 5292032 have 0
	BTRFS warning (device loop0): couldn't read-tree root
	BTRFS error (device loop0): open_ctree failed

From the dump-tree of the seed device (taken before the fstrim). Block
5292032 belonged to the block group starting at 5242880
	$ btrfs inspect dump-tree -e /dev/loop0 | grep -A1 BLOCK_GROUP
	<snip>
	item 3 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16169 itemsize 24
		block group used 114688 chunk_objectid 256 flags METADATA
	<snip>

From the dump-tree of the sprout device (taken before the fstrim).
fstrim(8) used block-group 5242880 to find the related free space to free.
	$ btrfs inspect dump-tree -e /dev/loop1 | grep -A1 BLOCK_GROUP
	<snip>
	item 1 key (5242880 BLOCK_GROUP_ITEM 8388608) itemoff 16226 itemsize 24
		block group used 32768 chunk_objectid 256 flags METADATA
	<snip>

Bpf kernel tracing the fstrim(8) command finds the missing block 5292032
within the range of the discarded blocks as below.
	kprobe:btrfs_discard_extent {
		printf("freeing start %llu end %llu num_bytes %llu:\n",
			arg1, arg1+arg2, arg2);
	}

	freeing start 5259264 end 5406720 num_bytes 147456
	<snip>

Fix this by avoiding the discard command to the readonly seed device.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reported-by: Chris Murphy <lists@colorremedies.com>
---
 fs/btrfs/extent-tree.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7a28314189b4..f1d15b68994a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1340,12 +1340,16 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
 			u64 bytes;
+			struct btrfs_device *device = stripe->dev;
 
-			if (!stripe->dev->bdev) {
+			if (!device->bdev) {
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
 
+			if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
+				continue;
+
 			ret = do_discard_extent(stripe, &bytes);
 			if (!ret) {
 				discarded_bytes += bytes;
-- 
2.29.2

