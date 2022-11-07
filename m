Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3529E61F727
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Nov 2022 16:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiKGPHb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Nov 2022 10:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiKGPH3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Nov 2022 10:07:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0F713EBB
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Nov 2022 07:07:28 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7DLGZ6019438
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Nov 2022 15:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=cnXKeSzs0RQ4F96NPDOUV/WyF5Z2tq8t9HAQY1a+GCE=;
 b=zTRNXJ8FKyL5bTzawG1czRS6EaLxN6mePkpMr0vT6ZOVTOoWVQdTy1e6iPvMJX0ooArO
 wnO34+MI+9FtimbVbDTB5aJFa0psvrSAKeXY4L4an8x+61n3icUl4fQkXnu58ZtYNby4
 6u4z0u5NhjqCBolMD55rgIZR+sdU6n1Zxpij4k13pcERPFEBHDy86jv+5wFDIZ0KPdrT
 6Fqifh3pk8mEHfYMG2rPbxK9+coG6l3WFUy4+FMFHyeAp12fGflmZ2eQa4iBSvhEmpqx
 w7cdntj9ete/3pIn6vzUohc7ivouU6QA41wgCWkz2sPAEqkTd8szdtPJ60UoZ1LaclP7 jg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngrem3g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Nov 2022 15:07:27 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7Ehij4003603
        for <linux-btrfs@vger.kernel.org>; Mon, 7 Nov 2022 15:07:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctb4ak6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Nov 2022 15:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/1Jl8PS/VLS6pwOwoLKzAxo5Tj774kGsV7TyLdNMCgzRovPJZjCDKFsZxCG+FeYaP666fxLwYlEY919INbu8XxsYEHgHeuu5WTv2UjsjrlQ0v5tJrOj/4JG4Up/yXBrTxaJqIrNDP8rem8U5X61TlDoT0FulHf/v3C5rGrp65dniC6cRPKsEXsQCKA8JBxtmZ0KbimP63DdZKVtEdMfg7n+6wM13WMUYWsjYZfuhOPTU4l4u/Qa9w8WolwQT5hGLDDG7x30p4b4aEDGNF7jd6ka220V0lsQc3Nc7x6dGagmGULtziP4QiuXdUIW1arbcLBLNIstBqgTZ8Q4ZFHr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnXKeSzs0RQ4F96NPDOUV/WyF5Z2tq8t9HAQY1a+GCE=;
 b=V4EZUjZW7P0+LgAju3z+12Z1HB5DIPhS4NT1hAltNzADZI814uLM1L5FjCwlLKn3vsgjWWS1KiyCdDq5vpKKBFu84BiZMdr5UaRM72+WcXDlte6UnPQb3JBxHFib6KIGExH4vGvB5Jkiu2qsORWO66FNAccCGB6j6KHGMLYZ3t7qc8ne0qnHFfkuts4nPdp71LxBJMTR6E+Y5qbwJ+68huLQ10j2YqAq31ORX5YWFNTRzqqKir+08ViSmZVa2emeRfuZjpyfD446ybCZBI9IuXEgXWaTWj8AH+EElv8rHHCYzz631QVPjGqOqRdhnK6YnotAKag4Gd1lSVz4HLxbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnXKeSzs0RQ4F96NPDOUV/WyF5Z2tq8t9HAQY1a+GCE=;
 b=uGlckSZz1Aqt5/2Z0u8g4b6aq2QZLjbFvbfWSnLsKQv3DMA+4Sl+CgHnbqe/FKakS7yrc74qa8evGWOkv+TohKFRCSLYJDGbDdflSlnL9Xj6b/pNQz8gvL82t6YJmukUVUlY6B7cCOmAuBeUvowSYE9rTfbiMFf9aNC68NVZ90E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 15:07:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56%4]) with mapi id 15.20.5791.022; Mon, 7 Nov 2022
 15:07:23 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: move device->name rcu alloc and assign to btrfs_alloc_device()
