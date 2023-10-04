Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F057B831D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbjJDPBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243038AbjJDPBJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 11:01:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76955CE
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 08:01:05 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948inCx030736;
        Wed, 4 Oct 2023 15:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=cekptlcR2GGDYaT0MclrZWe9imqnMJiCNeHTIDBiwtM=;
 b=BFZD+SEU27U550V69ORXJ13DOi6NuWRsmKn9OlunJj7m6DKkyrbX6O527PmcVkjvWQdY
 BpHH0FT4ri51J6N3A0IAmhmamlcnd8dtFdeEVEIIdFkc/BR5QzJijhJeBSM1lTBH03TY
 Lq12gP/pP5ZfKaN2b9PNq1D6OwTM18FvXoHhabCbaYxamiAePUgc6sb32TNw1fZIe167
 eG0OFGBOEmFL1rkHm3b0aeqx5uSlDfsT6tYuYY/3rLWExGpghd4y/2H48mO+7DX/zcjs
 RNqxfNI6HlRkPUyunFFWCgj7UAnsIut60BvqplBH4bdbn7pu6H1iebfxu692m57NtQhz AQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9ufbh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 15:00:54 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394DK6Zj008713;
        Wed, 4 Oct 2023 15:00:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea487hsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 15:00:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlE7Fg7rR5uKA3Mn6Hr8ItTDku/k71vMms4+imHISajYdKe47lCQujO1x90Y2gMKsuiSxNuheOFVzyovSStsGcKBYLyfI0TKE24beXkVMdbqLAc5M9t2w352TziTFl5Dh4y5aizpTpOtlXZk+5Xi5pz63NAn2WLd/nCoBBpt0LmeuXjr5JZvnwpveRU3l7+xbh7lbZZM9JtXzA1PtfQBXH2pRSVYbg13eMMNqKuZqhNce2FeoHrPuTvjVKvpticHBV41iUyzOZSJly4Q553+83feOOqIcaK36225igQJ7EOJRYlqquZrX9dqntXPRSrQvqpNK9CIhiJbNaU0kUQdJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cekptlcR2GGDYaT0MclrZWe9imqnMJiCNeHTIDBiwtM=;
 b=fwqCX7E2PaRkS/5e7ViH/LGDsXpug69B6coxTbyIC5rnZe/mbwJFxpKIjnci6xplyf8xtjchlOnki0kov49KJH3E7Zw86PsAmhKDtAaO2nBz6xBfVEFJoFS+jfAGSWTAPP1RKZsLBXEJ3YOg/QqobTU3OpcomtyMM4Fkxd1S5cKWxXBRqyfBJw6BNdhXOxUp95RQS5CFnaptHjuoMg0CHLhdaOvJ+srRoC4fyOcwoWVDXZ5W2xTmYnG7Ucgmy1k74rWlSUOsjdTdsPWHx2+ICbXvNVQWZC/XGDRvSGmBPHjns7BvuRmD2BmwJ1VjTUdEuE+rD0OzreJy+IOnBEreHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cekptlcR2GGDYaT0MclrZWe9imqnMJiCNeHTIDBiwtM=;
 b=e7mPu0opDq71U89b68OcPxED1KE0+L/t744SApb6CFp1zEHWw90dSz21/rd2kFPjgy5yi+NPFeWm9PBUIOGeOdPqHLa/J6UnnyY7jbyUmfbYbvdC1qfImUd1kidfwCKjtUoNhHEIiw4Ye1IrhtPozrMISnrUGGuS5Q4jxHqfp+w=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5818.namprd10.prod.outlook.com (2603:10b6:510:140::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 15:00:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Wed, 4 Oct 2023
 15:00:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, dsterba@suse.com,
        gpiccoli@igalia.com
Subject: [PATCH 2/4] btrfs: disable seed feature for temp-fsid
Date:   Wed,  4 Oct 2023 23:00:25 +0800
Message-Id: <f8739ead477d166217c62ac2096b6bdf3eece929.1696431315.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1696431315.git.anand.jain@oracle.com>
References: <cover.1696431315.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0169.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 43dacfc9-d729-4f3f-f305-08dbc4eab313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8emT+NmK4MkRsB4J07Bc4MRFy63/rZtALyZFC8aBgOkWnUmAde3SBEOGVbFoblXhwGTCSJX5lCAPOen14hq2l5eDc+ZhnXmpXTZlg3CP8NdWVq1oiARV3JTKG2rrpneI7RszqE7+d1EPDh7kNG97BTHctAxO66Edw2MzF4s9fu171gWN3ZP28yBAX+Kf5PYvGOh2Z7bAqk/w5Rzuc+Mt2fwymeu3VN84GkMq6vaYQ6Ux7wCg16cpsPZFphyV8zMx0DTBlB2fxUHSZy/EtoHKjS7U/agCXgUHtdtDD+T7Q0sZeOVMzZfAZpOp1odHkA9IZLOLHfkAexPSPUE1Ez/aL47O+yTJF1rklY5KWQp9hFCMF9kSrgXBmU7gNQ0nvrYF5UH4HEFZlZlwcSmclwP3h8eoZxpJsYQiwzeP9BQ030LjYGmGDT1fNrp1UTmhOrvnVKEizPd5O63DAl7+H5LS5F3V0ZIBgrKlrL++aurrWTKKF/Uy2oAEHzMAcG3Cz+1yCjFTKgzJPYDGhx20Jt4lBS8ZaCWThvwaRD+WtV/QOATyjRPMTCLp8/X6Td17Ka0c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(2616005)(6486002)(6512007)(6666004)(8676002)(4326008)(2906002)(4744005)(66556008)(26005)(66946007)(6916009)(44832011)(5660300002)(8936002)(316002)(41300700001)(66476007)(478600001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kuWT159A1FXYU27MfH5ya2W8LTEPWzgOFEK+VG80nNzqTNKlxBD91aXzvuXs?=
 =?us-ascii?Q?kJ9a8cd4LyHsynZCFWSMHr31HQVi0JX8jKMydwDAQfZ8uawqlR8VSnGcjikT?=
 =?us-ascii?Q?QRMgpf4YHJm0+1YjSjmMBUmMT99bixSwKTuqgI8k8bb7XQ6VAO6e+2DPxib+?=
 =?us-ascii?Q?eUTq5I9iVi2AkHMPfZZOngop8rJd6n4dmK1Ii9vE7crx9uXGQn2lOaJR7eiR?=
 =?us-ascii?Q?DwJh5R71yVew6MXY7mxdmaGA/4Ql5brdckfG0V04EiwZihcxgVyTkR4KDXQQ?=
 =?us-ascii?Q?77eZMbL4ToU1ioNJpnfzbmhhLDwyazIUXshNL0aChPGNd8qtr061ngboQzIq?=
 =?us-ascii?Q?gyCSuZZaIC573LoUx6/VIr87ys7fYrj/xlKTa3yePly1Ggxi0sU5zYSc1iFJ?=
 =?us-ascii?Q?Gyv4qI+Ug83J6wW3AtZ3Gao6K1f7mQe0B4pGl/7koTAB4zETp98o2pyeHsZ1?=
 =?us-ascii?Q?PBwPyLCXZWvgCL7jBBn0IEwbtpbxgP3o+NVhaThSSMdj9JQR/E/4nEV3tWeE?=
 =?us-ascii?Q?4X66TAjsoDn5igN1giTwJV3iShYzc+ynLItUXZNAqKptUMAT+jj/VueHhUC9?=
 =?us-ascii?Q?hjlZPZ1+ON2E1HeV2vgeycfrqWXiwvJjPQhsvKZoTq++5Tmm2/T2ndLD4nR7?=
 =?us-ascii?Q?Biu5nsEgbyHFVMUfYMvqbK40Oct714z2L5hnFWbxW7mh3ueX2izHbRDRXgxa?=
 =?us-ascii?Q?Q84j11mXrowMiC7uRmbitvqVh79wfNj7Hp9Ijg7h7dNyYLhYZrqWeDr1nTNO?=
 =?us-ascii?Q?jMd+sVOXGKDHOjj6+WFWYxDvdnuMZhD754iTcUkifV0m+E5ySpDelfv8v5PR?=
 =?us-ascii?Q?zltrrDzG2uIWBKCXPUMb+VhguVIc08zI5oQQ32zbkotG9IvYbI0nHVbzHlPz?=
 =?us-ascii?Q?I880s5z2vgyqla8evu8VHqzdXQ7N7rI90PI2Sgt+xY4PUzU3BJylOxDBiNRK?=
 =?us-ascii?Q?VmWMv1zvnRKHYamhHpA14MRP/+4qPaMcy1g2aIx+kcuUzkoHw29VrDJheRD/?=
 =?us-ascii?Q?pGAVLHYzCQruMIHu9XhGuYlzkyFJna2tlx1egx8yXyO3vjjV1c8F1Wk+3eeL?=
 =?us-ascii?Q?t1wXP9VOMAQfJfFpxM9PPQfz4uBb54VsbYd+Gnh5FGueb0MhnOWnEFLUHSX7?=
 =?us-ascii?Q?1CRcDVNX+BxendJEXtYFicOCTvnAPM3LkOrw7UGZfbDJcRpafzQhtvr3GzlM?=
 =?us-ascii?Q?IiTgUyvjstCllTijW2bbxDJ54x7Fq32Lbaw5Bnbz16ZQ8infF2kv26ByanlP?=
 =?us-ascii?Q?dsMRGHHsDjwQzjaUB26JVgfWUkwNiewCAgG5xDujwIsIaaCVvTSVT5gu35Ng?=
 =?us-ascii?Q?EfTzzH8r7eijplk0cZyfcRN4uyQEOAWkvRcOJeJE9+Dhc3P4lCV8/7shsVW1?=
 =?us-ascii?Q?20vmSyJC6901+F+opkDdwDPACZ/yyccyX9gUN4+0rQQLYuR8s/2tIIM/a5e/?=
 =?us-ascii?Q?JGkkRvJjhTSahfxFB1+PKfMQrneaNvSENznhzfJ4B22Z91ta5LZVOlvFI9jn?=
 =?us-ascii?Q?2NnftqV5eTjfLiv2vFNCExPWGfPoOgzQXSun+Wj+AAa/O3eibNJPIwVR5Ohb?=
 =?us-ascii?Q?MToGUgVPxrDIIaoC48OhP9Wy0XsMZTbXWwvnC+azJHIJX3gqUkWvr9e+ZlGR?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 26nD6pGIA4dS5nBL9QTgCRWAJq+Y0SFSV64qBtbDvgWWTSigMGjwJzclzTv567hAwTKuVAQzqAVmbQWfLnygfUdc4Zm9Lszbwcg39FCWVUButMC/j+pOaQsdCYrpn8q8sQrbgfVYsbhyzQsC5+/uirw3FC4nNrrb8r3NC+2/H2Q9/H+TG1a7zfpT7HZpv+VVmfwLxUdgYv21Xaq5ycbZQbf1zPQD8GKmbcShzqEy4Zvdsubq3tHn3lcDodraSgz24OB+3r3UdtMsjOBLSZl0Dz2z1UqfNoOJ3cKLqfj4NZBwa7ZRlbNxps0Qjm+0Z/ar/DnBKy66pmladjCYoI2F0Ox0+FW9LmO7JyJ/EmHSfQ4MYNyN1rTOgZki4/I4PZff7u/u+GDJxcqArsGk1KGtiPEfsx2EtpWQew1kZvnwMG4mNA7JuL5WNKuXs+4jIKUlJ6Gq0lE+PLJoQHx7t3KiEDElsMgAOrqh0NxDvTQjFR0ZWrjEK+QncBjQLB39r8ydSp78nIcwzosd2QiAkCIJolj6mIlbdqsMmF7L1MeJrnOjHnH71wfHpaePmG9q7RlIbVFKhklia7M20PRSFCnBNqRrwsQsZMdb2h6elpPyCWeo+nW5H9M3CdgTE8PaX0B3t1zknGwtem9bSnFvTdRJpRK0ibE5lHFWQ5+dlpWq1hojfI4J+pIiezpNB0LLse+1ilN8hxrOEmr0ktwkagHdxrNUuPB+Zr8FFRqLqDyza54VxRPoMwWLH+YvJ5tz23TSYaOcouML1apZPZFDYCWl9FFjHCOzpStbTIZB0lkjrkvndqGCYrc56bQ3RVBlQur4
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43dacfc9-d729-4f3f-f305-08dbc4eab313
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:00:51.0509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkJp1vA4vtuFylvUhsvugiW8pFJJWGaF68qdvWYNhAN0yTq8yErJ729vPWMI1YgTLwL/xUdKTiJTp6bWHtNLIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5818
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040108
X-Proofpoint-ORIG-GUID: E0vFJpFoaCUi79fj-yZ_1zhojtG3SJYu
X-Proofpoint-GUID: E0vFJpFoaCUi79fj-yZ_1zhojtG3SJYu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A seed device is an integral component of the sprout device, which
functions as a multi-device filesystem. Therefore, temp-fsid feature
is not supported.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 81b735f4efc1..1fdfa9153e30 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -571,6 +571,14 @@ static struct btrfs_fs_devices *find_fsid_by_device(
 	if (btrfs_super_num_devices(disk_super) != 1)
 		return fsid_fs_devices;
 
+	/*
+	 * A seed device is an integral component of the sprout device, which
+	 * functions as a multi-device filesystem. So, temp-fsid feature is
+	 * not supported.
+	 */
+	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)
+		return fsid_fs_devices;
+
 	/* Try to find a fs_devices by matching devt. */
 	list_for_each_entry(devt_fs_devices, &fs_uuids, fs_list) {
 		struct btrfs_device *device;
-- 
2.38.1

