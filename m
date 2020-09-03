Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C85725B806
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgICA6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39068 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgICA6K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830usll049677
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=hKUXWCPO4tDDJLZDrMtq/eLmi8ODV+oBIt+P+6CsfN0=;
 b=dhpfUkbaXwGyobPxN1rB6u5cOxvdDXoSXBfIsMSgeDV359ZmCSD/RexvmpmRM2b3LGLZ
 GpOvMRCGLKmrfaFgHEu8M8b5yYy1tgrCpnIIUmQGx0p4StfYmOL9Vr/Kq3KpPZ1J5yEK
 IRvWqWmQquWkYg44+OIeCnWNopQSDPyG9uN8yy7Lz0UVUqGAJM4SBFrcXpXE1d9hLmo6
 MY0OsBIJSKEqted75jbpVuk1EWWKREnLLT+i7sIu5pTVf/9HFBHJla+dYiMOQzBpcziO
 tGnbXRuxTqfEq286EhXSuWLAHsVJ8BVOyQHLFiimDaIqidgHUAxOK4XYv5G3kBg71Wu9 yA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 337eer5x9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830seXC036796
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3380x8anqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:08 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0830w7ck020130
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:07 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:07 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/15] btrfs: seed fix null ptr, use only main device_list_mutex, and cleanups
Date:   Thu,  3 Sep 2020 08:57:36 +0800
Message-Id: <cover.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=1 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030004
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v2:
patch 1-3 are cleanups and is a split from the v1-patch-1/11.
patch 4-5 are from v1 with conflict fix.
patch 6 is the core bug fix, which fixes the null sysfs obj being freed
        which was in v1 also but together with other required
	preparatory.
patch 7 fixes a new bug found that we leaked sysfs object in the fail
        exit path.
patch 8,9,10,11,12,13,14,15 were in v1 as well. 8,9 consolidates
	device_list_mutex to use the main fs_info->fs_devices.
	10-14 are cleanups. 15 fixes bug exposed after replacing of seed
	and trying to mount without the seed.

v2 has been tested with xfstests -g volume

------ v1 cover-letter ------------
In this patch set:
Rebased on latest misc-next which contains the seed_list from Nicolas.
This patchset has been sent before as two sets, here it is been merged.

Patches 1/11 fix the null kobject being put, which is observed with kernel
compiled with memory poisoning.
Patches 2/11 and 3/11 are cleanups to maintain better flow in the
functions btrfs_sysfs_add_devices_dir() and btrfs_sysfs_remove_devices_dir().
Patches 4/11 and 5/11 drops the last two users of seed device_list_mutex,
so now they hold main filesystem device_list_mutex. 
Patches [6-10]/11 are cleanups.
Patches 11/11 block the replacement of seed device in a sprouted FS, we already
block replacing a seed device on a non-sprouted device.

This set has passed through fstests/volume.

---- original cover-letter ---------
In a sprouted file system, the seed's fs_devices are cloned and 
listed under the sprout's fs_devices. The fs_info::fs_devices
points to the sprout::fs_devices and various critical operations
like device-delete holds the top-level main device_list_mutex
which is sprout::fs_devices::device_list_mutex and _not_ the seed level
mutex such as sprout::fs_devices::seed::fs_devices::device_list_mutex.

Also all related readers (except for two threads- reada and init_devices_late)
hold the sprout::fs_devices::device_list_mutex too. And those two threads
which are missing to hold the correct lock are being fixed here.

I take the approach to fix the read end instead of fixing the writer end
which are not holding the seed level mutex because to keep things
simple and there isn't much benefit burning extra CPU cycles in going
through the lock/unlock process as we traverse through the
fs_devices::seed fs_devices (for example as in reada and init_devices_late
threads).

The first two patches (1/7, 2/7) fixes the threads using the
seed::device_list_mutex.

And rest of the patches ([3-7]/7) are cleanups and these patches
are independent by themself.

These patchset has been tested with full xfstests btrfs test cases and

Anand Jain (15):
  btrfs: add btrfs_sysfs_add_device helper
  btrfs: add btrfs_sysfs_remove_device helper
  btrfs: btrfs_sysfs_remove_devices_dir drop return value
  btrfs: refactor btrfs_sysfs_add_devices_dir
  btrfs: refactor btrfs_sysfs_remove_devices_dir
  btrfs: initialize sysfs devid and device link for seed device
  btrfs: handle fail path for btrfs_sysfs_add_fs_devices
  btrfs: reada: use sprout device_list_mutex
  btrfs: btrfs_init_devices_late: use sprout device_list_mutex
  btrfs: open code list_head pointer in btrfs_init_dev_replace_tgtdev
  btrfs: cleanup btrfs_remove_chunk
  btrfs: cleanup btrfs_assign_next_active_device()
  btrfs: cleanup unnecessary goto in open_seed_device
  btrfs: btrfs_dev_replace_update_device_in_mapping_tree drop file
    global declare
  btrfs: fix replace of seed device

 fs/btrfs/dev-replace.c |  66 ++++++++---------
 fs/btrfs/reada.c       |   5 +-
 fs/btrfs/sysfs.c       | 156 +++++++++++++++++++++++++----------------
 fs/btrfs/sysfs.h       |   6 +-
 fs/btrfs/volumes.c     |  40 +++++------
 5 files changed, 145 insertions(+), 128 deletions(-)

-- 
2.25.1

