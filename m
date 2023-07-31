Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA48769483
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 13:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjGaLSC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 07:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjGaLR4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 07:17:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0941BCD
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 04:17:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VAitCU000970
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=E8ontY+bhkmoRt3jFnRVTjIYtiaCZ2Foa1AIJG8OvOE=;
 b=EwY0KyTa8CtZ2qUbqj8AkdYmVb1FXkKjGXMEflmP2I5CaQEfzGs6LRoUXmUYRBLR7xZY
 TDII9vG+7RBbTmtuJhPCI2dis9lCGEWV6Zk/JrExxojJ7ZYR/30sqQBK/YkSc+0bw6t4
 e5sDbvW78ozl1QMfWHiGfYyfJaQ6QSqc1Ty4JkOc3yLFo+AB0bOUOh1Ll77WvnJ5ghXr
 7MIy6nLsyVdv4rEbGY1Wf3FrMK3Zt1E/cJcG2ro3AKCFy3Mswb3VH6AF1N5Avc8eZNph
 WWDCJ0xnOGRAu5UQ7o6lTxkRXq5QZTP7qLFy0BF7uUEizPpyRhaO4MtDX7W3M+QlyQSO Iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2abpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36V9NDiJ033596
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74n228-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBu8VzMbGE1mcIKytF3MkZyiF3n84sFcsiDkuldZ9qI4Kxqb5W8GmTI8hW38I1X28XHZVWB5ArG0oJPzWBt+5ggqysmwVQ463XvKwq/p8F9TXDaSqAafBTNNhcvoDcid+wuJnvO1BKLpv7gsAqO0xQ/Ckx43TsMNY9fYCdI1ipvBU16BvEo40wCF0tVSPwHUz5Nbd+Dfv4kYmGaKchOzRWBO8+MLqQZifplu8Gzx3P4dn5+++IKC3PR2H2JFmJ2HqryxIiAHMg+Dn2+x0otaKcO+u7eamG6fsuWRlpEJCPKec7bL3Zvl1v1HL1F0JAYpMUxurJ7pq+5unMknMtmmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8ontY+bhkmoRt3jFnRVTjIYtiaCZ2Foa1AIJG8OvOE=;
 b=hT4Qs3g8RicBTR9S9uLhgiUO48EsUrICJJmUsY0jxhNBaPSbETo+zcv8CVfiwyxY69HKFDCxGHLRsBhLxm591YW11tGwBGhTlat5tLpUeIXRN2c0eGwzau5WQdrOGhNYlONNlk+kZWbP9jy2SNfwQvhIy83D4rm90qmXEtgo7fDCn6m/fj0GVxVrWwJzXzywoGx2Y7MVFEJNCEX6vKXfAralga6yK6wrsIJeNvX+X5uOctx+6VRltz8livsSBGUojwYYQ+ZBPPzfdQjzfPX+P7y52LKq8ys+VRjTK9sC84jvpSb9LbSY2LToY4VXMdjsYBfRgWhIhNLn6t4996dtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8ontY+bhkmoRt3jFnRVTjIYtiaCZ2Foa1AIJG8OvOE=;
 b=bPYJuPN/Z668W0+vYZrWVswxjDDc9m4es7SuFVBHlYJmJX4xV1SIhqWBV9mY0QD54L1J9x6bd6DDEs3UOej2J/HepF4KTfJePw1e6mte+mWxkS1x8k5st6YsTMMi3y90+zo4KcIk89G9m6QFOZQG8oR3ZMNAPYIkdAUlCbZc6Dk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 11:17:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:17:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 3/7] btrfs: fix fsid in btrfs_validate_super
