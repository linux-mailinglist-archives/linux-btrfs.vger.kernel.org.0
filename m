Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF97366AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 10:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjFTIuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 04:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjFTIuv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 04:50:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97DC10DC
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 01:50:49 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JNhhR3004103
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=CvGvho1p5qlgwAJj/ctpctfgqi71FXrLQ578GSVTdz8=;
 b=B8qjxEw8hbYxCQsS3FrENkufucNEXNCd095PnduMKsPBZisaVsv1jZ/0U7xUX8bi1xAY
 UN+J2EWn+87znGvafhImATc1N5ygHxgTQcbEMqrl+XozWrsPCGyR0SJJUqhsloh0V1Dw
 Adp+aRjMyyTlrfLKDoYYxa1xIVoyrF0l1JY74oiY6D4ELCQoI8GqniJRXAL4R5e/3Zwy
 LBj7f6wNmyoCEd5RA66/x3pA1Wg+Ffnjy4pwyLiWUMOP3kZCseP5Qkwkl74ShTHn47yH
 36I+9LecnZ0/32q89OzD0IglzmulZ0LrdlyPE+56OMWAopAThZ3HBEdFc/OdWgeeJE9k /Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94vcm6v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K8eHKj032868
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r93959fg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 08:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+1FCdleKvjtK9ubVFodhow+1iU0UDLZchBaFTf4fpmhWQgQfX8sOQQ2917BtmITu4ZGKxQNyDJoBPhsj+jhiwR0d3AX1MC5CsMo/dAjvyAQF7eJb8sIj83ZrTcKHp3bVQE4H7KXmaP69D1WhSz2o+LocReJB0uE40NrgNpK3ai9LXplatuMK+63+9+j5I8ZyXNhfMg2E+V26kggXCEmvqh1Fgqzm2x/OfB/RQXwVFXDk5eJyIlTMaufLx+wD5z8TCQShq8qhmP9AcjXnGNqQKBCAOLgG+OgRkuUpQpcju5vGycIDel96BcOjh9AYcgqXWcusH2rhxgePVI2P/WNTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvGvho1p5qlgwAJj/ctpctfgqi71FXrLQ578GSVTdz8=;
 b=Zfj3G3rwlyrB1IChPn+oC+oPWSLIyzrkN9joW57J69ntfy/sKK9Nw88HRFVA9VhdxtdAmwxO0JPj7no6gXulZPZ0X3620KKzQXptgN1YUJonMXkc+64fClOt+W819vDL8X3+897n6Ony6bgKeSWTIJZqdbhK6lIxPQNQM6RUxeZj+IR9m4rT9TWxl1OtOrwI2pL5xKnVH3wtOrusUz9TYytwDX9G+LFnwsmFm1sZ0IdqupKjNWeIcqUCBURtnW4xrrtUrD4xaYe3TCEwdsOCfVNZ04YOoRG7ho+l+ki0sVhm1+BV2q/pX/PrMOo9sWcJYWxnO+wJEN7WmNPcutfipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvGvho1p5qlgwAJj/ctpctfgqi71FXrLQ578GSVTdz8=;
 b=YFOXxIm6EUg2we31euuN7VDPIkw/wfmJVTfIWqB8UG6Ca8Bn5iVp3gw1DPKHs9xTCwdwousK41NoAsTPZmoE4uOtJhH0/ipKUtsmqkLpfKC4ajT1NBUUU9qK20fqjQw43TZKJUZDzWu6L5MsCxk9cYSE2X6RA0Wlj3tZnj+W2QM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 08:50:46 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 08:50:46 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 4/6] btrfs-progs: tests: convert/003-ext4-basic check for btrfs acl support
