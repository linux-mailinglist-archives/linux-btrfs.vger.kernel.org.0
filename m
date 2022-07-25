Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A84658012B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 17:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiGYPKu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 11:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiGYPKs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 11:10:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C035637E
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 08:10:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PF9UOD022457
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Q8Dbd4w2YFJpcx4omoLkxb9TE/tRiIduteBZpqHIYzE=;
 b=oAVdHHa0WGYXK9AOKVLfidWGWC/ui9MeRkKJgcVwqTLKRnb7MxQjRw652+Ji8ypN1mk+
 OwCnfjFaT89P7GTF+Cc1q6/NNc7vTaD6+cM7MZGKggC2h5kY0UYRUo5/yUTUFkmv9E1X
 HmcFOTMT+iFYHoiY4m7SJ/jiPSNsCvtbiX9p9ttXVPqgUGZ3JcfnQTPVckWo1v4xPqRE
 Dju22T3zUMxh6TsVJglyI7TsjDjYf6WPe4lxm3ypUEqa3e/Jiqzs9HZdpOwdGh8nR0k5
 8XIaJL/SSb2ZAYcopbVL8Lwl6hC+nvHjzfy4vqOcvDcdwMffI1iznMxhTCvzr8HXmEEg vA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hg9hsknr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:10:47 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26PF5wZx016641
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:10:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hh64ybvmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 15:10:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+q5CWpMD828ji37c7KqWvua5LnKclLgPHqEA+6UYgrWIjbqewaV+rgmtm54oyAlBZXdqvPPq+JXYX987i8Rm19fTdpidQEKKgLE1uewRbvpUeqJmc5lTRhC64AewhgweBV3EmJeMLBObSGLXEMj33dqRF6M/L55zI4ghUbP+tOej2k3hOTlJ0ZZ1HiaHcN4OGzMXZEZjtVRNleL0S+jnuJpZrdlVkRF/Cn4nxeQ4EdlRXF64e+5SHHcF/NlXyKYwMt1lH1swMcWnvLgkT4p583hGbQ6RnGmoeigf139AsIebAVi/LFoj25NfqgC0qAdrU+SDI5j25q3npjLIMpMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8Dbd4w2YFJpcx4omoLkxb9TE/tRiIduteBZpqHIYzE=;
 b=D8wc/UzZFKQD+Id+1dDqELsykrGxPLQZHb+fWfol7Ewdi5UZpGBsgZC15B6lcVWe5zQrXdKuHh5dR8K9nPBpBagO3A07s+nKF/zv38rSAwibo+Hjh5FmxX7hZHFwHtNoj0+8XMVJl9vf5Y55lVj7LeKRBwZPrL9N9nAgQkyCT8w4YhpVORpwKr1JQHC/30kzk43e9rKeX8dl6TdQ12uIQPQlJnuQZmWW1ICjaNcpRYM1q0jO6Bq08G/5VZRiv4yXUwILjCdD5vF3P7eRDW86rc7BJ3iF75fKvf24LDuh9pLS5EGXQAJfIY2wKK5NqpSc5Bpgmxc17dB9oqM2L/ebrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8Dbd4w2YFJpcx4omoLkxb9TE/tRiIduteBZpqHIYzE=;
 b=s9umXduZdGP2QUEP8dL0mKDi7RlCXmufkrd0OBXWBWJFuzoAGYztudbK889ckAAQHhGJQCDj1gCrnOyx5sMIOFHATcVyjCSw/jUYQNHcb7JtaKsbNS0vb2de1sT9BE4BropYabLSnBoYasUiTIBc69h9O4uuWPAfX4URw/bvtjo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 15:10:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%7]) with mapi id 15.20.5458.019; Mon, 25 Jul 2022
 15:10:45 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs: read_policy type device
