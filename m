Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0EB9FEF8
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 11:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfH1J42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Aug 2019 05:56:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52816 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfH1J41 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Aug 2019 05:56:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S9s99V055057
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 09:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=5v2z057xDXvMVwlIKOhll7HdJNg3tJCAoR44GxHDuNU=;
 b=TiMYfJrSw980iIWaI5J5FPAqvQPg4aQ31DlV2y1ufTUs0rIiVqfqVxhwnWBtCI/xyhjx
 Vxwafmj7m7wyhWo2r6g6gqVMv36AwA1w+JbS9QpE0ufpwRvC8hOGq+xDVi91PGxg1Sq6
 Y6rX/QINKIvllwrhHTNG10/B8uzKp+NYp4x102wB9G9KHhdIMzWRhChxXoBWoGv9r9KB
 uDNIoMS2+GwW79PZZri+kCRp5xtFQnKNb9dR37LscygBMNLTvZTJ2g9l1SryfluA4ugT
 BRAoI2Divm3AS2jyRg2wlPOOiSLa9IDTTZEK4Q5/HicOVqeIl+kf0ECUqV+ToQDQU7Bh Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2unpter88p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 09:56:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7S9r31o103172
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 09:56:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2un5rkvqbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 09:56:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7S9uOUv017247
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Aug 2019 09:56:25 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Aug 2019 02:56:24 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: print-tree add missing DEV_STATS
Date:   Wed, 28 Aug 2019 17:56:19 +0800
Message-Id: <20190828095619.9923-2-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
In-Reply-To: <20190828095619.9923-1-anand.jain@oracle.com>
References: <20190828095619.9923-1-anand.jain@oracle.com>
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

Add missing BTRFS_DEV_STATS_OBJECTID into the print-tree.

before:
 	item 0 key (0 PERSISTENT_ITEM 1) itemoff 16243 itemsize 40
 		persistent item objectid 0 offset 1
after:
 	item 0 key (DEV_STATS PERSISTENT_ITEM 1) itemoff 16243 itemsize 40
 		persistent item objectid DEV_STATS offset 1

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 print-tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/print-tree.c b/print-tree.c
index 5832f3089e3d..0f9b3a8f0f83 100644
--- a/print-tree.c
+++ b/print-tree.c
@@ -689,6 +689,12 @@ void print_key_type(FILE *stream, u64 objectid, u8 type)
 void print_objectid(FILE *stream, u64 objectid, u8 type)
 {
 	switch (type) {
+	case BTRFS_PERSISTENT_ITEM_KEY:
+		if (objectid == BTRFS_DEV_STATS_OBJECTID)
+			fprintf(stream, "DEV_STATS");
+		else
+			fprintf(stream, "%llu", (unsigned long long)objectid);
+		return;
 	case BTRFS_DEV_EXTENT_KEY:
 		/* device id */
 		fprintf(stream, "%llu", (unsigned long long)objectid);
-- 
2.21.0 (Apple Git-120)

