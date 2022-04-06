Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323B44F659C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 18:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbiDFQkL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 12:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238033AbiDFQjx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 12:39:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651CF338E32
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 06:58:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236BTufQ012558;
        Wed, 6 Apr 2022 13:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=+1Z4rqk80/EBHAyVvv+POT3Xxg1AJz0GicTzZA9Ms64=;
 b=zZtqxI1nBnG2gMX1yyzIf8pBImHA4y3WqeV6YiT0aikJciPhJcvYtbqNsuK3iW3O25+D
 o8yCMnrRrkx5gGJrUHLOZNi+7QNkEhfWcH8cIPvXLS+vzUL6UINu+gWK2fOxh8aIr88n
 2uPUoDvUpw4GaevGZ1Y/QeOr6fY0Y93vBQQFRezcpQsEx2JaNOOXsi7N+0mG5mQDXst3
 d3qn75/tgqLFKwdmGbE8MgVKIvBNrHGLGzdqAC9eYR2HR5vP1bFqeTl1GcECN1LJncUB
 aNBc6ewElgMAPwvCHoWDVr+eMkjWy4GVB92KSSfHkOsEv9nLeNChK7tpIkF5wt0NMKkO 0g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcgsg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 13:58:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236DuVm6029093;
        Wed, 6 Apr 2022 13:58:23 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f9802tfwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 13:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcQnkAxC9h8e6hc/cE8Vyyld10szCWtfNgeGC2JA2bHo0YOnFI9VdrC9LOvHby3XyrT3RWgOkAICA93cKLrno+MC/OVHn207uwLsT71bEYUM9wYZLQWnmPNrJQd1VOXaDCUO5i4k6ISPsyvQDXO1QcmLkw2fpntORBo5HcGZTZ9gmCmEoMfN1b0wI5XtSXcxy/2Oalt6CGZu+VbVtQ+8DoQo+F2wz0OCvvDeFpke0cG6gN3KdPWrjjcVWFfvWEEEPiSIUTVo0+6E2/E6BO8RTRyiD/rHKkeNvufp8B3Sngs4Z7tkLEZjmxLP+ChNYEkwPyHN1lVJDp14neoEVZuRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1Z4rqk80/EBHAyVvv+POT3Xxg1AJz0GicTzZA9Ms64=;
 b=RcP0hjgDyKNtW9em2WJVii6KVkWhgBlWIDDOd7TluiXj4m/scAbmE+p53R8Pl58pg8uTGwLRPDWTsMYXRk6ivLC6GdN631uylEHyAY2P08wAikTjjb2HBIc5Bx6f6Oj8IbvP8hgEXqy9bE3C2oS8qaU9Jv/eu6X6qqt2xN00Mp80nhWMS+VzAqR6YgGjWwRxYU3/ppRuRSqevfe5U5m1EWcVXmRgOCTU3LwMNp9F4n4717jicRH/Z4oFmp/nZBA0YLcVSuaKd8BL2RAHsNJONuTduLWunBwIDSEWat2LI6G86wBB76AGW1FwgbTtDlKzAzmUVvG09sybRIb8HJAiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1Z4rqk80/EBHAyVvv+POT3Xxg1AJz0GicTzZA9Ms64=;
 b=uImikg0TTLWTLssTVf3GHLchHHYFtbme6qd3GZYnkWHhkFFSJr/wYYgD1QCbzujXg0c6RAGbcmNKLSPUoVC1if6yjTJuiNxQBBvS8rfvE/QzYpn9gkwIjO285XJoDXzZZzLPgYyI7n1b9Hb8wrMQnSf6tnUY2lngZejdJQgESMc=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by PH0PR10MB4711.namprd10.prod.outlook.com (2603:10b6:510:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 13:58:22 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::e830:3ab7:8db9:593c]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::e830:3ab7:8db9:593c%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 13:58:22 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 3/3] btrfs: set BTRFS_FS_OPEN flag for both rdonly and rw
