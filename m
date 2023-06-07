Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0C2725B2E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbjFGKAM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjFGKAL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:00:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E41C1735
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:00:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576Jtkg018042
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0LduO1exDaYAIvA8U8ZvPKe4jKKCbLPtgyUMcknqzDw=;
 b=MAZXuPwMeqqONNNx9tPQWHOksixlf9geB737TIXpjUsJen2CJUEAqjGQXQaFd2nWcwCR
 FMz0Fny7Yw8vnaGIF/s+waGfU4uQTxXsqBwHA3Y68bRY3GpRdC016E1lYf+mNJiKfcCh
 1H5EOSQc6EKrTyFTNy5E/cca/GVzK/LIdV+2TNIxD6LYJEIpqEsKi7HwEhnxA7qLAJuS
 /FMFVTXtc1VDsEudZVwYjUh106m6YYIXOJTEGrhRfGhSK0o8gqgWe9jflnP6y3S+TpEe
 jHwAUIRE65urSHrQFqH8YMNSwNUAC7NiIC+Kxv5yBLoc2V5+bK5+P/5+8OCCiSzjoVi0 dQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u9c9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579Twgb035855
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:09 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6r9g7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtRJC35ZA+Jl8tuLzXgdcQv5ot8k4IVBCKnp+O0uc2UAnXMZmP268qiU6oC2QPcRiC40vhFfZHvFEjzMCL43V+qQxIoclzrrhQ35CgsbYSB6naM3I6MGbQTcfOJ1cl0jsE7//stm6x/EdjydvPRxXQYDnkmvQTbw5XDwTM5n279zMndypbeoWhORG+bkQbbPvaBz0i5G6MbmMrRevir9ecgY7Ko+Ss3qm9jBtw1I/NYoaR95T28dzDFMLEYXVk9Woq4RtYVazdsFdKlH4bEnnT7xK3f3ztQR3ZQNhbAEhl5K+pLlprDG6lXt/f7v9P0Z2Pq2BUqnWrNxyVfSCL4IGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LduO1exDaYAIvA8U8ZvPKe4jKKCbLPtgyUMcknqzDw=;
 b=TcoM+sMaNH4mgGxBKK3INh2vjGBoQIb0mggKv845oVUWpaB8CHtOgVm5XVPJBkuBiv1RSbHmTD4TdZQrAd2ZYUOhKxA+vNqwgO3hOuU6BhEljwZemjF2ppdR3w0UDxv+sP3R6K4exX4aN0ehpdxQuRUeGfIl5rQxxDZSkG2h8PHOd+lUqwbbgQ4ZB0tlz7rGSo8iK23wOCu50RScrQjFf7Iww1uI8mNeK4yDzXUX/7Dp7PDWuI7kMDXJNqWO9bsik1W5kthhdtOsNlhMnuke2IVxPqjC1yeMhKhpxru44oKjQHVZZM5YWFKKpx/BF8VIW+bni9FdlymwXcJLmjMoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LduO1exDaYAIvA8U8ZvPKe4jKKCbLPtgyUMcknqzDw=;
 b=GscV5BuicjK+IZA8RFF49orIlwJuVwcnu1/9gF3jR7ILi/tjsFShiVXfenJXgDTJGVC8ZBvXB2iG0n3Oz3DeTodnwEa+LqAtKoyAdMObup+/OwoZCk5EsGSvlF/TQMGUx375sYBcADcDNDDrIObPeAe230t7bU4rNFg856QCOUQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:00:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:00:05 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 04/11] btrfs-progs: optimize device_list_add
