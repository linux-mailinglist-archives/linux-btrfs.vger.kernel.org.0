Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E79877BD06
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjHNP3j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjHNP3a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E1B10CE
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:29:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECieGp024718
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=/pUN6dSftlSXBrqqTxhnEr3F4Eh1SvwpOg2p2utEnxE=;
 b=E1m2wSNF3xLvPhi+kBWaGW06TCL28jiSCuFgEEtsyw0e9zlyphH8uWcBxioB0gpv3vch
 BcAnRpRmw/P4BmfIr9xVueS3Fa6mjdhfBRprEpV2ISuVKPO1xTaAXAUzdnIz/ex/XRme
 fEfmYYmaEQees/RJavNdND7mL9LvFfeJfhuUnwRCuDSziRLLg7oo+i6u3LJ1BlDu6jBm
 NyylEoHzZ9fVOYu6AtimJgbx6Bx6Ap/IuWrkl7He3ga6RThCm/wzYQM7rRI8OlgpxM/K
 5rZuR6SbHhzljjLr1/fb584ZxkrAkzeH0rUIb1XzzVVeJYGz4Sl6y4ayqsByibLbYI/9 dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3142vgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EF6M9A006624
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2c1st3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc0orcYLxJy0x3Ndlje5sGpcJtP7LMbpns39tZDpCOqt2CfFpy5ACMLigMGnJ9wlWJDAWCQLULgIVG9+DZq8qDjXbznWr6TTSLEoR7Hh9Kqa7I+h2KpdX51Sp4pSTusdiVhUoflmZCvqLZzZ7rgQBV+SRQOYLC1naH/mwJFrB3lvH3v5vwuxm4jCJBFPgOl0X5FWWhtYvuJfHpihUZEzkelKb2jl09Ve0B2ghctRN3l8KJFL2x7UlfVd+s8PNA+hFQQ3x2caoE9Lp3wgWp/zhVyXaxu0xVfwdFgxs5ESr4I9h9Y57/2wx5jd01M+FC06nOastidqcddD09SZ9pcofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pUN6dSftlSXBrqqTxhnEr3F4Eh1SvwpOg2p2utEnxE=;
 b=Ld53RZ/YiVdWQTP7QCsAgrIwXAeSKy73U5LRt0aCWgbG3xTU9+LrR0PXnbTPr4KPm5lR7B/q2A4pTsm/EfoBZkVaoe+2c7Tr6YzVrWcaqkuS/JHFFU2YXZ0j+bh6eIxeYG1dxN7/QGvtPdVc+KnMVUBKMcdlhyw4H2Xz1a7VqwLonj4TpQovjIBQ256mhUqm6DtmfsN8tS+3HJstYU62M5QVeMojlHnSMau/o1IL8kDF9+l5tLpnZSdOrLjs69mpEgDcx6IyPIGuLeiWURd4mOCcG5Ady+ycsSodgf9RERPZkwXOWBovLF8EyCe6WH1RKWnLkHmz07vqWE2NPhbOMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pUN6dSftlSXBrqqTxhnEr3F4Eh1SvwpOg2p2utEnxE=;
 b=NB8tui9dq8A2j+Q7QBR6mUhA0I95fhJ7KxJUs6z6y33L07BlYB8DIKLn/vaxvhe9m2MvyoThk75JbdazgmKxbfQh8HoNIV04qmfz+Xc2akCV89ZdcOhXiHL3U/Aur3AC78HVSGmfxS3W5iF0TTU/RuhgCAnOEPZj1RX3XTufUaQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:29:16 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:29:16 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/16] btrfs-progs: pass metadata_uuid in check_unfinished_fsid_change arg3