Date:   Wed,  6 Apr 2022 21:57:48 +0800
Message-Id: <1009996d395610ee3e04269d24ad83734c74140c.1649252277.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1649252277.git.anand.jain@oracle.com>
References: <cover.1649252277.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 516053ef-082a-4ed1-232d-08da17d582f2
X-MS-TrafficTypeDiagnostic: PH0PR10MB4711:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4711C13508C56C1FEF21992FE5E79@PH0PR10MB4711.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOFaQyYAG1wTiDVpsn2TKFZ76IHkvqMdqbFqbZsDqd9aLNcTqiQuh34PGlucpu11P7L9ZXnRGt5gCTgtghjEx4lO5tMoO5SCu8x8tOyesWGN0MuAou7b3LbFWarlq8HZOIYu6fNQfHHyDFhZ2MzCM5kDreA42BIE3Wgv19i4KRY7L11OYH+Wz4aUX+Yk4lDNAS0TdHGZOIJuiy041f1jG2PN2fQbgGAB1UaBTyq5/8DeHaX5YX4rzHmDzpZyc5HRNhNQyEpKLLLUlK4tnX1MtVPrwG5ENe6o/Z5wISmkrBvhhQRWxq2RnP4Gt2O2aJJnWB4XxMyPvUDc+tVkrnVlTEvBAa6X3ArNy4/UsoVUAg0x9nbNyDAuXVnwwb7ClJ/MrqKaN18DycRGcoFweOldZG243xwipXylMgYGLvNjvW2xW8440BwYmkrM0fk+xDqGh1ayYAgJcfZD5gqJKJcw9vqH9WhLxp1Kif9emovPxGEoSQBXKF3fE/WC40XmDhXD5OIDELJVMEhkEJq/PsVxoNrWiAgelvkrvjuVBfXrNo8oPjMygS6rdbl2+5nHdnX+InKupd/4L46vz5Y8+AcTIv/NNEqUobUEKm2/wmjcujmXKGSsyVR9RFqjfdefN8E0MS3jMrZURmZOGoV8DLhQaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38100700002)(6486002)(83380400001)(6512007)(6506007)(5660300002)(36756003)(44832011)(316002)(8676002)(2616005)(8936002)(4326008)(86362001)(66946007)(66556008)(66476007)(6916009)(186003)(6666004)(508600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YyPOW5VTd4MJw9oYVdynXkD+GlHpbETfinRFJtFPWtnqpHRlHrECW7TiOYtf?=
 =?us-ascii?Q?xzR6WK7hHAujK/P7ntjpxw0SbVtSv1oO/NfIGtU/Kth1HxqTKZI4E6jHb+2S?=
 =?us-ascii?Q?HoCtMo6NG//vO8nJXH63mSqaP02qqOsTUVQXwQBkJLlAm4HPloUJkRO1fvDW?=
 =?us-ascii?Q?xCO9y68PmGWCIQBswu12e40bIRfVrXqOsGMtRGm2eK9A4HlKwXvm/vK005g2?=
 =?us-ascii?Q?xiH3a8Pg3CZoRIw7xPSpnolSqd1K86Bdp+XlHMxrYD1qHYA/O2HkIkRLj353?=
 =?us-ascii?Q?yo4UyNuseas+djUHCUKEW0OdIBHGpuRtoyXMoZ2L1H2Mj0pm/7zOV+4bm2OP?=
 =?us-ascii?Q?Qo2cji1SuAopCbEczRuudUtVkHxELh8tXo/wRV/rImRU3+8DyY8+zHSvKUDy?=
 =?us-ascii?Q?fgzObXRcDouUHlvwR0a1/mphE4c8/Nj2iTNtob/EyCLbEBWjMEpMax56wkBX?=
 =?us-ascii?Q?QW3aZDhK8gorwxJoU4XTFIRih64/KGukHtNaswz39AwSYVZTMKJuKk8lgiCS?=
 =?us-ascii?Q?rBMe9jNvCSQDGl3QyyGdTsri+CXCpRlOT7WugA1uK0OHrREDiPjYODl3qd8G?=
 =?us-ascii?Q?PcrIa8OjAK4grWC9RDrTvpcgcEfLPDGH8DSoS7vjH8cYScHfXsHSwP+drTtL?=
 =?us-ascii?Q?z/n/qAoT/g8N6rcEF/M5AS002B4tO811ui0l+k+D7nW+YCCCzMUSeSiM7c23?=
 =?us-ascii?Q?mAxCB9/UOKo62Z4n5Dwh77xiLKCKxpiwRNQv7E9krWRjTvqCbtZRPviDX8Kw?=
 =?us-ascii?Q?utN2TmVLqCk/9m9K7l6UoY9A8RspkFu9hJJZuKZylLtg1QwI3qx8/PnJCY+R?=
 =?us-ascii?Q?MXWd/64YBF47WnhqZGXZ7ejVD1qhvA5x8o/niIp4QWoyh93wKrJvGHYrFIp2?=
 =?us-ascii?Q?aVCzLdFxl2dqET3BCay50IK/4BUIaw6QPY9sjlejnr+iUnX3rYnd7phlHxE4?=
 =?us-ascii?Q?SJ9zMuMVKuwS1Ds3wS0tDzb5Tw0fe0Jn01Re/HxfCV0AmoIekXrwlejkBjqw?=
 =?us-ascii?Q?GDFzCzCRlQ4fuf8iMKKZk7VnIaZc8NsJYFLL54dQAGkLSVqOzFjpXHkrCJ02?=
 =?us-ascii?Q?GkYDaeDXQ3PrZOL57PniCoX80sAK8HgsNMwd3ML+57OFxABVCQOhABf+do89?=
 =?us-ascii?Q?GjxosObcq/tV40Ymq5DjZbs9dhBERAGsdjrP2O1G207W59XWZJa+2OpDk1pH?=
 =?us-ascii?Q?SaRo1DslZqYloMnrti/8yP0nf8twbnPCBzHnXHDaO+YMb0wLadgLnr5wKzRW?=
 =?us-ascii?Q?v/98k4MF2IzvzHxVHY7rRsAOYe983tkO3Y1S7ndozR5J2A6l4ty55E7128jb?=
 =?us-ascii?Q?7qs4mTY4xJOaPakx+WVb6N3EMUOuaDTc+YSC2XseVCH0dGxHikQQffVa39BU?=
 =?us-ascii?Q?BUibZuRlywcrt+Qflf7lXA3GWtj+St1FS86kN7HDjxq1tlO59Ui9SAhWDPng?=
 =?us-ascii?Q?jBkWqkheRas2BLs6WL5xlatMng45M94kaSF5JsNTcJppBn/+76Jcvf86Htn1?=
 =?us-ascii?Q?KPulJPXvhaEj3rgz5L1nFgew5vHshLJxeX92jBLdJDic5qG6Z8o0stIkpuXm?=
 =?us-ascii?Q?49Y7CzX7hvBNi1yZWPy+BNAanbrqU11bSRK810DhYiOQQXa6edCLhbWF2zNN?=
 =?us-ascii?Q?t70DmPzPHCcuwxL4PUlgAj4uDcccS7RkJ1CAMazRkwQSM5Fx06lBpgna+P1p?=
 =?us-ascii?Q?hYbvZlelXqcDIrKwhnn+DUjHN62MJ3juvZ1cM8+59rULhXJoYrYcO5UY9TGQ?=
 =?us-ascii?Q?6ObpPQCfCg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516053ef-082a-4ed1-232d-08da17d582f2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 13:58:22.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: es7AlBjrkyqgZNKBOYtS3fhtZEzZyeHYqjCNcVWjBJ5Y+uMXuHpO2sI8oSKEQBw1e4QrmCKpctx31T0YuFWYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4711
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_05:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060068
X-Proofpoint-ORIG-GUID: -W0i5Ac_GZlWICOYRRH1T_AuqBpB86XW
X-Proofpoint-GUID: -W0i5Ac_GZlWICOYRRH1T_AuqBpB86XW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It is good to have the BTRFS_FS_OPEN flag set irrespective of rdonly or rw
mount. Setting the BTRFS_FS_OPEN  flag only for the rw-mount does not make
sense as it lessens its utility. Besides, we have the BTRFS_FS_STATE_RO
state for mount type rdonly or rw-able.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ctree.h   |  3 ++-
 fs/btrfs/disk-io.c | 39 ++++++++++++++++++++-------------------
 fs/btrfs/super.c   |  2 --
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9d21f4b9d3dd..092efa9392e5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -4028,7 +4028,8 @@ static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 
 static inline bool btrfs_fs_state_is_open_rw(const struct btrfs_fs_info *fs_info)
 {
-	return test_bit(BTRFS_FS_OPEN, &fs_info->flags);
+	return test_bit(BTRFS_FS_OPEN, &fs_info->flags) &&
+	       !btrfs_fs_is_rdonly(fs_info);
 }
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1f9613d733ab..0624f9636497 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3906,36 +3906,37 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_qgroup;
 	}
 
