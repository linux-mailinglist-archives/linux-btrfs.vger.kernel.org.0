Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E5156DC8
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2020 04:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBJDN3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Feb 2020 22:13:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJDN2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Feb 2020 22:13:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01A39Q2U166676;
        Mon, 10 Feb 2020 03:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=82bzNdxKtj5UuSLiZn/xbNCmJYFeBE901hOp2eyTKfA=;
 b=xqBbzlnoywLwE5kasQhFtmXJ2vQXPwZCiwlo4SYK0eWn+ok16ksXPW3L2leduuL2aFTm
 SFPwtiT6+G8qCwkt73qrBMBBoLUSlbEFnKr7CLUp4wFrrHN3PvgmwjTdDtCAe4iwptLN
 RsT5Pt2im36JcgaSwLgSD4jP56sC5s0iLEdqpckFNTnnHwPMZuRgKezVFuNib3TCrfCW
 XOuAtVkA0TXaCA0KA1RFGai9QGnhd1CuJ29xvrGx7id5lwOl9k+W9CylZFS9HJhG+FD3
 Fl+7hagCAuwLzXR/cUrD+X+rtNUXc404l7C5aOefYKFYeoooaaSEKa176E16PYo25iVS kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y2k87s9bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 03:13:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01A3715S055303;
        Mon, 10 Feb 2020 03:13:27 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2y26fe7b0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 03:13:27 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01A3DQvk027084;
        Mon, 10 Feb 2020 03:13:26 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 09 Feb 2020 19:13:25 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: common/btrfs: use complete sub command
Date:   Mon, 10 Feb 2020 11:13:22 +0800
Message-Id: <20200210031322.1177-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9526 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=13
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100024
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9526 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=13 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100024
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Grep failed to find this subcommand of btrfs, leading to a wrong
inference for a moment.

Make sure we use the full subcommand name in the btrfs command.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/btrfs b/common/btrfs
index 19ac7cc4b18c..33ad7e3b41cc 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -7,7 +7,7 @@ _btrfs_get_subvolid()
 	mnt=$1
 	name=$2
 
-	$BTRFS_UTIL_PROG sub list $mnt | grep $name | awk '{ print $2 }'
+	$BTRFS_UTIL_PROG subvolume list $mnt | grep $name | awk '{ print $2 }'
 }
 
 # _require_btrfs_command <command> [<subcommand>|<option>]
-- 
1.8.3.1

