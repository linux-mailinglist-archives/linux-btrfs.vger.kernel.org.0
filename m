Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E491C3762
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 May 2020 12:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEDK6w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 May 2020 06:58:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56932 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEDK6v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 May 2020 06:58:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Ar33x028466
        for <linux-btrfs@vger.kernel.org>; Mon, 4 May 2020 10:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=7CLmkY3i7XgSstHJleXKux7AFn66VW1lMOfHAeRofps=;
 b=lOZBMVaXVXl9H7v1lwXvw0qYhijHeVSgP5KLMkBmtKDNcj52xUHu/uhgfPguwlANVQjt
 nXz30Guv51fMnRLiw+751eGqjo2b5uvO8PElbcx7mq9hi3cZMJT25Q50NCt/QSDUGcNn
 mkM/e/tGjONMkX9r2NBbHjahH3FGv3oOlEWdGqQW9RejqeYrh8GdvXD8Dam08iBQtI75
 r+QZCymso5ZY6quZDfN0qfU/HUaUcEG8HtcOsyskqcJvSB0iaDRV/3dRZzthMMBw/0/m
 4bXoCrGwtBHTBc3KOEvvioW2yd4eKY3zT+Jwh6XgxoSl8Nqrlz94vTQByP0XT1pG3wGM PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30s0tm64nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 10:58:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044AvbTp146466
        for <linux-btrfs@vger.kernel.org>; Mon, 4 May 2020 10:58:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30t1r1xcuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 04 May 2020 10:58:49 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044AwmZ2006445
        for <linux-btrfs@vger.kernel.org>; Mon, 4 May 2020 10:58:48 GMT
Received: from localhost.localdomain (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 03:58:48 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 2/3] btrfs: include non-missing as a qualifier for the latest_bdev
Date:   Tue,  5 May 2020 02:58:25 +0800
Message-Id: <20200504185826.9954-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200428152227.8331-4-anand.jain@oracle.com>
References: <20200428152227.8331-4-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=3
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=3
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040093
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_free_extra_devids() reorgs fs_devices::latest_bdev
to point to the bdev with greatest device::generation number.
For a typical-missing device the generation number is zero so
fs_devices::latest_bdev will never point to it.

But if the missing device is due to alienation [1], then
device::generation is not-zero and if it is >= to rest of
device::generation in the list, then fs_devices::latest_bdev
ends up pointing to the missing device and reports the error
like this [2]

[1] We maintain devices of a fsid (as in fs_device::fsid) in the
fs_devices::devices list, a device is considered as an alien device
if its fsid does not match with the fs_device::fsid

Consider a working raid1.
$ mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc
$ mount /dev/sdb /btrfs
$ umount /btrfs

While raid1 was unmounted the user decides to force add one its
device to another btrfs fs.

$ mkfs.btrfs -fq /dev/sdd
$ mount /dev/sdd /btrfs1
$ btrfs dev add -f /dev/sdb /btrfs1

Now the original raid1 fails to mount in degraded, because
fs_devices::latest_bdev is pointing to the alien device.

$ mount -o degraded /dev/sdc /btrfs

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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
v3-rebased: update change log.
v4: update change log.

 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bf953c4895f3..f93739afe681 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1042,6 +1042,8 @@ void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step)
 							&device->dev_state)) {
 			if (!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
 			     &device->dev_state) &&
+			    !test_bit(BTRFS_DEV_STATE_MISSING,
+			     &device->dev_state) &&
 			     (!latest_dev ||
 			      device->generation > latest_dev->generation)) {
 				latest_dev = device;
-- 
2.25.1

