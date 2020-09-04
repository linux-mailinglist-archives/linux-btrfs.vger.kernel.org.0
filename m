Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8A125E0E2
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgIDRey (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:34:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41818 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIDRey (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:34:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HYFSt073913;
        Fri, 4 Sep 2020 17:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=rT/3QVcffRyCcLYP6M90NuhbeYqqrSxmqbpNAVQygU0=;
 b=lk31ycPYAytETx6YUGnNpejzC+7jDEYueeHwcVeEMba4NyGHRZt81n2xTJw9eAhHqWdq
 pemwPf3yfxLorjmQvgBdSngjCnTMTqK+fylBgK+PCEm4SzwWp8s3iEUBGZ60dr9jd+4G
 ETTSj5+hzBq17aU/mNStvgjvlpLUOTnqfRiwFzxMEXxwibbdpMU6XrDpc53ZNmE4DLf5
 ifNBwAADEeAxhO71tsbAxhGNR6LgYzNcUFM7zyzRPdqEe7JSSxRFu1dAcIL58/govMSI
 GPeHiepPYWwOYJbofPBUMDSrhxcxeYfhPSvhUygtabjFXH+JWgUCnaxzg26JIHfoWf/J eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 337eymqmet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:34:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HTrJ3187005;
        Fri, 4 Sep 2020 17:34:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33b7v30tua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:34:48 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HYkmV014121;
        Fri, 4 Sep 2020 17:34:46 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:34:46 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH v3 0/16] btrfs: seed fix null ptr, use only main device_list_mutex, and cleanups
Date:   Sat,  5 Sep 2020 01:34:20 +0800
Message-Id: <cover.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040152
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3:
Makes bug fixing patches suitable for the backports. They are patch 1-2.
patch 1 fix the put of kobject null issue, fixed by checking the
        state_initalized.
patch 2 fixes the replacement of seed device in a sprout filesystem.

The rest of the patches remains the same, except for a conflict fix in patch 4.

The patch set has passed xfstests -g volume and seed
The new patch (seed delete testing) btrfs/219 has been modified to suit
the older kernels. Which is also attached to this thread.

-------- v2 cover-letter -------
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

These patchset has been tested with full xfstests btrfs test cases.

*** BLURB HERE ***

Anand Jain (16):
  btrfs: fix put of uninitialized kobject after seed device delete
  btrfs: fix replace of seed device
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

 fs/btrfs/dev-replace.c |  66 ++++++++---------
 fs/btrfs/reada.c       |   5 +-
 fs/btrfs/sysfs.c       | 159 +++++++++++++++++++++++++----------------
 fs/btrfs/sysfs.h       |   6 +-
 fs/btrfs/volumes.c     |  40 +++++------
 5 files changed, 147 insertions(+), 129 deletions(-)

-- 
2.25.1