Date:   Mon,  7 Nov 2022 23:07:17 +0800
Message-Id: <558d3ae7ad53788c05810ae452cece7036316fb2.1667831845.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: f92a3c5f-77b4-499e-3f81-08dac0d1c5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5YiMHR2hFRBKm/LbdHSS83DqtKGrfZyOXm+a/eFrz1HuruUMP+CCCH5yIvP0/r9rZ+9i5qpv3/hz2Wt69BenIb96pcRWUJ/FLGSgUonUO+BvLo1sjBcHhcROhPCZZLnPsFis2UAaxb5NXNt8T4jO+zH9DqAjW6JzjeBwuU116t01OTht33B1ecAE+Yh4311KkOOhc2mawTnw2tDM9BL+ZH6rKYET+zkbz9YngQfa1B4JFrexkpqZ8iBnM19YkO8Dsxi8FKKDCYWgyycZgsPm76lGQq2clutgbwBpJfc3vcnab+9SFnDKu2Gv2v+jFK8KYHC1CH2ItW7mjr6UYkWd1KtF+mEWlaY996eBErqgfggjAbP39hZ8mZylKy9zyveexaHTSakPSkWsvnrzHgnZcde1PvyB3y7Lzi23STgCusMe5nUfhoAdRXIwLaT2Q6wfxsJHzJhQb8UClv6Jg4Rp+BGiX8XSnkF6PcHqRxEzX2336ji8ehjlVG0McPOxYyx5pd4CeYdUIxchx7e1E64ehbAABGG0XKrgccxiSxicVA/9s53suqe2REqyp6Rg8DYqWVlt8NOsYwx5soG8cBcSI7Qythero/Ibe+jcaB1MGbAJ6Jfn0tybB8iECnyWff4gMRpbOfWbQVoyagoPW0In+QeAAuU4lY7O6cApZAGky81xlWzdUsjhFKZQ80qAZUUHhuLG9fT+nWDrSYhe7Abkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(44832011)(478600001)(2906002)(316002)(66556008)(66946007)(8676002)(66476007)(6486002)(5660300002)(41300700001)(8936002)(83380400001)(38100700002)(6506007)(6666004)(86362001)(186003)(6512007)(26005)(2616005)(6916009)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mG7xJIsc4bYpT9NMs894djCrB3A16+0+W4eR/9TQ0Rs3uyd7Fet3Rc57SRAs?=
 =?us-ascii?Q?XlBHardrWsasFhZigrql1d7kxLW7n8HIOqyUf1XghlEYE7/DmsOloI+yejDw?=
 =?us-ascii?Q?OOdG8HIS1AWgudQ3N00LCTwWs7GiBIE1wNIdVsTr64MHETH+Kjl8Ssy6oC9J?=
 =?us-ascii?Q?S26THStcGp7exo1XwRW1zDJbVbway3L7Rxl2LeDRxpQ1sKJ4/v5Rbl0H6kHp?=
 =?us-ascii?Q?bAu6A25jJuRkCX4UPla7G6+4rzQf1rScK8mwxz34IPxO4rCuqkYT1DqDqwOK?=
 =?us-ascii?Q?o2/EJz7TfyOGOmrsY5tJ43Xjb4TRqMAs+2wKhIo+j+qiFutdPFxtnAVWoWTn?=
 =?us-ascii?Q?Zr+OSuPAyBbxAwVi/XoNwajP++Ryq1uVEnDtVzE11yzIUfeXJC/7dlZHfe7x?=
 =?us-ascii?Q?F+1EP82YTVL27CYC4z5ERs7k08YLdROi6OVu8nx21PxDf3VkF8kvnroe5tIs?=
 =?us-ascii?Q?XuBCj9Sng+h1pmy9qmrcVMRdfSHmSsOUFI0dEVRZ91fTBDBm79L2GL+y76W6?=
 =?us-ascii?Q?6LZ6pIOrqkc4b7/J+4YbJxr7eslE6SzZ3PULE4VNhJaMPz18W+2VHscpUOdW?=
 =?us-ascii?Q?UMJvSn3rW0Wz5eSPB9J0efA514upEacnLJ1qqbGVZcZ5fLF/N5vIdJAMfU9E?=
 =?us-ascii?Q?pkagRIZ+5XQMYOGjbZOQrSEH1Soyc82owuIeqG2C732xHIinuiugCNXzEQIv?=
 =?us-ascii?Q?IE/8XgXqVPphgrN4hfKj/0fAPIR3QricphX11By/wjdXqR7SiR1jG72MKEeW?=
 =?us-ascii?Q?Do1vYcx3B0KzycESTx7L/s5/Q/b/RbXaRYy/5dnyez9V5tLLRpRy6TEucCMp?=
 =?us-ascii?Q?QbTX+oKxwGk5i6CHRXIyFr5RdTQCm0osvDbUZzJJhMFMI2g92PzpoIC0yg3n?=
 =?us-ascii?Q?aIHl499G/uGLhvc0YOs65Wabu0m+r2bjkbrhwpRhPiWS2hx5x3pFM+Sv6h3A?=
 =?us-ascii?Q?6SpzqSNFg06Y/7j9hbiGq3B24i1NaG+5pXjoFvjpov1DFM1MLFaYgK8Ms4zu?=
 =?us-ascii?Q?FTxQQsPmJ2h5MljUnHKi2HONsBF8FLb0UfgAQOA+CcJwlo0DzdGfhN4DIjxE?=
 =?us-ascii?Q?vl6Kj+Kt0DI9454dxa2S+B2hUBtzhvWvgEu8ctGu9yUr7Gb2CRqMMiLd8PEd?=
 =?us-ascii?Q?DJHj8IDSOZFcswNiIwmDiti9PkdwrJQgf8yhFhLv6CFcab24BQs+BaAUVGK1?=
 =?us-ascii?Q?t7ITi65VJ8WdW05Nni27TzncVJCOt08CqSpi7enfhT8/ZiZQISLN+VGqTMiD?=
 =?us-ascii?Q?PR/za1TtjcMAMz3gEd4hw0OPAvGOBrZuQchsZksf25xwIqXNsXzc8IOQ5qdr?=
 =?us-ascii?Q?3SfbPdxdXWbw6wsz3WySVLWZvLkqFC5412xrR0Yt+hY7bVq994HTknVclAuw?=
 =?us-ascii?Q?2G3z1TxxpCXJIyR3mJJgCLTEMxtIgedUDfXidxgqhDh8m69jW187Zn72L2TE?=
 =?us-ascii?Q?p96VVifBbCz/NcPoFHgv9abxBiZ/pXtb9G44Z9sWoQ1lG52HinjYZ5Zvxl15?=
 =?us-ascii?Q?1C/KuD0nFrnzNiIqLWgfVsVICxJvW5dY52XDvVhrMsMoHHrkL41ThLhFSfUd?=
 =?us-ascii?Q?jqyGR8gPI8d4iNwzI3e1NT9epNJlWwgSXv+rTtme?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f92a3c5f-77b4-499e-3f81-08dac0d1c5b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 15:07:22.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LTa+yXSavMlbwgzTCCLMzkQfAPJCjIP1D+QwlkGuU2ISqzV56xXF87w2rAz+PFyoxwd74LU0tyArCoOAzCXylg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070121
