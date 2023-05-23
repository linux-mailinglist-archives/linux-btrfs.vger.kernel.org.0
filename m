Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262C970D9D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbjEWKEi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbjEWKEg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:04:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AED129
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:04:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EBYh032760
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=usOaIb/8khGQpw9p0brW5cE47hdw4XEC+Fis+aKvWys=;
 b=kLbXxvqR4DcJh601dC//xQBc3UxsFgy2VCFvFi8tfl96/Y1HDX5Xo0dA8tSSHOLGtspx
 UcL0+SL7J6yMVlZ4D5drIH1Fd6INJEuI3IUOSJXmFt1Jwm3EeOAaEilghNuiOJN8U4pu
 0R4mgv0IclrcJLuU7ZjnyZnw8S5/pkFr24ynseXtdlyYvUcgUambhNSzB0uwiv4bxBCL
 te2J0f9o2NQf/MAEaeYd871KJGhaizIv9cGovrdC+F11EKSo9AzS8WJXxTxli2xiyIlk
 ilB5DuNGWgHM5m+rk4Au8c+wEoOlFpRzzlCRDEud06qGgOyAU6C7C0+vbjb7pJGwRHkp Nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44mp76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N912np015800
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6j4023-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDVfxB+Rkto4x1XPbUzwbaTJBt2BocuGfzJUlgCsiE4K5LXGYp4qYsrL/F+Ystb/agp2cofStZVLzwoiJaNd+cmwOJsmVRcZVKiyYKqpdP+RwFKQhKgW7fXc+3PDE5mpj9F75liuaZ8UxqHnIPRTC7q1FpQnHGp1o5TTrRcGsQ7tPiE2CsTlR992rXJY9rIv5CZzhXocoaZiuUDN+Su+hzvxJ622DA0AiUcayka3VPDKT1r8kVtZVd6m4YfSWACh9hbFdUNmvAsS+cQsHKSwuu75P2UGySWv5rw0E+mc3gmGqew72eCGoRrVUlp9oYRpgK9hZOHAYQkvS26LJL+tcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usOaIb/8khGQpw9p0brW5cE47hdw4XEC+Fis+aKvWys=;
 b=UbvLAkcml5xyR6oULwSyeAyVVesYFVrAChMuvd2wWrSxr9c1pCYIZlSBxXpPSKNIHDB+VLjmMIKNC2jBmPfXJLXrekvfatzxbuEioBVZQLuhxL4jTqpy7pAHfBxKs2rVEX0JAjT18plFGqAekbJgER3uOzj0DI6TxTJZO2M4ZliFqApEfOy+zkXt0ufnEAmZK9LyIoPu17AcxSyvYVy2cDhS3h+XWurHG798jZAZpx4YJFSRtj0G17CTx2pV+fsqizeV1LLaKXkf4on+LXVsfjjFJP0xbQSu5zH7qaH988QK2ikDUwJVpsT/KexgMlrnYJPdsO60liK+cgV24KKRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usOaIb/8khGQpw9p0brW5cE47hdw4XEC+Fis+aKvWys=;
 b=NfRc16Xx+89fORu12SGFBNeY2ADQj2fuwvNie4Fl1iI7P9lH1efENV+MPjqyYZMNUtaiyd/cx1FxjJVstYpOHQ6eIXGzocnOJ9oU3lym5kxUA9TXhKtv+x3Ehye263Nvdkt4P8ywKaCcWZ3ZCFghtAFzXwoMmuXNjsYjAUDdLTk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:04:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:04:30 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 5/9] btrfs: simplify check_tree_block_fsid return arg to bool
