Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FF57366B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjFTIvJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFTIvH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:51:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFBCC2
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:51:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JNLYVk006337
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=r52WghAP33/HLdHhglwLRdRrpluWiI1k2w14/fAXaXY=;
 b=zBJV0wX/Jzq/G/X60iKneKw+I5nfcBkutNbN0eMKMHS13Jd2IFN2qifXZpTC5Ck98qVC
 mp+Wf3G6m7NprMb9KR5lC5fRXhlgX1hqXs8XKGdvLEoc87il4+HWYL87kd6YYzJlPPFv
 zDWjA9tqhHRUnigR+vy0SnewfP9S/89n91N/5d/nb/p8OvOQkowy1daaKtuOCMwBhKtS
 CA28pZMS/Dw+Lf0nGPnUo6+HyFQ2S93ATOkgVRyvB644STv0GXfD+X3W16gkvTwuEUvD
 v0zcdJX3LdKIc/LX2xqNYO2pC8AtvrS6kUChzqnD7o/uJN/IdEZHYoa+fB9fLcgAQm8L FA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3m7e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:51:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8aPoo008308
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:51:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394jtx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:51:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fc4PvDKz4PmKwR469a4NZmrdg6nvR1oVI2SwUa0MHdgL7zxJgsbzv2SQrZROgx1Tt9I9w/VHT6L1tQwLueSqVocTsu29dXtGTshk7r07QHPC781ZdKui9nOibgXkhIYW8DnP6JeViaOXLc2vjhpL1ZJ6/limMOcasJAzbPq9KK9qFV80oNOIueDLSsE0hY8u8l3Ue+8JXYtuYMm+r+u4rTjfq6gCkYZzJU4pf9KjszPwFVbPUnXUBTSB59SXi8cf2pY2pevZ/R4utW2bXme5bE3hyLeop3EgQ/+SbhjI+5aeFeEusSQAKy9EHs8/94g4urDgeqQ7Jdg/Qt4i8bedkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r52WghAP33/HLdHhglwLRdRrpluWiI1k2w14/fAXaXY=;
 b=Ozh6+lAeI0+JbInW2Sq+Tdr0qSbmdMSWHtW1jMhM5jYT5deiurAXuX/0f6tfAEtr8dWt/Z4rqq7NSzb76+/0jSRo9V7yvO2VHiNbv40lq0W8rLiKqUz8PL6ZqCMaRccxDaR2tTAcPcKtGWLpQQ8huUq7z6FKCQa/2VR2MXWAWur/yufzE77riRy/w59TXSukNukJEJRjhNW6YJqrWhrP1yxJCmxN8nII52SJuVd1rfZ9e/N5crnu3Fuj97dpLc8JORQBrvKQAiayeng/1DFw9fe2p7u9RkHcGMZp9VWHioP5jipbBKXL0gkgQJxihan7u5Gx6P+tY+jNok99y7ISMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r52WghAP33/HLdHhglwLRdRrpluWiI1k2w14/fAXaXY=;
 b=LSSe2SE2vGkOpZHL0iscZkBJO39aT1rJsWMbmokgu0SfagEXXhDVPo/BbgUVQe3KOZlIUFmQ7htiW1MuAbCZHXdlfNmx+5Yla4RxhAl/aTklXtZrgLchept3kcucoje+KO9RezinBLzrm1RZ/MdTgtH+EWXD7rFmySN7vZ9ep/I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 08:50:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:50:58 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 6/6] btrfs-progs: tests: convert/006-large-hole-extent check for btrfs acl support
