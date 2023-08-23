Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE276785B23
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbjHWOxO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjHWOxN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:53:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4885BE6C
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:53:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NDuQgo016098
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 14:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=3jOOoUIa7v/G7bKqOUGSR3N/cCpBS55iDEzrPPxg/YY=;
 b=wHlxunYRXxBwXbzggnf9eCK0TTk3rzsG/xVk/TU3PGpEYUZxg8tXW6THydb29514bDTl
 SYpI20e4XZc1fuLup9jTJQQM5MEQbKweuNom6VDHI3wJdNOM67E6YNX4a7s/jer6otCM
 oawjAqJfQi9p2q4XbYh/+EZIDh7dCptUeyPV1xdrlfPIOEbKkXvgBFDZaeBJEcLLkX31
 iVFxgn5DsCyITO/BOuLZamh19aeaggzIDOmaEtFYweBTeDidvhGODjI/caGTWkUHFSt0
 QSUwlT5K6HpdK+OJTe5hItKQsYBnk6pVV4KLztjbJkbw7fDfAyOMQAYfVTcdLbQpkkls Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20chy7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 14:53:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37NEGwjG005802
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 14:53:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yrx56n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 14:53:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUPsqves3adiSeyRRq9+T6TpjtgsIJqPF7sxnf7jjzG7UcqjuVVhU90Z0D5KQqbztbRkiHoi60srVwri3tMiS71KND4Cn5jMpgY4k5sbN00r4ko9aphnqgIwpg6ZhiVED/czS3maQy8V8hWzVzCiwgT87kqhb6AiBk/nBq1rsHpQPXvManQ2RXx9hCgD4diqcnk7ep5YKrr+TeWKHJLvLn5mURPnCDkYMGkCDshatat9XmtatgZZ0IWPoD8mifFfDw/xVEHJXlOPDMJrhRQzUPESBZmrGw0HzQgmKIHGjSuup1Y9I+dgXS9loYgmm87f6zh203uxf3Tn5evu8giGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jOOoUIa7v/G7bKqOUGSR3N/cCpBS55iDEzrPPxg/YY=;
 b=bBn+rOHj4RWNlvzuPDUfRJr7RjdF1ABVrUee3Q/bElb3e3U5GOPZMzDfWs05kVue8E+tTOD00gDuhHLcAg8YkHBVlOg1+pzrkU1KozFBXtDIXLFiQpTlbdTR82uN3Pp2D9dns10DYWdxFiu5F6AEoGt2v7EJWA2vmhRkcvmnD/9fblcoGWzX5N2l2BlkyTkHxra02FeG+2ehuV8JC9aHYHVs5c+XnNE4qG8YI5bt8TgESrytSRO3ZazMQJFw4x2oGgdTVBa/XHvA4uMT425TgT/GPBFpj32KzTARooaimH/HDfhQacQ0f1zVnCvTWBv4ufH9Y5gi3O2rjxkxznXQiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jOOoUIa7v/G7bKqOUGSR3N/cCpBS55iDEzrPPxg/YY=;
 b=jpoZjbxNY77oDRNvXAbrq3doZ5v0uJhXxhvvD19TX9SJ7nybQ2B7yjK7KpMIwkPvpZ+XO1vSpkSjJ086xoeYkK3CHofSVqL/BxjKezW/yt4ucu9HVKlW9fY6sPKdN7J6eg0j2TOdf0uS+yiBrJtdDDbIdCcXcUKO7Ojgo5afUHE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6648.namprd10.prod.outlook.com (2603:10b6:510:220::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 14:53:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:53:08 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH resend] btrfs: simplify alloc_fs_devices() remove arg2
