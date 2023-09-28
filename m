Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96947B103E
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 03:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjI1BKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 21:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjI1BKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 21:10:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF466F5
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 18:10:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL7Te9005192
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 01:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=KRf5hpNvdaajxxUYBoFflzPbotdFJLhW4BCTcFz9ESw=;
 b=MjJ/1Y6l/3zg2fMmLyCmWtlgdCsCn54rEaMCYt+rJCodPVxS/2rwl473Hsl0JQWOr6qJ
 0iOYZuw6ip3e3zk6K2ypBzewPiQt1oyYpZcLgAZCYWPUiYGOJBVDDzB8Tz/kRRd/h1J1
 +pkZa5dl6MoWgw6r72yfwRn6wXmX61OQe2LF2U9p4KfRsMiq3ZG9JU5n3d2BXeNf1Nsv
 /dzS9pSxhV93zuPz2HS0RrnTvuNB3MfRnOnbtxt/jv1TFJTnlRPYVLAg307bZx2GaR6r
 Yd9V6RNzMwQmrnDmQBD5s0BjfRyu3tjkPDGr4SaguWdsKJP+zSG9aDt62Ioy0GyrXdYn Cw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2b2j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 01:10:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38S0EluP017941
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 01:10:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfet5fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 01:10:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTNnIuS064Hh2S4GzavwI0t20w6PvP0MDsQBmtJxX3eImPMOJcPUd312J0MWCQYgAKIUy32LAAbEI40fEJ7GL62nqG1uBzwC4IFAaWalF3tZtFJwRLUiu3CjvBDcQDkMKM37cmCAWpnoc7p2hHaGz3ptPQfJjzo/xpie4do2i7clE0of+Q9Wi/fq6C0BrkFU1pxHpoaFv29kxuGcNUT6jTlOtYsqbdm61v3geQSouesZ+8Cxmj5/4iK5+3TFnhwJbX6RrrofFxxUl4IpfrAYcTDcxhjLle7JWl1ov3TGVY6VrC370Tl28amsejbAs4dNqySc3I76q8w9LNZ493A5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRf5hpNvdaajxxUYBoFflzPbotdFJLhW4BCTcFz9ESw=;
 b=VhjtI+ml67ZCjWMdODxrxoEws9uXeosg/cvPC2z1/+rP4mn3LwiGixNxggLfO46ktwI/n/7LJ18PTWf5UgFfEanAbPHRm5VR083MxPhhU5GzGWUg5P5hiSYQUyGxj3zxuIUtbw9ITKpOUfPYCHdl8P5fSW4ZWZdKBoRCB2y2qTf0oyM5Elkya+mUYysVs2zdU6+HvoTcYv9amLjNNfrlrAmCnhmvvs3bEK5yoTOriveF0pyXi/KDQ70nLE/LcnlcF0nbs6Dv89MRiID+qaDcc2xApQsDSdUzF6KstV5MpTl8yVhMGLloN3wtsozi/lEeMJY/rEoqYyOBXrI2qYJTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRf5hpNvdaajxxUYBoFflzPbotdFJLhW4BCTcFz9ESw=;
 b=nNlVoKTrR4RM9oXfY7jRIjJb0JT905TjwFeyv9duoI5T050ryQZBvZE/JIiejlv5i/Ccv/4ckex+DlXl1PE0IlUHrz2cyl9f+RwoqrRyLIeTWxSqeSrICzN+7BzrEez50AYGF+RX9G1n4Yh+Qu4cW8ZIUClSvGGzTzlQ7I1zxC0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4996.namprd10.prod.outlook.com (2603:10b6:208:30c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 01:10:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 01:10:14 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/2] btrfs: add helper function find_fsid_by_disk
