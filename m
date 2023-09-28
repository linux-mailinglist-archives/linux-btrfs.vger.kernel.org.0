Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3654D7B103C
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 03:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjI1BJt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 21:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BJs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 21:09:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F6DF9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 18:09:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL7RQD003964;
        Thu, 28 Sep 2023 01:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=6wuU00vIVnScP8GKzijGhVd7brBgF+JQIGH6Tv5Zs1s=;
 b=wF3vsnMYjEo7S0Fn3Elh6fbbD2I5Pe4I/MMknoQBay38kxIxNBkXyVuscBSCCr73Uvtj
 wnf1r6jjsoiAZucJ+J0V1R/BTSUzBpaR3JBnWk/b3v3WwhVvdbWoKrBIBaBrWnwgt8kI
 GjbCJeyj+01+hVtzDrtf9gitqxXOIWfl0KRXJHtkrz+6pHTs9VTezBF9A3Lgo2h231EA
 6DqjBc4snZpYFP7Vm6rj9qyiKTQigE+xT///H7o4bokXGxb+31vzyULH8PJsdr8xJqCm
 HEG8DnO1xr/UvB1VVWtviEj3NDnuj9QwXaY72t5XUQTa1DcXGQh8B+sSDw9BlpRI2t+a 6g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjujynb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:09:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RMk8LO035041;
        Thu, 28 Sep 2023 01:09:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pf95hvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGzrZpO36dxmgUNQ8S2oR1hryY2rqGhAbPWoYPLAcgZYtczjSZ+V/J2+6rzId8WEoAKDr/pQcltMyQwsj4A/l+c7yeGJ8Dutk1/OrTzHnso/+lAqz1uGRZNBXg9nc5KtxTwoyeKVyRFGOGctMF3zAFZWRWevDMQFxWLDN+L2GBEpKFZVeW5eqqJrxhKQTN0d5xgvHzK6rlFHnO6vr7v8tfmuXgDhIy2ygljszeJ26xBEmr4TKn2LDd+V2DdDScxlp1k/hD+WMQ0jNmVP48u8FASQ2tL3SWrti6MiJa6M9nrN2liywPGqvLxAdZ8sqpf42terPKM/7t6P4tA2R85a6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wuU00vIVnScP8GKzijGhVd7brBgF+JQIGH6Tv5Zs1s=;
 b=SrMlsAREWzGjMGUxSt2COAC+uVtgJtTX3NgPr5Ood/JOVXbb1yn7aKgmKaAfzhjTJEUrJ+302uwoxf8GCI9A9AzLHPY+7Inq4J1mlGRqIbw36oCCRDL+cPBBsM6qSFy0B9Dq0j6zEgY4DxJM9ZKPnmIWWlh6Rve9v5qmBhlQ3FSEbMsRnA+JQQ39ZdZaQn29ooPnN9EyKXrdamHwtKDdHZvIwHjgViN9OyYJIIk+YLRQ2SmLGQYKO+vPdM3R/6Q6Ut4xMEIWHG67I2bIEaaWPVmsbDG8yJOam5cX8eQ9hVJhDC6MCoDyocooQvZGw4uAppDbEqdFb22rC7HCz/G8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wuU00vIVnScP8GKzijGhVd7brBgF+JQIGH6Tv5Zs1s=;
 b=pwOlY+g50HZ9NvvARtXfR/MLyWvkRt8BRalVEWsR1eSRn5J/aCA/ukHpG5gmeAVhdBh7NaOqq3gP2WB8Pgk9cxysyOh7Q4bZIPZHwEjEg9mOP5PATklT8oaFBrzL9R9xN2f1swNNf4nFQ7eM8UXoaZcE/anXV5DJyaYoVvwNWw0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4996.namprd10.prod.outlook.com (2603:10b6:208:30c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 01:09:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 01:09:32 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, gpiccoli@igalia.com
Subject: [PATCH 1/2] btrfs-progs: allow duplicate fsid for single device
Date:   Thu, 28 Sep 2023 09:09:18 +0800
Message-Id: <9a18c9a1dcf857c3e505994d488facda4bcf37f2.1695861950.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1695861950.git.anand.jain@oracle.com>
References: <cover.1695861950.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 61859858-d0a4-490b-5fdb-08dbbfbf92d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdcWJgJkftmHh6PxcPUZwjqG5mRsgeb0D/bfszxS7oxKcC10m0TsHU5q8UJ1g+wvnePWqy3ZoG47yoxz1xGPaBdyKIeZojpwc878Sr4e0OzzUDFdnuAFhgqBeBwiE7b03payJe+BADSSznwv3DiDnV5LVpZkzijteh66gMKYPgpAr4OeC99r3U1sbA+s1MBMaQ7ZtkXtIIFGebyqgKaZS5dOHE47QwWxS0r3yeMmAZfzkEv9z1wkIp+/yA5vDRJkipzARxPIhJieeSFhUDUnN53q2NbpQpnJ8qiq9/oOLGkDSHhfkjiGdqb4nlJ5eerh1uHEwr3AHrR4e7wVIzhwOMkOYbxfphDVdg/Tj6/hx+YJkCNx075UkrmUSymiH++pfLFRW1IVSAMDxarPs5B5tNSrxMNxNPebD9z939/18WznWZfEJYQPwyoj48WUUd3G+AG3VeTh6goOFnOpHSbt9CoSYUWDLts3BzP1CK114o0qXVVo2/hvW3NbvxYCxAG4i21cefjlOuNUWy0NLQ3HN/OfcHT83rautftoZ7AYFg6oR3s8LZRcOolm3E9t9Ukb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6486002)(2616005)(83380400001)(478600001)(6512007)(6666004)(26005)(2906002)(4744005)(44832011)(6916009)(5660300002)(66946007)(66476007)(41300700001)(66556008)(4326008)(316002)(8676002)(8936002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fjBQuVPaITfw+7vaviZP39oGTg03Db6vVyPbpsUjfQK7QlUuEFPIZ5SQK8ll?=
 =?us-ascii?Q?T8BvDC1Y8i/1pb3coIczXOYPELGRhaSKJuVpFwTcmIv9obzDkF1TF9LHiLmH?=
 =?us-ascii?Q?ZSz2t9efWt1J55owkawKtNK8pvFlZWSzl8s1BFSLgUcptQLkuvWF0U3rYXNc?=
 =?us-ascii?Q?RbZrZ88113ji8zexCI+lxjGTrUJgoTDZ8Sg90NDrNgJ7l+bK7F62uoXSSuJi?=
 =?us-ascii?Q?N2UVYDYnvJUABlWEMoF4y6mAodmS0mUKgyyhacgogbvIGOkxFUZMY+Og290g?=
 =?us-ascii?Q?B7hLxD63mnqZCGfWm4ebSgAn3bhIf51NjxDyNzYY0tZTeQ8nMHLxY6dkY0Cp?=
 =?us-ascii?Q?W80uF5fj1j3Z1eoUxD8TBV1GWQ/QEeQCNShW82HUzHTIsrnaWer8tlEVKOAo?=
 =?us-ascii?Q?xDeA9DcHc/olEGMMGjlgveyceibxg9sCSaklEeUUVnSfO76FMXpXyXH0LMZs?=
 =?us-ascii?Q?Du8x3JVVAB7byITyJNqs3+2OQoDiLxEPqIK4upg5VOnAojIWt8ccFhAciimN?=
 =?us-ascii?Q?5pL2CXIWxG3HEynGyGuTHc96tzn+R1vF+C62vk//xbq4r6awAz+CsUWWCmjD?=
 =?us-ascii?Q?JCifoadVwryKsRGUDeF3hwg6FinlDMFyNo4yKfo1obehyLVp/j8oAr0WORol?=
 =?us-ascii?Q?juM150KvaoYYf6O8WjmSpHTWOCiuLeDnUJnh9BXQWzuRntKxv2UJ+Ns5m+lZ?=
 =?us-ascii?Q?52WeKIKQ3YLpb0JUhFkdFyVuynlXvP3Hp9EtHouYqF6jRRD+cDT90h60WTxr?=
 =?us-ascii?Q?0fXadv0vOXR7UtTjxx8+X47vnnyjGSQLqxSXN2m/jl3xlS7iJrGDNEs6Yd//?=
 =?us-ascii?Q?b6sZb28Md8wCs1EIUY+FC9021vvgrhezbOeSaLqql32BTIDLgXv25Ar7LDAo?=
 =?us-ascii?Q?6lAuqGHmVDsFhcSDZSHjTN3j9GoTXj0Qzzqn/h5ycZqr0R1Xy8ozSCGQbHaG?=
 =?us-ascii?Q?cBYG0gyCKlHWqWpwkN4APil45chAsrEVXIquJaeZudBFYGeUCtVbJbFI7Y2g?=
 =?us-ascii?Q?5jMgP7Uf1FpQFcfJlmaKfPt/d349NSbGn123bfM65VhdSen1GEPH2Hz+e6Iy?=
 =?us-ascii?Q?/YnVAPTnjvMNnOOqDzeFgnMyzRh5m5xGu3s3gLn9jrVQIEGtYU+NC08XFug1?=
 =?us-ascii?Q?3acpXABO9YrQfzga3nfgNOx2U1V5cR+4yrow5U9CCFXS6TZQ5A9JumwRnSW2?=
 =?us-ascii?Q?VOyd7MumgVSqFLO3NbjbKfW3JNz7aogDfXsnmlVnF2NbKcm9GIKyZ+GxvghX?=
 =?us-ascii?Q?Qn+COEfuuBq6jw9kgXF3omKxdii1yqR2yoMBx+675XxD09WdJvNUz4658o4Q?=
 =?us-ascii?Q?Bwc9G+2VsSdeUyHp7ce50piKYkUgEcNo9Vvrpc6T8QBulaTbfjffLcM8Ab1r?=
 =?us-ascii?Q?OrTCYhTHWmR82ho/KLsf+LAgbAgEm8OBvO+O9bc7vWJO1HEJANtSCbKqsn57?=
 =?us-ascii?Q?phcE5AKFD4AMEPFf0iHYVVKGtuTZbp6+P1hE8D6qkmY7hHBZYuRjQVoPdi3E?=
 =?us-ascii?Q?1DDd1tjSdxSmXyPXTYCEOaNn1W4ueEowTL3DmH4a0wk0xE1XBV0eWI2uMqcr?=
 =?us-ascii?Q?XhA0DNnckJ6Va4QWHRtN20jMNDnxKBB+fdmbDJq3riaw7/vTo9mz2CQxgaWW?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BKltix+HrFC+1fb3o1y/rwwO0UWFLekav9RHVS+OQv4O4qlqwhvTJo1sbrBeM33aRNCeAjYCyJnNeXDZuTNSMfEyOBlUdPR98SiembmLhUCzePd/ejA0OIRXzTrDTsOWrK5TvbTx0kBXDMbl3nkCrXjoYC+Tennj13CmIjPT147+OIo+9MxuMT1lVHa1KpMQ41R8dzMdMoK73fkxYHLCeUezMfP53pyC1TBgtxRjB5ZDMoMf3EW75H0EPxM7xgvBBD27PuLGwCWuOU0dhAMiFKnmJcGTXpK67v0Bn+21YPIv9woZk3jcN6kcxpND63dl3buGaEh6Se0ITnh8ZeKTS73XWEPVjWaqd/Gh2N3S8gje7DxCif73L98jR1XsYc1MY0cGvPLlcUsej5uvL/qD0zRoFaNkXYXxB4XqPXiSK0hATUSC6cimtDP98qzKhGiFENvc4YZcMHQbm/sgex/H/SDP3la9XhqAy7pigI0TCz95+OnIK+fPRcbsN1/cHaUZTyEA8B4bMCFVDK+mRkUjoS+i2dgZU8THTvOpAosF+9GZKGcYdyd0JPODn4/WeYerI/Ed6UXWRwJkDtiyzEFFU96b71sW1z8R0zMlgMwmZlHRI67mnHcSUm9ohZAWbFbukPlQzo/HRzU0z09VPvNb3Pt0QgWCKIeLBs+GUXyjcSXP6TD4qHpKMQKikr8/3fniSfguGMrNsVTy4ifXamc/+mgVQDD51Tz3IZvDYXrB2giBG/V6F+zezC497YmNGrUtuEC38SztDRi4BqAZLbET1v4Y9jPM/duTwcpA/E3b/lx3KkhjbjGxpFalSm2HRMqH
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61859858-d0a4-490b-5fdb-08dbbfbf92d6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 01:09:32.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYZU7oYbGm0LMtAx3NqikR7aGefUqWLr7HlhmP1PTVrbal3vY+YK6eh9ZdNQ1lHFeYFqtBHMM24sSt776FV7Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280008
X-Proofpoint-ORIG-GUID: ThZmKDuVc6tQHyXRkokKQQidsMRwdAX0
X-Proofpoint-GUID: ThZmKDuVc6tQHyXRkokKQQidsMRwdAX0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For single device btrfs filesystem, allow duplicate fsid to be created.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 mkfs/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 6b38f8079bb4..68ff5d7785d3 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1321,7 +1321,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			error("could not parse UUID: %s", fs_uuid);
 			goto error;
 		}
-		if (!test_uuid_unique(fs_uuid)) {
+		/*
+		 * We allow non unique fsid for single device btrfs filesystem.
+		 */
+		if (device_count != 1 && !test_uuid_unique(fs_uuid)) {
 			error("non-unique UUID: %s", fs_uuid);
 			goto error;
 		}
-- 
2.39.3