Date:   Mon, 31 Jul 2023 19:16:34 +0800
Message-Id: <19310b1aee2625da1a90f59c03a8b78fbe21e8f3.1690792823.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1690792823.git.anand.jain@oracle.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 3746fc85-a9bc-4813-fa5c-08db91b7c76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XB7HuGbvrwsMQJvRaBeVAqvpGClvl5333n1E5EbpCjWCM4cHkWpoF7oxMX9KiuMwdt2D0YM962/3xxt1Aty8ivlPxzBjd7gPnkR95Hoiu53kO1V/ZTTvkMYQJqzjcuPSlPHvjDm3L3UhaoiVnHQyoR451hewq4/5tjOXqohmuFW2BqFswoP6pszLH4TQ++GOR4W8jo6rMxr8aWkNwILB5fuKVeRMgZBhcS4VXYMuL2Y2pRQQdSZJ+2xdOYRPEtKHTxzAdDheTVCc6UP8f5VVrgA8UvCGxjg3t9mhmrt2P46hESaRI+CJvFoMWDUEnr8QuOPvZHUSncztsxcaw3EChymuMsTuyXBJeqlohtrBjTwSEbka6i+zIGnuoLthJi0qM+UPl91+OMbXSkfORMYlrujQwX0bf2UOIZMs+6O2PoFd3aXLyq1GJPNTdAuqZFLiNRnOadpun38OvcL0TPXakrJHwvg+6JGDWDYwVrlQFKh7VFK795drwRWGPjM+bPUdQ1nMEITUQU1PKrIgIA25687Fr2WhALqa16qaJxV6EFKQ63o98+jtNLc47HaidJc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(107886003)(186003)(44832011)(66946007)(66556008)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/uCunw1Kf6aH1MQBFcmz9g4A+rxC3UY7hUMQiv07RLL3iSaRAN79XZOJ3hWz?=
 =?us-ascii?Q?xJJwsRPhqkpT6z449Ipz5orGWrBeyEui2aswUCuU3PUIIkGE6bh/CIdkeCsE?=
 =?us-ascii?Q?DfWcB0FXqLbn9LgzP0hntrH+NijXEyJTf+tQWwn7Hkeovvrl0uv9/2NHvyTy?=
 =?us-ascii?Q?XY1r9oqh+u5ahp3PgkQniA9ftdx3dJAshz+PaaQTO8qpXVVvYdwEJTvGZlq8?=
 =?us-ascii?Q?FvPTi+Nd0fBbm1eUbrS1AL479ScYMzFlN4ZoiNhdeyNjSgHo+SOO4/IXifDO?=
 =?us-ascii?Q?wU0om9QVV9WDKOsxFiHOWzkan40UtgGVVAG4CP7HqtJZrWX5eLZYVkLgIo9B?=
 =?us-ascii?Q?0KbJE8U6Bywr2o/AtXGP9PyoXOMzRyyeHCVrEG+bQ98A81d0DtAwZwPpCnZP?=
 =?us-ascii?Q?XvL0LZVYov+KY9e2KSyQigMLHujze8AzzbUCXv4quUzOzNLgyUPV64pYyajV?=
 =?us-ascii?Q?YHAYnneEdnkBl5tRF70C4DINB0Q2oaR2AlgS+xr3iS1/cdj6QZyvTpAASkQU?=
 =?us-ascii?Q?YNYepOFT5pAEjlUR0jcdw459SYPbp3Caf8wbrErxWbC6JeCwUDRIthGn7UW5?=
 =?us-ascii?Q?N60/lI3yMCqJik1Fuc14GDZEh3eI77Q7PnwL4WT4tzWqmLKlgB3RVUqeHpXp?=
 =?us-ascii?Q?sft4VmK03Lr6ZKds7iqjLLHO6u61ODld+6CeCY2bjr0zx9tGBY9u0YpZ6Dyf?=
 =?us-ascii?Q?vQN96uFwdPN4kAXaMfTDzMYvsNAw+ptqmSwHri5DzMt7PuDm6dVOFNDPpuMV?=
 =?us-ascii?Q?1p75E5cirb6eD/y71EYIfuuHlIeK4wr2nTF+MpdIRd3FUa6sdXMtLGv14pSG?=
 =?us-ascii?Q?S0QDFUI0HfEZ9RdyTw7Lev/hjwMRrVEk/bN0HTMKJoh3kW0vKGmDMRiTFawQ?=
 =?us-ascii?Q?RpryNYmcL2c13qgsPz5gkuHuQkj/bzFMg4YOK6YGrfdKTi24JrrQWC1PZVY2?=
 =?us-ascii?Q?AFlegWWshZ4p27N4PjwsZFmQ0SGHgMbxpMs1Nwk3Al16dOUz76RvLapQ+2ZF?=
 =?us-ascii?Q?S1QviEF7qpNO197MvpJTpgIkTOCbhv86QzP52gOWew8rs0qNwoxDxHD7Yw8h?=
 =?us-ascii?Q?8IpR/n9ax/Nw2atb8B2uceSNe3IQqcaimfbKBbYQX8h/DfTDOKWbGqIsv2PA?=
 =?us-ascii?Q?tuIHF8hwjsddfQ5auixxlEhR/X3IlnG6Ok4kuruNqCVJrcWcKjCCRNJvIIgR?=
 =?us-ascii?Q?aikey8muQ55Q8m/XEgng1XsBfTzTjMfKemhK7X44F595ZFO6cwPjiAqhUC5s?=
 =?us-ascii?Q?M6jzYnmPwF6UdB7RuwHYmF1QxDXmqzsqIowxkZPujuFnY6uiA3nNuNjV+0ww?=
 =?us-ascii?Q?oGHaNzMFmXwmd89PN63mnzOVnxxyLFOMsifsUazzJuXDH6PFOwYtiytCzhbe?=
 =?us-ascii?Q?olxgCUv3jse36aMp6XyCfv2NNFGutrTEDSFw/g0IJOKmPSbygnD9bxFSMHUi?=
 =?us-ascii?Q?F4CHolUYuABgwrT7RIZ8haMJJM9xuqEMVajT5gVEA7MtfMD7MKq/CusviwU+?=
 =?us-ascii?Q?yi+LihUhCpaB9ocMUhAEn+8x/PzsgqnJdhMHr+5roMD2VjLyYbiyWTERM0vQ?=
 =?us-ascii?Q?pIYPlDP8xeWBwjipdAyldJFJx40remZRiyfwZdct?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T1M0WjWzNOqduSL1H9K+GJ/sGVEHhDiuV43WTk2+v0xCfQlkR3TbWRW9J+X/twWhJR72qd2DidJ1lEIPA1hyv/Ro0hpXj496NJtFKS6CgYcW94u64MuYZoSLdfF5OsLl1oSAC1hE5AhJk7wnS0g8g04GBSE9SlIDx2U4hSqfH52FWy92dE8+qY2t1LmoauVYaLjRWQSy2+C914joS7nPypL1GowyrVa4ClGcSNVLKxMSClg4UWZ9puJ8JRCNplaUvhy+LoPtrX3iEgUBiCEvzIEMHaMoQkMjpVFP0usDioJB6iRE4ieD7DMt0Zf6LhZhcZJ86CebyCIcU7AyQZ2u21qIv8TVqcYg2J4zgRlkmW/GLbzYRHJRbTo//LyZczGReOY9hW5TmLVLAYxt424WB5Wifhi8wI1y9bWfXFXAIRWJL2KxX/vPvLotFLf3AcSxGxHhilM8XQq1Ge+UWMohH+aYnP7jzh6YK94CHHYUTNNno0JMrYLisuQCUTTWCOT8mhEuUoDxSL0soAthgw2fFDRXa2gLhJshCVF+LG6/srROizSzYPQoKCEsiR4dOeieUBwdCzyrtdVPw7P7avy+W55gANitWr/NoPda6Gltq79Q9ZuUFoSuZ344NSMXJqDaUIW0CSe2lOk+UfVsaoqJ5DteisZOTxARIQIGjIS7lQJsOU7+0u+TVS2V37YEjans0ihiFQdMIPVbqwr2zhgbdgWYEzlE3ivTF5wmvbns47XxepdynUv3GMsDcimaCcbh+TVFh41toDfHQuClV3+mRg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3746fc85-a9bc-4813-fa5c-08db91b7c76e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:17:51.6796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdV40JEkXjWuwhsw8cNUIv5+VcM0fRWsMSCHHyji/8xWJ8DLbBDAQ3dkpRzowpF81GSLFWiExXhlIKtEonQ9hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_04,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310101
