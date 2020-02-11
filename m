Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50351586D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 01:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgBKAp4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Feb 2020 19:45:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37816 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgBKAp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Feb 2020 19:45:56 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B0cJ5g094295;
        Tue, 11 Feb 2020 00:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=Fg/X0AtLEc+Zkh7pPYRaOzqen8ezxm2r5jSJkg4R7SM=;
 b=Rr7gIObxKBo63ub7By3oPe93xF55FgpsyyMpUEbGTZjz3Ar1+/3UTATQobsEhhqLpRuj
 gcimqB70EF9Zzwh6aOhuJPm5rdbVCqsXa4B2rhNSVrk8Hzbs8y4JNnbN1LEHkzfTzqeZ
 QDfvp12yi12s3nsRoAC8jli9s20PkoBK63pL7vz5fw8uNZOzdcZiMTC7jcxF4n+B+aJe
 H2YdX/npr0bb85oFbGEtVZIF05/dpZeoKlYrNExQLfLC14OP1lJ647B/1jjSN103zias
 aUnZrUiRE81cxESgtpeAmEjI9cZEoI8mJt+RjWuNW9ugP3a5+Isl9I6elK88emNTz017 Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2y2k8807bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 00:45:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01B0b3TI105149;
        Tue, 11 Feb 2020 00:45:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2y26fg5mgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 00:45:51 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01B0joB2019826;
        Tue, 11 Feb 2020 00:45:51 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Feb 2020 16:45:50 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, mpdesouza@suse.com
Subject: [PATCH v2] fstests: common/btrfs: use complete sub command
Date:   Tue, 11 Feb 2020 08:45:11 +0800
Message-Id: <1581381911-6727-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=13
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9527 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=13 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110001
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Search for 'subvolume' in the file common/btrfs failed to find all of
them, leading to a wrong inference for a moment.

Make sure we use the full subcommand name in the btrfs command.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Marcos Paulo de Souza <mpdesouza@suse.com>
---
v2: Update commit log.

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

