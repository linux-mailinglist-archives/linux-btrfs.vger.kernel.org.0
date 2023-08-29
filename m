Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D428578C478
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Aug 2023 14:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjH2Msz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Aug 2023 08:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbjH2Msn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Aug 2023 08:48:43 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE1F9D;
        Tue, 29 Aug 2023 05:48:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCCb2j017691;
        Tue, 29 Aug 2023 12:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=G1qbYKwzdMS9xH8/Nk31sNd2iybXYUP0EQ+laC2EbSk=;
 b=j3P5ds1hz15MXmvZGxRxx3HuMTAocvKc7VLkXJMDJyEtEIxJ2dDjz9hLLMHCUd1m+jKQ
 RVwVE3x+vxGXRqVH98ur3D2+wpMYCQDtV2VPD2SxeeaJ6IADnnxf0PAuujYcl6ffuBjG
 2/37EDRZpquTEH9j3+BojFTARaeQuDhVeNVtPKIB3Mb2gb880HkpOtvAbRerFBGPFzvu
 Llmc/EV2JR0Dx5VwxXJneM9hGxS3nXTaawq0ZPjR4fjwIUaTvZfheGGt2GznZzzzJ5Kk
 Nyj3REdjFo2S6Qbdp2HTEnLFPUzAtmw2d6sE+fUUyZD5jC4URb4KewadA4+UPRZ73IZg xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9nyvt4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 12:48:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37TArY0Y022944;
        Tue, 29 Aug 2023 12:48:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hn1afd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 12:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wmziqa237ePRj4LHvxhdbrPf2p68bt+vXx4W5QIrNFZ3aOEtlDt+TWu86dBqGRZX7LbLIi8irokSjC/ynEJFcd4QyBTYI5v+EzQwFDgHYm55OMfc3u2hbMavy5X4ddyKZVnCIgI/9/RQ1oKpEj2lrTBKMqJw0ocRqq85VjDdmOwwtC0e9WI/TlnMVif5vbwMCKI4Y1QmCFzC5IlykCTHn7trBITGNVxTK7zdQQD5JS65/AimfuzJ37hOhQfrlMhQiGfscxiMGB564WI1MpNxhf0tuyGdGyOs6M3PyVc4sjhm/M8uaVnSLg3WVpT5DCiVhP+yb1DOlO6B6AYp3z3LzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1qbYKwzdMS9xH8/Nk31sNd2iybXYUP0EQ+laC2EbSk=;
 b=EIj+Wvfzt25pVqRjXo39S4zp4gH4C4ZKTDpkgwSj4nyt+gMe1J/qNK8AedYWIFHBr44sQ64QLKG7PDNWjQzhuV5xkftp6X4QgOMZ1MekovsERkBGAVUGIPPsZi+638Cell83zPQkqsXHhWZpfc248yEVli5CwgjIWz8ko9tyAwDySY5UyE42EqMEVtLsir4JF799qUPD/f/9dNdhxinZFktkP7YyQ7LPBMxCtytKcUmjEV0VwQ1g0yEAvgezs9evlvrm3ZX1Gm08dm0o510eX44eo0mMYy7c6r4v91ULrHrOItSA6rOQ9yUHKLiZZayxGGQS/hPWRirNtLwkRYRNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1qbYKwzdMS9xH8/Nk31sNd2iybXYUP0EQ+laC2EbSk=;
 b=NzjqVNq/BLgyrZPq3+8ynlSPiEyqx0Lh3PMdCwq2AuQJpI5nBh3dZS2gyT924LBbZwr3ER4mXqvkMPT38vYopcAetMOkX/TIN/l1dyXJE785LP1uBNXW4FeXrGcKQk5T2UUUrb6kZLt1e14cpAr2Qq1XKT5pST4U5Hm0XhB00OA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 12:48:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 12:48:19 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs add more tests into the scrub group