-	if (btrfs_fs_is_rdonly(fs_info))
-		goto clear_oneshot;
-
-	ret = btrfs_start_pre_rw_mount(fs_info);
-	if (ret) {
-		close_ctree(fs_info);
-		return ret;
-	}
-	btrfs_discard_resume(fs_info);
-
-	if (fs_info->uuid_root &&
-	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
-	     fs_info->generation != btrfs_super_uuid_tree_generation(disk_super))) {
-		btrfs_info(fs_info, "checking UUID tree");
-		ret = btrfs_check_uuid_tree(fs_info);
+	if (!btrfs_fs_is_rdonly(fs_info)) {
+		ret = btrfs_start_pre_rw_mount(fs_info);
 		if (ret) {
-			btrfs_warn(fs_info,
-				"failed to check the UUID tree: %d", ret);
 			close_ctree(fs_info);
 			return ret;
 		}
+		btrfs_discard_resume(fs_info);
+
+		if (fs_info->uuid_root &&
+		    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
+		     fs_info->generation !=
+		     btrfs_super_uuid_tree_generation(disk_super))) {
+			btrfs_info(fs_info, "checking UUID tree");
+			ret = btrfs_check_uuid_tree(fs_info);
+			if (ret) {
+				btrfs_warn(fs_info,
+				"failed to check the UUID tree: %d", ret);
+				close_ctree(fs_info);
+				return ret;
+			}
+		}
 	}
 
+	/* set open-ed flag for both rdonly and rw mounts */
 	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 
 	/* Kick the cleaner thread so it'll start deleting snapshots. */
-	if (test_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags))
+	if (test_bit(BTRFS_FS_UNFINISHED_DROPS, &fs_info->flags) &&
+	    !btrfs_fs_is_rdonly(fs_info))
 		wake_up_process(fs_info->cleaner_kthread);
 
-clear_oneshot:
 	btrfs_clear_oneshot_options(fs_info);
 	return 0;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 0df155f88c14..ad38303a7803 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2111,8 +2111,6 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 			goto restore;
 
 		btrfs_clear_sb_rdonly(sb);
-
-		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	}
 out:
 	/*
-- 
2.33.1

