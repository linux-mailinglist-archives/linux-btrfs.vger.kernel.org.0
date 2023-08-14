Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18E777BCFA
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjHNP3D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjHNP2f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:28:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B167210CE
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:28:33 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECi9cq017395
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=8mdyAB7aUt98v79hROsiIpAgkdliDgaBXYa8E8sjMTA=;
 b=Bhh4f8A/q1RVwrCmRzW6MjaOKT1hKL9zfldD+JJN5o1cTv4CcaAqJJSpiEXKOgAEWXXV
 j+X2MzgfRELdx3vwdQAgZFwhEK/IYIRBQbYvKPQQjgbo0BXNfF/yZu/c82a9Vug+k/+j
 WHFnqypSkUhe64iZllgey/W56rxQDheZYSvE8j2+DmvmzhNK/uAXcAqDmAIKKCw2+6Co
 elEMyW9yElr38iCBPoEUNurk2ksYpC9TcyjTtzmeHACAVKTKhclztZ6Ii6jPJYEtxmey
 ZfdxP4G77a4j5gBcP1gI/bZDxGNlIDqc7zWeO6oycBB1BQVNzb8/lpq+C005ZpMNH4rl Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c2scn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEkjuw040343
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0psygg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8/n/Dm1cKsb2zkcUio9idU0Iu1uOCLNUvTODwkj57EBVWM9LhBO1aq4jk5VhS3oxmoByY33O370hPwSO2IuQosy2LmfDt7c3z2v99/U/tlXnSVoAVBQrHpl/0weplPZtxFuJbaCHJf8E6cbiYyBiggZ3rJoRWCrEZ7NjkAi+QwhkQd6hWCg8sdZ1H3D1e6P8uxz3FjJelBJgVz1Lj79my1D+E0gU+J0uZt1x7pDY6hXet/V+Oq5/6TEoS7fQgs08p5pGd12OADIxLrSSIMF4R4lQFokoor6kCwElRe5QTnoNX8Sv/AZC6INVetEaXhGL/9LHXVLKcip8WFsCzKGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mdyAB7aUt98v79hROsiIpAgkdliDgaBXYa8E8sjMTA=;
 b=NPc1W49usdbxMNOVYXHjVvB3zEdToH75UAvEOKr/+4SiDTKp4VK2iHzMFW9xaTrmqDZP0LFHsE0StYKC6mDSRMHqH4odJWJr71kOKvPPnbptscLZ3KDqNHbxDDxWnp+Fy6UqChyVf3LGhpQLfm4xc9aG5sE07zgb80mlW730NkvvoT9LB1WtMnfUdqK7z3Xlwcu/ppIydawRFuLnSL4coiL7ITzmQ3BJ7lE5B4As7VzMnN/G8r26JAZaqIUjKG3wpxEKaWdhObzqXNpQKhUOU/YyiiSbEGvqzEKQslZjJcOdiMs6LP5V8X4Fqva/EJB5OQ01uykPYlx4yod1RjZ2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mdyAB7aUt98v79hROsiIpAgkdliDgaBXYa8E8sjMTA=;
 b=KlZ6uB0zgalf6RzCitl5baOLvp31kfBGpYBkIaPpL8OKdThf9ggVSiJDH4Rt4zF/5B+ZV/Bbm+tCiyyaCopEnNZRAzFcV7jm9CVsVc9+bc+KhE9/82OhefKPRBYtO8J1Jwi4jRGA7VGrBk4qyAaRw4j+WujsgLPxFmzVZg1LAFo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 15:28:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:28:20 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/16] btrfs-progs: recover from failed metadata_uuid
