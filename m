Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53FA4F65B6
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 18:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbiDFQjx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiDFQjp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 12:39:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BB6BABB4
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 06:58:12 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236DROb3000758;
        Wed, 6 Apr 2022 13:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=clbx9pgi7J89+t28p19fmOKLd/f8CjHmpfmjVu+DoDA=;
 b=i3Dglp4a8D3nU0TN9aT78sOv/5NWDe8MBgsdmnNTKNYEpz6pzTBdIAL3p+M1IuCNePfH
 cqlyeana0bf7x9dAcqWvhFQ0bgxTpcoQ3BZphAdH9F+qVaNbBix+7HBQyqg9k8e0Q5Fw
 SYsCaen0F8Nuoh4LFitWZCOkk9bNhYINhXRqddSk4UM3MwUMeezD9pDw6eEE4V0+j/7f
 5pIEQQZLNFyi1AFUvUNUT+z5FnndpXjaLcvp65Y/tbvQVim5d5rqdANyGhHxttEM2hwh
 rRkcPwQ45pmFxmNOK8miMfLPkr3pFVMaPU0Yu21ZGdcVsQP3nOH1YM5jk1sJK7bhW4k+ Kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3srxmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 13:58:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236DtMVq010448;
        Wed, 6 Apr 2022 13:58:08 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f97uvjwwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 13:58:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXDxO6e8xZexvdyxR+9Z5C+nVIp/mcWECInl+xsHxpJbjAd8b/vvXr/kLcDjDnhsuXBtNvPzQlBaBp4hgoaaESp307FPgdOEBiaydph+aOb0Si/XeaIujUA1u8AIv8oIxUbwbkckzPx8Nvb8uwKYir/H6dVxfJjgmzu3Q4czumHVKagVDYGm33RUc5jSwwcYL7Ps0+ga5MF0egWVYFA+wKNvp0+iel7VGuXcQrBI13roAIv5HiErdxu4KLXNlS1J3ATM2ake/NEc3xQK9FhWjKEui5hegj34fe91LRUJ1LRliUA7uH92fCWYA4KzmVlB2ZbBbQUWOS9lXxRG/T9QHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clbx9pgi7J89+t28p19fmOKLd/f8CjHmpfmjVu+DoDA=;
 b=MRqkDp+/hXVtqxv6kIaAS+NVi5cjnXvVCzBs0kM0Q0bn00Oh2P2cg7NalIESDtkHQS/Q//Oyp9ZOiw91nYnVPH/M3znS2QzikAwfc1tj8S2AMGVHb8n0KNIfESbotmFdMutdwrXRFXKe9+mjJb9XqVpSc31JZ3uUqfgO+VvO2v/5RlRiRMBJxT0xYFugwzLvSMwMf6BrtR0MSmWPNt6cSbP5ZANmc2W6oiDynRO9oksNHpYGEwoMzHqCwaozVvg80xWh05S1Kk6H1T06ZoHzbv8QppW0DNQVtjsac9Z9GoX2yABHztCqk+XvcGb242zs9MphfQ7phv4JBDD9em7XbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clbx9pgi7J89+t28p19fmOKLd/f8CjHmpfmjVu+DoDA=;
 b=MURxorWyxf8QXd49xhvrNIqOu1B6mdWM7BPefHAZvhoal359wzO2OLV9uNNDBPYKV0AAUNsoZ1eAw9Iu8cltHmBttiCgGnNvPWTjEUGJmwJ2dBwO2JuL9cLQ0mwzGG6jYnoA8ylnvC1cZY4cnqRLUrf49Adihgk2uFD0MTYDCBc=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by PH0PR10MB4711.namprd10.prod.outlook.com (2603:10b6:510:3c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 13:58:06 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::e830:3ab7:8db9:593c]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::e830:3ab7:8db9:593c%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 13:58:06 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 1/3 RFC] btrfs: wrap rdonly check into btrfs_fs_is_rdonly
Date:   Wed,  6 Apr 2022 21:57:46 +0800
Message-Id: <5e71eeec9e5317d2c2b54ec5f04e72a348c89c23.1649252277.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1649252277.git.anand.jain@oracle.com>
References: <cover.1649252277.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0092.apcprd03.prod.outlook.com
 (2603:1096:4:7c::20) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3008cb3-7ff7-4b2f-ea30-08da17d57997
