Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4801172E009
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbjFMKrp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242010AbjFMKrm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:47:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1691AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:47:41 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D66FSp022395
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=laHAaUq+hLwUVD0KXBPY4IAuH0BIMqR+DVl9L0on/Uk=;
 b=SXxI7Wb5Sh9LNALcPr/lobdbvFcMlJ8JIjyed05WT34rgyKRY60WQpz/+SKu3Wg9BbEn
 E4pCmeqCf/8KgpBf+voj1uYmZD8yknmZB0zUz434A0zxuOb+c3ZflFeaGve9hejXxDPr
 z1iOiWNPiboE1NkGpQiEHKq16VOeRfqVPYCxGdTMVhaVKNcAKHXzxKy71qfeb2cLyldm
 FJfvIstir/LSM5sc3zu6JwwL86UOQ50kLgvbZkjrP+CE9Iir3zqU4raZT4G2NuLbZQEZ
 uwocsFDcz1lGc0G2jNFpSiWuIBkgPBtHnpNP6deyBZmBX2xVxW43SvmT/jzuUwOpIiMD Rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bn0vc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D8Uqw6008268
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fma8jen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:47:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3BWj8Yt92TTokhLcKp8XuZRkTuf52Unsb68TujMiNhQraODArklddK60GJXW2YIIGtHqta4XxH3V8HGTseh+QjteZMzDCMBN8S+WMwwRHmD0fMNRJN5nlWwHPlQ+2/QgGReK4j+rOXN/hmsBnzF6mBZR8bnW/jsf/vnpP/2syzoZnEYPvzrpDwsMWbLJVIwUiL48KmTb+P5mogUIRP9N5p0v4Zq8lo3J6MlPMQE2IOjWRhTHWjoIpFiIKdCUxJ7dP+NjSSBmXLoF019rZz4Z6TPPBZLvfL4PdovG5L++2BeCoIJ0j7HqV/gVVlASRQla4nEZL32HgdAyrQ3x6qEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laHAaUq+hLwUVD0KXBPY4IAuH0BIMqR+DVl9L0on/Uk=;
 b=OnLHGi86RvslxP5dOOX9/yYHpAPpTbNdNOAhLLw+DuoIP5SFCKvvsyb6QgJg5zBofkqQsBW+t+GoNqy7p14JURjowGd1DX/5x59iatSQFEDNnyvift+xQFkzCeUuwrlBHmf+XEliKDUlgp1fqtqqrRHOTaPZc+pRUBhJCW4HBLcFpoy9vFZkALhNdeVv+W+klm/I2g9G5h1m7rRZI5OYLeGSfKqzHT3qfvQbQRZuy9EGBk6L56c+KEH1y32aXOI3qtfJ4vThI6d2CyjvrnP8QLe6labAm2wNbLp7vrvfZxIPGTgZkGeobrA3GQDsXAuSh7lRnjJYBW2NC9ujcVh93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laHAaUq+hLwUVD0KXBPY4IAuH0BIMqR+DVl9L0on/Uk=;
 b=x76wSvfB82v+BAM2wW9jdUQIGAghD9Pnme3pWszxuWyKaTFVhDof3BT4lkzIdlH6jYmZWMkeCA8RhT+ss927+1CKYMC1C15vuA4bpDF5+rI+nnohTFQBpIwfJyvk5hISFmlu+lwsoFSmWWRUyJr9bwQv7ANdW0w7W7bPDi/3KY8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 10:47:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:47:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/1] btrfs-progs: tune: introduce --device option
