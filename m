Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71ECA13A0DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 07:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgANGJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 01:09:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:50694 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgANGJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 01:09:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E68kTa111898;
        Tue, 14 Jan 2020 06:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=qbRDopoPiVC+/A1w3lHLf1Jces+GdVdKkEAc/ne6cMU=;
 b=QSfxLFo0WTuO0gOuRUX4TDP7jN9YOIoLh9CHyne0dTw/TVD+7+3vI127umuuM0iDPHgv
 fKKe6SU5g2etIk8FXLC26uD8v9cjsopBC5Ebr1OO16nULU/eP0eXNVg/753aGxf3QlhO
 qYO6AG13ro1GbQ4Tsg3JRWg0o7451e+VG2GzjTUuLWqts1AJi345eoi1s7dYR000+ejk
 OeClpBDAG7XlZDRVN2cUS6bXx/2KZmDSr+TOn765BIGirnJvL+9vzjpRqvQCUxJnYqo6
 vzCD3BZcPw14PYyTNM9XnkaQCm6ZJZGtnQMkB5WWnJESAH1fOtYx8IMjYvyWh25M2fUC kQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xf73tknwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:09:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00E68j3E109507;
        Tue, 14 Jan 2020 06:09:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xh2tn4ryp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 06:09:30 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00E69TE7031395;
        Tue, 14 Jan 2020 06:09:30 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 22:09:29 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 3/4] btrfs: make the scan logs consistent
Date:   Tue, 14 Jan 2020 14:09:19 +0800
Message-Id: <20200114060920.4527-3-anand.jain@oracle.com>
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

Typically we follow, a logging format <parameter> <value> and no ":"
so just follow that here.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
David,
If required you may roll this into the patch 2/4 in this series. I didn't
dare, as there may be some concerns that it isn't relevent there.

 fs/btrfs/volumes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0301c3d693d8..bafc57bc02c8 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -890,14 +890,14 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				bdput(path_bdev);
 				mutex_unlock(&fs_devices->device_list_mutex);
 				btrfs_warn_in_rcu(NO_FS_INFO,
-			"duplicate device fsid:devid for %pU:%llu old:%s new:%s",
+			"duplicate device fsid %pU devid %llu exisitng %s new %s",
 					disk_super->fsid, devid,
 					rcu_str_deref(device->name), path);
 				return ERR_PTR(-EEXIST);
 			}
 			bdput(path_bdev);
 			btrfs_info_in_rcu(NO_FS_INFO,
-				"device fsid %pU devid %llu moved old:%s new:%s",
+				"device fsid %pU devid %llu moved old %s new %s",
 				disk_super->fsid, devid,
 				rcu_str_deref(device->name), path);
 		}
-- 
2.23.0

