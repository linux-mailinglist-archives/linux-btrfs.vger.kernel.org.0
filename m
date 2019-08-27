Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0DFD9DEEE
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 09:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfH0HmN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 03:42:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfH0HmN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 03:42:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R7dd5v088743
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=riwgwW1CIJ5aSNLwGnyjFYpDTYGGHaHbSEm9WX+uzPU=;
 b=IQ6wIxIJnlkrww9tqtSadksu7ptaRipKUspjXaIQNtzxJy/fa/TvzrMtQ9GLurOVtw0b
 jCBSBuzwsw0bu5r15NabRd4/qRaAPYw5k0nmOZuQ4JFgRq6PUsDBjVyP/8mfonaZg4jI
 v/VaoMfdtN7Qh7n6H427xItpo2VcCsJf8nZY8RtjHjKn+8Axa9gMxWO+1Bt+EQY3i8Zl
 9WYwz5GA1laVkKunaNbIhDOwWSwv0CTR9cerJY6pavNqjgugFLpKHluMOFOxLXynqrED
 JBSsCLsC9kERsswx1LWdmNQpVJetqvqvv05MGC11lgFx4zLwSUa7D9Gf0ph2b9XESz9t Fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2un0amg0dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:42:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7R7cVnE113645
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:41:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2umj2yb7hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:41:11 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7R7fA0W019886
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 07:41:10 GMT
Received: from localhost.localdomain (/183.90.37.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 00:41:09 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: fix BUG_ON with proper error handle in find_next_devid
Date:   Tue, 27 Aug 2019 15:40:44 +0800
Message-Id: <20190827074045.5563-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190827074045.5563-1-anand.jain@oracle.com>
References: <20190827074045.5563-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=996
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270085
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In a corrupted tree if search for next devid finds the device with
devid = -1, then report the error -EUCLEAN back to the parent
function to fail gracefully.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4db4a100c05b..36aa5f79fb6c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1849,7 +1849,12 @@ static noinline int find_next_devid(struct btrfs_fs_info *fs_info,
 	if (ret < 0)
 		goto error;
 
-	BUG_ON(ret == 0); /* Corruption */
+	if (ret == 0) {
+		/* Corruption */
+		btrfs_err(fs_info, "corrupted chunk tree devid -1 matched");
+		ret = -EUCLEAN;
+		goto error;
+	}
 
 	ret = btrfs_previous_item(fs_info->chunk_root, path,
 				  BTRFS_DEV_ITEMS_OBJECTID,
-- 
2.21.0 (Apple Git-120)

