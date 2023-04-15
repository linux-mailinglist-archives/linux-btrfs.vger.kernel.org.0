Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9616E302A
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Apr 2023 11:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjDOJwU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Apr 2023 05:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDOJwS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Apr 2023 05:52:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A0A3A8E
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 02:52:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33F4LKNE027143
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 09:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=J+rqudAYtmPJFPwc0X1eTMdKcAre8NRV8JgMHdY0Apg=;
 b=ouvdKIp9e5I25UO4PYhcTdQNj7VyvRRL9/j6xQExHzNBgDSEvevRg9iFAiZpbqifM50J
 XKH2VRrUZIc2Yqu3YlK4rDaX39NciJa207SXLOSAntY1tO7k8gT0Z9z1cbmzrVLafRlh
 nNAgbL3xBJkraDS2I49V/KhnkUjQSpVphP2+2UEAOQXGyi0kPgGfO84lRu9CFwl4W8MN
 OGYT6XGZgOa6vGkmUeGwjpFsxQFqCcpqZnFKR3k2oj/EisWFJkx1mBED0QOhbamuNawJ
 l+a6qCSzExo0mJeynSF41U/AIZDJYpy2khq3XDFLemhKgknZ1RcKOPE/374IZU3RLIcx lw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pymfu8bpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 09:52:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33F7cFne017449
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 09:52:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc2g5dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Apr 2023 09:52:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpFMBOk2if6F+rpNHR+ffKZ51IBQu+PagvC0ZR5CIOhsgaM293E7ohaOoGYjF/aZdXu8rsgtQkt/HvMyiIGY+iRQh41L9I4bZnRQjfvVwTMGbV+WUe+p+Cu7VrMk1bndIf58IHDInB/tQuOeyhshnkH3dPyzp7t6J7QpAX+boyGMBw1fB/i/6EYQL3rDsrNlcNOGIFEaZJISuAUpII6jF6efrG+cl0E9ua6Vm/qFV3GZdcOIh/1kXyUcIV1Hm6CxbuGCUumfOGeisU+q53/P+gkkl3EIf8XSG4Bl3GjduOKfJsrTbkVwbYtFWWo+dfyL4VRkblnfsRsJ9jXSga6SgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+rqudAYtmPJFPwc0X1eTMdKcAre8NRV8JgMHdY0Apg=;
 b=S0VbL/iqNfiFcpGoP/FxM33v8n5U9dmqpDJyR3fTeat1q4Zgx0htrgM8ECpMDkbGHOSS4TbPFGEMypObVi4P3l7uwTme2+qqBddhU1krr4JWECqs7MwupGdidBzQe0EllMrxspZb9516CKflxFcp5pcuaIpaKgfBQO3hKCbRIJWUan/O2YPqy5DsQ9IPE0LHwZ3sG5ItMyh2CqgljHBykVXrO2Mm92KUJ60do52SdjEqnYrSbdwww3bVU+bIPHMOmf8HCiRQpDNHGWhodRQT/rCTmRU+xNQKAggK3iPoXRRzv/7Cit+A4b+Fx+1EjXLeKttwp4wn/Rktq9ODYfpytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+rqudAYtmPJFPwc0X1eTMdKcAre8NRV8JgMHdY0Apg=;
 b=FvisA0WO79Pmdv7UgrjeDJ8Vwvu6RZ58QxYTRZxP3cpdljjX7AmR1Cb2jkJryQlkmrxkNxMlNq97zjXPRsG1hO06arDEI9NBEOFS1rwha7NcIefztKfkPDpgMS5t23A0UGJ6ZdLDis467uORSmhembfLniSYDBZeiI4w8mO0Ksw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB7372.namprd10.prod.outlook.com (2603:10b6:208:40f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sat, 15 Apr
 2023 09:52:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6277.038; Sat, 15 Apr 2023
 09:52:02 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: use SECTOR_SHIFT to convert phy to lba
Date:   Sat, 15 Apr 2023 17:51:23 +0800
Message-Id: <703d830a41f97b60e2cd2c59e3b15432a01220fa.1681551217.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <bf0d31958fd2b40483146e2a8ec483c1f54796d6.1681544908.git.anand.jain@oracle.com>
References: <bf0d31958fd2b40483146e2a8ec483c1f54796d6.1681544908.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0011.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: dbddfd01-601e-4cab-eb43-08db3d971027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ol5tXsISTnjqeS4KDE5LxYHiwy/wllPdKh3BqCPQkRrh1TGP6csU5YKcyj9U3CHJfbrsYh2RoddskXIP//KEd4iQanAAlgO9snO3+/MwBb6+Wepse2yHU20xmV4BPlcNUQgnNQ320PlEvLCoGB5pAhPKs3jfxsWWh+tALRLsylKm5U43P2qcu+GIX2IHXG3trmyLeeMTvJS4yeZV/L1IkzFJPdG7B+C1QBvVHxb0swl71vBHVMPd0/u+Eb5xyxRm54fi1gCAUQkqWBVEdxEewKKEB0L5FwsFEeOXM2t82CQhETPe67D5AS4K8xmV2KEYSr2lPvkKgNYyQwqBcG72a/LmBc/iEMzIJW5KZ4Kx/+s18+xC/va/zxf0Q3R9aAQV97x/Xsguk9kzdL5en8GHeT8xvPHL8ilBDlnwLmdy7WAUTGQA8u8qKS7TUML+kQCK0WaPBC81fZ0COmXyl5hDbkQSpV5KtRvQiWYP05mKd3zw7FWE+zzxpHN2w3lNHkIULqYhKVv7Q8zdU16aP/ykdmi4b5a6wTBcg54cL43d/dlUS5SaZxSTUl2MCuMTRDMs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(83380400001)(107886003)(2616005)(6486002)(6666004)(316002)(478600001)(6506007)(6512007)(186003)(5660300002)(38100700002)(41300700001)(36756003)(44832011)(4326008)(6916009)(8936002)(66556008)(66476007)(66946007)(2906002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pnCRWs1RedaiXtVN5q7qxcBMZiCEkxceVKlogPyuBoLvlKXIZXf7bVPdOV02?=
 =?us-ascii?Q?sImp5vhokdCU0uS8URVB3P2knZoZgb5//rZB1+Wj4nNWMiYCHoZNjQum62T4?=
 =?us-ascii?Q?sOPsFGFTOmwWdt83QzCG6HMockFLgzhV/WfeNejHtkU4R6qCWT1n95+UfIhZ?=
 =?us-ascii?Q?fj1xGoas3FBDTaU9sgZZ8WKPPOcSr4BgQDZrlO5Ar6CbSlfRbGeNN80B725S?=
 =?us-ascii?Q?QC2iILjyTHEjKhJF29DHPj75fXMlCokAwjQVgVV96dBysOjOtbvi6rfLlfd8?=
 =?us-ascii?Q?EfNvuokZMirsqY0sh6GYqPgO1I3BFsL+thGxoy44t1m2TA8CpXdpIcO3a8jD?=
 =?us-ascii?Q?wdGDnc2EXvpG3O8f1s/DQd9avFQQvycULdliOLSAMouVks97aHOcwW++HHSe?=
 =?us-ascii?Q?NXXeDylCXQH0Bi0x1kdRWCAcjOy9KCAhCfG6U3babJWM3a/i3o1LA3wZWn6N?=
 =?us-ascii?Q?zDSI3EOIMZOc7a4j2UGjsvYn8Y47oIz4J4VlSp3w4YGF3a2t38j5MrFSBs8G?=
 =?us-ascii?Q?uHhh5oZUQWehUnAYolHbjs+ETeV+Ci8chmJBKTRYNkjxXBjCGr3Jlpe2Lcqu?=
 =?us-ascii?Q?c0C7S+t4Dm5fE8tkDy2IeVYshWNQcVMv38fQPRfQBTlQ4R4yOwm3/vl4vgt+?=
 =?us-ascii?Q?OW/QmpC2eap+xHLeB7XK6y0oQ4WF1GRMLB0xXyPAxo4dxLG661F7cvnATOEo?=
 =?us-ascii?Q?80kGSbUJnWF4L5672z8PkmUBqQ+acQx0THy8L7JsInJT4qXSbnFmGMR5qIH3?=
 =?us-ascii?Q?jk+fwpEn2NUzs6Fgkrj5UMXK2a/YNubTlycZrL/Bwme3X+qD1y+4PQvuXLFp?=
 =?us-ascii?Q?S5DS43t1DHz+wms8IrLryA5omKQ53jVFCdtHdZn4fimdukkoGa43tycqT+sc?=
 =?us-ascii?Q?e1TKSJLi+/jEBDG/CCI02+NL5/AIU6K4tc6SEpSc7wORyFp9LRsq2Rio+hec?=
 =?us-ascii?Q?7CYP0wu4WXEK1cKw1ZP2hAT9whb9WeNTZlE3qYLa7yUH+KkLHNm77yrG/qNl?=
 =?us-ascii?Q?j8tZKdyvJAx+w95pMabMm/IAFzDqRDdBe5Cq6CpnfzLEDET3tVraz3BLYq9x?=
 =?us-ascii?Q?XlxwpTymlAsHBoSzwibrAzdJyeJSCHztFyM4GFGul6gUIREdQP8mFSJmZSFP?=
 =?us-ascii?Q?hWJbo5ir1N2aRSVj0lcWCk3MU/AQXkRMLrGlnCIx4LP3zLCKYiOp2hAIo+eq?=
 =?us-ascii?Q?ky4JAXH9elkqjdhQja22cYIzpRB3OX0FmuCHzzTPsUj1Kyfe1xUsiPrU6TvA?=
 =?us-ascii?Q?wmwtrg0sDfcREKPpiusBHRnwOflRkeZj5cBQoGgrQ3z/HXj98hyCt5qNJP4n?=
 =?us-ascii?Q?Tz4rh1aQqqE84Y5qT+DlYaxzwxrgMZGOzQkHyt1oCMb0mQzsAMJ5AJXenBcJ?=
 =?us-ascii?Q?ahuVqT66f03d9/rRYeyrWG1UMNhK1DutG/FnWVD+OJSpoC6Z6u65dJOWU55d?=
 =?us-ascii?Q?f5AhbhNRk6TdAeaaHVw3d3HfdxAMacBAntms+Sqkc6+UaYeFfKY2WC6/4Ghz?=
 =?us-ascii?Q?8fUWWvHBI9p31741xj8NtVhdpqZytlbhWpch+wweEg1uPhS1KPeaUesZ9uR+?=
 =?us-ascii?Q?Dwl1JdLJKYFXNS6JtKtxvDPLqObFMXiTPk+0YvKwKOs7oV0/Hms5enHFtsWE?=
 =?us-ascii?Q?u0C/Z3ijZKy0eIfj5ZlUAAe6106KLYIz/waqilzex70xDQId8x0OlNSyoguv?=
 =?us-ascii?Q?rZiTXw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zjujHdMIgKoDSxGrv9yx8sD2YhvZrEZ6opzbAWDuJXPMTVjj0pOxhs7dpP1QcF65+F+dBDYZdNTxQLmpI6bpOVbxFrcz1856TQKKZih5baQOk2DLes5WKYLoe1B0LreU+2/uMrjhnZ9Pq28QiKYXEeF75w+U7ayo6NMG4SblzeyKUf2Kvtul7Q7GPhQhsbWdxiBuSr7ZqbRUgCNQFgP4mUMWzl4ZR4r2VA6zqEb9TUPoGNxV5lEITxx1YFGQNQzi89gcj6RKCyiWLYmHYXRYKVkdNKeJICCI6wnSYb5AC6b8xHtov75BxqBX7HihnUJbzJQoUfuIFQ5EzM8HpmOecowr+/OAdJFH1IdgvR0WeLrqkgAzDrbZgmUr1ZAW8JMAIN8vnJtoEUaaKOy6m69YVwxo/o/we8uRb46TVqQPKSMNuxb/uVHZ32reSZ9bxe409zWLEf78F/1OsIfHFxFdxtxlJK/nXe7OuUknIIOqGRbn+hd1C5o2TuhrS77YHtLiJOolmew9x1Mw9dlby2betYPDmwXDGPisNu6hrTPwcSbk9KQ6+y/2SvQhNo0dSfmAMAY5fFnVRaJo3inFzTe9ItK0swt5Oy4umZNB2AJX10p9f1BnbB7cXuDWDYscVYvtFgX/rkDeDee/rCRx6p2TVhgHUvxfeBOpvaS6kycqvvwjg5JWrBQ3xAVZ6aMVnCUOoVzSkh8uFkfqdD0hA1JojYF9sk8ycXlec5dU18QB5relkEpzaExV+f7QAI/lM12x36iJkbaqQhGWro4zX0v+sQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbddfd01-601e-4cab-eb43-08db3d971027
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2023 09:52:02.4831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnsV2XkqHiRSxdMrZzonmvNTA9ubNkrDeVxdx7CLl/6lj3LLHPiTgGKdKWNKrYDcDQXnVseu8HjBY5DA+Ty5hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7372
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-15_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304150087
X-Proofpoint-GUID: UFjhDO1Chn3VXs96mxOKZsM9Q31hn2PD
X-Proofpoint-ORIG-GUID: UFjhDO1Chn3VXs96mxOKZsM9Q31hn2PD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use SECTOR_SHIFT while converting a physical address to an LBA, makes
it more readable.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
Dave,
 I found some more places where we can use SECTOR_SHIFT.
 Can you please fold this into the patch sent earlier? Thanks.

 fs/btrfs/check-integrity.c | 2 +-
 fs/btrfs/compression.c     | 3 ++-
 fs/btrfs/inode.c           | 2 +-
 fs/btrfs/raid56.c          | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 82e49d985019..b4408037b823 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1565,7 +1565,7 @@ static int btrfsic_read_block(struct btrfsic_state *state,
 
 		bio = bio_alloc(block_ctx->dev->bdev, num_pages - i,
 				REQ_OP_READ, GFP_NOFS);
-		bio->bi_iter.bi_sector = dev_bytenr >> 9;
+		bio->bi_iter.bi_sector = dev_bytenr >> SECTOR_SHIFT;
 
 		for (j = i; j < num_pages; j++) {
 			ret = bio_add_page(bio, block_ctx->pagev[j],
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 2d0493f0a184..1a982dac9f81 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -421,7 +421,8 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 */
 		if (!em || cur < em->start ||
 		    (cur + fs_info->sectorsize > extent_map_end(em)) ||
-		    (em->block_start >> 9) != orig_bio->bi_iter.bi_sector) {
+		    (em->block_start >> SECTOR_SHIFT) !=
+		     orig_bio->bi_iter.bi_sector) {
 			free_extent_map(em);
 			unlock_extent(tree, cur, page_end, NULL);
 			unlock_page(page);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 57d070025c7a..b9f88309bd4c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8630,7 +8630,7 @@ static int btrfs_getattr(struct mnt_idmap *idmap,
 	inode_bytes = inode_get_bytes(inode);
 	spin_unlock(&BTRFS_I(inode)->lock);
 	stat->blocks = (ALIGN(inode_bytes, blocksize) +
-			ALIGN(delalloc_bytes, blocksize)) >> 9;
+			ALIGN(delalloc_bytes, blocksize)) >> SECTOR_SHIFT;
 	return 0;
 }
 
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index ed6343f566d4..734c65ad281e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1099,7 +1099,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	bio = bio_alloc(stripe->dev->bdev,
 			max(BTRFS_STRIPE_LEN >> PAGE_SHIFT, 1),
 			op, GFP_NOFS);
-	bio->bi_iter.bi_sector = disk_start >> 9;
+	bio->bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
 	bio->bi_private = rbio;
 
 	__bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
-- 
2.31.1