Date:   Tue, 13 Jun 2023 18:47:12 +0800
Message-Id: <4640d0c2f0fea0ccb009c26acfabe53cfdf61b31.1686494057.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484243.git.anand.jain@oracle.com>
References: <cover.1686484243.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d95f34-235e-47ba-762c-08db6bfb9a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0XZDKfGz7AKyioq89lm9oOeevME+waVeDjmOfJxZdhKEoW5KINAYB096ihOrVy5rmHSPgLci5WJIwXweGuEdsDzxgz7bnl+yOyAYSAERv8FnwWsqomBseX5Vsxmrbdz8VVJgRytbaP9nj7R/8LtkF5iSXIz5YJ0l4uv48YhwrMQlvRJx5heYlA0+GxB7bCfr3ITtazkLUEWa8akaXLv1kmTwdNqYpu5/sD482u44o38obDKZZ2pj0BaeLabA4pw2Sfykqr1FJGjEniReDbGFbyVJGkoya0hELoahNWV8qfrvm4ZWz1B9N6F69YQvUImH2H372z8PmFUqtOBal8yB0QQK7NTSjeSAs7+UxSPbN94u4V0gEC9m/+shhd9kHrkWByLuXQbpB6K492V+x1r0j+5+RjAs8X2Kwd40fAkuMWBJnVBPbh1vCRHtobhzxuc0BMhlrpdO8KOLaTP9VuH03r+3mdQj9vy/LNTL5poq15yZDahYRzcSRGFtftYnasoLW03CYo69qB8yEqD1w45nlO46s1uuj4zlY4oaVmXYe79T+qk90ft9Ct6gjc4j78nwPSaiwPREIvHJTPbDgOcmjqTaVqp96pbj1s8Vqt4BDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(86362001)(2906002)(2616005)(83380400001)(26005)(186003)(6506007)(6512007)(478600001)(38100700002)(6486002)(6666004)(41300700001)(8676002)(5660300002)(8936002)(66946007)(66476007)(66556008)(36756003)(316002)(6916009)(44832011)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JpzTO2jMywY2r1Ft/Bgm9yzT/mGDrZqM5F+H5iEgqQksu1T2uUBK1CrxaPQn?=
 =?us-ascii?Q?NgM3sLkamoqSPIsEpr+6VwvQxgIgKKnW4/oZ8ki4KQ/hr5lC5c8tVLRssVzy?=
 =?us-ascii?Q?0paaxzdDSp9A3JwYtVVyJrceVEU1tFTCcGkWEZ+hLgMWhL/NnVQJ2UDbuQZM?=
 =?us-ascii?Q?l/sTEj0/KSvnTFAcSG/SlqOBMBs4ut+PAYfsp3hqBgTAD7dGG2AfjROKS6go?=
 =?us-ascii?Q?/1PcvMFz97bZPX+xmg/Y/7Pkm5trm+BPcUSr9+INzwDqv+asRIzSTOjDFafO?=
 =?us-ascii?Q?qZCGz+HVoJKVEUL3WwtJPNrhFCawYTFy3pzOYXOhpufLtb5KQSF3oGGBoXB6?=
 =?us-ascii?Q?SUOm+dNhCHAA9ta+lPBH5odvCh2bjGUxkAE9lc0QS1PjJx9zMs9n+YLMdC+K?=
 =?us-ascii?Q?N4wvgy7cXHqZd3lQSAR7iHwhPy8EMjjEgOdXnb34fANshDrOTmtbNwaczVzS?=
 =?us-ascii?Q?28wbyp/6r/IUWdlm6Hv5gZUIJTeoVwjfovqf2Tr2oLH6qjZjdFtBJ2JFUl9d?=
 =?us-ascii?Q?mjvclUVWT8ANTg9FCJ8RmAgJaU8foOxQQ4SJyXmAMDRV0EParZzK4CS5XNZr?=
 =?us-ascii?Q?jDTN8Fh1LS7YpMJJnvpXM0SH9Svhtwlvy1fXt1XnBtPO0xTqwR+Fy3muLhB9?=
 =?us-ascii?Q?nCLSu9X3BV8CL+pZDNUmg97eZ1esKGkLmwUbxDn5jcd+pPjX490EVQxOafWp?=
 =?us-ascii?Q?bvWzzDVQWM2Z+AEcfBoSdKQCUbg2IxZbwmucoeaxJTCQS3JU5UwIwa7C85fX?=
 =?us-ascii?Q?sd9HBxVlRybk+E8djL9wTED6zlt5YqiFuKJ0aA3qzbAoQ9x34jHxNCaASACo?=
 =?us-ascii?Q?HJjbf2yFNiRJC8vvYOCz/8lThNp4spvdDARR8HafuhQNMM16arFS1MgiWjjf?=
 =?us-ascii?Q?HeB0nNL1eG/Rsy1m1WRqf0Nds8RfV/JDdsErABXyt46XyIQtm+WLOKQ8cv0y?=
 =?us-ascii?Q?ESCpylf2zgljcgVSrh20m/Mx4jo7RCGLoHZjCFEWJE0TNgxYPKK/UqO4fSy1?=
 =?us-ascii?Q?DuO+Qs2AXL856+BqufmWnl2ZnqMbbj9loA3z1uag2VCYR+GSGA4pqH4Govo8?=
 =?us-ascii?Q?1f8KmVJXX/moy0nfTHLQnq3sYCuh34m9Rn36gFJtTeYsMUvgHS8IFk1t6So7?=
 =?us-ascii?Q?Gi8b9A2/VBcrDExP7i/Pkp9j4aY+k2COrSL6aBD1iIjeJtkxfVNY945Y5eOf?=
 =?us-ascii?Q?nb8K1Dtu7li+qnq55+akPkSEykYozH0SSxYrYTRNJnkXo52Jy/rsIXyNANsZ?=
 =?us-ascii?Q?A9f0A+E78kGeiIzpnQ1DTBeVBvroHe7H8ibgU/o1gEaoeag7HmDn67v0Fdr2?=
 =?us-ascii?Q?yjrJ1V3Q3E3yUCmeboFQdH31/VhGJmEHsS1DVMfFlMzUMUlUhc9nmIf34B0f?=
 =?us-ascii?Q?a/dCoi13fC+9fHvmadjbrKLE8xhS5blf4KwAu9ZNhT8syzV7EUsMXvh1OM/s?=
 =?us-ascii?Q?90WHm/CLZ4bCj8UR5LFXWj2yN2lsYbA8PIr6ItyPE+awWuFZUOEpP83TeIRc?=
 =?us-ascii?Q?3I+a50Hu0FfSZrA2fmc1eDoZxhAD2vyv+oHkfWKimXg17ZLzxIPiFhQrZLSL?=
 =?us-ascii?Q?9fwvR0u1zqcIVM+2TEiA0gFNT8NzTCXlyn7EP+ui?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tez9j+4dJPE2LBaAWep0XLoR1IgGQD+Wv1GrIEpFvOxY8uvX8PT226s+v5SKwgQxSA+e8hlEGLTDPEMbXjS4Sm/vfy0DKQoQj0jQ2sH9cXSmltLu98Rq/rqea2r7l6amZWEiMtn+vXEQ29rdoC7JS6P5sP9hvJMB4K4mukWqxSTjGp7eUqigdo1zahGQ9ONXEq0mVxDoTHNRmUmVpdNbMvAy2C3AmRrL71ykVLjlxSQKPet2tjsGmVxxXDpXQoUou6vQxlNyvk10mqq0RtDV5l5lxCzTFGEjAdt5yNzkJG7PP0YOFKJvKtnn2Fm6wiJFyxuralhbztJCqUh5YKGRs83ieAJcOQKH5jkElszHD1vmC1vhFuSt//SO5I38++/hI6yp01Ha4s05CIiAbSZvAZq/mdXjQgPSaejvuXsSnDIRbLdk67EIkQbjGjW5g3oQDNpLoWys9hgP8/HeMgKdTdrY8rrSf/QwIuJvIyXYCAAw++/AWAJei4BmTyoX3gdh+mzbJRB4FQ4cXbFYFhzZ9biXIOIOLRfW/NXbaXq/gjJnwXVv/UcxYb8L5Gtf+E4z1aYoJqKKEwu+gNO6RFc7YZD+MNR74hORaCfFAjPGxRz7qDl99AbEQ28+2a7L+GCZkUKylF70WOd3OZIomvtWMPjBG/VYTnu4iN/HiWX86JAu3bzK1sc5TAivuchoCFsbnwQ8Ei+wM6lvNSvMl/cB2Q1HtTDV7hkar0tjs2JahoAkSJAAsZctAJpis+fRVBNRTMMesE/cuaUXETgrka2vvg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d95f34-235e-47ba-762c-08db6bfb9a69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:47:37.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YuRfZJLDQ4oKsHRbg8+cjQTp61iaYanbxejjJcaLh5NhIoM/C3uD9qSZH+3YeaCroLEUBm3cBb7ELAHITSBng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130095
