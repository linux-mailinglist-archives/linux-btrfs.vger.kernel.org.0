Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF34691FF2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 14:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjBJNli (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 08:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjBJNlh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 08:41:37 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6721555F;
        Fri, 10 Feb 2023 05:41:36 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AAmxEM030886;
        Fri, 10 Feb 2023 13:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=X3VV3tW0Dj/cUxXxo6AwZ05p2C757Nf9UZKWsw23wxk=;
 b=NrM4fgJBCHpSmoq/82rXx96gbHzicmqwslWqL+SsvLuVOfkWbyaT4EBLTDnw9yLNlE1t
 thG5g0LPpXJV3IcLIPObg8lhdW5pL51ZCAmWHG4xnp5eI2PlDjY5khc04+LfvdhztXKB
 RLFGcRDLehtY/ARrykKicJ5ZewteBNx35SHn+fNYr3hsDgq7WKwnWttZVo3OhA4GAiDy
 ibbJIyCGhhdteiqPIKnpo7xt5ahuDDajafdnzrVizoWXkXJUgbeTY3oeCGt7L0eePz8Q
 pQeVGaRZ5vRUE4ykl/GkF3X1gLNY/vOM5oM6jBfIaEh8WjPaP/0mGXUj1EAVtBLpIXDS jA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdw716-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:41:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ADcpop015142;
        Fri, 10 Feb 2023 13:41:32 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbesyr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 13:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTHd+LuupIDycw/MtCJXRuLVIVQnGG8Hqim6k57bvHK5nX76MF8yv6vF1ACNWZNQBDg6flPgK9mNXiQv++iXAMEE9z/qTV61n8EMUAL0Q82t1/IE8nOU9Zmk8RGbGijWkRbyK30J7ulLskpysiB1acnkBXxU9hlO6pt3gpiT9kHxaEO5W/5HDTWPIvwzkbQdG6rDSYy2OWWvMjeXkRQwQcnHEH9VV+TcS6dzmjmntK49ZPsYtENe9rMV5a5s9mBfQXsyMLBRx+jb5wUpP1SsGk0P0YlqL95GMUTVSQL/8Hs7JPmEvol5aBtAP5VHhx+JYZ/pI3Djj7IgfP2JZBcLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3VV3tW0Dj/cUxXxo6AwZ05p2C757Nf9UZKWsw23wxk=;
 b=WavddJw4Bz8lRi13W7v/lvf3qhRolhXbBAUMJEMRgV5hWE97GPastLUiQpV3IKiIDF0fSdC8HybsBXTbpZrnoKj2XdsuTyRZn1XdUYde6qBpNMTKEWTC7gMG0v1oC+ATtwaQq/ZozyaZ6/w4mRIUq8AXbRIvKjvWK4EP3CjrCnX55tkeboRrsMsz8bPILa22QNPPoeblxwkWkwxqrUHumRql+c8vhE2qTugz/W91RMNVB2tWjQGWw/Be9SMoj65h85XQJbzZz8ERvapFbbD8o25ijnF87Qi5vbhxT2bzQLKxQjHhhDD353ePXrH7suE8j0dX8aS6xerBZuHHjHh1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3VV3tW0Dj/cUxXxo6AwZ05p2C757Nf9UZKWsw23wxk=;
 b=GOD5iVlYIZoHJZLvsGZMVgQl8T0vFCBbrgsl2yBePFrpPvpQrR/arw55JWOBhCR5pmqvok0IS30E8VTDGx1NVq+aTrG/kceUMhkxKLsDwbjJ4JxPUYJ+UYit0fH0n0bK5WtP8VguQo6FbHVFhlsXWS5m/dtfKihy+A6KK2fZN+Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB7285.namprd10.prod.outlook.com (2603:10b6:208:3fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.6; Fri, 10 Feb
 2023 13:41:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 13:41:30 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     zlang@kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] fstests: btrfs- add _fixed_by for new tests in the auto group
Date:   Fri, 10 Feb 2023 21:41:18 +0800
Message-Id: <cover.1676034764.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: b963bd7a-27ad-4325-5c77-08db0b6c8401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 538Fo224mDuirRcnCpFQ6lLjjD3oY+UXpajlNsAzh3AxSEempI+x1YG1fLbpwbR8BsEuj1mFXzsnibOFJWPI7X1bQ2Y65MkKCapEGj+4sRGdcv1tP4tEXIXgLBasB9Tplb2DpESrWhlGuQGO4VC4E2L9QLBdFYEEJiusSDlO6c4Ph6Xr7KqccIWEcD3sin/Jfgw3X52Bs0MU5LYdYfNX6DmxgPI0MM50NkeDGS4nhj0TeC036rhObCCJRI5JdxJngop7VE3fCMEBlLUDrHBdiI1r8Vll+ypruJ4eMVHmwVegkR5h137+h7M0af1Hs0ZFDgny2KlGt0T9I5Voez1NbewGmGUl3iJSd8bvZUQhtPjp0fZugTRcxClvKahC32U4TntGQRRtC7QwMyQ6uB7YyNuw9sq4oNU3BAtXkGwmGirCHUkbue3YBL4hllHOOVCaTvuUWePcLYYGbOpX87Ez7UY1L2ph2J8z7O/y1Nv3L+v+b45mB3y60PJxsY6IcmDAtDuC9k+dpq+b60zA7clc8rzlMjRmh3NoDN4W6yLlwhUhiZQ5su1i1kB9lGECjjbCc98Y7eHdl4zKsd82Q/4FVP6E6fNc5Skih4tFIEjw9Hsu2rXdm1Ks3mIGdKcYqUe/RB2t4RZWMGpsGmv9Ggc1OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199018)(36756003)(86362001)(316002)(83380400001)(66946007)(66476007)(6506007)(6666004)(26005)(186003)(6512007)(478600001)(6486002)(2616005)(66556008)(8676002)(38100700002)(8936002)(4744005)(5660300002)(4326008)(6916009)(41300700001)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zmLfQJVPyuuhf6mCRdY7zDLgwY6oZ1BJe0dpaMkthQ2Fuj4gnpNFkdMz3tBt?=
 =?us-ascii?Q?02UIoQDu4hpWv+7t8dHs88katNa+qZDJOXe4VJv5jO0fUVzJonsc1d39Ik8l?=
 =?us-ascii?Q?nZDMn5MlmbQIP6kCyAWh1NkEAAtKzWGMppOTYlsfkiMJXVnWcjBwipY4F5Ol?=
 =?us-ascii?Q?7pqBxawcsCMMUiB0eSHTnbvIKTJwCi7Z2aMeVgqsw8xQo9QRhNL08MHqEF4y?=
 =?us-ascii?Q?lg8HrarPSkcg5buAo6UwJ5xcQpcsEqCssnbV71L69pDp8XqdvMSAm7jkDo//?=
 =?us-ascii?Q?pt9MCuLKjiYStY3+MuyotccuXlWT/vol2deMuEyntjpv6bRnef6Mov2GbkSO?=
 =?us-ascii?Q?IGpdbpX+N/q/wdlxq504MDrVBye4DGaBDdfb+Q3yQTZ+6Yo/H/7+ngEAuHGM?=
 =?us-ascii?Q?nbMSaSRtLrfzZ8SUlYDNdwqQBHVFSn1kiVjmOjsTsdPYyYdx/WUJ6537dC5Y?=
 =?us-ascii?Q?/ZBbCrR4WRYw1Pu+kBvWmwCOC5BEUIcSw5jk1jYm/+64Im7RMhtyUJ4yEfFF?=
 =?us-ascii?Q?2W3HPlVDP3T77GepG2TZu2ImL1pNSEhsy6VYgNXEbvn8sTIWo3enzEAPot9B?=
 =?us-ascii?Q?4XAN+ypeG3CqIBAayCx6Ak0EwRIpiGea2pDH+Xjc8qIIIvKpqrhje/p1xuUD?=
 =?us-ascii?Q?6hIIdByET1WPqlTXgBUGZsE990izwoPK3x6L1CeLmfevohFceAlneAWVMoe9?=
 =?us-ascii?Q?8tJV/3XizHaHyW8Q0eIJHX/PSsxaOnuUjqEGobg9gTu7BMdYRsq9/xiu4PtS?=
 =?us-ascii?Q?inK35+G121CVipM1gXYRAiEGKGX5X8S4LZy/vCoUL9u++MS0kLfqnbSjpvgW?=
 =?us-ascii?Q?zo77LbJ69tVNjfc8AS/pEhX/vJQqD+BPnd0HWK6QDhmcp9qMdfAIFrv5ehqe?=
 =?us-ascii?Q?F9JxM4U5vX0WMKoCL+yR/NnCoJV0lV5vw0IL9TiMV1t4woxEuGc9ajJHlt8X?=
 =?us-ascii?Q?njTQZajzT8a6VfsSiZ9yZIiUtLzSTETF9pHcvZrmNJXhKpAgwLCXau/CSOC3?=
 =?us-ascii?Q?PY/W338ADa2yKbZS/BOsFGTJNtLx+NCnbpdCUStvdj84VJY81ZfYUy1fVw1r?=
 =?us-ascii?Q?P13XN/2N/ziangxGrEMDtgGDToZDM8Eirpnz5o279/Ryh1+c0LzsN5vaUkzC?=
 =?us-ascii?Q?sZv+S/+QxOfIJITrOsXifTEfV5TJcMyfTfl6WVdn3mN3tcIPU8Avcpg2T7bt?=
 =?us-ascii?Q?tibk5+xvS5Wr7tPco2BbOwxO/mB8Ez7yrh1CPqCUJLXcU/htzwJcJ+Xj0Z0X?=
 =?us-ascii?Q?AGRQLXbho0oL56FH1r27pKMRPOlHSRea/bAAjDvkvCRdQKzfqf+EjZdcqnNW?=
 =?us-ascii?Q?6hvLzTPN1NbWHQziWSwoFgkzqJ3CLVJ72sF/8knU+uxAmH6EFysXG/BIcnRK?=
 =?us-ascii?Q?0JNXLhEgcTXDTxUV0U/T5filvwNvs9g8UUsmJeZ+KwHObfwV4G5AsnAuzhEw?=
 =?us-ascii?Q?vjRaa3hXNzkue1Kse9s4bs3iLrTTIvNOGd2sIJ9D7bO9eSGNMhRGmWdIxLlv?=
 =?us-ascii?Q?ud8mmkfVhEmtMsuKo1lCxZFmY5EKwALhtPIkXLg9S7qaTwIugtBCnqdb9AV9?=
 =?us-ascii?Q?2Hpqrj/+6yDtSkR8iJdjzWZIASnH/3+cT7vC/DV5mskRtyIvE8SYinccGk9O?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FnT3tWDhMsSVU9FSqPMfBwpEJGWHZdrnAH4lSi6ZAf2qQIs29kYytBDWJP0vx43X6m1HRkY9C2iWuM6Sojlmo9CYIbJpFnnKoZx5a2CfJ93aLGU8OHngloIwchdhyMHe/fCt0u0LaUkMdtPE4ImN95EAspfuIpo7p3f/giEc6gFsuH16DYj2M117cac6ztNnA3plWn1sY7xBpjAdkBTjfEQlJxdifn5X1+eLXw25+bUCgo436x5i8lmEQ50jVSXH6W67sI8h55KcLIV3+t/yrtZc0+IYQsKI/twMrsU9vewoMtQ89kSP0HYiRM/0rplPF3VBsNY+hkujW/im+uwg1ldOLNvLbDMFWr64z6oGhLeEwBJn30SpD07Yxd4q+YmZVZzAu+xxmSGa85zZK3FO8LrqF1ZEd5uRK9y9NHyDTL2TBDM/US4/mwVE8/9F+MtaO8A+QYb4Oujg8sB+ug92nj+2FOWmsNuPyDs6+oRqUEr24ujJJZ7jezvHn6mcxt3kcmLJnyjR5V6+mhuGcGwGv6yNauWX1db2G5DS9bG2+mIRPJFIqBqHtE3ysU2HoAdFrKPgZxSQ+Qq1NWOPJRlt7vbRtzsYMju1e6R9opm00K6srl1/8tF/ciUW9Y+oEgHudghPzfk0euuMQNHGg92PwNv0rDy7IGSuOBd9Yo2DK7whoD6bEZ9oMyKOBmnJBXdrpAb61EtzwqcghE82HJPBO3Ke4UNNXyHu15Q9b4hoi9chubNdUuwps7rkPVRzOv/u8p+Yw/D4Baex9v9LwwZGr4i4mMeUO3+6z0hohJVuroY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b963bd7a-27ad-4325-5c77-08db0b6c8401
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 13:41:30.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eyq5/2zZf7iNiMmKbuHigIBDekUgomTPJarL0xaRkmsiPTBrZyIvLEm59nNPfToOtPvF7NU2l0gaMZ1Rfu4L2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_08,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=812 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100112
X-Proofpoint-ORIG-GUID: rMTPWYXCZgtb3howx5vt2nuWOVvECXFs
X-Proofpoint-GUID: rMTPWYXCZgtb3howx5vt2nuWOVvECXFs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From the POV of running these tests on older kernels, include the
_fixed_by_kernel_commit attribute.

These patches are to apply on top of the series
   run more tests in the auto group

Anand Jain (3):
  fstests: btrfs/198, add _fixed_by_kernel_commit
  fstests: btrfs/219, add _fixed_by_kernel_commit
  fstests: btrfs/185, add _fixed_by_kernel_commit

 tests/btrfs/185 | 2 ++
 tests/btrfs/198 | 6 +++---
 tests/btrfs/219 | 4 +++-
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.31.1

