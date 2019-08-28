Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 844D9A043B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 16:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfH1OGT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 10:06:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36522 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfH1OGT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 10:06:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SE4PoJ072842
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 14:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=6evHoGkImwjGjg4F23rql4BpXDhsBT+OBarfveO3ATw=;
 b=nYhVC9gDwEYpsZhgLfL7n6jNlLanYswHxPmNSU/9XcB0RJS4lYb19uz6AobCwDk2RlUi
 5WLzdoDaQEzYYd8Jh8HcT1fSPkPpC806QcV8Ucog5Yu7A6WO35nnJdWMTd2sxEdRjPoN
 lhgEkCrYW7MoRADzj0tIgvN8AaC1ZdI5Y8AfHgm2WbJQ7TK58NGLIbrcgRSE96jrUjkC
 DvWlzP+3bSerQYVhTtCHbnr/d8rGIkISkAJ7rOEw23VALMDbz5HSERLmgaXj9xYMou9l
 KKxgJxVquiKC0vsS67/gKdZT5HLqrOe1e4dY9Eoqtkea29mTd61ExbUklj/Mqh8B5D2J HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2untrv06c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 14:06:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7SE4U6P183356
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 14:06:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2unteta364-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 14:06:17 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7SE6Gdc005366
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 14:06:16 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 07:06:16 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs-progs: add BTRFS_DEV_ITEMS_OBJECTID in comment in print-tree
Date:   Wed, 28 Aug 2019 22:06:05 +0800
Message-Id: <20190828140605.20790-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190828095619.9923-1-anand.jain@oracle.com>
References: <20190828095619.9923-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908280147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9362 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908280147
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

So when searching for BTRFS_DEV_ITEMS_OBJECTID, it hits, albeit it is
defined same as BTRFS_ROOT_TREE_OBJECTID.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1->v2: Improve comment.

 print-tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/print-tree.c b/print-tree.c
index b31e515f8989..b1c59d776547 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -705,6 +705,11 @@ void print_objectid(FILE *stream, u64 objectid, u8 type)
 
 	switch (objectid) {
 	case BTRFS_ROOT_TREE_OBJECTID:
+		/*
+		 * BTRFS_ROOT_TREE_OBJECTID and BTRFS_DEV_ITEMS_OBJECTID are
+		 * defined with the same value of 1ULL, distinguish them by
+		 * checking the type.
+		 */
 		if (type == BTRFS_DEV_ITEM_KEY)
 			fprintf(stream, "DEV_ITEMS");
 		else
-- 
2.21.0 (Apple Git-120)

