Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A74760CE4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 10:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjGYIZY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 04:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGYIZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 04:25:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C544E66
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 01:25:19 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P7ob0h026771
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Ejl3Gzs2iD72kUvAdittupk2Pa/bqIz2sxP5a5Sh1tc=;
 b=QTxjnL9erpIQw93Svb+EllqYHM2qbSkhRp7QNII047mXLtxELGYUGbOSELZIl6CrUPek
 5ErZrzPOBkqVN1lRjbCqXamKhriU4Pu9YTrc0a/Q0R6R9zMNnEpuWH84NmrhcMiDokg7
 ir9rU/+JoH5wIECV5NwRwOo/yVvlYO6CcGymxEelyEQXkT5KgWZFILU8/x/Na17oXS7l
 2k8/TyqQvY5a2Cf/RauGXp8e/LtCJ7xqXzOWR3x7M8y3Y8GctZWdERL2erAjQb4MBTzk
 EoUSh95WTWig/Mpzq9xcPSu/rcA+hn47kKkkznt+2Lcqo7PsvzqFIUUDIU5gfy8R37ZY gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070avh0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36P6RLSC028903
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j4pt4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 08:25:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6IkiBnuR/eQp7/90bIclwWIBt6Ss0vfYwy0iMkEOnZztL7Rg4YBJH+wEoA0QFVejxSwGGQj5Elh0nFSd4ic0Q3SJj7SMdLj2cwyJ/j53aKSe3IRzmMGiqfYW73Ylmq2LTArcPjTZ39GeW/BTQcCsRC7RMzhCYaDIYL5cM+L5Q5bKZRsrQYygEQBXpLbQCDSAd+tyEuQS6LosNOnL/R3jEr+wzttolwGgU3Ts6C39I4EJRbO3UdbyWcWjz3xips8EBbnuDYDTQpWWrErxjJf1qsSj918xf2mQFQuZ3FqytdMGQGiqoNdL4ay8qqY5qPKZkK7Ra27M8dnWqNhuDvG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejl3Gzs2iD72kUvAdittupk2Pa/bqIz2sxP5a5Sh1tc=;
 b=CvaeHGECbVKjINRSqwirSVEorJGULyNWtSnnt7jMIR5FvgYJc4/X3PMpTSfo0pCK0hXAAo2JOo3G/h98PUqbkHMJEYuCp7/ElKIKxASogd1EJCtf3kWM8ysPIBk727CEbKUHHrbIZBtErXTIzRnz4wSY8Vqw3/jUT4hrXYDiDVvejKgLUtgmtzAL/WdTH4nPiL5SbDYrHJdlI0sPpYllNxbIn2o5vlXf33tsWfOeoCIqKokxD3Ys7v4FFjA5pXslqO/Auarr2BtfqOQ6cUyjdYjAGK41wDygFXgPHS4Q9JuSCCS4p316t7IJylFw+4QMfg/i/Z+CYXIMf+X+3o1R+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejl3Gzs2iD72kUvAdittupk2Pa/bqIz2sxP5a5Sh1tc=;
 b=uniuwHSIaypMOxZKbS36257IJ5qpemrXfbax2oD2XHXjFj9oYz+MAuo5Rxalv7tefTQRaiWHrmfsVh+Bnaa8Cho0/MhuichaO3M5ed82+S4B5r0Tv9MmYeojBGmYYuMcVrqiE/XgA0wjaXMnyMgac1+Zv7quScItvlqn3wv+oik=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 08:25:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 08:25:15 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: fix dump-super metadata_uuid
