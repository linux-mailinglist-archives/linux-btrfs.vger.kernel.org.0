Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8C17366AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjFTIuq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjFTIum (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:50:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE9D10F9
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:50:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K0F6QF015133
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=g7zVIofcymWvvDnx+llkSMmi+KrG4BHIbth6BSNlumQ=;
 b=RYwX5DMEMMnIruIUXtu62gGhURIDePGjkI5pgdQg8DYF3GfJYYKUhiBobxQo3DND8+dk
 CmNMX3OrxmzuPsFH0ONkEKeGl1kVX1t9xbWiTNuM0Wk1d9GFyGn/HrBLV2NOtqEOPrGm
 Uc65fdtjjZGQsvMpmYesrt/TbmcbobV423JQeJ0hhcOrvr7dsXL9Vxh8L5lfyNWccJY4
 e2hDozI+i31rC0i+W+GcvFmiOcFKRgFqwCY9hK/8SBNewmgTtKtw2ZOeSdcis5+9C66D
 3OMgtGksPP46WSfEtxz2x0+lIuc2H5ngUNoaMQPf1ezdy4rcHxL9Y0xb3QEowRLWYf2W JA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa44tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K6iVju008362
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9394jt83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3qMe+RW92ecHmLWmzEhuowfQljt7IhSs6a78p8dk9Ao4vq6g1dgZCkEhniae6GnMOnLFMpV/y2Ba267/xK2KQ5gHyL3O/+HLy5TIl5G04bpZ4gCEu68GY5vZNCgd1GojwBz4cxXxF1Hwa42HNqJA07PwT3TH0FI6YohkCq/6ITxGrFvV94IDErY/9ORiwGZJKey1XcL0DPc2JMFVnbRvPGfL+J2fxSxozDsrcNTuEnUpx4BYTctYXyxxs1LKExAqLzvKRxn2ZIyqjCxxGXrq99tzVmQm1sBH3mPcMplcTRPQR97d4/ruKiYWuSmqqyyV4StezwVmDQptttpnRL4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7zVIofcymWvvDnx+llkSMmi+KrG4BHIbth6BSNlumQ=;
 b=fRoMgU34A5ZqoeYh66w+sp9vhUdragt8FZbVp+vB8Z3hNuhGoHJF7ujKtCoK/xnuZoKDZ4pGpjPKG+HDj+2Rs8JuPX1FRHygYLCzRoL0LjqrmKp14Chl3anHBZvRiCiBsoJC7XydN5XHQUmJ8Ti0qGhvAXEs7oaJbYCZOSzdDMyEbB+TYbm6Gh+FtNuTo7t+5vFaKELtRSfOLyZcmOtJc/Cqqw0rR7kxr2GYvjtJjGU1gzYOMcpTpph2bHEs+N7eGzEp+apkZ50nSq5VRWHtOhzyv5VEGxoz7jQ3dCzb1FSSCKEiJMsmOrOTvCyFgjSbdlZTa4rVAqfd12hSk+EhFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7zVIofcymWvvDnx+llkSMmi+KrG4BHIbth6BSNlumQ=;
 b=EXqmQgUTMBr/faMJhi4Y0Ou4MlF5YI7AIvX24sf6s1Sn1scHAsbJeFzwM5HxktkLiMMQXYxMZIEapKZYx2gOc68CNQxBynpqCEWhPRT8As7CVYNBZv/Ki+BpI1B+aXLJVNrtmNkf9dsD61nzxBMbh76bcPfeDRjD9G9Z96v9EqA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 08:50:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:50:18 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 0/6] btrfs-progs: tests: fix no acl support
