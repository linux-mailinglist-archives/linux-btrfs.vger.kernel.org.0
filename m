Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB5270F5D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 14:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjEXMD3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 08:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjEXMD2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 08:03:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C351F198
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 05:03:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OC15Oa030572
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=XXUrY2kyCAzaG33AM7TfDIjEhmVV+LrKlRcBXx+4vkM=;
 b=k6da1tWEbKl3thcwXKge4HnbdDLjLWHvtTQsYebLW1TO3fk9//jVYnx5lHA2HPXXD8L0
 VZtwDks55ZDaN2WRRv9ZdKIQ1vOcv9ZPDnxdGnRIjyo4V6xVofON4wS7A3uSZ9m8CU6O
 AJLnsiBmPwxSTYsZdpdo6HokCHKI96zvYcMBccfWZJ3yTMQfYTaNL8xv0Kq9cGt6a8lP
 gGv7COY4QOasDvqhskYsoHmpk6OH5umdOCwCuPZfpYo813HA7K7sNulx37ujMopss7La
 U6l0MQodDkSaKt+UaEAeMm5q7XCbIMRlbuzUENFyadD8fExyLw0ATtemFqCWwFpXcYgH 2w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsj27r0pb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OAN2Gb027108
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:21 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2evjtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz1nM9OydGIiFqjD3P5BM1SYho6KcQU1Nu/G2PpHt+eyAnwNN00PVM5lAPmrDB19an/h40WqC8H2AXyPHOyi8qBkbPUAAj+Tahc/OyrmLEBF+9Nr407VQ/RBeXxhj5HuzcHW2Qzf75Ltzf+ou/cJIpUF6GiXgngJ3Xm7qMDc2PcI46GqDu1mpHMeKJTMIXy9P2Vj4hLqfND+wjCid364pAjSPro/0dMr259Zyz3kITtwD3MN/bpSvQ2QYDWw5UHOf29HmODQUSY42Tv3jc/pPLaLbKCyA0e2GB8ulLs80wu+pW9vm4l3hoo/7MvPD8D1IAkE3dKbddjdxe3R6pUsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXUrY2kyCAzaG33AM7TfDIjEhmVV+LrKlRcBXx+4vkM=;
 b=RvnXqnc5q2l9/JvLRAufEs7BoOY1PsUq2xwuh+c2F5rcAaTE86ezKClyJjqdeEX76CLijkmheXMHPDKhQxCb4gtx85wlV3VzNbTLccZu8Mln0ppp55dzpRxQupzKTNNQYgfzagmie3griX5tPmwo/ugBI9cmIh6xUUCRbYJ4aqeobxBMZN+0mdFw7EmapEzlNR39k1bpOo2SHW2+p7joO8wF2DupZXbHv8hMLuETrAk/UnYlmHdvzZMVNlAU8/cmDd/PDCmFcA9rV9+E+WlM6h4UDpzH/6QiIYpRmVM5xi22RMhSDUhV2/Zsx3y5v6mK0yB3EO4z68JpDAc+eN0n4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXUrY2kyCAzaG33AM7TfDIjEhmVV+LrKlRcBXx+4vkM=;
 b=NXPevbB/RMP9670IdbTzha43KFcGToGvkvevCdntCCVSfbvFKK/vcntRPQ7+GXZrYOHS6o259j35OZ9OZyX3hnYDf+0S7TefpFluUGu6g2HiJFUDACU35RpYM5XSdjApfV2DqwJzbxkhMDUbWzQA2WbuLZRcedeIsRxxk+8m9fw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 12:03:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 12:03:19 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 2/9] btrfs: streamline fsid checks in alloc_fs_devices
