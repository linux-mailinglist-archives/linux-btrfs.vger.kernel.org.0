Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A1C3F1FC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Aug 2021 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhHSSTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Aug 2021 14:19:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63986 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234488AbhHSSTV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Aug 2021 14:19:21 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JIHCt7019567;
        Thu, 19 Aug 2021 18:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=54r/IkewdguWoy+IkFSAjsMTDqVEGjJKlDp9akYW7mY=;
 b=n7OmB4Pm4CNldcn2ldrlf//p70JurkTPSW/AzKjZUq4pd9VtE4cHwN/fgb3eawRCHzCu
 5+pMyVTyRPpOVRACXFIM/Sn1l54s0JNySTPRjnCsm4eWBjkUc+EmjetJVfDWyfPUvkhu
 dm3o/6j60H/5KZXPqyxvQZCDFgwLRkLXtyYouFQrvPjCeOnbMZnLItkac6iYhGwHBXTS
 r5ZIO6dfwnMMXxBlO2Bb+jI1KBgor+ygZ5fSSXx2pTX/X0RtsKFmOyclB6FCOJskA7pE
 94jsnN4ea3RZoaCsAgkpaLOH52oeEAGOay/Utc6cB4t0BomHis+Ih4v6ZZY0Trn9W6PR VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=54r/IkewdguWoy+IkFSAjsMTDqVEGjJKlDp9akYW7mY=;
 b=LJPLQlWrKGIY0e8OM9W29tH/pVPSoRMuo1Sm+OeYmxiQBXWvTq3QzrPByq1QZJxHavDq
 mOb7ZVGqsZc49npmLGZx9/UB79lhsPwtD+TaKYFu5fTLoZH8NIiIyNKL1YV0X61vtTo8
 9PThXHdIyb4wr6FHNzZZcVzcMRGLFGkq14g3l+ZQLjgLUXiYlDenYk4cpklW7uTsNmzJ
 hKxfwEEiiIrgHxe6IquxFsCdIc2mdVe/lNkdRi6blOOWJXHxArF0l0xf273JKM3JUlYm
 3jdgI6EFePbP2JKn9trydRCgZhNClAVeIorWZhq+Zv/dIuX0U+3CQH6xwoTDisNMllAl Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahs5cgkhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 18:18:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17JIEvcN194541;
        Thu, 19 Aug 2021 18:18:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 3ae5nc0pfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 18:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrPlYavnDHjeXi7H7cf5n9GbH2O9hk8CAlaGUzxZ0K5b/u1MX+2eNNqATh7K7/3Wb8QHWYCCji9GrENiAYArZDsNEIVsRJBvUZJQfwogqSeWLko75fcz8C97VyGOXF5gflKPrZ9eX6L1FwNKGclHx9K2CddR2yw4RFlC5/mLpEKhCJQdCyDVYU1OlWBuHxmEmboHCF933jPWk/uAt9/KoBeuZkNqTP4EBnByMfz6CLtSNfU/vX6X/6TZbYjRt/MUkY00I8jEKi0/aVJKee2IzCjRlRAiNiWXbqRyHh2fZ+/Z3nS3FXMxucNNsQrrcTL9jpodAiw64AvpKbbg+5i/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54r/IkewdguWoy+IkFSAjsMTDqVEGjJKlDp9akYW7mY=;
 b=X4mMxXaatZbsFWKYlolfRmQDWQIdHPFhaq/oBDa/Ne1r73hQlkucrZu54NW0cfkKOMAj79HrfMXvRbEBTrqFU+bckFC2/lnDRAUG3XCCL3UVyhYETqVWOcWNIPV8QTO1yr05O9HSLJRPpdOCuLLp1DdN3QbZ7h0XLQt3IvQpI5UkedAseL1IdpP0unlCIypjkDf/tvcqMUhOZ8o6Q6mFiF0OuTubkY05PMpjMuX098SiUKCtRtyOyuZHAf1qg6DkU7nBJmBX7iJI5qfnqlO6PKkJQPhcCa/9Tj9DwhsHCRZ9q6MD2SGFndLJE5VnGwR22ihUqFh9MWTA3ri4/rJPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54r/IkewdguWoy+IkFSAjsMTDqVEGjJKlDp9akYW7mY=;
 b=lM40uRMm1gPFqrWDoRcsYDWvnz4OX9RMSjHoMTD712kZIbOlWWQ5I0VV3n9gSb+LEWnYwaDAmBqZ6jET3aBXSb4RIEf6KcbUU/ythh3Ejr4HIa1luff8ef/ulBbg3SiguuMrjvRjvx+tA6V1efqLCwAWH7SzQwJSeArOzsavwKg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4127.namprd10.prod.outlook.com (2603:10b6:208:1d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 18:18:33 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Thu, 19 Aug 2021
 18:18:33 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH 0/3] btrf_show_devname related fixes