Date:   Tue, 20 Jun 2023 16:49:56 +0800
Message-Id: <cover.1687242517.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 806ffa32-6cb5-4ee4-1a52-08db716b5f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOxbZmN7aJEUubh1J3WO+A860iBpVgIF4S/qZ4yf9Tj44UzUfuLgzqTaE1qdN2y7QegcoNZlORwJ+Nebwg8c/krqWDVXn1bxpAQCF/4uxmjs5u2vg6ce/6g84+IlL62sbh2Z9kYzWbOQ6gWklBF19ikPZCmmOwuogVfoTVNy57TrfOqKll3Btei4499ZwTloA2pq60BNlhOQ9iaCGUzIROEORcfs/hLwXB45aaZC1PaL7mRH0W3rWfmWRF2jsu1U9u6XnTOa4+4z0fpXE05/8TJuuMzPtYWmzxkhmoLl3TJ0E4ql7V3likXoBGp0CtNqALyI/jFqcMUmw/bBip4vph+SnDeRPbg8NdWCdVrE5xEU3QNeJSdmGhEGmTvlTdcsudQM/yG1hxw1bfHOY3y/Q1cRaYUOHvOJ5bzIEszMPvgb9fqJK/HyLvVoHo0gO1xLFoG6CTF4WTAFBAHdt0vNIJbV7pjkgf8QgB+bDzmbFb9zgIpoQPFouklLCSvT8rs5oTz9KJubLUSlB4Q4cSaW9VxfKt1LIyktzzSqUaJafTfHwW4bs1hIKcxhNCdvjta9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(6666004)(6486002)(478600001)(186003)(6512007)(6506007)(26005)(83380400001)(36756003)(2616005)(86362001)(38100700002)(107886003)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QL/cVc6b/wZr+Ch47ip/7n02cP/2Ma3zAz2pMoA9Ztf79AQIHRj1CqYcC7gX?=
 =?us-ascii?Q?taKaM36yajhXkXl53rsXBqbuR3XaGJG64uw9AyK1w2f+KJvk7bG7dcZqQVMy?=
 =?us-ascii?Q?Ik3fmLHsAL/C2/7iQn6/A6AelMxzF+qmmhuFNaQV6j7j3BuDYUXxvoNmplLJ?=
 =?us-ascii?Q?ltqDFALoXZMcdIBqxxL/T9g4FDtC39ouh2PdnvACaMZI3H9NXXZP06ZrejNI?=
 =?us-ascii?Q?O76DgkLR7mb29g57J5NZEea0wsFpgk3p2acHFcz/dqoMWg8SaEnTvav+n+RJ?=
 =?us-ascii?Q?J0FEk82nBDyMGo2FM3HCD4AiNQlQ23iI046RFbjJIWdy6MmUgF/qaOOlYlUn?=
 =?us-ascii?Q?zIi6Yr5oegkfiuw/slObeiKriKtCGNi7UkSRWzk0TqrFR7PGUT8uJp+wMwvh?=
 =?us-ascii?Q?bTpHIAviXcabDHZfarN76Ppqns3zmgBg7NcUSP9Q0bodw5UwIdRECZrFK4+g?=
 =?us-ascii?Q?RpzmCLaFWWpVGmPFJEifg4WqorhI/Rs9K06vRNMYXSyz1WtKitUjmpTy++Z8?=
 =?us-ascii?Q?w9VL9KD5tzWti1KXJCPmw7lnCKd+MAI1SDgiMXormzxagX0QwDnhJmrG88r3?=
 =?us-ascii?Q?tFsxGAIScYBlBByFuoHomQGrVWDKBNLiLe1jayFUqX58eU9O6LN1uJXDB/ly?=
 =?us-ascii?Q?zjKG+UlJpS7iz73YPvucCE8Zo/OVKLX7nS/7/mBIBnztqCdNl8Zr/q65wDiK?=
 =?us-ascii?Q?kEX8QXUHDEqxVjo9rYepri+URGp+Fe6nibIHCk9DjIkQXaEPgyS7Bhkz7/i9?=
 =?us-ascii?Q?vsUb596/e61X5URvQ17dRsfv9Qu43BnZWyAPcOOCF05tqQO+jMWDTyVR9uI2?=
 =?us-ascii?Q?5H877m47WB8lsyIi1uWiEbh4Z0/2EixG547EYz+dcbMipFh8P1ScqSsQMMBp?=
 =?us-ascii?Q?uDthzMpVVO/sIhP/DEe/ozFSZtb/S7nEzs8x8oyzmOnif4MzkmFctz6TmrmF?=
 =?us-ascii?Q?38jBj2TuVnUIEYads41Dg07UY0lc3mLd3hBHeNYhkvjHy4NUFKtZ1QSa5y7z?=
 =?us-ascii?Q?5G4NB71keADF4O4PXHLZPx4OXBgJwqUBoPHpGjw+ezommbAAqjiB3imtbK+U?=
 =?us-ascii?Q?bIxTBUIpfC2YOFFLsCVnUnlDmAVPdrXfbtZV81enNadasRAFDJ69aXi6FU8Q?=
 =?us-ascii?Q?XE3UXsvBbdzl45Gtxii/R6RpG6Ph3BKeiV7EZ+PnBnpdadf6Qx0Ml6Je4lLv?=
 =?us-ascii?Q?MeWUOCrD1dN/wig/ZB9v5lrlpLzVmBV/6IPxjYtFI8Nbnum6Nxy24OBps3gC?=
 =?us-ascii?Q?7n/hon+/i1Z53uf+o0oNVA7XJRH49iwOY+D5SjYNRKAiS9OVKUEdtwnuuYmX?=
 =?us-ascii?Q?yp32r/2qJKoIh9W3i9ir5NNp/o7N/DKap2QhPPPoNdzZgVBxgC+C4FTplX1u?=
 =?us-ascii?Q?7UBZmGERY3dHdvCX9HocrE6d6yteASoWiLTuP1rIW6SvPxr/Qu5ts0UYBx6P?=
 =?us-ascii?Q?fhI1Iaw80Ojy0Q5FdPyOz3q3VUA1vaER8szmeY/ApGqam1diCtnbnu+yJHIA?=
 =?us-ascii?Q?MK377HAvP6kJyNnQk4ScQKC68HbMWcw3cgdXpgCT37r//El0T8wBVEdf4/4p?=
 =?us-ascii?Q?2g95+oIhiBEAVZFP91VNncCtvFgACs8YlI+R5n1X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iLWcEgRmetaA86IGl/XR3HKZHgKuNIPFXoFIssomI83EjeS6ETvcTX8Z+Z7x/OGZuVOAsuZOkT4Q7bszeFs6d9g3C+9CC58B4ur09ubqMSzNBNuy+P17JnxGq1Jx/ekiZRigwxGnZY65dVdJYVLjIcTXx50rqSOC1r0CStrWOsf8L+Gncvwnut2EJGi6Xk2fkKqj9y7O7kBQ4FTCPcVuFFN80AMsyl/WDG2SxAnNcOcQJvqRWesQJWpXc+UxJjMWl1mcrt8jk50o4A9LlU+8jlO2uB1sSJAYDT4ZA1e7IMmgYVKTrzJTZ6s7VYDQZsYdHr2kbulck5YKx7hXv1IDjQZKK3fHU3rU8dOuHqcYjC0pP9S352uaYOF5Q+vOmvFb1JJA5+gdOHDZcywxKG5gZWhXVEN9iXXLyDprJSrqjdZbPrc/6hV1uqXm7I9U93s9Q89kYpw6jY0VsLw9CV7wxB0txrEzUPVxH8h58DPyrO2RgoeCx5MYwuswjBxsifrRyft5rMFkS+ptVTADjNqEJP7l9ueQGWBXqp/tm7w4/WY0BzMop92XCXuNo9nb2P2c2mlR0GOLqAnOmMjnoXqjNyu4FQvBxBCudxQDQdCyunB1oWfd2388BB2fZ+Kr0nzWP16A3TPQjk2uohd47tGOepO/sjHmI1GZEspMkeAwTVX5uO01L9F8QfchMdHlgIMzw+tZiWXrw9TNWYLBY+Ig2gdMU630xfCgiGJ+L55tSuApUp7/oHHCyAG2z9PkISqSTsNbwetvH78ZXh+4/T38gw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806ffa32-6cb5-4ee4-1a52-08db716b5f69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:50:18.0774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fKu58Gkpk1U95WXOsr9o5K+JWC3NZiAnOK1LVZhfRF7guHBzrwG0fSmVKx5fbT6QxJ/VXV657M3x7xv/NBO9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=945 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200078