Date:   Wed, 23 Aug 2023 22:52:13 +0800
Message-Id: <338a56ae484b9c91ccfb2d2d5dd710d5c363ebfa.1692082136.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::19)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c40a979-22d9-43e3-0fdf-08dba3e8a9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8g9ZbyGHwuQPOULUXLLcCks7NqObcW+d+SRv6NyTPSQ1dYb7CIPSNUJ5oOOqrk9vO5xHOdQkB/1SxBVllq2mRq7pxFFGYHIl470WYdniGoTnJYCcMfZ4l4OevpTnZCRZhzvVvhN7S6bopdyx2iqTHyrSdnY19sFXZWVkSSbJ0KXKU0AdzkTnpMe+BNB/xWYIcbcFq/1Tdz+wivrq1iOiOTt2o8ckGoHRxw5/2SahZcFZhf/1JQDwRk85YON8PKmV2jhnzHFLYZwW0f8sGebbWDm+NSLNj/M+P5sbxTv46HJu757JrjXXwPHjqRHRpaZGvyZkaM/v0UAqj9IrAs7Sqh2o9sV0qeng3EPYVVzecIO3d0559YNSLC4F9XE7czewLadKxTqzInCD4cF7mQI/hgxsXVRLuhZ6dxZbez4gLUCjfue34LAGPIP2Qu2YnG5zgF+ILrUlko+tpRPgKW/YPTkpRkpmZH+scp39A4KrKhhTn9JqfXyRxXyGNdDFGIJCycNMNnO6pPqZSRqVcQYnIWrc5aYXF9EE8r6rBwkSHc7nwLJF53r64l0m17tVGWD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(1800799009)(451199024)(186009)(107886003)(41300700001)(6486002)(6666004)(66946007)(6506007)(66476007)(6916009)(316002)(66556008)(2906002)(4326008)(38100700002)(26005)(8936002)(8676002)(2616005)(6512007)(5660300002)(44832011)(83380400001)(86362001)(36756003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a/1HD8maho3oWI8EBc36CJulnTL8kizaM9cE3Ch6o1q3j4SFk6tF8hNSwi+9?=
 =?us-ascii?Q?w7WtqDUnhsGIj7dwTE4WMi5xE+48cy5aYYr2sn3zSlDCScj5zHE9ES/R1HmB?=
 =?us-ascii?Q?qzLffsYQgdDu/oEpEJY8sAjP1ggpmFkqCBCCnAvbPUVM4Qf+y9KqldH1LUxz?=
 =?us-ascii?Q?zqaoeXWIkE57oOUVn69aSwCOuZxSQdD9Ck95g8RAnLA85ofLjn5/c5yZ667s?=
 =?us-ascii?Q?8k5g9DtwGywSWmkDOSJy1Ei9szj2b/N5URbY5kWwUHCPTZFBf9smQEfGN/pV?=
 =?us-ascii?Q?l4zLhBxgs2HNzRJmOqGA0B1BAx6AWZDgyStzgIpYnVKXFYY0SJJPNllPG4/q?=
 =?us-ascii?Q?i3Re1RlAbwL9isYAgmz57M5v9P/WVNrKY1I8StiymtUOPTvVde9gLYMKOWeb?=
 =?us-ascii?Q?+Sqo7Oegv+DKzmBzuo9f9WJBy65bwjITHOaSUpyuLZgw83/PP+L4TxB7yK/G?=
 =?us-ascii?Q?Ergcbh5ldJbkYsb9o803qegADl/xhInMHZpdbwg0lWjZdfkXkFAs+sbj7B3c?=
 =?us-ascii?Q?yNcVDRh0VBfhtzTfnw3dxK7xfoo7BzArkZ/o7F7E67BcgRliWdrXs0FLRINB?=
 =?us-ascii?Q?DomBYXQ1fqLC5tvtIRaZJ+Rgi0JFz3XzMKUAPqCYuHsOHhJjLmjqi/snmuOG?=
 =?us-ascii?Q?RkgmMsCnMuaLhZ2U/Qkmt9tBqiPcK62LEQYWRuEz0wIFSRLJQPPADXM65d7B?=
 =?us-ascii?Q?EwFLU3njh2Q9D+FI9zb3zvTrxvzZKB7JyNByY2yigRPuy0vcof3lfwLtqAVi?=
 =?us-ascii?Q?s8fOhcu1xwal7hYiXoNcd+3fZuFtyRxzdxlAdW7n1tBHUk2DINy60ccHt9vv?=
 =?us-ascii?Q?wS+bZzn33IQbtMbcV5j03WxLCk4Zh7Otjhow5yhbuoV3QMYOPEX4A1vEXD4S?=
 =?us-ascii?Q?IznjaTK49gvUVeSM+KUsAQ3Z0+PinPIxWfXJD8l8P1Hjr+PqLefEn5OJAhHd?=
 =?us-ascii?Q?GFA0qQebJ2oTkrRk1o6wPDw9gtXc0jmY/+ZgVfNtBoCFxaO0f1ls3Ewc6xbQ?=
 =?us-ascii?Q?393zHYIKKWAd7lqORjNvgMKFSGtEPjF6XGo00m6LJBxo0SXeQ5WdDFpGCN2C?=
 =?us-ascii?Q?hkf0zedpa5NgtEpPNBIcgZGmAFvo9DlKDAisJXffhpZrMIo73XQk9aKxKDpT?=
 =?us-ascii?Q?cxddKCOC2o5fUQDzC+sV0MdIqw3PjFUOUYWK8VZ8bUbNsFOdmkm7m7caGTR9?=
 =?us-ascii?Q?DrDUMxyDREFp+Fv2idWH8Njtj2Qsf+dh2eRi4iG9AZb94VpU1lcZnUzn5Ah/?=
 =?us-ascii?Q?6dYN6ps2mnhc7FC5gL2u/awtWpNJmO041yi+Ir4VaXPVPi1BDSVyOpttx7jp?=
 =?us-ascii?Q?nX0Im0dRivC8nBeA+o3waZLi43Scr/PstWrX+kS2PMVylcdkgnwbbP3BLjXK?=
 =?us-ascii?Q?e6E2Pzw356BX7q02Yik+sfw+D7deszpmLOryB+pNBVRaUNoNMmy/YJG23yo0?=
 =?us-ascii?Q?ENBwJZkrZJNGypqgD1ibX9vwiHpnzUV7mFsytDeWw8zYAhfek3iXenj7jQxA?=
 =?us-ascii?Q?FDNXKtEAEpyyouoZDnt5dO3JqDlLfmH61AvLkj7oUJ1mcl6i58naLVzN4Wti?=
 =?us-ascii?Q?8VWwzSfqz7n144eM+1zeR45RzqKuQfRzexGTsHVXPJ2J4eIQknkloZDnFDnH?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YxF4SH33Ehgw9m0XdbhsCMKMdnOXO7THnxrPErP0SANBChEVc3ML0OSsjnGSPQmsKzbqGTkXWLcii+BUBVwIJ04b5Sc/PmnHy9nIqKyiMYu/9VI+wI6FExuIJvCfrijs33wRTov+uFmqrb1r1XDs4dYiUUGhcsWSsxda6XUpB33PNajvUgAd06OQFrTDvYMC8qJA0Y8FBUEtEY13Bn0hxpYn5OAgYOnapcLyjD8Whmzlk9SpIEO+LkTUYjp+k174RSLgyl8kZWmTDkGwKqw7OV8L9enEukw340fAKKsBRPazEQVTE5Pa5EAeBjZC3HhaBGuwS2XGKDWQ3HMb2FXa7erb32lyHDPPn9pd+lp3fiwVImT/2ENHTyfNI7tzAUk7IJn8Q2PIPrQU0pZXTLpxen4ujTEDK4phM/f6DjUVHOUgk834fgIizFD07t7Ro7ZqUpZ/iiUeCAgpcFCqxKKrOdLe1i5YY7ntG3cIHos9Hdt3/ZYG8ndm1kj0qkKr1QcbNGLx7d5cBGsV4vZmzHKsmtUEMD48y1srjRcvf2oUoUXou/VvaEGzUScXaC78yxU2ktDO0H4BlPbUb4Dwls8iEVkBC20fQhWgQqMDnFetPqwo+tKzIpP61xmeqCWrDNpMlDaoib3CFdd1EALWPFY9BEfHVkMPUMH8ueXDiqnzbfplCX+Fhn/eFKmvpz8uhWY65UTffs4xVAPMR7DzZSPPUtGBCuTDZ02wMCI9flgykC28vmMKWEaGTj379kB0E3Fbdq/Li2WGPY861jbqU/s3vQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c40a979-22d9-43e3-0fdf-08dba3e8a9ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:53:08.5257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hg8nYWGJtTI3YsP0Sj3stcPQ3C7CDnIG7eLREN1w36v2aO61M5a2ySoq9A5ehXPwtv0NPAWwh8IYe7+Bb4ZCPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230135
X-Proofpoint-ORIG-GUID: a5ad7l7SfiiYjMxYWWR_eWLJRwuZFQCu
X-Proofpoint-GUID: a5ad7l7SfiiYjMxYWWR_eWLJRwuZFQCu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Among all the callers, only the device_list_add() function uses the
second argument of alloc_fs_devices(). It passes metadata_uuid when
available; otherwise, it passes NULL. And in turn, alloc_fs_devices()
is designed to copy either metadata_uuid or fsid into
fs_devices::metadata_uuid.

So eliminate the second argument in alloc_fs_devices(), and copy the
fsid alway. In the caller device_list_add() function, we will overwrite
it with metadata_uuid when it is available.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c |  7 ++++---
 fs/btrfs/volumes.c | 25 ++++++++++++-------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0a96ea8c1d3a..9858c77b99e6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -318,9 +318,10 @@ static bool check_tree_block_fsid(struct extent_buffer *eb)
 			   BTRFS_FSID_SIZE);
 
 	/*
-	 * alloc_fs_devices() copies the fsid into metadata_uuid if the
-	 * metadata_uuid is unset in the superblock, including for a seed device.
-	 * So, we can use fs_devices->metadata_uuid.
+	 * alloc_fsid_devices() copies the fsid into fs_devices::metadata_uuid.
+	 * This is then overwritten by metadata_uuid if it is present in the
+	 * device_list_add(). The same true for a seed device as well. So use of
+	 * fs_devices::metadata_uuid is appropriate here.
 	 */
 	if (memcmp(fsid, fs_info->fs_devices->metadata_uuid, BTRFS_FSID_SIZE) == 0)
 		return false;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 189da583bb67..852590e06d76 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -358,20 +358,17 @@ struct list_head * __attribute_const__ btrfs_get_fs_uuids(void)
 
 /*
  * alloc_fs_devices - allocate struct btrfs_fs_devices
- * @fsid:		if not NULL, copy the UUID to fs_devices::fsid
- * @metadata_fsid:	if not NULL, copy the UUID to fs_devices::metadata_fsid
+ * @fsid:		if not NULL, copy the UUID to fs_devices::fsid and to
+ * 			fs_devices::metadata_fsid
  *
  * Return a pointer to a new struct btrfs_fs_devices on success, or ERR_PTR().
  * The returned struct is not linked onto any lists and can be destroyed with
  * kfree() right away.
  */
