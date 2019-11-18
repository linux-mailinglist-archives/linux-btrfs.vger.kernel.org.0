Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAC41000A1
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 09:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfKRIrG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 03:47:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52546 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfKRIrF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 03:47:05 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i4Tr076478
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=V2eszgGBUw3zxjtw1YwPnNqDitsEOtijy+PxQpw+YYQ=;
 b=PNL5xrBNDM1YyNN6nml4ueEiqhHkQMaoKXEmMiHCFISPrFNdR1iXtBkxXtfGi9K2FylU
 xZKqTXuXRMfOAt3Ok8T9JsoapT9ouw7JRCcYkqZ4BJo1LHa0T+vW/Gi2NekbZQpoOf36
 QiYklxf8z9YkFRU9YdjutZqdsIFKAvRlSQ3qXdcWsLe41c14nld0Jb8bILrMtNP7r5P7
 pwfwGenD1LnOQUNU0aE2adSwi+8V3n0tGBEnYaYrrLA1o2uLj27QvgqXex4NH9X+GBGY
 sZ2hDmuxFLjq/bIL4PRR6YSlMWXeWmWvYrR+aFBeGAg1LZStz6359+P6wnpB+IhptwIB xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2wa9rq6gh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAI8i3mZ156221
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wau946cvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:03 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAI8l18J005405
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Nov 2019 08:47:02 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 00:47:01 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/15] btrfs: sysfs, cleanups
Date:   Mon, 18 Nov 2019 16:46:41 +0800
Message-Id: <20191118084656.3089-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=680
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9444 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=740 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

Anand Jain (15):
  btrfs: sysfs, rename device_link add,remove functions
  btrfs: sysfs, rename btrfs_sysfs_add_device()
  btrfs: sysfs, rename btrfs_device member device_dir_kobj
  btrfs: sysfs, move declared struct near its use
  btrfs: sysfs, move /sys/fs/btrfs/UUID related functions together
  btrfs: sysfs, move add remove _mounted function together
  btrfs: sysfs, delete code in a comment
  btrfs: sysfs, btrfs_sysfs_add_fsid() drop unused argument parent
  btrfs: sysfs, merge btrfs_sysfs_add devices_dir and fsid
  btrfs: volume, btrfs_free_stale_devices() cleanup unreachable code
  btrfs: sysfs, migrate fs_decvices::fsid_kobject to struct
    btrfs_fs_info
  btrfs: sysfs, unexport btrfs_sysfs_add_mounted()
  btrfs: sysfs, cleanup btrfs_sysfs_remove_fsid()
  btrfs: sysfs, merge btrfs_sysfs_remove_fsid() helper function
  btrfs: sysfs, unexport btrfs_sysfs_remove_mounted()

 fs/btrfs/ctree.h       |   2 +
 fs/btrfs/dev-replace.c |   4 +-
 fs/btrfs/disk-io.c     |  25 +---
 fs/btrfs/sysfs.c       | 258 ++++++++++++++++++-----------------------
 fs/btrfs/sysfs.h       |  12 +-
 fs/btrfs/volumes.c     |  10 +-
 fs/btrfs/volumes.h     |   3 +-
 7 files changed, 134 insertions(+), 180 deletions(-)

-- 
2.23.0

