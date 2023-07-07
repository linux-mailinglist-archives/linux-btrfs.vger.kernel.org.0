Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81A74B4A7
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjGGPxc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjGGPxQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:53:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E00FB
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:53:15 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FNtdI020144
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=zbU81DRnZygZa/2PE68Xz5FLolmzTwdulvU/uxql+0w=;
 b=D5CPb5XBfUYUb/K2+aczOx4nE0EQuZW0NhFqJhvTrbQ/oE9HGQqQ+BFqEssuQYuMZes7
 DT0neDd0sZKLgnWgRUbrs3SluWekPpAjGGDoQrn5KrkUHjVozekyjJNUgeQIsVuTS3aT
 5PmBa9h11KJxKKfVvi5qttCMcmXdGR1whSYpKboMwffxwpbFoEM1fOt5KTd3I+h+ACo0
 T2R7jzokbKvSKDacTrhISiv0YdXHgnwzY1812hQzpMK0/ZRIefdtV+ND7Waj3pqSBkip
 SBvRnISPI87I/l1cR+oE09eFw1EThGH8V6AbbiPVLXSDGqGr5rA5pHkN0353cHb9fWrT ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpb4xh70f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367FX1Ed007129
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:14 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakekckr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSHsbBMhQtypWQXdPwtU3f56j6eujHUqE+PswqtBye9jMd5kYqxMm9z8XfJRgdvwWoAfSysGyEF3ZpIOHPXZkmV/3W2ydygRnQj/lTo/+U+ZsGgCFLVk138ynQ17TWDU1SBjzKK/bPxaBtILl5//sf1K35YzgzCVptzYClHaO66oJZxvc9JKkmbVpQPqempbBkogDDcwoKrWNeLwywmZ8iIQMIzYK6ft810aEbUIgVPwR497zRtyvAq5iG4A4Vn+9II09LvyJrd9hdGht4irW3iLG0IXvooWFb+CmBdx2binDEC/XXOePbXus6KxBWYicuEMlCMR85X/LKjio5BLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbU81DRnZygZa/2PE68Xz5FLolmzTwdulvU/uxql+0w=;
 b=UAANlEvJmWyO6VAcmrrqBfUHvhqWlzk7eh9Mpe4kp0jr0pPwmRTiICj6WVw+jz5TC1hYbRrF1HdM8lVPm9khvg5cMeDInoTmISa3ajsYMf88AkWGoGeB5G0AkokO7lFe2QwcjcDjEWOBgJTHsEFkmG76pod5CMEN5BjMjrGVtEL0ldBxpx+TIJyKIJVWa0BWu7NLfXZIFk9G25g3Pgv9jUEEwa5yHUEN6pVkeIYO7PwM7N+0BDaqsU3SIrTAzqEqFjzs5wKk42BNTFF+6oRdbWg0lYklSiEuiEnhYYOd0Zv0MZQN7WQdgNBCa26B9yAjFQl7JN5wPcveDNU3ujlJ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbU81DRnZygZa/2PE68Xz5FLolmzTwdulvU/uxql+0w=;
 b=zIsUW9nphTh3crrag3AnJihRdLcXiYKByIkYs8bG1/E0uX5PCUaIHSiXDP0cR9KVM7nkZKDXAHZhfH6P7Fy/QJNgTiebVCGwY7JgdV2O1r0pu1LrbWO7ye2yq7Tp05hZdbb6OGDm0Am5FUa4D2XRNVTULeX4Kx8pcjaIKjBxgGA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6156.namprd10.prod.outlook.com (2603:10b6:510:1f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 15:53:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:53:12 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/11] btrfs-progs: track missing device counter
