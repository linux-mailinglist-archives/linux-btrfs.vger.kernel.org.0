Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DC569B688
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 00:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBQXso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Feb 2023 18:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjBQXsm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Feb 2023 18:48:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEED25961;
        Fri, 17 Feb 2023 15:48:41 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HNY8Pj031224;
        Fri, 17 Feb 2023 23:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=9YBWnqyn7/KXTjgfL5y6baRQ0sUm2A+O0f5id1PwZl4=;
 b=w5mFdYyJO2dNyk8I5n2vVAo5QJaJIJ3lCu5kmry9z9+H1NAa9sSq252CPkMeKxXga5KZ
 wrS6nRoFbZbxydCJEw3Dy6QKGq/8OmoCnrZmopkenzT8ZLHmjHkheiEtGWwCBpSuvNnO
 qBE9G9nhSt4MKrEWmNVyMC5s83h0l+NVB4VxYta551K0R2QPgFu4NifwjFCztIEYx/10
 50fCUzSmaSE8T30p3N9A7ksV/Hj2+HIxP4V70sZTuWHhM9PLggH/7c9IWkem2qTdtbYT
 cFjqqD3ksSpy6g8A/mQLvqNdmvu45M5otVqbWdx8oixqX/ux7dh3zp3rYhT5TH7lxn/5 ew== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np2mtq697-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:48:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HLUxKl022796;
        Fri, 17 Feb 2023 23:48:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1faq7wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 23:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHOBKr2Xn7KVqR+NHZOBJYz/neSJLmnE8WxOJ6PiQLzzXgXJGo0BNQnoEsruAUMKbkaJVcUROhcsmAQkVYjDBppEOupQZVdt6t8wKxxXmYcQCT8DwO49nUQJJUzExTn2kY3HKCIX0/vwPF/iUx1hvjtmbuj3JN6moIHhA0+2HLOvvFT4BUB62O3EMgodhQc01hzwdbxLAWpAKKc2O4Q17V1WusbzM889w9GOW30I6fxqskN71RB8VhUk0X3tEC4wP/bj3NodDsmHAFABhk5swyVjM0vQxUComuu8RM2ccdjnYyxKpiSOdV1L0t0EehE3rDXaJGwuvFZcIV8TD5tgGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YBWnqyn7/KXTjgfL5y6baRQ0sUm2A+O0f5id1PwZl4=;
 b=eSd7UmfrgSGsDUp2nVGBkWN3RUS1oiKn4z3HilmRMS9mWGava2tZATyo65Ss1iBg+D2UHsUmWZKiE2b+E3OXrRYztyp3wpUsn9m/AgLAHKY0762t9zCutaxja1nWETjgjnGIBzHKrpXPfFhGfypnsELT/aNKFiWEqVIqpJs3bE3qtZLIN4IzIprqy7IzKRKsoqenfnt/TT4dgGgHIT6uPvfwFAQ1+V+EQsM7E+sqvE7vXGMCF7AYG4nEFbTqBvoZe5TSjyjJnePnwpxy2kuga66GPGavgCFpCu1/CTJh56gC56SnZ9qTgHAYHhfe+KiFyr6oOmNkBX7U0L0P+f2+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YBWnqyn7/KXTjgfL5y6baRQ0sUm2A+O0f5id1PwZl4=;
 b=hntv59BBaxQIHJ9L3zmPYlVAN4Kxsw7pxr8JIqBSSw+eoYoBPET2zgDC1Nm9DTSjoA8Ur3EgODTkx5ToS8y6/3ByKxEGK852coL673OzqJusljwXjUmra1NhlP/rZ8gCJRLRnXYn/U2i/ShI19KRbqwAgQdofJKXImJ3Fj3VCEU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5249.namprd10.prod.outlook.com (2603:10b6:208:327::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Fri, 17 Feb
 2023 23:48:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%4]) with mapi id 15.20.6134.006; Fri, 17 Feb 2023
 23:48:24 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v3] Subject: [PATCH v3] fstests: btrfs/249: add _wants_kernel_commit and _fixed_by_git_commit
