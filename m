Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A52786822
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Aug 2023 09:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbjHXHNt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Aug 2023 03:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjHXHNd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Aug 2023 03:13:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B527DE4B
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 00:13:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NKwUKA025876
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 07:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=qcReYdxdLILbCtTXiOpcLmbRw4wze1uQPbxftmuZQuU=;
 b=tyZ2ZkQK2HBtv5wBSZg6woQVutccR6XbJteXUYce4HxqHLLclFCwx1YyGcdox2fDxezf
 nhOCHROV79kwyB/nUa3nwFg+xyo40ReXvVEC7keOT7JDjSX6NHe/Sd3yDhXx7FH5pXfW
 dUHSLpg/w/KC7MEewyFKxzlmoQ10zu30S0VRt7/bd6lEpbzQlMQfNTH+AqYyL/Y9SjEC
 rl8e4SS4DEZlG1VwFlnkzmfFOsdf6Z3F27LbaASV4wz6z/AYrMqwhz5Aag6Viw4Zx+8L
 ADDBEV2yRj5wUeefHdKoA/kzOpXG9FQc9qBgEz/lNMNvWJBAimJvgUBch4e72xYKEarX vA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvue4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 07:13:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37O61hBc000901
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 07:13:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yt3jyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Aug 2023 07:13:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOzitgx9i2N4FxQrJF+uQ8HQ1h6HhvwEO6KxOag1eP8p++ZKmix0qstL2REask2TCINgBn6IAvXy8Ygu6Gsv7DZMEPvsLyme6Xac84OiLAm0mcJXYM6OkAGzntgGf/RMtTHQ5q812WEp9FUajWwtgyJZUdk069SENYLvIYQkfxYwDDAx7XEpGovgP6FexSvf2UVOnPDGUiHnL+AMEi7kpOYL52vIUG72mduKePO9y2dJ+Cu38AjSz0E6vcH0DtOvjYaaUpi9I6oIRBAEwOhnJpX8O7iNiWCLnUkDs48ZWECZcDR5qd4B08mdQX30HSQOtD3J0cVUQlWnkU5YBevC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcReYdxdLILbCtTXiOpcLmbRw4wze1uQPbxftmuZQuU=;
 b=BJ6nJHcQATU9bG3FOeXXhHo9KoVmPNwOPCwFNlTzmdtZVjib7S9cmEym3NBgP5N5DwXw59TCcJzjTJ0Jbl6uBezE5RHVwTz2TJleRq5FDBubDXW9JLEt7pMbD8HSpUJZSIXR6uWFxFSGupk8OtT0ibigqxjvzI+M+zEg1eW3trHixqA8/WhHH8TZfb1UcneOFDelZmnP2PBhLxMtK9prOPXem+pb2Iqu8+ot/uZdJHuXZWUi/owH+UtBOPe9x/dUUTos9fhWvj1HPgiP0pLKtWRhBa5xwyk64TnmZexfFO4FU/iAVvkbXX9irOx2x5ZCB3p3SrFWVl/VKoy8EosUng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcReYdxdLILbCtTXiOpcLmbRw4wze1uQPbxftmuZQuU=;
 b=FK4Ymt5zgM8aYzJVp6I0iPzgSrMKkoMcNYtiyqKnoISKKQ/CxZ31MqTA+6yRIzLDfwY348vgRtEgO4m1M557nQauGR/KnfHz9kcRdKXWLmq6950Lt+wGfplZ3fz25wEJR+2j4I2AfnJYbxiSfj5vln1uNDznsoXp18x01Hf6r3Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5051.namprd10.prod.outlook.com (2603:10b6:610:c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 07:13:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 07:13:28 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tests: fix random mkfs.btrfs failure due to loopdev cache
Date:   Thu, 24 Aug 2023 15:13:04 +0800
Message-Id: <aa3f3c927b62d1da51166efafa856e18d01cc1ac.1692861033.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 8398f3e3-bfcd-4cf9-32c0-08dba4719d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsHWt0+WLa4AkNAODGfPUvDE49dktEgp2zjQQbNEAwIHoBBie9cr453hI2km1ZkytbrHPUsSMU0n4zkUtuEE8A7I9ve7CJPn9h+TpB6IzL42BjhoUsVz8wLb9n3VXYU+kjmFl9X5aPWCl/f4Q20gJTHotRCjlcDJFRUqkP5gtCJlP3w/OYCWK2SV5EAB2MCQHPCsJj2SMunBC/eornxr2WjNwG3fbBfl2W0sg+MvmnMIboc168AAtvWp8L6fVgwDEgQtDmIqVlWpb8rXuQQR2TsNV1ebTcZhaD0vXkJ6+6q4oRN/mGEeHV2kRMOp93CO9nR+7c3KXWva7SH/7UFAva6XX0PQuKnLMrh67ac3gks+F9rBh6g03HoKI34pvHTxIdoJED56ftb0e4tsgIENqIoWZFymJhOmzPCp4AJE5JMe9Km0dZ/t6xvXfD1l2r4Zd3j86vIDGeaoCQ5qMH8Co7JGiIFYUigM2Owk3mW2SHFWD9KrUEoXqqB71oZe4BAIUYDeAfrFtmQiJclNrW41V/RnxPLQyfueZ24Oggzg8VbkmTtQqJzVXDGMfM6pBJ3i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199024)(186009)(1800799009)(66946007)(66476007)(66556008)(316002)(6916009)(478600001)(26005)(44832011)(38100700002)(6666004)(41300700001)(86362001)(6486002)(2906002)(6506007)(6512007)(8676002)(8936002)(2616005)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uvO/PC1+a7LcKHzAje3V83IpY/fGnq2LDeqw9FI1ur1SIlu+5wZxLsDYFwcy?=
 =?us-ascii?Q?RGWRrkPIwuBZcGHpOXmowKUjq+QunG3V+wQTlOIDwnQnJlxOzrWkvP2328wN?=
 =?us-ascii?Q?hnHWiVje10zBqX46D3fj7ITVEGoGAtvgch3O4LQGShXL4xmA2K9hIKTkWnqK?=
 =?us-ascii?Q?JDpl58rW+nF8k1o2NYrtScb93OfT2r46nqkIiTVbB6+Mqrr15HxwtEu6SsD0?=
 =?us-ascii?Q?fF3LHFwlzjVtxFJhv8AnjrxqGCERvCYLpV9wKtuUY/gQoJxiRzz807jCc3UL?=
 =?us-ascii?Q?UAkycNrPH+oI5riP8Vy8o5I41I2dmugAicFUe4bq8Ogcl7EmqByr/fYM4+ev?=
 =?us-ascii?Q?UoKymAO78nu/f7cZ7I07tePvThhPFKYM46pV0wSW1qZtvjMr+HubvbhhoFmS?=
 =?us-ascii?Q?08lnpYafJDXBGpTYpQvHKX7FixbuExh43G9S+jFaWrBTOXKyug/dZRxzKhVA?=
 =?us-ascii?Q?McL6G5gkFcG0VnzYYVL3d2RBm+bBUtUFd9o+m40M/byQQ+KWidX7PpR//55Z?=
 =?us-ascii?Q?zECJlH62DfiHNXBYj9H98GGrbvA+JHIrpMVXVpyNijeu76uHw9ffgQ4vz6GP?=
 =?us-ascii?Q?WZZD6SaWpSBbGoCu2F7wgrM5D/EwBArqqagSDdBmFv2xecQ1D39mGFJDI6gp?=
 =?us-ascii?Q?f8GeZrFNlBqQ2dYgkyTZaBsC+lL8bsr9PjHbt2Yp8ATxHXHLtouTrdQbI7hp?=
 =?us-ascii?Q?DDkHd70oLWEDXks3RqEJW9UpDA9byGH5sCGPuPR48dEQnsdmOA+HIskFRqYt?=
 =?us-ascii?Q?FjVqsrPnkVvWm16gASGH9LmhrmL/9Q9xUvXl8Egs3EkOb0bfIiuWc7ywVxZF?=
 =?us-ascii?Q?57jb/0MMykH6SPAblQNmNG0iSncGRGz3QcPlkJWqkqE9yDfOFTPdG8idIuSB?=
 =?us-ascii?Q?7Wr52KxD6woAalDGTSOXsCuz9cGztccILmv9I4ZHD5WvxxE6AgQHquUi/zCv?=
 =?us-ascii?Q?r45Ta7J27eea4OJq13/PK6AURnRygeMFojmL+drnJIFXD27lGjf1sspLX7Wy?=
 =?us-ascii?Q?G7RQUuqAHys5SRHnBVt0Pl0a+n4ICTum1yR3jqLe9gfijv0roso0d+yfmbs2?=
 =?us-ascii?Q?U/hy1mS+pHHdWnZpOVQR9oVTAvpNDwn0umcA+jbt1hnEtzNL3bcMPqYEmCKg?=
 =?us-ascii?Q?RMHKDf7gMCieJbx/woRy0zedp2u0weefgES0+uS03VFvYiuYeM2n3pHe68sa?=
 =?us-ascii?Q?761QmIYOG5bVGDRNVDwUUp6GYipH/BqTHUhky9TyFwfLA+6wE47IHFOgu+tq?=
 =?us-ascii?Q?I840ByE0isb8d0e3tM3UHyCtNfmFc4F7hL0jlL1kUqNGwcxF2c0lMAV3gC7m?=
 =?us-ascii?Q?ywj0bBjBuFHMSCHhKRa2/POGDGe9kgMvq2bzCa5CqoWeeEazgyVsdb5HZfNZ?=
 =?us-ascii?Q?SWvA7lektazCZvXc0p1oqQcDATAQQ+bPL5Euwu4dvYUUIY9zGN/d4vgFCpvB?=
 =?us-ascii?Q?ngD+H0BsjBYeeJaUeOBtbUJZrfPpOoFxag9ocuDTl7Iz+sk9KveKpNN1d/tv?=
 =?us-ascii?Q?f95vCF9/5KAOYiy+8+xV37xrQVhwlVF6PuL1DRyxTjWwnok+K44LnFQDapQw?=
 =?us-ascii?Q?IbiCqOl4OTE16N0aEXsfdH4fkUXrdOyXgF/Og/R4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3ncU9QLUt376sHUO7kK+2POQPUJYCn6ajCpulLqdCL9bWXRMHpBPD+D7cOoTssme/2KTB9yL7ZFwQ3rXK/n/5guAnL6sMRp5P8lzZNToXXF++2nItixlMgQ0ZG5/6JjuACgpAR1hOfxc0sPrdMgWInAA8jLsYkRpjHQk+d1YDEq8PLzWPDS9ZnetnUY7t/lj6bpTqNe3FcUwppRkIP6l4EGwfmdlis1F6HfUusj2cfTVO+DGsTHdYjzQthXnbz+Kvt5oR0dzSb3kmydAD+1v1zSaseLyENLCbx75XhhTgXNMwWeLFzmHdv5I+LPPxcpdvj4gE2u7SbLFKtyGUiL6so52f6O4JINa9hSPqZYMY1Ykpptm+/6QuHdnVh5Uw9tTbq1cVY9nBoEkmPTlVdyG9gEoiAZNuXfWp8EzCEkodbg+KDRWI3Zw2I+6by6CxyZgiiH3D72qBJO27C30RnkUqbn7wSKX3FCe7BZAzpNSRrHWbdzNGzarHNDktvQvnibiNQ+Xf+k/KjUA6tqHBHZxEngB+EqkblCeODkZIpupkA+usmWuLVY1FCJAcTp+3voMxXy7EBEeb3T0F7FGTAB6y/FC+NGBpX9QOpA4PcFccK7X9lBUXOPziEdalqNUBVOdJZQTrKlKL/Nod6uW7PSzslpQ9k87ze3xGOCyj0V7801zg46BBpi3rXVmIR7A2qij6KQzd0yAaBhNCqL0lCNCGy2bdlM0S9lUAHEu3ezGbV4ZwXPHqEft8b0DKrRg2zy4myHK7+bWOsoU8QVdIBmcRg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8398f3e3-bfcd-4cf9-32c0-08dba4719d75
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 07:13:28.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpMUBRV3g9k2njd1/RriYwEmgZ0vPITUOlJPaP/xdC4LNf4fiMyvp5nhQuj6RfTrf47xK/+43Z9JMLC/cSX8Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_03,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240058
X-Proofpoint-ORIG-GUID: 8yAalS4s_nFvjRcdEfJV0viPtmRR3KJC
X-Proofpoint-GUID: 8yAalS4s_nFvjRcdEfJV0viPtmRR3KJC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Sometimes, I randomly see failures like below.

    [TEST/fsck]   013-extent-tree-rebuild
failed: /Volumes/ws/btrfs-progs/mkfs.btrfs -f /Volumes/ws/btrfs-progs/tests/test.img
test failed for case 013-extent-tree-rebuild
make: *** [Makefile:484: test-fsck] Error 1

Looks like losetup -D failed because the device busy, however if ran
again it would successeed, possible that loop device is still writing
to the backing store.

Using losetup directio option as below it never reproduced so far.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/common | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/common b/tests/common
index 602a4122f8bd..72ea8c688ec5 100644
--- a/tests/common
+++ b/tests/common
@@ -834,7 +834,7 @@ prepare_loopdevs()
 		chmod a+rw "$loopdev_prefix$i"
 		truncate -s0 "$loopdev_prefix$i"
 		truncate -s2g "$loopdev_prefix$i"
-		loopdevs[$i]=`run_check_stdout $SUDO_HELPER losetup --find --show "$loopdev_prefix$i"`
+		loopdevs[$i]=`run_check_stdout $SUDO_HELPER losetup --direct-io=on --find --show "$loopdev_prefix$i"`
 	done
 }
 
-- 
2.39.2

