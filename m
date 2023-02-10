Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D9D692315
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 17:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjBJQQy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 11:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjBJQQv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 11:16:51 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D51D900A
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 08:16:49 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFMfQC015489
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=nIU7lKUBg6Pu3KxbNaI1jCyW1FLsN+zZcuLXR8CUoik=;
 b=lieSvGeAUmD4ORWFJF66zenN7shZ/Ki3+SOXs9exKRQ9axjqhb10CWlcsqxh2BpdtPoU
 7nc1Vw6IyKo+Gt5UgJ2zgvRAoVDBcQmdv24/bq8xv7n47ROCATU3ePOt02q8Sh8fjeBK
 wLsWiCHBxbkLPP8hBNYj3JLNgqp6jKaktvvcQLqSxy9yHxr+OqvdlFVny/nzH0j40iqS
 LwbOMrkfVYLRFxehnf2wyQv25k34jz/5TnqsZvP2lNEf8dp5cd4oKGyrlD+Xwi0+VYMJ
 zEQPEHVCXqvWFmbACg1XnAetm6La/z2+9Xd7wPx95yH4AvablzWKIeJDXk6oIUnkUcS9 Sw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdcnpyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:16:48 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AEbk7b013754
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:16:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtaejx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 16:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h00/PN9GaYH+yQr64zfohQxgbqsZdqMjEG2kMU/ELv7SQBqp9fZ1KHUzHABloaR2LrSiXl4kT6UadwRS+0NvvYqEFfsULQizqz1idenPjJMpvhTTLyGLD8rk1gFr9K8jsSKQHnXzBZK8cI29VBWuNdsoUYllMrwgiQ8xBCj9n+crsiNBb0AI3B4p1Li8zml5MY7YdDu+8XY75nOulmpB2V0udhRHgYotdCbypsWWS6q3zsQMT7gieLp5T5/EaWVT+dPB8WhsJqOC/PQoYk+5QCai4GG5mOCaK4ucZPnGYDFU/NISQRAG2pHz7zLhple0L6uBSG3ZrjiHUOs0LQxiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIU7lKUBg6Pu3KxbNaI1jCyW1FLsN+zZcuLXR8CUoik=;
 b=nHRdiaGUngYLFxDqOnttHTCvLO1hs9B51kMf6bn7mSHqfQULcxJuX8/VtUpupQTmiaxPs/oSZ5rmeSw01zv5MsV+WAutrXDs4p4Vs9yBe2H3avRKcFgRqRNdmr0NK7P3zC5cL+T5dHNmMr9LgHZf4aBEIF/n+/o90nrqDe1t8CrFZPJc8AFA2ZotQDI8yc9eADIfT8kXgOgbsagdpclqwfdkQJUXhK4S3xEQQHIhYYctytPyJ75B2h0yLSua3JyAaA4oo+bJwSy3SHKzGG75CUmh+UmNq69a7SYbas5psxL/WHuWctNSTynQgcgnUsWOmq47FbzSm46HNvEV3NHMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIU7lKUBg6Pu3KxbNaI1jCyW1FLsN+zZcuLXR8CUoik=;
 b=Y9R+3zzUWbUEE/1NcAOJSA8fWRXT7YYbqxhGDZDNCXpij7tazAvx/vM/QlTMPGeQ6Wpeo74jrcWQ2pDrmoTKEHN7r5oS2iqdIxNOF8R/uspkcCWjmwEL5yswoiFHdXBysucpbR+k+dgYY3U7eF4HekdlYIVNJbrdBqDWsBGxtMw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6030.namprd10.prod.outlook.com (2603:10b6:8:ce::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.6; Fri, 10 Feb 2023 16:16:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 16:16:45 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] fix and optimize btrfs_lookup_bio_sums()