X-MS-TrafficTypeDiagnostic: PH0PR10MB4711:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB471129CDCFB432A7D83EC98EE5E79@PH0PR10MB4711.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvuU1MMwflAo02DSqstznkFNRnaZO7kS5fkSGDaBSkdvqHvHa8Rx0U1AffOXKdkEbSvgGQOQOL8PQjqiJjcRuo6jM6Zcw5nbw7fynhuecAL7XYLPexp2p6gL2/j9ZBVYzbGa5RH4ZKQifE/YBTBm39FHkymS0LxZvUKr0KOE2uyxMnebRSkTvmoyO2MSTSSnLKZEWkj5sYn1nurhqFA6ps/ypmUV/b8jQ0N7fII/6rkOyd/yFQjSS4UOBvvfqB0TsubOom6h59t7RFDqF6VS7IXqAkJchsC2YAbJ+9qljKC4gkuZ3ok4NimqXo894HQoAIxC3tXfmx0g6LiMvNVTihuApbgJenDRgBKxnRiGKr+UiyqWZB3VyCT2bM27TUiBClQD5dzMEbkZJ8yCYpvDdTFfeTOaCFm+dF78DcYzhYNdmw88pw4wslpVbsXGNj0V1kaVNL/behlm3FfvTukkmUMHGQPonfaJN7M7U4s9fMIEHctp/V+PJWtoXz0VRlfvVPutRiALa09LBq4rThD6NLIFkUyYtT1Z2ttKKbjVsWRKVnl42eXal+cpmr6L71rqWEjcJemSVZFxUvRUPfYOfaNBnPDpZZQbTJxS9zugtaOSAQdMi/dcT5UV6nBbMS+408F3gFIc2SveuzM6ihw5sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38100700002)(6486002)(83380400001)(6512007)(6506007)(5660300002)(36756003)(44832011)(316002)(8676002)(2616005)(8936002)(4326008)(86362001)(66946007)(66556008)(66476007)(6916009)(186003)(6666004)(508600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i5i0FSmAwNGZMCLcwJ4sE4HrlnViWqX/KAyZLS8vG7+RxnvSwntP8Ovfd+f1?=
 =?us-ascii?Q?cKTZ4lDOvsECY4IygIfWhdfxG/+TlGzWDc/nGWfHEW8FUuF9F1mBu1NOD/Z/?=
 =?us-ascii?Q?iPQhVWU8b+wXgGTvZ49dw8EQapuQZqDJUxfSJnSl4d1zpZuk5dLXH1DHpHh8?=
 =?us-ascii?Q?HHqDv3/C20YbMgLERfgPS430OiugYR2Vt7xCY4smCH+pbtxd878OkY/Vs3W/?=
 =?us-ascii?Q?zfCaMp7umiGuXC/0pKalZc/YSC1V8q1n1SjnkdVjkQc9+mnpBmdSvReolxaf?=
 =?us-ascii?Q?xPXQ5Ix+HSxJ0bF4KJEF5hM11tOxqKpg9IP075RXp50ArZYP2Rb0fm44TK9m?=
 =?us-ascii?Q?p9t2QzqsNeTNjj3SMFh/BLLywBS5TK22608dPFMo88noFHziFn1dzBlBhcHa?=
 =?us-ascii?Q?J690WQwekBLuGfggBoBuBa7gMGGN0xVIogqlOJNGQ+oWqYGLWsa5w6KU9q4p?=
 =?us-ascii?Q?eD9ZCXNDnbrILk5ruZny0O5KHKDttbA53oI1lsxlROvb2KHwtCGOareHWTgt?=
 =?us-ascii?Q?BLHSNrCF78rvzuE+oJZwrr50VGujyyFFjc+QgW6Gabllpp/bIqdvDJ6MHqJC?=
 =?us-ascii?Q?2ssdFhth1GwCf3y/a3Q2BOvNzJ8Nkl8Fs5BT8U9e+QiKQdJzEtnigtQoSyZW?=
 =?us-ascii?Q?xeCjeW6pWH4aJC1qZGtRjPPuS/N2P4Kh7wTa2gLAYqyMC6/SEev+amvpPZmC?=
 =?us-ascii?Q?Q3XBcHoPokJOLSinH7VniJJ7dUgV3smZEl1ClcvhX1uGJr6WGg3/cfKnq+KL?=
 =?us-ascii?Q?kW1LxrwCYfwTrwxPU4TT6hdyp0FDXQdEhpX5Skxv5Yu9fPI/dX+VQnvghS5d?=
 =?us-ascii?Q?HcNLS65AYhB1Fve2peT+CTHPjMGetSj7UI1u2GmmvRPC9aae3uyWmX/BAg9c?=
 =?us-ascii?Q?mn2Lo0ltCI/t3rLi6xZfKAbjRxgIJunnFtWeSACS7HeXVr2heEyXqNIAeGFE?=
 =?us-ascii?Q?bf5FLV7Q9EexzJT8ATV//Qm6ATHHVFF+5jnu7KG/tZTlPOs4k30xgAbLzlSR?=
 =?us-ascii?Q?yaSteDiYU6f14PwpbYf7BR9lb5WnnvUkUmx9s6BHCFw1mKnGppeaDYJWIh8K?=
 =?us-ascii?Q?WU+iphiKLNh9NOWIb3l0KiG2O0dBVhi+WzAZyxmuAqOscHlgTUo/MQOQKg8q?=
 =?us-ascii?Q?ApWXh7RPeZkRks9rkBFpAy/9rhz+RcnB8qUq+j/bON6jnZRlUxxznrMdebZT?=
 =?us-ascii?Q?sC+JHgkGg8nVSrvSPCfgCubel6/cOuTjYBUGu+n1mlTJBqnWJkU9DPCpe0iC?=
 =?us-ascii?Q?spPYMCXWBeKxu17WgZeMxrkyvl7u1VgZGl9oA+9+C73UxeRL7Y0Z/PEkDHOh?=
 =?us-ascii?Q?9qkljCDWzj3IwxetnbthO/kN32t0yEQG82joXaCKqa7wnycYhuq/07sMopf/?=
 =?us-ascii?Q?aP6G1PcihfMkX6q/J/SYW/TQcUzAYbU8iUXcf9wbCGp652QPGLwd7b0Xq2iu?=
 =?us-ascii?Q?6zWDXgjTmaDnnpX5p1wc8GfWpjygJRLTfdgZvsyrchpukfAA/bHwYtEatba9?=
 =?us-ascii?Q?8SDCnRSCba/gFRNicObsw7033V8lxGpueZlM6Gr8qeWSIAeBu6v0svwxL+qo?=
 =?us-ascii?Q?f0LPOwzuzRR/IAnsUMaygwPafnrImU/DcFYfmMQGSW9XmaByam60btqIqtZV?=
 =?us-ascii?Q?8PsOUHfa6ziMzjgOXPpAQQkspGn9k81v0kcwgqpheZdVHciPrDQRsmW7YH4V?=
 =?us-ascii?Q?7YSmXvjB7ojJmkOBFU5TTANIrtmWLG23sumL125G65GwmzjuYdJIVvlAlWdP?=
 =?us-ascii?Q?eEFYa+IUXw/Nhow6Ai4I6v/kPv5mRtM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3008cb3-7ff7-4b2f-ea30-08da17d57997
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 13:58:06.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ppVUVlu5WkjY+Shufl9CJMaE9Zah7pjx11oxiEKb5NBbkZdvyWWpZ2N7cl9wksD/RYx8IGyL6J9BFer9xMeu8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4711
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_05:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060068
X-Proofpoint-ORIG-GUID: PbWjXny2ljUA1yg34AlJ3umUOHxagVMd
X-Proofpoint-GUID: PbWjXny2ljUA1yg34AlJ3umUOHxagVMd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Check for rdonly is a little bit inconsistent. At most of the places we
use sb_rdonly(fs_info->sb) however in btrfs_need_cleaner_sleep() it
used the test_bit(BTRFS_FS_STATE_RO....).

As per the comment of btrfs_need_cleaner_sleep(), it needs to use
BTRFS_FS_STATE_RO state for the atomic purpose.

BTRFS_FS_OPEN flag is true if the filesystem open is complete and
read-write-able (not rdonly). In preparatory to take out the rdonly/rw
part in the above flag, consolidate the check for filesystem rdonly into
the function btrfs_fs_is_rdonly(). It makes either way migration easier.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c  |  2 +-
 fs/btrfs/ctree.h        | 13 +++++++++++--
 fs/btrfs/dev-replace.c  |  2 +-
 fs/btrfs/disk-io.c      | 11 ++++++-----
 fs/btrfs/extent_io.c    |  4 ++--
 fs/btrfs/inode.c        |  2 +-
 fs/btrfs/ioctl.c        |  2 +-
 fs/btrfs/super.c        | 12 ++++++------
 fs/btrfs/sysfs.c        |  4 ++--
 fs/btrfs/tree-checker.c |  2 +-
 fs/btrfs/volumes.c      |  4 ++--
 11 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7bf10afab89c..94345316cc92 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2571,7 +2571,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	 * In that case we should not start a new transaction on read-only fs.
 	 * Thus here we skip all chunk allocations.
 	 */
-	if (sb_rdonly(fs_info->sb)) {
+	if (btrfs_fs_is_rdonly(fs_info)) {
 		mutex_lock(&fs_info->ro_block_group_mutex);
 		ret = inc_block_group_ro(cache, 0);
 		mutex_unlock(&fs_info->ro_block_group_mutex);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4af340c32986..21b1e9698b19 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3112,6 +3112,16 @@ static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+static inline bool btrfs_fs_is_rdonly(const struct btrfs_fs_info *fs_info)
+{
+	bool rdonly = sb_rdonly(fs_info->sb);
+	bool fs_rdonly = test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
+
+	BUG_ON(rdonly != fs_rdonly);
+
+	return rdonly;
+}
+
 /*
  * If we remount the fs to be R/O or umount the fs, the cleaner needn't do
  * anything except sleeping. This function is used to check the status of
@@ -3122,8 +3132,7 @@ static inline int btrfs_fs_closing(struct btrfs_fs_info *fs_info)
  */
 static inline int btrfs_need_cleaner_sleep(struct btrfs_fs_info *fs_info)
 {
-	return test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state) ||
-		btrfs_fs_closing(fs_info);
+	return btrfs_fs_is_rdonly(fs_info) || btrfs_fs_closing(fs_info);
 }
 
 static inline void btrfs_set_sb_rdonly(struct super_block *sb)
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 677b99e66c21..1a9b2d7eedad 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -1074,7 +1074,7 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 	int result;
 	int ret;
 
-	if (sb_rdonly(fs_info->sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		return -EROFS;
 
 	mutex_lock(&dev_replace->lock_finishing_cancel_unmount);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dfec67e8a78c..552dc49e2948 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2590,7 +2590,7 @@ static int btrfs_replay_log(struct btrfs_fs_info *fs_info,
 		return ret;
 	}
 
-	if (sb_rdonly(fs_info->sb)) {
+	if (btrfs_fs_is_rdonly(fs_info)) {
 		ret = btrfs_commit_super(fs_info);
 		if (ret)
 			return ret;
@@ -3668,7 +3668,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	features = btrfs_super_compat_ro_flags(disk_super) &
 		~BTRFS_FEATURE_COMPAT_RO_SUPP;
-	if (!sb_rdonly(sb) && features) {
+	if (!btrfs_fs_is_rdonly(fs_info) && features) {
 		btrfs_err(fs_info,
 	"cannot mount read-write because of unsupported optional features (%llx)",
 		       features);
@@ -3838,7 +3838,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	btrfs_free_zone_cache(fs_info);
 
-	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
+	if (!btrfs_fs_is_rdonly(fs_info) &&
+	    fs_info->fs_devices->missing_devices &&
 	    !btrfs_check_rw_degradable(fs_info, NULL)) {
 		btrfs_warn(fs_info,
 		"writable mount is not allowed due to too many missing devices");
@@ -3905,7 +3906,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_qgroup;
 	}
 
-	if (sb_rdonly(sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		goto clear_oneshot;
 
 	ret = btrfs_start_pre_rw_mount(fs_info);
@@ -4694,7 +4695,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* Cancel or finish ongoing discard work */
 	btrfs_discard_cleanup(fs_info);
 
-	if (!sb_rdonly(fs_info->sb)) {
+	if (!btrfs_fs_is_rdonly(fs_info)) {
 		/*
 		 * The cleaner kthread is stopped, so do one final pass over
 		 * unused block groups.
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9f2ada809dea..20916748a3b2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2391,7 +2391,7 @@ int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
 	int i, num_pages = num_extent_pages(eb);
 	int ret = 0;
 
-	if (sb_rdonly(fs_info->sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		return -EROFS;
 
 	for (i = 0; i < num_pages; i++) {
@@ -2434,7 +2434,7 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 
 	BUG_ON(!failrec->this_mirror);
 
-	if (sb_rdonly(fs_info->sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		goto out;
 
 	spin_lock(&io_tree->lock);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7d91166d90bf..a1dcc656dd63 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5755,7 +5755,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 
 	if (!IS_ERR(inode) && root != sub_root) {
 		down_read(&fs_info->cleanup_work_sem);
-		if (!sb_rdonly(inode->i_sb))
+		if (!btrfs_fs_is_rdonly(fs_info))
 			ret = btrfs_orphan_cleanup(sub_root);
 		up_read(&fs_info->cleanup_work_sem);
 		if (ret) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7a6974e877f4..2332b9226735 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4132,7 +4132,7 @@ static long btrfs_ioctl_dev_replace(struct btrfs_fs_info *fs_info,
 
 	switch (p->cmd) {
 	case BTRFS_IOCTL_DEV_REPLACE_CMD_START:
-		if (sb_rdonly(fs_info->sb)) {
+		if (btrfs_fs_is_rdonly(fs_info)) {
 			ret = -EROFS;
 			goto out;
 		}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1857636b84df..0df155f88c14 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -183,7 +183,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	 * Special case: if the error is EROFS, and we're already
 	 * under SB_RDONLY, then it is safe here.
 	 */
-	if (errno == -EROFS && sb_rdonly(sb))
+	if (errno == -EROFS && btrfs_fs_is_rdonly(fs_info))
   		return;
 
 #ifdef CONFIG_PRINTK
@@ -216,7 +216,7 @@ void __btrfs_handle_fs_error(struct btrfs_fs_info *fs_info, const char *function
 	if (!(sb->s_flags & SB_BORN))
 		return;
 
-	if (sb_rdonly(sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		return;
 
 	btrfs_discard_stop(fs_info);
@@ -1941,9 +1941,9 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 	 * close or the filesystem is read only.
 	 */
 	if (btrfs_raw_test_opt(old_opts, AUTO_DEFRAG) &&
-	    (!btrfs_raw_test_opt(fs_info->mount_opt, AUTO_DEFRAG) || sb_rdonly(fs_info->sb))) {
+	    (!btrfs_raw_test_opt(fs_info->mount_opt, AUTO_DEFRAG) ||
+	     btrfs_fs_is_rdonly(fs_info)))
 		btrfs_cleanup_defrag_inodes(fs_info);
-	}
 
 	/* If we toggled discard async */
 	if (!btrfs_raw_test_opt(old_opts, DISCARD_ASYNC) &&
@@ -1993,7 +1993,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 
 	if ((bool)btrfs_test_opt(fs_info, FREE_SPACE_TREE) !=
 	    (bool)btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
-	    (!sb_rdonly(sb) || (*flags & SB_RDONLY))) {
+	    (!btrfs_fs_is_rdonly(fs_info) || (*flags & SB_RDONLY))) {
 		btrfs_warn(fs_info,
 		"remount supports changing free space tree only from ro to rw");
 		/* Make sure free space cache options match the state on disk */
@@ -2007,7 +2007,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
+	if ((bool)(*flags & SB_RDONLY) == btrfs_fs_is_rdonly(fs_info))
 		goto out;
 
 	if (*flags & SB_RDONLY) {
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 366424222b4f..19f7ffd26480 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -194,7 +194,7 @@ static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
 	if (!fs_info)
 		return -EPERM;
 
-	if (sb_rdonly(fs_info->sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		return -EROFS;
 
 	ret = kstrtoul(skip_spaces(buf), 0, &val);
@@ -824,7 +824,7 @@ static ssize_t btrfs_label_store(struct kobject *kobj,
 	if (!fs_info)
 		return -EPERM;
 
-	if (sb_rdonly(fs_info->sb))
+	if (btrfs_fs_is_rdonly(fs_info))
 		return -EROFS;
 
 	/*
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 9e0e0ae2288c..24aa0e00bf5a 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1104,7 +1104,7 @@ static int check_inode_item(struct extent_buffer *leaf,
 			       "unknown incompat flags detected: 0x%x", flags);
 		return -EUCLEAN;
 	}
-	if (unlikely(!sb_rdonly(fs_info->sb) &&
+	if (unlikely(!btrfs_fs_is_rdonly(fs_info) &&
 		     (ro_flags & ~BTRFS_INODE_RO_FLAG_MASK))) {
 		inode_item_err(leaf, slot,
 			"unknown ro-compat flags detected on writeable mount: 0x%x",
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 26ada24890a5..e206cb0df6a1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2597,7 +2597,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	bool seeding_dev = false;
 	bool locked = false;
 
-	if (sb_rdonly(sb) && !fs_devices->seeding)
+	if (btrfs_fs_is_rdonly(fs_info) && !fs_devices->seeding)
 		return -EROFS;
 
 	bdev = blkdev_get_by_path(device_path, FMODE_WRITE | FMODE_EXCL,
@@ -4587,7 +4587,7 @@ int btrfs_cancel_balance(struct btrfs_fs_info *fs_info)
 	 * mount time if the mount is read-write. Otherwise it's still paused
 	 * and we must not allow cancelling as it deletes the item.
 	 */
-	if (sb_rdonly(fs_info->sb)) {
+	if (btrfs_fs_is_rdonly(fs_info)) {
 		mutex_unlock(&fs_info->balance_mutex);
 		return -EROFS;
 	}
-- 
2.33.1

