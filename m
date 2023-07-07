Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5625E74B4B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjGGPyH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjGGPyA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:54:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40619FB
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:53:59 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FmOcC031721
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=kz4IoOeXacE9VmIFrWWvcm68+1qOZPU51qnULsRHl8g=;
 b=HRK1vo7N5xtdlH888wrkRpJAjgVQQfASPD3V9/Pe55rm67EJfiXDUs3T3JvRGuqYBT4h
 tOfy5pgeXcmbcCReSJH/xqScuWbpPpktYyz8lXBQ/Fe3mDbFOyb+iYHcXfJVoqYWdfMR
 v3zVbw0OJgrFNwQqdSxmSdy3AVf7y7jaquuVF47MP68PNTQ2bKbCTb+T4tBH1borxDSr
 aUQBniBJrJou0e++TI2X/BB0qKEJeVzu0BxRHlVTzAupBPQI1G8GW5JQK9I5rw1itI4b
 UjQpGjz4Jz/zcl/0Rgcfcc3h8j1GjRBzlplNGah3hVQnAMcxAvl4huwSkMB+hXtkU31Z 0g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpb4xh71w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367Fg5jr013485
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8mt5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Snr4sCOd0NEbVqRKuH3V46UdTifw/w+z7qmCmYOPdDwoURks5oHLZkcGDeLhFA2MaAMS8DnbrrFT5kwtZ70J4pBjqa0vuBdAvZ+3bAyqTa+szbli4/dXOotay+SzSvzF8ScLjtCCs333WeFdqQTftc52mFpfx8a4K0g9WXW5cw0t1m7rsXZT/aFyqiPpNXIuHW389Ctyl6DaWuCQf/DKYBEaAqF+VL/rhbYHHWW+5Lmf0Jxhm3zBDy8+sBjZ/jBl53/ElaCFkWD40DzLFPM2I/uZN/fkeg0Qp7uM+cvq+5dEv+gg5OSjr75heK/CBOKsJNE+V7OC3GPCBoZr5MnCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kz4IoOeXacE9VmIFrWWvcm68+1qOZPU51qnULsRHl8g=;
 b=CjK1eOIKz6VpDovryc6Ta4bphgfP+yxY3JUVQOsWIwOBcqWFxjmJF56CV91q/wZVBIaObf5wY/oDbKgcLsWMI2HTM6QCLVqBq7E6QBR8/D0fXzw0zOzLXth8iuS7orkXDmgQ6mgoiFmhkQR5AWDbEOk1FUv2112ES2cH2XYBoSCa3+jBNC59/Sdndny5u2yRhcCD31ebzUnyxZLYTn27iHj75dCSVx+9VwqILPnzO0ZVqc0MBCZ7lI/W7U5KZor+40Hud9SQCbq1UiA9qUjGSNMpCecLWNFRAecdHsGny7hV8OgmanePBz+y/FCXFe3gL0Y+vTfOe/RZ3XjcmKH1Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kz4IoOeXacE9VmIFrWWvcm68+1qOZPU51qnULsRHl8g=;
 b=TGiEQRdXxunnAtPv6ztkpQtJV3m0/p5ntMVGfb6Hwle/QKO/zAp52alSf78OclcYLi5nxkUInaHeWvaLaziTIlGVTYglwZHgx9RHXFZbXNttP+OPcM2X8avusiLTlwg3siFv7tRsP/Y0nnhWv30j7TPBRe9cUZdZPTW51OrIj+M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5999.namprd10.prod.outlook.com (2603:10b6:8:9d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:53:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:53:47 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs-progs: track total_devs in fs devices
Date:   Fri,  7 Jul 2023 23:52:38 +0800
Message-Id: <25c9f3b987016c897132146360c5aeab0cca9a12.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e727b0-1afb-4e5a-8d24-08db7f02597d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1F0xVHMbntSAdY4U32DGwv0g1cyUXDw80Qo3V6jDaRU8qcZHKFoslG88MyUw6AiRiTN3gkXireYXs9Fbl5bSOXiMVoHdNBsW5ZwGsMzooJakLkl6ujQ3tE/alfQ/utOKrJ/E3cCDBbYupS8QP5vwUQ2XPWlCgHBcPOHkCSgQyiifFHegrpMQ9JtEpmwVMjggeaVv+OU4Nf6go+znxxvKmm0SQemXfE0vrmkl2esaOM1Jzqir87DciBB/LPofUqR29RPtEvJctG2s4KiOJaZ34VEvhmbNoBX5ic6o+FULWO1zxqSkBfpVwLZmHdG4RUwT01yrC3IiPydtXPIPLEiW/vtBcN45yhaRUmHMxPcc+y6wljLqYbNegVeMYmTeYmsAJvM6HTxE6Jn/0yxDbRe9t6NTxQy5B0/QulGMyyWbh3MxAicIUI9qnbNA0FHDRAZZ9KGsdST6PL8i5xW2S0qZgbLg0XELuMDq6U6GpAyXlqReS2E+h3QyRfbqIDtmU68T8ktQrOeATFKk7rYnwvjOBEmelBjWfq8sRxXTWh2V1zLnwujDtZHhXkVEnieR/S9Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(38100700002)(86362001)(36756003)(8936002)(8676002)(6512007)(41300700001)(5660300002)(26005)(6506007)(44832011)(186003)(2616005)(2906002)(83380400001)(316002)(66946007)(478600001)(6666004)(66556008)(6916009)(66476007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4irbulSiX0iiZC1mXTpTtmrlKqyEsTaESo+MKxzSraSs3l9O6uwYRbXoIg+G?=
 =?us-ascii?Q?AVhDBRFtu//PCZifVMHbCvAbpfwbNoRdz6JwbcWNhsP9+BT24IoAm1XcAXnd?=
 =?us-ascii?Q?rBtxPDWmtLkMQIwyIKnSrbxkm/2lWmlhDCeMYGwjXTun9gBkHhpyfPH3fsHv?=
 =?us-ascii?Q?zNEUOSAS/kpcFyXKgNK4sVKSvTVwsccj6JvgADSmvsrxZ+KqxtUAXVCGL8m5?=
 =?us-ascii?Q?Eny+/SE2RDDKx1kYgSo9mBKSt+w3zRHmAdhdt+5Omq6KEt3u30eutOf7Mj3g?=
 =?us-ascii?Q?tCghD1NcLA0w2Qzy0/IURDYsLKDy1R2rZ4Hq0yC3JZ2k29qlZBmVHJzoJz3I?=
 =?us-ascii?Q?cdV6ApiYXhd2PPV0XVVRFuKhSeGxUU+1nPcj0oNbhHKOsa+IAH51phdtRFp4?=
 =?us-ascii?Q?PKMx+cUxIlQoi3DEEtB2bvydjedZeOul6kaOGgfiuoJftGC5ZtQdVAYgCNY8?=
 =?us-ascii?Q?47oq/W0BE69qWD0fMNISc/bvAofwwdLjypGl1BFmnDTL3MAeMVyw85ZbNTZx?=
 =?us-ascii?Q?F/FwrnwS4wSEnjBKGWR2KHoBXTMycKd2x0Unkrk8oGkclNmT2s/RWBBiSNLA?=
 =?us-ascii?Q?zLr6gu8DYkk0TcbLJKuHQB0Xu2du2pBQ9GE0gPczm1uF2eyX6LmFFbT64LPu?=
 =?us-ascii?Q?rHUfVM31lVkd16xXt/5mvC5Qw1rj1YhvdSYoz1BnvHUk1TA/dzIJcCPkCRbT?=
 =?us-ascii?Q?6VOnOBVGpeUoAF5UZtqhbuM/J8KVwArnqHTXYLU6GlVca42g7jDoWa23eRNQ?=
 =?us-ascii?Q?qrwVJ5EymQ2OYzOT5iDKR06groHXDz0Gvj3R1sdxYBEqmGflHWM+eXY45Zoo?=
 =?us-ascii?Q?Sv5dRZAV0ifyoX+z+CJoHrLNsW+TTbx3frcwKKDs231qLRqrZkGEyKXqn/F6?=
 =?us-ascii?Q?5WVAKAPwZBslSmET9+DNlQLgXOnpWMbkhKRcUOGCVlSXg/za0k6HvMVVJIlI?=
 =?us-ascii?Q?bHJjmLitrSSu1tRSKYqiKR07et7CC5zo5mB5I9/zn2LpYnfj/3/3ec/smfyx?=
 =?us-ascii?Q?CqO0JFlg4dF0ECAznDDc5e59aJNXovTo103CwQu0d9RONqHCCv/mE5m/Y2DO?=
 =?us-ascii?Q?bIc1SzWUchTXa0r/B01SuX2c6423qEWTV+7LY/T285jFeJnATs2ZaXshJVto?=
 =?us-ascii?Q?LO+GG0X/Pl/lvUtNoUzJMJquVuy0fJD+QakxJgnvbmr6ezVRjMqPaC+naMAY?=
 =?us-ascii?Q?IYbaujMcNExk6JAygr6N2TNZuwTZMimUMXc629pmIklJnYPOPJke2yv38WAD?=
 =?us-ascii?Q?cU02lIK0K8F8bgup6rQcaSVKjZ1e2D2qp3RQGMMpt/LpL6y5GBusBpHoNqBE?=
 =?us-ascii?Q?cBh+uHuQ9lOzTVw5NDOwzfWCJAUDLM0OL7WlAZQXOH6JpHbZiZKP1VgHe1LS?=
 =?us-ascii?Q?wm2GjGtOE3EOzZiUJN31wkhCOMEhHHCVchSov9xjlg7euLYmY2xOIKMFVrzq?=
 =?us-ascii?Q?TGZg34i7tp/o0Oi8+8a0tdkyJR/smBenDvRLrJaR5pVGNK9b4OcCgXD6zLy8?=
 =?us-ascii?Q?3UcWEwAPytpMPndWzWeqochAETtt6xHzFyNwQpUnXNcI/hjVqNvux7zBLLU0?=
 =?us-ascii?Q?or5U5KTsN/tCcC98VUIsrXD6Kn7pwSadfaMaNhCM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CiAueX0KswNZ82Zq+R3o4iuD7vktfpYgIvp/xnuV+9uXKWhcgO1C+07R/nt8eRi0aDQlvHDLe0Yc8QFPUPC1ag8YUwfWBKinfoFM++Ci1uKoHHdSTaiPaiJD5QFuomaES7t8RJynMazA0cHCI0tesnp2d/wdNJkJipQZydeF+hUzzJDVGCeOj+7uxGPfMRT2M3Y8Y+JqyYyBJBjGiinxye8F0FCbYPWk7vElmLcwKNvJg029tyXMVj2vLTdaXNNDzneTgUF4KglRfFlM1Bumjn/OdK/lHl4oDh7YCn6k3thR+b7GDq9r2KDObXqWdJdfHhgktDe03nYzZrzCA2x4FUU4/buPl8xNVDzgI3ziEJXHhIc2bACFi1GihJ5z342iF6RS2YBetFCJvJylVfj/TeeZkbzG5P2+1n4KoqjFe08TckhJ4yClxXvJWOG//Q27+dtSZGqFLqbI4nK812IOeODUprpThlMmXtKzDFFM4UnCVALMS4p5ehY1tiBlNIki0x2bUR8ruU57wz5J2zEHTm1Bu12tkIISaR3311WKdJMJux5oW0HjJ1xmSigTDaWGtet57f0PwaoS9zrRRfymMSQlHKAQIJ8z9XtyScXOkfCn+m+wWEGtZT7lp8i/yibAyDb/+mEvPRiLngdyaqyS0BqnZzkuUU+OaSXOIGt2XsLZfp+Az6Jkl/Y3dYl7aKY/Em4FxMkAcEBt4lNUHUGLHcV/Zln3BrD1j1gXCDEs9pBwoccrveGsuitnw/eEpCsi
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e727b0-1afb-4e5a-8d24-08db7f02597d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:53:47.4024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiaNQP5bxUc14irR62QeOu1gFGbbY9Ksh5l3m/mzqQjW/DV1T8KnMzQOmxNP3wMzClL0Eo75A2yNS2Md9jfSvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307070147
X-Proofpoint-GUID: HDXevl4_UcItkN_Bik3UtSN0rY2_ferL
X-Proofpoint-ORIG-GUID: HDXevl4_UcItkN_Bik3UtSN0rY2_ferL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to the kernel, introduce the btrfs_fs_devices::total_devs
attribute to know the overall count of devices that are expected
to be present per filesystem.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 4 +++-
 kernel-shared/volumes.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 1e42e4fe105e..fd5890d033c8 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -367,7 +367,8 @@ static int device_list_add(const char *path,
 			       BTRFS_FSID_SIZE);
 
 		fs_devices->latest_devid = devid;
-		fs_devices->latest_trans = found_transid;
+		/* Below we would set this to found_transid */
+		fs_devices->latest_trans = 0;
 		fs_devices->lowest_devid = (u64)-1;
 		fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 		device = NULL;
@@ -438,6 +439,7 @@ static int device_list_add(const char *path,
 	if (found_transid > fs_devices->latest_trans) {
 		fs_devices->latest_devid = devid;
 		fs_devices->latest_trans = found_transid;
+		fs_devices->total_devices = device->total_devs;
 	}
 	if (fs_devices->lowest_devid > devid) {
 		fs_devices->lowest_devid = devid;
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 93e02a901d31..09964f96ca37 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -90,6 +90,7 @@ struct btrfs_fs_devices {
 
 	u64 total_rw_bytes;
 
+	int total_devices;
 	int num_devices;
 	int missing;
 	int latest_bdev;
-- 
2.39.3

