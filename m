Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B074568C
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjGCH4M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGCH4K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:56:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02193BA
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:56:09 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3637iAQj007954
        for <linux-btrfs@vger.kernel.org>; Mon, 3 Jul 2023 07:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=PfYVAQjw6sm1Uh4t8hBcUBmyylbBUFBtSGeurDMjNa4=;
 b=XZDwa5cLzPdTKofpd5w5dFgAs1896gQX7I2W28hUQeYBgsS4+BB3QRJoW/MakyaWpvJ2
 RJlLWaICfGZCenbijjiQxQWvqt4sQB72wE3drkAOSgvE/E0sl6AXPZHQMIYSjcy5gqOo
 DwDYIc6Ogo1WR0GvgMO1X5Q+TpagoOfSvl9lV45rM2vfqfcUpD/d3sVV0++M3Yj0/+dC
 ZcJ48OMM+CBRXB1apGwKdXzSi/aK67c+QI9JqeuqGCRMXYauI3XTJeZ4ZvZu6A9cKbwY
 KGH7iBHP0wNigNuSD5/7xt4MRxLPbEpvrvHO5mURzM8UM+qZCJXVE8cyq565Hcp/i6Wq JA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjajda3rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:56:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3636HY9S039253
        for <linux-btrfs@vger.kernel.org>; Mon, 3 Jul 2023 07:56:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak2r0y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Jul 2023 07:56:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QinCqf+MEwlFv0HZhX2T1XieG246zRDxluh5R8OtK9THq21x6aUis/Gg1NlAcJsHcvpzfeAIYnnHybLxv2I2KBFvgzTtp6a1XRPoHNq0PDDfrs/tr0N8MWu6SPPdnokFiwVlDdRLqMyaIe6PJGF5yss9fQQ0WY6sgMZ/VQbr9RyF4bHDQjRuHQKb+7KDeb9eU4crW64TNSBi3H8Lkf8I1bXF+k9ezHspyr3KRatZ6TSlxUKXQZPF4TCcWzASaz5YoWrJpBFrUVPEp7kZC4RtsB2+Lk+ouCN3zFI8RWt7ET+V9c1zAWAyt4wEnZpy99XT8UxxcCVV+pWRzSSxD5qnjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfYVAQjw6sm1Uh4t8hBcUBmyylbBUFBtSGeurDMjNa4=;
 b=muyttymrWZ445ZELthUEyRj0PV/FJnlIGqfGR5v8Khogt2pXhYmtqhndjemAoulfGZ0xfzllXnIYA5QEIFR2eUpNRHWoUzC88OPJRvtsWYtXRdrvH+QYHoeCAZCcYPIleKLrDsjX6RyZHFMPmvYaN7Kfh2SSWq2NGrGy6HPVRiAS62sj3tdBCxpNn/j3L586S268vucDJDJQnx9//AL8gS8D7drSWcxdNpEhDsLL440/b13aZIGsS7bzKuTvS2DENUo3IOcuR2wXRp6pNO3J/8CJT90Zrxs9cDt2ss35BJgWs/kEaVU0Lyx5cF481Sj0hJhZ6qnOxI/Wgu3HAWyBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfYVAQjw6sm1Uh4t8hBcUBmyylbBUFBtSGeurDMjNa4=;
 b=MHuefyvDJ2OXXt+dXiTnrHcxCbe/FBfIYcY23ZH9pQ6F8x4NGifn3FtopoxjG+LZSz5mqWb1lxVOf9vdUUpN/Jt63dZli8BCTj48ZRRr+427ND3m7smDDkx4hLMeakKj4IFo7m62mEwClNErJkARKab7gYEGAsd0ZxAXyeXfN+I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5243.namprd10.prod.outlook.com (2603:10b6:610:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 07:56:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 07:56:05 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/2] btrfs-progs: print device list
