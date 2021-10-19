Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9D9432B2C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 02:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhJSA0P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Oct 2021 20:26:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12560 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230038AbhJSA0O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Oct 2021 20:26:14 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19INGmQv004568
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=HCJmm8d6Oze9g9zzk/Tr14x3yVsMFIdqiJHFlVwL1Ps=;
 b=QKF2tXcKEqkoHLtZqPwiFVlLFrtDZoouzExtaZfFWUaIuycb3uW7TBMvw0OmZjtNHMXX
 zXaPI3QpJCU0bEywZya9jOC5ld0TSz1nUPy4KJCQYDL7fAJGZ+hpf81JcAu0anncqtg7
 xfDwzq1mCQ9IcYs6BL5rdL4vFLo+S0ts6wqZosTUwcMa0dGRespaNyTBAwKOJSfvBL4S
 b2vw2QtgmYjmm7Ab5RfF3qurX5Udowzj0OwVy4bwX2oCbYy3C/qzEBdocfm9sRkIrbKN
 LoG9qpX0xkuPnoDhdYClEL512MmRElX1ZXcgzMXXGkDThYsCpBCQ3NOzDd/Z9eMIkkAF AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3brnnnfea5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19J0H6EC001897
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 3bqpj4k2tt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 00:24:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQy9LVf9Z4zWu4jYFJx3OYuLjKtTdVKjXT+X+W0PRUBj/6JOvHyD872vzvBdPbKVGcCIiDjwTLkee1h6v6INEYEMT+UQLrUfVft3gBcw6lq+RvoAqzcehXabEHM7yoIofAsyzrfEDcOWFK4xj9dR7ga1xJBsqVQMGcQFgWNODH1rK8Mxr4rs1+Lv/hmYMypheIx4dU0MK++/WuGp9RJOxmT+vJ4n9B/aCvQXFeWTRoUKozGB5Rua1hSz0z00GQN+rkOCC+4UDEYZbt+P+sX9IWa1evs9gnpIYttR1c/q4iu56fEz01yf7L6uOIwNvQ6dkvLbE4RZz7ixXW2BfKIrpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCJmm8d6Oze9g9zzk/Tr14x3yVsMFIdqiJHFlVwL1Ps=;
 b=OsXvrif36NEsA3wnBYmuopvq/PM7cWe8zV/ED/Q6NxT2Rihe4dqQehr+t8Hsfe5WifKOm2UMdQw+JlweqBCkjB6t4L1QUI/2H9hpjg5MYEvnZ6IlE0im2Jk33elieps0i7ryAInMiYNPm+s4w/wlV3+5qltHwp8Xsc+pPkkBb6qysFfxPyokSGkckOGwFiXEhMQMaTpOhkSVYV5ogwER8c9JRccseE/pK9+uCHIb0M/FY1M3Az1xkCefXdKXN/L3Mxrue/G06B2tN9ZwrzaIRPq8ZUCoyQHT4bk7j3VlquFgPG1FjMFRoEDoMoGMrdR7iaex3FMbAkdsLwGKz8qSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCJmm8d6Oze9g9zzk/Tr14x3yVsMFIdqiJHFlVwL1Ps=;
 b=viRpzbdQAKGz+gzlhdgdxBo4k5LGkn1hwDgxOb7PKueb5z7Rerv0xcIUtn8IKnxrzw/CduGBme2cK08BcY/1gcmRbXrPPhhhQDyS6b2cT6jDAOW3F8eaPC/x++oBA0Tvx/3I+5+JX+bvBqTGYJCI6JI/wyrTSma3LLdiLX2hvtA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 00:23:59 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 00:23:59 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: prepare helper device_is_seed