X-Proofpoint-ORIG-GUID: Soj5OrVxnRSzf1gO7Cz6MJB3As-ymaU2
X-Proofpoint-GUID: Soj5OrVxnRSzf1gO7Cz6MJB3As-ymaU2
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_validate_super() should verify the fsid in the provided
superblock argument. Because, all its callers expects it to do that.

Such as in the following stack:

   write_all_supers()
       sb = fs_info->super_for_commit;
       btrfs_validate_write_super(.., sb)
         btrfs_validate_super(.., sb, ..)

   scrub_one_super()
	btrfs_validate_super(.., sb, ..)

And
   check_dev_super()
	btrfs_validate_super(.., sb, ..)

However, it currently verifies the fs_info::super_copy::fsid instead,
which does not help.

Fix this using the correct fsid in the superblock argument.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b4495d4c1533..f2279eb93370 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2373,11 +2373,10 @@ int btrfs_validate_super(struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 
-	if (memcmp(fs_info->fs_devices->fsid, fs_info->super_copy->fsid,
-		   BTRFS_FSID_SIZE)) {
+	if (memcmp(fs_info->fs_devices->fsid, sb->fsid, BTRFS_FSID_SIZE)) {
 		btrfs_err(fs_info,
 		"superblock fsid doesn't match fsid of fs_devices: %pU != %pU",
-			fs_info->super_copy->fsid, fs_info->fs_devices->fsid);
+			  sb->fsid, fs_info->fs_devices->fsid);
 		ret = -EINVAL;
 	}
 
-- 
2.39.2