X-Proofpoint-ORIG-GUID: e0ijx2h1G2iD-KFOsc1mFwsQH6c_xMnj
X-Proofpoint-GUID: e0ijx2h1G2iD-KFOsc1mFwsQH6c_xMnj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a repeating code section in the parent function after calling
btrfs_alloc_device(), as below.

              name = rcu_string_strdup(path, GFP_...);
               if (!name) {
                       btrfs_free_device(device);
                       return ERR_PTR(-ENOMEM);
               }
               rcu_assign_pointer(device->name, name);

Except in add_missing_dev() for obvious reasons.

This patch consolidates that repeating code into the btrfs_alloc_device()
itself so that the parent function doesn't have to duplicate code.
This consolidation also helps to review issues regarding rcu lock
violation with device->name.

Parent function device_list_add() and add_missing_dev() uses GFP_NOFS for
the alloc, whereas the rest of the parent function uses GFP_KERNEL, so
bring the NOFS alloc context using memalloc_nofs_save() in the function
device_list_add() and add_missing_dev() is already doing it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c | 10 +------
 fs/btrfs/volumes.c     | 64 ++++++++++++++++++------------------------
 fs/btrfs/volumes.h     |  4 +--
 3 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 84af2010fae2..9c4a8649a0f4 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -249,7 +249,6 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *device;
 	struct block_device *bdev;
-	struct rcu_string *name;
 	u64 devid = BTRFS_DEV_REPLACE_DEVID;
 	int ret = 0;
 
@@ -293,19 +292,12 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	}
 
 
-	device = btrfs_alloc_device(NULL, &devid, NULL);
+	device = btrfs_alloc_device(NULL, &devid, NULL, device_path);
 	if (IS_ERR(device)) {
 		ret = PTR_ERR(device);
 		goto error;
 	}
 
-	name = rcu_string_strdup(device_path, GFP_KERNEL);
-	if (!name) {
-		btrfs_free_device(device);
-		ret = -ENOMEM;
-		goto error;
-	}
-	rcu_assign_pointer(device->name, name);
 	ret = lookup_bdev(device_path, &device->devt);
 	if (ret)
 		goto error;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 27fa43f5c4f4..7a9e6c40c053 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -845,26 +845,23 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	}
 
 	if (!device) {
+		unsigned int nofs_flag;
+
 		if (fs_devices->opened) {
 			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-EBUSY);
 		}
 
+		nofs_flag = memalloc_nofs_save();
 		device = btrfs_alloc_device(NULL, &devid,
-					    disk_super->dev_item.uuid);
+					    disk_super->dev_item.uuid, path);
+		memalloc_nofs_restore(nofs_flag);
 		if (IS_ERR(device)) {
 			mutex_unlock(&fs_devices->device_list_mutex);
 			/* we can safely leave the fs_devices entry around */
 			return device;
 		}
 
