Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2CC3EAE52
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Aug 2021 03:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhHMCAX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 22:00:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39860 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhHMCAW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 22:00:22 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17D1vMw9029444;
        Fri, 13 Aug 2021 01:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=0vRsLyY6G4abi4FEb4lsqZ9EwtzkCWCytQGmWfdRgtY=;
 b=zD0JdcRWwsG9IABfiwfv+jfPv4Jv12M1uQZgp3jkfqjV1sNdnlkZ94c0pTvgauBt/F5D
 L9c9WXYBYMeiQ6FEf0HQoaUTFoL81G27Y1sSiagMCy5/07YQopSCWYciA0VjeHLXGmLv
 e6nulLatw7eZWKT3ZgYsSrQosPGegqYUFRucayMij/3QdyRkD0lJ1Ayph4LITQ8hQjgz
 SJnprOI5AE84bzreIHy2JhBkeFEGOyQG5jumx1hn9dItp3YfYJyBt75+dwmCRCORle6N
 a9vxF3peWi9nB2CZfBsGE48LL3bUIhWLdacb7+lmSFL32H2cQwBYIp2IXdeRFseE+8Z1 ng== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=0vRsLyY6G4abi4FEb4lsqZ9EwtzkCWCytQGmWfdRgtY=;
 b=iAzaPRssip/Tt7q+ogH/ehBGMcvDPWJAyQ9zdKvnNpGPEB/NffdXB8ueJPjq7igsSHUr
 TSXBq1xhzd/SFGv2xvADLOaXTx90Me9tyt+EGU57raBCdPQk0fqYhqzdT+HV/5OC0B8K
 4ffWp5cWlpwMDejZ2v3X46C8ATDCiNcPK3d33oVlqGSYrfQK05B6QC5lcyT4oJScCma6
 Ihup40w15h9dIqJS1GNqfuQ18kvG77+zF9kC8EjNMkb5IXpTazcWwlxqS/b+Rx3FtrmA
 Wqh0pAoc6TNT07Vl9CCkMqOp7CNIPXt/5Qwdj8L5JShgzZgx9JFdxqzvbXNjyTfOVFPz qA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd64cbtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:59:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17D1udRt112637;
        Fri, 13 Aug 2021 01:59:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3abx3yv9md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Aug 2021 01:59:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQAzVG42cgYLta6w+BQ8Bc/lVCUsqqWJg/L6YwY262JMbVB8saFAzfA+svTH3E6lSCTMUZv+bfHLN4iZSsMSNEzWrNojCeBKXDt2GQ3fhgtwPLxE1l9WBsFzo61+OD+9DF+W3K3GubDQICIOVV4UM22WeTAOItr53YJoHHFvjofxVomD5H6Dn/ElfoJ2DcsF7rK3N6XzcK6hak/hyGAmFafbk7SkF4QABknUYPFsO0VG61v3mf3yTV3hISmDihmKjshCeaU6x/ffSG4uc0MxIjhyr6JCYQwj9BDzH6xqZsnZjZso+DLcEFlbr9u6Bq+iS3FKtbhYfM124i7Uee6q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vRsLyY6G4abi4FEb4lsqZ9EwtzkCWCytQGmWfdRgtY=;
 b=jGBtR++SiCK8cULfx9nWFnEgG4j6VytGIuCQ2fLVu8E4R8lQ5VUGj/eEFon5kTPp0lg8s+HINVWVY0u1zZl+YP2u0qpXSxbo06tu/WkvURDY9XbvI8jMO1V4t6fvaUzo0PqCONCpmTFIQCufU27CQh5ye/GdcUAHKOMNIXw1rp4Z8thKEkEYlkOmG1hNE4JLw+RarcTlIlaNXSQoRVtuKdpYEg5oEkivbJTkeZN44EDaUwfyXVS21ccrTp3CmSMFVZfC6BEcrlA93iJEH4KNZvob4TXo7BMtePWh2Yf7HsAKBsCTQoUAsKxboYH4Rq0blZVWOBXhPU14dYfsE8tkBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vRsLyY6G4abi4FEb4lsqZ9EwtzkCWCytQGmWfdRgtY=;
 b=rsp8DTgT4ZlJ5nta20LmocF6TbYmrZoGXtXHzyT/5qmijVpWCUiuwKFVZn7XHLmBFqF6Chd8Y8h8sWkkXVZLuNjHlNI+1w7SGvbV4Npq2gEHusP0hZfbQDJ3daEnKCI1iRleEK8jZpCCq4+HuizPEP2/vSHCUsl49evIT7McAxM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2771.namprd10.prod.outlook.com (2603:10b6:208:7b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 01:59:53 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%4]) with mapi id 15.20.4394.025; Fri, 13 Aug 2021
 01:59:53 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] rc: debug add _scratch_mount_options to the _scratch_mount
