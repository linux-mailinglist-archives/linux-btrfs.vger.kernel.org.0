Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086B542B38D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 05:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbhJMDaw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Oct 2021 23:30:52 -0400
Received: from mail-eopbgr1300139.outbound.protection.outlook.com ([40.107.130.139]:25376
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235482AbhJMDau (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Oct 2021 23:30:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hN69wi7i1XRjKEefrqZzCYTc0QA9KiTubXEcjp/lA2QfH7jL7+iZNb4VjKsE32QiPhJcYq5AR4fVeQP9h/tCTC5LAERSReFujYK0fTBIipFbMyOTjNmeISknpORKTAN24Dqk0VZcmICD5Nafr+wnPd3UDUjy9cwWD6Mxy3qg3Yn4KdQusOW2unbELYoGvP0qwCydVuJU2+4S5JhDTzAKsnxQc4yYwhUeaNDI8+Z2lElKhcyUlyd/ZX9OG5IAJNk40hZ4bAfNXI+GyOd9bWLO01y3aNRMXsXT/4keuJ784KI+uV6JfMuFXJPaYagtCa/d5Vvg1B+SAdB0W9zquBPXGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU63GKDNKcnshMFJ+MnONH1QPqManTck1lOsSmFLz4c=;
 b=MtQzr5wEsqh5pHIza248017gj+6sPGTwqwzHQy7KyKnCqzcQKxPadxvg0zUs8YqHdNJoLqzV60lLJ9vC43d5fo45ed1l0SCde2prfMC7wNvOOM3ld8PKkq/ikmnVC489xn8gal3M5rxRyUb7pC35t83ZmAw0bQraUkK8aoUBdiPSI7O58UeuDYw0+Em+vSE0LxWZ74boAc/44R46I2Pp7SKW49/WVKxe2CeAN9LP3CMykYnH6F79sGYUh1wm3PfYQcwcijQGC0P94kMc1aiCIAGQsPgOGwL8WC/UJ9EkHUGnI8iL25TJYt4sHJYsw53t5SXZyo2Do/lKlrvHVRiOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU63GKDNKcnshMFJ+MnONH1QPqManTck1lOsSmFLz4c=;
 b=aE1dp+wytvxt/5+OSq78vXJ19GGgkO1YobRYzm14g+ULgs88QnoFJluMn1/a1VtcpJr66V3O7nGyOuFPxxlpQKu7gOfH2Hd6M/d+yWdaqeG4RH2vadx3badsLiYyvjTLOACm13mxxB4HQn7KypsR58+N5mA8yEbSHppbvQI2gBY=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB2955.apcprd06.prod.outlook.com (2603:1096:100:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 03:28:45 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:28:45 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] btrfs: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:28:37 -0700
Message-Id: <1634095717-4480-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0159.apcprd02.prod.outlook.com
 (2603:1096:201:1f::19) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR02CA0159.apcprd02.prod.outlook.com (2603:1096:201:1f::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 03:28:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 159b96e7-6c79-42cb-c62a-08d98df99007
X-MS-TrafficTypeDiagnostic: SL2PR06MB2955:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB29555AC8AFE410A05BC0A482BDB79@SL2PR06MB2955.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQ5GPeG1uc9QB3b2dpjTW19fXkDKvh4bzvVTYlKqrV47pj9Cd67+Y412Ea5OTGCZcmjbOMB7Er4Darcy4L6Va9dBCIFL46NF6kcSXuhRqBqS2HAUfhJHQdgI2n/s7odTNIXeZOcktW8JJyPwzKFRrKIFLC+IsyCLGYtQbdDNAoSGnYQBkGWZP0ibn0NQFetYLxRJjkCd7N6F1mfynTmTR+bGDbPb0CpvHk6GJgTVL6fzuRNRp/oK2u+2kFHBUNmpTSSHuQYAmNfNQjoKUHHMk5ZRyUUxFEGn4du8ZsRp/5fOgh7YqWwCjU4RVVMmHxia0GLpOXFomA78pa6cCC3PI5InUyjevH/kWBCGhQmG+8nDzLTth8mUnabiSYQaf92N8Lrg1qB4XSzwsVuPegTR2spvacgbzOVCbJUy8vIGmC6IVvgWAafFCTh4lBsnZfUW6Wg/pQw3VymKtbvF7CmegDXNVEUg5U5UcGI/PKDUuPDREzINPJLDUejEr2ZzQ29YSGUeCB6347WV3W2lVyNhWAANzu1Cubx64Ub0GVmrmYu0UfqeJv+ZmDjnTyEvJ20OZ0fSeIo3M9EbN8J6qu02XSQnxa5Oy06KMLBuI8aL0nSaKevTRYMSbuSxSfm1hnlMU+nyxEHb0lbQJB0ghu46DGxnQXWJ0JJz2AISAmtpgOZvR3ziyr/tF5Uqhu1A49OfDRNIO+LpWRaV4UNA8wGsAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(186003)(6666004)(107886003)(66476007)(66556008)(8936002)(66946007)(110136005)(26005)(2906002)(6486002)(2616005)(36756003)(83380400001)(4326008)(52116002)(4744005)(6512007)(6506007)(86362001)(8676002)(316002)(38350700002)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?efwBiYrMNjqjjkbBvbhQhFZZF8kRLKqDG8rIaAWRiU0fQqeKWCfci7wVpDn5?=
 =?us-ascii?Q?prb9QpSQIgZ9tRyhDrwISb8gBfljZR1uPDGNkrLPmMvBHyHr9n5NTIqH68KW?=
 =?us-ascii?Q?gGvT8quXjAddo0jVYIHnDqgL6fGjS36oh6wmN8Teb+h3wp15TZ3i7WVS6w5m?=
 =?us-ascii?Q?aj5wQSJZ6T4J644D38BX7Ks5HqlyQY3mc352GICjmBMRdCE+Sg0VvAev4gQH?=
 =?us-ascii?Q?1u+ZUuR+Yd4u759OYK+f7YkNJvc2XJtUqOzPGzwstoklZu8cXyAHft9/Pef7?=
 =?us-ascii?Q?KRwWrJSdrd0R8sXsy2MUwDP30wkUEUFD2QzNz3lhorNwHWIyO1Bxq5CVn893?=
 =?us-ascii?Q?DLDp7xaFvxLFlIxZSeGED+3fZ+Sm2/OC/xw6HcQyOSQo6HKxShKaeQSHRzuE?=
 =?us-ascii?Q?hY9aoy7VFH3fvXL9RGiOz3bUkHaeyfFuv5zhGYbhFExnNI9v02HnKH95zR2n?=
 =?us-ascii?Q?CPPeECN6kXodNNOKW0mIis5KBa0bWwR5fIaReRpT/RpPBCg8g0PXoaNV3ckh?=
 =?us-ascii?Q?OpJ6YcnP1fFryQe+uHAEodwJ8ZAfGPdE9ErN4q0OrpTf9f8O+AUdhBXNGyKS?=
 =?us-ascii?Q?igz24ql6ChtA3ngQ6OigP3ifnjRUoau5Y6v9f/XUqYUtsx8V1zeSAJwsZKvq?=
 =?us-ascii?Q?VVx9E7PjFBsfgMPkFhFBfFJv407sLdgdutLqa0ZN06sBeGz449ZuQKWuq7bT?=
 =?us-ascii?Q?E9cA5sopmrLOyxEetuYJycBrE0uVPzSZirmERclFBczgNWzLJ5DICABPhNi1?=
 =?us-ascii?Q?jlhPOZhq973dU2SKkBI6rxE4C70S/xn0ee2a+pfWFI614X3kqny11r0jt33w?=
 =?us-ascii?Q?6yB/MPmDCy/ZQ+rWUfETq17IuDpWu+8MZ78PHFGOmfCghK0g3ZpHCYBF+zJ5?=
 =?us-ascii?Q?0yg9yt1lNR7acfJjGy6gyOGYs2aVZCXq9FxYdJtJtScOMII1x3z4tmC6yVz2?=
 =?us-ascii?Q?EakL8rEToRiIdSe5+NwNPyn9yCVoOMG8f2Hkl0hIjz5xsR0UKEZzHp62TLpE?=
 =?us-ascii?Q?D9BF7NN2TSmdJW0+rF+qBVytbNMOZBHCb1yVM91C2NGuz9u2wh2TpryVjkMF?=
 =?us-ascii?Q?HSgCXmX9KoMocNdGjDynpZU0w3n+BvwJUanVH+QckKStf0/vshC2ajhdrdJ2?=
 =?us-ascii?Q?ESTJYI4rj9m1qbrpL2n9bE5BhnybAUkQx0wACS6Bs0Qfdy3V9rpfHueWDF5c?=
 =?us-ascii?Q?zOr6phvNG96HC8kSuiRw+yK9KGdu/SMcAyjSX1tUNH8sC8Xyawgx1blQDivI?=
 =?us-ascii?Q?5zl286JmRiwzG5FrPk0TZWX2B1onibIVWoshpGokNju5qMDqeagfc+ATeKkp?=
 =?us-ascii?Q?oueDUPZZtnMpSyD65W4yuDoC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159b96e7-6c79-42cb-c62a-08d98df99007
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:28:45.4126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dj5HwI2OXcskRHmk2zXSHPjrZek3DzkzN+EZtRwb627DOotRFSDAEVl379uo6KdUZS6sPvz0DirthrqA3XZcbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB2955
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the following coccicheck warning:
fs/btrfs/sysfs.c:335:8-16: WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 fs/btrfs/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 9d1d140..fda094a 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -332,7 +332,7 @@ BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
 static ssize_t send_stream_version_show(struct kobject *kobj,
 					struct kobj_attribute *ka, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", BTRFS_SEND_STREAM_VERSION);
+	return sysfs_emit(buf, "%d\n", BTRFS_SEND_STREAM_VERSION);
 }
 BTRFS_ATTR(static_feature, send_stream_version, send_stream_version_show);
 
-- 
2.7.4