Date:   Wed, 24 May 2023 20:02:36 +0800
Message-Id: <3b7b4844919ad7d988c3f8a0e83ac9a63d0ee4d2.1684928629.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
References: <cover.1684928629.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 89abd749-ecac-41a8-26de-08db5c4edcf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCE94snAq2zAVTonyGmU8TAjoV0a4iO3/GD34YwLU0zKXsNUdfPlYBBBfmRgK14n69WhmluR6QfoAJbQpv1QVAqPBfNj230oi8jxW8/c5/0OslCk/B/LAGcmfRwQprTxPPr8ie69aqtVOHEiBGS6eL0oUE9MWDjNzS6gYtpDtPgsWZdhXafDesajNANQpohkNWPEwcWpUj/BleswEjQlD669DbOBKpwofOsQcYv2TkV7d0BUEIwU0pJKl8my4RNTVaBEPXPGYsbHoEIP9as3BJD5BKzNMGK4ht77OHO19pX79PL1jUy3h5jA10Hn70jxa7PjM+6jP466T4LsfZe5T/obKjE6HKVICUxaurjpBc6T6caBFfTaSecc4fHMNT/99xYaBbMSVlM+IhivpSlUrO7tFUsBta0C4m1ZC8XmmSJ1G3JU0GeehmZxb4lV/rwGkTYW8GKb8AnVQ1P+9pXCKFq25J0ipldk4AgegW/4PDktTPzRJ/V8zpt4fCd1MxKGngmz6ZHQ8VQzxhROvCoNa+nAdzx2s6i9qs0tKdoYh6VvHVYa3r9vPHZhnoQDZDHB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(41300700001)(6486002)(6666004)(316002)(8676002)(8936002)(186003)(36756003)(38100700002)(26005)(6506007)(6512007)(107886003)(44832011)(5660300002)(2906002)(2616005)(66476007)(66946007)(66556008)(6916009)(478600001)(4326008)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mBwcIemBD7wvRVFz+GMyYHuR39NrLMbDvnJZ8i/zIt+SFvW5GBf4GVEwhfaU?=
 =?us-ascii?Q?Oiwvos9MH+H6MiS8O9YmDJHo5dStQbHd27R4xqbTk5U+eS3gHweMGXV1Qd0p?=
 =?us-ascii?Q?YwK+tJBMXe7rD6M9A2HSM2O82I/HH/ma7bVzwF8TbZWRaiUYpDZhPD2qj77D?=
 =?us-ascii?Q?GlV88ZHbwmGXgcOX63HvmALh0qp3JGID5qlM4TssMFgSLdpcuK5R18rUHGHC?=
 =?us-ascii?Q?oSwB2jYj1+Yy2Krl1YWHrrAqpZJZTiQaS5N3ZqYntZdq2NOsEei+AdGTpi0A?=
 =?us-ascii?Q?cjK+eoT3JeYlcdkU8D9L7DanCd1KG+a1QHA1h3Xw92pmHA5Aqz8ndH+cvx+r?=
 =?us-ascii?Q?ZxrYFFnUepmRbJt4TxSgoQWhxO+HHW9DayUHw6jQfgtpkPQZOhyoPn/+IU0x?=
 =?us-ascii?Q?qEYmeVbQafhUygsR03h30P0buwZcAAPRLBmPn19wg3ejMEOPlhsuskKfbBS4?=
 =?us-ascii?Q?AQlRqHcnehutmFbG1Yl+HYaTs1tvv+5mRSzP+a/Qb2GSYecvFTVr+iM9HO53?=
 =?us-ascii?Q?TNW45aVz7xyNDcNrSdKXzOJo7SpHgsnmshCUyErlihRCaprXq54qkem/k4+Z?=
 =?us-ascii?Q?IqhgdIz3K3i+jneRoAQLa3kRwdlIRWD805AkvjsiauPP5JytKjjoWvcPFEIW?=
 =?us-ascii?Q?ePOcqbC59dIQzEKicst6IkNu30jDd2qEuYhhP9EinbEwMu6RdiBgXx3ZEE7O?=
 =?us-ascii?Q?WUxeRm481Jx1w91fAJrq+Uy7YCi6ELCr3ypSlYdj/VYDK3qqZRyHYnPRwUzF?=
 =?us-ascii?Q?4hk5kVire63y0ZvCrq0yTBgAKswAToMFGpMV/NruKE2lvxwz2PSFyrhx4Fz8?=
 =?us-ascii?Q?g0pQE6yLzTvb6R8LgIHr19Moc5mFDR8TEcKAJo2JV5/8tbM3xpFMwYOaNobh?=
 =?us-ascii?Q?la2z7yY07ZMSaYFAzJNxYyrP4/7zIDgnOO03wS1z4QNfiYaj63ntiT80uN/Y?=
 =?us-ascii?Q?RmlepnoyAuQ92zBg03/GdY/rnhM2hCxnwU2DqQlfvcWqGCX58o2OKFNjLLgt?=
 =?us-ascii?Q?zmI6BurPXfHSk1W/j3I+gWRfKmwXI+XfiXkkxQT0cl0qL6/s/LZOt2UhBx/F?=
 =?us-ascii?Q?C3k4syELVH4ye3vNdjqnR7QGNv6ILtApJz9w05B3JF0qQBPB6ec8kY31g0Tn?=
 =?us-ascii?Q?BUaxQkiIr9w3+K/+KqzBPFUHiwExadtoQzoUR/dJtrDbHnIhL3Ebcz3Gshjf?=
 =?us-ascii?Q?o8LHDf2SmhLgkJeT0NxlotVDn8TJprZ/zhQRneJORbPa0BLFKCSZs7w6KuSz?=
 =?us-ascii?Q?5ypmywwZx/OkEKrdZQob+5N2GHy1MPJir9MUtkU0VpneZQilhXKyZIW6eABW?=
 =?us-ascii?Q?flgmNyb+l2+nDegyYSK+gBhwtfjr8q/kU78YoX+gFkSTRStsofG4Cw9WSZz9?=
 =?us-ascii?Q?L+6ej1/PNmz0+6qzgr19pTyPM7GiPhM9VmRaM5zuoGir262lH0B/nqTT9doN?=
 =?us-ascii?Q?tzBGGK5ouwcJqF49XEHta79uU6nOgFXCiMWDxBxIc4YDGSX44/Ys8OZ5805g?=
 =?us-ascii?Q?gStN1GuwqfZHsadPrJq8NpUDgs/5MpxOgYivfnX2/dToCQQRyxMDzfl8Nc1t?=
 =?us-ascii?Q?jhF07GKkd/Zv8K0+o9vExwYjRkusFlwQRNANkQD4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E40ktHauqwfwCdAQ8Edpk/8BDcpscsYh89LrHSLHLK9RLNtrUED59B7fFxW9ihpXNti0HtB6Un7ygcy/90sWvlRcwmf1j2d7SVonm27s5TtqqONDunTzBaqnVs0ST/c4OvFsenjrFcHmU2zghch0ubrAwfq0WvvY0t9f+PHZb44EOf5yt41o/CEIaZL31rWWw5XTfWE9xsUl6QiG3MlUoGHCs7JgzL4D65JzDHMtUt259qCa3206qhFCxpEP8WU+OSLKA6B0IDL+JGBCJ6Y5iyNYnUW2iMzOSkOXkkQ/IPXATqIJJuaPU7V2izpYx8I5UwZtvSRanBuv8PHGyfaVeUxhE+mZL/Ub7M4W4xs7Fj/kdg5XZAvv67Fu7+2BWN4IbcJuccyM8Utf+Qf+825F7lgz+ceyJdUydSTC7yEhp3KUSSIeDJpkgEXNRlBORmMa5a7pCPKAhpOtxGZwsQ4V3drasamWNYrP+SRAjkacxXLsf0wpTzP+4THXDktLnHjncSAaKet1IM7FacveZ1CPqJ/RiPryuCJWEpAkEYOnTKFabuSShtxdZkfU0GSg6mUaY7u1xBvCuzFnwIvQkMtj3ttJaAMW+nbkTKWdixNoglOkABahob3zxnnBA0y60+FzQ5Txbc/p6L+RO7j0My68IP9pQED8oUUsj63JrXy0gPyL6zyJZf5ZUBZsXida+kD0kDFgvNJHH+DfYMX006KT7nJ0y9THDZjuuQuKAzbDa9onCEIC3wANTJ6SwZ5sI/ABvMw25juMaXESOiAPRR9C9A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89abd749-ecac-41a8-26de-08db5c4edcf6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:03:19.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gqkFLyNLQ5rqzph8NL9UFUhQCaMFWpm5z8xdR+Pd/VIlbVDukQSSO6OpM8+YylvtIgUPn2g0QhKnjQZgLW79g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240101
