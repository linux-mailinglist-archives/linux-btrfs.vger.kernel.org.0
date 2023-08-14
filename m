Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BFB77BD0B
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjHNPaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjHNP3u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D38C10DD
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:29:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiTRY016429
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=34o3ieDKQse30AQdGJtOAmaIV5a2D5SQYGVVVYdvSNc=;
 b=SIaCCtG/WGjNT1ba/iPLK1A4IUVbQmY4x+X2pSyXJDbFBlM4ga7+oDTfusv7gQidbnRL
 iqvEvLpe4tPTEbsHJQSLDZTrfK+gpPfT/jejmJQr48RWNJLn0oegF0YH1a6hF8En0lGK
 DYvlGo+6ip6yeeLO0c9UINs9CoTpOdgT2XxecskFkQAbJGzLFmXlni/5+vPH0Mc5ruS9
 gNCawJV3GFBnDOcj9GiJz+IDI7sYVuxibaz7/hPMPQ2xwOnlrBVHrerZXUT+x3AsJN7l
 yILIA/v2YQRJK5rtldkyt+9BBnLPBF7V/CFSClu5FDNdmFN5GXS4ddfw+pWAiFzCHAxD Og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5tutx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EF4WFe027461
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1r1vjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dshf6gIfbvLR2XKP37rAkfFnPWHSSsFZuEerJTNMRPktrOJMOIILHaGiiMPjhjBpJT+44k0IXZWdXhAG1abjJw72rl5FlewKFdsaK+IXl1bUbJIJS9qZonZgK1b8WKbHLzisVhhCzwFrPMNqOiVS4eEFIsUhk9oOIl1/cd+9QWT4qGxH7o5FxTjYnp4MLBjkx4ncUHi9+XRQeIJr+IV1Axzsn4aGRJLB9BzUGbmhfiFCYfdDQluaeyRwuswZyxhFS3zqfFEgZH50cNvpqXB9Fcfiknmri1hWu5k6cDugspUdrYF7rGFvBcUtXHTMBPbFI94jpZ+ahdV1/BriKo6sNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34o3ieDKQse30AQdGJtOAmaIV5a2D5SQYGVVVYdvSNc=;
 b=FArC+f/MUBEMDGvbTwzXSomwFoRRieil8l+UsKP6+z6/hCNpg5+prcmuWcCtb4b+Qkps7Kr+/Ezy8u/zxuMdF/BB7wKTokrnOaQUA8CdBED+M8PxWzBaZn266G35G91X8ViwaT36L0hgYOiT8YDnZVHIg5Sv18HYsrEOvQxGqpSQnN1aAl6px5+amWDMjROuSlFir4wsxVqXkCAz6zZsDycxWG6l/q2u1KFUYqEGAf89FWylQFJQuV7eS5g7qHbg2RNxO1v2WGOL0AWQ+2J2YMmx4IUr9ufBv28tygBbht1l9kuoarui8yy5u4jSjib4/ElQklC082U6+m/ueT6RAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34o3ieDKQse30AQdGJtOAmaIV5a2D5SQYGVVVYdvSNc=;
 b=hklKt+gC0BJrJ/SPs9ccvjrLkSKG8P/XzvKg0pX5+KLL+TbYSGHgGUYmP1XCVJFYnQDriK2tX2Huzqd8Fo3GpXSSirNm/Hh1hZjclof0A9NJOQScC93oMGlIbdKU488exKqapa2QA+arSb1x2HKTJLBnw9LZAx2G7Fuzu++jbrs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:29:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:29:46 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/16] btrfs-progs: rename fs_devices::latest_trans to match the kernel
