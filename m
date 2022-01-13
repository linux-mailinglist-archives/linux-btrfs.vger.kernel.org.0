Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB46848D32F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jan 2022 08:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiAMHtO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jan 2022 02:49:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26166 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232100AbiAMHtM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jan 2022 02:49:12 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20D0YPFt011805;
        Thu, 13 Jan 2022 07:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dZl9q5OVcs/iEnwb47Dm3s+auy7hWNWCOocp8bfOVGU=;
 b=avuI2u0WsJdovChkwk1dH/aQYZ20PSm58qVtGXKZ4I3ajmFSIRVco1fg0All9Dx6qPW7
 4WLmkhKyoYqD9jIXziJFdNDSWJbRys9j/+bDo2lO6yzVSCwbLgtsOqliuc980A3FCKzK
 O3Pcc1S230mmei7DajhOMCE/HqjWRPgNGVjcHUiOqx7xL+ufx1nuFQdZ8OIUNuqEv6Z3
 rxv5Oz2TGttHQHbJa8Kk1IgsdiTsiarg0o87GhD5uWDBq8dvkiAAL39iob8IZOpiB49L
 3rtcs+THKl7U2If75KCNEwNqyi0vhzVp/5Qf2t1GNHAtaYvKEtxdzeYWjTBypKgCRFAC KQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgn74g8v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 07:49:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20D7kY5R132185;
        Thu, 13 Jan 2022 07:49:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 3df0ngpkm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 07:49:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKDpmcONQ4B/wkfSbE5dxsJxfsVM0cbTO0g/rgIL+yHpJdx6RxUV3IEQTPSfWLHgF1yZtcihp6pj7HpvIY1O/ipjp/v1snwdGVLlgSvLECOvee3F3XkLN/fOXfBRyBIsmgs+OBxl0QYoW59RBzBOyUm2Xpf3ALNSGCKm/x1/N+fuxQsFgoXL/k/UjZA3LfebN8ixuoe6QRfQuhZukdcwZGJ+d8Nw/mS0v9dyj16gNcWZVwOwsALhInyr85M/cQmrHE9oCb1Jv7Ert/GrZmgIJ+y86r/vD00bP7OqgPXDWvOSHFtSEvEE3WeWEEwjVPvlFC+pt4NXQDerLv10XlMnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZl9q5OVcs/iEnwb47Dm3s+auy7hWNWCOocp8bfOVGU=;
 b=jGSPRZg9l88RWD0VVLdB7ahKXzIi51yV1TNTplFosuysX7uw6wKHBUzqPIgROinJWtumPLo7MAlQuaTrvn4b5ehGMV3d+ZgsK2HE4pwsaAtaH2Tej5fW8TgPJK4ve6Zurwo2Xaazh4a/CsP5hMR6D851ubvl7Zl72uNFQPqqfTfqfy4o2Xgmnep5whp95xwal4iZC7+D/8/CZ/aiixpkpKAL+IS/ZUjp49x1TXTIhvW29ZIBI1UYSnNcTRfXtqeoANbLLhMjAtdHP9Lp80iPFKnZeqH9hx3RkehvrXFT49K5bc3nV85UzJRDAs7WENYPAoXii8s+6z4SLKN6gQqucg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZl9q5OVcs/iEnwb47Dm3s+auy7hWNWCOocp8bfOVGU=;
 b=nEusm6Il/4ZfhHt8X9+2j52o/g67v9nn98JxMyLPZRHze1u6p5R9+FEFVSnZh+uM7zKnWPIqy7Gx3lU1JOXXEO8BunmhfHiqoMasMtxZhc/ztd9lFoGtYVU94392rziHYUGnYVmyEXGoaDj9C1d7AhkTwlQGw6gEY1TbGt8Lh2E=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MWHPR10MB1245.namprd10.prod.outlook.com (2603:10b6:301:9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Thu, 13 Jan
 2022 07:49:06 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 07:49:04 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com
Subject: [PATCH v2] btrfs: cleanup finding rotating device
Date:   Thu, 13 Jan 2022 15:48:54 +0800
Message-Id: <d56216c5f955862d31be7c9884222fa9b7a4ddbd.1642060052.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <1b19262076d9ae10d3ff81f73209249375ae25bc.1642048893.git.anand.jain@oracle.com>
References: <1b19262076d9ae10d3ff81f73209249375ae25bc.1642048893.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0119.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::23) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51796cfc-147a-4650-f901-08d9d6692ac5
X-MS-TrafficTypeDiagnostic: MWHPR10MB1245:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB12450C67D4D244DA15D70180E5539@MWHPR10MB1245.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qN3wwwAtgnH8qfqmOwrIbcpbpKMR7etolwNU7AdOEM6mFLVddbgJwZ36JndNrSTy7wcxWCBXaILe/f/3Vc+LQcLrc5FX9lS3rVpZPid+yTjdxv1YahOOOPGJbIxg5TB9QHReSf2zsB2KZIy2ZvmkCFfobzxlb0mLq7TCj6JN1dbAYAndHFT/jidhdcw6GDAH0iMxlKvK8LFins7EvtxfUKZ3pbqm0/6aR2G2GyXkhwkG+D7D+jz9QrNDOmT0QbdoKJ9oN/wwYhL1L7vmhj0+04noYpOjFO1P+IYEcCoZVvkdYbkayaNDaxOJXrzONeYfSEIInbiz2jIIZmOurZ4MPXQx5ulr8U6BL7AIgX9V6pCbV/ZvvP+JAh2Vq5153BCxKjSbkM+WnjDQA7pX8BTvtxigpW1R7LT7oB6fJwUTaJJ2EqY+8RknNO7eK7XoFdf1iXBwBeiwlCzhZMUVdl1v5wmlJMlQbAnIwhsi+LxK3rsD9n4Oa5PaUtBghfcXUPCvund2+sC2U+dussL1g/slpFsVLkJRbMsoE0RHLHk0VF3SGECUXHw/cj9wKKIR8jo4WNZaWmEi8NEQG7DMV6VR4tiqd2LZooodoD6HBiAQZckfjPLAeMD3BClOMvTDZ/Qkp4VM7/fSe+C+HrWIdX1AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66556008)(6916009)(6666004)(26005)(44832011)(186003)(6506007)(66946007)(316002)(38100700002)(6512007)(66476007)(8936002)(508600001)(83380400001)(2906002)(8676002)(86362001)(5660300002)(36756003)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ObL7xIdUSXo1m/fwyidWjJnYdaCeoRbxPC/oIvS1Z7N/AsPS27I5Tw2/9wIB?=
 =?us-ascii?Q?LGExNVYPwYW4DVN/DCrk2ddNJvdtFL6gcrnQDUZ8U5v33vJM7x+CtMlWmc+R?=
 =?us-ascii?Q?IWruWCCyoMvUM3TY2CfzxB3EJoB4fio4qzBLir0wNeIz1k4V8tjk7bq73Exs?=
 =?us-ascii?Q?S+hYifTQAc6POC3rBX5I9Bgevco0kz7jGkjFznkx6gVWezoSaRyD83rk0DXa?=
 =?us-ascii?Q?JLEUS//4Mo33hKf6ZyOkBfdvqFSz/UzKGbegKRN0dRmUsM7Xbvu6UBAI32Ie?=
 =?us-ascii?Q?2EO0G3A6Xc09E39IHqI40tbNbeZOqMFqcr0XPv3kIj7gYQrHel1y8tcDPKq6?=
 =?us-ascii?Q?HbTGlrGSNOWGVgnDfsosUdwNAWqOjSu51NnnYPLz6aqTP+o9/s/EIuj4HOa/?=
 =?us-ascii?Q?Hyx1M+5+be+jcsR+3mKJNyJiXL5yDwaPL2NQgzUeAJuL45vMjeIyzQtkmSwM?=
 =?us-ascii?Q?VsHQlzvoCQjYNSeQ5y1Q9L/TucA+R6CuFmI5R1/e4ENeGrLk1RS5PohICzPM?=
 =?us-ascii?Q?R1vijSVyN8KJQgZlviboMfCwBHkjXI+tWOKfpPjghbkzjlLNIs+nH8zP+Dmg?=
 =?us-ascii?Q?+0kbFfhvZBiYISl50M3xwbmLrAZ+y6z9lHa4CICC0pejmGNivPYYkaG2qKrO?=
 =?us-ascii?Q?5KoSETyFPbz5lJQpI6gTntzCgvCZwgs1iMz07g5rCQ6eHByN/evo5d2wPK/T?=
 =?us-ascii?Q?Wic2X5Rnpg5mlfQrqDLu03TfAGhssqoQZYoLoVkYQ6SNXbnqsRM9Vq5yarNt?=
 =?us-ascii?Q?YyAt9eUphs1T2j4Q4jnZyZbfdoblsLJkRivorcfU7hgUCrSX16b0qm4DTJ2L?=
 =?us-ascii?Q?Jy0Kd8fL9Zdjd1C/Got8XU0ux0Ab2YEbjk5sB/eUYMz8QkOCMDbhZIaAbyIW?=
 =?us-ascii?Q?1Nwj49R1Q7e87dc12kiTSSDoFIyykV7RnsBqrd7wMyNmj5977tw4VJ41Okk9?=
 =?us-ascii?Q?naqvf62t/I/sJ3U3vgkIMtb3WBCOOEmAN15pUVnnBv00RB6L9d0MnMlDFJSd?=
 =?us-ascii?Q?avm86prSHd+tZNC7/R89vf3YgcSgWb1R4RBgrKj4jOBbCcBYhHKpe76CJdd6?=
 =?us-ascii?Q?D2Bbqh7SxoDnydvmOteYdKNBkCdz+rrIbNIy0BUAK1HUrFf/hxa3MXAPVT87?=
 =?us-ascii?Q?f67EfzegPVy00irkQLB9fh0zESCdxkgiGxwjPr3hHACSi6qv4/CVzfbwn+uw?=
 =?us-ascii?Q?VuUp/OGuw7jfbCUSLjXrEHHu9ANFbNH/xYBAJ9UU2jJSA0PHH7EU+pAfwoyz?=
 =?us-ascii?Q?KcZbs7R0vhUpHvrPQsaU5Aqm8WQcS27xtnushsMPkzsXgvMQnYqCwa0lLCCv?=
 =?us-ascii?Q?XHV8Tur2CquAT4+QiWO0DlMeCAB9yHbnVTkKLSOUsEV1t5x8vULsQbgNzstZ?=
 =?us-ascii?Q?RFzD24MQhXaITHxkbIpZG461zmZF30q3rqiVi+jczzu7ubcI+PwXn6WKUSFO?=
 =?us-ascii?Q?+gOs3p3JZilcvicXb5nVEkOVh3P/omkR/+zbYqUp+99jmOCIheN44HSYhOVN?=
 =?us-ascii?Q?CtdabHBQ8eE2wGlmmjwkR/6G4Bq2i4MSexejdFnkB/Ml7AGnUL6IAJXAoUnb?=
 =?us-ascii?Q?W1aA1KHxAMHXhhIydvdJ1V5HhFYeZnAyXICg7QGMMkfmayprTdaKr+m+gVdr?=
 =?us-ascii?Q?N6ZZUx+Z2U2tMfD86zmygss=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51796cfc-147a-4650-f901-08d9d6692ac5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 07:49:04.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNgzDSuPpo4HqitJ4o0C/NiY/TZSfql7kbIXdiHopx41Fw8+LP9Wj78RPuLsLZIRHY6Orb/21euow4DHQprSJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1245
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10225 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201130043
X-Proofpoint-ORIG-GUID: 0m2hQfiw3I-RaWZY2SMvlX-4TTHrGayO
X-Proofpoint-GUID: 0m2hQfiw3I-RaWZY2SMvlX-4TTHrGayO
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pointer to struct request_queue is used only to get device type
rotating or the non-rotating. So use it directly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Eliminate the if statement.

 fs/btrfs/volumes.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 70b085dff500..34d08c4f7b6c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -601,7 +601,6 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 			struct btrfs_device *device, fmode_t flags,
 			void *holder)
 {
-	struct request_queue *q;
 	struct block_device *bdev;
 	struct btrfs_super_block *disk_super;
 	u64 devid;
@@ -643,9 +642,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 			set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	}
 
-	q = bdev_get_queue(bdev);
-	if (!blk_queue_nonrot(q))
-		fs_devices->rotating = true;
+	fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));
 
 	device->bdev = bdev;
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
@@ -2590,7 +2587,6 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
 {
 	struct btrfs_root *root = fs_info->dev_root;
-	struct request_queue *q;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
 	struct block_device *bdev;
@@ -2666,7 +2662,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		goto error_free_zone;
 	}
 
-	q = bdev_get_queue(bdev);
 	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	device->generation = trans->transid;
 	device->io_width = fs_info->sectorsize;
@@ -2714,8 +2709,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
 
-	if (!blk_queue_nonrot(q))
-		fs_devices->rotating = true;
+	fs_devices->rotating = !blk_queue_nonrot(bdev_get_queue(bdev));
 
 	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	btrfs_set_super_total_bytes(fs_info->super_copy,
-- 
2.33.1

