Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 689FE11403D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 12:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbfLELjX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 06:39:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47166 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLELjX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Dec 2019 06:39:23 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BcsTF083141
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=ME1m7LsWift1rg0lPspJ4DWNHW/XsOhCYf5t+2347+Q=;
 b=JC4nH7E/H3q4Agx4lDBLxVl0S1exw3fZNWfG2f6HiScATYGWhf4qWq9CsNOEH6uYEKZm
 d59E3j6cls/ersBkA9M+RC4mbW8kQyj/TS5oPIaKz5m43j6KxOfX7Bvz3feEDF+bqyGj
 fpw499hAsLtdBfefbfoicAoP/4vow926AWBhvlp1FNcVfbF8rnQuK7CT0cqgqc38rkjS
 mol0++9bavKMkEn6FgfHbs5lNxGFxdzSTGXpUIRndnOLf9YQLCON/czccMNI3lOAT8Tn
 id1M5Lm0Goe5UTd1bFzsjqBMrqo2INRXztTV3oogVp9Rhb60S1sTc0F6vGNSyZgLUdFR BQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2wkgcqmghx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:39:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB5BdCor108575
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:39:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2wpp73yywk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Dec 2019 11:39:19 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xB5BdBsx026983
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Dec 2019 11:39:12 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 05 Dec 2019 03:39:11 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: fix warn_on for send from readonly mount
Date:   Thu,  5 Dec 2019 19:39:07 +0800
Message-Id: <20191205113907.8269-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191202094450.1377-1-anand.jain@oracle.com>
References: <20191202094450.1377-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912050097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9461 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912050097
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We log warning if root::orphan_cleanup_state is not set to
ORPHAN_CLEANUP_DONE in btrfs_ioctl_send(). However if the filesystem is
mounted as readonly we skip the orphan items cleanup during the lookup
and root::orphan_cleanup_state remains at the init state 0 instead of
ORPHAN_CLEANUP_DONE (2). So during send in btrfs_ioctl_send() we hit
the warning as below.

  WARN_ON(send_root->orphan_cleanup_state != ORPHAN_CLEANUP_DONE);

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

The warning exists because having orphan inodes could confuse send
and cause it to fail or produce incorrect streams.
The two cases that would cause such send failures, which are already
fixed are:

1) Inodes that were unlinked - these are orphanized and remain with a link
count of 0. These caused send operations to fail because it expected to
always find at least one path for an inode. However this is no longer a
problem since send is now able to deal with such inodes since commit
46b2f4590aab ("Btrfs: fix send failure when root has deleted files still
open") and treats them as having been completely removed (the state after
a orphan cleanup is performed).

2) Inodes that were in the process of being truncated. These resulted in
send not knowing about the truncation and potentially issue write
operations full of zeroes for the range from the new file size to the old
file size. This is no longer a problem because we no longer create orphan
items for truncation since commit f7e9e8fc792f ("Btrfs: stop creating
orphan items for truncate").

As such before these commits, the WARN_ON here provided a clue in case
something went wrong. Instead of being a warning against the
root::orphan_cleanup_state value, it could have been more accurate by
checking if there were actually any orphan items, and then issue a warning
only if any exists, but that would be more expensive to check. Since
orphanized inodes no longer cause problems for send, just remove the warning.

Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
Link: https://lore.kernel.org/linux-btrfs/21cb5e8d059f6e1496a903fa7bfc0a297e2f5370.camel@scientia.net/
Suggested-by: Filipe Manana <fdmanana@gmail.com>
[ Remove warn_on() part, and its reasoning ]
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Commit log updated.
v2: Remove WARN_ON() completely.
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