Date:   Mon, 14 Aug 2023 23:28:04 +0800
Message-Id: <074f60b0f55304a5a567c4fabe17e401b061f8a3.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 38622466-9210-4073-b721-08db9cdb388c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odpW5mA4RgcihEOlCORr/VX7YWgAMP7Km7Mn+5LasjOj4RLvMiclOtnwHHyMet3/GA1qu2u9xvP2f1F8m1/f71YAek8lhm2ulthimJKHaM/Vy5o+ox+MAfdbvoGqYcQW1mZWPWosEeHNnAD6kZ4bf4hInX3KDUhSXnecTTOsxMiqNhODUIEffZNg/HOdEOvacUKerIA5+EJck2C9w7Do/dlCDt8gcHgEBYSdeG2K+BgPVeNogkTKNYs5j+03ufogri2qRjuE/6IQxUzkG6Rfy5O23oZFYJtQJOaDevPWsnjLLM6ojRSafM3LSx2+jvTMwhxv/x5/HfAbaWYpiRFQkt5r7v83MI2f8HqOYtsbfr6WgLKoBVwE9AetxCvG5roiyy3HJYDXLiRBi18Q9Fp41omcsRsLzHs9B+R3/b5i0KStcdgk/DiOHPA0ivlmVVxOUl+3RyWTrdi4CjMdUUH9xN8seLe4KQC7ITfPK59lQDjh8mkRixl3YHFrST6RA1mXQZJB8Ga+9xF08fUehJ0yF7SmNmv+o1vSr4M5Jo2RT88Agbbn4a2J3Cm9COssGqqd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(186006)(451199021)(1800799006)(8936002)(6512007)(86362001)(478600001)(6506007)(6486002)(316002)(8676002)(66946007)(41300700001)(66556008)(6666004)(66476007)(6916009)(5660300002)(44832011)(26005)(2616005)(36756003)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gMjXuL33GBsD2RzxRKn7i9yyVVdT1pjXebIGVCfaKSo+mQgMSRUhBrpCefIt?=
 =?us-ascii?Q?4Fdb9yYXz84jr5TAyM8xJ+XWtRaAv2kVJyi2hxkxf/3oA6GfWGsyDuOGg+5Y?=
 =?us-ascii?Q?7cRaWcqR64qh3nZhjoB5xZvBRObbOxBfTYUK7l1IkrFTCVV1lf5wQsXQq1Jr?=
 =?us-ascii?Q?EKkNnlI7fRPe0//qFAfpqojUSdORIG8e59hIHu5FjdjrqSBCtqdt8Qiljv/A?=
 =?us-ascii?Q?WAm4YOGYqJJO/STlxz3Y4nb9EP+/kjiK60qxrhl97cmyPMBs8hffD2az96t4?=
 =?us-ascii?Q?FSPeyn/9gAobumzOCWUYvIF772c22vZtXt9yvIPDsrli+r+jHO8iIuoUpnPL?=
 =?us-ascii?Q?68zQDTart/PlcN8SxOIVqTnRXWyjdC95VBxB2HlfasyxQfiTwyllhte3ZMPU?=
 =?us-ascii?Q?d5NcV2PGQ8E+vldpEbC3MYcg/b+cwdAnK+W5WIX4fM4myLtTlnCSzEHzvPQU?=
 =?us-ascii?Q?WZ09gSJ8yfpLaezWzNcxFJVdZxhXIItoRCkbhnG4KAghk40NTnJWZqR2jTy/?=
 =?us-ascii?Q?d55ntOvAwnalbc76a60Zrt7DUlMSpzgOK0w8Rp++/4SM8ishAgXyHOHRHn6d?=
 =?us-ascii?Q?nXWyqrbacXh/DwodDg856vcUr0CvSGDRoe9fF+hDWRNhw1W9h/XP5c/Xe3L7?=
 =?us-ascii?Q?q8gNWkj15BAXnRm+cKqLUJaIBXN5gjfiM7ahgr0ZBeYqP7h/h/JNNiwO7jJa?=
 =?us-ascii?Q?eZGJpcFg8MQ4mrmF/12GoAQ5/wQuOJaAu9FGYTFjFMBE1lqb4QWhy2Sp3FRo?=
 =?us-ascii?Q?RInAFa2y4GpLFU9sSu2ORkKj8/mKvSM8bvyCMGu/yNJJMo6Pz4/aSkOronpR?=
 =?us-ascii?Q?MPk7g16Z2cywetssOK3F8x/DcKcOIDsn2cZYmHa2Lsd15fU1SigG9h+E6R43?=
 =?us-ascii?Q?hRWxXiYJUzR6sjhvJC+RrxWc63wGbnp+IfzSBkyCGBOuCp35EwWDRT03yN42?=
 =?us-ascii?Q?Zd7A2infjlmhMCjeyCPI4F6IC7hYBiI2fxsEsp4r9M8dm4H7ZLseAX50srOM?=
 =?us-ascii?Q?Y+P0rjY3cJh7BF5PYFIxkmlKIzJuFLN9KTTPuj6rI9DW6gEalf4VYyucmKJk?=
 =?us-ascii?Q?qWTbzQ3B5Q69s0KVzHixPmEvWbEjyIOUG+SjPsD2nCZTazIemzTb32Xc08Ay?=
 =?us-ascii?Q?F2+paptvxxH+gy2qrsi1TXmrf2tpbGB7wd+UWmYoxJ/VfBLiHsAY3YT8gL0I?=
 =?us-ascii?Q?wH8PSwdZIQWM0J3v2LpmW7CzEHIaxaAu9qbf7/8Fek3vELJw1XP+t7rcAPRi?=
 =?us-ascii?Q?SJYrTT5OWFvwoPUc1MEv597yT+smzOP/WHiMUd/Yz3lJlvoEjqC38kQC3WmN?=
 =?us-ascii?Q?0uofmoIE86+aAVws/8CRZiFrSTSm+RNeOXF9K7DhKhZ8cvH7l52D3tXanLSe?=
 =?us-ascii?Q?TU7uRP7l2O0G/OxoFsEhjdBSehuRednokHYRvfGtTQo2h3bFArxpBc3QUrjU?=
 =?us-ascii?Q?9JaSOcXVGCtaSuMbJ8qsYia9ott1/nUL94bOXprEw027dvI70vgZB/ql+8Da?=
 =?us-ascii?Q?pMUXWtM0rkJlfXZLnwrD96GB0hGqfhL/faYGPeUOrvtLQSXT27FvaatgDg4Z?=
 =?us-ascii?Q?xSgsAXy2VKiN5KTV8plKssYp5n1Vn03u0u4RCWrpBpRn9wSbXuG41kLWJzDS?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hmP9mV+dA3RJ3HyToPnOiluRGye0jKcqb/W3/BNlGP1hzJgKhWzzMu9LVBM/hnmbWd0MPChtTNEHo3q3EKnGlTlT2QctK+LiFdt8yBpaEXXTFhGg9nDESx59Aa0Ztykb1cxFQ0rR7NWgR4j9i3RrYIvbhg63uEa7E5foh/0qJbgfMjiLIql0gsN/3IcDmIsGAmVE0yTD51m2KCCI4jZDbYXf3WqU79usn6ZjuUrWMIR4eoM2hjrX5p+YY9TZ3YN6MzLTLf4Od99vBpYJjPSc8zn/f7GguzYsmkFKhNi11YUGXe23ueE0FEo4lg/Kgd62WLApzefcEi4hNEVq8AKaIEHqpPCfNmy9UGigwKOCvhD1PovzMIrulPaj2gH9+RLcisOOwNx5yPfaWRMTDp/+B6qf7Gg/rtukbp3BYrRHdJV7+7NRTz3w9r1fTtkUoP1IMTlrtgMs4gB3LqGkzckk8D+IX5oGMpQXu9bPGtalDtq+i4gZgPed6SOiCdgFMRPHNHXh7RYgWREAoECmaxwf2PKP2AkeFguyX5YiOOekjk7DzYezBKoDPvd3y9TyXXzGMbyY9TX02ZgUbU1mo8Wg15bT5Z9CRj+ZkMZmH+sSol/q6rxO0CTO8EZUj5jhORhHbbIyj8uKHNDRWbABr5fM94wqVjfyaFl5PmDZmuqvgik8XCZCO5u73/Zvk/LZa3Kst866U06W6hSPsb3SXYv52Ue4V6fo5FGhg9U2LmNZjKROM4iK9FTiQKYpVBV0fFPWgCNmw50x7gHpoH/F/vz0Ow==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38622466-9210-4073-b721-08db9cdb388c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:29:16.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNVeYTmbkoHzEZTtM6s1O3VMwi6MQsOwqyU8JhaJ5b15GOLM7gaaZIVSAZGJxKAurzN+43TBB1C/krr1qfjyHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140144
