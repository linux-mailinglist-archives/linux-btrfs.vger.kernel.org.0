Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7798E9FEF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 11:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfH1J41 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 05:56:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52814 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1J41 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 05:56:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S9sCZQ055067
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 09:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=vateWwAhQ0mXkJgL0yvnu8OWavlvWVCBsAbJutyTbLs=;
 b=XSe18Pl7IOXXVhog3jZx4fiymbux4YDet14CLKV6zCC3cjtDUpG6HxV+WqPn+q9uuj9I
 OEjnoWDmr016XpaBjS814URDvQpOCVqEqDEFJ91MF/a+XIC7Gq8GUsAmVG2AZyVmHNe0
 8MnMONyFmoNhBycEEfUScwR4HLWDroFxKyqGsYCLq2gPsHp8AEQ8bcX38roeK/c68SiY
 hU8vXyNapl1wc8IwwNun0NkJafz9leOZpWT1hnNgbfK3PF9DbxZi5k3udh479l+sbph0
 C4iweW/H5JmwuzsJ36u5JbdEFMqGDu6DgO2RLG+VzzLXt79cnwJrZADgqQStURSJMaW9 vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2unpter88n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 09:56:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S9rkLb129141
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 09:56:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2un6q2fhcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 09:56:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7S9uNFJ017589
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 09:56:23 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 02:56:22 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: add BTRFS_DEV_ITEMS_OBJECTID in comment in print-tree
Date:   Wed, 28 Aug 2019 17:56:18 +0800
Message-Id: <20190828095619.9923-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280105
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So when searching for BTRFS_DEV_ITEMS_OBJECTID it hits. Albeit it is
defined same as BTRFS_ROOT_TREE_OBJECTID.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 print-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/print-tree.c b/print-tree.c
index b31e515f8989..5832f3089e3d 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -704,6 +704,7 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 	}
 
 	switch (objectid) {
+	/* BTRFS_DEV_ITEMS_OBJECTID */
 	case BTRFS_ROOT_TREE_OBJECTID:
 		if (type == BTRFS_DEV_ITEM_KEY)
 			fprintf(stream, "DEV_ITEMS");
-- 
2.21.0 (Apple Git-120)

