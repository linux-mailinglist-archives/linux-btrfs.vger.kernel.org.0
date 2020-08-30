Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5C256EB1
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgH3Ol7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:41:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59128 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgH3Ol0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEXx2t130645;
        Sun, 30 Aug 2020 14:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=2zDE+PhlyK+3qqQ4/bGOYi80DoGQP/Yl1cGfWXIidzk=;
 b=oRU3m7DWWOtDMOQl6NZ5UbJu6j3O3tppUtiyVM2E86f9oe4QvgmDGHcj0wsysrY6WoyL
 E6RFg/uw+B5LR5H5rXIOwDlzI48R5XiJ9enptnyKPeftDwcSu95VOcWlObF8Wv8L3jmG
 arKWL8144RJlyFQBH4qLTfba+sF28g/EZaEfXOh7CDcoPTcpr7aOV4UW60QlD3glcQQL
 jUYURcN+9Zm3vcIna5piq7LVYQq7BOX3xRXlDoquV3LYN6eyTsT2F6jVaP8tTIx9MoOq
 zubhh6ucGAOEseXsoSrnhx+Kf6jm0SrQdufHi0HjPDza2XqYqqRrlOqFMXl+gLFkOAhi 9A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 337qrha2ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEaqV9138895;
        Sun, 30 Aug 2020 14:41:20 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3380sp0uj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:20 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07UEfIYe030134;
        Sun, 30 Aug 2020 14:41:18 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:18 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: 
Date:   Sun, 30 Aug 2020 22:40:55 +0800
Message-Id: <cover.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=1 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Subject: [PATCH 0/11] btrfs: seed fix null ptr, use only main device_list_mutex, and cleanups

v2:
Rebased on latest misc-next which contains the seed_list from Nicolas.
This patchset has been sent before as two sets, here it is been merged.

Patches 1/11 fix the null kobject being put, which is observed with kernel
compiled with memory poisoning.
Patches 2/11 and 3/11 are cleanups to maintain better flow in the
functions btrfs_sysfs_add_devices_dir() and btrfs_sysfs_remove_devices_dir().
Patches 4/11 and 5/11 drops the last two users of seed device_list_mutex,
so now they hold main filesystem device_list_mutex. 
Patches [6-10]/11 are cleanups.
Patches 11/11 fix the replacement of seed device in a sprouted. It is safe
to block that because we also block the replace of seed if it isn't a sprouted
device.

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
found to have no new regressions.


Anand Jain (11):
  btrfs: initialize sysfs devid and device link for seed device
  btrfs: refactor btrfs_sysfs_add_devices_dir
  btrfs: refactor btrfs_sysfs_remove_devices_dir
  btrfs: reada: use sprout device_list_mutex
  btrfs: btrfs_init_devices_late: use sprout device_list_mutex
  btrfs: open code list_head pointer in btrfs_init_dev_replace_tgtdev
  btrfs: cleanup btrfs_remove_chunk
  btrfs: cleanup btrfs_assign_next_active_device()
  btrfs: cleanup unnecessary goto in open_seed_device
  btrfs: btrfs_dev_replace_update_device_in_mapping_tree drop file
    global declare
  btrfs: fix replace of seed device

 fs/btrfs/dev-replace.c |  66 ++++++++----------
 fs/btrfs/reada.c       |   5 +-
 fs/btrfs/sysfs.c       | 151 ++++++++++++++++++++++++-----------------
 fs/btrfs/sysfs.h       |   8 +--
 fs/btrfs/volumes.c     |  40 +++++------
 5 files changed, 143 insertions(+), 127 deletions(-)

-- 
2.25.1