Date:   Tue, 20 Jun 2023 16:50:00 +0800
Message-Id: <a27501df1f73789cf98aa464137aa12b1563f8e5.1687242517.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1687242517.git.anand.jain@oracle.com>
References: <cover.1687242517.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 77343c83-2bba-4c4c-be4d-08db716b702e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GENXvuWnuS1XNfDaS0JfFfI4KRDV7WGGr28OY8W+T7AenozevgKPKkC0k1IPJY9KL93BR6nE57jvP77mLmyQ1w20+mGm0npQxJ++o2tMM2AGWy9xsM+Inxlv42WhTVdooGoue5rGynNMbB1OArASkgiCZLBnQE43MZT7RbUszfcisnDWAAiaGrVAKpU2cy8dOLtUdpStAsbPPKOA++x725eBTHdfzTQEBvbNWVItoYN7jeHm8MUx5mdAeQ0my+USRBzoWUqqLWm3/7rrSNd32664WLDyBcHUwks+UtffOX9Tjis9VYcTgD0heyQoZz7Vym7jC12JS35+++G8Z8W6n5E41FR3OCKAtABKVBPJn8khAlPj/4gtNDf2bxdPvLYqcMCXb5zOhlhW5kCGhVBgD2N4iA+1rHO489feYJ+mikhGazG00PPHY1Lw7dBx5Otdg8x9bxqM+QS2Pk2XwbvGiZc7fSmvBFfLmPm3NaBrp9ny03WEqby0uhlxXiipU9+BGaJV67tDtCmO5XidEGySZF71FNIuo1OzOn14EOXtqBbbrN1fvkTDhWI1qEotFy9d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(6666004)(6486002)(478600001)(186003)(6512007)(6506007)(26005)(83380400001)(36756003)(2616005)(86362001)(38100700002)(107886003)(6916009)(4326008)(66556008)(66946007)(66476007)(316002)(44832011)(8936002)(8676002)(5660300002)(41300700001)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PVWBnU78KmeGngXC3ut5x0iXCSpRbJZ78sbQbvb1Emj2kW/U6sfeKOFUj4p?=
 =?us-ascii?Q?QNZt1ox1klC1O29Zm4PQcahdMnIzHvPRMeW5P2gSO4+i6OQLPFf40/fCmusw?=
 =?us-ascii?Q?ZJZe19eXeZz4kW8okEnQvADcjfr6k7xxkL0CrFm6NdIuSnB6KfzbInyFqPzK?=
 =?us-ascii?Q?YeEubUyU8c//VvdTVsPU7IuMGQu9qJbKJ9xk2oykTMdb9F19aP/gSObhvX4n?=
 =?us-ascii?Q?r5f6yb3n0QlK0S35bPBL0Uynj1pwOiJdMGRN+/+0dW7KR35e8rMxVW5KCqZm?=
 =?us-ascii?Q?dJtOBbGemR8/+i1YxDfuu6oeTL2Doel3wb731feE6NGMc05q/6l9uiTarrkv?=
 =?us-ascii?Q?EBnAx0nn19PoyFhdz7CitEIEMrE/GXeEDX/c+EmULKXG9hhqaGp59l4ngAcV?=
 =?us-ascii?Q?85rRU/j/HMGA3gk1IRyR8W9KJHWeNDP1MYwSRkpOuFtw/n9URKPSAIyLwBWZ?=
 =?us-ascii?Q?sOnOS4PFjNBTIhGrrB1k/Dld79bUR51phvCBfpeg0cPDm+lTFrNE2EyBkocA?=
 =?us-ascii?Q?qOG/GCZbcvy8R4canjmb5TAc4vCYEaW0caOg2RLEeuKjhgRTK+p+SAfBzYhS?=
 =?us-ascii?Q?PfKtQ5XDBD/t97EmPKh58m6DAXwV54cA1Wsi7RLFpl8Brnz2Pp1Db9pvz+W+?=
 =?us-ascii?Q?m0rCEt4l3pxUh69kUxLoL7tAC9gWX06ojAKhDXz/bNOCwNzOaRtd1roRN5TR?=
 =?us-ascii?Q?8h9vY4LZLfH0gjbDQMyTX7ena5JWiaMyztCqVQsFMQLeQCfkYf8SuZmNrIib?=
 =?us-ascii?Q?GE9wvTPeOP70NIhcnFf/IUFKTwCuRtohPNCoAWBR3+FJ7Qm6YS/xbjg9MSzR?=
 =?us-ascii?Q?Qxd9v1QwGXceCRR8u0uSpNFIr/VlahWVs78lJwj+KDtf1ljkVMxqllRAUqWj?=
 =?us-ascii?Q?Gd9wYuVm9xA+B//IIFkCaulzPm8aVcSLmU91GG9Max4kNEy8kkrM6L4E4/TH?=
 =?us-ascii?Q?MfIQfDoQ+tLLdmIt2sOlVpwKs3ckwCicliPraUmZy364ZOmUETq7he+GDE3c?=
 =?us-ascii?Q?A5LspCRTfmcqtigGYhVUb9zpX7DrJiVroncSl2uMHCrM3XpszD5nk+yh/8x6?=
 =?us-ascii?Q?mxl+5tejIVV6EqWoDlUT7L/Ifz0SNj07OROfDePIqZpY70tPP0kf6U0e83wJ?=
 =?us-ascii?Q?EFNLL7vNKDLiq88N2P2Lz6ofLZdzm62l88q73QQGtINM4oEXCMaZ4DoWyRw9?=
 =?us-ascii?Q?kzD60uA4a6/Har/jUBaFlSLmOos4/l1pgUTeiW7czdpH7jJWGXmz6NK9nLIq?=
 =?us-ascii?Q?O51DarQZORpU7s1PwMeiGx3BEsDyzQCoy0uBCIZPsvLot6F0bOvEZtYLNtCu?=
 =?us-ascii?Q?uMQUyTiE2/L2hpOKQR0syFFcIcZprrE1M8ReWr9SewJvis4kfCnpt//2F9ye?=
 =?us-ascii?Q?Y2iPnFSqgUa8pVwg3chkMYzC4vGoVkaZbY8iW0xv0LaQ1/HYzLkD5q7Q5PBs?=
 =?us-ascii?Q?KrnBEk7F6PY6ETLIACeBcid6NsZZliYzGeqoGaf/LqWaNU6IQpH8u6L8M1j7?=
 =?us-ascii?Q?qITwnA6h9zYbUAVpX3o5JmVi3e0TrdefwZyYLCs3m22ih6Mu7FSgpIcsTyCc?=
 =?us-ascii?Q?jLx8n1/+8rRVD/kgcRu4OFzkgYIsF9/Em3gQaaYZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MkOAkmZSX+rfU8zQ7qFSLZG3kpV0811kYbGJPtIYIvMgyhTzFjUhT/bmm0M537Om3s7SAxLts1kOYQR0Xe63EbZ/q1v2gCMVbvbaMw0RBUkKwJz33y3V1lUmicsJtwWakTWFLFfiBhpV2MDy5jqA/GeD/j/XichqIXsncjJ5snfVrkBljXbeDx1zi8wgh3fONaGUZNf6o+s86DaJPwSk87iSB78pMJKqgv7Rzwd+sBZd4JHMF6ZRzZT3ONZ+flDy9k4PirZhrXmmqUr+3cGTcfWBorUGHU74ydRFwpBHlbZ8UyY0IPNi9eljAtFW7vMkT/xl6dyicNA96LSUxDs/5WsSVUqKwZtF89ft676URFmnK0d7SNaiy0aEF1BcljwLY6xrVr2Pab00xbyCaxmHG1GZsUoWMl/qCvn+V9tPyH+1rsgLvFWPDCsk4nsEpIotNjPRJ3GJaSx4NwTDu9o88SAlsRkqcSTDHNfUhyywif6TJ5I3dZuM4fD2TZwJwLE5197Gv9l36ByKWqow4g0EWIiH97sLTTXY57ZUTZevi8ct9oDE9KOuLaBeLt7zWhgyRezMYhrJt5ixEAoRBnKmhPBp106OVVDdSTePe/NR2XL91jMccdsnaU7jHGkhzbvSCryo7be76uzZyyFBXy4GgfwP2g0huwlXspwEdRvC10f7qOfyTlCL4kVcI1AOzZYZOpwLUKqdTcULWv/jQj9/2bMRW768Oq5XmxKu7eqmoQU5G5wawnf/zkXPY5pGvrjG/x4A/zQcx5eTVpH+KY33bQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77343c83-2bba-4c4c-be4d-08db716b702e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:50:46.3229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FsvCiMcja78L2a9W27qyCj18b+xQ5NYJ0p3v51sPMrYQuYL1VBSMRNo3x6rewL5ZvU78Z4SGWyGbv0n98fn5ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200078
