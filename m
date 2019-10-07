Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46DD3CDE73
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 11:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfJGJr2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 05:47:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38842 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfJGJr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 05:47:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cvXx055196
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=uxLnuaTusD6GVlodIfEgcw/hzj4a8hTmmrWsih825Rw=;
 b=jS7cGjpObdIVj0Kc3NnkX6oMy0T4u7C1aTu7LFinunYsHoEHMKh9xbwKcG8DQVTSwkZk
 OSyfX2cNc39nPY9DoK7tRLV+v1d6paSbjOOmK27PRDXhJ2bCi1waW2IWFPM+ZsfBtlog
 wONzbFNvhetVT5tKuR+9qG8dMDgyIyB8PyC9jyHF4xsGkMVzpqjYrwg6Zn95dMPm3AyS
 MSJqXW8RjHRKMWE+omodeIyrs7kVuxlEDI6FNttY+N8FDFghptonbjtbksAaAyIxkaxW
 69LLW0il+DLBoHESgMfP5Mm6eySy/JEDfoxDfnCMPkKCBIcqG/Avnf5fKYBV0YDf69KJ Mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2vektr5gnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:47:26 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x979cddZ099237
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vg203btbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 09:45:26 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x979jPcv022320
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Oct 2019 09:45:25 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Oct 2019 02:45:25 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: remove identified alien device in open_fs_devices
Date:   Mon,  7 Oct 2019 17:45:14 +0800
Message-Id: <20191007094515.925-5-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007094515.925-1-anand.jain@oracle.com>
References: <20191007094515.925-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910070097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9402 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910070097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Following test case explains it all, even though the degraded mount is
successful the btrfs-progs fails to report the missing device.

 mkfs.btrfs -fq -draid1 -mraid1 /dev/sdc /dev/sdd && \
 wipefs -a /dev/sdd && mount -o degraded /dev/sdc /btrfs && \
 btrfs fi show -m /btrfs

 Label: none  uuid: 2b3b8d92-572b-4d37-b4ee-046d3a538495
	Total devices 2 FS bytes used 128.00KiB
	devid    1 size 1.09TiB used 2.01GiB path /dev/sdc
	devid    2 size 1.09TiB used 2.01GiB path /dev/sdd

This is because btrfs-progs does it fundamentally wrong way that
it deduces the missing device status in the user land instead of
refuting from the kernel.

At the same time in the kernel when we know that there is device
with non-btrfs magic, then remove that device from the list so
that btrfs-progs or someother userland utility won't be confused.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 326d5281ad93..e05856432456 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3417,7 +3417,7 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 	if (btrfs_super_bytenr(super) != bytenr ||
 		    btrfs_super_magic(super) != BTRFS_MAGIC) {
 		brelse(bh);
-		return -EINVAL;
+		return -EUCLEAN;
 	}
 
 	*bh_ret = bh;
-- 
1.8.3.1

