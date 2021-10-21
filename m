Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32071436E8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 01:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhJUXzn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 19:55:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60264 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhJUXzm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 19:55:42 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LNipri022862;
        Thu, 21 Oct 2021 23:53:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=oOmEkEsaWyg4vkE7IkGsMJX0SQgXzNJayfniom6bGIU=;
 b=VBGtowWur1vVdjRYXY7ioWmrXR4eOEKAwZZ5YQ1h3VcZBCfZpgUFEGxuOwyAsFPNZmXb
 wetTW7Cm8KQZPoH+Zi9XF5rHc4enH8izNhV6bMTY3JtiSWwCyLJOBd5gS8IyuJRjSm0e
 C0sk2AtZ6KQRWGt8ZOUf8oer92EU0DnieKFY3oZvF0egrud3yHP26WGUUHzJQBxxQT2x
 X9drvOKTZP4i4j1WecEIUau76hvUxd+4iyKuF20ziuN1llGgWNro93PLPrKnrdB0vphf
 h/kRJ1hyPOuxTT/WNSlddtSCx0tN6NWyuCfOmXLux1MstjkNH4HNi+BxVdNNq/rPTM0H FQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj91s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 23:53:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19LNovRk101701;
        Thu, 21 Oct 2021 23:53:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3bqmsk1h64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 23:53:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy811SviJpW8nGKse9qPQYVWtYgyCKrWCGcZibqmp+K2KtIAXC4JpRGshHtaAkdXFix1cqmp4BnfAa5omwFr04iKrPIYsCUW+VdzzzTaHHK4b6jRaNcr57fLjoR2RMtPO7q/Epw+aGMHQX2ued9t7kVJcsBCoaLjp+f1IKe5uSWrzX9+DolfI2rm5lH3dRt5RsZsh7UsQMn1kd3Ie0o2Su2h4EmMMmdxd/VU7HGH066i+d3HSZqd4PUviNYHybgBTZP+zXJZL6YRQaTaisNaqg6JIDMfA++KleQH7GDpFki9zNBvcZJ1VIoM0UOSBOgVKagQpHHiPjJKNkMj6h27YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOmEkEsaWyg4vkE7IkGsMJX0SQgXzNJayfniom6bGIU=;
 b=SCwHEfHhRQ3tMibtI0UkEI1U2HIDWrQzu9O3ryAsAsS5dQp/neD1nVnvd6nh3/w4ncQJ2QOub/TqFrkoexumoNli725E0WBMVzrvtdnuA974Nczf1qBKreeq4rtT2ng33q/I8luL0F4Cw5+JjXuWDbsN2nsgHcaDAcZGN6kTwEv5fZ6JP8H1uT0LGQXt+TuPzuKvjCETNRxl7Yv1zWbuBlADBeX4TwdM6C3a97pL20ECupyR5SzizrLNgxq4eyqJiWwyptX0ikNQoaXCCNkVftwkjxUzP72SrWba+6qSd3ueS5uZxCQak5IxXI4th+coJNbQvKyH4YUFNle04Nmu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOmEkEsaWyg4vkE7IkGsMJX0SQgXzNJayfniom6bGIU=;
 b=XCejwm/OjFrLomDnL/IRfjJefgXoECQ69eIIyYNB2rGFl2Vnx+ywR/MXA1FP/xs49bRP1kN7bBYoRa/iytiOfHxwrNaUDpt7e47TA01g5OxPN+SwJtDKce30w8lFTZrzq5UqWeXy766RqS6Op5MAr3uHdGoUA8i7nt+1Akd4STY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4366.namprd10.prod.outlook.com (2603:10b6:208:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 23:53:18 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 23:53:18 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     wqu@suse.com
Subject: [PATCH] btrfs: fix comment about sector sizes supported in 64K systems
Date:   Fri, 22 Oct 2021 07:53:05 +0800
Message-Id: <59371eece911ff3e73517fc9e3fbafa843f9bcc3.1634860167.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::26) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from dev.sg.oracle.com (2405:ba00:8004:1018::1cb2) by TYBP286CA0038.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:10a::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 23:53:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62f45ef1-da6e-4fdd-8b99-08d994edf48d
X-MS-TrafficTypeDiagnostic: MN2PR10MB4366:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4366F359B3038E9E425C8C89E5BF9@MN2PR10MB4366.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87PZWSU2ENrc+4GcFb6UDbxJQNWjwJOWdG7JRqvlq14EMkrB18a1v9Ds1iAz8SarIoSoo1OLr4bOxPpWjYCMuNTDxkOsLpJXRKlYjsScp0aJ79MmovTHRkcg+0CfJ26Uwr+bDYB7R7Y+96etH/4V5HdPyp3sBW5fiuwrK2DdsZkp6pKELuifYnSqZ2uWbzSH8Nzy/ShrpO+g/NqTAUqLgtSMwnVu/MzXZjWK4UJFOye79KV8IeCF3h4ruYrtblk9NGowwGu52OrmA3X2fPdRrSpwJNcM1nlAG/4Yv7SUwhscarMNsJDirBmSQ2Is8WfyOnDWzcpzvBMucvVzLl9wknbgtVHsF2ZNxpDx1Yf4FjIaNZw7YnIuOH2ZEFvCG9T8PY03iwbQbansgmoXam+NgUgg68PGGsXeveJZ5t6gAG69HiAuz5uoYvqfUMEnLrq0cibd2b6mTDE+oAnR19sdJsenFw+DFr1rbk/qp9MFTQxy2+/jot9Q3WzdWIn3SrxM0NcIegnWRLgT9dj6GP8n2gkZ6UTuWRQEkQuMIdglz/rlBpl/y3TeufDSP4j+NU+cVE9ekgzTXAtmAi9RcqWX3Q2XQVV/7QEpI6mUvjsAj/zTXU8D8mDqLo82JSYqoLz3ctgBF+hklt3325vn/Snakg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4744005)(83380400001)(186003)(2616005)(6486002)(7696005)(52116002)(86362001)(6916009)(44832011)(66946007)(316002)(66556008)(8936002)(8676002)(38100700002)(508600001)(66476007)(4326008)(36756003)(5660300002)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?33Ql1wD1na6rF795jZc2YFmUPkXDzZhrB1WfMMEFur/DKq/0MqQDO1xguAkO?=
 =?us-ascii?Q?6HgAd91G4UR/52wqpXZ42KYFw8Tj3XempqJIhHGy5NCfalULwSxrYRqca4P7?=
 =?us-ascii?Q?xFGTNRK2tVm2cqqP+KXQag97++3dgZWvX5tPWOBkz5NxZAk9vX3wdwquionD?=
 =?us-ascii?Q?4rjPY9khWrncV+4spQhvjr91r9+v3i9GUOlNFxIbnec4fDdOn30b6LbYO2w1?=
 =?us-ascii?Q?5bWOGI2JwtTJZi+HafsVrKOx77OJ+nLodavFVZRlXBmci9Ae/LvJ3tGkwx3k?=
 =?us-ascii?Q?GklX1NAG/bnISa4gaG1dv/vovjMsEYEOZ0pf+hoWpQbhGqW0sc/uzA/nagaF?=
 =?us-ascii?Q?kydUSAMU/I/N3gE8OiV42PwhKeDtnPPSBgOoZyuyqkeQMhzvYHKxD5amsSq3?=
 =?us-ascii?Q?Nd6Ai0CraO4SsweIe/j/flQfBM5c8uZEZmgnLGd74imIk0koCCmHW4ieGRdQ?=
 =?us-ascii?Q?uF587gYez1FbqEDcIVz8L/hw123yyzgGWgovuhbonHumggJEANIqRBPrcuvG?=
 =?us-ascii?Q?dO0WAsUeI+pnHPuRw7qQczbsrpnGJEaeV+TBhpVSJ53y4+9iLV1jEhHrXtrm?=
 =?us-ascii?Q?ulmOl3dvu0yiP0RIpOJX/V0hI/Gyu/miHLDLKv+RooDCeZhNS99nuMEV28Is?=
 =?us-ascii?Q?rWehnnWG0KyDPHiS2g9GTkA+Yg3V4vKO9PTV9gmgyule3iYKFHDwCmxu3iy9?=
 =?us-ascii?Q?TWx6N6GRkwMk9pVSBzoIZxaT9IVsleQH29p2//prFFDvOV+XWAqPQo0CuQ9T?=
 =?us-ascii?Q?pdMWzMWjSBP5XTQFcXDUzliFs0VlwCMJXiiWOGUksxBziiV3of+Gn9olaZN6?=
 =?us-ascii?Q?9FGqlCBZoWW4SZTokBCbVm5WROOHYtrt/bXQstN65NKm5P2eraxNhpRkMjYl?=
 =?us-ascii?Q?pHe5CTgghrl6it8zDtWIJqp+5SeQOw0TgeLw/3gCGm5U2B18lOaIkP6+3/dV?=
 =?us-ascii?Q?v5kejPyOv9KnvczxxYU+XgrMklkTexuM4Aut0N3x42U8UBbB5NVRyFUHQ4XK?=
 =?us-ascii?Q?iyFA8WWSpi1s+ihgQOJxlLuvBF3t50Ro+kWlHeWXiEhDRlveBBdfI+P/odvC?=
 =?us-ascii?Q?ITqKd+vBpquEkzEprhCPl9k0BfLh2vVxdAUAuTUSySosBWohR1Z9+GFQEbN3?=
 =?us-ascii?Q?WpfogxaBe0kySEbbQuIQ5XHV3kEvj3sDa5sVRSW3ztQIWp4opAg3V8uni5KY?=
 =?us-ascii?Q?v8n2WKRGehCC0Mv52D2uUhq7mcVYFuup5aDmElsO1zfWW79BG/yN9AagJGZX?=
 =?us-ascii?Q?/LtUJzoIlM4u5/CN5q4FlmXD1HAVfVFBJ+IWqi8qyHgHXHgIxRiQ1nU6Navv?=
 =?us-ascii?Q?FzMAK3jVchZDRNbgTFNhN7XeIdDf3n1p7Qgh2itwsHJgc2Qa7aGogHqr0zqy?=
 =?us-ascii?Q?eWOljyypvTaOqD/JGr1XlksJorusFgqW8ZZ6WE5pmsBp6NEp/2Rjwf8ErpiK?=
 =?us-ascii?Q?IdWHLv+2aEG/ON/ZfBTsOSY+/vDH5QP2l7ZBpNqhEKCMF7Ge34U6Yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f45ef1-da6e-4fdd-8b99-08d994edf48d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 23:53:18.4585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anand.jain@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4366
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10144 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110210119
X-Proofpoint-ORIG-GUID: f-78dd3ng5YQx8_rWGZd4IYJje34EFTv
X-Proofpoint-GUID: f-78dd3ng5YQx8_rWGZd4IYJje34EFTv
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 95ea0486b20e ("btrfs: allow read-write for 4K sectorsize on 64K
page size systems") added write support for 4K sectorsize on a 64K
systems. Fix the now stale comments.

No functional change.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0e44f89b8664..2697b8ede289 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2592,8 +2592,7 @@ static int validate_super(struct btrfs_fs_info *fs_info,
 
 	/*
 	 * For 4K page size, we only support 4K sector size.
-	 * For 64K page size, we support read-write for 64K sector size, and
-	 * read-only for 4K sector size.
+	 * For 64K page size, we support 64K and 4K sector sizes.
 	 */
 	if ((PAGE_SIZE == SZ_4K && sectorsize != PAGE_SIZE) ||
 	    (PAGE_SIZE == SZ_64K && (sectorsize != SZ_4K &&
-- 
2.31.1

