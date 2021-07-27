Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959C33D83A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 01:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhG0XDd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 19:03:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49800 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233242AbhG0XDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 19:03:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RN0jfJ017616
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 23:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jlVQ8v7FAdNazutMbOpbN6zZ5NLio0D2cXbXn3YFgOk=;
 b=ZUg6t1YG/ZEvk2SgqA7QKLLMdzGiQa/UTDK1CyJ3Sw1LLLLrJ57rkjMczOYKjCefponI
 v0FUqCTR1My3UaP2nEGogFJ/MHUHA341z6N0PHXSKsWpWpCUwOJkgJgZcFIWWOqo7QYZ
 +hPhINPfrURCp/yGulISi4fX/rXPKM6sMsr/n1ajAczdTv6NgyAWLDF4LCGoJJcquHZN
 3Y11LPSyhBtrH2RoMiAT06fIhAyYOvy/Ai65dqd6Z/IFwT70Ec1PACXEWpfjbDrTKob0
 3AjRvNb8MhazpSqpcI3Cpy64QoTFSSTdndxAkpgUnqzvBpZUBHtKFD5E9t2g+ASyMylz WA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=jlVQ8v7FAdNazutMbOpbN6zZ5NLio0D2cXbXn3YFgOk=;
 b=yxVG0YS3uqsPPqsNi6hMnPyqSMyvSChixu8o15U1QVKpjiMZSbL3VdFVjUCqVysISxk8
 ww2yiCpPSa3SNqRkPStGudXICEH7+YYLTYHk7MGEfgoG7LK6Dz3xnEnSt9UR/OJc7sAu
 AUrxcAsKTKcaWTSHjVZJkQU8oEeVO6qet11zCf9VRy9Ix99XnRix1EyyL/o1TkCgF85V
 WhvquQjfmA/092Qvk5h+F3qdlM5Chyx7Yo6sap/WlpezLxhQ0POUBcPR6IMtabSoPnqk
 vrNyVyCggHS6qEkIdboQb2gGmdOHlOYH9Ut4RQJv084XkaqT6fmXMHE8EfHTrsUyA2sh /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a234n2yu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 23:03:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16RN0vpP022720
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 23:03:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by userp3030.oracle.com with ESMTP id 3a2353wc8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Jul 2021 23:03:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOwYMZUzV4CPMiQ4snxOddyphEWw4HqSZaIunuwP06cuMTCFDVEuuVIBTGUWmRxBOXPXStIPAAn/XlcLeFqXCJjoCRBXF+cubVoLqwGy+uwvdMxHxsS/u0dFwlD5/JwfRH3cCDY5OTZv8p/0R03HWX7TAyMhX7vJl+BBgYaEbinvZEtqkJMpcwz9yhXnibiq4GoCzC67e+hhmMNnYB7ZZrCVsIa2PxzDzOVHkEnyaCbchyfw20RdSftwIh6FMG2z9QHMaBRyIm/2BdaHd0heL49a+TjPeOqDEtG6kWapsqzG9fe9qCZA9G8pRSRRQSK9Mo3J2IvnDnDFvviWjhm3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlVQ8v7FAdNazutMbOpbN6zZ5NLio0D2cXbXn3YFgOk=;
 b=CtkLU35GOcCKhB+b8JlrCq1qwEkjPItlxvh2eNBWI4w7lNGQaiA85BxcgNSrS+V2yRVgF7RzN1vlaOUMV7cIFr9ZnuZyw+bfI3VGjAbSLRDiydza9P8U/NysDnoz5bfUUOHQiNbH/GGUEK5TFOfWFP0fQCCbw8ro7OGknjCbXSp9ESNXGo50LevzsdS/p86fwx1fEfEqEeHifcD4KJGPuaNVrzN2zQj/HrAm6IXz26vDAuO4dTZ2UsPMe2s4X7Cic+9OQ8uadW2MtV7PY0h/BnyxlNf6O+Fm5BKn3PMquSb9ciqDIlxgHCzQgr3CACR+7VPDvx1dTO0d2LQF/ntfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlVQ8v7FAdNazutMbOpbN6zZ5NLio0D2cXbXn3YFgOk=;
 b=liuDASvLkhpW0tdSb6hf4o+ccYv3UZlaw3SQYJVHtI6oJa5n+EBlI7Lj0ubzYQm/K7NY5WorMSe3LIAaUthTIetOTbRpd1oJQ13ByMwPdP9EszRTlMG1Q+IWqmQ01c9W01A86OCJJMuqcMPJo6psfj/hdkYlozGH0LJb4zyBqXs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4048.namprd10.prod.outlook.com (2603:10b6:208:181::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 23:03:27 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b10f:7144:1abb:4255%4]) with mapi id 15.20.4373.018; Tue, 27 Jul 2021
 23:03:27 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: optimize check_raid_min_devices drop ret
