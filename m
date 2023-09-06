Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888B579417E
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 18:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbjIFQ20 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243163AbjIFQ20 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 12:28:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDA51BD3
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 09:27:58 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386FZ3Pe003633
        for <linux-btrfs@vger.kernel.org>; Wed, 6 Sep 2023 16:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Xo1fzqWKe293WoXkDkiV7xfRUjk3lWSBuzA79eq9q0U=;
 b=QxLPc9Gn9pMHCk9HRfoJOhaASf5th0UlaefWecXLWSzqQjRki9+wMJAhyA4HtnKMccy2
 lkS4UtDqNBNtzR5r3OV+B13WCF6PR8YPt0kzGqAqtOyBdTjQ60oZksE9ommRdDkzKlRh
 bhNlh8tjPwgpkAoPat3+mTxDnUiphOLmeQDKhweFT7/nuEZJ2RWwUhH1zRb5jp/okSE4
 3MtTH+NS6eptu5KyoDGZxFLAqDQ6L0wsGhj+YMa0YlK8Qqit3mQbERwpn8Zf3KrFDaAR
 2V/zdy9XBe/stUk5ToMXRJDUGlj/w8QISOAb1LkF1GWKex2QtxEnSw6h+I7vmMzSIbxY 4Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxv6g06c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Sep 2023 16:27:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386GAfl9028152
        for <linux-btrfs@vger.kernel.org>; Wed, 6 Sep 2023 16:27:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug6gcg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Sep 2023 16:27:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvJMIC+xnYFs1AxiRASJS5XLvEG3aepF/GXGtlkU0XG45LbiCsZR9g+/iQNSbacwxX1VhXxoLzjX5PauU6IIUthYr/H7LFyBUBSJdV/UdtUUZsuhPvn5brFJ2A11/jeUH4GvdmKUbNQ8ptRalheDbyFdr3Yi2c085UtLqalNd1C1ZZ0NoXmd48FA1CzG3q45NZcY/Fc2AWVwf9ObONsjjleQCfbfZYVI86ot8BDuIl8hnmz8Ug/HDXgo3n2hZ2Ml9Nk0mgcjLIstNDpOD/EoJ8keO1ShGkMVd7cJsY/ZQ6gE91pXfveBIpo6ps2et7XHCMEOutf+yr0y/9M22eRTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xo1fzqWKe293WoXkDkiV7xfRUjk3lWSBuzA79eq9q0U=;
 b=M+PKrxNQRY37CS2J/VxKfMlSiq+WGsONN1HyA3ybOyO6RTFvNRjcIABO87VzP+LXB5wjEAmj75iBzC4HnvBK4IhrPnX8kkbPhn1JWgaqCs+INuaaTxecHnCt4sXkh/gFVe8VdT7zfdLbTSqbGk/eTMjHdh3uXAXu7j2zm2Sng+RXoMcx308qqzjHxmGHjAeyJ6+HPhmas4Xj1rojvelFIAmfvSXDo0moBebFzMjrCqptlFaEuqecfok9lPd7ZY5OZzWV34j72mWi+zjGns7KyLgqkfJVSwVuDcohsjjDBniF6T2XE74vx2WFyPCKjwN5JkPQI6LQkXQBreybN45grg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xo1fzqWKe293WoXkDkiV7xfRUjk3lWSBuzA79eq9q0U=;
 b=dyC6AEqYcfUiMu01DVeYhI7j+pgx/kzfLQ4ILz3S+QJRnZOXhb+DcQPW1U4x25CV8K+uvB9y+li/IYZiRTGv9upp1Kz9s7LMV6jrlURCDyEZ4Q2Z9CMpq4A7WXBNK8gNVLIRK+7pjDgQVDzZVw8KSU/ud9EDvqG+gxF9zbe2J9M=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB5161.namprd10.prod.outlook.com (2603:10b6:610:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:27:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:27:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: pseudo device-scan for single-device filesystems
Date:   Thu,  7 Sep 2023 00:27:41 +0800
Message-Id: <b0e0240254557461c137cd9b943f00b0d5048083.1693959204.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a02225-c4fc-4e16-348d-08dbaef6389c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIiU63Ctu2/hEOl5T562pVoP9n9MP73tbKyUrK6AhSBGn1dYXGoqsH77oGtWA69qWLV5ryjjvMaZJaRB1ac4soEC3jHiLllDNQpQWaTT0GRH9inXfz5kui5Nd6GILpr0Ip1BQASfrumbh2xiO+WeTdV8R5bDI7sKHqNCbDHenyJdwtgEFWbM62wnnosyTCbA+43ujg/gULhXJGop0SEWCEqlKuyv8G4QZSAEtXY7ClBFCIfuvOFyAXbaO3zbxvDbRqnSMGKwr7BzGjcTA45mxr3yORKD7K7H7K6SJiF0FWhYf9luRqLXNGGGvSeQo4jQeqo2GJ0d1OWyAe6WpneGG4twbZU6xW0jrC1jxpBAkiQKsLtPGaD4uoNxy81kPJ8Q7uOSB1qHGfry/rnt8aRBHMCoj27LJfNnD8DVRVRUf9XAqwyiYkMsOQNnjBqtjgcVK7v7DkZieItyD47cwt/j4RkTakmgNtW/9BT0XIGbGcQwGPywvhZDI0B4E7C1s/IxfQG8NubEk3e0CWlIC7PT4N2+OKCL4kHxYgNvfMeasDP6aC7YT+Aa47KrYUefdp2J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(186009)(1800799009)(451199024)(38100700002)(478600001)(36756003)(83380400001)(6512007)(6486002)(6506007)(26005)(2616005)(6666004)(107886003)(44832011)(6916009)(316002)(66476007)(2906002)(8676002)(4326008)(8936002)(41300700001)(5660300002)(86362001)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xQ45LjFPnnwCApVruVa0Krq1gPo3izs8JNilMEEKnuFaIfHXyRIqaJa2RqJ+?=
 =?us-ascii?Q?FVR4DTQwuc8Bcs203fLrVuTB96nkbpy8tmNUYt2JajJKwAncf3QvbL+1Dye6?=
 =?us-ascii?Q?55McoaRJt1Ogig/7vCgh0pjIWXqpTs5xflss9XiWWvWGBL8V6vXLR28caz8p?=
 =?us-ascii?Q?/dzsYzqgDPe1cMzZN+0ga3pOVQAwMPuTo93uTsq14wha1adQA7iTl/CjhBH3?=
 =?us-ascii?Q?V4UEEaMNDqm0/Ci5eHhHiTjtd7pSKhSsDR6AsmyEPP/vqHiRH0aQJ7aFlKnf?=
 =?us-ascii?Q?WwjBjzPG0yWTgJmMEN/x3HIiTTmhGUv1hQD8TNkEQVBiw7QLjGVpseANSWnd?=
 =?us-ascii?Q?L9w8/CJewRgM8aZS8MzOIztro8ig4Ygjj2KYlJldY1MUtV1o+R9GepOwafYu?=
 =?us-ascii?Q?M0dLWiA6bJZ+9Nohui3J67mjtAgmSmoUVOqjBV+089WmeFS9tnpKML3YCAqv?=
 =?us-ascii?Q?bpAgiJa2kuOkAukvXy+edxqUGNEDIqCGST6ytBpv469XRjtaRe1BuOEqFk3Z?=
 =?us-ascii?Q?Mp90QxbUkGEkSdEof9OADZ+M2O7WgGInmFew6yYaAaHS9x3VcPq2B9XMchEe?=
 =?us-ascii?Q?EHoJnheWWBJpaAbG7h52a8pipXcMq1PRTRGf33Wh3hlxvGSkXlZoxatFI6GU?=
 =?us-ascii?Q?IBRdAkNpXvWRNwsQFs+WCYZJft3sIztrqDA/47dRtoAqZKiyInL4KAAQOMpM?=
 =?us-ascii?Q?/RZxJabXOhgv0gGMsClIbLt0KSae4wLZJeajH0UzV38Pn/VnKOBCz9jtvPYT?=
 =?us-ascii?Q?2UCNsmyhOaHRQgCgQw28jjrKbXtMp1EO2PlEhIy9MoHMAX9d4qdsOQg/bY/X?=
 =?us-ascii?Q?ibZDd6eQ5iHoKF+RLoeisqQNFf/Q2/gOMLaKNE+AW0XcQCK6bwDE05xvBSM2?=
 =?us-ascii?Q?Zeg++Xhzyp2fYrs2ses+rTaFBLN6M+8Z3kIKgRWDqc+ZL0qKbRJqBpNdsdRH?=
 =?us-ascii?Q?KTm4Y2gvFcsYj1LJjKLaYs3PxCgrqSx3sd7Y60R/cjJi71h3qVIY0BDhT45w?=
 =?us-ascii?Q?XFujme7U+1kiI4r1PPiFfZtlWvLfr2IdJKQmiXTAFi9WM7z8D+iwkQKjm2GO?=
 =?us-ascii?Q?4V2Y0H71YGOqaxzmNWiOJaUybPhepwIlHqCR/SrT1SWdFtu9/sQ2YbVkrkFy?=
 =?us-ascii?Q?EBehVw5QASPQ1hc55/uDKbIxxTH/rPtpIawKxmyqG0qZDXsTpw0DjHjqkumy?=
 =?us-ascii?Q?x7F+wJIz0f4Hq+khinPTMKcy9jwZCwyW3eqX9aiTXdDYaWtJfHooZLBe2tg/?=
 =?us-ascii?Q?HfiqeLYmoWQfEa/tNtke4JK8UknynbsMxaiKs+3I1salJuGuh66CyAYwuQ5V?=
 =?us-ascii?Q?SiTnP635dO7kiv/uUo/6AV4oZmkuf5ezepdNAd+qCtruqaQdRenaqkiCIoj6?=
 =?us-ascii?Q?+35p6+DEhRMLKtejcF2zBVHZoHswaN2+sjhtia88v421wtyuhZpwY/K00D8y?=
 =?us-ascii?Q?p/PHfWMTGZ+qx8vQtIE4UmgJPsmpPO/eiUJ9Jx8MPCoZBIwxkD0XECBiLnz1?=
 =?us-ascii?Q?XpPts16kmlaMlJvtVOEDxVQsl4TrS/djOKrpgaerLeytwH1uuQiUjTuBgZLm?=
 =?us-ascii?Q?leHeZ1Ght8veJv1U1W6bI8bTfzvEYBZXddK0kFwH1Xz9HlD1Zppwum+K5UyU?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6WEfjcuVn2dlonYKCsIvki3XKuLiRWyEAk41m+0RBwtiP1ofVOw3Bdo/qwAWIQ3vwUn/VesIXyXfIN1rui9v/QveD8Il8BmOBB9EQpLnZGp4X3wQry9orPzsb986izA/cjhjKpPjfEzepHf/hV5Rore8TD5MbgJ5TgVpaN8+WNuhYttk0W1Di2p3N4YUl1yEo/3VbIbWNjdFuqDKnRUhKsa8mYCXfDOt7oNfWfmUGlt4ljVLJJUUWM7OOqQnEt+gAQEUvQfRpvT9B4GVup9Jx0dj4U/IprbEIa71CyA/FIZs5fV/8kn75nAfz8u6W4RWBd5iljskKGWxggg2J5ECxeqbgZ6+8yEp4DQnG3FOu15T4V8gQAOSbY5n8wvhpdTdHW0ZDUuvXTW8Bf2Srvt9JhxuT/8QBKY5azSyXvusiivrGtVCBT3vwTIIXRxowuuvfbvS0/k9t2NDmR6TxgTK862/AuBs8PBYtFG+wsqa00TTZSMq1pEV8fVrj8/LJ5W/dlg48obAg/uiHEK8hvFcioqyK9ZjJ0lM8UYKbchWbRm7P/IJOFen8ZyY9gXLCM5P8QDAHkiuTlhoQLE2C14aZO9bgyzRrFEbJrhjxNb2DKiJJTxUYQGH5iZlBkdlAa3MevMZT7DA5cTunGksfFdWU5GXXGJQqqZPvED4n4D0d7OOdflYd/RCEROgD7P4SOlvgqC54jvS0KTi48/6Xqyvm2P4pH3JLdAGRVPqpxtx/McyO3IgdbSSaXEcIB44WapM
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a02225-c4fc-4e16-348d-08dbaef6389c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:27:54.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMr5xYWvfzzHw9BM+qUGnbP26knarRMLNrUd/AEEyb3mQafMoSdlqGDnlFm/X1DqTy//nI77Qr3izLuuAyqcNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5161
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060143
X-Proofpoint-GUID: bbFcaHTva59j5-pMrLguW0enDIQY5ZUE
X-Proofpoint-ORIG-GUID: bbFcaHTva59j5-pMrLguW0enDIQY5ZUE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After the commit [1], we unregister the device from the kernel memory upon
unmounting for a single device.

  [1] 5f58d783fd78 ("btrfs: free device in btrfs_close_devices for a single device filesystem")

So, device registration that was performed before mounting if any is no
longer in the kernel memory.

However, in fact, note that device registration is unnecessary for a
single-device Btrfs filesystem unless it's a seed device.

So for commands like 'btrfs device scan' or 'btrfs device ready' with a
non-seed single-device Btrfs filesystem, they can return success without
the actual device scan.

The seed device must remain in the kernel memory to allow the sprout
device to mount without the need to specify the seed device explicitly.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

Passes fstests with a fstests fix as below.

  [PATCH] fstests: btrfs/185 update for single device pseudo device-scan

Testing as a boot device is going on.

 fs/btrfs/super.c   | 21 +++++++++++++++------
 fs/btrfs/volumes.c | 12 +++++++++++-
 fs/btrfs/volumes.h |  3 ++-
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 32ff441d2c13..22910e0d39a2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -891,7 +891,7 @@ static int btrfs_parse_device_options(const char *options, blk_mode_t flags)
 				error = -ENOMEM;
 				goto out;
 			}