Date:   Fri,  7 Jul 2023 23:52:33 +0800
Message-Id: <cd1a6eb0c0c04105d5e3ae76a4959ef89c704cd1.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: c579feea-bab8-4e05-8b7c-08db7f0244ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ir67yt0QgD0kK2BmGltA/zuLvn9NCH4BlC1ywG8E9PQhd0ajmJz46IGnGX8/yZY8poYhXa14Xs7rKYQzrAl4v3Nx7Ydjzh2KF87C9xbMEQIlClPQcRGdGRlnTZE8GdlVe2KecLEB/id4/G/X9aTsbm5rRb4/Q3zqayEXvPPthufF4CI8Y3x427UF3W396JaRsjlzk1tadu4iuiS6F2ry+SqDr+iAZMDxNAlGXPXytMHtAqsmz0u3DPZsPc84QAgqcWO6Hp7GZZXOs9NFa/EVwF3qP5GBSiVWn79glOOBJO84+eBhof526Hvx+MES6V9nsm0v5XNoiftlsPVlj2S9z0fqeSMHkrwoajjEbX0yDAvEcFOu4x6pSmf1EyMQwn9dXerhcRZmMzh6c6GSJtO5CSo8b9rh2dMrwhDxJVH1VtQ37VVaqrla1b6+JRIYMySQUPkQXiui+RK+PblxN5Hy8giI4ZpvucahTdX/Ypg/+TZ27a+oao9ZXQtNSePIqjIriALSQ7JsHJ3UhAtOGq4L74+o9ieB71opCx2kNqJZrnuB3vVzCMdbW7HfHMo5ZFYs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(44832011)(5660300002)(8676002)(66946007)(66476007)(6916009)(316002)(66556008)(2906002)(6666004)(6486002)(6512007)(41300700001)(8936002)(2616005)(26005)(6506007)(186003)(478600001)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYIppfGUBCfbjvO7Ku5+BOeLYuhWZ/yRdXAacl8ERNMgav3Jb257jHRb8laf?=
 =?us-ascii?Q?6JCPvbPWBZLEveHZiOcE2o3yHztCIMP1wfp0gG1mCyyG2Epohjc8LG5L2eZo?=
 =?us-ascii?Q?7poHVSEsPCDp/80iQ/rFupvbOtKi2QKA5T4uNkZzopFLR1y/uMHKwTANssbt?=
 =?us-ascii?Q?cDpvLojhYCVgx09DIjdEqoJkV0bZ2YrjM+BNG/W3ACamUW2L6P+nJJ5k1op9?=
 =?us-ascii?Q?mmefl0uW28+9oPjvW+SKpKtaPUW6CaStwF/Tc26fTig6Qr934aKDlXDq54Qj?=
 =?us-ascii?Q?7mFyKhzN9dhThLLjr4erxenSWWWCP7F0uS3WcKTI3NDnQrd1MHIkRhSDUtFI?=
 =?us-ascii?Q?jWaAXjiul9WDo1DcOh9ZA22l4ulTF2pWE8Gjkc9wLGsGZZmd535OqzvSCwpW?=
 =?us-ascii?Q?PsxpBW8NWHqXTD//7Sp0j4yKpNDRFnEu8L/VoVA61vKU71FDN9nCGbu9eWJL?=
 =?us-ascii?Q?PJAf7foTUxfzaCHq/ZBFOMNgnCs+M1CQVOwY3NloCxoMZvFCRfodibYIn7MY?=
 =?us-ascii?Q?dkM7Ye9CeANI1gUjGhdZ7eT6LaNS/pfmodIaT9+nngb2gfoo+fIo3BFqef2L?=
 =?us-ascii?Q?yAwsEw35j1cDZvlvPKRc8jSdPMmMAvZNLthqvD94Z/HIlRMmv1tA1xzpaxTz?=
 =?us-ascii?Q?YcGm7MzPAaxT0UrovRR1KyyEugCmuRbO7W6gnGInt+FV0ExH5zjd+ihWtdB6?=
 =?us-ascii?Q?p3K84YIW7je09pn5Xb/zyIwOxuRlmtptxuAl5ojyWwrsshe+v4pD/vpl9N5q?=
 =?us-ascii?Q?BBS+qweqWpOAyiCciv1KvW4r/dA7KOnKJLOOxWmTqjYJmanif8KNVd8lmWSW?=
 =?us-ascii?Q?shuCrCGtirWJZqjCVex70wIPQ1Q5b/RcZoUhLIeXm1d5sb01Jskj7qZ/F99z?=
 =?us-ascii?Q?AVWGtYi8uF49WeiGs7oXP0w2wDdKcijpCMLcjDMdpw73VLjQ+SaeMaj79RGE?=
 =?us-ascii?Q?zsQYIAA0hGigetw7aGnOHCYJfiB/M/AhnbvrCbDJKaJUikufj1t/MJUg8HLV?=
 =?us-ascii?Q?dAzc9dWiBBqk0/pMc5w2B9hXEftRgUQJKoy52Gvae5sbzTOoGa0r2dCPkPwR?=
 =?us-ascii?Q?aXpwLyoDwdv3lMVnwGihhwsVgIQYjIO9r9whXsTEag7V/ONEe4qaf7/kugad?=
 =?us-ascii?Q?bNVEY6iPfwJp/jCrIdQv4QCeTEyTMPTpd8/hlSKcWibtM3C0lpzuRB1vSD/0?=
 =?us-ascii?Q?MyXOdmTKoDH78LDqOh3i7ooJFdNKrwHmPqH0lP9xh2xwpWiFIahw/a8KeMQa?=
 =?us-ascii?Q?WXT9kIS0O98MbJ51eoWeTP2TyIf3g9tP11JfRlSFHequvWctdNU1RQXGN2TF?=
 =?us-ascii?Q?/ojPVe6339A9epLz5NSwMrpmPoZLXxMBqgnSSY6WzOTUcxZI9yWJimFNW9QH?=
 =?us-ascii?Q?DIrYdqoGCDSlph9gQuN7FGJ96SOj9HrJyU8YCbA9Issnk/ZjJxjms/V2T59D?=
 =?us-ascii?Q?+qp3R/UmpR0+3Xz+bmIxbeLBrvQ5E/HKK7XDCSmqZMv6L8hGgS4JYWvPK5yj?=
 =?us-ascii?Q?JTpQHnjKPMJQyBVcUHILUXchZInKK65dbURQSxtYeJGBZj0ZObhsPfuCQplY?=
 =?us-ascii?Q?Ugq/DXt5c7mG6FhmkoHW+CsT8GOW7aBzqn/Ef/2r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N601qrWsmuczvyBnXZRoB/1dN5uOuctV48Phr3vZ6FCt9ZqB5P/t6IiAlnk065wo56Ve7PWfqE8jarWu80aBD8sWCof+t+L9iIGqnqV7fOhZccBr1Dmxfzyqak2rkBmH6EF2M0fivzyukJTtRZuMe3A+FYLT5U4RmwLKtNw30apUn7qeI5d/zz3O/aCCJwqs67mr6W15Z25qMXjIzmjyjdYwqbOali3Zvy7LFmJr5Cu00iTOy1EZ3xau3XQ37SdWyCgMWT6xRtxDrNaCCI2vFeC16L28KgVSck+2T7omHxHL++/tw8nx9Kt87S48eJMF+vXslkS4kWXP5j3d4kZPfSnBseCC2h4qr10J+maEud75oHOoucLJ3tuOE35+SZgwGT4Vcm3NlaCFK1NPDKDMjhCes5REym4vvL2N0OZZAxQIv81rb2f8IR2qdv3wRfCXQp6RwnK4VDANboJkGND61IMTPDO7HbufkxL/VdNV1VtROg7u76pwqcWsDEA0/TW8bXA/3ozZIIXx0WKKPhlsiMGBVXBOvNKPJ2ggy1F5amVeFixWlBkpM/tY8IiCkI3vaExq9mFHKSyuvFvdSqVCsQzA7auNZaavDojsKzknuQcjBR6KatMBWsQO8QfakzaP0qejIHmDuEP1A/6SEdfw8iXW3/6VoFneM6fkr03ft/m1QYFlct15Vn4ynSS3Z6DGo1dQlem2yheEnT8NR8vS8Cn98lc3h8zOS1q65x2sHX8aZ2nTQ2Ep1KpyAdGj44yq
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c579feea-bab8-4e05-8b7c-08db7f0244ca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:53:12.6448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViYc8VaxmhgsE4ub0SJQj6lzXLU12hsKj0ZKMD4VBhsFA0/9Hyz1itYWZQT1TWn9kZjSGg3Th8CcErq/DoWh4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070147
X-Proofpoint-GUID: NTq1-nAXkwm--AVy7pa36bs878aYMUre
X-Proofpoint-ORIG-GUID: NTq1-nAXkwm--AVy7pa36bs878aYMUre
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Maintain the btrfs_fs_devices::missing counter to track the number of
missing devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 2 ++
 kernel-shared/volumes.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index d20cb3177a34..671396dba689 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -2156,6 +2156,7 @@ static int read_one_chunk(struct btrfs_fs_info *fs_info, struct btrfs_key *key,
 			       (unsigned long long)devid);
 			list_add(&map->stripes[i].dev->dev_list,
 				 &fs_info->fs_devices->devices);
+			fs_info->fs_devices->missing++;
 		}
 
 	}
@@ -2259,6 +2260,7 @@ static int read_one_dev(struct btrfs_fs_info *fs_info,
 		device->fd = -1;
 		list_add(&device->dev_list,
 			 &fs_info->fs_devices->devices);
+		fs_info->fs_devices->missing++;
 	}
 
 	fill_device_from_item(leaf, dev_item, device);
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index ab5ac40269bb..d2915681e6de 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -90,6 +90,7 @@ struct btrfs_fs_devices {
 
 	u64 total_rw_bytes;
 
+	int missing;
 	int latest_bdev;
 	int lowest_bdev;
 	struct list_head devices;
-- 
2.39.3

