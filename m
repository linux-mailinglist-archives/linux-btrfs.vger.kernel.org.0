Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E577A13A0DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 07:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgANGJg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 01:09:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:34338 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgANGJg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 01:09:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E6835L128377;
        Tue, 14 Jan 2020 06:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=CtiCPqxxSvOBDKi0gLrFRaiaJsq6T8diXr/NVdRKWF0=;
 b=ZXj4GlKjqkEFS6OQlCs2ivvO3Hvj61A4IVgNkYBVbq/+Tuc3QPFfQoDYehWflbyNAWZK
 74yLB20XwVsLKiZTEsr9M235v/AT+UhuS2w5nMyw/1EjbdW+yKABg3NnQLMeSmXuat8U
 a6Vb7v7/2nzfxENIyeDBKLGx6Ed+ipcIIbJ1xg6JfdxEyvYmGHeiZ62ZAa0QdazmJwxr
 9OHAB5281A1dghOBZN/Tq9rXndFtaTzrrZDyAIwV3VB1VeGl3G7KD/aE1qQRxBuSVyEy
 bOdB2wrahewsOdYGjzFvozpA7m2HF/HKIuTYbKp4FEgNo+lLa92qqsgTdkL+0GYbJAQz 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xf73ybs36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:09:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E690tO193964;
        Tue, 14 Jan 2020 06:09:32 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xh30ytvv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:09:32 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00E69VVc021625;
        Tue, 14 Jan 2020 06:09:31 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 22:09:31 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 4/4] btrfs: use btrfs consistent logging wrappers
Date:   Tue, 14 Jan 2020 14:09:20 +0800
Message-Id: <20200114060920.4527-4-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200114060920.4527-1-anand.jain@oracle.com>
References: <20200114060920.4527-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001140054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9499 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001140054
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now as we could use the btrfs_info(), btrfs_warn() etc.. in the context
where fs_info is not yet initialized, so replace pr_info with btrfs_info
in device_list_add() for a consistent log format from btrfs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bafc57bc02c8..e30747949074 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -824,13 +824,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		*new_device_added = true;
 
 		if (disk_super->label[0])
-			pr_info(
-	"BTRFS: device label %s devid %llu transid %llu %s scanned by %s (%d)\n",
+			btrfs_info(NO_FS_INFO,
+	"device label %s devid %llu transid %llu %s scanned by %s (%d)",
 				disk_super->label, devid, found_transid, path,
 				current->comm, task_pid_nr(current));
 		else
-			pr_info(
-	"BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s (%d)\n",
+			btrfs_info(NO_FS_INFO,
+	"device fsid %pU devid %llu transid %llu %s scanned by %s (%d)",
 				disk_super->fsid, devid, found_transid, path,
 				current->comm, task_pid_nr(current));
 
-- 
2.23.0