Date:   Tue, 19 Oct 2021 08:23:44 +0800
Message-Id: <25c937de157f6a14f389e73c1198b779cfb0b5c3.1634598659.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634598659.git.anand.jain@oracle.com>
References: <cover.1634598659.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR02CA0018.apcprd02.prod.outlook.com (2603:1096:4:194::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 00:23:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d467df08-7079-4024-7a55-08d99296bed9
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB3427C91BB00B6C0F35E10158E5BD9@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbuVI4Uqw9J72sE/+8jx8e0VReE8WFBRCvP2GMpCtPDJfKdtgnw3xfup9OHbvz0IL5sNSkV23Qrc3VZ3oJwAEPzPH2Nws4rjPvGMBhefd5UVP5OuvUUGJx1IrtZc2JZZ++xaflZbuuMe4UddIvTwJxQ+0ptfU2gGR7CEj2+NZDRZGF22Hgb1Xj8NOMvwBWOhX95qywEVS9cSX4qE2+UmbRShmBEdOouLXfJ9Mnv8nzt5OnhhwdtxkvMS4qUHwANVmPVhQjcx1n3K03fVtoehi/B8DqVj1Nzs/LM+ag74O3Cs1DWrL3hSBUxCDopPM2PFFHa6fkXy8uB3hojphf2ti2/f9N824IMekppzn1MxuWw642UfK21fc0uhgWhccsZPGGlAuvTu5Vr4RAwuuvxkmEkoklAbFoCZoWXEGdSF/9oiYI70Rxl0DRUpsiFxh6sVb/eAZUSfWjKqGQJgJ2blrQ2WaWTyYmkBwJ2blxLdhVk3IaQT3vyNjK2DdcT+vgBdrLTqGJrIlTuaSJ3To2LJ3/Vqs8341gXLO5EWdAPG2xIbyrAUhQkn5J7HwDylVwsEP1TYqA2wR3LW29H1lbrcW5KJuWSoRXO2DWIdCfzqTtfSUCIgXIrM6Zku2ZzyUHFb5nsn19WCszpGTb5R+6eaCVZ3rvlGrWchEYzc66xJ6KFx0PjBuWZJMQZMIW6gW0FvJgTvniE3w55eHsmjubsCHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(5660300002)(66946007)(186003)(6666004)(508600001)(8676002)(66556008)(66476007)(8936002)(52116002)(2906002)(38100700002)(36756003)(38350700002)(83380400001)(6916009)(26005)(6486002)(6506007)(316002)(2616005)(956004)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zrsk7THLJ/PkmDXW5SnjlUs10BBGJZHBhSRWrUahcC9EIr8vA/lPtUDCRUHg?=
 =?us-ascii?Q?9JxYzKeQLM33nMtJthxrZK+AY3lM5fuJjR13UtNsyyXfMFux8DvBvRFsP0pl?=
 =?us-ascii?Q?kwyBkSfYIhnrJruSUhd6nQCKeOUSltldSIMPmoFVunPoNXamDFoDkG6GKU8y?=
 =?us-ascii?Q?b2sFu9VNcEg6swKUPHxcbV4l6pyuuN47bhAYK4zHbOVM8Itn7R+DVnk1ZQbw?=
 =?us-ascii?Q?n8F78fX61sWCWfGZzZWjTyCcYVFOASh2DuoXm1KV7dCR97790b8YaptYUp9c?=
 =?us-ascii?Q?zwLdhLBQbgIhOsAUrLcwYoEGGjD/2N+zbnNA8pyX+CTImdypIHHraI8uqdkW?=
 =?us-ascii?Q?ONeAV31SD4p5sn++Vi04o/w4lmL0Xg70Zfe0Lf2gHodk7j9qhFLwr/vJ+c5u?=
 =?us-ascii?Q?TaNJzbYrpcUspOObQ4exkJ29cdr8sRZMWBKLj4k4o6f9i/xDU1LxcE5q8q//?=
 =?us-ascii?Q?n+/9vnisieNupPQj04Y2Dk4yad++dXU2N37OVyk8wO/NhktX6xDU/WJuF8Dn?=
 =?us-ascii?Q?zst3Y61EzOKCZ6H3srY0ynAfHp+99LnSKOQWZeAsZFRTIgtgbFpKOR7+pDnL?=
 =?us-ascii?Q?iIn5YmLQIwxtE4sOfEY/649hUIIL0GPygKpZg1r0Sx7eSQ7iqud6oUX8RvjX?=
 =?us-ascii?Q?0T0P3aDiz3jaaAIwlZvfQkyafRLs2iVA+qNt7Nr+ry0D4oCvfXMNcL5TpkN9?=
 =?us-ascii?Q?L7nweE3maMWd5Nt+C58eu6YTpFHCAYnhLlDBzPRGzdWFRSZV+JP422qu2Yg6?=
 =?us-ascii?Q?BSOpzeI9RHH30WlVCSFNmpE08MejBcgyZsZus7r8IStCO7ZSTkrJWCXD9K6P?=
 =?us-ascii?Q?fRFx2YuQ/6iCIwMDLSRJaDYNxBzMYrz/ZT4THSGYWiinSM0SDqGO2DGhc4No?=
 =?us-ascii?Q?QCYg4vpcGj/x3RjziWi/gRKWXTXAUnRUlUKCtYQDrpJLYwaBB3Ipjl/3ey50?=
 =?us-ascii?Q?WF6lSPr1Yc2yHcYkBujnlM4q3+1ztOUb5FOuCGOO5qvu0+oUpLPmnV5TjSeA?=
 =?us-ascii?Q?mlwl9bABy+zFM/Fq9imfteFCwSQ6hRW+8aRj2s7z3hEHZbfpoAo7+Ttjp4Wq?=
 =?us-ascii?Q?Dcya99Xk6zZj0czVHFuA/YIyYfMr0zBKeVCQQrVZlV4Y3XnO3BhE8Ex8ZZFG?=
 =?us-ascii?Q?82IIwp812EstEAcHi8Kmt3NjIeDxW17eDrZq2tjDD4B8Sqb7SLXTnitNxpbZ?=
 =?us-ascii?Q?dJLM3Nni+zUwZJSnJGeBg7fK4jJJ4QtYQmTnwCzonvGXVFN+M5HTldOoKD5M?=
 =?us-ascii?Q?AgU2HkOhFDHu4Jp0iEYa6ZMOlb95asEOWUk/+4AYK2rTu+jw07DOiEuSqRy4?=
 =?us-ascii?Q?uDg7yGzKhZW6dbPwoA4KYeaR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d467df08-7079-4024-7a55-08d99296bed9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 00:23:59.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pIIsWrK4/hQp5ld03SisoQFTv/kuHgznMZ1e1MgDEuM05xuysHpKQJgq3s3zRH7BK9XJDG/raFjyKmoFLuFIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10141 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190000
X-Proofpoint-ORIG-GUID: Q6VNKV_kVA3auIw3xHqMJ-JJgS-jYwFE
X-Proofpoint-GUID: Q6VNKV_kVA3auIw3xHqMJ-JJgS-jYwFE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

load_device_info() checks if the device is a seed device by reading
superblock::fsid and comparing it with the mount fsid, and it fails
to work if the device is missing (a RAID1 seed fs). Move this part
of the code into a new helper function device_is_seed() in
preparation to make device_is_seed() work with the new sysfs
devinfo/<devid>/fsid interface.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/filesystem-usage.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index 6c0f9aa977d6..0dfc798e8dcc 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -25,6 +25,7 @@
 #include <getopt.h>
 #include <fcntl.h>
 #include <linux/limits.h>
+#include <uuid/uuid.h>
 
 #include "common/utils.h"
 #include "kerncompat.h"
@@ -705,6 +706,21 @@ out:
 	return ret;
 }
 
