Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669EB3E0BEE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 03:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhHEBDU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 21:03:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20534 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231143AbhHEBDT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Aug 2021 21:03:19 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1750thCs024230
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Aug 2021 01:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=XdxiZj77mDjCbH0KY/QxUE/arRTV3wjhvO4v2uLQgyg=;
 b=nsV5qlHE487c4+S+4sff463NtCVI7gN25xvM4tTetRv8lAsvvL/WDyt6kN7EU++PFSxw
 je7aOJCUgjDT2yeNqjXLDajzCQHgIrVuUdY1Wdm6oEfCRCjrZ2uYbOXVw2WCFlkRdqQP
 But6AN0uOyiW1ZJrjIt9BmjirVSvonZ8dDTkbR7hVWlKG69r+nn2pHYDUjCpFb5YLmNP
 KfyrtnS33El5xGDBqG5cgiSZcYLjgJqmBqfHkNnCRWyZeNlRZgFCMP9D5pVZAAxgmDoa
 1eFpaVRveSmAUkLecRjoiifPYSfkrOKFnwEGtEGJyq8khVzzGIL5j5OuWck0JgDtRN9n Kw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=XdxiZj77mDjCbH0KY/QxUE/arRTV3wjhvO4v2uLQgyg=;
 b=HaKLSGgLzp0wjXJz5mOKaHdzGB6cEuDHL/17BkfHzQRQJ4DSQ/+YYAtNp9ExxnjiPhP8
 +bBfzR8LdBvTBevEsyaOcWv8hXjPj1saodMxPB45NIn7TwQC3fzgzEl4VZZlQcyVwOd0
 xLaIIeNyWjhQy+Ha88uEbuf828kfJC2nar/zRSUuQIo2M3fcHhk2E3WuvDRYYzJVfrYt
 TX4WeW5lxm+f0W0eFprPi7KYX3IcU9ZEOJI/eNPOkNnZ05KNXRl3FjyPoTfWBRdmbWvJ
 uJtR20XKpHYiypwybkdAUzEj93GtKjTPWQwo74ZeDI6NEy83D557gXe2hsop61Trk53N iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7aq0be1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Aug 2021 01:03:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17511TQV115076
        for <linux-btrfs@vger.kernel.org>; Thu, 5 Aug 2021 01:03:05 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3020.oracle.com with ESMTP id 3a5g9y6y5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Aug 2021 01:03:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cexz7pnLwHzI0KefJlZd1/RGJKyrpCk0sXseEg9lkaaweVUDG3NeCA1ROK6GYPu9LQNHWsNdkLklAvAoGy2SkW0EVI0mCEehpnoSz8bxLUvuoJNog7iD24TKNFfZYdzk18Rzg64yVvdneIUFxK2eFYDIJ1ni956dzNDp0yjID+ervBgri9Ws+kvXkcbq8UlDUrjJwEAwSDfyB5XcpeCk6TAoTVCfhTgsjzjkloxt/kZa4dkWpFrOE8HL5h2riL07+RgRO7pCVstlW3ujmkAdw8/Mr9uJqJu6ecmPrayDkUGl8rtLAnDTdV1Lo80HiGKBNgVI0o5a/118eVr8bnel+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdxiZj77mDjCbH0KY/QxUE/arRTV3wjhvO4v2uLQgyg=;
 b=ebq6k8Y56WPIhpQhMlgdYAdJYTm3RBgGk6mL1lKoDfAFvS0nTM/DlBu4tgLHaBV2RT6B2LoENsc2Xe0XZqJ0ptKd610SK0T/AKabnaqAANoW09xG06IVEmcufSOCJ26iZhky7clyGw1IanGQOBmlA69A3EaiJT9flPn8ZdyBYmp63uuMVRG7xH4w/fcvn30ls97uuqepbSaRKtQhJ0+nN1HmEIp2PqRncXaI9wIkfAHZYme6cYDvfg4M4Drv96GkPcwFsVSAgeGK+Db3vtxQKySks/ZO8kEcA5OWY9OKQ/lCrjcyg7v5+dbz6KxTmNj6PQ5GXTtZ8vya0h6Ck2mzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdxiZj77mDjCbH0KY/QxUE/arRTV3wjhvO4v2uLQgyg=;
 b=V9NPoOm3Zm4HpspYT/5+zMcCy6B3NNY7qBvScDHbZaXUhGvP8Kho6eN0HwPKPDpVm1GRVIyz8D0UjvLeJ/NVl3SCRkP8vTftTbt4vnDdwAm3WqaTI80BewOje9hTOFVHokyXw0vWPJOVbGT9n5zi5TJx9foTQpKGJ5xXGLUJUpg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Thu, 5 Aug
 2021 01:03:02 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 01:03:02 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: sysfs: map sysfs files to their path