-static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
-						 const u8 *metadata_fsid)
+static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid)
 {
 	struct btrfs_fs_devices *fs_devs;
 
-	ASSERT(fsid || !metadata_fsid);
-
 	fs_devs = kzalloc(sizeof(*fs_devs), GFP_KERNEL);
 	if (!fs_devs)
 		return ERR_PTR(-ENOMEM);
@@ -385,8 +382,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 
 	if (fsid) {
 		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
-		memcpy(fs_devs->metadata_uuid,
-		       metadata_fsid ?: fsid, BTRFS_FSID_SIZE);
+		memcpy(fs_devs->metadata_uuid, fsid, BTRFS_FSID_SIZE);
 	}
 
 	return fs_devs;
@@ -812,8 +808,11 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 
 	if (!fs_devices) {
-		fs_devices = alloc_fs_devices(disk_super->fsid,
-				has_metadata_uuid ? disk_super->metadata_uuid : NULL);
+		fs_devices = alloc_fs_devices(disk_super->fsid);
+		if (has_metadata_uuid)
+			memcpy(fs_devices->metadata_uuid,
+			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
+
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
@@ -997,7 +996,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 
 	lockdep_assert_held(&uuid_mutex);
 
-	fs_devices = alloc_fs_devices(orig->fsid, NULL);
+	fs_devices = alloc_fs_devices(orig->fsid);
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
@@ -2454,7 +2453,7 @@ static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
 	 * Private copy of the seed devices, anchored at
 	 * fs_info->fs_devices->seed_list
 	 */
-	seed_devices = alloc_fs_devices(NULL, NULL);
+	seed_devices = alloc_fs_devices(NULL);
 	if (IS_ERR(seed_devices))
 		return seed_devices;
 
@@ -6905,7 +6904,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 		if (!btrfs_test_opt(fs_info, DEGRADED))
 			return ERR_PTR(-ENOENT);
 
-		fs_devices = alloc_fs_devices(fsid, NULL);
+		fs_devices = alloc_fs_devices(fsid);
 		if (IS_ERR(fs_devices))
 			return fs_devices;
 
-- 
2.38.1