-		name = rcu_string_strdup(path, GFP_NOFS);
-		if (!name) {
-			btrfs_free_device(device);
-			mutex_unlock(&fs_devices->device_list_mutex);
-			return ERR_PTR(-ENOMEM);
-		}
-		rcu_assign_pointer(device->name, name);
 		device->devt = path_devt;
 
 		list_add_rcu(&device->dev_list, &fs_devices->devices);
@@ -997,30 +994,18 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 	fs_devices->total_devices = orig->total_devices;
 
 	list_for_each_entry(orig_dev, &orig->devices, dev_list) {
-		struct rcu_string *name;
+		const char *dev_path = NULL;
+
+		if (orig_dev->name)
+			dev_path = orig_dev->name->str;
 
 		device = btrfs_alloc_device(NULL, &orig_dev->devid,
-					    orig_dev->uuid);
+					    orig_dev->uuid, dev_path);
 		if (IS_ERR(device)) {
 			ret = PTR_ERR(device);
 			goto error;
 		}
 
-		/*
-		 * This is ok to do without rcu read locked because we hold the
-		 * uuid mutex so nothing we touch in here is going to disappear.
-		 */
-		if (orig_dev->name) {
-			name = rcu_string_strdup(orig_dev->name->str,
-					GFP_KERNEL);
-			if (!name) {
-				btrfs_free_device(device);
-				ret = -ENOMEM;
-				goto error;
-			}
-			rcu_assign_pointer(device->name, name);
-		}
-
 		list_add(&device->dev_list, &fs_devices->devices);
 		device->fs_devices = fs_devices;
 		fs_devices->num_devices++;
@@ -2592,7 +2577,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct btrfs_device *device;
 	struct block_device *bdev;
 	struct super_block *sb = fs_info->sb;
-	struct rcu_string *name;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_fs_devices *seed_devices;
 	u64 orig_super_total_bytes;
@@ -2633,20 +2617,13 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	}
 	rcu_read_unlock();
 
-	device = btrfs_alloc_device(fs_info, NULL, NULL);
+	device = btrfs_alloc_device(fs_info, NULL, NULL, device_path);
 	if (IS_ERR(device)) {
 		/* we can safely leave the fs_devices entry around */
 		ret = PTR_ERR(device);
 		goto error;
 	}
 
-	name = rcu_string_strdup(device_path, GFP_KERNEL);
-	if (!name) {
-		ret = -ENOMEM;
-		goto error_free_device;
-	}
-	rcu_assign_pointer(device->name, name);
-
 	device->fs_info = fs_info;
 	device->bdev = bdev;
 	ret = lookup_bdev(device_path, &device->devt);
@@ -6986,8 +6963,9 @@ static struct btrfs_device *add_missing_dev(struct btrfs_fs_devices *fs_devices,
 	 * always do NOFS because we use it in a lot of other GFP_KERNEL safe
 	 * places.
 	 */
+
 	nofs_flag = memalloc_nofs_save();
-	device = btrfs_alloc_device(NULL, &devid, dev_uuid);
+	device = btrfs_alloc_device(NULL, &devid, dev_uuid, NULL);
 	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(device))
 		return device;
@@ -7011,14 +6989,15 @@ static struct btrfs_device *add_missing_dev(struct btrfs_fs_devices *fs_devices,
  *		is generated.
  * @uuid:	a pointer to UUID for this device.  If NULL a new UUID
  *		is generated.
+ * @path:	a pointer to device path if available, NULL otherwise.
  *
  * Return: a pointer to a new &struct btrfs_device on success; ERR_PTR()
  * on error.  Returned struct is not linked onto any lists and must be
  * destroyed with btrfs_free_device.
  */
 struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
-					const u64 *devid,
-					const u8 *uuid)
+					const u64 *devid, const u8 *uuid,
+					const char *path)
 {
 	struct btrfs_device *dev;
 	u64 tmp;
@@ -7057,6 +7036,17 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 	else
 		generate_random_uuid(dev->uuid);
 
+	if (path) {
+		struct rcu_string *name;
+
+		name = rcu_string_strdup(path, GFP_KERNEL);
+		if (!name) {
+			btrfs_free_device(dev);
+			return ERR_PTR(-ENOMEM);
+		}
+		rcu_assign_pointer(dev->name, name);
+	}
+
 	return dev;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6c7b5cf2de79..07eb5aecbe81 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -649,8 +649,8 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 				 struct btrfs_dev_lookup_args *args,
 				 const char *path);
 struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
-					const u64 *devid,
-					const u8 *uuid);
+					const u64 *devid, const u8 *uuid,
+					const char *path);
 void btrfs_put_dev_args_from_path(struct btrfs_dev_lookup_args *args);
 void btrfs_free_device(struct btrfs_device *device);
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
-- 
2.31.1