Date:   Thu, 28 Sep 2023 09:09:46 +0800
Message-Id: <46a185408cb2307eb1f94250533c7d10a3a9d62a.1695826320.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1695826320.git.anand.jain@oracle.com>
References: <cover.1695826320.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c9c033-af3d-46a7-227e-08dbbfbfabae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BuBIThRnNH52bAKIq+zkQpKRZ0l63/FvZw7uQ0q7nz1mPs+NhVZiUhuxYT4fn9YqwMFRJE/mV64LqYgId1/wrsk4U9cZQn/ebl7CvuPVjxNs8nmwqYa/RJD20XCMI64LSWTstW1cZN9LmWVxlMHZdRjRSbSO0Fe3NzI5hWp3urhMu647MwTd+7rhglWRnRXP603+XoqUZqyiY0Dn1geWn+KpeWbYfS8z1CvdEcpIWKjYp6mgyB7XKQYaEtno/EDtDTY2JezjNfC48+3K4vBdA9GZSE9l7uXoP9CfMD1G5s06aM83PyzzZwRSkq+yoj9l7Pjaz/Syz220IfNCsVYk2v7goZWJks4b6BOwfPQNEVtj4hHyYXC4LDMI3JwKGYvOPlUfWlz9UpEMdWJklh+u1wD2kBfatZXSace9EbwsHlyCgJY+51D7UpcnlInw3Skm8dZwjoD0ZXaQtI0SQFWtV7+VzfKQhuw6gNu9f4ei4eM1mYypJ5x/uMatSrbs3w5Np9WbHRokIr6vapN24Zw4bWOXDcbA42iNnU4iEov56npv20osCpRJ2t/ox/JIfUT4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6486002)(2616005)(83380400001)(478600001)(6512007)(6666004)(26005)(107886003)(2906002)(44832011)(6916009)(5660300002)(66946007)(66476007)(41300700001)(66556008)(4326008)(316002)(8676002)(8936002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1yejL2hYIx+wRn73Rby1zkmTl9fPMXRgOtlmubRzOKz1ccjHqR3QZeYMTLCU?=
 =?us-ascii?Q?o9JLnrgBvAdxmhb2PudlY5SZPJX25NV/o/QEsDovQe/WqdvS1ci9pFnsLBcP?=
 =?us-ascii?Q?Y847obspkf4s8BufjEVIjOudKXDlthbQrHSDTvKep0kT9DQMAwIZ9a/oo0GO?=
 =?us-ascii?Q?q+nF9OXpZdxmiyKzCmDAMZB0vCQPlWY51LnDfKxYEJK2CCKAgVdc80/68AYT?=
 =?us-ascii?Q?Q/a78WMpi0LAqGPhl/DBqwg6KnCWe78a4tjzK1NHZHDY3MfyCOELs6QxqU7Z?=
 =?us-ascii?Q?aQ0spkHWbN0gXlHxtE14ORxAqNGl1uEn4DWP6Je5s1FRc/Jo6WuMQkUz1nL4?=
 =?us-ascii?Q?RKz4FIgCt2KT8AcQxxynMUPyCefo09Vv1jYNm+LGqI5CxTownbtL+hWg7gqy?=
 =?us-ascii?Q?YDLvy0SisMP2txJPipQecLoKMBpbN881fMPOkjlytJR1O3IqBWkocxIR7Km+?=
 =?us-ascii?Q?9Lojc5Kk59C1a1OkcAFFCF8cae52TJuwzuqcvqjQkZ3UNKIbAIMFUYS1Hfp9?=
 =?us-ascii?Q?85NQM9LWxXz6oYzCojhCSfZeCOihW5X4q2Nkg30Ne5uyeRKM77FWnzBt4lHF?=
 =?us-ascii?Q?olM9+8u3nyiqyhxWQ1dXKReyfxNyDnkReoTaCmWU47FVILjNfSdRTdLNf1+8?=
 =?us-ascii?Q?0Pd/FP2fDY8yTpB7IVZspw1MycGKH0rbQeVaGVpwiKAyXnvo7q24co25jH8U?=
 =?us-ascii?Q?G5NgSDyGq28GLh1mm9BN9brZvYtr1Jpu9qOB8YGYsIrl/tS45XIt1j6+5R4Y?=
 =?us-ascii?Q?KBQ1c1mJNGFffNHGDCTzouKp4EEiTZVvE83zW1Cz84CmEmQhQszAoh3sL05X?=
 =?us-ascii?Q?I5vr+Qpu3Sjg6yv4tblIbeNTerNRFnYptOvUAQXUVU+Ti0ihs+vqL2V3a44z?=
 =?us-ascii?Q?N8TxdYSL18mPiDQiXJ763xAdo5OtvVoEa3YBBht9WUNKA6sHu4BF4t+6xKA8?=
 =?us-ascii?Q?Q/bHBfdW6ShUwkZKsHsEnFXUx4ewpXlKJtofMs5aNPe7IRCe+kz6OsTXPOtX?=
 =?us-ascii?Q?pccSeW8k8gKk/KCCiQxKrGS+oRPbF3/IqDOPPy3vG5tRlwbHid6bK5dVZDad?=
 =?us-ascii?Q?sVDNiuzEWLhPbbd9k2rg0Ha581nSiyJnVsUIbScRFORFG6xlu7JZhfyFAUhU?=
 =?us-ascii?Q?T5lAP5cRsg0LvAHpeJCIUXi1RPEOk5bogd4H845VvWV0DEG4XJuvXVJgrp3i?=
 =?us-ascii?Q?WVsjq/EAU1ld3CQUkeEnLLrSQFiZhIanJsnI+BuJ3wGkWozNR4KfHac90k67?=
 =?us-ascii?Q?Vc301KxxUtM6U5ID0UlDOySO4tqMXwvgk3CfrQ52+J/LgtDSynIR8xhxCcgO?=
 =?us-ascii?Q?9B347Y39m+p+/9fJJYLo8fnSoYUPDapTLw6q5neuIYMcYpCZS8/SSTRaIq5W?=
 =?us-ascii?Q?J6HQkj79C3J3h1r+oz8tMyq8rqmXN3TuO+3KI5F0Bwur2KM0kVZizf6gbnbm?=
 =?us-ascii?Q?HNjMQfO8Rsw/ERCPJIjSUvogb18strBbEi6v9J8EfcDRyotaTKPnmJ13xH/8?=
 =?us-ascii?Q?aZSGiyhkuXBW5Yjx2SuMVhyNAepFDmeQAeBjmrg4dBZ+QozDdnjZGRr+YJlp?=
 =?us-ascii?Q?4H+51w9jRK1AcvjL5n5l2tfxLZP37PHAK431kLddkO2CoHfjftCrOkLBsHWO?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lESMnuDvt+raCKt5DWHKQcHK8vGLVOOjhQd9R1iCN90vOzQKhb5ir5E4+29oXZ1KeUkFk4pmZ3PQoYxWj6YxKpHTa+4CMjASws6SyYO7THoSwUjS35XSw9rHpu+BtVA4toS8kiVxezdWNOWwoNzHX/SuNiqigELd7E4JQSNqez0PEJexG/h9p9lvsVZCTAFUDIUvshqdDpXMhsq2kgqIA8EwYh7op5o9tf9X1IomoNBPxOhMbWTwyvWwVoL9mFkTLuWTvZ8k4oB0USvxpuwW21ZpWKyqN41bwoW5bj17seYNZlXx669FVBrkcCBVICWBXEDt0x8PP5XGKsRjVR9nns8szTT1y5A8tkwOuISLJmXN6v7TV3S2pi051Kwb9sy3gNVc4x0dLaHPd+rnbkPPstNTlWmE4zJZHFLsNgkmOk13apsdOdjK8ToURs5mf9SeikgCkbIjnshVW0E3tq3xpdFCF0wr0nryeDCBJW8x0Xvy5PqCc4s1jU8U8SDkvB0kSAB8yM0HcpHP/Dg3D295eoFQuBly8rVUNYpFr0ol20KhLErpQyLHEfLFKYy/FPLmRf+juTKz9bjMtqSyVqQYlJW2AYnrqStHvPVdpif5kUQy4JGrmCA0x7tKldWn/SO+G9BBIfSZZIjrEakE8p6epFcczhpRemyxa+5mQq0D/UBXYstwxIicF+ofyTvSIriy4wkstcCShwWkhM2els+0q5J3/mvhE00jsaeAhupP0HBvMMsYpst+76Y2JVdI1pFqMY0FFaHTQs1zVwGavGQZbw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c9c033-af3d-46a7-227e-08dbbfbfabae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 01:10:14.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wqeb+ufYgt5EgxiICdEQjYE56hXVoNR38i36j+8+3E6mtNMJVFH05YQVOLxyAYhfhjhw/CfDun1SMSmhrSADqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280008
X-Proofpoint-ORIG-GUID: LJ5Fd_MirbwSxyPXhH5z7xC5KBBa2EOG
X-Proofpoint-GUID: LJ5Fd_MirbwSxyPXhH5z7xC5KBBa2EOG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation for adding support to mount multiple single-disk
btrfs filesystems with the same FSID, wrap find_fsid() into
find_fsid_by_disk().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 298e5885ed06..39b5bc2521fb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -553,6 +553,20 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 	return ret;
 }
 
+static struct btrfs_fs_devices *find_fsid_by_disk(
+					struct btrfs_super_block *disk_super)
+{
+	struct btrfs_fs_devices *fsid_fs_devices;
+	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
+					BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+
+	/* Find the fs_device by the usual method if found use it */
+	fsid_fs_devices = find_fsid(disk_super->fsid, has_metadata_uuid ?
+					disk_super->metadata_uuid : NULL);
+
+	return fsid_fs_devices;
+}
+
 /*
  * This is only used on mount, and we are protected from competing things
  * messing with our fs_devices by the uuid_mutex, thus we do not need the
@@ -673,10 +687,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		return ERR_PTR(error);
 	}
 
-	if (has_metadata_uuid)
-		fs_devices = find_fsid(disk_super->fsid, disk_super->metadata_uuid);
-	else
-		fs_devices = find_fsid(disk_super->fsid, NULL);
+	fs_devices = find_fsid_by_disk(disk_super);
 
 	if (!fs_devices) {
 		fs_devices = alloc_fs_devices(disk_super->fsid);
-- 
2.38.1