Date:   Sat, 18 Feb 2023 07:46:56 +0800
Message-Id: <94140118c6e86d2d9979ccc2c844d5c24d2964f2.1676677149.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
References: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5249:EE_
X-MS-Office365-Filtering-Correlation-Id: 82dd615a-36fa-4c0a-0618-08db11417572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrVXJPKInD8uTLC0nPP8f2QtMuC13uASlTuKGwAM2w62hTy6gIcPQnjje/mE6gvyu4ohUXozICr0HXa2BquSuspf/eLUMUTUcA8y3rMbKkvY3jN6MO1iWHGraxhh0U6u2EwUGJDVxtG00pXJWnkvQ6+q9bI5ThwhjbB+pz3pUoPZFedF1KZKo4b5EvPFrWrLv8eSlFI6ceqxsE84wqECdRozm9SQVKNVBRtadSoNvNh9l+i8VPhpODbwwlCxWaWxONy581BF4KhuFaOcjDXCN/RdUtik6nD5dkwGWUhP7VzYxiVOabxRXCMWe6lKCBcxtIymPmv+Py9zieqyWsG52nQQrR6Z0TFb3btaThAuMUUIcpbpWprX5l42mdwX+zTqdP869IIyz2kUKd+rYAZ2VuNdnmrUOPhu0gEos0oDJKYpW0G2Dzuq55ZxiVpzZ4p92BCNsD4i2uez8lnRpj/NuDZymbl5r3nigOPN1PHw2RAej0VAB6oBPLJasSK2NHybdPx8Y7Pl+RZ8yJs1eA882VS3Xt+aQd5TviEWz4TKNQC7vN6jiPK7QOUqvKhGoWTU37tT5M/Zni5feuvlKiLnlxWDkLMTiaRxW2tW6G3mbf7fyAeTZQIj+kQWHND0IC+Ty4NNsUOH698D6EHI63v9qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199018)(41300700001)(4326008)(6512007)(2906002)(38100700002)(6666004)(36756003)(86362001)(478600001)(8936002)(6506007)(6486002)(83380400001)(186003)(2616005)(44832011)(8676002)(5660300002)(6916009)(66946007)(316002)(66556008)(66476007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hiLPLJ6bS/3lvUjeqvgGsqc8WIuJbJK+Aq9vyW0Xnso5+48V7nDIBnzuS3+j?=
 =?us-ascii?Q?MNKAvaNZU0I7bn2wNGKTx2XrCuelZ0JPFIPZc6EoDQjC3hudhqmdMmMVpAal?=
 =?us-ascii?Q?Me0tcbyYmmc0RiQ9f4qYE7sZ/jM+Zn5Btk9uIM9SPEE0UC3FJIXYq7L36eOz?=
 =?us-ascii?Q?+3bo1RQJ85XJRUmw0g9VmS844uvpxGsikkvc4CYjT9zY9Uk5hNozHUvuAgSa?=
 =?us-ascii?Q?JGDMkdwpDv1zy4uNp8HDBwcoa9fgG/Qw1EOQFmPyHYGO9K9+NR13opYOr4G1?=
 =?us-ascii?Q?2pp9x7silSeQNvX9lpAXKkJYDs3pZ3CY8sdBO/wEikJbWNIgJhYA0p5SO6Du?=
 =?us-ascii?Q?qCxH6PDaL/t4fgiSYHDFRSCwU0fo0mRzkhTAUkvNX3tGTgl2hfugvVbFlWtG?=
 =?us-ascii?Q?eB3adWGKWRHnb2h2yCWi/k2nVtVjLhZOIFNU3RKuDc9EBZ+Z+puKNhRi0DmX?=
 =?us-ascii?Q?MM9IGPbFfFX9Gs5i6GOG8Dre7lPEdhi7qs+TIzpribwALj+r3024gNcPO0Gh?=
 =?us-ascii?Q?/ZNlP3paFcaIE9E8WdSm3coJ+kJTa0OqA/sflvyIlSiqJ5sjsN0ULUeFfR1z?=
 =?us-ascii?Q?Vo4HadSvasu3DM8mcqFIVmJCp6xU9cWUXiazV2RxXtSeEK0JqY+fUZhYg8FT?=
 =?us-ascii?Q?/M52q0UkQgPJJYZcgO7/e8J20sLxzsNUvSvzccXzvTHzts2aDSorxaJETgbk?=
 =?us-ascii?Q?OF+sYgwfWNS22aI+lrB2KGwAV+vRQIOJ+8SStfwx15XS6MumQuvjawHktQFN?=
 =?us-ascii?Q?PctikSaTGGZDfkxzb6aTSBFz5Af+A6n5ieXpTzxPsJ18qqB/1IjUFbHJcJNY?=
 =?us-ascii?Q?I5NAYPth945GKRPp5oC1bbrK0fJUA9OGyeb5bXUooaLAaUKSbCDNS5oxNPf/?=
 =?us-ascii?Q?+R1a8tUJXdgPYsjZxNyYk/hV0aBTZsg9eAnQPbkbs7YSXWfWHktgJDOTGBY0?=
 =?us-ascii?Q?xPiV0hogEjdnIxTWO6yazlWf/fGIfso7f/SG6VVNw0qx5vK1mcp7eKwRSCU1?=
 =?us-ascii?Q?lBazYJlkJAMKc2orl/MIxVnqbg39/Hyly1DVOXremu/6Bh3ACXAN/UyeGMjs?=
 =?us-ascii?Q?yfPFI/H+Z6XLgM7ZFKgTzuVlUoMRA4lH+mOxg/M3d2LFvd/qyFVLn8IRvS76?=
 =?us-ascii?Q?YdEHQ6FGaf8dsEhiaA50z+ojuq+ddyp2vec/odZ1AmmnQfaVdyWZ9KhpIZLX?=
 =?us-ascii?Q?U6ocstTsF50Vr84HuXFRGelQTa+/yFjeBF8NXVdK5/BSDEZSDbh8rQ+X9IX4?=
 =?us-ascii?Q?MOG6Ge7qy7giHBtNrYk4vGZS/pR2IjcOmtNaHXDJ4+dpGoaZS+k/+MaXrWdV?=
 =?us-ascii?Q?dQAxQI7YMXjuWzE0SW4+NCuLTlIc5DpEeYvdxJYQPAL2n61rxzPbVwMloFue?=
 =?us-ascii?Q?txPbBg6byEPdmRvhV4ysJbUxFS7sMIqjwic8Lr4k2UIqFNcexQ1Shpi+9+Rm?=
 =?us-ascii?Q?lMUhxmNk8m2zzLuB1mUYSdiEQ2RsnzG7QWg0VHbL5/l9F0KVGgFpqRJ3E97R?=
 =?us-ascii?Q?ylvQB/JJdcKzIZ/yPBcMFAhJQ2GSNpwwwC83/ZL2jrz+p85STRlbxJnoZT7r?=
 =?us-ascii?Q?j4H05MpM/2Oru5GpkCCuR7+5orbSP9aIDMbWzNckEaF6ceGQb18CowFDue41?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T9LtPymNnelotjHqd47ZfyKB5QTKcog27c1bYmkPW9xZQf9zzmop1AELIhd4bQylE5pwRcfqmAakRC9b8q1FI+jhnMtNYzrl3CSUp+POHwHDZrsZwEaS58H+oeqHInWo/Ci4gDhsN9UZySYM29hQFllJoFC8O7nSk5XWn+x+uYHUtrYdyYUbadZT+mTiFk/FcsWg1z4CsRhGQceflSzglroiGcC3B5EOIRDAEgL04FaxfKUYAJmZvr6z2KIt/LoAbnHuQapBr4oEGMrPn7PLYCDUWbkfQPW3WOPJ1yPC6GS6fJ7tCkafnai1uFOkIZFX1GU433+vOHKG2WLg2+r1AkZgE2pCDGibJ6H3uWlGwJaW/tHQXHOyo0KEcSMb9CZL/FvdCpsSgNXDUOHIVhhXFGFgH5Yr6qOFijIXhH60ptv8InOopGrOqgIYNZN2wfePmNU13Tx4F7Jisg0SwGoo5C8dW0WVMXjMXreY9O4SrG+tmdX290LLv011fcjxb3/z7kUlf/Jf+Jhj16dysgMVwUJlvLyG6LL3JTKyVQKnoxZM6Y6ZqE7YL+P3yE0x1pn48oGVaL4HqL4MIGvNHycFH+m0GY/ZFuKu12WY4yN1brl04IPyqhMnEEwN0XuBa5Z+LK1TohS7g71o6kGypP6AUDr/f2BGoEpwhMAypakVF9GL6hgP3KmLOLr/LORmaTBGDG1RPoyEqClFngNjcHZU/Z7f7B96Z8rsFIMyfDUT2xMguac84NilWstnsW93+r1nZmS6zl2QlutngdDQG3tvDVns22GEqTqBiDM1lOaTOlE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dd615a-36fa-4c0a-0618-08db11417572
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 23:48:24.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKSGG7kTTurqcrZ5UKkq5dNHdTQEZ8fhHpg5+2yDg1A691HvFgApA/dh50MHuv+LbemSU5+ixbClqi6q1bUFNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_15,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170206
X-Proofpoint-GUID: 8AaL1YIvb0nHJaLeHMlnMO1gNeoAQ9zh
X-Proofpoint-ORIG-GUID: 8AaL1YIvb0nHJaLeHMlnMO1gNeoAQ9zh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the _wants_kernel_commit tag for kernel and _fixed_by_git_commit tag
for the btrfs-progs for the benefit of testing on the older kernels and
the older btrfs-progs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
v3: Fix title and change log
    Old title: fstests: btrfs/249: add _wants_kernel_commit
v2: Include the necessary btrfs-progs patch.

 tests/btrfs/249 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/249 b/tests/btrfs/249
index 7cc4996e387b..06cc444b5d7a 100755
--- a/tests/btrfs/249
+++ b/tests/btrfs/249
@@ -12,9 +12,6 @@
 #  Create a sprout filesystem (an rw device on top of a seed device)
 #  Dump 'btrfs filesystem usage', check it didn't fail
 #
-# Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
-#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
-#   btrfs-progs: read fsid from the sysfs in device_is_seed
 
 . ./common/preamble
 _begin_fstest auto quick seed volume
@@ -29,6 +26,10 @@ _supported_fs btrfs
 _require_scratch_dev_pool 3
 _require_command "$WIPEFS_PROG" wipefs
 _require_btrfs_forget_or_module_loadable
+_wants_kernel_commit a26d60dedf9a \
+	"btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
+_fixed_by_git_commit btrfs-progs xxxxxxxxxxxx \
+	"btrfs-progs: read fsid from the sysfs in device_is_seed"
 
 _scratch_dev_pool_get 2
 # use the scratch devices as seed devices
-- 
2.38.1

