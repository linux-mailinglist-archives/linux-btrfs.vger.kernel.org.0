Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD31788BEB
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Aug 2023 16:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbjHYOsp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Aug 2023 10:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbjHYOsN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Aug 2023 10:48:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABD92119
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Aug 2023 07:48:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDOBl8018181;
        Fri, 25 Aug 2023 14:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=SeEfKTqvQIMVTAGnNyAFy4ozPgPKIymMutjuYBVNuz0=;
 b=bjkjNWyVgOqYchns3gI/+TpSgkbecfgYabiG3VLYR4LK9xn/44jx9VVrNeOW4PNyauvs
 u56r/N3q/kdjRISRRE1HN17cn5IwlhFDb2XpbtHEucs710aGancWzHmS6P5oRQ1O8UHQ
 jc1dY8PgpanQsVOVCVmBJnNwYtXv9EQDC2ekCZgFURP0IKWSc0hOIZ4KATc9dYFdXB7/
 1wB/5VY++hQyKYt5mWvNOqthk9jMka1YerLyuh5O8tDIK1RvE2CgCuIXYxPo4KlREkj/
 m1qOrIRhiA0UhikBBgvyAR0dR/b+O/4iH8+sbJfDeTTEkGVC1zKEoK0bJlZb89E5RSOv bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yxpf0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PDTSQw001061;
        Fri, 25 Aug 2023 14:48:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yux3cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 14:48:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBTzJhSTYUdGkoilfaig+H+bGqRfgreYSChn4hbUi7hQAojcm4ePvjOAgUZ9gLUIrEI8FX+M7aUZJ6kRVARZp+KtH4V7JVMSJRB9sy/7wkGontiwtVuFOPEcBz6M1z11v6kuRBxzhFhpKyEBZqKfk0P3xtxCbqabe5WDRMH5rKErRadNQZ2C27Vm9KCUNe5Pt+uUfFao4wn5ZAKf1GC+xRoQwhh2Z/Yklnp0r3TrVUjVQEKE36KJ8dRymNngXZ+2A+ljqXqrSzPj1LmwpaeMHFPvQyfBmAPoAS2yotKKbG0efOEsvwQ6Z804OE5+DjUY18+67SDW8hOJpE1ZWDsEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeEfKTqvQIMVTAGnNyAFy4ozPgPKIymMutjuYBVNuz0=;
 b=H63W1MbbS94Jkj8BcDiL7nzq1FQybj1zCtBrc0d70jPcKMHCCTVNt/vQqYn0Ayt13uAeHUlCyard9n2QCF4jmodBpjfo6vVuDm6s+prEJNRkRHZYyq5Xqnc8gIPZL3xv5mnOWEM0lMRHv1APWYvS+S0YLZ1Xw2YMYRa54498+iEOJ5SQBTgSFpc0TKGzKiZ3PgcMsFQl8HVU6bHvWEMJIh7VhPwTB7q6UXSwDNJLlv6TYwzIMpiDAynfjYRdwwcuQaXsOJbf+xoW1IF4WuZDNZF/O3NLU8efOt2y/tL9WnvmLf9N+4NcpZIPfgv9OqG7zaF5tJNFVjO+xxbjQLdwCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeEfKTqvQIMVTAGnNyAFy4ozPgPKIymMutjuYBVNuz0=;
 b=z6x30Xy8xnKctRXGIFaE5TSf+K8+Nx+0K07g2iO38/hW9S5n4nQPdtv5PyEZllLsPKvG8/2+4zQQGthoWwxe69XeQET2k/mNzS6tmPfYweDheLMM5zJcYwKscm1zpiI7LzJDzIy5j1HFFIOQZSBmR1Jzd9mFvA3o9o1eFr0BSfQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7338.namprd10.prod.outlook.com (2603:10b6:930:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Fri, 25 Aug
 2023 14:48:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 14:48:04 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com
Subject: [PATCH 0/5 v3] btrfs-progs: recover from failed metadata_uuid port kernel
Date:   Fri, 25 Aug 2023 22:47:46 +0800
Message-Id: <cover.1692963810.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c4ad4d-e68d-4182-cbec-08dba57a49af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBj0Qvvf/Kh6OndnKR8kR6dlcB7tSER/ACC0w6sLHojbqDEq1qruauhSQc5OIXtkgnB4z5LqmEQm/xZPmdIIK1PMw6twfiP7BYyAp8S9GwUpyNknAGDDX/3yu99u1LYCtdoWHFV83cAfszvuY0JgCE+v4Jj+5qp+uYYDPL7SkJ6XFRPln75Uyg86uJrGpg/c7v90JJJijTN/yv1jNeqqz7VA2vky034xofYKjkbC1KvcM5/jhxYpHHkqCb/ZzRu4qRX8dIk3LSocK4da+PnZN+7CHY1eiLZnO2xi3HPhzCXJ7t07XOmlBKGgoSyD048ydAcEzx93ucSJU8ONDznXHKBA9ZXk0I0Fv9XCAJJsID2SJCzMbN6IhLnJYx5c362frCycZwDwyUMTpN/uHxY0oyXnzj6cV8QWmGcbontPRFaWhE/ib3btwTtKyRXmuTNVMwN93UJPrlRICo8CHggd6FbrKgu4OlfsOXDOpTFOJtPJOjppdYQBWeJiBdedVj1qixOl9iOeGLBPW3XViPji04su1hZ5ek3HhUXRqTgVKnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(186009)(1800799009)(451199024)(6506007)(6486002)(6512007)(6666004)(83380400001)(86362001)(38100700002)(36756003)(26005)(2616005)(2906002)(66556008)(6916009)(66946007)(316002)(41300700001)(66476007)(8676002)(4326008)(8936002)(5660300002)(44832011)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i6ndHh2696MBxlzI6WdfAQhndv7XfGKpVKNsDTWGGM4hBSjP0B3KQGMPp+L/?=
 =?us-ascii?Q?msI0w3A21fEbkv3ZN5JR1YLEgK8FYF8xtIhVMzXIqyZ8yBD4qLKepOafwyKw?=
 =?us-ascii?Q?P0FPyjKFqqwxpaUuPaIs4uOWdJh9nsy8GkgzX2oTIwfk36O6keDXEMKpGcZR?=
 =?us-ascii?Q?jKl4MNp5HeK3NKrYq0cxizI8lM/1Dfz3c0NZr6TwQgRqBzbLHOFZ3AGtatP2?=
 =?us-ascii?Q?3vqiF+ICAe0x98U6FjPNbnYscLlPgcqgihguUSEms4gL8Uh70SwlcnAGw4Vn?=
 =?us-ascii?Q?OLEcpL1iw8BJWeqwL7SUnt9w025iY5eDGZfIm7IsNkLd9RuNDTta4+ddssHe?=
 =?us-ascii?Q?xuegUzUFDRSMyqiGeUJS5WJyU1kHwUnJ6jO8GgfYW++8rRcnlfGfQfwuxAeW?=
 =?us-ascii?Q?wAuzJYSF5L57D/P6fnwxCA3utKPynS5pFAX/yAh4ARYhXJZ+uE2vFJIMSnhM?=
 =?us-ascii?Q?BOwsKiOaD0CM67o7g3p9BbwUeA6sNoN8+F0uweFg7CmZtJr1zTNRQuT2Nye8?=
 =?us-ascii?Q?T7knxmDFUrS001mrI6B0ewa4bRwVT7Nx+vXLO7NfGnTHkHS2SUOIIDg+jgI3?=
 =?us-ascii?Q?sBaaqDpIyt5QbiEphR1Cnnxb/2o4HQwqmAKO54ugw3BGRkl8eNGRsfs1SUy7?=
 =?us-ascii?Q?zysaWSlzBLd2wtFmSmku+V/3JaEYcY5GNi3DNZ/JPomb6ThhW0kThzggcZ5S?=
 =?us-ascii?Q?cDZzpXQ1f41RkC5twfn+cawNKbmMkmCoWUHRmGrEDkqhW0ZsvaUIUPLpcsmi?=
 =?us-ascii?Q?SUwMt8fzECipsYtqJCpPBFAPO6KYG8lW0CA6zUY9AJ+CFTG8Dv7BFauJ3R9X?=
 =?us-ascii?Q?w/X5qsDcXFtFJbtXRsgWQmAuqk1cYDq4jnrAbXf02mjOojR0WCL2HhgCu8/5?=
 =?us-ascii?Q?6Bql2Cdwh4eQ9ATij/EquGPkK0XaI9Cjez4kgE+m/SlaEKOGKpNDoxF+mIc3?=
 =?us-ascii?Q?grSfRsnAAywAnV/Dybwy7hSJUXxzRohHve7V/awCWLED55eGbtZlS95T5GiG?=
 =?us-ascii?Q?ei9CLxseClkdz+bjnm+OYtb5Sp5VZ5Vq0rsMhNCIxXThLmkcSA6VACg1R/hI?=
 =?us-ascii?Q?7YcPCHOzT+fSwQYFatryPInOb4Hzo9aoErZGsQ+Gewbs74UgES5IHKbccm4h?=
 =?us-ascii?Q?E1RUZU2dEoYnAJJTMQQ8i77cg6wpHkuAWHQc5Fb5xeot7zUleHFM0rdD4jh/?=
 =?us-ascii?Q?VKT84GPzBcd4LPBUBOigKzvvXJUQS7C8LYu5LjoOYiA1nyTCXC6hBDAxow3I?=
 =?us-ascii?Q?ZKOE/Kj9B80x/n/58dxGfr1HJ6E6kNJcMWaTiRG+5ENUO8RECJbnysdZ2ql7?=
 =?us-ascii?Q?JtT4NRfOBVnrUjRmZpy/Y4o6VNEpoqjD/SsDfP67//5/CADpPwn9rXRZoQCk?=
 =?us-ascii?Q?Z1BeqUV7MBTQMExK1JtQG/GzSVeeXXUViN6+EpodmbFOVYq/XqSUEoq7NiF7?=
 =?us-ascii?Q?WT/wvvjtMFkcq/cpPTaSWc13FB7UADzXNQkXcvcfXOy7JGHMd+dPGPv5cKoU?=
 =?us-ascii?Q?Q8MR6rVc3JYjAeZPcp7XzqLg0+vtw1afb6sE3KymDsleKM9C39hHFAhv5NDJ?=
 =?us-ascii?Q?0DK+f+L+vtpZqzofGsTjHs7dFvH/2ltI2qoHkCaR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IdZl/MukmDvSN4df7maRzV3qA3BQbkWC04myxbP/Pw9xkDzU/emyDB8Dxv7scwKj0ien63olOGlT8GZs41TMqM5rojQCK2ucPax8B8pTwFtGuceOzIk/oymca96TxuHFDwt617emsYpLftYCu8eS0Io/bpGsKG0C7KBA9R8zISs7NNP8Eo6a0YBNWm4IrJCh+y8eybziY3eJKCLDcmcUfFEbKmzJv5OYg9oK60I5xjc1mwlTnA6C38GeUth+K2iN2T2eED2qIVHFzEQHnf/9nvbAbI3yp6Ez6x7GSshbLPA4XJTUZEkulLsDnI5L1jhtGBMHxsbiz75sTUGJzQCox0aXJkEvYnRzQ+NJto6ZoucutAQKDQoZfWqBtV/Ka7n1zRfDjFATYKNAmPOGq5lIN/ToyDTm2Lil/M9+V5w/9NVejZtz839f2M1a3j7LjR/z6DK7kGz0vtjME5RihHmFDceci9Nub5Djt/W147uVAO4VN+JlP8+/tItNNK0W/YmwqjAiGkkPk9ZJ2LJv7luUhlqapOM0QNBZB2mmwMfI0kjQ+fDUxn8A2CpghTJLJhXKKk6fV6UWVDAMzwhGuabhW1RnYgXSirOuyxb4LkvPiOuM23TVT2EQrkpNG6QH16s3qli7L8Q4H3SlFA4fuOOySntHXLiQHv2lTrSMt+fc5oCtZ3O2yghaO5P0J4yP240ubVtxUdGYxUN8kRAJqc9bCUPe1o580avC7H8tXq6RmfsiK9Sy4Kgaz2URlD44SyBRu0Fu+7AyfBVo4M7AxOrWLJ0DfKGgjRBxbVPOF8Xhluk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c4ad4d-e68d-4182-cbec-08dba57a49af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:48:04.5767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udT8jVbUhNR62PSCCqA23g6hImXGmazYGi8P2ZonK10lDn750onMOrZ2xE35NIU4n068LSBGsVafB9bph0qgww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7338
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_13,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250131
X-Proofpoint-GUID: xJzyJc2geyy43GSrGwOq_0UL7Bx944a9
X-Proofpoint-ORIG-GUID: xJzyJc2geyy43GSrGwOq_0UL7Bx944a9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The earlier revision, v2, of this patchset consisted of 16 patches, out of
which 12 have already been merged into the devel branch.

 v2: https://patchwork.kernel.org/project/linux-btrfs/list/?series=776027

This current patchset contains the remaining unmerged patches and
addresses the reported bug:

 bug report: https://github.com/kdave/btrfs-progs/actions/runs/5956097489/job/16156138260

In v3 of this patchset, btrfs_fs_devices::inconsistent_super variable
added, which helps determine whether all the devices in the fs_devices
share the same fsid and metadata_uuid.

Anand Jain (5):
  btrfs-progs: cleanup duplicate check metadata_uuid flag
  btrfs-progs: tune use the latest bdev in fs_devices for super_copy
  btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
  btrfs-progs: recover from the failed btrfstune -m|M
  btrfs-progs: test btrfstune -m|M ability to fix previous failures

 kernel-shared/volumes.c                    | 193 +++++++++++++++++++--
 kernel-shared/volumes.h                    |   1 +
 tests/misc-tests/034-metadata-uuid/test.sh |  70 ++++++--
 tune/change-metadata-uuid.c                |  48 ++++-
 tune/change-uuid.c                         |   4 +-
 tune/main.c                                |   6 +-
 tune/tune.h                                |   2 -
 7 files changed, 281 insertions(+), 43 deletions(-)

-- 
2.31.1