Date:   Tue, 25 Jul 2023 16:24:12 +0800
Message-Id: <cover.1689841911.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a25f95-a9b5-4999-6ede-08db8ce8ac4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kSi1/aX4p5Npff4zO7ZURJVbA79dvcrncpdKk4UFscq2OjxhcwEeX5EAEs1Oim3pINc3iZ+HF2bKvVgk3Djm73uB5umARjN4vCS08FoHhbpRMuxkPe2GsCaps0SyUHox+CYQayZP3mZGJt363mHimd1czOaXvGzBQYfrVOXQH03zD/+XWKZIjzXRL26SywlDChu7FmBI7smHYwwiLvOxqWH7hDvN3c7Ghh6sqjcbY18/QyxwjVkVxaoP2H1M4OmF5j1oH/4hA9p2vwvHjEQ3Wimc7CcWhvrcSMdPITUu/fYXEoMsYaDbnt6H/kIw33bB66OtA4S02lg/j7lRvGZGKWyzHgpDOgSlWZfxfbtcb8aFpvG+tv92Dzx1hx67dJGMPYdzQ3C3SUGwfCRXWzI9ewsf9a/7AutWnoSMB3t7tBjyZ0HicUdyNh//4tHWG7tt/gH1uLXGxFeZMdsH8D97p8TFsOPEuJnaojGdVvMIeNcxHBhMoJUg1T+mmu3bvNF96IQ8rK2IUpsZRhlZJvXG6+GYkayx/b+H6bpHzdORi6fzrBgPkHfbyv+2TIPDQIO+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199021)(5660300002)(8676002)(44832011)(8936002)(316002)(41300700001)(2906002)(4744005)(478600001)(6512007)(6486002)(6666004)(26005)(6506007)(186003)(2616005)(66556008)(66476007)(66946007)(6916009)(38100700002)(83380400001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZseIHlT2slJ8YY1ayXXVoiJzVB0UZGV2qxdDbql78NgaJ0EwmNJI5R3vMfc?=
 =?us-ascii?Q?k25ctxRzZeCR4slcz58875eBVNl8ddkE0+weij4jKEiv3eGWyXYh+UK9k/Zy?=
 =?us-ascii?Q?wA4Z67U4pb/jhqCk+bnsRr9RTyqUkM3PhoMcdrTLP1q+glX0bK6BNFAuTmg+?=
 =?us-ascii?Q?RHbBN/bcKW3cpOpV3QK6qlbvzWfc2/7umEweUaMVGtLsGU24iNG1p2v5xNmy?=
 =?us-ascii?Q?+Xr+Q4xqZe9ohVWdJRPqd5uCAP60dOB5tiNKItuW5/7SGISa6czlLQC45/+R?=
 =?us-ascii?Q?/HThxd+7iPzearKBBhGDoia3m4UnoUkW09qj4hOgbmhnTxRU/1boyxVIxlQV?=
 =?us-ascii?Q?cNkmmC0fX1wxnumEjJvLmtfT4r1iSlKFcjkrUaoKE1KXmvUt99k7tcp6oy96?=
 =?us-ascii?Q?pENRpphIb3lovMMpnEYjiMYRp1BzENhNuL6NoyIn6RbIrqjN9PflxWpU9Bfl?=
 =?us-ascii?Q?7NSb2F5OyYDCdrOj7dsur75N9dl7xmQCRaE3r1EBXnfdRY6Md1vw/ZkVxEKn?=
 =?us-ascii?Q?LwD+JNU2nk4oxomxd7I6Ocr88elrvyt/OLqc2F51Ch+vVkqz2WQMhD3siFYQ?=
 =?us-ascii?Q?NAdAD36Nia3vUffQmW3RtXz5fMYlbol2Ztl/MB2dMLZf0X8CAMAnLEK/fGrk?=
 =?us-ascii?Q?ZlogrVZKobS1nQgVT7g1PRPK/ZOYDSNIhYoSYH4CroPeQOTAkNGRlrhKs1ZC?=
 =?us-ascii?Q?faiWYM9y/6VdhpWlnk6EkDbhvB0JsVnG1pZJIYM3prI3VA0l+y5DnuEdT+Gl?=
 =?us-ascii?Q?Q9PsKowcVBbhklpx4ZtUXoPKwzCjLFV1N5f0oTpnBGi+hTWDfMxkqZmtIyv4?=
 =?us-ascii?Q?a2YoOG51WBq+QkdWghDfZK7tIY2usaXBS7rAl97Ps6gjYY9r0vy+N31Alljl?=
 =?us-ascii?Q?fmWSqwQT87DHj/RHYMJ4rdDw7nlt6tnGYL7iX3AiZ35v8yeb6xblI4Vt9R9i?=
 =?us-ascii?Q?RQmFi8fulpd5qN/nB27tEvO3Ipf0rCSC7PMDFMQjWyRfdiuxNaN2Gm2kKDly?=
 =?us-ascii?Q?hiawhu7zoRFROyR6KrE8Ty4qlCE9GcwQ8OzqiwUkSPq7fIY75jM5XS+i2KsP?=
 =?us-ascii?Q?HkL6pGgxNlnPBxQZvFJ7m3fx7RyLHCfs6AWJiiV6XRKSwjrKCJpgc64Qesok?=
 =?us-ascii?Q?mRmMcIrdW81yjXddFFaudiHGU1m1maN7er3SsBpwgt8v1iWUH2nhbMOdzwk5?=
 =?us-ascii?Q?z7PUlzty5bSNGL0zdXsii9InF9oEo7tx7MJa3KFz5lYr7RWEMcfV1LGTYY9a?=
 =?us-ascii?Q?0aNQ61Wx/5dxe8zrtYnSkA9L6/M4Vr8FbtSNPi9ZQzWWNjPmIt8EV4dX9OJg?=
 =?us-ascii?Q?fN/lY0E+Z6e9AFenVudinKfZNlwSQrBT7rfgP0Ahy8jUiAQUa2PFfI8YAGmD?=
 =?us-ascii?Q?ua+myRj4qmum5lTNFq6Ufwaig2asfK5ekRg/zPNHaw/Yj8VDKpj2tL3HmHjW?=
 =?us-ascii?Q?Ffh/BPfnR/kGJQKczRASv6qvOMQiBOIEt/jnXnTwqLcf+ljj5ugn4I06PoPI?=
 =?us-ascii?Q?fKO1sUHRz2voLzH+7unRwjFywyKnWu62ZAoijGnK5Sb69B1RIw1JNfPdjW+B?=
 =?us-ascii?Q?0RSijTIV5Z/NYwA2g7X84cNobuVbSW+T5xHpVuNS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yY//ZaYFr/ykmjMYz9aH04xouCujgnWakZVXidsJE31/hhi7W3097w9xBRiiZOCzAWyRvHVFSdr4JfHc3lDb6B711a/7z2QUa80V5myunRhqKogDdtNlhvepMATf9NpQYoAgEsiOFF8D7AIKljW97JIwGVU6DRjW98KqZS0Qtgm6wuP+IlWE8t1kKlFuCb8MLPUNL9mrgI+RR7dW5LRQIVKwDuZORMkHwnVrhN9IBB+heJS4aJiwF8J49CFgAzEex5W3ijkW9pkW8x0Fz4FpUor1DN30HGgp+NsDwR3xKdyJQbqIKSzxCmtP2omA1PP9b3TQzbcHohQraRzVGFKB/5cw+TbGC2uEi0YYVNCvrHMIkTsrDocYnhzYwKbdiu5Csmcr9kSsx8EVu9IfG9oLRPIr/0xWLgUvwlSB0sadwMWcm/EqEpisKC3Yc1E/LOwFG5scUljH9X13Riv9ky86AHwzeDUs9g3B/KRQAEnw2gHYXv5+VIBcd47JSF8zeHsqxbbIuqwfWx8hYmRcq7lUnwysVUCLhZ9eQxAzmqE1vSZZA/XcFOvpL+0PuvyVg0ccuTMWFl2RCKNmvecF/lFvppGKgftpHYs3S3rPZ6WPz0Ev4NKTF/sAHHEa3sXj7nViXhtf2etOA6pDfUwRd5q/G/klgQpfiWoiGgpXGY2hazqs0dUvSZwsUa2pr+OqxQey555Ndt1QzVNELjmt/rGmwctt8zQFtjnkKJrcLxfqzPPFIUaDFCtL+JQpbh6k1CX54TVfYwpyX4Hvf9tHov3ZOg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a25f95-a9b5-4999-6ede-08db8ce8ac4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 08:25:15.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoKPCLmdm3q8pt+R/+WOdGZDwO55Q0XPFRUl2jA8S9DuPMnfsOvYWnAnu2aEtzqxxbt54l+6H6Tx0TR9OPi61A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250073
X-Proofpoint-GUID: hhGTRe5D3XvAXjlqy4hAFm4jQsymCgkm
X-Proofpoint-ORIG-GUID: hhGTRe5D3XvAXjlqy4hAFm4jQsymCgkm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can be integrated independently; so sending it out separately while
I continue to revise the other patches.

This has passed Btrfs-progs tests, and Fstests tests need no fix.

Patch 1 fixes the dump-super output, and patch 2 fixes the test cases
depending on the dump-super output.

Anand Jain (2):
  btrfs-progs: dump-super print actual metadata_uuid value
  btrfs-progs: tests: return metadata_uuid or fsid as per METADATA_UUID
    flag

 kernel-shared/print-tree.c                 |  8 ++------
 tests/misc-tests/034-metadata-uuid/test.sh | 24 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.39.3