Date:   Fri, 13 Aug 2021 09:59:32 +0800
Message-Id: <339e6b40db7628a8828c78f49c75d12e375d0004.1628818510.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1628818510.git.anand.jain@oracle.com>
References: <cover.1628818510.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Fri, 13 Aug 2021 01:59:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e4cb6af-4733-4108-8c50-08d95dfe0a47
X-MS-TrafficTypeDiagnostic: BL0PR10MB2771:
X-Microsoft-Antispam-PRVS: <BL0PR10MB277181A0AC97520D00BC809CE5FA9@BL0PR10MB2771.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ow8kInkNavAwXRoqy5Ke5icd9kkarXi/kz3UdjEX1a1+oCwDkf6dDzYcS+j2nAhRUZTOFBtnQcFhFMWdni6p3nA2ZXGoNfVYcsKSCh/uel0e1+TXJlLmHe0/w+Y9WI/8F2KOPrvQa5A0liR/b8c72vA/hBaprMeaWMMBud/8jViZSeWXK72BCcN71rHyqTnCNA9DxaAMVajDj803MG745DSOULsUr6kpzgdRWYJ1gcwj/MAEtbATDhDsELWj+O+pPaJlq9j0rRklHuyQUCav1E0B7jnwzqPFxm5BLvzi5mY0S1xFSJvuW/257YvDNTXL0X9VW23TU2Bwly1TzzhD9aY/7QWpfMLAFjG9swmuooyRhN01OV6AEJXAbvkwa7qXmlxL+x5V6YQnQ1+OqpiV3PpDf68ZHVDfKGBpHR6J3QjAQuS8+NgIcXNeJZblBppJNZWrwthOWYY6CMEYqz0N8fFWDY6olMNQYry6p2Ygu2w8lnxDiJQDp9s5M23zg7fDbR2XE1t0pUcKHpyxflmA54dDQjInoh2AcPJD8pYXBvAfW6NxKMrlkqOLGDj3bOUXW+RcyIw6SDO1P/HYUYZGNIIKWLzDjUPN4brnEEi5Fezw6S+PrC5euunpkK7wR/AQJOL9QQ0eGftLu3EuU03gNEKDisT93UGDtyznwvOQXh/JWr1L3viCcNHJBHFLx2TvPFK5IVdIfKFhYWUNBxWUbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(956004)(2616005)(44832011)(8936002)(8676002)(26005)(66476007)(316002)(52116002)(2906002)(478600001)(186003)(66556008)(66946007)(6916009)(6512007)(6486002)(4744005)(450100002)(6506007)(86362001)(4326008)(6666004)(38350700002)(38100700002)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wGpOUqdTtaZTv6U+QKAUkJWzElpAgQtXRYt/uFhhRBCnKLZ4yRegUt3utNcp?=
 =?us-ascii?Q?Aet/hKXE3jjWUnR1k8ZwghHJ7Wh+j55/CIKxm4agxxGl7NRf9G29zievPAQ1?=
 =?us-ascii?Q?AdxdA1D2frLyVg6AvCkyPX+SPAAmLKcCC+ux9g+wRYfworsJbhxWcrV9YL2t?=
 =?us-ascii?Q?7T78kth0UwrkudHddVs4v/zjHVJMw6kXfmsfN256xiCQK62MsQFhLdzKRPBk?=
 =?us-ascii?Q?LOkBvccS9qfFefzJzcAh1DUWqg6DGfsyGjPN+01IugIGqS0wy0ddUiaa3/4l?=
 =?us-ascii?Q?v2ZyIao489o6ZI3FpDjk4cx2WGRioug437JuQrmwYI7xcVqjPsQEwil7C37V?=
 =?us-ascii?Q?zt6rBLpqjgN35wGvLIBnG27bdmtZq4tIh7t5mUzrb9uhc3WZhr3M1mciFkva?=
 =?us-ascii?Q?PokRDVSvDBrFsrHFGXTalHvEuuZEaYY1U/U0lZZoF/U4yl/0BOp2/10azOze?=
 =?us-ascii?Q?U0Dmewihz6t1odasVkXnPtZ2dLSgvZl5fzXt4eUiRRNrCsSyD2mMB3Wk3j1i?=
 =?us-ascii?Q?7kgGsl4lUzHF+DTVapUg4QbmxXysUbaqc5dBrMyGPrSfJYS+l3F8WQYFF53k?=
 =?us-ascii?Q?6UoLm8U+eK2bOFu5p2f1x8QzvUlIqCEy8Ec85yCZHslD4XfP3hn41Ce5bolz?=
 =?us-ascii?Q?MkVit7FeSlEiQwGjPL+mX9oiqgwEmiUl4T+moVDDhrOZPWDM6gYFXcFpc2KZ?=
 =?us-ascii?Q?RCs58jyXqB4qzxL1MJOzq3vHrBfS00sjhK/Xb1IWKe+hlX7JkSKOn2W1FLtX?=
 =?us-ascii?Q?fVUIO06LPdFfzlbjiZ3SKAXaqTVBf/l2god4AGr3e9G92ZWkJkBT0w93BSlO?=
 =?us-ascii?Q?vSlA3PiwYnAXwaC+bAc4E51tcsvSZYsy/0uPSiX243gkaBsvWA2f8H3rMaCr?=
 =?us-ascii?Q?pZSnbaKqyx8GGIBhxRdq2tWFFKx8xgh8wNw+mzc5MGT8NQh/oUHWiqnG2euZ?=
 =?us-ascii?Q?NquKYtgztzEIiliklwmayhGx99GgDmQBD9r64Kb6B/ggHMBoZvQvJT/V7krr?=
 =?us-ascii?Q?UMTPSlmSIz8UM7V5aciXIfuAvvgyi35jOa9YkNllZvqa2qm1+p3gRjimVfdv?=
 =?us-ascii?Q?HRrYE0NOR3xRnh2eTYA7xM+IaE6oLmnrAlzIlH2Hma9pvI5C3KmR8TXxZ0X/?=
 =?us-ascii?Q?iO54WM+/j2Cfd25/qvFYXf0vBkuYH2lZvXWTLJZWqzd4XXsx+1mTCb7gRbMN?=
 =?us-ascii?Q?7bwY1Vn1lFHUNbQegcH55LwbxSOVMTSvkSk8hAWlyyp+olqSo4apPS3Gs/1p?=
 =?us-ascii?Q?kBgnEWbFf8cksXr95bdd5wGj5yvvXG1QlW7TsSIf/66o6jU9N7dSLG0dJArn?=
 =?us-ascii?Q?FqamNtU7mElZNq7LjALGqxHU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4cb6af-4733-4108-8c50-08d95dfe0a47
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 01:59:52.9335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLOf5qvzMwRnp4eLqfdvcWX3kumk87NgFRUDFTEf4zGQ5ejG4u2HalfUcJN0hJGwKY5E8wFLpADVd/5FiPVgEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2771
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10074 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108130010
X-Proofpoint-GUID: e9_UlDcnm5NC2cGGKv2DoyaM_CY0rXVQ
X-Proofpoint-ORIG-GUID: e9_UlDcnm5NC2cGGKv2DoyaM_CY0rXVQ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the _scratch_mount fails, there isn't any clue on why it failed as
of now, change this and add the $(_scratch_mount_options $*) to the
_fail.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index e04d9365d902..4e939da37010 100644
--- a/common/rc
+++ b/common/rc
@@ -339,7 +339,7 @@ _try_scratch_mount()
 # mount scratch device with given options and _fail if mount fails
 _scratch_mount()
 {
-	_try_scratch_mount $* || _fail "mount failed"
+	_try_scratch_mount $* || _fail "mount $(_scratch_mount_options $*) failed"
 }
 
 _scratch_mount_idmapped()
-- 
2.27.0