Date:   Sat, 11 Feb 2023 00:15:53 +0800
Message-Id: <cover.1676041962.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e1c0b4-768f-40e6-19a5-08db0b823464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idNAPCWf2kFlwRseREsiMGdQQkJEMx7pTpMiZNREFuwx8P3KMJtfdrxvTuvwAzlJSnbeNc57FWv11EIT8ZfdvXu3kSD9vfFALpXjCy9XdfbU2Mq/tKGz4vA6ttN6zuk06x2j3wOx2jl9ivaBHFMD6QLjxF4GP8Mw5DETZJtW/3nFuGGAsjVSRAmX99jbmaW9Yb4kiJm1Z6jihQEvLHZ1y546emLNUJlw8muJlHYUOMy1tgs3aK+NFsLzbfxNFWcno3VkqInaDd4WG8qiHx2mCe8a1slpBSf/bq2dWF4GADN1oGOuX1eNjNJYFKYlYXNNMuWhvHskYjX1rQXrOiaR3vKjQ2nUaL2MPVtoSu1MuYWa87za2skMsaDDWj0//K0uQC8jnkCLaer5QPro/hFxXVL6k9vEd6EG1BSGp/H+WLItlktWA68lAAVKsxPItNkTz9OHxo7GTOrcJ6J4/IemoXCFlHtzswsW/fv54xE93j0vMKdFp0ErY7w8MZ/noiKY5sorj3y5Tm4q8Rhf+MyjYj29hvwFtdqrUKn8WLKlaRhVx5lLZs0u8WWDtXcLUH8kxjSB0HM5ZQtgwdwBotk7uvXgD0XLUfXtjUPSj9tfZ90dVjJ4gwSw8TrSjc3Y+Ji6aoX/kx1eUWebgUUSX6IMLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199018)(478600001)(316002)(6486002)(6512007)(26005)(186003)(5660300002)(8936002)(6506007)(44832011)(4744005)(2616005)(2906002)(83380400001)(38100700002)(6666004)(36756003)(8676002)(66946007)(66556008)(6916009)(66476007)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SYXM4vCdxAZM2Hh7kX7gexDLg0drdJAOyvXj5b5Pb+CJduqT+b3xyf/toz+u?=
 =?us-ascii?Q?6tS57YnQXmEcwsdHbI4mDkz13pwofdoU9JUlcpGeaAGhpmgyTTlGmR54Fg4r?=
 =?us-ascii?Q?6f0SP9EELys4sPn24Iq0BNSMgeYZlaqvvA4XG2UEIHBpV9WOSEHIHsSDC65O?=
 =?us-ascii?Q?kTSnDcgVTycZyBFQ6VfYNOvONn7I2acwHu3Rl4/jedrdzITKH3hFuwlYqfZb?=
 =?us-ascii?Q?b3AETK/nDQ0ZV74WNdO7sgEx+2GRi9FQtz2MgFtaherSmcp8irfXSpy1LgMM?=
 =?us-ascii?Q?NpK88Z5ur0YRZb9f9E+gguo8LENDr0jiVHVOzdPbtADZu1+0odCGGvAS1KHu?=
 =?us-ascii?Q?u+UIHLVtFleCRESsXteEDuXO/jDJWyTJckDl/H3qRfjpl4nzdGA2m6/In9Dl?=
 =?us-ascii?Q?xXRK4oa0c9wFTBB1pO8ELTEXs0sSwMll8tCEnczoB5GomsO2erpmN0/WTtl0?=
 =?us-ascii?Q?V5MWjrLZfoBMEkLpIgMgUWxb2Nq4U5Vb47SOZSSPH+hJZUkDTqkOG85sBRU0?=
 =?us-ascii?Q?Gvo/nd7tKy0/Ih61TgsTGlJwu0CLV5nJihfMNwelcr1/ctVIJVDz3+w7pj/9?=
 =?us-ascii?Q?FMTz0d/y/3Ol1KEJlJ+yJ7eLAYeD4Qnn01trzhZWWtbscg/K0e31R9a7MiyD?=
 =?us-ascii?Q?wPoRELz7QNzYgUgCsy5+Q/HwwETLAYoLMG6GFFUk6cLnHfaIJH6Kw55xSOTs?=
 =?us-ascii?Q?wu/lka8bKlGQ5SdU3Tco/BjuGy0J4rVfaIYkMbyJq8sbSI0aSu2kQ7AMML12?=
 =?us-ascii?Q?n3PETQO8Vtv0DIK9QnxgybV8VCKR31gwI0cqFkcHC4XfqlxDLSBQEw5lbYaY?=
 =?us-ascii?Q?RiF5iSQv0JVSVHhTIiickFM9mdUmSZP45PnhOzk5y7sGsWPnTVjTAbG7mcWf?=
 =?us-ascii?Q?NsOBMc+gCKWsRs4+yX16KEw1/vtzcPZtIEtcO700TFLXqFVAuJHNUim6I88d?=
 =?us-ascii?Q?OQYfQaRDnDJtiKOu4UZl/14W9kc74BC8HAnoQneuaO2hfL6r/opz1SseCa3n?=
 =?us-ascii?Q?WM+HN0Tit8TL/SvCXy4TwUgECL407VVcnU5s8Kht6l/Zu2NMWvWgf8tUZfsF?=
 =?us-ascii?Q?XyBjq12jQHG22RuBfcKB5vXHbqAfhcOHnvduSYz4lcQ6VkObLqGL/KXrhCy1?=
 =?us-ascii?Q?f1CDeCj3z0QEcUvl2ex8F/kHNhwxxTomGxKCij/VQlnKTgow8g4XLldpuaHH?=
 =?us-ascii?Q?QGUMBvOSgwthQEE0IY2FNA4I15znIn2GGspVX1lKsMAtxGHLyRWovnFG1UZb?=
 =?us-ascii?Q?WxxUIUBFo3NXuvz8W/J90hutgqn+FgUnwa9M1jLB0+6FFlrzNT6j6XC+fLGY?=
 =?us-ascii?Q?WvdNBhONNkeA31ArNBmeG4LdtnWoub/kVhaoDrtPoPKIiWx4nBpNXMpNU4kw?=
 =?us-ascii?Q?f2uLcjVRvhaxlLTiuRazP3z01hO/z8hbboNQzb6eos9vPhjumDrui1NDncTX?=
 =?us-ascii?Q?P1vAnAo7tWrWe9ZDbecEkTj61/IZ9VbwHxZzWN5TXEZcUlYutGn5q1Pqr6xs?=
 =?us-ascii?Q?KagcV+PmiSzEEuia63zIuByPvxzOaHaOEIzwJF8AXu9WEqzUI3+kH3O4Tiix?=
 =?us-ascii?Q?/4WuwhZllxQYbQ0rBAGfy4X7HQa+Fdx+h0NMuGoJYgocPr63a8nxZaZU6sdC?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sl9r1j8PKTRvRxxIXUc8wCELco8UI/IWEMUuK9nz87eHoIIgoXDJqdX8oKc6G435EUNnpjYP9m2yk2GYWhlxEOAVACbM83gGhKds/ih+vHjY1qn8yUCopk10YADZ2IGmMXvfiiu94oVZ7b3jsgPwJfM6nqKHo0x2jJVXkEOjes1ly37WwAY1Tn2gFiG9TOZSJ6sEQ77pJanbb9CW05l+AbEKmpF0rN8So7+qvVFg3LvVAFW+yl/rdGT+x6MDrOCABypCXg9uF9wCzL0PmGORPbhKnvJmrWmPzyHEAYvm/b2PVJ8jDd41nOOQBZ+XH5mmYOYo/AIbkPOsG23/lXMtGNuEuQFwRh9YA/bIJNnmmItjwvQd4k/WkfT+NcCUkrG8i+o8pY+fSDz36tQt50YKOxF4iMbo5pXPbiHftoiA/vE04sK3kJSPtxgVTYASa7SS0BiIpszUQpezfgzm/Y88JGzpdMUmlKQq9DrJVlG+Id4FDA2xCGd5QPKRZkrzcx/MdnCSWA0AfpE2+QOsJFkhBvaBOFpF8OGWCOQaxo5GCe5ssI/p9dy8bTrhlIDPhUpCnFprJenJRy96ivriY2pL+HeQ5ROAx3eJ1awrGbshiX6xH9aS++rUhZp4eU7IgStrFX6Q84Lm4NOXZASuvzizh2NABJasOOk44P0lP6n6wiImoO4qPYchNXwaZtcXzlE0Luu9nHPf/E686txU5Mh1n08MkDmji6U8Pye0UxU2q6eOfSzMJM1U1mvfHlkmZnLCj+wO+qtibCGjjNPMPqL9Bg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e1c0b4-768f-40e6-19a5-08db0b823464
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 16:16:45.6936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWzqkygmdxB9VuvB9fw7JoAGNTbZJ0JiH0YLicaOX5EEamGfWXOf8Yh5qEtnP0LB/Ep87LqHl+Rr7Yb73BD4gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6030
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=424 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100136
X-Proofpoint-GUID: O62eWVFTsSQZ76O8sSblwezE1LOdUVzB
X-Proofpoint-ORIG-GUID: O62eWVFTsSQZ76O8sSblwezE1LOdUVzB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_lookup_bio_sums() has %ret declaration two times
 blk_status_t ret = BLK_STS_OK;
and also in an if statement block.
 int ret;

Patch 1/2 addresses this issue, while patch 2/2 optimizes the return
value of search_file_offset_in_bio().

Anand Jain (2):
  btrfs: avoid reusing variable names in nested blocks
  btrfs: optimize search_file_offset_in_bio return value to bool

 fs/btrfs/file-item.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.31.1