Date:   Wed,  7 Jun 2023 17:59:09 +0800
Message-Id: <d56a56492b6436922a82dfebf79d3b35abd1a25f.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
References: <cover.1686131669.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 82058da1-d4f1-4a66-1b2d-08db673df81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: flLZt8nibIymj+HjxC9LPhMxl8oW+FHCDn0KRlfxM5v0lovOd7k2nqDv+ogGJDMrVuHXDNzjTuHjDfr+0IVow2yJnH0IONDHctThhZ4XJ6hfveV1g9EdgtlKiYmiQEmQWfAovSmelIn6EQKkbitqw7lsHAawVn6OoYaiwqaHJyDuiXbFarLkJ817Wl9a6UfVrR5JYoxIr7G3J86CcfuEXT2vtnn8G8r/URseMB8srp0XAewnsZVgUfb4tOllMD9iXW2NoOf30xbjmh0HnIT34sMEgsbaevYIhB/9edT6ScGW5W0xkd7MASTGgGVeid+TNkSnYbnUZfFZD9MKWrDQZhW5ilEq7hriyj0/ett7k6KRqumkCFrUolhKgl1HCDpT+gPFKCNiJmq2MTZIQsI1IarwFfXRHW0cwAuZIeahe9UMhtGcxe+X1mazpMdr5DAA1cCf/8Tg+AP5wjp7oiEs6scz4l2dGSP0aCn8k9SQO0fzgYKZLlguNx4K6xCw+i0GH+ieqixtLTyD6PupmSIUs9/m6lJ9F/MraWtG9Qd1MlRz00wJ+XrmTLI6IvWc/tCr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t/805EXY8PDDzcgawZxTfp0DSCOCSiqUd5F/mag0s7XBQnT4zge9ubeXrd8r?=
 =?us-ascii?Q?s1y9IRw/0xh7+sDVL2L8MS7ILqyk25BC+1Y4gfXXVNYO6KmHPc/GQQkyOhBf?=
 =?us-ascii?Q?OxYXxVSSz0Vzy+nIq596/jOfoIS0Ht9j40yOy7VcHRL39jU++BtdAeWVgWR3?=
 =?us-ascii?Q?NZHpBiMKAwLao5AKjy2alENI/l49B1EKOSK7MJ3pir+BeNP864gjwWUtBQIm?=
 =?us-ascii?Q?BlO9/OVo99ohm7F07WuJisWvn/geXvHtIQUFeE0uY4ByCqEcjISBLo0V2lZK?=
 =?us-ascii?Q?SHm9ZuFfErEBGv4umqZefoa4EjSGokCnzImoE2IJLFJ3BeYUPS1YB7ctldb/?=
 =?us-ascii?Q?O6WueoejBbr5vCd6yqN120nttlHPlJRsLO0wg6vBCdsVvCDO5i2GmP+1Stxe?=
 =?us-ascii?Q?/QdEzqEaI2RE6FZ2kMuLnhQwomLWWrBEkzUTUfxIGwRfVNtV0vWziyYIgNzz?=
 =?us-ascii?Q?a6p6JboCr0fadnc9mOaAFwa4Hrlp1ObrZWyKs8ur/7QMuGbGCTSfBBGme2Z1?=
 =?us-ascii?Q?dejDD2m6vDu86zFt2SXzTE5iaFVQRaEQ8bZ1LkSNanIfpm7lt8ZaI54hLpCT?=
 =?us-ascii?Q?vQEuRvHZH0PNs7Rjo/HykrwBti6kl6iBl0exBwxJYGhmoOzeBp9czb9H0sLf?=
 =?us-ascii?Q?yyYIKFm+4MbYj1Uzemx5xq9dF+44mxmn5rkNQqe7dj7//QCOSY0GJZ6vnYn9?=
 =?us-ascii?Q?34WaXf1FoY7NNlten0rBEH7Gy7xO3VAobgRXVpHecnEOaDH6fIyLA7wxWi/c?=
 =?us-ascii?Q?MrkaDaxdlHJAoahThsAz+3YLVY7jDBlO4dFUJoHsTIB80kNElWCG2LnlD7/v?=
 =?us-ascii?Q?51mWldF9pkkXbj06Tazdk+oX0ZdpCcZrm9cnLGcJxnckS9V7orVcutH2Jnm+?=
 =?us-ascii?Q?3Tz7dgJjfD1GcXcmlLbv+wjmVAypDUGxriRVM7sfXWmn9yOG/hN5lplcGdQl?=
 =?us-ascii?Q?5OrxCSzzdwfIa5k3mF5/wqmg+vqGkJUsBizGQ7Lqf7An4fwlYtYv6ZjFMDe0?=
 =?us-ascii?Q?HgLt7L5Fe98XjHHFPzvAYzjBjIXCqbyA2DE5mRmyD0ukxeGAY9wuwRWGzgv2?=
 =?us-ascii?Q?R93hdpLmCvluUCrIFK/P5ltnqLveno67ayuWXjphPw7t+f89l5b4D7v3G88k?=
 =?us-ascii?Q?m+/355OtsK1hc0Q0JhC71vieIer3yyXiWinbHSobMYTZMFTarI9wjRtxtEN6?=
 =?us-ascii?Q?fWHz7p16/i8TFxF8/VMiDySn+ola/kVxEESLCaiYLfmcEVaB1vCW+tYWRXu9?=
 =?us-ascii?Q?otBf3olUPwi3YRTrlnMYMTN9SaYic1zha+SGIzcV5Y6ucUWozRiQM+pYMoj1?=
 =?us-ascii?Q?m/zVxNZR12S5Zny3Y8gZhoI6EuxkABXDFqL6Kjer4+0+qzpd+MlpT6YjImp3?=
 =?us-ascii?Q?poqlanVW+EDMRWJsCA7f6O1398nJY9tu+uEm9T2XUiQ15NnXo07JQacIj/a3?=
 =?us-ascii?Q?8TniM2ef2dLz2CCIACUOzswJFGLslqGMzX/Hdv1Pea597hy5eqRV5PzFmeii?=
 =?us-ascii?Q?0PPgtynyn7o/FUuwF/xnTtn7QnGggE0IRF+z4y/U/CuQWY+vOjzmPQoui8lO?=
 =?us-ascii?Q?ACW0BaAvblPYQOtTdOxvn5BQqcZw7Ai4/K/pwK1ZrDsC8NaZ5itmzecGFRbu?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z+p5OPm3PpywYOGouyWzQ7XT2aKuIv5eP1NWGtwRjJ7xBBYmbY+t5Szqzgy7tiSNWdR+qv96UYCtYqYhBFLFlQsIIj+3sKl2LNNXwZoo9Ax1wzet/TJFiXR2Ej2DdcTxWsoPjHtLm7R1lL01UWBVsN50LeYjVCKOCsTZ0CN1MY5Elh4Bwv1nfr3Zi5ngCSInX5hNHED7UDMn7Y+S2Mg+mczqkMMOisapmT+06mcsoWdDcUvaBfo8+meJytnlSc4RRrxWLPBmGs/RqsDb9f9hjhFo8LidrWOj9eprrRiXoimZ379rsGDToQb87Q1c75iBOtiipvRcXUXf+Fdaxs04k8yHOmICAv9Ut75gFb0vOsmq3e+FObnsTOZXYr/JLKzV93hcEGlJ9EAEvEGIB3bN/HgN9PYkTTyrfGQwRsRdEVquqNW1DwMI9fBn+zbi+11qHEv0JC2tVLOGRiuDedNX6l66RPqm++aYQUKCHCAihmct1qeTzYlBndkifSTuKD6wqc3NTabwE6TUIsqMcWgNpGow9WvVkBZJe9eWof7HE2ghqF7QHg6Hh2pW3eDS9GP2vw0bZaeJn0IlLZIcIPEZMNQ3QOujf8tiJAofVApkWVLryZt+V6YjjiYGAe/+0yCZc/GwKe2O1v5w+fMK3d2dsF8YNmh/2bDyiZWKMhqoa01GT8Cozq1InapvG7Dy4LLfbExTl137/pA1mgLvYmFtkdhlUU2UeEIWRgxQyjjTl26Xs0o5TfyehoYY3pMMRdenRjJ2TkhlKNQm8GUHG9bZ8g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82058da1-d4f1-4a66-1b2d-08db673df81c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:00:05.8799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yB14T6EKH+YY+/QfttXZgHOh23Um6mKmAArOyZdwcMgHHs0Q4gWuSD87mDckDovV+6E+5Z+sWUM/OzFCDLH1eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070081
