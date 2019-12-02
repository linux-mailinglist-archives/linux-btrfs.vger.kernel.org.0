Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7EC10E7E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Dec 2019 10:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLBJpC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Dec 2019 04:45:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59596 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfLBJpB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Dec 2019 04:45:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB29iJ9L013552;
        Mon, 2 Dec 2019 09:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=v7aCVqP10Bliu5qcSrYz1ekCDEGwwhHbKW1BcO24CVc=;
 b=ii21dX6UsYlzMS2JAtHJ1iQ8z6bQC8vEzMOIdl8DW9OBZyV91PGOYWZh00abrq4YNn5W
 Od+eyY2n9n1RGDeZ71rnFPFo3hNiXyQUCOQ35/CmQfxYmEdrecipUadCECoJYU/u38p/
 qPz20SVR/c9WNiZEWzwu7IFVCByFvO+ocye2N1sM8BaxnQgSafnCYz7eL24laivmvAPn
 Doxl1tWjp8+SafdUAG/xapSIWa2gYvmJoxVnm5FSvHsL7RdgApPjjGIancCT2jbP94z0
 upv5lH5O75c7uOz/3chYrDykaEwiiYbnBVpsinpFHWWqnuo8w4Wn/XNwL9r51z+DN9Zl RA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2wkh2qxp1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 09:44:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xB29iGNV140238;
        Mon, 2 Dec 2019 09:44:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wm2jm37da-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Dec 2019 09:44:56 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xB29isg0014750;
        Mon, 2 Dec 2019 09:44:55 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Dec 2019 01:44:54 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     calestyo@scientia.net
Subject: [PATCH] btrfs: fix warn_on for send from readonly mount
Date:   Mon,  2 Dec 2019 17:44:50 +0800
Message-Id: <20191202094450.1377-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912020088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9458 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912020089
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

Fix this by checking for the expected ORPHAN_CLEANUP_DONE only if the
filesystem is in writable state.

Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ae2db5eb1549..e3acec8aa8de 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7085,9 +7085,11 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 	/*
 	 * This is done when we lookup the root, it should already be complete
-	 * by the time we get here.
+	 * by the time we get here, unless the filesystem is readonly where the
+	 * orphan_cleanup_state is never started.
 	 */
-	WARN_ON(send_root->orphan_cleanup_state != ORPHAN_CLEANUP_DONE);
+	if (!sb_rdonly(file_inode(mnt_file)->i_sb))
+		WARN_ON(send_root->orphan_cleanup_state != ORPHAN_CLEANUP_DONE);
 
 	/*
 	 * Userspace tools do the checks and warn the user if it's
-- 
2.23.0