Date:   Mon, 14 Aug 2023 23:27:56 +0800
Message-Id: <cover.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: efdac045-1551-4e59-dfa7-08db9cdb16f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TVr592VqHdYiu7bmY5cmvt+37MP5H0XHEZJTQRWSnqcETu88yuygVbTg8Wy11Bef/6kt1/UNaJ+EKXTuxEEY0gTPXW0ORsZEIv9VtLkwDhTlkZnEoRhslPLjhh3ShcGuPOcVkqgW2opd9wIrq4O1CEWaF7O5vNPRho1HK+fg52J8Uy3KxsACKpCWpMDsq1SrpuEpA2oVt1ryM2+yRMgMceocPb6szdOe69QDhkPhNeOA7odpcGzeBWRHXOQecs1Mb7uIZIV5dGAT1+IosCMDZXsI+i5rp0/F9rwT1pdl1qbbSkHQ6wQfvR7dHMZcnGYiOQtPuMrlRWZ4fePqsnLwmMVXVZD4J28dlcgqlfrS0dHF9TRPGF2ws+6//6YpszbCAkjycygDym0iPLPAnEJ8ZTcKQigv4tHnyi7JX/0zi1+3XxwtONXdUb1jMYF0YvnuSpesTo89N+6V8ps/IkeTzBx8+ICxp8jcbQcU+HBt421mTAXFIYWpo5JM0zgWcFOYHB6rnBPFquy/A5DlFXU0uwY0aQPxQtfUoVUbOsxHqNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(6486002)(6666004)(478600001)(5660300002)(2906002)(36756003)(86362001)(44832011)(6916009)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(26005)(83380400001)(2616005)(6512007)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jKMNlCsKzXkRvTYy3ZQheXWk2ms7LydniYMNAEbtAeMUGgyZSkcrKw1Vnh7p?=
 =?us-ascii?Q?ckRsEDdD7DmgJ+eZlBBXk+PqY+OuPuvTa9eozuKTVcBbDViCA5igK5Mr/rXo?=
 =?us-ascii?Q?C0EltxnZjnoPf3hQN2lJ+9NlJriSj29fSiXC6W52s7JAZeNwLqT5Pm3tjB3g?=
 =?us-ascii?Q?2u05LCSfeS1Mre1ctAj9ovHw+j/bWbrXKS+OLvb/dV1CxsgFbXB8HhkiqWiD?=
 =?us-ascii?Q?shjhbFRx5Jl1NUziTxeWoT4R53LdgYEFLlF2sdpkjAoXGjw/1mKODVuNYOBI?=
 =?us-ascii?Q?9fh+sipnq86YMu4M+F5w69L/UvU0H64xiNoWObA5hYJN5vHOwg5F3r4Il/DX?=
 =?us-ascii?Q?c4Gz1hA9jqnAwnnZCo5SVShrVz3zIFIPOeBIGHW81RIz5vGdsVVrnLF4tAvB?=
 =?us-ascii?Q?BjUeSmfjltC8Gqg3vqdTgUV0v1ed7qimNsG8CzZudfWHfxMbTvuDf2jezUX4?=
 =?us-ascii?Q?8m2voCOw0me+BzDVxocB6fAQ/0FPABgVQCSsoMEyUZy4vHfhejeWPgN2Tt3q?=
 =?us-ascii?Q?P7n7jgbfQv2lPQ1T4K2SZU3Z/obWTHIZ38rCpeC+lBKoOqtPRoW2/oYd/lPG?=
 =?us-ascii?Q?PCKsTZXlr3rWfICg8MV9LKBHTVzDrSVXrLQ9B874Jj9qJvAd+nYJWOSc4HFK?=
 =?us-ascii?Q?JikaO0BZjXwHdqlegUy5y6PynmGE8MaXJ0Jekva0cfDbumexekvvtRYmOlN4?=
 =?us-ascii?Q?E9mgskfeGPgPRB076aVioO8FGuJQ28V/k+6pFankC+jEox/RwU7F+ZKwYG4p?=
 =?us-ascii?Q?Go/cu9K0ree0AdJHg+po+EsFtgO/KwKedrsxpLPeLdCR+DHHKguacm2/C4AD?=
 =?us-ascii?Q?8/sTNWyP7WLAK4g8Ow54N0MHWOe0uQ8M0dgVh7DDQLpxjbOAMcy/38YnjHZc?=
 =?us-ascii?Q?4Tx23jIqctnPys13GZJAkyDIkiSP337skPklgQaiyTmdiYLRlQjpFVr1/fRN?=
 =?us-ascii?Q?aSZ8LmdtnPhNX02yIjRQeQH0BJQ4Zruald7mWvRSTeYtASpVboqx+yXvLBO3?=
 =?us-ascii?Q?C0WpHoS4k1kBvG4MypTT3c0xHxoa/iBM2lf3xBrocciCccQpCa2Z75qtGXfi?=
 =?us-ascii?Q?m2/DqxqOfD8a7YfWpirCIxFmwYZhOljNq/XJePw1z+bjz42dj335nCQ6Bd5I?=
 =?us-ascii?Q?O6iLXjraeYwuO+OzLxVt3/4yN6/om3urFtTgYIn2eB/11E1Tbi+Y6xSSgIev?=
 =?us-ascii?Q?gJpukb7d31HJDZxSxreeM1UIo7mM0THAUJXvjoK6e+72/0W2xu/IW21+yIjr?=
 =?us-ascii?Q?4PH0kRnk41r041wYRPX61vbYIXlPIDf9e07zvF1/tqXju1u8344JgII+HSPC?=
 =?us-ascii?Q?CsrGMyPgIyZeFwTRU4afDGgBlXI9tjKSMnYUFO755kmtyu3vlKL7lq5txnkz?=
 =?us-ascii?Q?bdpi4RE7AE57lC73UPjXTcpl6nkgH91jX0hC6mvXzn1318GQPZu8Iog3hztC?=
 =?us-ascii?Q?2uH6PWKQhBsOdfqo0GcdIJ8+CrRMikmqLaLexKzO/nQKtpflVuuAACDDDnU3?=
 =?us-ascii?Q?BGXF2NyP7BJr74hOIf6M6zuDZ+h8YaygP4AeGXB0hEQm4N01M/2zGhibzbrn?=
 =?us-ascii?Q?oF7CrqSKuZU1pIyfPl+E00CizlHF7IlHkl6WGItwYRe8M+b63VlQKz6ZlGIv?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lwDPmp1WBRofUKuX7usfdbspSAuy8mDGt2QkKzhrIYnl07qr1uuGXPSMasLgnaHmoXJHDr3gajiz/GFULGBefIftcpllj52aUoQuIPEO4Jr10gccUhIFX36Bw264jSgqzFPTXunly4R359Dn6/FOuT1bI46i1ThL62YTjPPLbQ2VwMTPehsw7y52rGzRUpHd35BAG91pBNT42ABfKKw5BAO1SLvW4qoerzv1t6bE4w2svaSn5lew3BUw0IQSyXi2ky0kf4y/D70aOGUjgFAs6Z5U2lv6bjNBBPYuF7C35hSVMvcBWo7IRZ3Z+ew5s9M3+gHRK08PDVp0p816XiMaS2sa4LCSDwQ+9CKnpC9wp4ozZ6q9p2kpUCOqkt2CRTBVeOOfZZDEEt2sOa3KJ5Xf7IPCidFG4/rhRWGvQtb6FtDqQYBID7rAW2SgSxnfOwmsmVlQbuWqS6kOxZjsERNooI7uvDWhAd6e1yrtjH9MOGp+6tiUo+XLjLMCwtwmZiK3qV0gKMSxCqownI/1w91IHuBYzFuYK3Jg3MXDLPq2JJFsH57rG3DMC751ju9QLZ6Gx3CKpvkRFKmVBIImKr6K2pg0896CftXd1tNUkkz73eVwrFU2vHf8n22SLBfGpP+yjGLj6oT1L/HnnfMPFBQoLCGmRxC3fD42sordtAM472AAnWQrmEbIiu3JihnQnpe7ZzGqufufV2Riei04jN064DQS+WGUa8n0IpcyUo5HK6GDZajyJxFy16vbbZ2kOksEmrINFjLu3IU9D3OUXyPx0g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efdac045-1551-4e59-dfa7-08db9cdb16f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:28:20.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FeMdQWmxgnzS/QOHdSH+7kFMViML0MT5cN/xnp4BMPAfr1XLSZCwabfpEhyxCtESiRbvktG5EdX5t2fjbWiijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140144
