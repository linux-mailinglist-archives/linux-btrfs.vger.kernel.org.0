Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F75D104F51
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2019 10:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUJds (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Nov 2019 04:33:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:45804 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKUJdr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Nov 2019 04:33:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9SwJw079119
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=QJc4YmRNspsMCmbEX8qH44riexMlK9AmMbjLGbNsBZs=;
 b=WFD0/qKrUabsMc7LtQEet+WNwkTWCq5ufp4SjUR9hZaSlGIlRA4uC7cLHqD71w2BGSub
 yfHtqsmH8OQBb6/CWmn/lbN0PTWQae8wKLazXN2rAoBlWx3czlP6CjHpvnUimUP+x4NS
 d6Zk3rNSOzY4wVBvkVq2EnuEPNcrVJf1kUTUy31coDqQnOGxn59PnBAL4f5Wloo9rwbO
 LC3+4qr1TUH81Q/H6aeQ8cXJq6KPTvDBfNRwG94DS4gUh8UU5EDfjzPcWPhaxaNqEKNz
 Fv7OoGPqBK4RU+lAyIvHP3383vYGFlbZfprmb+/xBWi/pfrNzG0Wi6FvP+QLre3sleVZ hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2wa92q2u55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAL9Wxru067329
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wd47wn9av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:45 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAL9XiCC027479
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Nov 2019 09:33:44 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Nov 2019 01:33:43 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/5] btrfs: sysfs, cleanups
Date:   Thu, 21 Nov 2019 17:33:29 +0800
Message-Id: <1574328814-12263-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911210087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911210086
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
  As it is learnt that we might add sysfs attributes for the
  scanned devices at some point, V2 does not cleanup those which
  might be required to implement it. Last attempt to add is here
  [1] in the mailing list.
   [1] [PATCH] btrfs: Introduce device pool sysfs attributes

  This set also drops the patches which moved the local struct declare
  to the place where it was actually used. Agreed top of the file is
  better.

  Drops the patches which was trying to bring the related functions
  together in sysfs.c. I am not sure why this isn't a nice cleanup,
  as in super.c we don't place exit_btrfs_fs() and init_btrfs_fs()
  apart we place them together the idea was similar in sysfs.c.
  Anyway as there is disagreement I have dropped them from the list.

  Dropped the patch '[PATCH 07/15] btrfs: sysfs, delete code in a
  comment' as its already integrated in misc-next.

  In v2 I have used better naming compared to v1. For example
  btrfs_fs_devices::devices_dir_kobj vs btrfs_fs_devices::devices_kobj
  and btrfs_sysfs_add_device_info() vs btrfs_sysfs_add_devices_attr,
  as I am following a pattern that sysfs directories are inherently
  kobjects, which holds files as attributes. We could drop sysfs prefix
  also because kobj and attr already indicate that they are part of
  sysfs. But people not familiar with sysfs terminology might have to
  wonder a little bit, so didn't make that bold changes.

  And I hope I didn't miss any other changes in v2.

Testing:

 As this is a cleanup patches, it should be made sure not to introduce any
 regression in the sysfs layout. So here is a script which compares with
 the golden md5sum of the sysfs layout. There are two golden md5sum
 because as I am using find command which looks like due to some
 optimization the list of file was in the same order all the time, it was
 in two different orders. If there is any better ways to do this, or tell
 find to not to optimize I will be happy to know and use it.

 (sorry for the hard-coded device paths).
-----------8<----------------
#!/bin/bash

known_uuid="12345678-1234-1234-1234-123456789012"
golden_sum1="7ae7b72ee3e5efc32f2fab152dd0fcd5"
golden_sum2="6cefff853e55a31047c57f5a14ffb636"

cleanup()
{
	umount /btrfs > /dev/null 2>&1
	modprobe -r btrfs
}

test()
{
	cleanup

	mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc
	uuid=$(btrfs fi show /dev/sdb | grep uuid | awk '{print $4}')

	mount -o compress=lzo,device=/dev/sdc /dev/sdb /btrfs
	xfs_io -f -c "pwrite -S 0xab 0 500M" /btrfs/foo  > /dev/null

	find -O0 /sys/fs/btrfs -type f | sed s/$uuid/$known_uuid/g > /tmp/golden.output
	test_sum=$(md5sum /tmp/golden.output|awk '{print $1}')

	umount /btrfs
	modprobe -r btrfs

	[ "$golden_sum1" == "$test_sum" ] && return
	[ "$golden_sum2" == "$test_sum" ] && return

	echo "Failed: test_sum $test_sum"
	echo "Golden:        1 $golden_sum1"
	echo "Golden:        2 $golden_sum2"
}

test
-----------8<----------------



v1: cover-letter

Mostly cleanups patches.

Patches 1-7 are renames, code moves patches and there are no
functional changes.

Patch 8 drops unused argument in the function btrfs_sysfs_add_fsid().
Patch 9 merges two small functions which is an extension of the other.

Patches 10,11 and 13 removes unnecessary features in the functions, 
originally it was planned to provide sysfs attributes for the scanned
and unmounted devices, as in the un-merged patch in the mailing list [1]
   [1] [PATCH] btrfs: Introduce device pool sysfs attributes

Patch 12 merges functions.

Patches 14,15 are code optimize patches.

Anand Jain (5):
  btrfs: sysfs, rename devices kobject holder to devices_kobj
  btrfs: sysfs, rename device_link add,remove functions
  btrfs: sysfs, btrfs_sysfs_add_fsid() drop unused argument parent
  btrfs: sysfs, rename btrfs_sysfs_add_device()
  btrfs: sysfs, merge btrfs_sysfs_add devices_kobj and fsid

 fs/btrfs/dev-replace.c |  4 ++--
 fs/btrfs/disk-io.c     |  9 +-------
 fs/btrfs/sysfs.c       | 62 ++++++++++++++++++++++++--------------------------
 fs/btrfs/sysfs.h       |  8 +++----
 fs/btrfs/volumes.c     |  8 +++----
 fs/btrfs/volumes.h     |  2 +-
 6 files changed, 41 insertions(+), 52 deletions(-)

-- 
1.8.3.1