Date:   Tue, 23 May 2023 18:03:19 +0800
Message-Id: <f7912bb8fb62787c9a02c56a959722840c33c3ad.1684826247.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684826246.git.anand.jain@oracle.com>
References: <cover.1684826246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 540f6714-b4c0-491b-06a8-08db5b7519ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1oOrq/eLSaKUQ6wRW5fIY57sZyZ8UTb25oTnBhaXf1hm4B/Qflzvrqa8cGqq6XtE96SYkImjrpRb7S/0/tcmnSIFYOkxZNWMA+1wTyioBAd1CvME8ihiUWoPV+MOwkB0v3no8OYuwzeIfXK3BkCMI6oNRkZYyBocLED5B2SYQW3n+oYaPJAPpsPy/xLenUaoQV43apKlwNAHv5F6IA2tkbW4gDSv+0Im4UNhUqVrf7/LjoRD+c/05oVn8IUdYGRnOa+0FMFJB1WTIsgVmSt2RO0dkXF/crsaz4IpfqERlDvwZGKxh2ymDQ2ui1tBmEkOY1a62kzlyfB+WtXUJpMFcavaJup9C+sIjHhx2ooVc4TIDWRV9Q/LLZ4PZVRvFvr+K3rb3CEmoUwcUfXxHzyRaBdefDzBfQxbktUcIw9fNl/MAdR2mH+0ASF1477kEnsT5IFcICbZAZmsgO50yQZp6iDucD9rDQbjJxXiK/MGScEJ602zNuazKNFg5EPJ/PbfUAZJ87nRnr5jbxnCV0lKdBfPNIBIZRNtPQuRzFSAQQ7zcafiMyeZ1VNIWqG9G7t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(478600001)(107886003)(6506007)(26005)(6512007)(316002)(6666004)(41300700001)(6486002)(66556008)(6916009)(4326008)(66476007)(66946007)(5660300002)(38100700002)(83380400001)(44832011)(86362001)(2616005)(8676002)(36756003)(2906002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B28+NDCOdTFhyb8dRK3ZTTiy1+5QsE97/uwH9jNf8IX2xzuOk2TL3aFK+UlH?=
 =?us-ascii?Q?NjlZ4BiCoMLccAsiL0XN0QzeportrJVKIKlqsg1bAWEhQG0Gc2h7yft2ODx3?=
 =?us-ascii?Q?j1ogpeXWioUzEkZhvSzQblMoHAvCXDwtkVqoY+ZW3ppkLInGU0oh25yo8CAs?=
 =?us-ascii?Q?Qq434o5lsTIT2xTntnwuO4NIoiSdNyAFXWIawa91UhaPLvbhxXnOqnhS2PUf?=
 =?us-ascii?Q?pbUauJzo8n1Ia12JT+nr67c5VkzI5xJcS54y4mfeRQxrBPualsqCVbhJj1iU?=
 =?us-ascii?Q?hz4BpNB5Y+BfEOsOdmMsr2d2vU4lKrgBchbGPc3DVZaQvhaEcHK2JQsOlpdM?=
 =?us-ascii?Q?6AKMPMgFOvohzCj9kRN96pLUgAN7k5AuyRbmtJJFCwImzJwKRJbmX+VNIEDf?=
 =?us-ascii?Q?3aWFA7Uvp994cgBWFM8nktYrCVx3Zph2uuoP3E6WkS76t3iZas6BwLhpfxLI?=
 =?us-ascii?Q?TyBE0OKaT+6HAIuxTmslk+msc1DBzS6GIcxNd8wglr12uzzJG9pouiTYIWZ3?=
 =?us-ascii?Q?WH/D3uCLEzGT4wwZrSw8yHHoQMAzpHu/IUxznQl+3aQu1DnJjQWXxMXFqzJx?=
 =?us-ascii?Q?E6oDlyLyPGonIHMUERAxzR2rkSp7jux+8oiaD6FVvOV9/xYwXFIQxu6CTBS7?=
 =?us-ascii?Q?ft0qIp4biWgDggF5r1acL6dJwoxv+mrrv5NchkZqnfPrGnKhX3tUd7EuiRZN?=
 =?us-ascii?Q?e2CF6Z0vnMEHsCfjBhudxP+99pw6vaxH7JYHAxj0s1fNDspODxXcK/r7Nv2J?=
 =?us-ascii?Q?KqUiRQBu19OGagPs0JyrC4/A5upd4BLkHeI0kXoj6+v98km6KrY8xLXimYZ3?=
 =?us-ascii?Q?2j++9E3OjMGdtuo8DLk1HCP9ZQIqfjECm2A7c08QJ+kF2CN4EyH3TB294Oi7?=
 =?us-ascii?Q?3CfpBdKmjwD8ffdpu2LN/xx5gpJIYqIizWFtY1tctVTsCPpofBKHJgcT95R+?=
 =?us-ascii?Q?AUQ96jVpPaFAEKAuYVeCvKoYRnlz5Y2W4Cc8I6Zmxyz71W2lm77wPnlLBeXm?=
 =?us-ascii?Q?pHUI6hIKYz6OwRTP8C9j4JinX2ym5LSStTiEcG6IrW3lqLTRzItwuep5Qenq?=
 =?us-ascii?Q?0Xjt/R8Jj57UkuQdWT3lRgMBBQHV7A4FPLrXFXwFkOwLlxqg0UcKtMjM5qeA?=
 =?us-ascii?Q?OmSGDT8XK53mODgkmYkwMuA/2pNpX/b0oLe+AZwNsuWnzpKdrtIPm/sCTBvQ?=
 =?us-ascii?Q?D6SiKAGa4nPi6gIzS7M7Nwj9GDjflOIG+VZANXuevITu4PPXDMtIuysU8x1/?=
 =?us-ascii?Q?OheiISvez5gUrbSSsjnQT95PW1xiCHQjP3X3ol+VG16xAXePoyR80NgFu8hO?=
 =?us-ascii?Q?EyWt2IbJgAQAQMeJR+lOp4LZLZIoL8WUJ8CoaToZmXgx6Rp7vx9o1Lxt4W85?=
 =?us-ascii?Q?mZkLeKz26MkQhC6j/PHc5XsQ4mgTQvxDDpq7YSOjYuKmz2/rO8NLyIHTKzWW?=
 =?us-ascii?Q?4GkN6TLEbSP6mYzfDF7d9d+3+MyPdiWJOr0LybETmfM8AVBvIo4opI8DEqX7?=
 =?us-ascii?Q?dzu2W0ZBZsHVqe/Hu4N6X9E0/lsw+4GAm2SfNPy2dypEy1zPu1gmwPS2Y/vE?=
 =?us-ascii?Q?3ymTQoKj2mduuM+lmnCrTQLZ9Uk8JBtQsHnAWXbc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GB2lwvuXDiW810rSuLE48u2PF9tb2PZ1DpSsBNjWHsNfRq/2daUhh3eB77lFTgfzaLyLm9xmo7rXq7xMrCW9o8m9ld9t6HybgQLoBTwbfpx1xkza8teeyJF3PNRGlFKdX590aeTEZ+1YrSTP6RiBv4OU2EGPxa2MTGkR/VqO5mc12EEz8obySOJ+P7kh+SaN0IBoHE7JFaOXpcRl1BF5rbyiFv5VsBWmP1LJ+MQJdZhXbQop/Dnu84P0a/SGR3uwKaepDj77Q7PFAS6HE05R+Hb2etgk8vAM/XosdOBkGFG6iPMWVGRF9Sm+shPXA/sw4Ka/5gPp+MujeWM8hrrSQxb0afA8wJQN0yJ5wSOWTHs4E0kUMtdShLJRXbiyVq9K3kcGk00vMGx51NIBb9ifJG6CSo48K2UTXTe7QZA2xngNyBwTVQZVQOSDjucTh4eNhBOq5R03Gdo6C4gchHB/kYHPphWVlCXCTHnUSzSbSXU69I3wXJM+FP9syYvfnC9t6m4BBrLn8Yp6PhHDHDPmhEweKjfBR1mvO9Dv/A7Xw7tFC8Skzan474gJgrUxG7ZK8xBfYSLCLzTMDUEVqBd1eXvh+1Fchus5KpFx792uOJJom9hBLYXXMlaboHei0VcoOE+JnwkYFwuNd6x75tbD32Exe2H8tG+FWLGzC3VZ0UuXsDKfOPza3owt3xej4M1HLnmu8wn+gbgYqzN0EMj5YxKvyXZIVBXx3qUAMVQ7syEgrVtvODJlHaczNFs+E7M8dArdiFyyitMKA3qUsQqZlA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540f6714-b4c0-491b-06a8-08db5b7519ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:04:30.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTcClTqjVGOtxCI+p3jOBsm4ELPEhYZbnDczwMtSnJH0MK9KFcTA651JzWe/gSvH/Mz9gyvNGPavHdD8k1gCew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-GUID: yAM6v1wkx8GExnLChMDhWRiCQxJc4hFs
X-Proofpoint-ORIG-GUID: yAM6v1wkx8GExnLChMDhWRiCQxJc4hFs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplify the return type of the static function check_tree_block_fsid()
from int (1 or 0) to bool. Its only user is interested in knowing the
success or failure.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dc2ad0bf88f8..5a3e92fedcde 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -396,7 +396,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	return errno_to_blk_status(ret);
 }
 
-static int check_tree_block_fsid(struct extent_buffer *eb)
+static bool check_tree_block_fsid(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices, *seed_devs;
@@ -416,13 +416,13 @@ static int check_tree_block_fsid(struct extent_buffer *eb)
 		metadata_uuid = fs_devices->fsid;
 
 	if (!memcmp(fsid, metadata_uuid, BTRFS_FSID_SIZE))
-		return 0;
+		return false;
 
 	list_for_each_entry(seed_devs, &fs_devices->seed_list, seed_list)
 		if (!memcmp(fsid, seed_devs->fsid, BTRFS_FSID_SIZE))
-			return 0;
+			return false;
 
-	return 1;
+	return true;
 }
 
 /* Do basic extent buffer checks at read time */
-- 
2.39.2