Date:   Mon, 14 Aug 2023 23:28:08 +0800
Message-Id: <56c3acf6c529847f7c1ef2efaeebd5040f341747.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfd13bb-bc5c-4a9b-450e-08db9cdb49f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nf2huJ7FdR0gst3OtYmcaC0FZZ1sEHBDj9sHFuWSM1/D+/GfMC2boG7/liB/nnCzExYKbc7ukZuVVxXWP0sq6oRneXWL6URm3XN5YnmdJr4uXjrK9HqVLScfkbIX2bpRG/7fkFn5QSg58KppgCLfkYgL/Y8Q1vsd18ps74k27T+LJ1Yg6Ihyq5D9ddVW7A4yTZx6Ibs0+yqNJde8Gxt/PqHkFc8z9U+A0gpBqv9dccdK3t4xH8p0JIx0hWUM/VKJ2oePpsF7K47kt25LCpOnmYxOm9WIiutZ3ojXhpzwg0zHAHxT9u6ZtB52BlOMPHzkBFnnzzWSX+7RC3O4vktEtPjIXEl/R5rUOQoIYVtOUUCAdCP2MyPKyHVXB+J9SHNJrMhl4FHGIGDI7wFgtLU5IKEo7VbdKpOj52tElCLm3bGCl0aSwy6RaTgjGxUXm1A0e9384niVaeO+OsKW+Mfhu+yyJxj2Fw4fzaoM3tEzPcza814j/4eAcZbXXPQjcw/3KcHIZtdGyU2/lXlP0N4IzkbbgJqnJaJMc79HzaDKRvhqUZpZiJ6VKEQl6OY7AdlM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8MbnNWWl6Ie/Rni4zzaUQP+GPl6Wevy/XuRjVab99RCd6FTdH78+FCF5/1un?=
 =?us-ascii?Q?RQjTm0lC9s52CSt4JxSEWDHktyyONcCK7SdBbiOp9KLwv3GabqXJVkr+hUpP?=
 =?us-ascii?Q?5e3Kt/UG3AhpaJGq8xjJtTXg7VdDc4jSBG7IM+FU5qjcA5rsVZ8u2+nHYtdL?=
 =?us-ascii?Q?D8R4N0JPmyo1zHD27Eu5wH2gPmGoG6t0CCH5CYB3J8aMkub+7EQRIxfaLtJr?=
 =?us-ascii?Q?O0k4XKK3w7yBQR+fz1+Ym9iQ4+7p+QNwr5DhdADzxkMAGRx4zJkaMp6HQz7F?=
 =?us-ascii?Q?vcnuR76p1DY8kG6Vmi3fz36WHQ2PtlLGSN/bpQmK8lMuerspDnl5fej6FPzQ?=
 =?us-ascii?Q?mrIcy/x0oIJ30QZtWuIUqMZdR5SUyW0KC5i0e3ncUcoZEwpTdLraPSJf6mor?=
 =?us-ascii?Q?QCi/EulXyG4ReUcZ62/ef/wJ1C/ooL8nuwIhfstJidazAz8+U8Zc/LG1tLju?=
 =?us-ascii?Q?lMvYE8n5XZTyh7rQ9sev0M1wZCahdDgL66cTs5wLRwBipxw1RoFRfSmcO5/Y?=
 =?us-ascii?Q?FUz2bTT5W+tKRUaLs1W3Hl4Yi/rRN3smHH/BSgdVMLQ9ZlnVL8A4iN++lUJg?=
 =?us-ascii?Q?ryJmc7Zl/0hfK08/bHi5hZcNaMelxFTcvpNg3a+N59NWu5rFWT/EGPJ3ieUb?=
 =?us-ascii?Q?9C6T3j/iMnfPfC1Dhh+owG8DFhLZx2iZDZ2tbiS76xhHvmRxp6r/emNQwKFT?=
 =?us-ascii?Q?UbbO5qepqLLEfQm31DZiOvoCJWjja94xfPW15aXpTL4rA55bL3WZC6ZyZA7c?=
 =?us-ascii?Q?NttrmQfeP0+4Kh75MDUxGmlBT+lDioS1Tnd+tWviAWalqHDG3mEddEs335Ri?=
 =?us-ascii?Q?Ke2cYEt12xnHmRS7a+cACA0SBYZSb7r/0y7y4TUfoThYV9E9M04znPNtmczJ?=
 =?us-ascii?Q?Yc9X+IpKjMc6q8kzlwa47jBMH4pRbTibUuoCYKu6lfaEk9zVDBgD08S7FOHg?=
 =?us-ascii?Q?TZte7lh0M6G4xmB29XyXSMxH33gRbLgWZLycVg3rcjxlGvaxxLLeLiRUz8vl?=
 =?us-ascii?Q?FCLb8P8fjUllnWWL47cfgSjhyYDqlDN3QreCWl69gfZZvOSwVUbJ8If2nT+L?=
 =?us-ascii?Q?/LmSytvF2ZgTYJb5bovdpFLfTuYvBRKVMCB+7UtdbM1ZVRazgZqLpYsavRxE?=
 =?us-ascii?Q?46Y7L6BKQ1T8mYwsSzwAx+x0m8seLnP3TLZAl0UDxTAkZ/YH2g5eDyZ/Ltyx?=
 =?us-ascii?Q?dOw2uV4OMVZIMtJwEAT5dj8W52UNjhWlqtJhKjDsVLy2k0JxhbRZLjLwenSA?=
 =?us-ascii?Q?KrxoTj8PPpaQn7fnV3UGu37uXPUrpDPsfCdgIo3FbbM8OKdRmICJkcOl3m3Z?=
 =?us-ascii?Q?zoDs0OMd8z5BVjpzDom7IdZ6GEdYYfLpAtgC9tx2iD0gN0idoCNyH3ywF99/?=
 =?us-ascii?Q?xVBo5qJqHXSRxfjXgRjrr8SbPfbzQ7CtE4H6yyYlb8e+wDabnQOX11pdm7zO?=
 =?us-ascii?Q?J1zfIwfU4kx0PhZr4pPZgOyCpJngKHEWBSvUSCJ4lLyhBsJOI6e+TAPh1Liw?=
 =?us-ascii?Q?ZzSIVkxAnmdVupZ7XVhuU+/Z0jEv0Is3qUpEMz2yU0kIS7XCR38sTI/Xgn6a?=
 =?us-ascii?Q?XEd3XTkklJrQ+A1BQv5VmXe+k4dGLN6gDZZN0FRlvJYXXKbvJWlhFM4cNDDh?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aJkaNk6YacZ+89dla5SFXNE5wBdf0lgbAt0i8XQym0Dqo9BukkzbkhW82/mHk+NybZr1F7qa2zA4gkwos8tGIA8NQAkSDif5TzqOKhciOJBDCPwqykH9u+8iPaScSXppfVngdtV0IT/MUqnK10zHv3vykCx/ykx7da4MJtGsTeDrI8353znx/4wq3veBVAmSRpKCQieOncw0eq0Vu32+fmoDoPwh4XMsa4PovA365WwFR4BYKSQ5QCqSjO6A9f+HKsKnGdkTKCpTYVDLZQjG8QQLppqoMW1jARZHXBDSlMDNztuCWYWEniaxp//KCVv3srlNzrwdCQyHFrA3pt4l0toMX8Mi5sCkS6apUesvDdvzsPflYPTKVxP3yniOLP4wh7+OMKn79VbnhEcM8/QpCoeaPddDQXGEYh/sSDQxK4GBbKv3GxDuzJ6pN5pnJyQZHUgWhVVK4wGo+qIvJZoDP9exejYKlGaM/OD9Cis+KzykGBYyMepFyG0vdlVXQAsfxkgqcsy2tACZ+1Jc8rRkc1/0dizOrKdXm0Z4LCVUyuwKJDglZ0wbC8dZncUnjNcMDG4IRjYnogpDjDpNvcltiBlCnyld693l3Z+MnTzZqs8oJO6M81OZHsbkiAKi8/2jlmYY5hoOnS0Ykaym7YaNSoeZVENjYoTC3rD0y6z/Go3r3ZP/DBuUCQBom2hJcc9UKTX24NPIaPolszs10LgRxC2rHr8595rt1Wq8srVRX1FoxL+vr5B4BQolKg2RXnfZu9TaFBEH6cDA/eC0Mld8aw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfd13bb-bc5c-4a9b-450e-08db9cdb49f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:29:45.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KfHuUl3pOPZf2dCmxWDahfFxOSwZB/K3xp5ZKFLgZnUwTOP8XbuuHKyEddzKp+Xa7gpH45ogl6DV1U0Y7gCecg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140144
