Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC75700B5
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiGKLcj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 07:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiGKLcX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 07:32:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824947C19B
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jul 2022 04:15:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BAkYxF008338;
        Mon, 11 Jul 2022 11:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=9YEY/5DXIdBebIgGo48ZCE/j5lHAPHQOOTpmPPTexVk=;
 b=Gx9SrKUV6HrXZTeGSy9oUpjZ5UPbONytGTA/ZjStxS7kMYdIJpdZ2NBCBrS5ajUEfCKh
 SwlGf3d/5jD1u6g3FwVoE57JNcFJbdm9T8NgF43C4CsGEmJhp4BsEkFjuGMRypfef8io
 h6xDhlDpVIn/deajMEv7IzlinoNCfTpxz6wbf+q6scuCRRp9bwFhh40lc6ohi19XSWCU
 wan1blgpXrAE0suWRNZ0ch91cK/hRP/uKOAFbzfSFQ/bdCSM09oKhKN2ToOFSXDuEN0v
 ZuyRXJoZ92HjKM8L/I8LKseCUN2vQdT0+aCznd3Ez5vkJZtBaoGyNnuE4O2er73LRlSD 7Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71xrb3qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 11:15:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26BB5FIW020831;
        Mon, 11 Jul 2022 11:15:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7042bath-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jul 2022 11:15:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKrSiHL+4ioHCg757uKUHCCzGG5VltpRYpazgySWHhcc3u7lEyN8FxdwAat8nAq7BDEj0rrye+nl4wLdfJWCI9DDbi9cesciOAykV3cP+rEPIJB9mwTXth1lIDUca8R1QzdM506Sd4rGEogSatUrEHhVqWM0KZQC6NMRkoAj+s3AE5sCp54Es/hDohukChfEx1B5QNVmU3n3UwC92KC/2aInt6GO7TPs66auFhaeStldO5K/ITAIhSnfu3Ssx7ashG7qIVStlYZOcb7dDQnNPcupD7bMBkcxLzWR9d8S6KXdiIDE4+t6lOOe/FDcD1C4K6EcWmEh3rYjLmsZXX+FNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YEY/5DXIdBebIgGo48ZCE/j5lHAPHQOOTpmPPTexVk=;
 b=VBJDh/cvt0yGzozUU9LrmM+0Zxn7wXkXYjRR4zXeebtUOHlycRR65UL8gW1qw7poPMQxf7QlQIINJYXtOadRY7LF7RxsG3UCvoym3GKoyfwQ0flJyQ/1iRL1FWWywJPCmJ1YTuNuz8eE6HGI5dFHFQ/+RFNFUNVP2HUJ/LeOWJe8NEWrLN6g8jYPgnIRwya00jA61X25D6EZl7OGewlBKl5A4N01A1kAHLWUi2mx3l1oXGQZTVepez36qhC5cfIbu/Cmg3ZsRys7wXRyVaqkagAuFhdBsJZtWc+KJ8/vpfrytsEjjI8WjIEpRq+RxdCDjO4DdYJzwyhMoFqEcJBcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YEY/5DXIdBebIgGo48ZCE/j5lHAPHQOOTpmPPTexVk=;
 b=DflY2eM7eizn4GKAoGATjZOWsNuESipw42Kag4ukZcH38yeojU2MyWsMpsUhTyFuslg2FBsQXRDFtRl80LAP6WcI+sFbp9ds1VsJRnKNl+0saeJil1J/ebG4NQ15go8jd6DkrPd/eb8lkA2ccAbda6Kfcnl6qAKFqsbXeteb3Bc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5001.namprd10.prod.outlook.com (2603:10b6:610:c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 11:15:06 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bcb9:f224:ac37:6044]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bcb9:f224:ac37:6044%7]) with mapi id 15.20.5417.016; Mon, 11 Jul 2022
 11:15:06 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 1/2 v2 RFC] btrfs: keep device type in the struct btrfs_device
