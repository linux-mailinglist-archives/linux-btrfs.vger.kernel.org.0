Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CAE717998
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 10:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjEaIGx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 04:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjEaIG2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 04:06:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0624F184
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 01:06:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V7lkAb013123
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 08:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=mjpGRgVV9xK1Bf6MtoLZq4bvB4hMBy5D5ihxpObNJDs=;
 b=coynuVEv0slmCiEmCmo3YSWzsWGJGBjZo3b1ba5f0g8walnkbM0ovJW/1Cg1pIWphnUa
 Puv2DVCs5eftrhyeowLfaR9Fs+CAMprpapY7zz8JTJz88myUYSbPEN8NfsP/YapXti59
 j384QpPtAaTuyv3MKZn9+GuVFauFr2X2zvd1Mr+8u+KN/6II0bUDHapKItoxhKEC84oY
 mXRXpfeaWhkNWsZwIFa8cSdTHcMdSzqX5DxsvHs0zU3f6LhforC4AnKV+lD2h7pqh+mr
 oXN90UoqxcVLP5GaNAPlxcXbV01gXhNaSNr2VVKRj6/Cv/n0spGuhOLOpSXk9GeZ+tFx ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmjn2gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 08:06:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34V7eNVk014581
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 08:06:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a55a1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 08:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR7W/KT3JpjmrX8iBpqBdUosGCJKDbzRhZn1FwyQLYMxnPmioUf9ptuRKo2AJwrE6Pnyj3zyqGnIWzLPJzjXrAb3jloWBmtHfXC8d9T94KQ07DnjlVaTo3Q1jKEnoKZC/v3Ez0apL4f5QehDfc7enIcJXSjB/A0doFpeblp8E+JRK8xi440/DZT63KYtmWac8Yqc8Gvd39dDjXTZOdp1HJlxsvAB8f3llpPPnm12l8GJJCReR3SfjF6vNQ4waIn4NvvbnHcLgfhWgc73loleVwe2WJxzyCKBO3pmC+F5fJb9YM6cRODJPzhL+k6/8qI5oK1yQGalA1yhnvlOxPvh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjpGRgVV9xK1Bf6MtoLZq4bvB4hMBy5D5ihxpObNJDs=;
 b=QGR/lbf7vr3u1vUjdHqqneLuaDbDzLHJZNu5k0FxAM1Qck09qOsnEcPSg5By0CFlITv/nO0uXKxTRTrV6sJbx+7SebqZUTlCalD9Twbe6q2RWwszBIpEKkxQGtpvN8WpCSc8QnqZUyQcUf274DEhUdy4Uin63cvuLPZqy/NJtvRTEstj8/aGY2qtlHlURuwXwz/HNt4EZYoWH3Fpy2x8VrCAShGNfnVJ71AWMjo+1mSgLCUdxYBX6BX2GQMqyk1oKVtbMA5b6Qs45aBfiItaPYJN0gW2pF3pYvtYBk/yPrs088UzaqCm1OZrt8cmOub95bhhxyZiG9RmIWfxmVWzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjpGRgVV9xK1Bf6MtoLZq4bvB4hMBy5D5ihxpObNJDs=;
 b=LVbAH9FtWgNm8KLtfvOknXySAk5BhgJaM15VzjSDG/9rR3uR3gttqqicbvxLa9VNmWNLQgiaw7o50B3VlXdJsuPne0B+sT+bQrgqBPvyrE7Syj8N/EmETapA14LAIvsvLeRsoYNbIGCxwIkGNsK2fl5uqUYPtkccMLPETn+ROm0=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by IA1PR10MB6267.namprd10.prod.outlook.com (2603:10b6:208:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 08:06:22 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::cc8e:8130:ef15:a31d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::cc8e:8130:ef15:a31d%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 08:06:22 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: add CHANGING_FSID_V2 to print-tree
Date:   Wed, 31 May 2023 16:06:14 +0800
Message-Id: <f9d3d5feee3ddd2ddf8484396b6e0642b7ff5f91.1685519856.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
References: <8e152cd504552e92680290cd34bf30bfef0cc1aa.1685440589.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|IA1PR10MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fec8909-54f4-4ca3-5b34-08db61adec44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G30h01w57VxIZNWSzMMpagASFvtHdgyW2tmxk6H43JClNLk/rFDq43xyag0FdEzA+1XVyI2HaU3xwVdG/UQtND4Ku+5IZdvlzBoHRI881denXinlJKAplHKC5dwDJEaay9Ho1VSZeNRKViiBzVQ0KfdDL98C4wSLI+iotJTXS4Dv5JMBSmgyN6ytcA0Atm9lFmJGNS7DbUsP3AQkHUI3dC+eE2yYaTGY6QFfjgHLFLH79N1FOUFXkQRWoERKLZS56KfvNuSqmY85a1N5pMl312RX90lfgj13xG3Ep2rsyhuh7bWnOzxe0eik6ooJnGQQQSJsv3wbHCeI5YJL+MUu2MB2cKQk6knoLQv+dXvyMiDhiNmc5syIYKf9+iO1YDD7BYm/qMYAt6A9V7zGknkZSAJCR1De1MUwxp+O6aiK4mzgeEPTOrYe//rwFYFNX9rX6KVV1CCaKPRZmCAQEqM18yOxBXrsEShUvGBTzZFx8ViOtqkdTzmM2t/6a7AYmhHMDjT4+3PITDIWp3cQA6bk7WHQCTfhCFy2NBHPs6zfbGcQi2gqb2VLGFWhl8xPvqVW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(38100700002)(26005)(6512007)(186003)(6506007)(41300700001)(2616005)(83380400001)(6486002)(6666004)(478600001)(36756003)(66946007)(66556008)(66476007)(6916009)(316002)(2906002)(5660300002)(44832011)(8936002)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GGxlp1Pp0lEvkSOYOyt5X53qHJZXHl6+F2DPLJMBpmBPDVVSUn4H2D6vihYr?=
 =?us-ascii?Q?W2h5EHoFtdoGBpgV1scrqFjErvFLO1cCfXbdXaemS2+9hiqL2wBxe6fsk5v+?=
 =?us-ascii?Q?OVEHNWa5Kr/FTpWN4bqnlQ9My4HYGeDiLv4G2JK6P6B77f46UXwY5QKPz60g?=
 =?us-ascii?Q?NK+TsbXkrOXCRF2pEBKVPaqVwntkMCsv0JlWlNU6F3R0nwnS8QqYnFgGNGEV?=
 =?us-ascii?Q?RIQxuGgYrLrAIlw2HhWlC1y1I0RGF+nt8qmfDV5kKIhjL+V2Dmwjwj1GYA9V?=
 =?us-ascii?Q?HGrh3mZyCRvu9CdEDxWKcQp1YLNmHAr+kiMdtzHp+LUVGnQfdYyZMZhnPIMQ?=
 =?us-ascii?Q?iMU22OMexxyNEXWOXbx7MeMXNjKhTmmGBPFvKEb/rbrGyV0JCWkvrPMweWYU?=
 =?us-ascii?Q?JwIFUx6sTqc3zBNG9GCHx+pgiRvc/otZ900aga2QhlhtbTCzI8NE3flTUVaZ?=
 =?us-ascii?Q?Z+OW2feVfaR6KSBIXLJoON/spl7jG18aS+VRqw7CSFsCWVEBZUw1K5Y9csEU?=
 =?us-ascii?Q?V0pevcF/Pgdmb9HnDm88Sqm7uJ7V8VuQNYlgcLwwbNkdbyuw7HMDshqJkNEE?=
 =?us-ascii?Q?3EecDE6X2pHDJ3wU1Km7kwAZdeBLl+FubttUA7ud680Kx1mRGNzaIcUFjJ3r?=
 =?us-ascii?Q?6xLXmPEXz/cfdFGwvyR2sbRo0e1o96gFL+L/smgq/damLPRKGhcpR6IMlf6h?=
 =?us-ascii?Q?F47zi/XvqDumR36svcK/4fMx99FkalnlbXJ2v8fW5a2YdtNwDC9YRyVCQbnc?=
 =?us-ascii?Q?6dJ0SAbiKOitSC8fKmeQH/ibJmUPdnNyIYK+w7RoV/XKu/JsvNvsvTgnU4rt?=
 =?us-ascii?Q?oWoomd82y1fx+aBPXErWljAz3nRgUCLBnavG82tJM37DTbVbglaOuel3EtYz?=
 =?us-ascii?Q?NUozRS+NsDJchNuaQMeZj+VZrNBuWDCi4pgqr2Gmvx9GrHoPLBI4cV5fGayl?=
 =?us-ascii?Q?LbzPNbG20qOZfEg7DqzVnMGzrujZ5Zp+1hzNoaJqaFvnMBKD36M7IIhlitvU?=
 =?us-ascii?Q?uzzJM+2wCIs77XBSgZ/l1Hbl/NIy6IbOiZWrh/WbE9g8DgkeK+UXb5FyaiZ0?=
 =?us-ascii?Q?F8ayU61lSFNbJlp6rWCZolaHIjliXvTNvMdSlcKs2dGIseOWzs160rA8lBdt?=
 =?us-ascii?Q?b3aPa1eJ/heCV/wN3BQtg1cjwo5m7IEcBxp3ZGdeV6QOU5I9Y8E6fF8SNmvF?=
 =?us-ascii?Q?QpkF94QoiVwHd0C3zjLtB+kseHieNxFp87XwLCXbOilwHhXY1yd6wkWOv+B3?=
 =?us-ascii?Q?tvKoMCqxy9do9O1UF1NYP38yXrxNMTb7j02uNtY7MflUZD3Vg3SJR1LIfWzf?=
 =?us-ascii?Q?uS1LxypKeqgvcHX3sigd6ULfqqmFYs+LMa6oPTA6iQTF2W3hPrzZYEgmKB6b?=
 =?us-ascii?Q?w+C7OYYlxPnXxQ46BgPjJOlr+6h2zp42vudyc2ryYagWOj+QjFHxwkUKN8pp?=
 =?us-ascii?Q?L05/VEgkrjKd8OqQulveKrsRV9aqAuwi9AxzM0QR+VlXfpmK4bGklvPe9Oim?=
 =?us-ascii?Q?XcHj2QNxv+KYcfM9Kz+AS6kfF9jtnV+GFuYpTHA2BzWafXQBNTzXF/77TMyf?=
 =?us-ascii?Q?QipUGeaQ83QTfBcoD3S4X6dpbLTE4OqcVt6JaTxU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vkGHqQ8vSuuIIHVOVutsBwJWX6mI4KpX5iKThqJQ78SUiF6kQgYp2FX7m3zDvPUFtRPrWie81Jda+GRUP4XgxwLypZHzahpYV9wtIrZ0BYT2Yu2KccvcKThBj/E9/zPr8DRgapkiBYTj7GCOwiW0KaQJE6B8UvtdZTE7crQF5vTodGNC+4VKrYaHRWjzU15ertaAOlDDC3761TSUk8E9FDIOEfqBMOYMEn/0n+UKq5xq50lySLVNrO/WuFDmDdzqF568uhsCaXXbjVo/fWDd3k4cIvy9IH1dcJuWM1x8nbIWlFAXhFjjKetNaeDsW5h5Jp5hR0108aHQvKoULtvuOZK3zpOGx6owJ2J4NVQQNlaPU+GAW6rDPr4PWgwWLfM65MefoL+Bmcd4CULC/g6vB9kqednLDqQnYsSi22dY8qimXtZ5y5UpAIcgAg1zFWvghSVoZZSz1JhONjHrltPLaI9LcH6Ixob2ijmeJzChXy7RPUX+mMxP/plhARGk+AP1h6kpN2nxn3q+IJ9MqLw51Tp2+H8eo4Am4KA8gP+H4p18suFp7WLJ/9RGRUtWjAYceb0TlUrOcz7Xayx9C1g9F4AgjWDSsmS0ZHvXlWhuOFT7E0WLtBsT0kFYtbZcsTeDM/kia+7SAMB61xJCOhs4TaKB1klhM2hLqm1tde1Lrsl5b4yu8xLxIMniNGxS464Y/EADB9rEHs2wfNeBE2KwKpkMy5nsUFbkjBuo73H7Y4153v++MUTCAq2AtD3VGs8OLTVg9TPXQkotG8UyWXcVFA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fec8909-54f4-4ca3-5b34-08db61adec44
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 08:06:22.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8ZkzDAJAML4aHEDV9jADB3RAOeslLjPP8BMRDDZ3h4lrAHou+YVTnV/G/x5vkPA1U8IfMqZcGWo8ydU1fYr8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_04,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310071
X-Proofpoint-ORIG-GUID: rHbHhuPzotnmEMtlRe41HwtWNJWpUIRz
X-Proofpoint-GUID: rHbHhuPzotnmEMtlRe41HwtWNJWpUIRz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the DEF_SUPER_FLAG_ENTRY for CHANGING_FSID_V2 to our btrfs-progs'
print-tree.c and to the BTRFS_SUPER_FLAG_SUPP, so the dump-super prints
the flag name instead of unknown.

Before:
flags			0x1000000001
			( WRITTEN |
			  unknown flag: 0x1000000000 )

After:
flags			0x1000000001
			( WRITTEN |
			  CHANGING_FSID_V2 )

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Include CHANGING_FSID_V2 in BTRFS_SUPER_FLAG_SUPP now in this patch.
    Update change log.

 kernel-shared/print-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index aaaf58ae2e0f..0f7f7b72f96a 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1721,6 +1721,7 @@ static struct readable_flag_entry super_flags_array[] = {
 	DEF_HEADER_FLAG_ENTRY(WRITTEN),
 	DEF_HEADER_FLAG_ENTRY(RELOC),
 	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID),
+	DEF_SUPER_FLAG_ENTRY(CHANGING_FSID_V2),
 	DEF_SUPER_FLAG_ENTRY(SEEDING),
 	DEF_SUPER_FLAG_ENTRY(METADUMP),
 	DEF_SUPER_FLAG_ENTRY(METADUMP_V2)
@@ -1730,6 +1731,7 @@ static const int super_flags_num = ARRAY_SIZE(super_flags_array);
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
 				 BTRFS_SUPER_FLAG_CHANGING_FSID |\
+				 BTRFS_SUPER_FLAG_CHANGING_FSID_V2 |\
 				 BTRFS_SUPER_FLAG_SEEDING |\
 				 BTRFS_SUPER_FLAG_METADUMP |\
 				 BTRFS_SUPER_FLAG_METADUMP_V2)
-- 
2.38.1