Date:   Thu,  5 Aug 2021 09:02:46 +0800
Message-Id: <8a0aac47cbdcc25b7ec861a5d334db1b6add34ae.1628125284.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0057.apcprd02.prod.outlook.com (2603:1096:4:54::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Thu, 5 Aug 2021 01:03:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74e1bdeb-b392-42e2-e6a3-08d957acc66c
X-MS-TrafficTypeDiagnostic: MN2PR10MB4125:
X-Microsoft-Antispam-PRVS: <MN2PR10MB41250E372F9BD7CDCECE5A32E5F29@MN2PR10MB4125.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyQVZFLjJ6XM+UDEHdmbWev4PGhUIidxY97TIIdrOqrVtQWSZe1iM/OnpaRV2G5g5FJNsQG13ezMZGl9tlLyvb97wATj9RoO9CRfSDCZQlkxIzOWBEqcYa3GX/lxPb+tlbqGvkrzt5Ors3hmsh76mkX9Xk6d3NBNSzzm3CzkAtRqjkVe9gG0QOGZ7EwtAw29Q4yTQdcw3ViXU+fjqGCvt6/hyH8qYTNeQ94YOQx7BSglFAUzikjOaLlzTsmymcDwUrJd/jlW6k0vzMuzzVHWE24iNfKaGnn2hUNAe65XJfG/J2Pc1pwnf9dAMramWImofHa5fgK03oJFZnA++y6Sqwxz8BbRVWAXSOrAyonj0QsaqmZPS51ZsnQsdkdHACce+ObNE/fxPmQUzNo3I1U2euoFpdBivaa49+kDczEXWuJ7aBN75v+wE5DvkzwzeF7VJun3XWH+BacywuDygccMhbysdqCNvwzMvfxyklxhByTu1jnem7yreV94XO6w9qfKrU55h+ajIkThgJPH2eVrdeqjIE2rJQl17H6uLnXtdYEAss5JcJUKgzMtwKAyB7WAfC5oC+81bzDw7uzzJ2qiOdyiT8eRF0PGB8pTmAlOcY6M0Ss/QwVC6g9DXTS/DvN72H+HlYjF/hCj4QaemW5P6YbptGu7Mzr2mROAk0HPN4CkPZBe3v2Sk6TU1Gj4ckBJ9WepYb6DT08AfJFFhvxLsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(136003)(39860400002)(6506007)(44832011)(956004)(6916009)(2906002)(66946007)(83380400001)(52116002)(6486002)(2616005)(5660300002)(36756003)(8676002)(6666004)(6512007)(66476007)(66556008)(8936002)(86362001)(38100700002)(38350700002)(316002)(478600001)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aMdA/Hjl100apk1ntBxreGnI7Oe+Px87YK0RFOiSMidLQegl+JA6igMBHxBt?=
 =?us-ascii?Q?D304p/C2YSNcfgMe1R5Jf940FMImfK+4/j70BHM0DvJhbfThSt82P4SMFTd6?=
 =?us-ascii?Q?x4EKTCSVOSj2aoVMV3Re2hN2Lio0bem0yOFbDkKReEj/ohBCX0Htv9noz9dG?=
 =?us-ascii?Q?XkXGE8RGFB80+olDYWrjZw5uIbaWbyAb4vwFI7gLY41GRuWosaumu1YI5qW1?=
 =?us-ascii?Q?iaJ0SNIuarJJC2GcG/K08SOK3VRtOJuqRuoJXfAJ1Ro/vvv0AA8P5XkALqEH?=
 =?us-ascii?Q?ttiNXcqEOrXs8jm7PUsr7wWw/x372EcQ0nN40keKeCXmHQMLqSadfUCHpDjo?=
 =?us-ascii?Q?DkmOrvHHSYPmT1bOZYBKca7dJOJIPiDnkwYjxLnKhPr4blPH+Q653Lav2W4g?=
 =?us-ascii?Q?9yDB9bi4I1N2/m1oadIk89iDRYZ14Ekvpp1p2CAd7DARFDYfP0vEVShKW+Gg?=
 =?us-ascii?Q?jh40VyINYbcM1G81QirBkxBBHaDMjqBJgfr3K9FLgIVwbGZaOP6Y4FaeevSb?=
 =?us-ascii?Q?5QiUqIE3K97ka8O8eJ4QisW0z99uwE2h9BwLjBwVipPDJwCvkuDZrj4vx6dg?=
 =?us-ascii?Q?PjCZlSHvetycKxgTlnj28sUAydeY7he9Kpi3O5SkT76M8TLw/wsonwMiUBJz?=
 =?us-ascii?Q?E2SJ7bfbxW26wsjOOH8vDWmyTagNUdPIXh8rODPsLDe+FWUOnBn0fWVBl0vi?=
 =?us-ascii?Q?P/qH4mIatf0PJj0WZtfHUB88Xm+blco4ItEBg5kmkV6KMSRQeaXGuqTKFXzG?=
 =?us-ascii?Q?oOUeAI8ZWMT0bc6RXFK7oU2bGnYw6RlZIIn1YZdtxh8192zKSN5EJrEl/80K?=
 =?us-ascii?Q?vCePJxY3PunM8mQfqWZxejK9WBc87zwa//ADjJVlPnf2Q8q7I40jSMvVfKhI?=
 =?us-ascii?Q?ha1I317V2oToLXFGJXFg5sdGorRIZnDVsFBIrqntfGoAIX7O0n/r5qgzl71u?=
 =?us-ascii?Q?eQw1YptHjIRkNImTjkRHOGdK6v/TfFUzn3xtZ+EofcpVopdXd1gd8H5nTToh?=
 =?us-ascii?Q?m8RvmwhY2qBAVaX1omwFkHlBLHU7Eb0n4AFsgM4SPdsvgE5awe8u0jdKasPw?=
 =?us-ascii?Q?Fk+8+Lawdh9Nb3601wAEoe6QbRDrj2l/NygLTfZoFsaApZ8SWdHYpbQLPhuI?=
 =?us-ascii?Q?1Q9utEZl81PYISbYMt6IAzXEM53CUkF5YYeitND/azfFmvZ7cs46aaxJNJvE?=
 =?us-ascii?Q?MjsWp2NqSiZlVYCfz/gf32YsqA4/ZDZs6uwZmlawPd+s4hBnChkkYSZ/Y3+I?=
 =?us-ascii?Q?p+lSVq4ec7WLylM+ZnYOoBk8X9AMQtA8dO2C5ca5zJTrREgCML7l5edEvHwW?=
 =?us-ascii?Q?B42ExHlpxcB9N/fufoFwJBo0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e1bdeb-b392-42e2-e6a3-08d957acc66c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 01:03:02.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0oNyUSJnefF/wNqZaxBjWlITDtC7CoVTpzkRBszFpo5pXpf7ULSVwVMtAtqCN4v8RqYduHhbhREgY7V9I0ggA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=17 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050006
X-Proofpoint-ORIG-GUID: 43DRadsqFfB4CO_irKZJwi-0vD67xd0t
X-Proofpoint-GUID: 43DRadsqFfB4CO_irKZJwi-0vD67xd0t
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sysfs file has grown big. It takes some time to locate the correct
struct attribute to add new files. Create a table and map the
struct attribute to its sysfs path.

Also, fix the comment about the debug sysfs path.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index bfe5e27617b0..cb00c0c08949 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -22,6 +22,26 @@
 #include "block-group.h"
 #include "qgroup.h"
 
+
+/*
+ * struct attributes (sysfs files)	sysfs path
+ * --------------------------------------------------------------------------
+ * btrfs_supported_static_feature_attrs /sys/fs/btrfs/features
+ * btrfs_supported_feature_attrs        /sys/fs/btrfs/features and
+ *					/sys/fs/btrfs/uuid/features (if visible)
+ * btrfs_debug_feature_attrs		/sys/fs/btrfs/debug
+ * btrfs_debug_mount_attrs		/sys/fs/btrfs/<uuid>/debug
+ * discard_debug_attrs			/sys/fs/btrfs/<uuid>/debug/discard
+ * btrfs_attrs				/sys/fs/btrfs/<uuid>
+ * devid_attrs				/sys/fs/btrfs/<uuid>/devinfo/<devid>
+ * allocation_attrs			/sys/fs/btrfs/<uuid>/allocation
+ * qgroup_attrs				/sys/fs/btrfs/<uuid>/qgroups/<subvol-id>/
+ * space_info_attrs		/sys/fs/btrfs/<uuid>/allocation/<bg-type>
+ * raid_attrs		/sys/fs/btrfs/<uuid>/allocation/<bg-type>/<bg-profile>
+ */
+
+
+
 struct btrfs_feature_attr {
 	struct kobj_attribute kobj_attr;
 	enum btrfs_feature_set feature_set;
@@ -573,7 +593,7 @@ static const struct attribute *discard_debug_attrs[] = {
  * Runtime debugging exported via sysfs
  *
  * /sys/fs/btrfs/debug - applies to module or all filesystems
- * /sys/fs/btrfs/UUID  - applies only to the given filesystem
+ * /sys/fs/btrfs/UUID/debug - applies only to the given filesystem
  */
 static const struct attribute *btrfs_debug_mount_attrs[] = {
 	NULL,
-- 
2.31.1