Date:   Mon, 11 Jul 2022 19:14:51 +0800
Message-Id: <9b608b4fb235e95b439233f8fe778c5594da4e4d.1657536723.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1657536723.git.anand.jain@oracle.com>
References: <cover.1657536723.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fdcf7c6-a710-4f3e-99d0-08da632e9bd2
X-MS-TrafficTypeDiagnostic: CH0PR10MB5001:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R9SWCFL0Kmn8hMAg41xAVF6fYS/GG5DWtkRrGRo067bnCDH+KBu0touXp/tbPgDmc82Vc2k9YsHdP52Cldn4wIPgFq25Zdxih0oUJp1NnIWyv+giP5NvrTTRn6cT4XWZfgIIkCGXavUz54S8KI3yDBz3/41B2UM0ZsMuUzP3QaxhFv31WYRDwksG4pBovjSRQf+vGpa2G6PG7HgTdXIcx7c6LDgz/ZEyvMf9Hc+HscYBP3X6gJog/coltv09tFjJSPaSXoP+ZS5unajoPuH+hwTMerGntryn8ByaljBuL21GlCuvr9fv2hxO+tCgOlG0APdhJk/ihggVUS6LgmYtxjNr12iSSGaOmHWR/mUTbK9vZ/JRI05kJOEkaclGECZbxIpxdJyEq9oVqflOOqiCPfSlfMCk1l5bgMUHryYHLW1B0vzVYZJiK059IKMtu7NH1VBzmoBSKsBXFw4M8osGJdkZq+CzFSaJSoFtdfN8y2ExeE4tsELve8fYxoL1WwBcT/dVgYe1exF6korahRPHtu/a0JM4D7HhRA1yxcuA2MW77IhGht3ptJ9c8orG/SUAGXeBuUeOJK7+5cfPNKj4KNucd2bgQccuBojLkWF+pePgx7wZLp+kcKMN6L2tvc2iOGk2TgdXHhywAtFZju10SRWngXkiZ3WPA1M4A/J4cikTbCmQ+xOR+EE/lnMYLk+iyMyPx5b3XI1NrNbhHQnrAS5IW7tjpq+QA/MyTu0bVTUyuyGrQ7frRVDGlZUAZi1v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(396003)(366004)(66556008)(478600001)(41300700001)(6666004)(8676002)(2906002)(66476007)(36756003)(6916009)(86362001)(4326008)(6512007)(66946007)(6506007)(26005)(316002)(6486002)(83380400001)(38100700002)(2616005)(5660300002)(44832011)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R3kN9rNNmlSXNnCvQzwOzB0MvObKscxoN1/clrzhOVApIH0ypKrN9e8UxUR5?=
 =?us-ascii?Q?X7BzaDlR5ynguhQ/1STphQ4FvxnwO2eka0JBdU/+uFd3TloSdULXup9nPNPe?=
 =?us-ascii?Q?jjCnlwaduFDIbRCsNFFThXYg9ml1LhKp4p1ow1NfbI2ijQOXT3RvvraHC6Xw?=
 =?us-ascii?Q?Ro/znxRrcCRfVyEX1KruBkV3OmyUsEea2IqQE2bYtJRurNKsu6TCnaK7OD3m?=
 =?us-ascii?Q?yXysxDslbHxfKxv8Fw6Lnkb69EKHWdneimvYnWDfMOwqeXjRv3eovZWbTBxj?=
 =?us-ascii?Q?4fBonwmn09z3KQhp5V0xW7Mc+2VEBQ5QG3ncvUm0Wparxbji2iVULdE6fjfB?=
 =?us-ascii?Q?7EqCermmHgZjfQ9Qon+3rtT9Tg4xYg3KiBekVEKyzZAsPawmxxG/VK/ly0Hn?=
 =?us-ascii?Q?5YfQjMzBHFrjp60hcSJUkq3HlFjB8EUCxJ5OX31Ne1SScgU7nc2VaJswxjBH?=
 =?us-ascii?Q?9c8YAmpY3RSCvUx8J3fZSZ5DRoVr9+OJcEHLGqJdezGYJ6Ytdz5WE0kKfTje?=
 =?us-ascii?Q?u2SuBB4klrCcvSX3uDly3GVn/FmUybaWWYIBZlo7HMvchfgvwHp3IL0bw0/9?=
 =?us-ascii?Q?eq24QHYAxvjO/QvDfTX8N9v5dr1DxVVW8oa5cpjh+q7/bZ93UWxdEAMcMAJu?=
 =?us-ascii?Q?b8jeV8x+P/U0L+UTsv9zpBlSAGtrj0fGHjg1BKk3oTy3LlLr7FONzbDcl+14?=
 =?us-ascii?Q?siVRVUHV08B9BCi1NxwcNicJIsjnsXDLvocVelmJfY/rIYGKu/SnDKM2zc2m?=
 =?us-ascii?Q?AzU4mbqGB0KvURNwcKUHdEs6hndXIU+875ZKxpG4LPVdZFlyGfg5AdMcvPEQ?=
 =?us-ascii?Q?WZQhnqKI/9k6jBU0JgKNyieUTIUYryqt42gIey2+vQJfabTtLSlUOgJXDYej?=
 =?us-ascii?Q?vfYc7JJ31ekc0jY8Gm4rZ6wtA3T1syJiERy37dtAZU/iQ8CGWmIn3HwE4Vif?=
 =?us-ascii?Q?PARLu2jx4btwAwiOm08xyZ9rwlgXO9mzJJvky5QPgY1q/qUYVh5Ni4iHU3E3?=
 =?us-ascii?Q?NUug2f3uTWigNSfi1zlJMEMeNxsILAMJheTFrS3f3JrH0gG9kbZiuAuhi8/y?=
 =?us-ascii?Q?TG1RGCib0HOx1kFK6iPGhLJm1T0pemg1EvXP027SrXYbydOZ7jRwas7/A8dz?=
 =?us-ascii?Q?POfSkdKnOwq00W/wHG8ssUDYOh3K+rhQkmh5ckqgnIrdISGX6NlDGRzLFIef?=
 =?us-ascii?Q?zMqc5WPjuoiheDK3JAXGKenvLZX2rh9tWpRutGUaBc3xsVUKEpSO7oMiJZHl?=
 =?us-ascii?Q?pDumwTkex3XxfO1fcmI1i4aUvNBQW2iakDq7p3wk7hHI3RxbynigEU+FmrAP?=
 =?us-ascii?Q?jum5i/Eju5feEE3V5eAjqdAhYcNMMccxL/5BL9HSVU1ojGhwnawY5eH2W9tT?=
 =?us-ascii?Q?E/35Adk56eTr/E2BzuIEClpETo5J3E7fzKLalQAH6bIGyvMZqUgFpX6Qnbph?=
 =?us-ascii?Q?NkZCosbL1CYu55abO2t+yuergbQnxHJIUnMFkmgQaWf5ZkiE5mlVpBUGu4mS?=
 =?us-ascii?Q?weW6JGsPVzwe1oPj5gXjcYO2FuM/WOrlqcqtxsFaNgJJJKmFyRlQzua1P2NC?=
 =?us-ascii?Q?7Xl1YdjYYnd8rfQm1+5ksO7RU/P3GbE8k9FG26Fw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fdcf7c6-a710-4f3e-99d0-08da632e9bd2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 11:15:06.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KLcuRxfk3Hj07/ULF5xQSGfgU/UsjxSD1R7lX7QGTqc6UDBJPEZ/lZcfSTZA93dftDbOEFwFIWSu6QEi5GizQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5001
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-11_17:2022-07-08,2022-07-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207110048
X-Proofpoint-GUID: wli2F_lLMbp0VgI-23WBetcy-eDULIDN
X-Proofpoint-ORIG-GUID: wli2F_lLMbp0VgI-23WBetcy-eDULIDN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch adds a member 'dev_type' to hold the defined device types in
the struct btrfs_devices.

