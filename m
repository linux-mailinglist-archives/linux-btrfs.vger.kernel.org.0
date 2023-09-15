Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C94F7A14B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 06:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjIOEOJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 00:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIOEOI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 00:14:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018AB2703
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Sep 2023 21:14:03 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EKxZSw029217;
        Fri, 15 Sep 2023 04:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=v1XTdY/8SMXzJ/kK6SHlu9knIbc147IVanONA0YYBTQ=;
 b=SwyYuvffYAQzDzFFi7Z9mwEV1aF6MRxaith6fjOELok3Qk0uK89mJhh6MC2kXxJCT5jO
 37Swu6NjhBtvKeRRmweb5l2dpRbCHORzdLH7JHQLsEQ4E4+DbD8zzaRr06lUwanjnwNl
 7gzTADzjZmazFntoJeb1o4hCqyP0nVZamEyKOs0G+7/ROOxVx8seGmdMH3jopRe2aXGS
 zqyuucnHKWq8MMUxmqm2lF/7YiPZCROmQ4yvziK54oUS7kZlx05VSItbyAlTg1mpB3f6
 +3EWLgRcxEpTelItntgvvxBlthnJ1bkrsiQ2Rnm6QyJOpabbFfvkLpOkb5L+2H/GwMov 8A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rf13x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 04:13:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38F1Vo0N007350;
        Fri, 15 Sep 2023 04:13:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5aaq8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 04:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ViIF2kc8pPJkH4EShTJ6QyXeKS5SnY6bo0SyJ1OFRGWz9fWveMf56/ff2pQmtSHPe/NcwwBT6NNm+NmbgGEM+sm1pGx4k2Y0n6JBnewa3SCX/OnPsSsw6prv869fTAmmVv5f80eLW/uOJQkrjLC/6jwde+5NGwPRo9NSiHl4l87g8FQSd2fU20nAvyTpqxMpD8Y9H4RYOvfLEJkmRYtvyuThb0ZccqWVhOACd1lNWGkmn/3AgMJaG19R6yMxOt5+D1riVmrvb33Q7VOpDqy5VQSCp8hcfAWye4PUWxd9+apx6Z1njCvEonTQH7e/N7EpjlflX+/NMTzCCr+p2qZFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1XTdY/8SMXzJ/kK6SHlu9knIbc147IVanONA0YYBTQ=;
 b=Xk2xLHV2DMiuskUehPUGCq2fHhQxnWOxM0LjV4qZHP+Oo5pRQwbn2ai7KoRxnbWBCYLkrO6c37QhDEwEU0dZxH7W+TY+xfc5f0gN+qXTAfG+X1bKRbUO2vXY/3CDQcAXMB47sEA15V7L0hIN4jnJvYCUsPSiEeTpT9d8njP1TWuytYt0fPrlJWDV16c3kAKYVAP6OM9kr20dkDtfbIPqcRnhX9S2cd2vIFSo0MqcGfFPLjOyEiqiVoPWvCuNW4UxwKFldKTeEPPEk4iFg4v0RYYpUOYG69npeehIEB9n5jJmfsa8e2AGR6NzoFfdae4WS48JDllUkRrumIpfRRByzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1XTdY/8SMXzJ/kK6SHlu9knIbc147IVanONA0YYBTQ=;
 b=QQMoQu1+t5MbO3Yj8d2WK/4GMN/Sin7La/nO48tXgBcNRgFqo9z+B4TdpDkxzrNaiZ3vHZIy4t9PzkEWf9c+Dwvxt5VlMvcSlPxZJXmfDf/co1OOjWBE3dcC2WOSMbr5c8piVtVyH41BmK2ll5FKUiM95krn7Gvv/3XhbV1tHlI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6544.namprd10.prod.outlook.com (2603:10b6:806:2bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 04:13:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 04:13:55 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 3/4] btrfs-progs: recover from the failed btrfstune -m|M
