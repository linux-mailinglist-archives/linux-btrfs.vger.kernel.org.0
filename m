Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6B8766470
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 08:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjG1Gsc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 02:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjG1Gsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 02:48:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FB019B
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 23:48:29 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S1NDpj020254
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 06:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=shC1biK+BWxCwhwoEo8xXvwKFY5/KiKvvcpxWvUZqQU=;
 b=Go5zzKRD26m9b0CYcaz46OfSPLX88w9jkTG93G4a3Y3oWvY8qfAgGMvuo+8ce5Pnbqnt
 7kWhB5LdmvquBodkq3QfpcMspszQuiYUhAMvTqVaCXx+9Mv5iSDmbblG0zhDlkk/aRkX
 q01f0/NccM9wy7QtnYaNcTL6F8XGqii/nVCJWQjc409IxqqD1DhGMN8JKem6FohFWa9y
 t0Alboa3WSlJD4u1f0yYC+xK9z2YGz4Ij4u+l6clfJjoJo19jB5+vou/iS7WXP6Be0H+
 VcolPFzxqZTkqkbTAUqfRx5AZ2xUaci6PV1dPBQLVnj7JAJmXxffrVwxQ+g5rJjc2wNH zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3u9fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 06:48:29 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S5YiF5022966
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 06:48:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8kwp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 06:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyC0wm8o/m3xTsp0WWgGgrNhd2lOecUkHgG8U/VoMfjphdWmYXFtO2hDKrxmE9x0d+n23m+Lg9wxT/a2A2m5V0orAZVMXQYUpM8Y7T9t5bkY+/KmrUFjgI7cUF663709NrwHKSn+OQzogkepnsJhgTG1ZLBAvLjKWOt53nezWJMcjyqPB9KLuMRxXumW201SCrUFrm3Z7VtKgZzq19Ov4XEoKKa1fX0zbFQCAlK6JgVv2tdDMCjM9ZJS3XvBRtZpxFD7RV2QpqwstOWG6krne4TDTpIgxn/cinKdW02T3DcfZnO9Yc4YjCtN6czdCP3NDy2yQwrWi25A0d4zMU3jNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shC1biK+BWxCwhwoEo8xXvwKFY5/KiKvvcpxWvUZqQU=;
 b=bzbuBUkp+P1mN4A5iy8rhEKTAdTl6aMJYkyknTBKhTTKgj4j+mk9lS4zrircTfUUXokWDX0Mwws+M8eKV17Btob7Uvzys8KZtGfQtIQ65EKGnv7yQjPPfjdUKhyxlmQXkLntK6Y7DxL4MSSuDv7ospW3aTL9b1Zg11oIRD0xUCpFxvxKblrO+ipe6HS0psuiJT8O0+VS5wNawB6tNAXQT4+PqdwNsbtppkOO9C7IvbaXDU6ZGAD+950+RhhVVlILKQ5oxWKs2Bk8CykfyYaCZptzQJYL17kS0L5h/JRKijSGrUOD3k5U+6eh6jYhwfY8XVNnmXd1s4UsIPcC5meOLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shC1biK+BWxCwhwoEo8xXvwKFY5/KiKvvcpxWvUZqQU=;
 b=wPlGE5nrPxhkAqClK+PGdNy4ZF7GQfztqRpuz/OYo6eUKKn0a7nK6BSUb3i5k128KsTCLq/IC8dCnv0OdfPGfP+OqsGKDBvYLrZmHKHzycaSBnTRTQUmkpyBFw+JjsC3Pt4EiYXhwnvJy5mG/F+KHqXqNpxwvDsDWjcVKvcyTUk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6118.namprd10.prod.outlook.com (2603:10b6:930:36::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 06:48:25 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 06:48:25 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: fix replace/scrub failure with metadata_uuid
Date:   Fri, 28 Jul 2023 14:48:13 +0800
Message-Id: <50a6bd0ecd4e9e2b900de07c8ea47b71959df8ca.1690526680.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: b8317808-a5e5-41f2-71e9-08db8f36a491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tl6KkJLK8AzzQrpJ4Kb2D2/0RO6Qgq6dCHQqutkQnH1+fhAb3V9qWl5hYfq1pjWC+SAn5752vGaRqpqP60Y87aZaSJlLdQlDNCU6fR21A8JySbUr2MJMx5Jz0vVDj8beOWyhqhACaXfN9nmuXzM9dC4FIzXzL2ClMe+mN2i+4ZqedGt+LrtOao8J2dplB/g5iOLRZAPxqST2bNJjPmuJJfAIAA2aediqXw7KZ9TVsmtiP8FaT8DdXsyhoUCeXtfSRzj6rfKvhxh4eY3pWpeT+/CF10yaKY92+7KX1ktnqrCnUTv5eWRApgIXT1fBTGFh/MK/38By+MSyPNOQzbyJ2smO4o9gYXA+tIeJ1Rc108CfqMDKZi2uvwbtbBC2bA0Kb8tcjqBgQgxAUkoROYBlQcsQ/CVx34/U3WCMynrdh6NSjRhlg1jUKFa0QNgcjLqjB3aP64mRlcC37bitMdzHm6r7ueuZVJZ1HDRRFJjGfiXTN8UpZmRgtAq/huXFaZnScYh+moV8MN42qhcceikaVIYE5it12dojqc/prBVoXwkOCoDJWuSffQrjVcO7maTa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(83380400001)(44832011)(2906002)(2616005)(6666004)(6486002)(26005)(6512007)(86362001)(478600001)(38100700002)(5660300002)(41300700001)(66476007)(66946007)(6506007)(186003)(66556008)(316002)(8676002)(36756003)(6916009)(8936002)(4326008)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?snDIURm5+tr8bObtUy3CIVWQzqwbjxVt8sw3Rjhlx0VGeMjTrJ4dMwEZ6vwm?=
 =?us-ascii?Q?CK/Zp6d49p2Ud4jOxr1PjNG78c7nV0PW5IvaNKMXk0c/ufo75Z8vD5eV+Lyz?=
 =?us-ascii?Q?v1hp1ZMzrrzgAg0VXdHw/1EwRqqIxTSwXU/x4+AbmrBBSvRKWVepXr5z+rK+?=
 =?us-ascii?Q?kpkb9HrSLL2fhHucOurF/NgZl1JoKg+X4XxAToRa5Sk07+dXvaJklzEijPxS?=
 =?us-ascii?Q?nrOfkTjXY4HnU1BvTuej43179S+fsh161zzY/pqHZP+J7unIKgu6qOAwkqGj?=
 =?us-ascii?Q?oFt0lE7WzLQCeBtyG7mOIPob3iSwTGbhXSgQQZJd0Vq0juJdAaYlY0QHoB4L?=
 =?us-ascii?Q?hGc5+6MYVx0OnkkM7na65GGLY/K9SIyK5RcP5gvI0UU58R3tPkqHsOx676tK?=
 =?us-ascii?Q?//lBTPcMe85c/KdhYzp959ZB9MFbOrGpUeqqMVb5+mWCRYRNdSA2a9XfMsDc?=
 =?us-ascii?Q?greBHuU5ws9dIN8HexvmolSzOdY0iQ29P0AU1/EzmT4XgYq0q+XNvC+koFAB?=
 =?us-ascii?Q?0gfAxp06DoQH94bYzi4jqPsLayZuCmmm2bUXrTkx4hcQV20cbqImDR9hkDw+?=
 =?us-ascii?Q?SRKO0uEfbAhKZjoFVzxoImqkqmr7pd6AWXjpj5/jsSwixSx4QPjwtgt1+Jp9?=
 =?us-ascii?Q?RwUgz1Qj1KYw3o9yoC4hUIrtz7hbsC5/ZhMslfnMZt6L3aNo4/HI2e2ZCO+a?=
 =?us-ascii?Q?VmNzSfyn4eQCjajz1VyP3QuX47QMhoJHdaf4ML+Q1VY4xQbJYeJZv2PaEUCg?=
 =?us-ascii?Q?jCCzPk8S71t0OGtTxI6t4kEYhTvLfkwg4zzKA6Dy7/N4UPsFBsROmWenVETS?=
 =?us-ascii?Q?TCZ1K1kyOVWG2PTXkrdjlWKoScUaybPGngtj48ffyDYwQcjyL475J3QAhu0Z?=
 =?us-ascii?Q?DAuJ2DQnhJOW0JXQj0EGZ6cQcE0aBA9BKt5j6b9/z+vlb/Tplaczp8LC+mIj?=
 =?us-ascii?Q?i0ndflbA8QTiOSU7tnzwDFzQl0XfzhmYOnJMqWMaULxQftyGjNGh947yncZ4?=
 =?us-ascii?Q?26P3hV+AlPlGPPHDLN6NOj5mhj3BuO0n1wYIFzH+JOXwiErGUUcsTot9awM+?=
 =?us-ascii?Q?cGZty7KG+SApZ26wfWSeH38/GlzJzc6V+q2eqgpq1qgLJVsAcm2Vx3LuoPmy?=
 =?us-ascii?Q?uJzBVwYlu5UWjEL/B3uS7ZbCzEWWnf7HTdY+yUUGUgIT5W+Otai6ufcYArJo?=
 =?us-ascii?Q?h5ApMbdJORvCiGX9Ulfk+Ci67L5r0stUGzqWuKBVyfu/mVI6iYB5sWsoa5V6?=
 =?us-ascii?Q?QGkEUQQaoHbDuK8nTTB6jEwjNmoRC90EmcZzz+bERRF/TZ7G3X3GSHz/9GXH?=
 =?us-ascii?Q?JYMehGPbTUdBAafjmkwEFPUIWwnIJ256FfMp3d7qin1mTnxM+E6n4+mMsgSE?=
 =?us-ascii?Q?EfOFDY3zU6CNrtJgRoYkK4aUbdRJDmZrmV9qsPfW6YszwHlpQd0GkaSWvin0?=
 =?us-ascii?Q?SInMgyUNRxMgFdwy+/f0lE1akJFjU7uddTHjG/a5Y7tfHGsD+fQNssw9WdTK?=
 =?us-ascii?Q?B+nvMfuCC1ta1IHjW8V2C1nWtmYbJZ1l5jjNQWptanOUYgDoHT4biMelRCCP?=
 =?us-ascii?Q?U+9W40m687L06afS3uv9xUUETn6oRpXy6EibN4VT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9QyOy2yYYcQ3U5Lg23zRVVRt4iZ5+jFqX0uyaDyW8uByE+PdSDoj9w1suh2U9PDyoWqFb7qx5bQhvggaEYSnf/E1DO2lasiE+yocBGeTIEFl/XMebWFpCUOFpNz95z+XWHdIRbeI+4VjOr6vigt50IZ5RFpsmgK3K1NV6UgFfeRQhKD9vR9DPuOzE/ZuVvxjM96qbuWmn41Lq0Ec1a60+mozGAsAx/2CaDk7gDjfDyG6liNt+lbdpG8lt6DIz52MJi5sMA0FOFAZIvyCCtYdxKVtCy68wf9QHyETH6yyPguIpXlRfHYQ3riKXmVeLn9RedgLmtIHgKjAJOa63IbwXFGkyvUxCRugBIWeu42cZrkvTsLft6LhdU5ugueqYFLsazpqiH9SvM/jbLSfAg+VMjsjTpa7XhjcvSZF0BUJIijs9usnH6KIRexPgFpck2P0VcZ4p0xkhRfRNI0fXxtyK1/0zYiYW4daKykix3rh9R9x90oHVDDil2o/WBOUiy9f7u3KKnvF8FTRzJ41LkzZTpUj6QocIEdaNNRBKckVNU8zD6tHYdXxeQz9LITwGD3iqZvRvZcVBa8abYNjlCE6sxUNWbRnD7C6dv5jDHCdDYV3yv7yT7aKzGqNhk/hrg35zJ/Fx/LTTwmdF1IiHADOWfLZrHVFqrmbD+/3c671q1K8YeI36sKhSYbqcIJFzOIyxxWuAe2qcH9CndgjTybORKW330VHStkQ7qRrWecQ1Nah2r/8JQO4n0KEMXrCEG0IaCto1bG9wFAbj1znxVH7gA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8317808-a5e5-41f2-71e9-08db8f36a491
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 06:48:25.8228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Igd2iUShfjRbz0MCNgTcQT1MrxQ8MA5T28dIb0H2MDEQ0nZBWQ14BNZ1LQBVfuMLiH+PYmrRMLB9ZgSXkyjuNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280061
X-Proofpoint-GUID: CRMfn25q3m6rro-9bdIGUyRpYGqQXdMF
X-Proofpoint-ORIG-GUID: CRMfn25q3m6rro-9bdIGUyRpYGqQXdMF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fstests with POST_MKFS_CMD="btrfstune -m" (as in the mailing list)
reported a few of the test cases failing.

The failure scenario can be summaried and simplified as follows:

  $ mkfs.btrfs -fq -draid1 -mraid1 /dev/sdb1 /dev/sdb2 :0
  $ btrfstune -m /dev/sdb1 :0
  $ wipefs -a /dev/sdb1 :0
  $ mount -o degraded /dev/sdb2 /btrfs :0
  $ btrfs replace start -B -f -r 1 /dev/sdb1 /btrfs :1
    STDERR:
    ERROR: ioctl(DEV_REPLACE_START) failed on "/btrfs": Input/output error

  [11290.583502] BTRFS warning (device sdb2): tree block 22036480 mirror 2 has bad fsid, has 99835c32-49f0-4668-9e66-dc277a96b4a6 want da40350c-33ac-4872-92a8-4948ed8c04d0
  [11290.586580] BTRFS error (device sdb2): unable to fix up (regular) error at logical 22020096 on dev /dev/sdb8 physical 1048576

As above, the replace is failing because we are verifying the header with
fs_devices::fsid instead of fs_devices::metadata_uuid, despite the
metadata_uuid actually being present.

To fix this, use fs_devices::metadata_uuid;

(We copy fsid into fs_devices::metadata_uuid if there is no
metadata_uuid, so its fine).

Fixes: a3ddbaebc7c9 ("btrfs: scrub: introduce a helper to verify one metadata block")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/scrub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index db076e12f442..8381174bda15 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -605,7 +605,8 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 			      btrfs_stack_header_bytenr(header), logical);
 		return;
 	}
-	if (memcmp(header->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE) != 0) {
+	if (memcmp(header->fsid, fs_info->fs_devices->metadata_uuid,
+		   BTRFS_FSID_SIZE) != 0) {
 		bitmap_set(&stripe->meta_error_bitmap, sector_nr, sectors_per_tree);
 		bitmap_set(&stripe->error_bitmap, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-- 
2.38.1