Date:   Wed, 28 Jul 2021 07:03:05 +0800
Message-Id: <1523fbf731f23108f3b490600d1dbb1c9a6360fc.1627426829.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR01CA0149.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Tue, 27 Jul 2021 23:03:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8da4da9-eb08-4f70-a124-08d95152be10
X-MS-TrafficTypeDiagnostic: MN2PR10MB4048:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4048A19E449E4FF0722ACEE3E5E99@MN2PR10MB4048.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNd64q/hfG8PJJLAc4zCIAjf/OJjFJbw0ETwdjoMDiqcETTkm8W25PNbNjrDRe7HNGYxbVNvjsTLBMcpTgwxcWKUFbDWbfZnpRL9QAgr2lOey4imMz7g9J3hXAj7mHcQuWUpDhJHbH3K0i9CcZVjTLTzWWtGY1Bc67XVCchh8cfGqzhYbvXbTeiiUibO/QiKzOokzjbHGXtbFEKNZsb7NE4TFw2+g47ebAM3hZHiDtIsnz3lo3DxVrd2qKiKZMM0xyOsP5/DqLuZcEXFtqUF37e4Syxa+SoJCA4FoMfGtUzuDm2odzcyAiIxM82MOfCsB2EX+aAiOc42R9ldGSfe+UfAhREAOuPJYY5bR5A3yr59t2pZqV2elFQO2lVRgSF0G0y08wzwL28MC34KchNbB+CvjjoGu+6J+7+jwt87ogDaoVEXnxv2UgRVPA3SZY4UhFqNOa7nCHXkx+K4KefNkNDHwmKkoi0B37RJ7iXWCxMR3ZJ5SCCeE128Nkr89yO4YTpSRBZBrnarx7jc0hTzzJJgqh6nKdWGU+J2Q+vR7n1w2atA5+48LlfbetaWUjnJ4ImN4wHZINMzqNswzWAT/RLm6g8eKZ2XOUMl7j2VAYFTIcksdqMPZVGM7Ht9utR4ck0WLzYQlBahi5RB3AgYPqFwtFiTlc6uVhiJVb1mnQ+1rUpj+q/u3i1Xd8jCqnKVgNQvpyugbcyJRd6HBs27Ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(346002)(136003)(376002)(956004)(186003)(2616005)(4744005)(6916009)(6666004)(66476007)(38100700002)(66946007)(316002)(52116002)(26005)(6486002)(6512007)(478600001)(2906002)(86362001)(38350700002)(44832011)(6506007)(66556008)(5660300002)(8676002)(8936002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nkvb+lQGM46boM20wAu6jRn2MpuFbHbht1UrOMJfH6H2XLgCZWD3KW8mspCw?=
 =?us-ascii?Q?1vCZ4fsyUsdIlkPn4U3NnmXosDj9PbdCFSnyVV5Y8iW4vKGR/Q5kjRsEH0CU?=
 =?us-ascii?Q?vfGUc4ZkO1Uxz6+FadTyCk9Qs1cnSTDLxLvp6xb8j2cdHtpeeabDmF3e4ru3?=
 =?us-ascii?Q?VolFCP7p/E2KuyCdyCdrd6M0w+0mAmdRxMbWN5hN/OMKD6HLOzzRUgqZhWRW?=
 =?us-ascii?Q?YWK5eNdvqr1FhZcmK4/iy3V7ULeCj8Gm5Wq4UuwCItlSxSBfWhzkHfiQFbSW?=
 =?us-ascii?Q?juriAykUJP94Ttb2/dCEOB2X0TEI+izHPW6iEzjWwUhmVpiibmpLC/97DrG9?=
 =?us-ascii?Q?VoHx5OmQPkwonx+50la3eY/Bd2xLd9a54aWxyJ+nJ998bJfV4mlbrF2uBpfv?=
 =?us-ascii?Q?ZGgk1sJpS+o9j91iQCWqxqlpgIleRRxoEWzkjt/gFwFse6kkwGWPz1DQjPfl?=
 =?us-ascii?Q?KMFBY1jtSnEYmrVbQ2dbdQsbq0xr7SCm6VtZa7e9tH20EKUfduuZaFKQeP+n?=
 =?us-ascii?Q?AInBusZqBqHSGVz/AQBNI7gy8dGv/xDkUnIz0+2DZTzDMo9KAt1AtqIdNsrU?=
 =?us-ascii?Q?LlUKAxDtzD4NM/4jk7GkQDGbX/nAlOGzMxoj5PR4nYc+yOEiCjDiIU4rJwZW?=
 =?us-ascii?Q?rmKCXrRd7myGK8dDWazlVo73J1jpTo1jXuU+bhxKrmJ+WyrLFv+iuevtpCmS?=
 =?us-ascii?Q?TBblvQdxH7PURMn1/QHLLsj00nrWAHgu5lx3m4GIPGX/l3qvLhqB6j5jnssv?=
 =?us-ascii?Q?X9xYNFZrOu9N1SOEQxd+rn9bbTaQ5Zh2oS1xwnV+BD70zJ3a+zISmdnBk8m1?=
 =?us-ascii?Q?kgIl4Pa4F+e9yk0RB1q6nDivY0P/EsdnY3fHFt5qkVMCpU/ymq5GR2xvm1Qx?=
 =?us-ascii?Q?3rKy1b4QgWDT6Af+49G2mEnOX6GkofO4WpBBBEysFy6dD5EzekL5ZhwjReWb?=
 =?us-ascii?Q?QgepK+YTYmhnZZNw0YrbgBNXegxctz6DyfyvQPsktRsJnaYrU7D3cwxfZE5c?=
 =?us-ascii?Q?8ED/ppWWnFoW2qGENU0yU6+O0Wurj//+uJ9PB94UdrlJU1RMmtDGNVHS+hQs?=
 =?us-ascii?Q?Ugby/0A0dPk6CKjU2cTVOM2mcKrLTV/OB4vnFoBDFX9+bdFLrDKGiunnq7+A?=
 =?us-ascii?Q?D2iaJkrdRms3oVmHEBaDYVA8r8M2GI1Cisj6yX7UzV0arjRrBP88PjEhTeEX?=
 =?us-ascii?Q?XixT3PJpKHHPMicSs/RFTyHF7ugEbioxFKRlkE7B1pUtZp0tyQEmmtIM3X90?=
 =?us-ascii?Q?Q9N70Gpar5yPDgoUo4MUGO6ZedXxl9QqfMQsRcgxENxEAd81kbcdu1nhYS/6?=
 =?us-ascii?Q?0q7NhCI3aCLvHmIbwn7/UbkW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8da4da9-eb08-4f70-a124-08d95152be10
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 23:03:27.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDyi/xQZ/wZQpKheg1UC71orPNM3epiSYLT5wiuHRe27xkn3m+eByUm8ub43bxsiKcPElgNrq1P1Pdtb5AHA7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4048
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10058 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270133
X-Proofpoint-ORIG-GUID: 7WTFNUfjj0UswrJJjFkwD-hExUuEX4bi
X-Proofpoint-GUID: 7WTFNUfjj0UswrJJjFkwD-hExUuEX4bi
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function btrfs_check_raid_min_devices() returns error code from the enum
btrfs_err_code and it starts from 1. So there is no need to check if ret
is > 0. So drop this check and also drop the local variable ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 887e574266d5..391d5e8cd847 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1961,12 +1961,8 @@ static int btrfs_check_raid_min_devices(struct btrfs_fs_info *fs_info,
 		if (!(all_avail & btrfs_raid_array[i].bg_flag))
 			continue;
 
-		if (num_devices < btrfs_raid_array[i].devs_min) {
-			int ret = btrfs_raid_array[i].mindev_error;
-
-			if (ret)
-				return ret;
-		}
+		if (num_devices < btrfs_raid_array[i].devs_min)
+			return btrfs_raid_array[i].mindev_error;
 	}
 
 	return 0;
-- 
2.31.1

