Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEBE2441D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgHNAED (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:04:03 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33594 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHNAEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:04:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07E03Gmj173591
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=ekf09PaHwRsvaVLRktSJX+dnPc3dxtmLdb4F2Kjd+mE=;
 b=CWXGj2wp7vw47gifI4kUGHvPFYj5kt/oZSA0TT8VcNH6ZzfRgFC6O3BNj5dWXa+58P2V
 9Fd6io877333iQ4LYGQVlxPYy7SBvDvXDHY2dLTGkGpHH88Ar/3V6Zznk259vHz9WaJ0
 pXWrt5+XUtbBihGSoqN2UzMzG8WiTzVR3o+RL729Qx/v/hmLtV/tW2VjzCu8uCA7BS9t
 foDcg8xXOZdthOjxGFRI/WoX5H1Afqwyvs35URArmrz8gVDE1jA5qCoBRsY6lf96GXZQ
 FyZ0WJS19K9OTPUcFsrk1gLEAP8MePGy5M68P5fg/9vSfsDLX+9tCw6Gmeqm32sCF89v +A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32w73capmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DNwct0047035
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32t6046aua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:01 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07E040R3005886
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:01 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 00:04:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/7] btrfs: consolidate seed mutex to sprout mutex
Date:   Fri, 14 Aug 2020 08:03:45 +0800
Message-Id: <20200814000352.124179-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 suspectscore=1 mlxscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In a sprouted btrfs, the seed's fs_devices are cloned and link-
listed under the sprout's fs_devices. The fs_info::fs_devices
points to the sprout::fs_devices and various critical operations
like device-delete holds the top-level device_list_mutex
sprout::fs_devices::device_list_mutex and _not_ the seed level
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

Anand Jain (7):
  btrfs: reada: use sprout device_list_mutex
  btrfs: btrfs_init_devices_late: use sprout device_list_mutex
  btrfs: open code list_head pointer in btrfs_init_dev_replace_tgtdev
  btrfs: cleanup unused return in btrfs_close_devices
  btrfs: cleanup btrfs_assign_next_active_device()
  btrfs: cleanup unnecessary goto in open_seed_device
  btrfs: btrfs_dev_replace_update_device_in_mapping_tree drop file
    global declare

 fs/btrfs/dev-replace.c | 60 +++++++++++++++++++-----------------------
 fs/btrfs/reada.c       |  4 +--
 fs/btrfs/volumes.c     | 42 +++++++++++------------------
 fs/btrfs/volumes.h     |  2 +-
 4 files changed, 46 insertions(+), 62 deletions(-)

-- 
2.18.2

