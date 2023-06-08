Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280127276FD
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 08:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjFHGB6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 02:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjFHGB4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 02:01:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCEB1707
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 23:01:54 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357LSOZg017767
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=VwQv9vIP1P5sPNfaf8zp88U0HVgV9WMGN74+usTVadk=;
 b=1EoU1L6VUqHDJxpFvXoKet4d9KdqAzRunGQ/oClkJ0G13hN/NtX+A2849OQMb8UY+AGJ
 RW/dlIXpoShDTwPyf9zVc/zmtskrr+9h59szotcU/cx1drbgIKksICuyEWokGb1dkFEi
 PrZMZ7TfWIMzJIN+84+2iMF9WZhbSNKutiHzz8FZ7DEKZ540p0lEugmH30RJzJEuh4Ki
 dUB64aqhyZ8SNeff2NKS4C/A1rhho1p5ROUssNFd9oyMpQ6/O98bfXk3MdNUxUIx27gX
 vrboHb2/jCDX1ym0RLv601DZRru/Wk9T5FLI3rzYvv4FRv0ZkUF3hgx76d+D4dVkYenE Zw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6pkfqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3585dXW0015980
        for <linux-btrfs@vger.kernel.org>; Thu, 8 Jun 2023 06:01:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6mp2qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 06:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWiU59QfPY7gqNv6Ar22sN9XqIU66cWEtKTKu8xie+L5FXBVAkKsLSQVpuutzJl1PRtrwrW0Tu0r7PaRc7owlcHjQEqGKupWbxfCn3ApO9h2aeHH5/E8YHuYx8EXPunflZXJWvxI8nyImJ/85cYEvwn75z6sEegGADZte1zxxBM+M5WXLMh6+LMCo4b/K3npvNHeYfjA+8ea0mGqb9iPAFN/whea0nxN/wr+VxNl1leJmpelrHS2AnevQQpTtz37F+WDkovzQZ9kZJpWWzGMgKiH+3LlH95qJYO8SNhqBhCbhAYHFk6I6KLBPkFWUu2o6wS1kK89FRKm3DS93KaWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VwQv9vIP1P5sPNfaf8zp88U0HVgV9WMGN74+usTVadk=;
 b=ZgZpz0xqFIKqQIN2XLDUlgEcKNNXuUki1KHhePeuDnjxod6HVlL+N7W2d25e7sCujvw/yaTdnfxFnFoespDoCF9yQxAiRbov9Xlan3pi+DMbc7y2S6Lh3GKvpXNmbTqO0p0zYz4iUku5gTkyfIS8swb+1wqLNPTggDOdRziGz8M+APXc5hkviy8V5Th+8T2EZjNHYQlZdWbfBlb/CsapFXgWOZ0QEGl0EuMpUyI0C7NjZLCdhzqvcnZ5pdvgkcbTkTwp+n4VNi25frIk23fkn47WtYXFcqU1cO/SkrGTjp558kDLwFx0pTbkDS4CsdepSHUM1k2VIhk3mFAUk0mkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwQv9vIP1P5sPNfaf8zp88U0HVgV9WMGN74+usTVadk=;
 b=VvQavOpysPFpH245pFNO38zAWq4awRAQooWrgdxckkvqrp68fOA8YgoXvqRS2aG6EK1duRHSDzVl8LvYUTh6zmBqv2sQlXQFi9WlhXPajuir3YevKkJcnFixcsaMVFEBChFY1diipQGP+P510PqpH4OG92XUzeH6ABUHQxaFx9g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6181.namprd10.prod.outlook.com (2603:10b6:8:88::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 06:01:50 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 06:01:50 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 4/7] btrfs-progs: device_list_add: optimize arguments drop devid