Date:   Tue, 29 Aug 2023 20:32:40 +0800
Message-Id: <2fc42b09cdc710cc2ac83e3a1726b5f7b1d0af62.1693312237.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c4cebd-f32b-4b3a-2e49-08dba88e3891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +GDQoirYRLiwa6W1rYwr9fLsiuvBm6PHLFgLRC5WwvYOi6sGJdH1FlnbHJ4Kw+P9kU9JdC9hLuM6P7BvsJKuAxj6LGo67zHDMQZGfqVRRytT176jEfBESTM/litxDQP1ImxcklN3UVcutuNik+7bKz+7U1io4DVQcKxDnx5ToZ0Dl6zS/f34Ci4gkjU4evazg4xhM6FyFkobibjIRU/LfsDrn1VZt/mGTboQXHxbD+4GpAQqdhy2noUCVDiKdK32+e4yEC4JYKL+R27OwSl0AokjVl42eQzQMP6GWjwAuR6Qgts6vtt3EwNksZP116at9o+IoeZ9tnnxPZySpN1rsmzhUd4eIyMadovog3QulBQe2LHvw8l1KrRz3Q5m9EXx4lg5eWRHmgeEtbpZOpraehCZhOwtM/5q7ps1QRuMFFrS1PhX82jSr7tUuFNu+is/IrQljJQDW7finqVcklLASul3yaKuB8YszilL5ewCNG6SmO+hgmLK7Z98qHBououk5znxBn7VDctP5PSAREdW04R4PiZnblHW5Y21ckmYZt+HEhqgXCJY8VONVjyotLED
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199024)(186009)(1800799009)(6666004)(6512007)(6506007)(6486002)(2616005)(2906002)(44832011)(5660300002)(86362001)(4326008)(38100700002)(36756003)(8936002)(66946007)(41300700001)(66556008)(8676002)(66476007)(450100002)(316002)(6916009)(478600001)(83380400001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gDZKgA1s8f/654XhzD4ZVc0SwWKe+EkPUxkeMEdMjh4veamVvzkSpkxJZocT?=
 =?us-ascii?Q?5ds5rRoYYTnWPTMVVpIP2d/oywDE/RIyJowSLZKQ/atP6MjiL9A8euzLzw82?=
 =?us-ascii?Q?UZ8rsqknD3qYwB5weVww6cRztglN/YBNomSich/4hw797bScTVdnLU60ZuVt?=
 =?us-ascii?Q?D5KYYD4Vt4SkoXyq2QC4o64Rbprxy9bCKak6xj6IiayZRo9fnrGojng/HREr?=
 =?us-ascii?Q?S0zkxog/ev4Pr/nbfFzsWZsxBbPneZGJdEA66V+Fy5n6QNf6M6Z4D+ErVE1d?=
 =?us-ascii?Q?RkJ/07ufVf3k7NXC18GCfUbPiF+DqDLDW74ymsdFRVR5OVE7PHJIx5ZWGrEe?=
 =?us-ascii?Q?YbLxOlZV+jV70vg2cOsqlu1hMiJneZ+1Q3s9pd9P1k5a3gdkK+X6F56PtC1+?=
 =?us-ascii?Q?9deFZN1MEnMdJqvo/TkTaFGULdNwu+e8DXrLuMbaQ1Tg47KQf2Q2kH0DlkED?=
 =?us-ascii?Q?9WusSi982pXJRgsvGfXQvFdFoyf3yRN5fwplbZmYQ4dYFWQqNixl8YgWUH57?=
 =?us-ascii?Q?yqNJZ0Kupv2oBeP3f3SzEG4/E8EILhSLqtSJtfhlLcZd+9bqkm+adlXAaqmJ?=
 =?us-ascii?Q?ZSJmchg7+L4py0jtPW/fLpdwlO2/s+7CkLFLh+7YzGasEq7I3KwFgcyjoBv/?=
 =?us-ascii?Q?cUz9qBN3B0sl5euSxnYycEEFdX7JoZjOdp8rdBL2ltVOGs6gcxhQ8R+zk/7x?=
 =?us-ascii?Q?k+WRmCwBanU+wcIcYLj7If/w8ZyWAOsHtahxq2Y+vpXsuKrm44yJh89HLwGC?=
 =?us-ascii?Q?73bTwtbNKiQ3249mSeE5yb8c754V1umoxeC/CPTGF5Puhtt4FwhnCUaJh5y1?=
 =?us-ascii?Q?rdfBOFEc/ctibVVuEEKVTKAPeQSwK8vomf1GC78EchglI6NguAvC6NvNRfwC?=
 =?us-ascii?Q?s4hRV/0dh2cZRWmIQmxeVBtnyX2k7gNoi/nEDRNtzjlAUI7/NDCtTpxSZqNQ?=
 =?us-ascii?Q?DbN3JKY9Xy/OUzqF8X3/JaM5YpK8b9ISdpBwpXJ6b8JIr5gwAxyOyO5V9Gml?=
 =?us-ascii?Q?3XYgDoFbqHjV6LyKA6zWB7hiy5wmGs2xxztb2KQPBMIYdZL820r446Drmr9R?=
 =?us-ascii?Q?UbzPXuVADXVIdt38Mmz/5M/zaJ7fZ/HuryW2qYsjN73RTuFFQBIC4LQCsJkT?=
 =?us-ascii?Q?EOOAop/VG7PQQUuFcbBf7WaSUbwDSaov98nnlDcAj4lDuAY5dkvseJRCypSW?=
 =?us-ascii?Q?dHYY4qxuWPSC5e0NVc5D8xkmPX7El0HpHFgsEh47qzNIfC5mojfAEpIC7SUg?=
 =?us-ascii?Q?TFtzNPGO43M1X3bjYtkxb0dDIlmlc19buaZIPw4rhPSib55H3ivVYLtdlj/A?=
 =?us-ascii?Q?E8KQ7jww7KlbfbNZ01IevPZ5Bmr7dwNhjQozb03ptNz92E3lV0B9Tkf+tuQ+?=
 =?us-ascii?Q?Swow+SJlweg+mOv+bEazDEI2eTLAzSFC8LyLqlTUqNJpaMnNHX7L0VLie8+h?=
 =?us-ascii?Q?XRL3DiOtVGxb0nZLxVXV6aYbC5BbBW6jsGBHjiS3u5PFm2Q5Q88hwAksq+jM?=
 =?us-ascii?Q?JVynOvsx0mImXdBMefBPJozAVxey0AS8zIGURGy7r4M1EHnaaOWGJijVGfSn?=
 =?us-ascii?Q?RCZCl2EVunezncQ35WI2r0w5l6zc/u8kaIBU0e4u?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GVeQbU5KDSIoSCzY3CZs2aaAFQJMLOQS3jwRne/DJ0irD56Ew3Bwr+yWDGY6QixAE+Pcnopy/iuvV9EEGYPdd3zMxofdIPfvqyRKXFB2yhFvkQYz/oUtCSMFnfjYaJ1L9fZqGTuazJogzxd0/JW+CQLRA2mKQrolcX11yewJ9g0UB2MZOrN8qNETDtXuU3kkStLPmo5JipOXiqSJKAi7vkDAv0CW6o+X0qwf2tMkmX3KwE+EOHOKN/gEy+bTbqhKSdCBtTXq+F57Pn/7l6V3zcFf1WUN/utq/PEPFT2/DG827mpKui0gXop3q4Ed5I+26IFIGT/5sRkfwLsvj26JW23abJRJqD2IPOUoK3vISMO8Lf5bTqVPEjn9PN6AgyxOEPBL77QiJUhcplNW603rH67xoIHcp1YC8dw0nOjMaJx/o4Q7umSZZg+fYO9kw7GYSLORKYVp9VBt3wUmwBBYmF3rZ0R8ktkWbOWjpCzeoLO/7I3I8ERKXXcXsqQXe3HYumQCBLN8fMgSvcyUbTr72waLZiOC+ToJt3XY3mi0sNYjWxcTq65T+ADrOWVl/+oveUd6CWUIfHp4DF4rmqQWkCxgO2wiorcBYpETpywgKJnWab3f0HZouIrwzUT3iIFE8UmvTiLuJSke0NbTcIlLLpkgOWbEagHLxp1gAzbKAUSOHCfQ+AlLggte/DGMyvHeoWQ73R+00tz+pif97izibd1H30gv/RxjWhSc49qcf4Pht+Z+y9BYHCNvn0a2EwS7aYzFJ6G61keHbzGAvmVaGQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c4cebd-f32b-4b3a-2e49-08dba88e3891
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 12:48:19.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7cN6yYlO2MexPllQSoJ/1QOI/5FF3CYd4CYFsYxCsGPmGpgeTUrtb5az3tZ9QmF+pMIpbN7/cJqZeD0/PBkZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290112
X-Proofpoint-ORIG-GUID: lK9MrNTSQsHXWdTihWLuls6PGL-UVbqt
X-Proofpoint-GUID: lK9MrNTSQsHXWdTihWLuls6PGL-UVbqt
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I wanted to verify tests using the command "btrfs scrub start" and
found that there are many more test cases using "btrfs scrub start"
than what is listed in the group.list file. So, get them to the scrub
group.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/011 | 2 +-
 tests/btrfs/027 | 2 +-
 tests/btrfs/060 | 2 +-
 tests/btrfs/062 | 2 +-
 tests/btrfs/063 | 2 +-
 tests/btrfs/064 | 2 +-
 tests/btrfs/065 | 2 +-
 tests/btrfs/067 | 2 +-
 tests/btrfs/068 | 2 +-
 tests/btrfs/069 | 2 +-
 tests/btrfs/070 | 2 +-
 tests/btrfs/071 | 2 +-
 tests/btrfs/074 | 2 +-
 tests/btrfs/148 | 2 +-
 tests/btrfs/195 | 2 +-
 tests/btrfs/261 | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 852742ee8396..ff52ada94a17 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -20,7 +20,7 @@
 # performed, a btrfsck run, and finally the filesystem is remounted.
 #
 . ./common/preamble
-_begin_fstest auto replace volume
+_begin_fstest auto replace volume scrub
 
 noise_pid=0
 
diff --git a/tests/btrfs/027 b/tests/btrfs/027
index 46c14b9c1c1f..dbf12c26d0cd 100755
--- a/tests/btrfs/027
+++ b/tests/btrfs/027
@@ -7,7 +7,7 @@
 # Test replace of a missing device on various data and metadata profiles.
 #
 . ./common/preamble
-_begin_fstest auto replace volume
+_begin_fstest auto replace volume scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/060 b/tests/btrfs/060
index 26db8a9bee20..7dd4d2af74cd 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -8,7 +8,7 @@
 # with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance subvol
+_begin_fstest auto balance subvol scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/062 b/tests/btrfs/062
index 47b0b9373f33..10f95111f8ff 100755
--- a/tests/btrfs/062
+++ b/tests/btrfs/062
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance defrag compress
+_begin_fstest auto balance defrag compress scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/063 b/tests/btrfs/063
index c96390b9315c..cef80771d457 100755
--- a/tests/btrfs/063
+++ b/tests/btrfs/063
@@ -8,7 +8,7 @@
 # simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto balance remount compress
+_begin_fstest auto balance remount compress scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/064 b/tests/btrfs/064
index 741161889150..f29e68ba96af 100755
--- a/tests/btrfs/064
+++ b/tests/btrfs/064
@@ -10,7 +10,7 @@
 # run simultaneously. One of them is expected to fail when the other is running.
 
 . ./common/preamble
-_begin_fstest auto balance replace volume
+_begin_fstest auto balance replace volume scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index 4ebf93267a59..b6c9dbadfd32 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -8,7 +8,7 @@
 # operation simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol replace volume
+_begin_fstest auto subvol replace volume scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index 44803f9faf7f..970a23c470fb 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -8,7 +8,7 @@
 # operation simultaneously, with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol defrag compress
+_begin_fstest auto subvol defrag compress scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index e03a4891ec89..e0bcc2ac4930 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -9,7 +9,7 @@
 # in background.
 #
 . ./common/preamble
-_begin_fstest auto subvol remount compress
+_begin_fstest auto subvol remount compress scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/069 b/tests/btrfs/069
index 6e798a2e5061..824ca3c3110b 100755
--- a/tests/btrfs/069
+++ b/tests/btrfs/069
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto replace scrub volume
+_begin_fstest auto replace scrub volume scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/070 b/tests/btrfs/070
index dcf978b36b0c..f2e61ad392cd 100755
--- a/tests/btrfs/070
+++ b/tests/btrfs/070
@@ -8,7 +8,7 @@
 # running in background.
 #
 . ./common/preamble
-_begin_fstest auto replace defrag compress volume
+_begin_fstest auto replace defrag compress volume scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/071 b/tests/btrfs/071
index cd1de2642a96..40230b112cbc 100755
--- a/tests/btrfs/071
+++ b/tests/btrfs/071
@@ -8,7 +8,7 @@
 # algorithms simultaneously with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto replace remount compress volume
+_begin_fstest auto replace remount compress volume scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/074 b/tests/btrfs/074
index dc26d8c02497..92e25c7cc24a 100755
--- a/tests/btrfs/074
+++ b/tests/btrfs/074
@@ -8,7 +8,7 @@
 # simultaneously with fsstress running in background.
 #
 . ./common/preamble
-_begin_fstest auto defrag remount compress
+_begin_fstest auto defrag remount compress scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/148 b/tests/btrfs/148
index 510e46dc0826..65a262922569 100755
--- a/tests/btrfs/148
+++ b/tests/btrfs/148
@@ -7,7 +7,7 @@
 # Test that direct IO writes work on RAID5 and RAID6 filesystems.
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/195 b/tests/btrfs/195
index 747345973244..96cc41343925 100755
--- a/tests/btrfs/195
+++ b/tests/btrfs/195
@@ -8,7 +8,7 @@
 # source profiles just rely on being able to read the data and metadata.
 #
 . ./common/preamble
-_begin_fstest auto volume balance
+_begin_fstest auto volume balance scrub
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/261 b/tests/btrfs/261
index 21567052d58e..b33c053fbca0 100755
--- a/tests/btrfs/261
+++ b/tests/btrfs/261
@@ -8,7 +8,7 @@
 # without affecting the consistency of the fs.
 #
 . ./common/preamble
-_begin_fstest auto volume raid
+_begin_fstest auto volume raid scrub
 
 _supported_fs btrfs
 _require_scratch_dev_pool 4
-- 
2.39.3