X-Proofpoint-ORIG-GUID: ugRxz4idLN07yeuTAVE4uvOxc88cpVez
X-Proofpoint-GUID: ugRxz4idLN07yeuTAVE4uvOxc88cpVez
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Aligning progs's struct btrfs_fs_devices with the kernel rename
btrfs_fs_devices::latest_trans to btrfs_fs_devices::latest_generation.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 6 +++---
 kernel-shared/volumes.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 0a3b295930f0..ad006b9de315 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -368,7 +368,7 @@ static int device_list_add(const char *path,
 
 		fs_devices->latest_devid = devid;
 		/* Below we would set this to found_transid */
-		fs_devices->latest_trans = 0;
+		fs_devices->latest_generation = 0;
 		fs_devices->lowest_devid = (u64)-1;
 		fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 		device = NULL;
@@ -438,9 +438,9 @@ static int device_list_add(const char *path,
 	if (metadata_uuid)
 		fs_devices->active_metadata_uuid = true;
 
-	if (found_transid > fs_devices->latest_trans) {
+	if (found_transid > fs_devices->latest_generation) {
 		fs_devices->latest_devid = devid;
-		fs_devices->latest_trans = found_transid;
+		fs_devices->latest_generation = found_transid;
 		fs_devices->total_devices = device->total_devs;
 	}
 	if (fs_devices->lowest_devid > devid) {
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 2bf7b9d78b39..7f571bddee87 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -85,7 +85,7 @@ struct btrfs_fs_devices {
 
 	/* the device with this id has the most recent copy of the super */
 	u64 latest_devid;
-	u64 latest_trans;
+	u64 latest_generation;
 	u64 lowest_devid;
 
 	u64 num_devices;
-- 
2.39.3