This new member 'dev_type' is in preparation
 - To make data/metadata chunks allocations based on the device types.

Struct btrfs_device has an existing member 'type' that stages and writes
back to the on-disk format. This patch does not use it. As just an
in-memory only data will suffice the requirement here.

The types defined here are the broad classes of the device types ignoring
the interfaces used.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Add BTRFS_DEV_TYPE_NR and add device_list_mutex in
    btrfs_init_dev_type

 fs/btrfs/dev-replace.c |  1 +
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/volumes.c     | 38 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h     | 23 +++++++++++++++++++++--
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f43196a893ca..ff04653eda9d 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -324,6 +324,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	device->mode = FMODE_EXCL;
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
+	device->dev_type = btrfs_get_device_type(device);
 	device->fs_devices = fs_devices;
 
 	ret = btrfs_get_dev_zone_info(device, false);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 70b388de4d66..ceef98267047 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3649,6 +3649,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_block_groups;
 	}
 
+	btrfs_init_dev_type(fs_info->fs_devices);
+
 	/*
 	 * If we have a uuid root and we're not being told to rescan we need to
 	 * check the generation here so we can set the
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2d788a351c1f..b8ab13127caf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2570,6 +2570,29 @@ static int btrfs_finish_sprout(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+enum btrfs_dev_types btrfs_get_device_type(struct btrfs_device *device)
+{
+	bool nonrot = blk_queue_nonrot(bdev_get_queue(device->bdev));
+	bool zoned = bdev_is_zoned(device->bdev);
+
+	if (zoned) {
+		if (nonrot)
+			return BTRFS_DEV_TYPE_ZNS;
+		else
+			return BTRFS_DEV_TYPE_ZONED;
+	}
+
+	if (nonrot) {
+		/* Major 259 is a NVMe device */
+		if (MAJOR(device->devt) == 259)
+			return BTRFS_DEV_TYPE_NVME;
+
+		return BTRFS_DEV_TYPE_NONROT;
+	}
+
+	return BTRFS_DEV_TYPE_ROT;
+}
+
 int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path)
 {
 	struct btrfs_root *root = fs_info->dev_root;
@@ -2662,6 +2685,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->mode = FMODE_EXCL;
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
+	device->dev_type = btrfs_get_device_type(device);
 
 	if (seeding_dev) {
 		btrfs_clear_sb_rdonly(sb);
@@ -8293,3 +8317,17 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 
 	return true;
 }
+
+void btrfs_init_dev_type(struct btrfs_fs_devices *fs_devices)
+{
+	struct btrfs_device *device;
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	list_for_each_entry(device, &fs_devices->devices, dev_list) {
+		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
+			continue;
+
+		device->dev_type = btrfs_get_device_type(device);
+	}
+	mutex_unlock(&fs_devices->device_list_mutex);
+}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9537d82bb7a2..853c7a2e8960 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -86,6 +86,16 @@ struct btrfs_io_geometry {
 #define BTRFS_DEV_STATE_FLUSH_SENT	(4)
 #define BTRFS_DEV_STATE_NO_READA	(5)
 
+/* The device class type list. */
+enum btrfs_dev_types {
+	BTRFS_DEV_TYPE_NVME = 1,
+	BTRFS_DEV_TYPE_NONROT,
+	BTRFS_DEV_TYPE_ZNS,
+	BTRFS_DEV_TYPE_ROT,
+	BTRFS_DEV_TYPE_ZONED,
+	BTRFS_DEV_TYPE_NR
+};
+
 struct btrfs_zoned_device_info;
 
 struct btrfs_device {
@@ -135,9 +145,17 @@ struct btrfs_device {
 
 	/* optimal io width for this device */
 	u32 io_width;
-	/* type and info about this device */
+
+	/* Type and info about this device. On-disk (currently unused) */
 	u64 type;
 
+	/*
+	 * Device type. In memory only. May consider merging with the member
+	 * 'type' above at some point. Possibly, when we want to support
+	 * user-defined devid-based chunk allocation.
+	 */
+	enum btrfs_dev_types dev_type;
+
 	/* minimal io size for this device */
 	u32 sector_size;
 
@@ -714,5 +732,6 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
-
+enum btrfs_dev_types btrfs_get_device_type(struct btrfs_device *device);
+void btrfs_init_dev_type(struct btrfs_fs_devices *fs_devices);
 #endif
-- 
2.33.1

