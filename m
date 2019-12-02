Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A626E10EB7E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 15:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfLBOYw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 09:24:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57570 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfLBOYv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 09:24:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2EOPVN060867
        for <linux-btrfs@vger.kernel.org>; Mon, 2 Dec 2019 14:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=HZAJehdKe2atmrPigMUydR8Wm0G2r2k955G8jEPtvfw=;
 b=qr+6pZYVs9rzvjSdKEICQ0+po1ISdCuQ9WMgRvIotZR0syxi1f4D9Tg6AmyV/u/xajoV
 qlXPy3t/JcIwaOLuT3sBajQDf3+CAe38wG9DrL9Em9dcly1jXDvRbebWnR+z7LISS5cB
 CeMLgDl9Vl7ZcvKrP/Lq2KxFbJlh//RlgCE8NloHpq1MJCLzmA/6lU35duuKDFMTgtvJ
 1kxHgQsjHDi8MOvGmyP7Ui8AyLOAHKcGGL220dpv4SqOGAcBdRL77uWExuvmKyg0qBMj
 WPtQooj7G3HKq/jLBQgD2J6kZh+Czo9OnhQVbIUga8yWMzEXcgMY0JPQ5p2peuS8yDyF gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wkfuu0bp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 14:24:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB2EOSSM139154
        for <linux-btrfs@vger.kernel.org>; Mon, 2 Dec 2019 14:24:49 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2wm2jvx0gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Dec 2019 14:24:49 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB2EOlg1030463
        for <linux-btrfs@vger.kernel.org>; Mon, 2 Dec 2019 14:24:48 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 06:24:47 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: fix warn_on for send from readonly mount
Date:   Mon,  2 Dec 2019 22:24:36 +0800
Message-Id: <1575296676-16470-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20191202094450.1377-1-anand.jain@oracle.com>
References: <20191202094450.1377-1-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020129
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We log warning if root::orphan_cleanup_state is not set to
ORPHAN_CLEANUP_DONE in btrfs_ioctl_send(). However if the filesystem is
mounted as readonly we skip the orphan items cleanup during the lookup
and root::orphan_cleanup_state remains at the init state 0 instead of
ORPHAN_CLEANUP_DONE (2).

WARNING: CPU: 0 PID: 2616 at /Volumes/ws/btrfs-devel/fs/btrfs/send.c:7090 btrfs_ioctl_send+0xb2f/0x18c0 [btrfs]
::
RIP: 0010:btrfs_ioctl_send+0xb2f/0x18c0 [btrfs]
::
Call Trace:
::
_btrfs_ioctl_send+0x7b/0x110 [btrfs]
btrfs_ioctl+0x150a/0x2b00 [btrfs]
::
do_vfs_ioctl+0xa9/0x620
? __fget+0xac/0xe0
ksys_ioctl+0x60/0x90
__x64_sys_ioctl+0x16/0x20
do_syscall_64+0x49/0x130
entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reproducer:
  mkfs.btrfs -fq /dev/sdb && mount /dev/sdb /btrfs
  btrfs subvolume create /btrfs/sv1
  btrfs subvolume snapshot -r /btrfs/sv1 /btrfs/ss1
  umount /btrfs && mount -o ro /dev/sdb /btrfs
  btrfs send /btrfs/ss1 -f /tmp/f

Fix this by removing the warn_on completely because:

1) Having orphan items means we could have files to delete (link count
of 0) and dealing with such cases could make send fail for several
reasons.
   If this happens, it's not longer a problem since the following
commit:
   46b2f4590aab71d31088a265c86026b1e96c9de4
   Btrfs: fix send failure when root has deleted files still open

2) Orphan items used to indicate previously unfinished truncations, in
which case it would lead to send creating corrupt files at the
destination (i_size incorrect and the file filled with zeroes between
real i_size and stale i_size).
   We no longer need to create orphans for truncations since commit:
   f7e9e8fc792fe2f823ff7d64d23f4363b3f2203a
   Btrfs: stop creating orphan items for truncate

Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
Suggested-by: Filipe Manana <fdmanana@gmail.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
 Remove WARN_ON() completely.

 fs/btrfs/send.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ae2db5eb1549..091e5bc8c7ea 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7084,12 +7084,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	spin_unlock(&send_root->root_item_lock);
 
 	/*
-	 * This is done when we lookup the root, it should already be complete
-	 * by the time we get here.
-	 */
-	WARN_ON(send_root->orphan_cleanup_state != ORPHAN_CLEANUP_DONE);
-
-	/*
 	 * Userspace tools do the checks and warn the user if it's
 	 * not RO.
 	 */
-- 
1.8.3.1

