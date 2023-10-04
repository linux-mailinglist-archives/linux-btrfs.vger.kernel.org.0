Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AC87B831F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 17:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243027AbjJDPBU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 11:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbjJDPBT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 11:01:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0593C1
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 08:01:15 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948j9os012175;
        Wed, 4 Oct 2023 15:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=W8EWIPamRNepUteX3EsRnmKrFEtTEQag6I/nACioxzs=;
 b=ylDWTOG51EEFjZTWAvMLN4IJ1+g9Bqw5ShZErN/MxXLU9giz0CntpkYYdOOnhif+ivd+
 glwC+LR2xjkrHKk/ja2jji2kd5YItCRVdG100sorTp7xhjiKm/a5rJP6cCmxcfmM3VVq
 TTjXPphQFOEY36zXNQSiWdgaeRi9OILirvwZ95nPTQLuaacCAF4ytxK8/Ko3D6hPL11m
 ah270/q9hOtVp4ae7OiOOKgNwu6Y+RxeOWMvTGYdPcoH5TXSLpQJg4gYiCKjHlc/44Ri
 Gcsp+wrZ3E07ZpGGcr6higEwIi3tWG4clhuM6mSdPpeBDYk/v8d1d7y29nTxkU19Ayij ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vf7r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 15:01:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394EkrOu033745;
        Wed, 4 Oct 2023 15:01:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea47vwma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 15:01:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Feo5vdVJaaocWNjwtuILy+T4pW5kdnqDl0EVYt75TIf8YqLmv83b7Of4zh++wKH7O6OnBw4sqKDTJ4CYKW4COUS7+XcvgcIVnTxBb74/LLhRsA9zc2SfyPQXxFsSfzLgT1qLUlxA7d4PSOb2Z0cv2sRz9ZZ/xYM4CCwZPx+jH2U8aVtDk1OVRrAQU6WbNwxrI4k2Xu2yiV+d+2YfI5brFqDlevUdVCf3LzSClp6WfXFrE87/bvBJC6GviAqzIrtIGfcgXGpOfQkkGjsis2CLp20iYYUmNFbblpJUrK9CGzj383ufY4xX8nqhwCpOTPR5stbySCm7udfu/aPSr4gLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8EWIPamRNepUteX3EsRnmKrFEtTEQag6I/nACioxzs=;
 b=RRrBKH4HoP3g5pHhWlFAPUZc2oYOsXX/VVdB072P21i3VpL9qiIC3l4ZgtI3E7AwZKM20DImYiUM2ycahLnZYkDAYHsMm5hjK2K68t+JskcJeP2Gw/7d2Ldz7MDUrrcHI4ONsNkOiZ9HLBcyDyoDdyialsY6IWRUKtsvQkjs6w4mIayVIDP7/1sUhl9FrXUlhU9xI2p1sbPdWvWuxWSmEEPKtLFuBjeRViQxEb0oJsLqt633ucMWaRVbJJQziEmnlgR3zli8VChWdaXD7kvnU+lYdY6Tl/nIgHU3xu4RPVli2q2B8OFx1rNhXYlq3C4mQ2iEPW1a/VaYZqEEvxbVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8EWIPamRNepUteX3EsRnmKrFEtTEQag6I/nACioxzs=;
 b=uwr/Q2oA37q0neYrJ/r2fvDbmRLLMB+rJ8y1puyflZW+hAOYWqECdSGw2f8mchjk8lpbjGVgaLl3BBI3xYYyzcoK+V1w21CTR677viEMwUkoQznMrNJw2QT5xBAMqRPB1j25MCzKsm6quOaz5GATMwSqDFL49HW49MuByDHX5rk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6872.namprd10.prod.outlook.com (2603:10b6:8:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 15:00:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 15:00:59 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
        gpiccoli@igalia.com
Subject: [PATCH 3/4] btrfs: disable the device add feature for temp-fsid
Date:   Wed,  4 Oct 2023 23:00:26 +0800
Message-Id: <496f6f7ad93236768f7df67d8ebd98a0fff6812c.1696431315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1696431315.git.anand.jain@oracle.com>
References: <cover.1696431315.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a40c5a3-91cf-4e6b-c9d4-08dbc4eab7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eaFOqb9xXCM8B3g3jHOtu5hBNLMXcmrJ8sZ0m5Z/dxPr+IZOvrdJ0+WCKzijPN/u6/BgGEM/6ps3Lwea7HObvcUZBhdYm8GtzWjUdwE11TkKpAHxBl4plNxuI/zSqyghdUkoaNuqPA1nW16mhQG+2lflAV9YoAQGeQZHFYcBXJRbuxxj4s9N1syFRkFU0ovQQvQ+wypEnLSeT+J5V7ElywIg9eqw00r3gcSX19d/Psr1CsD6tBh1vPV85WJh77XUnPaTi+s5gGN0LzVSzBwj6qNoljqgoZffXWdl0dquEH9rXNNc3Cw4aJZcoAh1b6pAGPFStK9DwVYHm6/qGDIu/Fq/p7Yy2ULtz7d0/3405IifAl5uHqfyi3i2vUoB+6RDec0uufjHovobjJTHHoha/I0sw9dqYDudI01vXmZw4gbMvGddk0/I9wy3IP6Zc8jsLadl0QluVQdI2TKupww9S26Kr6JkIe7IL0z8AG7u40jfp1GeqiDx3OGaytaFixSL9O2gbcJnhYpCJRFHist7ZXFmyGSJ7alUOmTsngkKEs9V5Va/KTfCqjCcDrlCOnz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(316002)(66476007)(66556008)(66946007)(6916009)(2616005)(8676002)(26005)(8936002)(41300700001)(36756003)(478600001)(83380400001)(86362001)(6506007)(6486002)(6666004)(38100700002)(6512007)(4326008)(2906002)(4744005)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cSLEz6sfr04q0Jxsjq2euNq4wcIqhgAo0/Zl98xaZJ3j8tUvZ6S4WQXixjYJ?=
 =?us-ascii?Q?pHKvV5VN5hQQzZKvbtnlJuFRVXXMD15hQK9vFHtakAYyxig7SEnvFq2kRDAW?=
 =?us-ascii?Q?ISevsVOWgZQMzDzj0PrQ/vETmngGbLTRV4/vbRm77k5rOwCQKUSQeQqFrW/b?=
 =?us-ascii?Q?DXZN8Vd2wBNU5ovJodyG6sj4/r4bVoOSFCXkaDpZKpTvVA9PunbB+Cm46xkJ?=
 =?us-ascii?Q?BiR5RZsVVmx/gVVsHHTxgxq0vnJ7QEkLmrvYgxdp3k56UYW4x2sA2Is64ZoC?=
 =?us-ascii?Q?f90bAbcccEpcoeTIbryTv3pckn2kO0DAooAt4782eNfEJ1wnRjRLdlqdbHFR?=
 =?us-ascii?Q?IkGJ2HNFqW9IOEiLGhOiVmwxZEmfqq+MvUaSUX8AQUfYLhQ9+PJvimjwmE0V?=
 =?us-ascii?Q?LoMu1YAmDgqWMTsoLXoOovQ6ajbBfQpYEFIYM2eMEt6tneBWjwS4DnTT8J6E?=
 =?us-ascii?Q?aCPLsP5bfEr5soSPLUwkzQbTwyvKWFyGXxCr8jPfYODTsgcnxBJvLkfDX67z?=
 =?us-ascii?Q?W23awStzv5rbZcx9NRf9jDOcJMyr6NR7S9WIkCi0k5A66yYPy8UzOZIjvykc?=
 =?us-ascii?Q?TFPX06SpS41MeSNvBsUfrqJVPdmjh4YYHXak6v7xzNofkXijj1Sen01vScQb?=
 =?us-ascii?Q?Z9RjkwyxUQwpNl+O8Eo3UyGUdydgHwLG9XWV1xQSmjOPLV6EwxoLgfN8b7/E?=
 =?us-ascii?Q?UsGHU4eWNwhkxrJbSDgpN8sOU8LCbqf0xLwyU9ZpVCKC6awoKBc6EZxk19VM?=
 =?us-ascii?Q?bHuJjELQMJFOXU4qOxPrlmjEp2Q3g883Ogj2F3MWC+y4hvtEusTc+IlbNNQH?=
 =?us-ascii?Q?XEu7N1bRRPz5Qg7MXfe5I4DHkb/m5pSVsTzDeS45hHJxv0RlSNtvEzLnQ5IG?=
 =?us-ascii?Q?R+jH3VcCCBV7cGTgnS/AOAhgIMzwa+3wATv/ATLg4PFXbzEy7UM69DyA67jp?=
 =?us-ascii?Q?+FkI34eq8sE/xMus963ccFAsIIMwfKPI2AaCW2gAZa/AdH4m3UGiDRbp7Q6x?=
 =?us-ascii?Q?Gwtj1vdnYzEP4mNsFNTLChTCxqPQDxjboZss3h29ih22TO3wbCANkOr0gxWo?=
 =?us-ascii?Q?oZsrrnV0vA4Z9pRNQu/M8Vqu9BkwShjFYaLJWv1zipDZHmiLbcueIkTyI2Jk?=
 =?us-ascii?Q?VXlOk/jR126V9RhKw6LPjnyqnQ2webanC0v2WeLs8Mimv6vpEMb6SRfNBLvR?=
 =?us-ascii?Q?pRIMFoRGD/dlLwg8sHazfU0FCwfbg3FPH4ll3VexfIQThNEzSqq+N939EqSy?=
 =?us-ascii?Q?ayW7p12LseC86hblfB2sy2KnPj1JmCm1Xr8KF+DVgJQvGuj8InYVc/KUPy4u?=
 =?us-ascii?Q?n+xnJQCAsLwQ/o5+msjyPbyKyUmr6C3dKcjJ/Wh4P0tkXDzz1bTXGf6z78zt?=
 =?us-ascii?Q?7fuP5UYiMWX+BUoc7qzDf2H6RJoUsWBQCBJMOZvPZsySOT4uajwNsP7rBqqB?=
 =?us-ascii?Q?XmATq6Si96p6VPJyEnySkux4HU4gR0JDcadLttdFpvlaxorZcnUAddMo1lE3?=
 =?us-ascii?Q?lk8EDT2qA1H1lhePDnBfry1UCOqVkw76hO/QJgY1sQUKWwweetUY94tTZKZL?=
 =?us-ascii?Q?FJT2ynMiFnZC9NOMUXixMha9D5YVM545e4UIDHUrh2NyyrewlAv9e/VqQ2Wk?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +U8v4mw8JextDzAtt6FHPIGQSlQXZUup5tkNg5zUnsN0uvV3CVkB+6GxBbxeZmX2T8YfskCUMe0/PZyJQc5tmYHRKJJNp6pq8IpaLI+KdN911+5qAgxn0xJKoCu9aiCGsMxT7Avpuf0Ln6sJyfb3QoH6lzpJGfgIL0o8g/Usu9sFlqkt+kNHCe6kl2V+ENvulmADVo41M2oi6thlSFHdUuN9Fh5ulIs53zg0PxsQYzRYnLGJ92I2MUJBylhSj/KgH800Bk8UDOJ9cFZqKoTSlvzCeBCtn6AWA+WCj+LmzJuK/wKZBVSEQIywDGH+OuxbDvXtWCaqWToWSCdq48ztFDaTm3N2ersonPvYR3Ox5P26EMDvmIXJrooagz40lyYIlarHTfAkk8YxoWzaly+BXpCpSKV85NKRZ+dQXxGeJpD0db9sBCI2pNUIqyt50wvswGHVfxI02bEXhjWColL+KLQRCCDisrM9rPg+wLYcBkcR5UbHrcvC1KeLiDpf18UGKf5fqWNvNsHb4sbxRxXQf7w7CFAS+hFgJe8m8gzQeFgB1TEvt6YfUY2Lu9FJHpgjrIrBlveIJ+L8tPh+0KMygSErPq70NFRxG0M1P5cPGpFHPzfCvYZI7y7cWZyMW1y2hVeUgUyUXizvO72E5BNZD2WRMY8FyvWVSe09FDxGiDzsTjtYpLnV9V0ZKWFekfFkDd7qLbIO2hilC3yo7BylvXvXPUVrywe3QjifojGTvfk0C/wv2NunA1efQFIkBt0JGf5N1UT4Intr9pFn0voW+BSsaHfw0NhACk2Vt31o4WikeakxfyTgeseANWawaB+a
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a40c5a3-91cf-4e6b-c9d4-08dbc4eab7f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:00:59.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLiiQeQ6b/s2G6H3nn4tm2zN4LiPCQMqdVMrbUlhgeLrG5FRp/jLR9K0uYmRL7uLhgENuADV1XHrwgb/78cG6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040108
X-Proofpoint-ORIG-GUID: feXBoWcHdUYSQ8JmllLCLrHQ5ZQNZbjp
X-Proofpoint-GUID: feXBoWcHdUYSQ8JmllLCLrHQ5ZQNZbjp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The device addition operation will transform the cloned temp-fsid mounted
device into a multi-device filesystem. Therefore, it is marked as
unsupported.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 848b7e6f6421..7d8d217cf5fd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2635,6 +2635,12 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_info *fs_info, void __user *arg)
 		return -EINVAL;
 	}
 
+	if (fs_info->fs_devices->temp_fsid) {
+		btrfs_err(fs_info,
+			  "device add not supported on cloned temp-fsid mount");
+		return -EINVAL;
+	}
+
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
 		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
 			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
-- 
2.38.1