X-Proofpoint-GUID: Sy250w8tRsozP5vgoEHqEmpqbYSfU_0Y
X-Proofpoint-ORIG-GUID: Sy250w8tRsozP5vgoEHqEmpqbYSfU_0Y
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Drop devid argument, instead it can be fetched from the disk_super
argument.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 95d5930b95d8..81abda3f7d1c 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -334,11 +334,12 @@ static struct btrfs_fs_devices *find_fsid(u8 *fsid, u8 *metadata_uuid)
 
 static int device_list_add(const char *path,
 			   struct btrfs_super_block *disk_super,
-			   u64 devid, struct btrfs_fs_devices **fs_devices_ret)
+			   struct btrfs_fs_devices **fs_devices_ret)
 {
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *fs_devices;
 	u64 found_transid = btrfs_super_generation(disk_super);
+	u64 devid = btrfs_stack_device_id(&disk_super->dev_item);
 	bool metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
 
@@ -545,18 +546,17 @@ int btrfs_scan_one_device(int fd, const char *path,
 {
 	struct btrfs_super_block disk_super;
 	int ret;
-	u64 devid;
 
 	ret = btrfs_read_dev_super(fd, &disk_super, super_offset, sbflags);
 	if (ret < 0)
 		return -EIO;
-	devid = btrfs_stack_device_id(&disk_super.dev_item);
+
 	if (btrfs_super_flags(&disk_super) & BTRFS_SUPER_FLAG_METADUMP)
 		*total_devs = 1;
 	else
 		*total_devs = btrfs_super_num_devices(&disk_super);
 
-	ret = device_list_add(path, &disk_super, devid, fs_devices_ret);
+	ret = device_list_add(path, &disk_super, fs_devices_ret);
 
 	return ret;
 }
-- 
2.31.1