X-Proofpoint-GUID: yteTz0PjIC-tv-Ou6OFtBt7VHqycW8AI
X-Proofpoint-ORIG-GUID: yteTz0PjIC-tv-Ou6OFtBt7VHqycW8AI
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

Btrfs ACL support is a compiling time optional feature, instead of
failing the test cases, let them say notrun. This set fixes it.

Patch 1/6 is preparatory adds helper to check for btrfs acl support.
Patches 2-6/6 are actual fixes.

Thanks.

Anand Jain (6):
  btrfs-progs: tests: add helper check_prereq_btrfsacl
  btrfs-progs: tests: misc/057-btrfstune-free-space-tree check for btrfs
    acl support
  btrfs-progs: tests: convert/001-ext2-basic check for btrfs acl support
  btrfs-progs: tests: convert/003-ext4-basic check for btrfs acl support
  btrfs-progs: tests: convert/005-delete-all-rollback check for btrfs
    acl support
  btrfs-progs: tests: convert/006-large-hole-extent check for btrfs acl
    support

 tests/common                                        | 13 +++++++++++++
 tests/convert-tests/001-ext2-basic/test.sh          |  1 +
 tests/convert-tests/003-ext4-basic/test.sh          |  1 +
 tests/convert-tests/005-delete-all-rollback/test.sh |  1 +
 tests/convert-tests/006-large-hole-extent/test.sh   |  1 +
 .../057-btrfstune-free-space-tree/test.sh           |  1 +
 6 files changed, 18 insertions(+)

-- 
2.31.1