Date:   Tue, 20 Jun 2023 16:50:02 +0800
Message-Id: <d63a63b7a5c667932eb38135eb0d21f6decdcca4.1687242517.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687242517.git.anand.jain@oracle.com>
References: <cover.1687242517.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9f0e9c-75ea-45c2-542b-08db716b77b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: thBuDbjaUbz1IjCIQA9lyJDNC/n3FC19U7jYR42+xWreZj+wWjhGVN7MTq3G2vvwiUniNQIg5Xq2F9Q7ZP6zRlGx4hp1D+HL1otQ8FReEsjVUx4SvFNCxKzkHBiKvgTl8O8rE20z72XumBXVZxGxenQ6rsOz8fwiaEWS0wMMpq8DPVD9TDbyoWNUXa0SmQqR14hBfycs5wG2b+NwLgJ/6FVcfRBXcMj8g6zwZXW/4H70z/pPiMoIrJARlCZWHRTYJTsikieO/n22JEb3KETm9BFVsRn8XjIp3nEjRLMrXrooGZqzadDTh0Uw4t8gtbmVwLJG1H3Lor9N764xXmg1thnFmqbnAqf3n/B79+jBUma5/0yzY3xJks1HDNduJhvXZ6U2rf0PZS+GjXdLE+eApNdzv+o9YZVDuBr6gpXflO7bZObIZplTQm9qqgQWdXYwBHAPrNEGzApmqsuS3BptxZqpX0U9zhmlqF+qjfrO4ytD8MWZmODqOCah9XIz980OyUj8q3Q5F77/v5XhuYjDTY6cC83mkZVImtf1bgpzYobVZ0JUTn5bjAbjd2Jk39J0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(6666004)(6486002)(478600001)(186003)(6512007)(6506007)(26005)(83380400001)(36756003)(2616005)(86362001)(38100700002)(107886003)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AeQhTEUqakyJ73E8UfjB60JbM2+DgGFDjuEPx9dwPjf+tpLlQ6nj4kGoeozz?=
 =?us-ascii?Q?znUPXNBnbnxKDxPwbt37Ul3fiQU62a19P5aMgfK0MMxYkUXPB4Pau7szKryR?=
 =?us-ascii?Q?8V6jRM7PCvxbPhsVASGVLWuPBH1z/Hfx5Tebgr8+xo2WulcqQWP/YY2lm5iA?=
 =?us-ascii?Q?9P5kPvFp+8cFj2Ea+I23S1wZBVWorYTQEHU3xW5NWhLbc5s172zNXsotfAN9?=
 =?us-ascii?Q?52rknC/fGyzxjAlNrfPuxez9qHHIzPbcFFSnZuUF/lWW0yeXwtXum59CEM6E?=
 =?us-ascii?Q?sHZqEomHpJLrG5uyR+VRdTsi1O9QW2U9+dNa6kiLM+IFje74hqAmD9oTrMB0?=
 =?us-ascii?Q?bil5sIBUZk15Uq6/4zt3TES61ckKS5sihLEifLPW+JCCHV9tIjWDYKZMwWR9?=
 =?us-ascii?Q?4LQ7j/7LG/2TPKZMnvWUl8XMSYoLNHheuZMR037AF82EnETP0z6k57mnWjLg?=
 =?us-ascii?Q?4S4gUab+3KRfG/S16hHw19xSNyTN59mD4GRDpqwbRgcXNSuIu0+M6g7YYUdh?=
 =?us-ascii?Q?OAXuiKUaU6hk6SGrkIT19/WVwaelTXi0WEuae/Bfm61BXjGKp3KgdQmcempR?=
 =?us-ascii?Q?Y3y/iYXkBI9JECw1jKFKzUcJ3tRDCNVg9VWMB6/7MWb59EWPEPigp7ZDKK2L?=
 =?us-ascii?Q?7HZ+jDGO1QxGCxPbT19c8oKSAvD+W+sAZGuhguvCGLgX1rTqoRm4eEWPj83O?=
 =?us-ascii?Q?+Mw0iJp49x1WjXE3WDNQudP389Jm3wzIPqDq8PQOuCbMYudZPufnwemPEt92?=
 =?us-ascii?Q?K22q0WNgMsRyO9dHLx1OPv/TDXvPc1kbQObiwf+xxBNTB/M61Rum59e2LZki?=
 =?us-ascii?Q?BbtwotpnogKr2msRCnmelEYGF/Onw/q5WqpAv7qD3Uj+KhuVGVveAEE72xys?=
 =?us-ascii?Q?5eXrGOJP0+OAnLmfYkhg8fJP9pIfsMzYVhirB/m0fK5GMLoX5rMLTmZeuhjr?=
 =?us-ascii?Q?nHdz8iOf3km3/sbPjLsufSq7dcU0yCX28/7UKF6W1sy06fx4SfJPAn3FJfu/?=
 =?us-ascii?Q?uzlIdk9yjdijwGbhCH5VxDnvV4+dwLQpjXcQq6hbGQ3AQbPIkhtR1nl3Pqe4?=
 =?us-ascii?Q?U2SU/tr89GkNwcDs6XjhiZKloY4IpgRDFDjR5lCnrPNie6X6wa0GZwnhc7K5?=
 =?us-ascii?Q?LNvvkhAMmYEIiR44hrTdWMAOidh4qfsw6dLBZpftBMraPoW8p4+vYclrz+Aq?=
 =?us-ascii?Q?fJGcB+HrCt3ZFYvTslwUcHu5125Drr1FuYcTtozEPijiSODyhSrSenwdmWkU?=
 =?us-ascii?Q?SE/hbpsUq3NN48YdsbmPOhuudH0FkXiJ7FH+z+iJrxx0jFwvEGU8ZJUGXHWk?=
 =?us-ascii?Q?XoIJA25+pBRurkE7uD6qLp/URYXyZRiOS/atM+dUIYaqbb+bDv4ttlr+2qg/?=
 =?us-ascii?Q?ppLvxl6Gr6qIa+mab+7OnYo/dINVXwDd6Pbxk1aB1uglG0IAxQ2ssJizXsNh?=
 =?us-ascii?Q?eqJuB3LjMm86TDbzB+cRTfhancrqXvxv4+532oU5JaJkufYLtc1Xm0m88NuF?=
 =?us-ascii?Q?EvmyzWys96+NnG0CDqdHvk/or684DQDXjZBsR7QzY+YEZ02dvTrH2TuEoUKE?=
 =?us-ascii?Q?mnGTNwa+TZdalvIikzlJPZCe3RQYJ6TgMvgism5A?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xTmM+3b5z1G+SHm9G7kR+3VPDufSlkbHIxGhKGwmVG6PGyLjMstw3b69vRu720Qp3Sl5HeMoSAKxccbjuBLfTi2GwVvHhdCabv04uAOAbYf2s1AdgDD0Yga3RW5HIDsvlMAe7VVOLSzzLBHUij7Lv9wlMacltXexBwIoJN7+FJS57GhgANs4njiyE9s6jYXUiQ2H8qtnFR8W3iOQzEtLGg1O8II09R45q3AId4re8pNkeXCrgTWYylwbYUc6SIfVyLqtshucxLDjqlXzCdvTyQ3mviZmL+CZjLZ238Gry8kDunf7rxkiApzRhT2MDW9ish3lrv+GJr6kUpxSw8Y0o0a8VbNLb2ZDcG948gHL7uNPmqofsZFQvGXeCIk3fCaK0Pk242/u7woAQ8SV+MUOH2Mom6SCwxUjLQ4mi86XOG7wgdOF0kp9bxfSUhc9x4+gvoqVb+0Y3nAdFhgQx3fkOl0MArxvYkcpE0ukLE8E5cOvZDLn81W3zGZASwu4L33TNSeTiqgiQ924TUSubNA1cFzWxbFX467iJLiOoVtOo3UPitm9HtIqHt+UHJXGL0Io2uIFWrkbGdmyD38FE52cRxSANUjeKUKI/4pBQ9Skuyt6sMqLohr/daFTRrfx8dPZqSsaDOoYMrv6exKk2nI660oSGUJyyb2/drqX3hLVqR0TAOCSAxZG0bRzOOQ6RoH+1j7i3vIfGn75cak9CZ7eaPibklfl397/N/wCotSfJDsPKQ9oZOq6TkbbBSOptzt/bBEAnpD5TJ2KtrDM2ww/jw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9f0e9c-75ea-45c2-542b-08db716b77b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:50:58.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNa5KbVi3XhD27mHNhqEtup3VQNRT+Fh/hZT7aKIRT831+4+P92fvQlmrO9ZiWnH8LVrx+lGPNVxGgzNuVi/wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200078
