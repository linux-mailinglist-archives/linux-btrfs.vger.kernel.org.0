Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B526D4D794A
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 03:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbiCNCM4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Mar 2022 22:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiCNCM4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Mar 2022 22:12:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D9A3FD8F
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Mar 2022 19:11:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22E102tJ017947
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZpWc569g+6QQUsadJtdIj7a2kDI6383GVFlHofhDxNo=;
 b=MCg5v82Bvx9lFk0E5zNU0pNzz1Vu/C3QiGB9zr/Z+mJUZiWHYCYycadeEOeDFDobkDtU
 33XM1knZf8La2C1X7PoVbkcg1N2Xa9QWR+S9zY2cs68UPkMQvKECSHPFsO4s0LXl95oL
 Z/Tsy3h1fm02StOROG5ZpMjMoJ+wbtWJ8HRYF+63slXfD6xGdem9285IwWWJ5+fUZ5KD
 HPOoSpe6f99SKPMQUWYUOWWRyPLDbg6fvl/Rxsm8JB5U7GmoVNg3WImcSdldNRgHknqA
 HGTkpWDuV5hkngj4b3xjvV9qi4REPUYnm9j59YB5uTiO2P0NoUefZZUFVn36J90uD572 BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3erm2ta8gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:11:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22E25Q5R102860
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:11:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2048.outbound.protection.outlook.com [104.47.56.48])
        by aserp3020.oracle.com with ESMTP id 3erkb08006-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixFhCIAJ9MmSfdPOGqd4Ik654PJc2PDBSA7vCd5F8OoWVITMxzCTdhZ6nRDIMPjbK8rj5yeN8rvNmb9gkJKKtHDE6EQ5SNeR5hZXe+ethDLvOkznoIVV2vjOp7oFaSFTNjLtBwzXvQT3Ct65UrCMajUov/88VXS3Ixg/eIH+brA5wv71mll/AYbshd9lIrkyxrsewE3c3ri2J5/5N/QnHOX0zIkL8EGaZQfZd7h3nO0yubqM+Q8x9CLyAjLqbEIP2dsyHPY4anlkcdgc1uH9hAlsA7v/7vBa8FF5IQuTzG3i0pdayLPM+nX3uMwvAfLgP3HEcykUsdlDkgRmu1uT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpWc569g+6QQUsadJtdIj7a2kDI6383GVFlHofhDxNo=;
 b=kqkLLx4Rbi3xRa5dG/+z4jgyayOYSASUkRqBiqVPDw/TI4T+YQtopwZc5OJIkLFvfJDuLxjKHFuvJ+9dxM/S0/7YUAEORucUsOrcRNX8dZQ5FfhnWRA7FsaSGNHg2ZPbwPhLGGF9GsaufVOx/hHXOxK6XQBth1DOqAEl3R63cQiRwfbGli2Zt0trXYY39ZL2aIIWCYYB3tbIEpvpq4QskfFOQn1DElrj0Nsxaycm/07vYrTe61JG0XiYfzlHU2uysTX/wycGpfLvbee9A1pH6wo0eXAAkkQj89WvGw8kDEuMLRWarVzBMpkejakQeKlFEtYsBGe8b/PUMburK+WOVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpWc569g+6QQUsadJtdIj7a2kDI6383GVFlHofhDxNo=;
 b=uoMZAlvJO21VyATb/VCzT8X9EotwuZtd0EMiyAjeyPLuD17u8FnWoOskzrKF9jkst+d6L1jlVRrE6C5heCUtBM6pQHdKnXwSjtuDiNLLZb0ijdgi4JUbbe57akOc1IGKURvik4gLLiMSuLm8yN9s0yWzv64mXIbq028/OjA2IYw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM5PR10MB1930.namprd10.prod.outlook.com (2603:10b6:3:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 02:11:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%6]) with mapi id 15.20.5061.026; Mon, 14 Mar 2022
 02:11:43 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: btrfs_dev_replace_finishing use fs_devices pointer
