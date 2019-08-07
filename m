Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D4B84703
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbfHGIVK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 04:21:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42288 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbfHGIVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 04:21:10 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x778Iu9Q192061;
        Wed, 7 Aug 2019 08:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=LAiC2L/LXx573r+O05hiX0P3ZAMIcxpigkv3UcuZiAY=;
 b=gc/R+qUwSkA1EnhDSypJLaiQq5jiQbitBd6uqOq1qau1KW6IXmPf/sirxoO8DfH6UloY
 eRK08yCOdNYMyMnHgbdokVoXEvsxHsbZQ/Ya1bbuJGsO8uhWgPwmUopfOUUi3FlPXYPc
 f/5fpetK6VuteMR3fWEh2Ra0ur11KHIIMWNytfEwnMUVf9DzUPfPAnZegal7tAgCXk/Z
 3iGV4JJ3BdC+qDnUnUAi9n9/EQMkLCG7HWTBbFNBiauSJEcWL9zDbm3TEGUWQn4sQ2re
 NnjZQC3IkbzqVvssAIhG1ePONR6HwJj40XVmeMuaPV6W69kCooOyRSIIIepk2HLNsabr gg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u52wrarcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 08:21:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x778I5vX070009;
        Wed, 7 Aug 2019 08:21:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u7667c3rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Aug 2019 08:21:00 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x778KxqB016166;
        Wed, 7 Aug 2019 08:20:59 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 01:20:58 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com
Subject: [PATCH] btrfs: trim: fix range start validity check
Date:   Wed,  7 Aug 2019 16:20:54 +0800
Message-Id: <20190807082054.1922-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070090
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the whole
filesystem) makes sure we always trim starting from the first block group.
However it also removed the range.start validity check which is set in the
context of the user, where its range is from 0 to maximum of filesystem
totalbytes and so we have to check its validity in the kernel.

Also as in the fstrim(8) [1] the kernel layers may modify the trim range.

[1]
Further, the kernel block layer reserves the right to adjust the discard
ranges to fit raid stripe geometry, non-trim capable devices in a LVM
setup, etc. These reductions would not be reflected in fstrim_range.len
(the --length option).

This patch undos the deleted range::start validity check.

Fixes: 6ba9fc8e628b (btrfs: Ensure btrfs_trim_fs can trim the whole filesystem)
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
  With this patch fstests generic/260 is successful now.

 fs/btrfs/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b431f7877e88..9345fcdf80c7 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -521,6 +521,8 @@ static noinline int btrfs_ioctl_fitrim(struct file *file, void __user *arg)
 		return -EOPNOTSUPP;
 	if (copy_from_user(&range, arg, sizeof(range)))
 		return -EFAULT;
+	if (range.start > btrfs_super_total_bytes(fs_info->super_copy))
+		return -EINVAL;
 
 	/*
 	 * NOTE: Don't truncate the range using super->total_bytes.  Bytenr of
-- 
2.21.0 (Apple Git-120)

