Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E61B6E3017
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Apr 2023 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjDOJci (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Apr 2023 05:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDOJcg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Apr 2023 05:32:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D284D9F
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 02:32:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33F3FuFQ010458
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 09:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=rMnmCmH8d0I4eZwVCjCpD9LqRK4rmrKAtsjBFWIovUU=;
 b=JdVfS5KGeho8HagIGBForAqk8SJmhf+wdIyKy1h6gC0qMxJwnVesS1krFVvmqWWTrkas
 sAoeYHRRisdX7wZSa/WYphaHRQBYBWSnMBhzWLam0n4mJFWuJaRCddJOEkhiKgaTIzMl
 IGbhr7RAHRT6WkhhgTgoeg7kT1fQqNwABOfwfVs7VRsHZhmwQnkl41aQV7STvZFY9nMx
 xT7iwrCSGchRNz2j2FyzKVm5F0RUBCZV82vUZMJM3XkAOuY4pDpoG2a2j4s3Ekc5w/rL
 Jv+GICyVTLb0XYOi3nYCu/lHzAN1YumZstZPnT0XbodGglTaB1ChK/9qqAULQOh0e/Zv VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pyjq40dap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 09:32:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33F7LAoX023945
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 09:32:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc8qnqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 09:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCU91n3BuVt+oMZZo8EpAyM1wkLYJy14cbzxFnq7XJbfXHfHpzNywY3bVbt3FZ1zcQ7SL9Pcly9GkIS3RJRDhqTWfYhTe4sIKu7+asVy6CvspnUZp4Nm/UqGf0zuJ43J6AuBjMkiYUy/G0UWRjFdggHUL+NWb0RKvX9TbeVeA7Rk9LOWOwmeIltlZktkfMCwHysclHKL296B3Mdi6e8ScRgCsIIkd/y0odEdlBtbcIVwrPEvDey1w8kLAgmfbrJVhH4lLuEYG/MqP9Q94rn7xEfHNefy1p4fDK+7T39vY0YK3cuNiQj+WJUl/sAepIkW3CztHSz8bnl9jc6MeW8lIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMnmCmH8d0I4eZwVCjCpD9LqRK4rmrKAtsjBFWIovUU=;
 b=RTyLnc6dJt4th3AQ97ZxdG3VA05n1OcAkl/HlUElTuY35APDAsUqWHo4Wt98T1iA+B6duxeAMhsm5+Tmqzzmit298Q5Z7QIXlxSlCGab9HNfNfe0Cfe8wvFNbctQaks/VjMGTJJb/saTIdwbTBFCfd0JrGHu7CzxQVElOIsULm17MGRUqCNmvjluzMsrJcv8ouY3ugGLfeEpTX4bB3KZnw7jmCX9ooOJHvC8lXJgVUTQxpH8IPv70WpYUPWkoeAGbs8h67px7n5RDiIXIexZXwpSZQ7WQo0yBbcqZtlhkfZlsUJqS5bHxELOfg1GkDRPR9Ko0GlKqgLpXwluGCtDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMnmCmH8d0I4eZwVCjCpD9LqRK4rmrKAtsjBFWIovUU=;
 b=hOnNuGkv4Gx5sF1OcjYoMUOzEL3GgHIw5WrGFxBDeDvml4gNTGBJ/ePVCS2GxJa1b2OeI1GXOu2coznhM3bcvXpEufR5xQEhSRL+q6jqekDmSlejrWqSWP3MR+EGu4meJ5WiAyT/MDFdyFIeiRkpODoqFNWbDo1KCn1Yit1VhVM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 09:32:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6277.038; Sat, 15 Apr 2023
 09:32:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: use SECTOR_SHIFT in issue discard
Date:   Sat, 15 Apr 2023 17:32:06 +0800
Message-Id: <bf0d31958fd2b40483146e2a8ec483c1f54796d6.1681544908.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b5843b-fbaa-4829-3c71-08db3d945328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Pal3Vx99ULs34tBPDaQxXeszV43++ZK4DAzwcQXdXoF1z2WkeaDMKemKnVdpLUxrsWVmorMTtXOEnl6U1gUjcz9grplPoqEbsR2zMKNGWqrTL2BsdOkpU1pf1kbmxtWZZ56qjH4IOcaZVnG1B0MLB+73LpMCtmGvgRYk8xwZljhB1C87pKPaAYQo+AGC0nSUDgqAiXglm+zuHylZMgokH8GTMbdJlEILyF+hsrfro6PNMdmolkMGnM2MrRdA8YgHsxES/uBgh9mufCCm81TkP3Yd3Rt5LSQoaeUvwkZ6MY5TYFIUaAhjlvHMLeEFuzBbVRDSMm0yOhYhKi47bEysWUgR24JTYD1iS/lxoe+gdZmwWlznURUXSkL1FOzLI7Ae4o3ODpCzpD6F2jnfiX/oVDg+4M8w1R0OcJ1aXDGCRyty7JOibXafTTnCV6NRDdlxO2HEeg2ajDbA2brH9o1PI3lzgQXvEOCv0ofw+I6zs+qFQAG8JvhOHFI/dyzJb65LFjdh5fehsY5g2+kR3lWb4xJvF+akWfCV4PR2rsvDhbhBTWVPH/kJofXstUD6KF6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(346002)(396003)(451199021)(86362001)(44832011)(316002)(478600001)(41300700001)(8936002)(38100700002)(8676002)(5660300002)(66476007)(66556008)(107886003)(6512007)(6506007)(36756003)(186003)(6916009)(4326008)(66946007)(6666004)(83380400001)(2906002)(6486002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/8pqvIHv9IsBbVSx8bFDfLVAQ6XvbpXodlGz52Ywupy/nIfBOzSuWJHfSoqx?=
 =?us-ascii?Q?Dbv3LrCiGVMhY21LOikXbK3Ingk1KCo4+I0jrDMfkwoBnjCprC9cYyeiVrwf?=
 =?us-ascii?Q?pcUMbVKpQwijI4ObQeofOOrveW8K33Wvyvnl2atBE15qEROA2eFSbOhvddNe?=
 =?us-ascii?Q?MVVGve6iHg5tv6H/e7h9zJ0XdokXTmeO52JHRxIaTWRZy1aM7PHWVTVRrYaP?=
 =?us-ascii?Q?IkHBXRQevCBr4r6vcOWixjjFFsNFWEgElKuJaRpN4JafIbwhK8IpAxI8aa9U?=
 =?us-ascii?Q?4dQZe9b20N2wjA1JsMTRMiLEAIKE5L9AJtkBwKJGBreaiJTLFulOmRnIgYx7?=
 =?us-ascii?Q?eC2CVXjIdz+9y7axNDUnHrG9UvmgELCcbaOEShxhQ1QU+7HG/S+NvPAZM/ui?=
 =?us-ascii?Q?3IOGlyVgwZzoC+M5FE5NTbbT+vL4lssyE4DWYilSgzyuV5DQmwXU0B8/+B7g?=
 =?us-ascii?Q?2ps1iax+vZ1VlAVpJhMBhTriaNlCaLDO8SRu6JcMo3vI9QlZi3UeRSW2FFCx?=
 =?us-ascii?Q?Vs11Z66RZk8pL7jd3T3f4MQeOXNMGn05ORf3vNZ2Bt69huxWGm0NFniy2Ei7?=
 =?us-ascii?Q?d+0InCf8Gl+8M5e/LOXCb9IQugliufgMNzLUAkBsVFvYsTCz3O4SZRLPnFfK?=
 =?us-ascii?Q?6zbZOTjLeLWHjcERLmRCbv6FYDilccgPrOClDnndRAgm+fYm1NiGYLf/rurI?=
 =?us-ascii?Q?dbkBSRJuMgl6QLcIxR+ly8P33ROyRx1muAIeTtRMs7LH1ER8siiajXu4tWbD?=
 =?us-ascii?Q?yO1RTRHuCLw49xUc1m1ilHTHt0wiMInwO6ZYHF+Bs4vnTFTT1Hz31ZIaF4WG?=
 =?us-ascii?Q?OxxtP78C4vMTJgJe0sT42T6xzFVWtvUyvvTod42G5CHThExyQvrk+gyENOQt?=
 =?us-ascii?Q?NjUtB6gRmF55dYY3iZrret6e2v+JWMXmEh3lMwysIH+KWTbktMLUPgc4JPsb?=
 =?us-ascii?Q?mnkDxYCqrCLnOb8EMKJ3WjR4eobGLjWVYP4Hq40uK7RAyTxH/hk+ZKuMsiFU?=
 =?us-ascii?Q?kd24GM2sTpcH9+VV5Yz2lZ6inQdOBkWyRKF9Fqfp6+V7AUdS3UZezW+NnoGK?=
 =?us-ascii?Q?ioVjXuGdRtJU+E5u0OfKpoeMszht4HvDqBOr6dzrFyypl/h40l1O+WSO9+Bx?=
 =?us-ascii?Q?be/TwjRdM74CdaJ2nd6A+jtuVTVhTt2UnYk5u8pGx4WLkVqftjKYY8whAs84?=
 =?us-ascii?Q?KBwX4lJwae/hOJ/rKCeBdtvGuPMg/Eg2EQJj5bPz8TLFmljfpLTjpkDkLK3j?=
 =?us-ascii?Q?PQT1ZnhwlFg/h9Ttdilh3jftlGABG7FwNIHy7qIM3nvhooEQlx9nznr+BxNV?=
 =?us-ascii?Q?F8wJbtf0k4Y+djg8WJ7efOIPHON23S3xuez1Rmuf5G29Wb2BeUxdjt//Yj53?=
 =?us-ascii?Q?AlxM6zoTKuYPHljdmF8Sig1XJJWX/x2kgVgUxJ7eLhs+IDQxLm+0R2DFt3m3?=
 =?us-ascii?Q?HP//gN/g5x14R2+LLO/RQo+CYzoWZfpaJ/oM5dXklFrFVf6aoKOasEFyap9I?=
 =?us-ascii?Q?C2OKhFPHQtvpWMc0CfIdb/rAcl+6BQBKxodrq1T6KnalNJ75Zl5/mM9ktoRI?=
 =?us-ascii?Q?arI9iB22eUgLoGn/OP6Mum3Z/5mQgV6Hghcj+sml6FNVTpplvqESTX0nc/7x?=
 =?us-ascii?Q?tluEW5abQWCqHyqUVYooDleyl3zXEGIFMTLIHeaXGccJ8TK0tMkiOR3b26K8?=
 =?us-ascii?Q?W1nyVA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7XVp+FrwLSIa8IHwdBNd4IRkS9yWa3yr26JQJXItIo+TsxoiBGIYuwfn4sG20waXvYb+kwqL3lv6HL4hFNUVaaz/Zj29Pe70TMJ9BGW/3GCh2n0QOWqkztP/RoNybQBm4WQY69oQRerBk6LkJG4ZrbEYi32+w1ud6aBBTOoNJ3IzIszUDwLYhn4oOSV1/60Z1HuaiVnEqYff4EHKI8PlJ9hxp5fNJVdhko6WS9NxNXvAKGwv4zYT8+oM5Zk+wrSQGVOi3p10seYqYznalrm1iMN86FPkDI2FI/VbUKpEmKrispWl3bY3w4ZsUSyT9p1fQhZp7YRZZhjBt9oFzcYwgFNYwSQ+HxtSis4jCbOoT17+V5ZjEreaiBlTCg8HEIpikIBXTEa91WNYji8xQ7OiZ8+/DABFTOl+FvbcQTJI3bgT4MyeiFSepCGdPPcVWtgh1I+KqKkirUIw4vBN+9OWQecQBHgeddnAsUeBvcl2LOoGpTVX6Ei7WXWLH6wQ30NnA+8Giwt8Z3BTXtHAY+jLgQxf33wIcLui77MoHH4i+bY4tiSKsK5gSGIvpqGqTnPNU+U4fGefQU9yeeAqE44OtmDqUuYnQ6baKc9ndVEB6sbwxIg6+Or0ksjSg8V8N+QaW5pIwP1d7BHwuX5f08ytUu8FJhf5Fx2QX0MXPa9YgubzzIyMs6MV/r7NTWP6WXEjFd8YdWY29e8q2Kxtn8Qwol8+iGr3PdzRgOIZISme6Bcs0MNCDBKFD7SMsbflsNUy8mlFhT+pA9iRPgW/8nZFbQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b5843b-fbaa-4829-3c71-08db3d945328
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 09:32:26.4865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfRaLY8S9+yC8dXcRrJy1l0sXMZGpsI0+ENN3qBdqEuQjarWWrUFyZ3jwlFK1jEpGAsLGtCcpnfTpxD2T4vvAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304150084
X-Proofpoint-GUID: Nv9LPvBMe98cx1KyLR7ZVm2PeB-Py4M6
X-Proofpoint-ORIG-GUID: Nv9LPvBMe98cx1KyLR7ZVm2PeB-Py4M6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SECTOR_SHIFT can be used to convert a physical address to an LBA, makes
it more readable.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/extent-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5cd289de4e92..b0b9df93398d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1250,7 +1250,8 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 		}
 
 		if (size) {
-			ret = blkdev_issue_discard(bdev, start >> 9, size >> 9,
+			ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
+						   size >> SECTOR_SHIFT,
 						   GFP_NOFS);
 			if (!ret)
 				*discarded_bytes += size;
@@ -1267,7 +1268,8 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	}
 
 	if (bytes_left) {
-		ret = blkdev_issue_discard(bdev, start >> 9, bytes_left >> 9,
+		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
+					   bytes_left >> SECTOR_SHIFT,
 					   GFP_NOFS);
 		if (!ret)
 			*discarded_bytes += bytes_left;
-- 
2.31.1