X-Proofpoint-GUID: _cV8X-4rxw1X2q9nub3lu3izZd_k0sS3
X-Proofpoint-ORIG-GUID: _cV8X-4rxw1X2q9nub3lu3izZd_k0sS3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We currently have redundant checks for the non-null value of fsid
simplify it.

And, no one is using alloc_fs_devices() with a NULL metadata_uuid
while fsid is not NULL, add an assert() to verify this condition.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Simplify ASSERT condition.
    Fix space before open brackets.

 fs/btrfs/volumes.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1a7620680f50..4b35b28c8746 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -370,6 +370,8 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 {
 	struct btrfs_fs_devices *fs_devs;
 
+	ASSERT(fsid || !metadata_fsid);
+
 	fs_devs = kzalloc(sizeof(*fs_devs), GFP_KERNEL);
 	if (!fs_devs)
 		return ERR_PTR(-ENOMEM);
@@ -380,13 +382,12 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 	INIT_LIST_HEAD(&fs_devs->alloc_list);
 	INIT_LIST_HEAD(&fs_devs->fs_list);
 	INIT_LIST_HEAD(&fs_devs->seed_list);
-	if (fsid)
-		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
 
-	if (metadata_fsid)
-		memcpy(fs_devs->metadata_uuid, metadata_fsid, BTRFS_FSID_SIZE);
-	else if (fsid)
-		memcpy(fs_devs->metadata_uuid, fsid, BTRFS_FSID_SIZE);
+	if (fsid) {
+		memcpy(fs_devs->fsid, fsid, BTRFS_FSID_SIZE);
+		memcpy(fs_devs->metadata_uuid,
+		       metadata_fsid ? metadata_fsid : fsid, BTRFS_FSID_SIZE);
+	}
 
 	return fs_devs;
 }
-- 
2.38.1