Date:   Fri, 20 Aug 2021 02:18:11 +0800
Message-Id: <cover.1629396187.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (203.116.164.13) by SG2PR01CA0114.apcprd01.prod.exchangelabs.com (2603:1096:4:40::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:18:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c38aedb-7e56-46fd-57b8-08d9633dc0fe
X-MS-TrafficTypeDiagnostic: MN2PR10MB4127:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4127D2A0FAD41677F06EBC82E5C09@MN2PR10MB4127.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYkYgABeSipwShk3pKI7X3Dq/5Y5PrsDCvYOMRAhX4yimVBM2fOPuC2wBtrPGWy0hZjU2nWz9a8MitsoNq6B7I24bzQl8B3pj59f0g2pdCtOHb6SB+GY9qZrT6zfJjYLpvkP2XyjOy940XidNfVQQOjMUDSyogYJTLghg72mg00UPHa6kpzl52YbmPlqW7qKGm3Ztb0zwz/iPlb38ZEBDRIlLBCjKoL0K0Jap9jBGQh/lx3nEew/u3fl3jj5wa+UPGWqcih2tt5MNrtQbXxSvPRwtROcSLxnZQRZYHXgHvPmPD70Eeu8DQ8WNX8C4t0kl4RsgUQK7mWhgN+UcMeLSFoX3c0N5FPw2UHmrCxRM7cFGaONnkpYCFsTH4lKxc/RmDPUvQY6BOa/JGBGKeCE1of0CyfbINyS3F5uJZmLPUnwP0ekdLxj7MfAVWwhCAX5tKOG1N4z8Kk38/QNh0lUxBenBJb1yvZ2KfwmgaEMnkHZWy1v7Z0pe3NS53cZEuOLfJF1sR9dtmOJf+GjM07p9KRmDC6R7RnVcopkLcwgIP8dauCcZibh91c9Lmzb5CSWq1lnWkrLGXzoSejvMUmymXV3mK0pkTQdu1uiwR3UlASnLE9nESw2xOQHmrJG6QqqvQ377qjNnmOkKb366shjDgTQ5Mh3+urGQv0FLL4yLM6x2txuY/vmkR7EIOYhZk+zBZ5TyjdxzZK78wCWSdFJ7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(346002)(376002)(86362001)(38350700002)(6506007)(4326008)(8676002)(6666004)(956004)(5660300002)(8936002)(2616005)(83380400001)(36756003)(6916009)(2906002)(66556008)(38100700002)(66946007)(66476007)(478600001)(44832011)(52116002)(4744005)(6486002)(26005)(316002)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y0C998FU5bB3J4c9M2Ioq+IAOriOko7Fx5o8hdvrB9IguxKHl7cdIBNsNuMO?=
 =?us-ascii?Q?SvX8MSQv7OxucZNTu7P8Pk9S0GsWbaHxZQBH3hA6ij9UD+BvXdVuLSACZZ3y?=
 =?us-ascii?Q?jZnXYT3c5ytrE5A/r4+jn9QSM+A9NRLvWos/GLIMbOilfKIoXeGR6q9p4r+Y?=
 =?us-ascii?Q?o0vwsFFF//3vvwkmChDU3+zMQ8fhI4V2Rk9iXbi22LRxC+zOjKMfaRq2eY9m?=
 =?us-ascii?Q?YGzrQCDOzFzm/I5mviS5uSxrQMHQFZk6ZUzS3MzZP/ADXLIUMmW//MuoszsB?=
 =?us-ascii?Q?tgjOal3ENBkWpzOgOgKg8tr0X6jDrb94PvkeAuNzcyF8AyeRanYerFjU9aUk?=
 =?us-ascii?Q?AxBUk9gvIbpeR5RbRfEOdKelGyxKeQQECUYfhG6YkusQjLdFcCdibRLxxO1G?=
 =?us-ascii?Q?sBVyCxiNphSIe6shxwxBDgKVSHoJBJzBhuF1E8lP2CJgZdtM6msbF2JNn5rx?=
 =?us-ascii?Q?SkmHyFW0jL19Fee2/KCK34bGqZTyrTbQ8bZPaHFMUtN3CVOGKT8qzdxDGdbv?=
 =?us-ascii?Q?NEtcFJi4OPDb8y1dcG/rXx6ISh/O0j9IQwxwO4PE+1nK/ktvHzsfv4agsPGN?=
 =?us-ascii?Q?cFeVCDN8wV9lbQAFZQ/VSGv2QiC5OU1EQNe2onzqp37kCp0ZLyrFZJTJo6Q6?=
 =?us-ascii?Q?jRIDvj88+b2CurlsDv94is99TQJxAoAhTR0C3rxVwBp8pBcckFmVVfW0Fn2p?=
 =?us-ascii?Q?j7lQyDLRd/Rm/mq/u00B0zNpjC8sYb1BbgJbNtN0+bsM85uMl4RVfcnEPp5U?=
 =?us-ascii?Q?wX7p6Cyj7bBQQXgoXBvcY3ZS7Q7Hnr/wuFztvjZQNzQxuohZPL2IgUKgz+ms?=
 =?us-ascii?Q?Ms799ENu16hDDk6llajGV2wn6O7OtwZEqvHS1bic+qq/nR0QcV8tx2UWhXL3?=
 =?us-ascii?Q?P0Bw6SpCY7yZvEpDPSh1eId/Nkmash56s6qi/Up5HEoPcoM218ZN6dkB93Mx?=
 =?us-ascii?Q?It3i/S9d/w6v17XUic/wKg9Ka5O+ckCx1Olb9OoVw13V5d5x2QKrr1PxGaUr?=
 =?us-ascii?Q?0urnm34kn2u4D9KkQqL6EUtIp3NABOuj7hJY2pvYsG5mIuOEQ3Id4aGyO2kO?=
 =?us-ascii?Q?SwAC/5J9Pwu/lLYrC+sPlKXJd4dm9VY1uXba2vFxuWdCUSSxif20tJNHc491?=
 =?us-ascii?Q?kj03fDdTDqCpHF2Ss2rS0RnIEwQ4VjA8TOtkuoa7Qs3Tey+VPOJjpc2CLidh?=
 =?us-ascii?Q?2C/rZ911EKxN40RmXHqaKXqiN9YJZU9CQO/9x5Pk603yKH7p2jtRNna9t60t?=
 =?us-ascii?Q?xR0jYSkLqQG7u4j9Ym1Mo2mEX516BoUVh4x0I3Q+KV2zKdhoToqn+54sDjuH?=
 =?us-ascii?Q?ru8MbylHdb0tRzo47Z2Uc9EU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c38aedb-7e56-46fd-57b8-08d9633dc0fe
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:18:33.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqdxfE+DrNE641dW8/ikuUg2EOW8lca4OwlU3oW9XNVsoCsbRHlMcHQoT/Gjm4CJrpQQjCFpjqvTp1R1n8RGkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4127
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190107
X-Proofpoint-ORIG-GUID: Xekd5AkNjPe06jiunBmH3ZcWbo4nyxNT
X-Proofpoint-GUID: Xekd5AkNjPe06jiunBmH3ZcWbo4nyxNT
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Related to the bug/fix posted to the mailing list as below
 btrfs: traverse seed devices if fs_devices::devices is empty in show_devname

Anand Jain (3):
  btrfs: fix comment about the btrfs_show_devname
  btrfs: consolidate device_list_mutex in prepare_sprout to its parent
  btrfs: use latest_bdev in btrfs_show_devname

 fs/btrfs/super.c   | 25 +++----------------------
 fs/btrfs/volumes.c | 11 ++++-------
 2 files changed, 7 insertions(+), 29 deletions(-)

-- 
2.31.1