+static int device_is_seed(const char *dev_path, u8 *mnt_fsid)
+{
+	uuid_t fsid;
+	int ret;
+
+	ret = dev_to_fsid(dev_path, fsid);
+	if (ret)
+		return ret;
+
+	if (memcmp(mnt_fsid, fsid, BTRFS_FSID_SIZE))
+		return 0;
+
+	return -1;
+}
+
 /*
  *  This function loads the device_info structure and put them in an array
  */
@@ -715,7 +731,6 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
 	struct btrfs_ioctl_fs_info_args fi_args;
 	struct btrfs_ioctl_dev_info_args dev_info;
 	struct device_info *info;
-	u8 fsid[BTRFS_UUID_SIZE];
 
 	*device_info_count = 0;
 	*device_info_ptr = NULL;
@@ -759,8 +774,8 @@ static int load_device_info(int fd, struct device_info **device_info_ptr,
 		 * Ignore any other error including -EACCES, which is seen when
 		 * a non-root process calls dev_to_fsid(path)->open(path).
 		 */
-		ret = dev_to_fsid((const char *)dev_info.path, fsid);
-		if (!ret && memcmp(fi_args.fsid, fsid, BTRFS_FSID_SIZE) != 0)
+		ret = device_is_seed((const char *)dev_info.path, fi_args.fsid);
+		if (!ret)
 			continue;
 
 		info[ndevs].devid = dev_info.devid;
-- 
2.31.1