X-Proofpoint-GUID: QZKvC3fQvSYmrY14FO8_df0xzaU0i_XP
X-Proofpoint-ORIG-GUID: QZKvC3fQvSYmrY14FO8_df0xzaU0i_XP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix failure due to no acl support in btrfs.

  $ make test
    [TEST/conv]   006-large-hole-extent
    [TEST/conv]     large hole extent test, btrfs defaults
    failed: /Volumes/ws/btrfs-progs/btrfs inspect-internal dump-super -Ffa /Volumes/ws/btrfs-progs/tests/test.img
    test failed for case 006-large-hole-extent
    make: *** [Makefile:477: test-convert] Error 1

Instead, use check_prereq_btrfsacl() to call _not_run().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/convert-tests/006-large-hole-extent/test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/convert-tests/006-large-hole-extent/test.sh b/tests/convert-tests/006-large-hole-extent/test.sh
index 872b4a6f6175..d7007b705862 100755
--- a/tests/convert-tests/006-large-hole-extent/test.sh
+++ b/tests/convert-tests/006-large-hole-extent/test.sh
@@ -13,6 +13,7 @@ check_global_prereq mke2fs
 
 setup_root_helper
 prepare_test_dev
+check_prereq_btrfsacl
 
 default_mke2fs="mke2fs -t ext4 -b 4096"
 convert_test_preamble '' 'large hole extent test' 16k "$default_mke2fs"
-- 
2.31.1

