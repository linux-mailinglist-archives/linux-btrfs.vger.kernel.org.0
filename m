Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E225A2FCC20
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 08:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbhATHyl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 02:54:41 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbhATHxX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 02:53:23 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K7nYaj018080;
        Wed, 20 Jan 2021 07:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=38xJSaHSFd/n+oRh4yQFViLuYZXA/Tkon1mXwEVxs+M=;
 b=a96yGIQr1BPApJPXevj1i4TXIjV0sayXXQrVQULYUVdOO+3GbBvBfm5QZVrn9V0C/ewk
 knUoPrKQ/+zUHz2PhPsiLWUi/ag7wS2CXOnNLA59LhQ3gldj8JSBJwegLsSVqSUMohUu
 plVDVX/n7AjP2fZKcRz/gFW7sYzyz/7/JxvtWYhZQTzjY/teNRySl6sJtLesfHDpWuUJ
 bY+z6N9alldCDecHA9yAx+WST4zZSUmx6+loUQbERewCBAJRXzb31dlWAtiwfP2yL35S
 buuYyeLVte4lgbGD9m3L6yOJ/pbrxj7VvNyZaQbkt17SssmW4D3xFDQQ9PxCQYB73Nn4 eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3668qa95bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 07:52:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10K7nnae162454;
        Wed, 20 Jan 2021 07:52:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 3668rdgmfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 07:52:12 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10K7qCag009474;
        Wed, 20 Jan 2021 07:52:12 GMT
Received: from ca-dev104.us.oracle.com (/10.129.135.33)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 23:52:12 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH v4 0/3] btrfs: read_policy types latency, device and round-robin
Date:   Tue, 19 Jan 2021 23:52:04 -0800
Message-Id: <cover.1611114341.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200043
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200043
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v4:
Add rb from Josef in patch 1 and 3.
In patch 1/3, use fs_info instead of device->fs_devices->fs_info.
Drop round-robin policy because my workload (fio random) shows no performance
 gains due to fewer merges at the block layer.

v3:
The block layer commit 0d02129e76ed (block: merge struct block_device and
struct hd_struct) has changed the first argument in the function
part_stat_read_all() in 5.11-rc1. So trickle down its changes in the patch 1/4.

v2:
Fixes as per review comments, as in the individual patches.

rfc->v1:
Drop the tracing patch.
Drop the factor associated with the inflight commands (because there
were too many unnecessary switches).
Few C styles fix.

-----

This patchset adds read policy types latency, device, and round-robin, for the
mirrored raid profiles such as raid1, raid1c3, raid1c4, and raid10. The default
read policy remains as PID, as of now.

Read policy types:
Latency:

Latency policy routes the read IO based on the historical average
wait time experienced by the read IOs on the individual device.

Device:

With the device policy along with the read_preferred flag, you can
set the device for reading manually. Useful to test mirrors in a
deterministic way and helps advance system administrations.

Round-robin (RFC patch):

Alternates striped device in a round-robin loop for reading. To achieve
this first we put the stripes in an array, sort it by devid and pick the
next device.

Test scripts:
=============

I have included a few scripts which were useful for testing.

-------------------8<--------------------------------
Set latency policy on the btrfs mounted at /mnt

Usage example:
  $ readpolicyset /mnt latency

Anand Jain (3):
  btrfs: add read_policy latency
  btrfs: introduce new device-state read_preferred
  btrfs: introduce new read_policy device

 fs/btrfs/sysfs.c   | 57 ++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  5 ++++
 3 files changed, 121 insertions(+), 1 deletion(-)

-- 
2.28.0