X-Proofpoint-GUID: 3lsZGXRZTKEk5nBJaYj5wb9dvv20Mxs3
X-Proofpoint-ORIG-GUID: 3lsZGXRZTKEk5nBJaYj5wb9dvv20Mxs3
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

Fix failure due to no acl support in btrfs.

  $ make test
  ::
  [TEST/conv]   003-ext4-basic
  [TEST/conv]     ext4 4k nodesize, btrfs defaults
  failed: /Volumes/ws/btrfs-progs/btrfs inspect-internal dump-super -Ffa /Volumes/ws/btrfs-progs/tests/test.img
  test failed for case 003-ext4-basic
  make: *** [Makefile:477: test-convert] Error 1

Instead, use check_prereq_btrfsacl() to call _not_run().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/convert-tests/003-ext4-basic/test.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/convert-tests/003-ext4-basic/test.sh b/tests/convert-tests/003-ext4-basic/test.sh
index 8a0b2e333554..911d03006be6 100755
--- a/tests/convert-tests/003-ext4-basic/test.sh
+++ b/tests/convert-tests/003-ext4-basic/test.sh
@@ -8,6 +8,7 @@ check_global_prereq mke2fs
 
 setup_root_helper
 prepare_test_dev
+check_prereq_btrfsacl
 
 # Iterate over defaults and options that are not tied to hardware capabilities
 # or number of devices
-- 
2.31.1