Date:   Thu,  8 Jun 2023 14:01:01 +0800
Message-Id: <6b296396c512a2dd7cb024575a35a6e0c1132a14.1686202417.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686202417.git.anand.jain@oracle.com>
References: <cover.1686202417.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:196::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 91b8e4e0-900a-4db4-9cb6-08db67e5d9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BxH1U2IYEB45eBAvUzNpulcE0IfTk62ntzgYqryEKWx0qKD/IjQD0I5tZC9AC4nmXRCW0l5QvaCXKeUAp8iay36BOtrf0zLdzwnXzDTPA9HaW6cEXJKYBI62AFCc2iye5CydOEOGT4IUyFtYKMyfwYao1b10h65NoUaRnN394v2spuyRc1AMGW3xE/D7xwXGmLIJa9D8f3K4L5Fj24ZrqAEOdLr7diCq1TbOkitCgIBN07JnCc0GdOUbSl474+m4x12Aq6oY3vIpIrcqqkfEnVdhfa2O+CAMUvpv3AXzuX0jlhFkO1zmHx4S2igOwGrFeNyusplHkQ2DUbkw/ncskIxi3hhFW0wsW/WNpMB5Ntmh55/3A9uoekn1a9IcQTcBGTV+mHV1FChQXKXEZFRP5menIVtfAkgh3AjZVspVtbUyxcTd29vElYOHmvYR+9JcN1J08fzvqnDzToTCyHjA4O+3s5HlKpDkpcrHDixeENUsB5ydts6gEo94cJKEf6Ht+AULH1WoBwBiu5/d1UwtaIA30TwlmpBH4ZhGIdazJcU7WwAQs5g4v9ZhZVxyxw4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(8676002)(8936002)(107886003)(478600001)(41300700001)(316002)(5660300002)(6666004)(6486002)(26005)(6916009)(44832011)(186003)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(83380400001)(2616005)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2YBnxbN+yP4DDu3GATCTWsUIbhm91NDhh4E3sm5ZnBBN8F2jn9LOUi98WoNQ?=
 =?us-ascii?Q?kfoBUj2cq6YrjPAtOpSJXCeAdTqb2AFSZl2wG8TSYLxK/ILTNg85RWmySA2w?=
 =?us-ascii?Q?wvDP8eDr6ah7XorpW3HF6/q65POzEb/ZGWO0uVhpFYPDfI027DV5XLkmXTLY?=
 =?us-ascii?Q?8M1rMrOijtSEwCtd2ouG0QCKpSYwfZPJU7/s4utOxdOhd9cjY8w7+WQwT5JD?=
 =?us-ascii?Q?YXqQ0I5tfTu67xyZwARG1BeD6Yupf7OgT18V+/6sBTwQdmZexMUGp1RIftvC?=
 =?us-ascii?Q?IKnoz3ymqBlM1NPCZb5/cfbqUgFvvW7pSg9cUipZYRFprSL6TOQJDcd31QVj?=
 =?us-ascii?Q?a+YuAW71DrR0CWENB8KbwuUykC+Y1Hnq/zn4o3YRl4x4ABYey6soiJPvawCD?=
 =?us-ascii?Q?cXrzeZZTqklKLv2O8/uI7mb/Q0CUnFcTh/n+WzjU3igsBzHtbZhKP7x2Qzw2?=
 =?us-ascii?Q?urzp3GUj35H9ER0whg4bOsFIz6eR7cZzTAoZptt8ucInYwUoi3myU5TAlaB/?=
 =?us-ascii?Q?ljNFlhCzUu0LeEB+G6cJNCkJhRytpbKXFjCNJu6oziAQqmgkKqt7lODqQxu7?=
 =?us-ascii?Q?jMUTiBZH1uis7DN5yHODymFPuANNstjvf2Z7GuUz5QW3M8G8ScU/Xj9cr5NO?=
 =?us-ascii?Q?9Tk8TEvM2R5cyqCQ2OMmZSqwzmtPUfg1g/srQRipePtX1bvG90UJeXDfrORx?=
 =?us-ascii?Q?XwAN+VmiLghBl6lsRwDqEwzKOU5gYhJa2yTN+TAUkk/YUUT5+tW0nrMMLb1/?=
 =?us-ascii?Q?pqM+4R9RCqvyZ9FC2uzzr76eHam7Zr15MKkZlF3KBEyCEBeImNxR0jeDGT4d?=
 =?us-ascii?Q?ZVkCfdtBCAXiHS3PL4g/wiaP0Yp4KNwaWyUwIMf2Cuv6Iv5h7UrnlhNdaWDU?=
 =?us-ascii?Q?pFMTvtpz8LDw8Dapvba97ioN0Ay3lwoOgD4O5hiEsfApTqXt1VatqpOzQlgF?=
 =?us-ascii?Q?+fXaakwzv7Qvyt3JDRbHohNoutvzaGmaZS9iYhOoDuZDNQ12pjTs60PpHlgB?=
 =?us-ascii?Q?RC1/cOf6bvzK6H/iX7KKjii4VInLNotajst/eRLLBPdWL3mKODyls3YQ0JY3?=
 =?us-ascii?Q?f3zry7hubaZNjH3XGyp7sZeR8gvqQaQxaNCCwpZtivWahxwfQHNAjbrrKE/4?=
 =?us-ascii?Q?B61vlQnSOPypVWRG/7s/hvjRioTY1WpzfiFRIZvDdOmEl3L7mJ7lpWK8PgBu?=
 =?us-ascii?Q?wCW6YDHkNbXnhr09z4o70Ai10JpYGaEOo9IgPz8uoJEUn8JXpXfaZfPASVjl?=
 =?us-ascii?Q?ZmtycZxtMAE3ewEuzitcgTCHQ1IdEE/S7Om2PKy9gdHdtgp9hB9P0IwqjOU1?=
 =?us-ascii?Q?M6AYFfiuX4HyCSl6s0lUe3WziGcZD/3kW01MCmC0q47saEPREWYO4pWTWXxt?=
 =?us-ascii?Q?PL9L1kD7or7LmGp78RdSC/gPZvvShH3951kqLDNv5KNggaJm0029ld9uLkex?=
 =?us-ascii?Q?McuD4V4bJBtmmvijlMvWdFKCFl29SdYf7dD/fEZErkNPqeGg1z7nGCpBLGD5?=
 =?us-ascii?Q?LJqXiHqH4wuFTXj3PGI6UjkcY01HJwi1bdI6JtBXnE0SqtB6MkBBjsnjU7i/?=
 =?us-ascii?Q?XpTr1yTCPCelWIiJPMpmY14rrs+EHwBFusf/lyWYmP3q9GuzmSckwblzQ90+?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Krh5WVtrbvguhKhPfzlsSPthlTPI4Dzgx4VkamCMoHos05k/X7WmSzXox1nxbRScsxnDiC+TQDGRfOgYylpUcGAh/MLobBhBDPyWWWVBp2/ft3ClwkqQbr5wOuqwwpZpV/WVx1rmTwxLwFNsPaMlUfyo7ukxgt8fDurKrFPAeOgMvhVdHzAahTiLmgBE/JWN70xEp+ocBlqgCaUebVJGn7jHe7qaG2ZsnYUerNhr3zKtV5h1M1JDFqI0m3XAhc2EMQaANbDN+OvPgiSNFfhiYLyPc26C0Rqok46gpmExH0SvvitQ5bx21Gy4lW97u2FSL0FeJisXVP1dFA6gHTXu+QJAGBxZACghsWLzPX1v2nSRYfR6JsRm4dFq52CZywOMz0jl5h5fS/pL5ayh37bK2fmHvldj/fsjbFsQizsBU3yzJ68Eo+o8XnKa0bRLFpqWXEHQwd1MEARcwoUQZrx7HjTPwayIWQiZAKrmteOYygGTxUQKC3jN/+kJLKdoI/iQgZbLj3d75TnZGELFQwnUnoLxBmG4jYsICGxTGi6twDplQYl3g/cSBlNe19HOgrryAsc3XyKMRxWKU8ZYAlm9PdHOD2ftJAcqj9qotkmWHBBzL6f2DlSHM1BBBucTX0Pa7BrO1P8sOmpttQ5woAXUNCWS4ajy6BpbNPAOu2gKWkArgEQJ8nfhnPGqRc5zbtguRI/ACCPge5EWDirBkrFMVdH2Z0/k/8I7gF2uuiI0n785UI3hP0OCDr/8ZXCfXAT9
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b8e4e0-900a-4db4-9cb6-08db67e5d9d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 06:01:50.4006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arB4RW56kgreJWl4X7AW+kHBjpZxqFY/f/Xybx5EgSTTj0bgFZvRaI6aKcvNMECZLSEtu425JgZ4ilY/NW6TVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_03,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080049
X-Proofpoint-ORIG-GUID: oVF9_MQlfKOnVxVM3jLok9TcQaXrt-nw
X-Proofpoint-GUID: oVF9_MQlfKOnVxVM3jLok9TcQaXrt-nw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Drop the devid argument; instead, it can be fetched from the disk_super
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
2.38.1