X-Proofpoint-GUID: vJjx07VlXgcjqUDsCUokvw2zwfVHp0a-
X-Proofpoint-ORIG-GUID: vJjx07VlXgcjqUDsCUokvw2zwfVHp0a-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The kernel reunites split-brained devices after a failed `btrfstune -m|M`
operation. We can achieve the same in btrfs-progs. So port it here.
Ref the discussion here:

   https://lore.kernel.org/all/1fa6802b-5812-14a8-3fc8-5da54bb5f79d@oracle.com/

Patch 1/16 wasn't integrated as part of the set
	[PATCH 00/10 v2] fixes and preparatory related to metadata_uuid
it's now merged with this patchset.

Patches [2-6,11,12] are cleanup patches.

Patches [7,8,10] are preparatory.

Patch [9] addresses a bug.

Patches [13, 14, 15] provide recovery from previously failed
`btrfstune -m|M` operations.

Patch [16] enhances the misc-test `034-metadata-uuid` to also validate this
new recovery feature.

This set has been successfully tested with the btrfs-progs testsuite.

This patchset is on top the latest devel last commit:
 8aba9b0052b6 btrfs-progs: btrfstune: consolidate error handling in main()


Anand Jain (16):
  btrfs-progs: track num_devices per fs_devices
  btrfs-progs: tune can use local fs_info variable
  btrfs-progs: rename set_metadata_uuid arg to new_fsid_str
  btrfs-progs: rename set_metadata_uuid new_fsid to fsid
  btrfs-progs: rename set_metadata_uuid new_uuid to new_fsid
  btrfs-progs: rename set_metadata_uuid uuid_changed to fsid_changed
  btrfs-progs: pass fsid in check_unfinished_fsid_change arg2
  btrfs-progs: pass metadata_uuid in check_unfinished_fsid_change arg3
  btrfs-progs: fix return without flag reset commit in tune
  btrfs-progs: preparing the latest device's superblock for commit
  btrfs-progs: rename fs_devices::list to match the kernel
  btrfs-progs: rename fs_devices::latest_trans to match the kernel
  btrfs-progs: tune use the latest bdev in fs_devices for super_copy
  btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
  btrfs-progs: recover from the failed btrfstune -m|M
  btrfs-progs: test btrfstune -m|M ability to fix previous failures

 cmds/filesystem.c                          |  14 +-
 common/device-scan.c                       |   2 +-
 kernel-shared/disk-io.c                    |   3 +
 kernel-shared/disk-io.h                    |   5 +
 kernel-shared/volumes.c                    | 203 +++++++++++++++++++--
 kernel-shared/volumes.h                    |   5 +-
 tests/misc-tests/034-metadata-uuid/test.sh |  70 +++++--
 tune/change-metadata-uuid.c                |  56 +++---
 tune/main.c                                |  35 ++--
 9 files changed, 312 insertions(+), 81 deletions(-)

-- 
2.39.3

