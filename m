Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47271BC360
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 17:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgD1PYr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 11:24:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44574 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgD1PYq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 11:24:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFHLFu141305;
        Tue, 28 Apr 2020 15:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0BgW6oM+w0l2X72GICsuS5oMD9KsqZo7DG5b6J9vzFk=;
 b=ub6/DUTQxPIxyEaWkAEF39OQn7bQE93c4s5irn4vS2Y++pNDx2gBcMugXFwPTY/VZKOy
 7ysfb0w+KP4IyYYsoPIVhQGqdfB5eFi7WJdVBdBJ+M8LpcJ9irKYvuhk4WY/YuGOXVnB
 zQO9MN5l84T8aeYZ+qs8VR9yGYVuBbye3msU2Ch6cKb3bT0W62Np3yKpXygf9nE24AyZ
 r+whODwM3NYtRG2LbE8BtnFO6bTkfOeLXMJLbPKQPoBitvpQXzGEZFoqBm4pQYTaZkGM
 8W62GE8ezIU7lzBUpGRqyZuIl+U0mHdVD7hXy3QpTEfK5YjsHdBAUzqdQoBg8lFjng2Q aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30p2p061uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:24:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFCf5l086564;
        Tue, 28 Apr 2020 15:22:40 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30mxpg9720-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:22:40 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SFMdh3010222;
        Tue, 28 Apr 2020 15:22:39 GMT
Received: from localhost.localdomain (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:22:39 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com, josef@toxicpanda.com
Subject: [PATCH 2/3] btrfs: include non-missing as a qualifier for the latest_bdev
Date:   Tue, 28 Apr 2020 23:22:26 +0800
Message-Id: <20200428152227.8331-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200428152227.8331-1-anand.jain@oracle.com>
References: <20200428152227.8331-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=3 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280120
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

$ mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs

$ mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc
$ sleep 3 # avoid racing with udev's useless scans if needed
$ btrfs dev add -f /dev/sdb /btrfs
$ mount -o degraded /dev/sdc /btrfs1

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

 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 914402d3c1de..a67af16d960d 100644
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
2.23.0