Date:   Mon, 25 Jul 2022 23:10:35 +0800
Message-Id: <cover.1658409737.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9ea24e5-5b6f-471d-8986-08da6e4fd8d0
X-MS-TrafficTypeDiagnostic: SA2PR10MB4715:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a39CGGQBZdZ75rpj84XK5qC7jZ8UgsfudgNKYIOuEDuw2I5+elC5WPT8sKzxuzac2LP229K7OULgNAH/U9dFnRvObv+xxPbllAi4BuK+TpZlZpRsRNXFuGwpQEW8rc/CVtH3e/W1FCUKn0zGCH0a7p03neh4LONTPxl6u6UsoOZ+Ls7sDB7TtS4t7kEaYpu+U+xrhPeZ3jUJZ1gDb2uhJAGL67m0n1+D7Z/z6zV4qDS2N2L+RJc1hpHvIpAMJPgr/VEoA6E/0hf0L40rtbPyk4fagPsCJCJqIPsWs0whiXYXMi2je2QmFAiklVcs8gZMe3VRZEwFb9em/Iy6Ch1mBjdC97NYgyFaDgCaLxkHwKw9NQp+FWcozSOaVb8VaIdv0/oz42fAZLL/NsuO80+hxABHhnSMO5RrN463Mmd8CDyRG75gcC624h5Iw8QuL/PEdPZNwE/UJpWToXmXsK+HNZK2gVOIIN9gu27QdFAGO+j2cyp707oh34NnPOQkSBc+BI3uXCC6dMxjFkeZXbbeHMTp/wkbnjkME8v/raGzcIZHQPgyrKA12F5f13r1W4Yh/vpKlvA0UM9q9o8+TAZC9oxHrAM6rSkns/XC26EcO3+ZP37E2FTxuPIYMxFpw4vpmcHkQLWsl+kikCdjLo6eC9WLnJwsvenRnWNFfnF6iDQjJajfyYSjvw99HBglFpTM2Wu1kRMC0fkJROhvLUjhLP6SmUJwTcn0OZB0+E9QL9WcbJMZJwz7h26GZq6zehz+2iNk3L3xo4LPak+c727KxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(376002)(396003)(346002)(6916009)(316002)(41300700001)(6506007)(966005)(478600001)(6486002)(6666004)(66946007)(44832011)(66476007)(66556008)(5660300002)(8676002)(4744005)(2906002)(8936002)(36756003)(86362001)(38100700002)(186003)(6512007)(83380400001)(2616005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6tJTMpqb8aVoA/FdUdQgoEplE15EYoBWv/O/6B/aiNxN0SnTAYiDlvs5baE/?=
 =?us-ascii?Q?nf29FrZ64X4c0/Zt7p51LwA+RU2d4QcZ6zg1wyeuy2hmOsG9Tjt/z9A8ejn/?=
 =?us-ascii?Q?2qGJid7OArg7YqopGr3FP7wIpYuNQGXttpxGr3poGD/nB+1XI04MT12c5SVH?=
 =?us-ascii?Q?gxnwsqF8e00TgF0uAY89bJure+DujdXB1Md0RrJ2iJ1ZHBol0DyXtBKwVwUD?=
 =?us-ascii?Q?/FCAk7lmZrqt+oW8/yo/k/TEb8ibN5Trd730ySapm5cfYDNea00y4wKLddIg?=
 =?us-ascii?Q?nIz4acS9tpxW0YeNVqxkGrkysepdLVwZPJKfrH9ZIFlUkG+JmwlVr+2j5U+3?=
 =?us-ascii?Q?I2zL0nmEMCd5q2nWyzH5dggt0CAd23Z8rkNeszhezMVyOsPjXsnWsmzwSjrA?=
 =?us-ascii?Q?2HC4xJ3WyKziKlI2Sg+W44KVL7nmJuIsu115YlAc2d05etIXcZMYBMRSYppO?=
 =?us-ascii?Q?t0XUldWr/aBLfYBnOwP3mFmAKYK5hqWu+yYaHuWjFq7mTczANtFsGbIBi6sU?=
 =?us-ascii?Q?OZT0oqYBv9aUi6XTZ7laVQFQqJ61MzvROtaGWmDcKFi3wzpIsm07NV66WTxK?=
 =?us-ascii?Q?Ut1wUfPykY5q1YL91pifvc0gH+bG9ABdvcc16qRdXvpp/cAT5ii82okrYqPc?=
 =?us-ascii?Q?0jeOq1RV6HrAV8FTu3thlaPSVH6RYFLU36PKMc7Pwl8mGeSr8S9i/MsRGiGk?=
 =?us-ascii?Q?rr+HFNnzgEqrue0wN5ZUGUEPSBeG7v4gBk6WNDclGwovgirHDgGvI6pgoL0G?=
 =?us-ascii?Q?ySigiy0Qw6OMcwZvjqnnlYauQFrLiO6KVZKnmSzyZlBf0+GnZtjWEl6j042T?=
 =?us-ascii?Q?OfMdxjg9aNhSXl1Q14yBoIj4TBSzLuSZP1cKceCExZjZqrNKWPCzqOCjpf2M?=
 =?us-ascii?Q?SQy6skNqeN/QiGOdyQqf6E7NXhs4kZxGNzP05MVCB1R+YzxInNi8UkvD0INn?=
 =?us-ascii?Q?lOiJnHOdL3Js1dB7L9iK01UwkWODa2Nzi0wji88gWWedsCUxC5sssaw5DFaD?=
 =?us-ascii?Q?20ZLJ33vbzPmLz+fU4VJB3fYnnJ0TEmKPishGmMvpzMHuDjGX9UgBD1H4LPN?=
 =?us-ascii?Q?rkmhdRUQTX4UyGmSpqG7m1KBMVV98ZEXMJnwBQ2FhwzuYwUH0Zhtef0PpwL+?=
 =?us-ascii?Q?fMgcpLce/9J4zU+Ode2E/xfDOKC4SLdHUBWAC8pdwhcxTqEC6dYcDbh7+yai?=
 =?us-ascii?Q?gS+n1JPXjOsCRZjD/3CulBiU3poQBcKMVfbLW9l89c6c1YXFHIkZ5bBz/yEj?=
 =?us-ascii?Q?nJtwNc6xRlTuhrLnbJwAIJqZvObAckMEdosoyG57p7Cj8yySx19n3jB7m24q?=
 =?us-ascii?Q?J6eHee0KjpT/4CfD5hZK3WEQtkmgt0+QdVUFobKtMkZwwtMNDV5YNtPyQr4t?=
 =?us-ascii?Q?zFy2ZeyCDAYrvmKbpLEQoKF68GIWG1YnqN9IJK7a86J6hjsx/bmy/U07DQBH?=
 =?us-ascii?Q?5hv5G9/miwHCE3YgCH3RgXQCcvUcc1sMJA2zMWZEDi1JIbocoMXF2vy3QGmm?=
 =?us-ascii?Q?Y919nl6O+AzZZFfSN68DnMxgl6cbyirt0bQvBIXXeZNuOEUgLUFmoCY/K5EF?=
 =?us-ascii?Q?edt7TxCgV3dNFwnNsVTsdB8Mt8yRHWyMvFPfA6oW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ea24e5-5b6f-471d-8986-08da6e4fd8d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 15:10:45.2393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQY0phq8Aeu0xyS2eefOXwTXbN9fYK8HedyGmUCGzuo+KePQHpAwOmZxohMU8TXWFCIvGE95/8KPa6WBefyD6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_10,2022-07-25_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 mlxlogscore=656 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207250062
X-Proofpoint-ORIG-GUID: v2d9fqcXvPuy_QiPBCt26wqAy9_A_RkN
X-Proofpoint-GUID: v2d9fqcXvPuy_QiPBCt26wqAy9_A_RkN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch set provides a read_policy type device and was part of the
other read_policies before [1].

[1]
  Re: [PATCH v4 0/3, full-cover-letter] btrfs: read_policy types latency, device and round-robin
  https://lore.kernel.org/linux-btrfs/20210120123437.OVx7ybGaVfmOdZxtpp43qcB_ORHQQs5OzPSzr3ZUGbo@z/T/

I am sending them separately as they help to test the integrity of the
mirrored RAID devices.

No change from the previous V4 except for the rebase conflict fixes.

Anand Jain (2):
  btrfs: introduce new device-state read_preferred
  btrfs: introduce new read_policy device

 fs/btrfs/sysfs.c   | 55 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c | 23 +++++++++++++++++++
 fs/btrfs/volumes.h |  3 +++
 3 files changed, 80 insertions(+), 1 deletion(-)

-- 
2.33.1

