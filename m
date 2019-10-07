Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED0CDE6D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfJGJpZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:45:25 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59960 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbfJGJpZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 05:45:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979dCA3022967
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=6dmS48pG6irNMwD9fS+3IUEJAha5ZP72X+7lROcEt0o=;
 b=B7tfUCmakbzwWaP23T5ahoHi4rG/HRYFLM9vHMfCOSc7sdv2kaOt34vDo0JnzKNSUhJ1
 XIB6tPM02vxAHRxJqIoP1wEUp5cOp/Kp/+7K8QLsIGwjmJgvZQlVMFGW43ieuJzcMeUa
 zMtxvo8xvWAK9UzFDZsIXQkyJtoWT9q4mOP044DJDgRgEdTurOH+W8ShK48pvPASZ/am
 g1jWRcQVIW95oGm/Ly8lrKHhgWHJNkU0SAq7xQ4tu+ohYSgcDzbCESoGgyD9GvsGbd2L
 ISdMk5/su6bqv9O9a6XJkuirWC7G0iENlDZsi8aQOu8B3JhMiGUR52AGRZy9ID3mZcSB AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vek4q5ncx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cTWj094102
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2vf4ph7a13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:23 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x979jMpD003948
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:22 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 02:45:22 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: include non-missing as a qualifier for the latest_bdev
Date:   Mon,  7 Oct 2019 17:45:12 +0800
Message-Id: <20191007094515.925-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007094515.925-1-anand.jain@oracle.com>
References: <20191007094515.925-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_free_extra_devids() reorgs fs_devices::latest_bdev
to point to the bdev with greatest device::generation number.
For a typical-missing device the generation number is zero so
fs_devices::latest_bdev will never point to it.

But if the missing device is due to alienating [1], then
device::generation is not-zero and if it is >= to rest of
device::generation in the list, then fs_devices::latest_bdev
ends up pointing to the missing device and reports the error
like this [2]

[1]
mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs
mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc
sleep 3 # avoid racing with udev's useless scans if needed
btrfs dev add -f /dev/sdb /btrfs

mount -o degraded /dev/sdc /btrfs1

[2]
mount: wrong fs type, bad option, bad superblock on /dev/sdc,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.

kernel: BTRFS warning (device sdc): devid 1 uuid 072a0192-675b-4d5a-8640-a5cf2b2c704d is missing
kernel: BTRFS error (device sdc): failed to read devices
kernel: BTRFS error (device sdc): open_ctree failed

Fix the root of the issue, by checking if the the device is not
missing before it can be a contender for the fs_devices::latest_bdev
title.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c223a8147bfd..0cc8d40b8bb9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -974,6 +974,8 @@ void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step)
 							&device->dev_state)) {
 			if (!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
 			     &device->dev_state) &&
+			    !test_bit(BTRFS_DEV_STATE_MISSING,
+			     &device->dev_state) &&
 			     (!latest_dev ||
 			      device->generation > latest_dev->generation)) {
 				latest_dev = device;
-- 
1.8.3.1