Date:   Mon,  3 Jul 2023 15:55:43 +0800
Message-Id: <9fc15c5db68929847061528b9b7185156347cc95.1688367941.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1688367941.git.anand.jain@oracle.com>
References: <cover.1688367941.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5243:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d21dea-d28f-4a04-6687-08db7b9af42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E7Q9YoR/JmHXQuCK8j/7qiHYwDdkzChaV3a/lw6rfbFf6CGaxbup3h5OYB0c1cplJXp8+sKiiEmXDdkBZyy5JSG6kOZMxBdsNORfExi/Nh0I5QloKt44QLSm8a3Y32i9FbTuagplpH49PFQVEkb+0VKLFCc2D7MfCPqTXqCphssKwYV27YTyF4A8svAOvlu876myzpjw/bMDWzhacaSjG75FrZ3hfb72o+DrweD2bdtOrtNPQ/qOuS9LX/iRQkiMPxnH2tTF58k0iWuJI4WZN4Lxb29DvDMMQjVcNueyxvDoByejKJ+UsyUE8DzdivqLwYXfxWAoXNx4d3cz2N0UpBecAIAwJihfqaSLW614Jf2Z1aHnmbWthxSqnxOrHHv08TNhH9MksBhpymW+I84aKfuCairvKR7eQhA5kSZuD6im/hy/GVObEf9LNMxmRttxA7j/ovHqOp63UOylLOs80IObJVMCX81/R0WUith7FpwOeesFtHERjoMev5oImhl0TCuiP3q9BisBN/HMvSnb3iY4UxIxayI+iE5NT3h3kZsONg8e9qMaZFpivK7+wCLM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(26005)(478600001)(6666004)(6512007)(6506007)(86362001)(2616005)(186003)(38100700002)(6916009)(66556008)(66946007)(66476007)(83380400001)(6486002)(316002)(5660300002)(8936002)(8676002)(44832011)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4pSACo5L/3Ew7IKkrn6E7I6Tv96+yA4c1EAUsMJp+cnBM2wz7W+cFXH0Kym3?=
 =?us-ascii?Q?UBbb2hzvKJlkRIVfRdFrB9abqg9TnE5w6bT2znQgnvgrXvTw9+1ihxG4J4Ka?=
 =?us-ascii?Q?iEkW90ksykHdpETumvo/ElBGZQrPDGYm3Z7qKjKI56FXfF0mZrLk9YU308jX?=
 =?us-ascii?Q?0XwckYe6eDdJV7/Zs/zQdn/fdROCZauufbkaSFJJN63o9MVjvByBnMV/+Jdz?=
 =?us-ascii?Q?/BE5LkVqb5FJGQfgaSQiTigEQbhSbi2mRw+zBmLKCOo5Zw4qE20phrMMeErM?=
 =?us-ascii?Q?0117mwdU8lZf5HvCDgSyLAOxlrQoN3kPBaFOZEcQ+FAVE/1ikmR7We9Y7dJ6?=
 =?us-ascii?Q?RGgzInfAHOpDM01zM1GepfON1KKnyJ1apwiJPI5MC2I9a9qovWX/rAUyUcT6?=
 =?us-ascii?Q?6/CF81JMOpBl+KoZYN+mRWPRKRbpL46pAZbhyysGVse/8zkBO6z2Y2ld9bzn?=
 =?us-ascii?Q?hWC3drHSVpJk7Iz+hbDmGySEiue2CzLAkL3niKa917iRknZ2YrevLf9z6DtE?=
 =?us-ascii?Q?ElJb5cJRqiT6PxHpn05To+7jDRTpeP42/mDX6yJX6ATQuCCuEbMDsVo9Kcot?=
 =?us-ascii?Q?+qBxy6WEYpuLZclVYtTL0qA4H2ipnlXgsC5S7G0+cm3pMfGNAQcpaSkGfgyH?=
 =?us-ascii?Q?GeOvOCvF+Dgxd9xBOCkTtCql5tKM0uIaQPBBXHHvsPUj6s+ButIzfAvBzu77?=
 =?us-ascii?Q?gd1rFfFnP7I7rSkaP2Uw77sE4kPxaY+a+KWdKXY8FdO0oLnA5Xcdi9L9bwbX?=
 =?us-ascii?Q?aJgLMbfF7i3DsoSnEbwbDTrErm9324cfK4nj5DOWOaO3MO3hdbGHB1X4iLfD?=
 =?us-ascii?Q?Xi0tvaid5J+iwSE5pPS+etSDTMLW60tdiFu3krHS9XvgyJYZLK0jM9At0ZoS?=
 =?us-ascii?Q?GT/xtFIucAf03p6UlNdRRh9f1HMJKou4CBTD7gYMMWLia5oyLzcbwNWI2wzV?=
 =?us-ascii?Q?y9DphMGwW3UBvLwNgR8JKRDE4ENWpcE2hCNi9WtCXHqR5wBNDGYTKm+fHgeD?=
 =?us-ascii?Q?D/2uDikGC2HHmPNsLlT+/RPqwcPFUyK6JWvbm4l7Tu8O/wreaq54Fy6AAv0s?=
 =?us-ascii?Q?TsRXufx/WDR+GBLVhTuEt1wFthdJ280z5CwUKsMQzdqLxQuW8+FqbfGxTKRd?=
 =?us-ascii?Q?lwO28AzPhgrVl5K0S/u4BwJAAwGN2UX8xAZra039XNAC0VkxF6/Pe+0G40YE?=
 =?us-ascii?Q?La1042QGemtZLR/hYLz2X16FuC1iC31/JwsJY5k1PzDt2wvNFWf/PrDrdiID?=
 =?us-ascii?Q?warWTDjsXROfLYQmln4/1PHHdwyEKb06tfAbLRO8NnD9kPCXj7oo/2DM+h5e?=
 =?us-ascii?Q?+maKXhslkgeuPuxaIgJVZ7WEU0ISsUeDFsXCFmcoiKIzyzlr8WUoV9HTH9KD?=
 =?us-ascii?Q?4iyADGvmPsH6FHjnh2qEBfqQ5EsUjt007sIGmyrl94R7RcfkkF56+VVDn3X7?=
 =?us-ascii?Q?sNY3ffciKaZrVCpEtxW8krgqQTjwNCS/w1ANNjCS4FOdIh6n3Hyjt+wHnZDa?=
 =?us-ascii?Q?/DInhF3p0S/B0dc0r5hxyKEXJvFETfXfZfdTj9D6TMFhMpxlmABpuwuu6utD?=
 =?us-ascii?Q?cs0MVjW5i/98B6pMSaj4GMy2w5Xi+o9alhgU74m+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I0MATGZsL1dNiKw/I2Z2BnAAWia0tJyZCj7WYuN4+YeL8MFzTb4hfyIqXjzoYAGNNXEr5bmfqW3PUn8RFDz1vmYy3TQTEjV6hBNdaGGJH7A+u93FZdefOGJmiMhQ2BH2A23f1x3ru1iGJV6MeAqRuSeaTl/igc7j5oee7Bzb6AWZQBpAYLAuZ8ZNZHxgbs9dRu/AuenasMTd4ED6H0L10zT89amvLhhzSs7OpqvhKP9RX174iKvrgPM3T6v5pRH6jif8n24c5hbrFA4tl4nzlbspUzIUheAVXvy5I0PlDkCR1yRbrup1UTOP3PilSAOt/LYo5r0+eUDQ8vcxBnCymCa5xMEK13DH5dRtyXGJQQfMSEG/nnwVNEvnPl2UJC/vHjOFDIlKDRvH1lxufpNQRf/gPloXy2s4WpZaBfmfKreCWkBImD6kx8MKMAvPj8KcBSJv956h0QCWck1m04Jon+B5SXxBEQfudgUrkdwnRV09qH1dy8YaDs+TbPdlYiJQL+IKjGwX9kFXiTXFfbzfLR/V1Xw7958VWdfJ6/cg4f0PV8KSd4bpgvBFSkrZ42BMuGaO1LpzZofeE2JVaqqGg+RXClbufuQOajDn5E8670bFw4b9RhEuEsCcgWiXoude5S4+Yyffq/kvxrBrUXTlshJ+TfBMIlJOUHPgOzNTH7JvR6kHszQoEJG7CQ7AkuNx8Nv2wXWVp34AoapalDibXd6kmhhOkRNaF0J5LYkcPNplOYw4F8wuovrJPUBpDQ4H
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d21dea-d28f-4a04-6687-08db7b9af42e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 07:56:05.5838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK4oqS0d8LzNEP54ojlmaFCbshQl7Eu9cvKri3vqpOtFLXsDr68CtkohHMI7nc2RbLmDcXI4JUKbSjadoBtPqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030072
X-Proofpoint-ORIG-GUID: xB1WwhQR1JuZRFqibvhOQoeNbCgMdf2k
X-Proofpoint-GUID: xB1WwhQR1JuZRFqibvhOQoeNbCgMdf2k
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Provides the boilerplate code to print the device list.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/print-tree.c | 71 ++++++++++++++++++++++++++++++++++++++
 kernel-shared/print-tree.h |  1 +
 2 files changed, 72 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 0f7f7b72f96a..b3699e70b979 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -18,6 +18,7 @@
 
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/types.h>
 #include <uuid/uuid.h>
 #include <ctype.h>
 #include "kerncompat.h"
