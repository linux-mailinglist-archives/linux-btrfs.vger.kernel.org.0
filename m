Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4F1257195
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 03:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgHaBil (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 21:38:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgHaBij (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 21:38:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V1ZBNB145764;
        Mon, 31 Aug 2020 01:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=KtTmkeAxArW4Ahxf5tYlNEBfiZCvxdcYEP2tagTxXzA=;
 b=pOLzHqrmXGX8935zoyxilwzkvf6fE11FcNNWrfd4nmpLEKVSyJRWcl1l/B/pypLIZGNb
 2vt11ovpP6kt0HG8Ursp4WBfNbQ1MDVZClGU8lvzkUc5O4qQ8G8y0iIYIvKSooIHHJl9
 HDz5cCfTGwZCtYat25CqwvJ+lB0s6AAiXUqXbZxtFsTdicRH9gXje1Hl4QmfOcO5oDEu
 PShZmyfgsh/52eUwGqp9vBVOdpJduhFniyKHAqeS/k7sHXYc84Fs6XO+96MvIago3R3h
 umIbLN0a78E7AbwMvXvt7ZiJV5hsYLRh0iE92by844JDUAnwL6KzMo18zXQLgFI/tWpw NA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 337eeqkrq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 01:38:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07V1Zbh7145803;
        Mon, 31 Aug 2020 01:38:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3380xu3dm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 01:38:32 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07V1cVNr023583;
        Mon, 31 Aug 2020 01:38:31 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 18:38:30 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 0/11] btrfs: seed fix null ptr, use only main device_list_mutex, and cleanups
Date:   Mon, 31 Aug 2020 09:38:20 +0800
Message-Id: <cover.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310010
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The cover letter for the patchset below [1] doesn't seem to have reached the ML.
So here I am sending it again.

[1]
 https://patchwork.kernel.org/project/linux-btrfs/list/?series=340699

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