X-Proofpoint-ORIG-GUID: QOkjy2vDdyPXohUq3IIrayJSZax-HVWo
X-Proofpoint-GUID: QOkjy2vDdyPXohUq3IIrayJSZax-HVWo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As of now, btrfstune only accepts one device from the command line and
then scans the system to find other parter devices if any.

However, this method mandates always accessing the file raw image as a
loop device.

This patch modifies btrfstune to accept other devices or reg-files from
the command line using an option --device and scans/registers them.

For example:

	btrfstune -m --device /tdev/td1,/tdev/td2 /tdev/td3
  or
	btrfstune -m --device /tdev/td1 --device /tdev/td2 /tdev/td3

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/tune/main.c b/tune/main.c
index 0c8872dcdee5..c9bbada4f7b1 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -23,6 +23,7 @@
 #include <getopt.h>
 #include <errno.h>
 #include <stdbool.h>
+#include <ctype.h>
 #include <uuid/uuid.h>
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
@@ -63,6 +64,37 @@ static int set_super_incompat_flags(struct btrfs_root *root, u64 flags)
 	return ret;
 }
 
+static bool array_append(char **dest, char *src, int *cnt)
+{
+	char *this_tok = strtok(src, ",");
+	int ret_cnt = *cnt;
+
+	while(this_tok != NULL) {
+		ret_cnt++;
+		dest = realloc(dest, sizeof(char *) * ret_cnt);
+		if (!dest)
+			return false;
+
+		dest[ret_cnt - 1] = strdup(this_tok);
+		*cnt = ret_cnt;
+
+		this_tok = strtok(NULL, ",");
+	}
+
+	return true;
+}
+
+static void free_array(char **prt, int cnt)
+{
+	if (!prt)
+		return;
+
+	for (int i = 0; i < cnt; i++)
+		free(prt[i]);
+
+	free(prt);
+}
+
 static int convert_to_fst(struct btrfs_fs_info *fs_info)
 {
 	int ret;
@@ -117,6 +149,7 @@ static const char * const tune_usage[] = {
 	"",
 	"General:",
 	OPTLINE("-f", "allow dangerous operations, make sure that you are aware of the dangers"),
+	OPTLINE("--device", "devices or regular-files of the filesystem to be scanned"),
 	OPTLINE("--help", "print this help"),
 #if EXPERIMENTAL
 	"",
@@ -144,6 +177,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	bool to_bg_tree = false;
 	bool to_fst = false;
 	int csum_type = -1;
+	int argc_devices = 0;
+	char **argv_devices = NULL;
 	char *new_fsid_str = NULL;
 	int ret = 1;
 	u64 super_flags = 0;
@@ -155,7 +190,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
 		       GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE,
 		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE,
-		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE };
+		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE,
+		       GETOPT_VAL_DEVICE };
 		static const struct option long_options[] = {
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ "convert-to-block-group-tree", no_argument, NULL,
@@ -167,6 +203,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 #if EXPERIMENTAL
 			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
 #endif
+			{ "device", required_argument, NULL, GETOPT_VAL_DEVICE },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
@@ -210,6 +247,21 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		case GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE:
 			to_bg_tree = true;
 			break;
+		case GETOPT_VAL_DEVICE:
+			if (!argv_devices) {
+				argv_devices = malloc(sizeof(char *));
+				if (!argv_devices) {
+					error("memory alloc failed");
+					return 1;
+				}
+			}
+
+			if (!array_append(argv_devices, optarg,
+					  &argc_devices)) {
+				error("memory alloc failed");
+				goto free_out;
+			}
+			break;
 		case GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE:
 			to_extent_tree = true;
 			break;
@@ -285,6 +337,16 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		goto free_out;
 	}
 
+	/*
+	 * check_mounted_where() with noscan == true frees the scanned devices
+	 * scan the command line provided device list now.
+	 */
+	if (argv_devices) {
+		ret = btrfs_scan_argv_devices(0, argc_devices, argv_devices);
+		if (ret)
+			goto free_out;
+	}
+
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
 
 	if (!root) {
@@ -438,5 +500,6 @@ out:
 	btrfs_close_all_devices();
 
 free_out:
+	free_array(argv_devices, argc_devices);
 	return ret;
 }
-- 
2.31.1