@@ -2108,3 +2109,73 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 		print_backup_roots(sb);
 	}
 }
+
+#define BPSL    256
+
+#define BTRFS_SEQ_PRINT(plist, arg) \
+	do { \
+		snprintf(str, BPSL, plist, arg); \
+		printf("%s", str); \
+	} while (0)
+
+static void print_a_device(struct btrfs_device *device)
+{
+	char str[BPSL];
+	char uuidstr[BTRFS_UUID_UNPARSED_SIZE];
+
+	uuid_unparse(device->uuid, uuidstr);
+	BTRFS_SEQ_PRINT("\t[[UUID: %s]]\n", uuidstr);
+	BTRFS_SEQ_PRINT("\t\tdev_addr:\t%p\n", device);
+	BTRFS_SEQ_PRINT("\t\tdevice:\t\t%s\n", device->name);
+	BTRFS_SEQ_PRINT("\t\tdevid:\t\t%llu\n", device->devid);
+	BTRFS_SEQ_PRINT("\t\tgeneration:\t%llu\n", device->generation);
+	BTRFS_SEQ_PRINT("\t\ttotal_bytes:\t%llu\n", device->total_bytes);
+	BTRFS_SEQ_PRINT("\t\tbytes_used:\t%llu\n", device->bytes_used);
+	BTRFS_SEQ_PRINT("\t\ttype:\t\t%llu\n", device->type);
+	BTRFS_SEQ_PRINT("\t\tio_align:\t%u\n", device->io_align);
+	BTRFS_SEQ_PRINT("\t\tio_width:\t%u\n", device->io_width);
+	BTRFS_SEQ_PRINT("\t\tsector_size:\t%u\n", device->sector_size);
+}
+
+static void print_a_fs_device(struct btrfs_fs_devices *fs_devices)
+{
+	char str[BPSL];
+	char uuidstr[BTRFS_UUID_UNPARSED_SIZE];
+	struct btrfs_device *device = NULL;
+	size_t sz = sizeof(*fs_devices);
+
+	uuid_unparse(fs_devices->fsid, uuidstr);
+	BTRFS_SEQ_PRINT("[fsid: %s]\n", uuidstr);
+
+	BTRFS_SEQ_PRINT("\tsize:\t\t\t%ld\n", sz);
+
+	uuid_unparse(fs_devices->metadata_uuid, uuidstr);
+	BTRFS_SEQ_PRINT("\tmetadata_uuid:\t\t%s\n", uuidstr);
+
+	BTRFS_SEQ_PRINT("\tfs_devs_addr:\t\t%p\n", fs_devices);
+	BTRFS_SEQ_PRINT("\ttotal_rw_bytes:\t\t%llu\n", fs_devices->total_rw_bytes);
+
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		print_a_device(device);
+	}
+}
+
+
+void btrfs_print_devlist(struct btrfs_fs_devices *the_fs_devices)
+{
+	struct list_head *fs_uuids = btrfs_get_fs_uuids();
+	struct list_head *cur_uuid;
+
+	list_for_each(cur_uuid, fs_uuids) {
+		struct btrfs_fs_devices *fs_devices;
+
+		fs_devices  = list_entry(cur_uuid, struct btrfs_fs_devices, list);
+		if (the_fs_devices) {
+			if (the_fs_devices == fs_devices)
+				print_a_fs_device(fs_devices);
+		} else {
+			print_a_fs_device(fs_devices);
+		}
+		printf("\n");
+	}
+}
diff --git a/kernel-shared/print-tree.h b/kernel-shared/print-tree.h
index 80fb6ef75ff5..826e9281ef6f 100644
--- a/kernel-shared/print-tree.h
+++ b/kernel-shared/print-tree.h
@@ -42,5 +42,6 @@ void print_extent_item(struct extent_buffer *eb, int slot, int metadata);
 void print_objectid(FILE *stream, u64 objectid, u8 type);
 void print_key_type(FILE *stream, u64 objectid, u8 type);
 void btrfs_print_superblock(struct btrfs_super_block *sb, int full);
+void btrfs_print_devlist(struct btrfs_fs_devices *the_fs_devices);
 
 #endif
-- 
2.31.1