Date:   Fri, 15 Sep 2023 12:08:58 +0800
Message-Id: <3d40d1d595d0cbb5a772877375532d1864fcd8d8.1694749532.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1694749532.git.anand.jain@oracle.com>
References: <cover.1694749532.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6544:EE_
X-MS-Office365-Filtering-Correlation-Id: 0321fbde-c5ba-4285-c57b-08dbb5a22d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKXg1TuLmWdAd4s+lRlvyXq3ht18ubXnSlnd0lBh0jt/MuAVCSHTx+Svqenh7ilBTkhqTpbCh8Gqwzlx/uZOl3WL9AEWv5+WsNBKFmaYO7H7uP6yVQYdxQUkH8pNwq/Qylq/uHezj7otWOJ5kRjqw/9wI9L3Qqh6Y9nIHW91xmr3i5CNfSyu4u+4JRGRnG7UaBZAcD1CUTbsXlDew0hFJC/OqWavQF5vpZ68vw7wBTBOLm4tHEsTCej5r89U+J9JeuUgl+eypvo2GxJ7mlbsZeMy4lPyneX6nTkSME1cakQMBW1WR3RevH87muSst0JxMyXpfjRcIcs2ioxA+RK2fGMDRIwekoF1A22ZOV4Rmiu6BUmpxlHtsHuUsGe4uonbDWyARDQjkYfc9Fei0n3xfi8tRDb4PWifS7wX6zFiiavXMh2DKC3CUeg9c1nDMMt5ol90XaIo1Mir2FtWbxPrtrTJ1ir0B4A9Cb9Lhd1mfqhTzEsh9qvdzstFALi4RWwPAl77+YgLFRIC0qrmNQ5wk0SIqJYZaZxfZIzfqakY6PmiclmGrjBDUJ7dPN6HQGhh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(136003)(376002)(451199024)(1800799009)(186009)(36756003)(86362001)(5660300002)(6486002)(44832011)(83380400001)(8676002)(8936002)(41300700001)(6506007)(2616005)(4326008)(26005)(6512007)(66476007)(66946007)(478600001)(2906002)(38100700002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3xnW4ju4wMNkT8LlT4xSpG6jGHueES1SpwauC/v4dBjro10VlvX2nwe+nv/C?=
 =?us-ascii?Q?kYyQipOIJLFN9OdWD//JSaPMo2JYtSztbFf17ogWBlimrl3iJtDvdWWahLWh?=
 =?us-ascii?Q?r3i+ez7Fz1/EtO04sOksKi8Xhjbh5w4M6lWvDEmb48FLKCS8owB4rYO3/Ylt?=
 =?us-ascii?Q?uka1Ak6gSyE8cZG1nJgsGpniQBMHUd+g4naTrxO93YEgK8YBz5ZfOhUNGS88?=
 =?us-ascii?Q?jeuL7NDnJuFzctLxJ8a1Pyq/u+F3cxJxt8YT4DyiWB3F+YTh9skSj+2v8PQT?=
 =?us-ascii?Q?5xZx1oYH2/8MRk1nDfF9eaL1/q2SrgOv9fqf+BGlkEvxszIluvFVJ+OWA3+1?=
 =?us-ascii?Q?zaOIWV2wzXcW6yNmullsJl92bTKYYxO4EY8DgpEKc29MWT8RVHM0ZnQ2/eAB?=
 =?us-ascii?Q?9ldhYtcO97sKUHVlC2Uv6BNdurmnrDAhhT9syvrZcwZsMYuDvhjKFMhy532l?=
 =?us-ascii?Q?c5lBQu9JFmzteh1l+w/9wkiANBD6u5t4tdXXbSvhvmIKGOqqTDapjTB2O7nu?=
 =?us-ascii?Q?XxzRvtuIdn8+fcNn/yVh+kS86pO01aPfBOp8dAyTJ+iDYetODzjJHAQRtLzN?=
 =?us-ascii?Q?6YrN3SLjZkvI0Bx8LhvkOwAraevy+/z98ghbjP6R43x86HEI4CW+KTbG4yfd?=
 =?us-ascii?Q?jGPIiHOUglB0GtkCSBkkMPRffTStynX+K59M+H/strZ/0nnLMp1/WcGyIJr1?=
 =?us-ascii?Q?DraSM1pvJyQO5PEIdndPzDpjucKEbpqtjE1szGFBx0nvrVcg0JDN1QbHyFyz?=
 =?us-ascii?Q?4k+d3MEuZJTDFI6eo+9CymQkblxPkTNnAHvJL6/5qecRG39TZC5rgdhoIp3w?=
 =?us-ascii?Q?1OMTrIqBKdHw/ae1SedWhIwkgV15gWA3oX5g9fiLFwHH8fClD6uyxdbcQcvD?=
 =?us-ascii?Q?4uWqSWXlH/9j8pbPn1GcAtEl202MyEXZfGrWgG0EAupST9lVb9ZnrwlOHLvG?=
 =?us-ascii?Q?FdyX+JHLEvw7n9oHkbwh+0B/ccSuHmT8WRkAr/O90+l13AB88TITXgGTnGB0?=
 =?us-ascii?Q?zaWD1ZB/xzaqrkEePn5TQKQ8n6fcpCCARvbzAQepkUXSplyvCiVqwk7jXkld?=
 =?us-ascii?Q?kmcqVXOFirh5m9r170axw8/tESTRjUA+t2O7YX9z1sK+03maHC+WLRIqHmdl?=
 =?us-ascii?Q?msUw/dTNcXszOZ69xjzVav/eR46FTdImfAxmVG0qlfFxEcUsK/Ve91hdov4f?=
 =?us-ascii?Q?kwfI3XCunc8EIFEom5KHQ+jDpONCuf/R+iYeCTfF4+NCH4kGXDQNyxLha8+r?=
 =?us-ascii?Q?uGDT652xLqSzrYvz9tlcS/Pn6g9kYhuyY8nsItbDx/8CGIUQN3uQX5/Ayjnf?=
 =?us-ascii?Q?fW7bDi4b0uCS0jk8Vizr/3JgfH9Gtsar5WVe3qM9cyPCfrq+kxXQJNcV6Ktw?=
 =?us-ascii?Q?wGoCa0a0B23BWaHvPRXIJlf1/2oyGCXLecrXIoDWjeFqt/jpZXZ4zR0bUrPI?=
 =?us-ascii?Q?d8VQKjy6P88Ne45lOUvZDdGFPQ2SexJub1kmdcZ6giUQj4Ch/wE2B/cjysQD?=
 =?us-ascii?Q?NAupKd+3iSO4rvgxWprI+0SZ7QRVWKIB7O1Z9YkhItJRdEi2GXTKm11/+1D+?=
 =?us-ascii?Q?cyqYPA38NZu3VZZdt5flwNg/0dvMVqiZ8F6vCCy+ldRhcOSMXcFFVEC+cH8q?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6tgZxlkLmHqVWLzXaJNqtKgl1euVa/wIZjIftlA1SRZtIGxHLf27H8JLi/rsGupqVBh8iHBZa/1RzKIsMogRcG+W7AVoztderWRQReo2oz2Wlx+kWOAgABRFa9zvqgpCeW0+XM5Y0v3BYX2shmYcRYUXrxebob+NVEqJTGqg0CM7xxjO9yfuv+wmTisPb1xAa59MHpn3xI8SVjUG1i3/PMBQ9VoMHBX9FvL3LZlrXgT7OP2rQHxHqB0w6y+KmPT0aoLpytB6zHZyMdhaEEEaMFE/MJabTyx2RLJPpn8oinC4NWJkM2uC9Xk98Jq+ixd9VW31YUg6b4QsLQBCeHND9oJ/aPUed3cow32ru4GRv4AD5+LL3wyl32nlsrBTlEEKtUgpyj8iC4pdt5VJ0+M9DVGB6s0rbSlv9Ul5sgO33+oLFx8ESXR3gPooSleJb+djKiiwiK+5sUZPcWuOeMLfMlJavkdUab2TmJKPjhS4FPIDUexvE1n6/4DAv3q+8iN8iuE1ZyrPSAKk6HQk891G0TL+zRCfsR+ZP2NhDo1fkqxxji0PMTIOC9Y8j167RSlc0UXC65eX4AwN/SMzm7vs/0PcBmu1f3tCkixJRSrl/f9gMjKj39Srxr9o1Ij+AuEBIi6nb6x9s8Z2wBLiF9uJ1OwhBg62cXAExShpRsZ+doQxgFE3PAOYGVHQdhDQHR+41G8wL+nf+chI7Lc8yVZbCAaoHH7Egj5t6X3loYig+2PAMO3XhJd5tplqgsHsExSQFL9mBiSi9En+GRxvAN1x1Pd7pRGnuj1Md/CodluyF9k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0321fbde-c5ba-4285-c57b-08dbb5a22d4b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 04:13:55.4874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2GeyhJgUoZJkyIX84IRAk75cziPq215C5mEajDLMfifQI7OtCCV39tUy1eu/ay/X7JfyumAS4PnVl9cb7kHPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_03,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150037
X-Proofpoint-ORIG-GUID: 9DnJ_-tauvxr2MuVc9_dqKPT9RDduu92
X-Proofpoint-GUID: 9DnJ_-tauvxr2MuVc9_dqKPT9RDduu92
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, to fix device following the write failure of one or more devices
during btrfstune -m|M, we rely on the kernel's ability to reassemble devices,
even when they possess distinct fsids.

Kernel hinges combinations of metadata_uuid and generation number, with
additional cues taken from the fsid and the BTRFS_SUPER_FLAG_CHANGING_FSID_V2
flag. This patch adds this logic to btrfs-progs.

In complex scenarios (such as multiple fsids with the same metadata_uuid and
matching generation), user intervention becomes necessary to resolve the
situations which btrfs-prog can do better.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 48 ++++++++++++++++++++++++++++++-------
 tune/change-uuid.c          |  4 ++--
 tune/tune.h                 |  2 --
 3 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index 11c6b4669949..c118d06fae10 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -23,9 +23,31 @@
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/volumes.h"
 #include "common/messages.h"
 #include "tune/tune.h"
 
+/*
+ * Return 0 for no unfinished metadata_uuid change.
+ * Return >0 for unfinished metadata_uuid change, and restore unfinished
+ * fsid/metadata_uuid into fsid_ret/metadata_uuid_ret.
+ */
+static int check_unfinished_metadata_uuid(struct btrfs_fs_info *fs_info,
+					  uuid_t fsid_ret,
+					  uuid_t metadata_uuid_ret)
+{
+	struct btrfs_root *tree_root = fs_info->tree_root;
+
+	if (fs_info->fs_devices->inconsistent_super) {
+		memcpy(fsid_ret, fs_info->super_copy->fsid, BTRFS_FSID_SIZE);
+		read_extent_buffer(tree_root->node, metadata_uuid_ret,
+				btrfs_header_chunk_tree_uuid(tree_root->node),
+				BTRFS_UUID_SIZE);
+		return 1;
+	}
+	return 0;
+}
+
 int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 {
 	struct btrfs_super_block *disk_super;
@@ -47,15 +69,25 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		return 1;
 	}
 
-	if (check_unfinished_fsid_change(root->fs_info, fsid, metadata_uuid)) {
-		error("UUID rewrite in progress, cannot change metadata_uuid");
-		return 1;
-	}
+	if (check_unfinished_metadata_uuid(root->fs_info, fsid,
+					   metadata_uuid)) {
+		if (new_fsid_string) {
+			uuid_t tmp;
 
-	if (new_fsid_string)
-		uuid_parse(new_fsid_string, fsid);
-	else
-		uuid_generate(fsid);
+			uuid_parse(new_fsid_string, tmp);
+			if (memcmp(tmp, fsid, BTRFS_FSID_SIZE)) {
+				error(
+		"new fsid %s is not the same with unfinished fsid change",
+				      new_fsid_string);
+				return -EINVAL;
+			}
+		}
+	} else {
+		if (new_fsid_string)
+			uuid_parse(new_fsid_string, fsid);
+		else
+			uuid_generate(fsid);
+	}
 
 	new_fsid = (memcmp(fsid, disk_super->fsid, BTRFS_FSID_SIZE) != 0);
 
diff --git a/tune/change-uuid.c b/tune/change-uuid.c
index 4030bd523bce..810e85e1af45 100644
--- a/tune/change-uuid.c
+++ b/tune/change-uuid.c
@@ -211,8 +211,8 @@ static int change_fsid_done(struct btrfs_fs_info *fs_info)
  * Return >0 for unfinished fsid change, and restore unfinished fsid/
  * chunk_tree_id into fsid_ret/chunk_id_ret.
  */
-int check_unfinished_fsid_change(struct btrfs_fs_info *fs_info,
-				 uuid_t fsid_ret, uuid_t chunk_id_ret)
+static int check_unfinished_fsid_change(struct btrfs_fs_info *fs_info,
+					uuid_t fsid_ret, uuid_t chunk_id_ret)
 {
 	struct btrfs_root *tree_root = fs_info->tree_root;
 
diff --git a/tune/tune.h b/tune/tune.h
index 0ef249d89eee..e84cc336846c 100644
--- a/tune/tune.h
+++ b/tune/tune.h
@@ -24,8 +24,6 @@ struct btrfs_fs_info;
 
 int update_seeding_flag(struct btrfs_root *root, const char *device, int set_flag, int force);
 
-int check_unfinished_fsid_change(struct btrfs_fs_info *fs_info,
-				 uuid_t fsid_ret, uuid_t chunk_id_ret);
 int change_uuid(struct btrfs_fs_info *fs_info, const char *new_fsid_str);
 int set_metadata_uuid(struct btrfs_root *root, const char *uuid_string);
 
-- 
2.38.1

