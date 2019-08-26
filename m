Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72A9CC2F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 11:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfHZJGr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 05:06:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59750 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfHZJGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 05:06:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7Q93mGj101720
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=dekF4Tf7Cm2shFn/WRFblJJ+2Cll4xByspQoazZOiDo=;
 b=qsN4ol907SS4rcI5E3I3p8I4mfGdNW5Z1cNB8LCIKZpFs5tkcpcINQCPL6AMCnD882iv
 y6W0EvuthLkgtuKa28nGIJ1rLOHT37xIa9pA5C4cLvBV7oQvpYenr33y0GGTJiUtyKBF
 XE17M5Gve6Mfjjr797kVrTWisMM93PhmvMDNuEkvt8+bDw9+JSMJhNYBj1HTPVqQHtMB
 YUvMVEi4uMD6sw8mfr/wwhfQWerQ8x7nDhi4UDTXObcxvBtogoIMsnpBHtPllmqgz016
 9SkEtsQJ8hk1Tg33w+nJxQMvXYnPwkNMFB3MOUcZ+COQ5h1YCCHGwbFTBkFeONRaqVfl xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2ujw6yyn1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:06:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7Q93lmV159042
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:45 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ujw6umbhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:45 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7Q94ihs023099
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 09:04:44 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Aug 2019 02:04:42 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 0/2]  readmirror feature
Date:   Mon, 26 Aug 2019 17:04:36 +0800
Message-Id: <20190826090438.7044-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908260101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9360 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908260102
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function call chain  __btrfs_map_block()->find_live_mirror() uses
thread pid to determine the %mirror_num when the mirror_num=0.

This patch introduces a framework so that we can add policies to determine
the %mirror_num. And also adds the devid as the readmirror policy.

The new property is stored as an item in the device tree as show below.
    (BTRFS_READMIRROR_OBJECTID, BTRFS_PERSISTENT_ITEM_KEY, devid)

To be able to set and get this new property also introduces new ioctls
BTRFS_IOC_GET_READMIRROR and BTRFS_IOC_SET_READMIRROR. The ioctl argument
is defined as
        struct btrfs_ioctl_readmirror_args {
                __u64 type; /* RW */
                __u64 device_bitmap; /* RW */
        }

An usage example as follows:
        btrfs property set /btrfs readmirror devid:1,3
        btrfs property get /btrfs readmirror
          readmirror devid:1 3
        btrfs property set /btrfs readmirror ""
        btrfs property get /btrfs readmirror
          readmirror default

This patchset has been tested completely, however marked as RFC for the 
following reasons and comments on them (or any other) are appreciated as
usual.
 . The new objectid is defined as
      #define BTRFS_READMIRROR_OBJECTID -1ULL
   Need consent we are fine to use this value, and with this value it
   shall be placed just before the DEV_STATS_OBJECTID item which is more
   frequently used only during the device errors.

.  I am using a u64 bitmap to represent the devices id, so the max device
   id that we could represent is 63, its a kind of limitation which should
   be addressed before integration, I wonder if there is any suggestion?
   Kindly note that, multiple ioctls with each time representing a set of
   device(s) is not a choice because we need to make sure the readmirror
   changes happens in a commit transaction.

v1->RFC v2:
  . Property is stored as a dev-tree item instead of root inode extended
    attribute.
  . Rename BTRFS_DEV_STATE_READ_OPRIMIZED to BTRFS_DEV_STATE_READ_PREFERRED.
  . Changed format specifier from devid1,2,3.. to devid:1,2,3..

RFC->v1:
  Drops pid as one of the readmirror policy choices and as usual remains
  as default. And when the devid is reset the readmirror policy falls back
  to pid.
  Drops the mount -o readmirror idea, it can be added at a later point of
  time.
  Property now accepts more than 1 devid as readmirror device. As shown
  in the example above.

Anand Jain (1):
  btrfs: add readmirror framework and policy devid

 fs/btrfs/ctree.h                |   3 +
 fs/btrfs/disk-io.c              |   9 ++
 fs/btrfs/ioctl.c                | 108 ++++++++++++++++++++++++
 fs/btrfs/transaction.c          |   3 +
 fs/btrfs/volumes.c              | 145 +++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h              |   9 +-
 include/uapi/linux/btrfs.h      |  15 +++-
 include/uapi/linux/btrfs_tree.h |  11 +++
 8 files changed, 300 insertions(+), 3 deletions(-)

Anand Jain (1):
  btrfs_progs: add readmirror property and ioctl to set get

 ioctl.h | 14 +++++++++
 props.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