-			device = btrfs_scan_one_device(device_name, flags);
+			device = btrfs_scan_one_device(device_name, flags, false);
 			kfree(device_name);
 			if (IS_ERR(device)) {
 				error = PTR_ERR(device);
@@ -1486,10 +1486,17 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		goto error_fs_info;
 	}
 
-	device = btrfs_scan_one_device(device_name, mode);
-	if (IS_ERR(device)) {
+	device = btrfs_scan_one_device(device_name, mode, true);
+	if (IS_ERR_OR_NULL(device)) {
 		mutex_unlock(&uuid_mutex);
 		error = PTR_ERR(device);
+		/*
+		 * As 3rd argument in the funtion
+		 * btrfs_scan_one_device( , ,mount_arg_dev) above is true, the
+		 * 'device' or the 'error' won't be NULL or 0 respectively
+		 * unless for a bug.
+		 */
+		ASSERT(error);
 		goto error_fs_info;
 	}
 
@@ -2199,7 +2206,8 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case BTRFS_IOC_SCAN_DEV:
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
+		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		/* Return success i.e. 0 for device == NULL */
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
 		break;
@@ -2213,9 +2221,10 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case BTRFS_IOC_DEVICES_READY:
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ);
-		if (IS_ERR(device)) {
+		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		if (IS_ERR_OR_NULL(device)) {
 			mutex_unlock(&uuid_mutex);
+			/* Return success i.e. 0 for device == NULL */
 			ret = PTR_ERR(device);
 			break;
 		}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa18ea7ef8e3..38e714661286 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1218,7 +1218,8 @@ int btrfs_forget_devices(dev_t devt)
  * and we are not allowed to call set_blocksize during the scan. The superblock
  * is read via pagecache
  */
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
+struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+					   bool mount_arg_dev)
 {
 	struct btrfs_super_block *disk_super;
 	bool new_device_added = false;
@@ -1263,10 +1264,19 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags)
 		goto error_bdev_put;
 	}
 
+	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
+	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
+		pr_info("skip registering single non seed device path %s\n",
+			path);
+		device = NULL;
+		goto free_disk_super;
+	}
+
 	device = device_list_add(path, disk_super, &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
+free_disk_super:
 	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index d2a04ede41dd..e4a3470814c5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -619,7 +619,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags);
+struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+					   bool mount_arg_dev);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
-- 
2.38.1