X-Proofpoint-GUID: SfLag5Oa9Wb7IKvdemBnZzvozvd4uNcW
X-Proofpoint-ORIG-GUID: SfLag5Oa9Wb7IKvdemBnZzvozvd4uNcW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation to use check_unfinished_fsid_change() to support the
ability to reunite devices after a failed 'btrfstune -m|M' command,
rename %unused2 to %metadata_uuid as the function
check_unfinished_fsid_change() write the metadata_uuid from the ctree to
it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/change-metadata-uuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tune/change-metadata-uuid.c b/tune/change-metadata-uuid.c
index a49adda8dd29..b161f6757d13 100644
--- a/tune/change-metadata-uuid.c
+++ b/tune/change-metadata-uuid.c
@@ -27,7 +27,7 @@
 int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 {
 	struct btrfs_super_block *disk_super;
-	uuid_t fsid, unused2;
+	uuid_t fsid, metadata_uuid;
 	struct btrfs_trans_handle *trans;
 	bool new_fsid = true;
 	u64 incompat_flags;
@@ -45,7 +45,7 @@ int set_metadata_uuid(struct btrfs_root *root, const char *new_fsid_string)
 		return 1;
 	}
 
-	if (check_unfinished_fsid_change(root->fs_info, fsid, unused2)) {
+	if (check_unfinished_fsid_change(root->fs_info, fsid, metadata_uuid)) {
 		error("UUID rewrite in progress, cannot change metadata_uuid");
 		return 1;
 	}
-- 
2.39.3