Date:   Mon, 14 Mar 2022 10:09:29 +0800
Message-Id: <98ecea7936c8b9abbc5a111942b2f95dc395bdb3.1647218125.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0158.apcprd06.prod.outlook.com
 (2603:1096:1:1e::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6406bd8a-3ff8-47ab-0649-08da055ffc2f
X-MS-TrafficTypeDiagnostic: DM5PR10MB1930:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1930F04A76A19D3C0652181BE50F9@DM5PR10MB1930.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2QxEnWnOHu713A+ZYzDKBhz+247MRDjiEbcDTGGrTGSIPhZSD9Cz0Q2VLL5DMGocH5RY+P6131jz7Izavbuxwddw3I/apSCV2bvyE+JuldNsFi6byjkPbOdFILT7yays4CPLIUnlgYav++EwrVnJXKtziJoYJ5oK0pU8Dt+RY2T/2BvY/daAnx7EoLlunJRlGSL54o6mcD2phRCfH4ynj3NBTvyQ3RkSiMbgI6tfLJby7i/d/P6jhVmds63ybBnuT077XvrtkTuEtYxucmihVmi3raCaQ6S1LJtwggioFc7sy+xoPYJsIP3RjpHB+nK5vBkchP3WufXHHpPUQNSWbHBb/IYtgzYRY8oGQz60gSvFOBh+H5JRYaT0fq7Q9LS1TdVR+SVMY7PANx45jHjn6QIWzUrpg9EahOmYH/FE2v+2Hx6+w7SHKn7ZIgvUCid7BqCRQzbHlfm9ZnhzbvfCwPbvz+RNzSMWONgAECq5YWsTRfx2V360bI5hsiC9DrAIGIlKrCG9EwQ3tA4dM5n5EHxucEbIBgnRJ2tGOX+uTjncTd8I+Zs3ucFCRj1np6pIcqTGoLiCAf8/J3woMiyYFmZMYLbH0fU2ee5Sv481VBhUhCJxEMeujqF/17fjBb5RyLpEPnrp6pVL0xAOpUP9vQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(8676002)(86362001)(66476007)(44832011)(66556008)(66946007)(6486002)(5660300002)(508600001)(316002)(6916009)(36756003)(83380400001)(2616005)(186003)(26005)(6512007)(2906002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1B91mU/8OeYDe1wxwWx5iTjRT7F+6cKflbUgOBjzj1kDCps1SRh9CSqJsOX?=
 =?us-ascii?Q?eHfOGPn+B2fwPGRccn+FlHKQbpD3eHe8WxGNOas4rFiIWNmzhX/VStOmXjdq?=
 =?us-ascii?Q?qEfmuhRuIKOwphDR8KuRU8TPWlc9I3FJjrMhgd+8dGopJxBdPlQY2xHQjpvQ?=
 =?us-ascii?Q?/uKfwsnuX4q+mjcIMdmy3rPO4Jp4VNBrs0n/baQyUvupptEASOfHhrxvSXUP?=
 =?us-ascii?Q?NmynxhPyL1D0yskeNK+741lBZ0eN3CFq7aiQw8ci+gChJ234j1r1FzRY41oP?=
 =?us-ascii?Q?J8rPsL0bC+/tgf1bamfkhCnnxSyEE+rzrOlPLhkeb9sHh8h+0pQM+BPJAec4?=
 =?us-ascii?Q?4WBD3Vt27jhliTZyGgsYe723Ufhn7GaJjC4Ua3FUUD33ozJEjbktZTqpS0aV?=
 =?us-ascii?Q?iV/2BYmOFmDnDxKkxhywztO0GVYvX2cP/1OtJBdRC1h5sezQ1UmBLvH3ieZn?=
 =?us-ascii?Q?TjMbA8oxjjQ0Nvdi9vfjx+QGU/wVoTrIO7v+BIXZ5SDtZzN8wL0+SuJFqdtJ?=
 =?us-ascii?Q?nDrXZKrH2BIBpYigNhkLwZotZdb5doX0ae2NSTiU1hUNp/mVyaSHfbgxlNyO?=
 =?us-ascii?Q?aY0LjzYHreCrhuO/Je9+jNf2XOKFrgVUvcWErCCiSc4FfN2mpiJq6v2Oz4P0?=
 =?us-ascii?Q?PpiEYug1Ca2dboKZDJdrre7mwy4wg1Ss06TjvQUU1gTt99+mKYn4vFcyVCAp?=
 =?us-ascii?Q?cuRfgxkztLbwB9pHkdCzhgCtQI1xeUbW3FGmUexlcLZdcpnQjaErlpujquk4?=
 =?us-ascii?Q?5ZBj9PXJdBpZN4SfCXqkFlEfW4svmNb+WTZ7lNAiBiiSjYmqxqU8ia6MvlzY?=
 =?us-ascii?Q?sP/TRF83QlEq8XsR30o26sUikcxV48AmIPs7csm+RT7YT9w0VyynPRCSLuo3?=
 =?us-ascii?Q?Kf6wK9dHnZgjLqksUVIjBw+adUzE7dp+G611NmmEO41ApGzS7CDivsCc19zA?=
 =?us-ascii?Q?tZWLGRn+wVY6av47gaDvzkVeiqxQXnDuW/0+CNi0kHxvN70oKXmOH4g7IOG5?=
 =?us-ascii?Q?MPqUbvFSMq4ZrRyQBiFZCnIJe05HFumIllcW/7OfWmPVxbRSTDWPE2fhw+do?=
 =?us-ascii?Q?tjtMKTg1YE2pcwwoBSffdldhvF0QVxINLTDF1HSXy3tzX/SvP16t8rCRWD2x?=
 =?us-ascii?Q?F+bLbR4SowbpiqQXSfWp1PPgvEgA6vyvRzgHP6Q6fa0bn44aDnmIEYoqcQje?=
 =?us-ascii?Q?Ffwt9SlNtwS2ou6E4nuILsnxzEU7qGLAa2Ym2yIqW92hIYJBOKM8JGsUKXgU?=
 =?us-ascii?Q?uRQkcOVDbCKNq/XCIMmYM66TN5tBZ/aWVAm3444s6rhhRFHeo2l36TMUg2Fd?=
 =?us-ascii?Q?OA205Db73uKNyIRAmscr3E2LuAgcpzi0eaWCa4soKp7HGpLLijeXvWMqjNbX?=
 =?us-ascii?Q?h8q2D5WnH91WgkQSBUNcxfj5BxULyraX56tAzvSnPuAGcrBv8n1/DYDMaEuo?=
 =?us-ascii?Q?B2pxm9pSmgEbpkN6EfsEiySzP7nDL23z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6406bd8a-3ff8-47ab-0649-08da055ffc2f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 02:11:43.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LeCQX2taZ9XlB7LK2dmutxAntGhEPgdUaBnyp/QALjcJETkYIN8RJ9GxBkB23WRWVoqm5cQ3NdvT0HGMXybrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1930
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10285 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140011
X-Proofpoint-GUID: 3-CxOMJWyU1bPRyymZ4zxAcZRRK9qYxc
X-Proofpoint-ORIG-GUID: 3-CxOMJWyU1bPRyymZ4zxAcZRRK9qYxc
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the function btrfs_dev_replace_finishing, we dereferenced
fs_info->fs_devices 6 times instead keep a pointer to the fs_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 71fd99b48283..dd8c03c13e22 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -876,6 +876,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				       int scrub_ret)
 {
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_device *tgt_device;
 	struct btrfs_device *src_device;
 	struct btrfs_root *root = fs_info->tree_root;
@@ -925,12 +926,12 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 		WARN_ON(ret);
 
 		/* Prevent write_all_supers() during the finishing procedure */
-		mutex_lock(&fs_info->fs_devices->device_list_mutex);
+		mutex_lock(&fs_devices->device_list_mutex);
 		/* Prevent new chunks being allocated on the source device */
 		mutex_lock(&fs_info->chunk_mutex);
 
 		if (!list_empty(&src_device->post_commit_list)) {
-			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+			mutex_unlock(&fs_devices->device_list_mutex);
 			mutex_unlock(&fs_info->chunk_mutex);
 		} else {
 			break;
@@ -967,7 +968,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 error:
 		up_write(&dev_replace->rwsem);
 		mutex_unlock(&fs_info->chunk_mutex);
-		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+		mutex_unlock(&fs_devices->device_list_mutex);
 		btrfs_rm_dev_replace_blocked(fs_info);
 		if (tgt_device)
 			btrfs_destroy_dev_replace_tgtdev(tgt_device);
@@ -996,8 +997,8 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 
 	btrfs_assign_next_active_device(src_device, tgt_device);
 
-	list_add(&tgt_device->dev_alloc_list, &fs_info->fs_devices->alloc_list);
-	fs_info->fs_devices->rw_devices++;
+	list_add(&tgt_device->dev_alloc_list, &fs_devices->alloc_list);
+	fs_devices->rw_devices++;
 
 	up_write(&dev_replace->rwsem);
 	btrfs_rm_dev_replace_blocked(fs_info);
@@ -1020,7 +1021,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	 * belong to this filesystem.
 	 */
 	mutex_unlock(&fs_info->chunk_mutex);
-	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	mutex_unlock(&fs_devices->device_list_mutex);
 
 	/* replace the sysfs entry */
 	btrfs_sysfs_remove_device(src_device);
-- 
2.33.1

