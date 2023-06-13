Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9048672DF66
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbjFMK2X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjFMK1m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:27:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A85213A
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:27:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65GA1002074;
        Tue, 13 Jun 2023 10:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=9o9fbzjWMJFiuN4IjElCzZt0TKeUAvifWmS/uF6SspE=;
 b=nKqpg7r+aQHVBF/T+0s9hOQyE9XVscH/LRDWEbehVq8CdFMOPgnzBbr67/BlF4HAGq14
 QLVKDoDlp/Crvhu3/uTEqvK6eznf/WPyaUQdCjqJAXcr0ttrr1X+++BmdVvuwabRSwq9
 BRy2aoy/7ET85nzDlOu4hoAoJgkCXi18X7raGP58y7UQsLE42FcrO0Vtv0hafvQSIDY4
 eLsvMfzGXW9oqlCpIwMwkBxZfD9b4nlpFQr2dTJ4ZMOeF6284QB79p/ZtUPwP3ssrOC0
 6dCqB5TTbuHNd14zzPvVhbI0fX8pCkURNyPUwZYM8uKzy07W6mtcIGFPZx7IGH9oRj0k Lw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstvtxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 10:27:37 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D8T7X5014078;
        Tue, 13 Jun 2023 10:27:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm3qjc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 10:27:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+R/FrnOZTDzu561QEc1GYMR2cFZ9SInCRW+kbAnDlJs3ZSsOLw/Z14CL+hQ2MTii5EQl7Ga9y7IuZNz3GZrthpv8RoaG+n4zuiR01p39UNZFyVtloi+26sZOZkA7Ax9FIel7yL88IElxPVirNcMspYlG0OZaJSkbG1VTM7dQWZP9WTszaKkkulZhAEriMJkmjQLIydagXl8raCyy3qEYDlzp/VaNW8Wu+Bhd6niP7z938tg6Fule+sFugKME5SH9/1rHHJT6Kkt/OTm4CsBCA4c7vznQPkqGF0pGZkpKxYvXCj+2CqG+LVJ9yzlnmGtRuGPOuMenUMVCx4u7t3gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o9fbzjWMJFiuN4IjElCzZt0TKeUAvifWmS/uF6SspE=;
 b=hZDliTa6iE/HhoqS50kHlg+E95UEQYQVPaAWMZjMgp7WhtiWzDV9PQXrv8ofix5EQOcbup8T3ff/7Xc5s52jWtpU/ne662LtvGq4O/bvxp8o8oKzq3y0RxjmdTL88yeFtygE5ioGmKhF9Q/X2IZ2/XlJr8EriaHqjBTX8NxQ+5rDesg0SM2fE9PgCdBIMaCqiu9u5Bx+d8gEQhqFBjwkWolitGBU9t/RJ342XqVyHC0022ZksA15y4W9J2wVvPALyXpF33o4GIg+/GquoP41kXuwPAfDyDHKanFjcH0L6IXLI5OLz5dC+ZrW4iojd3l4C6aQDZnpf1z/QvyH8yXSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9o9fbzjWMJFiuN4IjElCzZt0TKeUAvifWmS/uF6SspE=;
 b=efQxbvmAFeZ8i+N42mR4UXpBoT35dd7tdMGzH3AKuKTNh5xpM3PVfGKrk19SJSYUU9cc5XBw8jvYZ5Lwyk1A/c+XT5nlZRkA+ShVCdgkvRroHiJPm7HTm6U/tq90xmeHtOl6oDp8s9PzlHdeiAJ4LbmY/hGfNFytuDtp0bCLEM4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4398.namprd10.prod.outlook.com (2603:10b6:208:1dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 10:27:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:27:35 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>
Subject: [PATCH 4/6] btrfs-progs: device_list_add: optimize arguments drop devid
Date:   Tue, 13 Jun 2023 18:26:55 +0800
Message-Id: <9de0259373eb05a32c575e8765d8733c59badf65.1686484067.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484067.git.anand.jain@oracle.com>
References: <cover.1686484067.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8f720f-5ef7-425f-a00c-08db6bf8cd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHDxqNjeFQCc6mOZf40+i+26ffV4dTNCHMF33XKaj5TUs4EvLjH1EZwRpyJELfZQycjokN9fOSnUsZpTpN6nd8jRGoI3ML6sTaEAxRzMegj1QBZBM/7mOZFVl4572rl952HCLGR7Vw/xgeiDnLNRTZmczPK1dab+XbLyws6r+NKaWRcYZnH2VTV1m8trct+X305+xMeZoFSl/k6FteDGiCysW0WQKrZze0Ix5aziQjXMJ3PgO+NNOpOzhuXDOtlDQsGcNFnCBpIC+ehLEoTwgeM6fZ317+kQ+xHjcVrmrJB0tOhe13hJO39WbeHoG3LUkMXvZZk103yRvNB5/GEteofpveCpv7vTT63bzQ6P7knrqGSENzX6PWQAGVi0mgnxba1N5oNTLcEcDcMH8tcxojqnHrD985zNYQ8erbKdf8KRRK1y8pPlwRwYkv7LajHgj46aemxBE9gXsFU4auVzRSIgP/Ewt+6RFYs+XVUhCZci44kLhRvcF7oqooTMrstvgDH6FAaeeRIOl+ldJlVNymk05Wl0ZIev7twmo3rlIKe7yYta82vb0t6X28cLtXrN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(38100700002)(5660300002)(478600001)(316002)(6916009)(2616005)(8936002)(8676002)(66946007)(4326008)(66476007)(41300700001)(66556008)(186003)(83380400001)(6486002)(6666004)(26005)(6512007)(6506007)(44832011)(86362001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gdJFESrzz+TZj/OQtXIn94dojfEcx9b75f7ZLqZcCXnl8Yu+kexXHP+exoFv?=
 =?us-ascii?Q?aBXZrP+i5QKEG2LXX1aNMXAKJ3hWAh8r7UEh+tneN6WPckRBFzKxpVDVX/Jd?=
 =?us-ascii?Q?l2oKimGp2O5YSwEjDztZ3foBiGNNpgMk062My2T0NuYcdvfhUw3TCL/NEXq7?=
 =?us-ascii?Q?DWV1AOscm5CMAbqdt920W+EDSDLFm2ThssYThfZo1pZPQ3B2kE++hRjHLFGc?=
 =?us-ascii?Q?skrOhomRNYIrspctIt2OJnU80pU3Vh3JCghtEA+EPMRegsaj3CPOjd/Pnq86?=
 =?us-ascii?Q?cKiPD+Z6lGfJT7K3eenx/wKoMZT+Rg/czaZc3F3p8hjL9CsteazPJhoJebda?=
 =?us-ascii?Q?Mi989X2jeZTimTJONBnEZAAkpe8ENZ5cjJRi3vISPKA4TR448zk+QhEZa4J0?=
 =?us-ascii?Q?CO1vLI+kSBWmYbT/mG1QNzNA5sIxIcbCWvKgdnIZXXsS5mr0QECyfp/q+Rzv?=
 =?us-ascii?Q?FASaZey50LKtwaPyUPT4pzAEtQEs9MW31nWnNLimhxwSgaEgG/IjwEKgyNZZ?=
 =?us-ascii?Q?SszqLudygSUD8PhIzEfrn3GdVLdGqIx7hMbnHZaHWbJ6T6nOsS/vUujG806f?=
 =?us-ascii?Q?cs45HMYO2bXUYiIY5s+aXX/HyUFS55ur99AOXC80G2WDp4GM9MZog5olu8qI?=
 =?us-ascii?Q?YGVb6P8/MFUgVUCf+xIRf+QguJncQIoAMDZdZLnRmcRLVNwbwicvOzbMgsOu?=
 =?us-ascii?Q?B3Fx7wDCO1WTbKpGWMlGZQzuMK9A154hrq1rjHMTQaDa6/LsBv/K4TXYRc1G?=
 =?us-ascii?Q?HS1wHqBfRWNeRFWjybI8q0mWRZiKOxrsqqpTM+wBcv1p2RVEIZUiKZKFh3Kk?=
 =?us-ascii?Q?S/YOO5FLT2/0nVemmj028HRjmlPaop0CUs9G3ZkRZjjSNIOWFucmNEDozsOg?=
 =?us-ascii?Q?C7J9O/afyt8nrIhFCpRjWk68EwEILu1nWUful/KTHPF9tZxKZZNXfmw7lsqk?=
 =?us-ascii?Q?SYe9tKoh6nZFtGBMIprXOrk+WAEMV4jilOx3fqgMme+QFgnRZMuoS4U8YMTa?=
 =?us-ascii?Q?YU8kOQU9IPiiL0JJWNcGLyKB/nLjiZZ85Fwj9QJJ0+eZ2PXSIeFj9NlIOkV3?=
 =?us-ascii?Q?BVIDbcZDp/TM8ZdXroOhJ5pAvkS0eTAvpZoPNuFMp0U2WPK1OiTidzSJk2Dn?=
 =?us-ascii?Q?IVI41R2yIP6RCFDv9FNAPI2Lf0+tjztxe/lJunuEodCgFcw49ovuCWaw//9F?=
 =?us-ascii?Q?5dz/i+x8+QD0BPDgCiq6utAWfRO5BtmQuH6TZCq8p24UTxeL3j0M+dF7TKKD?=
 =?us-ascii?Q?ktYK8zzHsdtSTymAaNMVsGt3e847iOZk4rF88xlh9q5FG+/IQjLg7YMYkjwt?=
 =?us-ascii?Q?mLbgk2HzN3C0e1RQ2hMGyZCQzbKzx9dGZZfAZUd2dzl0GqiFn6nXUmRa8PYL?=
 =?us-ascii?Q?URszk+btkD+4IixFP42Z+5x+TVhoJuHbO+8IIjMam+0nln7nYSUXPYt2xPT5?=
 =?us-ascii?Q?7aqUbtxlSTm9US5hlFpKMQPBbiM8lVBpxrO64NRbF3T57jgAEAqSCa0ZQrDE?=
 =?us-ascii?Q?EC2X7YZB15rCajQkUJauS6jexh8BXahRk5dff3CyX+uVUP9edAFN+SPQ5TO1?=
 =?us-ascii?Q?osnUcLFzEqdsKs098UO0TZg+XQaDP3b3XQRqAJGQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xcRar+g79JVymMWoTSdZgGNpPxmjkG0WDKWvs6k49r2Bis3vijXlQDQ1pGbqXeoIwZJMmuV7BawVc3mRG/VtDlmnfW+Oeit7MWFBIbybXJRPlVq5jlRO4VaozRjGOT8z4iZfYwhbqwt3AlRFHTBeGrx3+GwS4YMuZmHobAoS5Qja5C9oinUazgCOLeUzKbCOKSINo65yBsUVCPrrhl1bqmXC91T4wvb1tsNeC2JaqOnobVJVyLrcFnpLLOBSFHgTgCfM6vfC0v/JbluxJ7R1jED+U/H2dgLD4k48IY5dfpX+3hL5rRuFRuihvzkFlV1X5pt8A0mdR7yt7zDP1VXxh4wjSfmZldSPTHqDvE68agFyP9HdKNWB58OGki7Bmw93dHpz2VPqocyugqpH1gMZso8OJjfbbmZTH/IhG0OOIas+rPdgWXs4MM54/bLj6k4PX8B6JTx/ocdtXgz6w3hs4FY2GhT3uPEYL1U8deC0aXSIiPigzx52Xzv7bpxm5VKkqsaQ3q/eDsOZDnbDU+stgZrUD3FxtD1UCOYgeNxY2gLkXsNi2xDWKyuUz3hLB8pkVmexEZ0QRNa0FbP3VLy0KXo7UkhG/y88DXkshDAYjrAvaCdzOmcfGTGby6M0SthjUNl2/BLF3obKPKmS8rprZ3al2DmdBAO7s7QWLBnZ13yvdNl4dGZDr0lLxcjoEWY6cYBQ3OHdYaMaPDRN9p1ZrHIy3yd8ANPfkQT6Q0+1JPpIextPZ/DM70XEaIG1BzHvZ0nlul4RySsAXrIBqr3K20EtDHr2KGUG1QWTxXFDfNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8f720f-5ef7-425f-a00c-08db6bf8cd84
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:27:34.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9V9VBmZlymb0bO9o8XzoGq8h93Zvzy9fwTq387mFi+mYYN8Tck/8SYCOLXz8ThQJQ8P7fz6mHtAgUUI3xm2Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130092
X-Proofpoint-GUID: 8cQoBzpNOxa5hgsiu3hIeTrgijKVmpL0
X-Proofpoint-ORIG-GUID: 8cQoBzpNOxa5hgsiu3hIeTrgijKVmpL0
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
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

