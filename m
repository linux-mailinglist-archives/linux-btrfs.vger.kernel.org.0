Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEE86FDF6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 16:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbjEJOB0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 10:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbjEJOBY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 10:01:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE40138
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 07:01:23 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34ADxY0g014343
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 14:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=FDJLsGsyiqQO9qdPHRgFoj034IiXc6FqfdtpcKXn9RQ=;
 b=W4d2BT7KQUmhu5J4qzOlZDz84hJxDJxcpuGJppBR1RfaDgPoXjCQs2lJg/lhHnofHiRM
 hvJwb3IErxNkzHAww6GuH6PxP0D3itFZht1XVsS1lCLUyOchGeI31kBT7yLZiexoj5XC
 073WG1+mpZRBvYET3AAgOPMsscLkK0EmmhtFXVs0ye1kpao9J8En3ebbBerQWFQvgCTV
 HJZ/BcXevMTfb7I2rQ+7GaCG5R+bDe1X1g8KDbuo+9EB7UVGjqV/JNckOp0wNAJVkG0Q
 Ui/qGH5AM11s58zApjSh0Cn0BwT7B9TdaKRMWmFYAI1Qykmg17AzTuTYY655eQ0qusGq xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77dcpkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 14:01:21 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ADtckK001975
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 14:01:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pjmgg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 10 May 2023 14:01:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGacWNCAazhhLW5aOrkGYUcDJ/PYHtNxdsLw/WRRs9eHSk964UMzouDv0Rpq4DzLjWk3UJV0SYMuPIWz+oWumslpTjxPr9p9lXqTeUd+HhzCXio/f9DYUH5dv4LusQAFlmBLZvMvbG+KzXQCO0J+GBRZuAJyeJDGTj/95hz6fR3m0wcugf5/pKrGfgtCzTENKU1MiTZCeW4a72YiGv/CEaxBfkT9QFGJOCAkEkGFOsYtxJIgmnywob2yLzTIeBXjAfbfbe3O048RHj1RZm4/jtOsCaB0AIObMG9SW1a7U9Tp897vg7SKhq6UmJDUqXh2hSr9F/AHZ4LYbf6qyIHyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDJLsGsyiqQO9qdPHRgFoj034IiXc6FqfdtpcKXn9RQ=;
 b=eN+pFRyuMJLz3HtDDIuWFE79ck2OPui0oSTsMiN8nTo0PRTsr92ZFHL6T3S3a/4WuV/+L0Rx5AajgdbyetrGXnxXRga1xpM/aEW8x4DcZg+gzHOno82aUU1uTmPlp0Dj2p8ieW8BDQpcBKkmxhT7vOGTlUNsdcwDKaFeZj6HT1gskp4QR3XH7DPgOHPGEUe5sjZWEI1BS9jrKkkFTMpDByO+qUx5vb1PcMYKQMBHY78iNb1hPRGmhq95Bw2p6ppkVQahNuJIO0UB6TuTwa2atM4Kz0Vv0NwyVErBXzNoYSRHshLrlVPPUcw2YVHR199TV1z7wCinBAtZG5iTI78L8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDJLsGsyiqQO9qdPHRgFoj034IiXc6FqfdtpcKXn9RQ=;
 b=NfC8T/nwmE59AhYRCwomt+YHDgNmGaDeg1OeY+uCncy7x5kDbomAl7qclEL4LrbtcMRmBwd7iWBwmSss/JMkxCgreA7skX1xT0SrYRjmJHpmmQGqRzR/wZuY1CrBWQy2KBzIjQWn2ZV7wz0twLJykdFg8T5f4dQCQizCCX43YxA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ1PR10MB5908.namprd10.prod.outlook.com (2603:10b6:a03:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 14:01:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 14:01:17 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: fix warning no previous prototype
Date:   Wed, 10 May 2023 22:01:10 +0800
Message-Id: <2505bcd57b2138163bd7540e3534edd403554751.1683724114.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ1PR10MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f31dbe8-8e94-46ee-f3e3-08db515f0645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/QMGu3/FH9aclyaCGr7LcL8c9HA5IhGrrbWPIyJP0RxSOJCVWr1HE6SBtgpJAhsPBpo/arm1YDgxBzYzwYCnGBBIBnO7NVYLwkLHppgSV+IfLG7Q6j+Fsf04l+yXXDFDWrQ2EzVKGU14iQhANp5WCYOVvh2Lc4erKi5WILsrCjIJ6Z2dkT3cPlMC8YjfvBkwQ4M5P3xN1VlCe8pYEIsMkLaKTjXSih2kkVjVmoamGVK12p0fl8xgt84vv0ug2nlxu5qBtbYmP/ZukqR3UQ7uCd7qxiTsAn1AQ/sZd0BG4oBlAw1UYXS3ctmorzbL8l+p1nVZ2IUxASGxPRHv1JviC8xFlglMrVndc59xJzPXps/hLkwYWFLanhbbb+oPQq0R7Og1tta98O1ECoYwNG2hnV0nJfCme1PVN35ZIbQEFRVsRnAKvjsZxtmKA3GBnNohKUxAmvkyPnyF7t9UdV8qOkoPWPHpZlx99RkP2ryuKrqI1XU9JuMUWQQdIgWNcq7up16x4ENu1xucBbIpt0dr5Stel5S2oDF6uRRum+yUPKEE0+pyLqHwcYiXjdd6ktI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(66946007)(478600001)(6916009)(6666004)(6486002)(66556008)(66476007)(316002)(86362001)(36756003)(6512007)(6506007)(83380400001)(26005)(2616005)(8936002)(41300700001)(5660300002)(2906002)(8676002)(44832011)(186003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVB6cVNaS2haRDZtT3NrR0NYeTVWZ2pIejhMWkFHQ2txaUpCL0s4RW1mRjlY?=
 =?utf-8?B?b1ZpNmU1anoreS9yUXg2S0JOWVk0cURJYllIeGd5N0MxVklhMGN1Y0tVc3h0?=
 =?utf-8?B?OTk5dm9hMlRFSmIraktTVktaS242YXR3OGd2UlY4cG9HdUpRUHN3YmU5VlBo?=
 =?utf-8?B?QnAzSzFFcTZ1UXljTjJCYWRKZTJmR3ZISkIxL0xuOHZSZkpiRjZqWlZqanJT?=
 =?utf-8?B?Rnk0akRMdC9kam5MZG1kNjJHb3ZrdVpWRDE5eC85YmVjYWNobkpWQUVwYkxZ?=
 =?utf-8?B?dnd6eDN3WURhSys4Tkt3TVBYK1dlTTQvQ3VQRGFraEJ4QmdUa0hnR3hPcGV2?=
 =?utf-8?B?WFdVc0JyVFFSY0hRam5uUUtNR1dHZFN1dHZ0NlF0cmZrTnJZalZLNDU4NEdL?=
 =?utf-8?B?enI5Y01Xek4wQ0dmTktSeUw0WFYyRWx1Nk5FSC9CYnVGd2RRQ1UrY1FsSG1m?=
 =?utf-8?B?V1pGVFoyRWtUQlF6bjBHVGJaajB0S29iTytzK0hqbWtqd0xzZEc2M09IUW40?=
 =?utf-8?B?dHEzb3N0b3RUd1Yvem5MWEJuUmlLRGF1Q28rNkR4OG9jdHVuY3JIL3NwRjZY?=
 =?utf-8?B?emNWNkk1MnhRMWlYNVpDYmc0Sjk0eHBUN1lnMThpNklCMVh0YXEyYXVYdjRo?=
 =?utf-8?B?QWg2STFyMUw2Qm9DTjhGdGg3cUlDMEVQM21XYVhwaEtVTUFHYmRldVhkVExZ?=
 =?utf-8?B?dFVsWFNGa2pSUVc5cXRTNEtYVnkramNWbU5kQUpFY2N6UFdWcjBXME13bFR6?=
 =?utf-8?B?T0xGNUpGK3hWazFZdm1iVXRPQ3RsY3NLdW4rQ0pzclpJRGVscTdVY2RjVHZE?=
 =?utf-8?B?QzNnUy9GNEJvRisvTXE2dkFGTG95dmtLbTJPWkVwZGtCL2ZzTEc1WllEUGJP?=
 =?utf-8?B?b082MjNFeW5RaW1sWkx4N2pCMEpsSi9nQ1hJa3NwdmcwMmtCbEZieHA4Mm9q?=
 =?utf-8?B?TjFwc2huQWY0MTJXU3ZKOWFqNWpWWUFQV3R0Yi9UcWRkekxQcjVDWmNYTHc2?=
 =?utf-8?B?K2poLzRiU1d5aVZaYVdsOFJNemxtZUc5OThVVEFQamNsN0hlRjFHY3A4QW0v?=
 =?utf-8?B?NWdRdEt6ZHFOYklqVGZLYy9sd3UzRDZmWWtZNzJ5K0JDL24ydy9rbU5BSjFh?=
 =?utf-8?B?M3JOam1uandhS1VWWk54cytNNUxyZEcvTUx2TWR6RzdMYzRwbmt6VTQ1NUMz?=
 =?utf-8?B?cXlPN0tqNHYxdmoySXA0MzdaTEQ4VVdoODJMYmIrRG5jb1FVQ29SMUJ4M2to?=
 =?utf-8?B?Tm96QTl5akpqT2ZRM1U0Tm1MTTNtQUg1dGNLSCthREdpajNXaTJsOHpYRGRZ?=
 =?utf-8?B?S0U4cnhGZkJPY3FzQVEwK2ZCdWZUa3dxblJTLzNZWnkzWk1GTVltRG1HalI0?=
 =?utf-8?B?eFNkeUVEWFZodnYzN2lCM0RnZGY5aDVjaEFZWnExRkVjd3RZUkMya2FCUVM1?=
 =?utf-8?B?R1VrYUlOVnN2aDFoamFSTXZVVUdFOXdiVWdvWjkrSTBDUjBNKzM5bkhNSWd3?=
 =?utf-8?B?YUFhV2R1UkZUQWx5L05qN3doSHJpNElZckx1SytNWFlNanlIWEpzRHl4ZjUr?=
 =?utf-8?B?ZWthWGpoSXlpdHVaV1NJUUJNeld4dUxOWi9PS2pIOGpkVzNBdE0rWTF3c3ZW?=
 =?utf-8?B?bkxtQ0x2NCt5eVpHRm1YT0FNakNHdjNyYnRycnJqNnY0M1VMZVFjc1dWcXFX?=
 =?utf-8?B?blIyOXdGMzdzK3dBRDZ0OEt4Tjh3eGV6QUtxdDBCbFdsMmYyT3ZGbUI4SStG?=
 =?utf-8?B?NlNuNGlCdmlCRHB1aUNoaTFJOEdVeDVaK0t1SGlSeW9rblNGWGhpTDRYQlMy?=
 =?utf-8?B?bkhIWkdDQ3FRY253aGU1aFFIT2VoTHlqeDE0bXpMR3B1ZVpXWFprMWZJaHhG?=
 =?utf-8?B?OEErcE5Yc0UweVQwZW1tRUw0WGtJN1FXVTRPaHBkQTBxTXVrempkL0xkWG1k?=
 =?utf-8?B?T0tmMUttK2pOa004YXY2RC9ocVVOZUVTZEI4UG5GaTY5c0luYm9xbEhIRkxJ?=
 =?utf-8?B?Q1pFcnI5N0ZSOGFiRkxDNzlITW5tYTN6WVJGYkpGM0RvLzc4ZVJDc0Q3UDMv?=
 =?utf-8?B?Yk04Mk1ueWp5OWtKMU9uUVhFZzEzeER3MERsTW55dytlOU1yWmQyUmpzWHlS?=
 =?utf-8?Q?IutWsaKFBTC1wn8jwt731N5Hn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q1xMGMh3ys4MovYpF9NouUYDXOAlL7AdHfEiYYqHJWN0PmSOEni+HqXsqnOX8yxHyqjEDdQfKyUyaQ9eT9PRpaddXH6idWvTJzKk5MMrrKzKVyzhABEMjjUNzzxrGmms5SpwYGdNCCC6pNVO14h5UjwalCFQ9oZ7bqjmNY99XZWMZdGO+aPcoteP7dLE12Sa9lbBY9uaPc+ipt7S5rn2Tv05sAA1uYpYiD4TvqagNsgyifB4r2KbintEIuEGq3aDXFX8xhhgauE9d5lnsR4YPbevT8kGH23tjYJyXimez0S6T0EWTzhTM4yjss8ebRDEy5dw2cZaHwvRfDLrY9IkmxrIUHEg6aaZ0pjufiRCsT86imz7yZajvPQiBIwBOQVOINDkWfdkdgZR3skbSyrJTL1nJzk5KNbHMcFPn3r7FH5Y3cVOpkX+o8CIzTzwPn+sB7QKkmE6NYQcpnjGsfZX9gwTEx7BxH2YkyF6q9LEu9MtGFopWtA6N+BqOgG10FD6gziHA5yCPKuwcyAqs4gv/MlEyMvE2B0bVp8vNITLvlq/QIfshTwoC8xZOEI0NMdUttF86Fd4hanhtcS8BbsvYX1sTQNy81rPS6jpAFO04pTTydaaUymXZ//mz/ZadG4Wn65M4D4wcfNlZgcmTXWAI+9ObU6esVEgHtxXDD6nn9hbFDGNYW2p82hjzdLlSQGYTCu+hfv0AciHBKUNPi4pPPuUEEdhqlPqybte+1v4rIPAV5lJLInzQ8rLRYUuXfaay3JntGF7OhZPKznfzx44sw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f31dbe8-8e94-46ee-f3e3-08db515f0645
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 14:01:17.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+OWEZOm9yLsSRcnGY1Fhx1YahU9hubC6XyZfnqk8X6oRd126PM3g/UJCdUoTp9aaSYP1v+NF4Vb+k/tSSlMEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100112
X-Proofpoint-ORIG-GUID: fmxD_RyrLwC-0FdpOnEKibrUukHJ30gj
X-Proofpoint-GUID: fmxD_RyrLwC-0FdpOnEKibrUukHJ30gj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When compiling on a system with gcc 12.2.1, the following warning is
generated. It can be fixed by adding a static storage class specifier.

cmds/inspect.c:733:5: warning: no previous prototype for ‘cmp_cse_devid_start’ [-Wmissing-prototypes]
  733 | int cmp_cse_devid_start(const void *va, const void *vb)
      |     ^~~~~~~~~~~~~~~~~~~
cmds/inspect.c:754:5: warning: no previous prototype for ‘cmp_cse_devid_lstart’ [-Wmissing-prototypes]
  754 | int cmp_cse_devid_lstart(const void *va, const void *vb)
      |     ^~~~~~~~~~~~~~~~~~~~
cmds/inspect.c:775:5: warning: no previous prototype for ‘print_list_chunks’ [-Wmissing-prototypes]
  775 | int print_list_chunks(struct list_chunks_ctx *ctx, unsigned sort_mode,
      |     ^~~~~~~~~~~~~~~~~

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/cmds/inspect.c b/cmds/inspect.c
index 5623f9913bf1..117efb51674a 100644
--- a/cmds/inspect.c
+++ b/cmds/inspect.c
@@ -730,7 +730,7 @@ struct list_chunks_ctx {
 	struct list_chunks_entry *stats;
 };
 
-int cmp_cse_devid_start(const void *va, const void *vb)
+static int cmp_cse_devid_start(const void *va, const void *vb)
 {
 	const struct list_chunks_entry *a = va;
 	const struct list_chunks_entry *b = vb;
@@ -751,7 +751,7 @@ int cmp_cse_devid_start(const void *va, const void *vb)
 	return 1;
 }
 
-int cmp_cse_devid_lstart(const void *va, const void *vb)
+static int cmp_cse_devid_lstart(const void *va, const void *vb)
 {
 	const struct list_chunks_entry *a = va;
 	const struct list_chunks_entry *b = vb;
@@ -772,8 +772,8 @@ int cmp_cse_devid_lstart(const void *va, const void *vb)
 	return 1;
 }
 
-int print_list_chunks(struct list_chunks_ctx *ctx, unsigned sort_mode,
-		      unsigned unit_mode, bool with_usage, bool with_empty)
+static int print_list_chunks(struct list_chunks_ctx *ctx, unsigned sort_mode,
+			     unsigned unit_mode, bool with_usage, bool with_empty)
 {
 	u64 devid;
 	struct list_chunks_entry e;
-- 
2.39.2

