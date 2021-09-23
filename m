Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D905E415740
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 05:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbhIWEAc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 00:00:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7942 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhIWEAb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 00:00:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18N3QfqX019173;
        Thu, 23 Sep 2021 03:58:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=iqpn/UkNS1+f4DeTUdYdSBmbpKzXTsOBLiDS9eQZ9V0=;
 b=tt0BjcPQHFd34NWYJbRY+c3553aOXyFRLvFBS3ArXifEPJCPUQUsnHbTw2NQIPpjExhf
 UKbYdcYPTSy666ulaTyGoLgc+YpKF9AahtnS39AL181sMCAICFqQkt9rJLcj+gypvmRQ
 IBoReDH8hXtGn1Ak5gik984XVy/gSmQ1mWM+422Bf6j8blKFxlTjn3NTv0cxG2XO/w5U
 bxDllvdhQK4j8tP4ab4osWpSzPiz/sI4fmumdcF10Bf4tC2i5fvKcqGUYy+RUCjcQpT7
 olyKYkfLvewWsht710gJWYAksAuDwG1Bq8Gytmrj2RHerGssBqsy1HR/Nn6jQvV8OxB4 iQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4rgbur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 03:58:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18N3spH6173048;
        Thu, 23 Sep 2021 03:58:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by aserp3020.oracle.com with ESMTP id 3b7q5bm64q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Sep 2021 03:58:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StonJvvTARO/6r9CcWjU5qUQSlmiC7dlWZnXIr2ftEHDxP5YsZkdOh+yppAeciOt5npoZ5a1UFU89ja1cFL6sJt4YpP7J0tyHSs+b5e2IXlaRs0MuT2XuoNfD+zBx831Om0xLFKJ48zr1HkMNmNb62y9EFsrgVFBSAm7KDHZNZYPSpLqpNVorQRv1YCpyWXH6jW8pD/itochSTuhTZIfalWI+EkhmztRJysC/r2Ocz8M+wszjM98FcUS34Np1iCYfB2oAj/j/5SrbiXjIu5gKnTnzBaLRjelw3T18NFqwN+Pfx6jdt3IpuS/80rFz8bePEMtq276GMD/G26nt9Q7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iqpn/UkNS1+f4DeTUdYdSBmbpKzXTsOBLiDS9eQZ9V0=;
 b=ITrMHIMefz/cvYOCxC0LfmOOB2uJsCsqrbMBOqODPdv8MThBid34YNQI8qKzYA2Wgqn/z8uW/zP1HYuYNB1hACTxDv2+lnwGqu3M1Gzrzeozv0fuObIoO+Nel9QES9PUQvdyPIOOe0AcsGdbFsRyev++HbmsLABC7Ml/OzMHa8Cqcl/Y4W9LwidCUbXnScacXVD681l7m40uy858Oy+89TqrjGcGhVhs4G/q4J4TV8McMAY5CEisDjVInuafIAENDER56sEEMHU85ZCBKEBQsvZ8zyZElFCnij+/OPpWoyUthoizhTGMWiqWysAXia+i9mD9XHfaprFbFUKG4gzK8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqpn/UkNS1+f4DeTUdYdSBmbpKzXTsOBLiDS9eQZ9V0=;
 b=xWHOrzBo2umrjTZHD4HlmMKcjwT99/ipeytzHltguieilqoLfseSafrdzvi/AzRSzEmevxVjZ1uOyUntHsEAbkkAvZLFsARFQhuvy6Pck+t9SAGForTHqvGqi+3AL9sF+hSIY8vY6k0K97ejRsFv7RoFyk7xnrSsqP4sFwLBNyc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4820.namprd10.prod.outlook.com (2603:10b6:208:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 03:58:52 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Thu, 23 Sep 2021
 03:58:46 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.cz, fdmanana@gmail.com
Subject: [PATCH] btrfs: drop lockdep assert in close_fs_devices()
Date:   Thu, 23 Sep 2021 11:58:32 +0800
Message-Id: <94f69f0215f06ecf929c66249810c549e492071c.1632368499.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
References: <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0162.apcprd06.prod.outlook.com
 (2603:1096:1:1e::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from dev.sg.oracle.com (39.109.140.76) by SG2PR06CA0162.apcprd06.prod.outlook.com (2603:1096:1:1e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 03:58:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86943092-63f4-4c1e-0338-08d97e46712c
X-MS-TrafficTypeDiagnostic: BLAPR10MB4820:
X-Microsoft-Antispam-PRVS: <BLAPR10MB48207B3B4598702ACD093144E5A39@BLAPR10MB4820.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4NXiBnAEbrQByg+Ob+weVwNG3f5LTqxGQj9xWgADMjicBeaGKbj4iQdNgCX/SBxcjlXuTerVH9v+6s3Jz4mnsoVbfQAYYrTZYSyoRn8gzYlmuJt0nDOXwV1lnbPm+DD8Yui/Kyt8BIDpF6r/asYfqRM/JYi5i+MdYLszh67IBIytQMsAGpf2O4RHvbVG4WVss2W+ak+vrPfOddLBToLXgxsK/FFaz7KgpKAh5yw/A/J8a9/m0DPvc3J4V3rY550axBY1rtbmI78SBiZr3czy7zYigLbiPdAZ3Q8A9eESEpu9GGSS+k+cn/25qe7EtfdBDSa9DbPxu5sO2zarC4OCJOCdWsYsCDuA746RHj1hbdTJi8zri0e19oRXTHmZ7wFuHII0oL/NJJ9CHftMsmBbHSboLKhmkdCiwNW+2JUBELkKK5EjKw99dGAmYmCWT6bn1JBsB49Fn4mHX4yJdnSPl7UYPs1/0Kncu5L9nFXYidKW9rsNHCOTOQudhEpyfKhJi+qKvC8ZX4bgPghU6A6jiOPaFFRDWbo2239nZzMJxMej8Lk1XGFwvuFnA1ewnyvHHsxsc2l4UPi7RQTrSyt6lF4rDQ4MwmfBV9ItpSI6xVWS+CLuA7QcQMHxP3fe8vg4baUZnWgkDHCbbjwaadOmXwtEl8pKSiQIRDFM4a6OgRtsLf3TwTijy1qldO5sh208VmSLs+6YZjosZXaJxHk0pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(66556008)(2616005)(316002)(83380400001)(5660300002)(6486002)(66476007)(186003)(8676002)(6666004)(8936002)(26005)(4326008)(956004)(6916009)(36756003)(2906002)(38350700002)(38100700002)(86362001)(7696005)(52116002)(66946007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jsiw59OLsJt+QbB/qgcKSl5ow55kdcLEtjYUV2p+LZEoAda9XZqw6NJXDi7J?=
 =?us-ascii?Q?3lBb+zYjm4nKM2s5iLbq8ktqQEz2KwTOnzXwMINZhx6qQcDjI2fRjoIf2ZdK?=
 =?us-ascii?Q?77Qk9CmYAxVRySvKY94HnmRyZ12zdxapG4fm64G0IEBHkYyfDxJLnbKL9P4F?=
 =?us-ascii?Q?4JxMmktvLgzozWSrFKtB+wMvbDPoitglkpWI7nuT3NNjNUc5sVVwdRCUHWXj?=
 =?us-ascii?Q?1PxxWoF06xuZGjlm9hs1g3wVsU/adZNtmWjdb8yDhUjlzKP+BA9jD/z7DmDm?=
 =?us-ascii?Q?uxwzIqGq9+Rem9DlN4wLI0GYHJp3z691UOMZWkMM8I58n+QT9cu2nApcqa+q?=
 =?us-ascii?Q?6n3GsoYsgdiIIwPM1aIYSR/mf1849Y4aiJTfB0vcnezIckrmAwLu8+GWshej?=
 =?us-ascii?Q?wNZrzMgZIsScNUOnwndxwyGrQsG2TGzpWAgqoPmX1IvmRqBi2fDpoHfhsvnd?=
 =?us-ascii?Q?PbKBAeCdWhAXkuZU2mmqhU/3Epo1Oz5vWirkkY91dSCWFFWCW507wdvBt+Qs?=
 =?us-ascii?Q?L8t/5twrlswfqwCay83xmZ9M7qSfX5w1foAGddBXgVv3TY72gr8y8ZhxCuJz?=
 =?us-ascii?Q?i6eSQlCPfVhXL3t22B+sy2uiZhLW7Bc2XwcFoI6hwQZMouQURYqPl4RWRA/L?=
 =?us-ascii?Q?VdUZvzVHDpaClh1Ejolx0S+P9jexKhFtUqXfjR1KPlndA/HFo8vqXQhZP07X?=
 =?us-ascii?Q?0FWEf1OQez0RlLRt/0jzbnyO1MxwADNI/7vhiGpx8vB/mvQUoCpBnJNAGGO0?=
 =?us-ascii?Q?jvEFTPoL6cI5Gjul7XuDrMNemkfo7Ae8u6CYyEhFotsRKsC9MTN1FwcE/LZd?=
 =?us-ascii?Q?C99l1KrLUioWq1/sZpuUXEKfPGegprkEWcLti47aoOsJo2kE+ltLglQmA7gM?=
 =?us-ascii?Q?w1m05ODX+pnburEwosDFItp70ceZpqi2xRDrcf/s8F6Yef23npaZ/Op9XxZr?=
 =?us-ascii?Q?qhN72pZiMebd4hM/k+kL1uU4SWujm/RI/rPx/mHBOAZ1N8aJEfLWERojY8JO?=
 =?us-ascii?Q?oHxKuyRvXrO+QFuXFYSOuxthkdW56yIX/CbblS4TrKTTmjlHMkA8z0D9CQ6n?=
 =?us-ascii?Q?A37o06hN9lkIOcEzF988qKMl1hXL/x4osK7YKWWLJSgpUXegNf5GCpKP//9H?=
 =?us-ascii?Q?oPyLXV+RLw+T2tAyX1Kt57OGGPYyeSy+C4lODMwSHDDLopTkqaSBJ2fCpYiV?=
 =?us-ascii?Q?7aUdEd7BCwGfIGTB7JbTt0FGDlXrrORbljYWEqssZLV54tVVbH4oqwAz9vQC?=
 =?us-ascii?Q?lHu0wqQPlfYrXV7+FUlFtslP22riv90BhNZmdRSHDXUOyzMrcitRUhD7PIpT?=
 =?us-ascii?Q?t8SbzfmkXHoEDVffpcwB5S/n?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86943092-63f4-4c1e-0338-08d97e46712c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 03:58:46.3047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+qax9woR3qEoh8dI6oGJvoqd/2CXdeA8CURqrdXGPROQo2djZjwGjkQwIYnH842aJ2w8tQlzhzS1OkvYfiC6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4820
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10115 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109230021
X-Proofpoint-GUID: l_Pf1V5mKUwICvEi7ijTSbU1zDnfwUbG
X-Proofpoint-ORIG-GUID: l_Pf1V5mKUwICvEi7ijTSbU1zDnfwUbG
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs/225, btrfs/164  reports warning due to a lockdep assertion failure:

[ 5343.002752] ------------[ cut here ]------------
[ 5343.002756] WARNING: CPU: 3 PID: 797246 at fs/btrfs/volumes.c:1165
close_fs_devices+0x200/0x220 [btrfs]

[ 5343.002933] Call Trace:
[ 5343.002938]  btrfs_rm_device.cold+0x147/0x1c0 [btrfs]
[ 5343.002981]  btrfs_ioctl+0x2dc2/0x3460 [btrfs]
[ 5343.003021]  ? __do_sys_newstat+0x48/0x70
[ 5343.003028]  ? lock_is_held_type+0xe8/0x140
[ 5343.003034]  ? __x64_sys_ioctl+0x83/0xb0
[ 5343.003037]  __x64_sys_ioctl+0x83/0xb0
[ 5343.003042]  do_syscall_64+0x3b/0xc0
[ 5343.003045]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 5343.003048] RIP: 0033:0x7fe125a17d87

The patch [1] removed uuid_mutex in btrfs_rm_device(). So now there is no
uuid_mutex in the call chain leading to close_fs_devices() that has
lockdep_assert_held(uuid_mutex).

 [1]  [PATCH v2 2/7] btrfs: do not take the uuid_mutex in btrfs_rm_device

The lockdep_assert_held(uuid_mutex) in close_fs_devices() was added by the
commit 425c6ed6486f (btrfs: do not hold device_list_mutex when closing
devices) as it found that device_list_mutex in close_fs_devices() was
redundant.

In the current code the lockdep_assert_held(uuid_mutex) in close_fs_devices()
in incorrect, remove it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
David,
  Pls feel free to either roll this into the patch "[PATCH v2 2/7] btrfs: do not
  take the uuid_mutex in btrfs_rm_device" or merge it as an independent patch.
 
 fs/btrfs/volumes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9fea27b9f9be..ac4a9f349932 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1162,8 +1162,6 @@ static void close_fs_devices(struct btrfs_fs_devices *fs_devices)
 {
 	struct btrfs_device *device, *tmp;
 
-	lockdep_assert_held(&uuid_mutex);
-
 	if (--fs_devices->opened > 0)
 		return;
 
-- 
2.31.1

