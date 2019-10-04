Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3015CCB57A
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 09:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfJDHuY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 03:50:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48584 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfJDHuY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Oct 2019 03:50:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x947n5Xr064747
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=l1pYuZ/O4diRIhEgNr3zsJTiTmY6XxIPtGHHKhWFzPM=;
 b=Wu3RbGZisYwaixymgIXoAfYIuTPsS6dwIeWRtX0jiJRasareqTTkp3ENN8est5hwO9fO
 SSQ56g/wcPrcTJAMOLv46lqs6KFyj0CitvrUA36gsQs5brvZzhiJMdwn8aa/sMsP6WQ5
 TBuSYCzX5bTOIMTBmR1N7V+MpRaAjWLLMAhjh/iCkESvzZB3ZoVgEbtHklY1iV3u8ewO
 EgRwE8uVT4ygNyjre50gLW8nZqYduMpRQ3syP35F+OrYWqZ/wfBTzPfjEcPAOOP+9VoJ
 nkCmBj3D6cQuFjOy4mDyfQHxLeOCqd0w6zJLrzOZb0vNV1vj94r2eDGd30pW3SpWMT2C WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2v9yfqshna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:50:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x947mLBf129786
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vdn196brd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2019 07:50:22 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x947oLJY024444
        for <linux-btrfs@vger.kernel.org>; Fri, 4 Oct 2019 07:50:21 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Oct 2019 00:50:20 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: include non-missing as a qualifier for the latest_bdev
Date:   Fri,  4 Oct 2019 15:50:02 +0800
Message-Id: <1570175403-4073-4-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
References: <1570175403-4073-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910040072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9399 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910040072
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_free_extra_devids() reorgs fs_devices::latest_bdev
to point to the bdev with greatest device::generation number.
For a typical-missing device the generation number is zero so
fs_devices::latest_bdev will never point to it.

But if the missing device is due to alienating [1], then
device::generation is not-zero and if it is >= to rest of
device::generation in the list, then fs_devices::latest_bdev
ends up pointing to the missing device and reports the error
like this [2]

[1]
mkfs.btrfs -fq /dev/sdd && mount /dev/sdd /btrfs
mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb /dev/sdc
sleep 3 # avoid racing with udev's useless scans if needed
btrfs dev add -f /dev/sdb /btrfs

mount -o degraded /dev/sdc /btrfs1

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
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 05ade8c7342b..6c42048ec099 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1186,6 +1186,8 @@ void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices, int step)
 							&device->dev_state)) {
 			if (!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
 			     &device->dev_state) &&
+			    !test_bit(BTRFS_DEV_STATE_MISSING,
+			     &device->dev_state) &&
 			     (!latest_dev ||
 			      device->generation > latest_dev->generation)) {
 				latest_dev = device;
-- 
1.8.3.1

