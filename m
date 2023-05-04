Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DF96F6D62
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjEDN45 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjEDN44 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 09:56:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ABC83FA
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 06:56:54 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344DjV71000412
        for <linux-btrfs@vger.kernel.org>; Thu, 4 May 2023 13:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=d45f+D4IBzCplecCfKqUpOHf4uAMnX9Qk4dVTONj6GA=;
 b=Ql8xqo/osmNL2i2h6ycBa8t1WdIguwmtiPJ0KJouXHyVwYUq/0ZB8spcS7ezEqa+y9OC
 Kr60PpBtSuYM3PW2YIyTq1llxI4M7fK6WfkdFG5YBDYOtDnPM3uuOLy1cl9x34DCbu7N
 4boClVko/uNcuOAmOlwBUla9nfAcM8u0nb+zWBc472DWQaBD11oKQ6XVVmyTV7aLd31/
 Sk3/mrb91QecFwI6nlKjX2fXjOuGJIYA2INAEKsDe8kF8/Tc4ItheXDhaXugQpPjxWkF
 xD7TmPxCh6HLWVBAPuSNxMcI0qRbkqTa5xklvNEBvJLmY3cazVzIDXbrER148QJHk8Re Xg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburga0cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 04 May 2023 13:56:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 344ChM60027368
        for <linux-btrfs@vger.kernel.org>; Thu, 4 May 2023 13:56:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spetbn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 04 May 2023 13:56:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOgnDyKLInBekLxlFXFDRWnp7vwHV6pCmapa2P/kdKXwMypYFn6IGEAsnIRcC2ZGaI5C4k8Oe7gqtPcu49f+UlcipszwxxUCQjQg5EQqdelXUlOXZ2lnlphFU4uF/lZTGM7sJoD6spDs+2AGRqDLVl0jZfEZmkDStepF95LkA4xQ2f9EqQu+Q4fIsIQ4+uy+ZOGMpUSmOkZQUfvh3R5x8Lo8p4/TcmpaWTYjjpdoCYBinZtQ5RORugl3Bv90o/tY+tXEpSMg0JmHB3L/aCJM0CRj+Rj2phML5vI3i3RJo7ZXnlOVS1cnpe07HGV8xYZxeyX6PS0idYKyEhMZUc/DSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d45f+D4IBzCplecCfKqUpOHf4uAMnX9Qk4dVTONj6GA=;
 b=jmyW5jDze5FCxh5YJbGAe1iM4GpqvFjQRzMncVMF6s5DmzrMIrTkX331k5cjd8EERqle/2n6OSip8QpTWo1WsfZFTLI7HCogOi+MCfN6o7un8xfCrm7OnqUmYf9raTtDaV9O4HUUZghU+YMrO2JJtRAFC3Zv5NqprPpDv/AK0Suy+XewbjEFPhfAJz2VoD3n6LdDOp/oXaOdWZXFWGYlS5I1Nu6aF8Q4mkqWKkrcUU1gF5UTYoatkFsQmuCf2Rk+Brt2lFlTkCzkm/LErkXx8Rlcm1LgC8KS/olQad6rs+B7BZdqo5sBvbiScpWWJpZViJ/aplM+lzLGqeSBZsdJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d45f+D4IBzCplecCfKqUpOHf4uAMnX9Qk4dVTONj6GA=;
 b=ZFhsjojr3UB/L5+TGTqJfy0gVp/ELknGI20Xhp5n9h3c0Yr3qTKdEqWOPWNj2wykk+ZIPUuTvXjX+J4UtOY6Taik9LU6EkwmXdSjCv63gqykIUZs8N2ZJAuFzhRilH0z9w0ztY3BgsqIBKVV9U+Uc1l7/lA/VIDEmLH/bmRfLb0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7530.namprd10.prod.outlook.com (2603:10b6:610:155::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 13:56:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 13:56:51 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs-progs: fix static_assert for older gcc
Date:   Thu,  4 May 2023 21:56:38 +0800
Message-Id: <9eaa8a7f31c2904784aac4c877df30b28ab908ae.1683206755.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <85f3af8298a4d7b6e40045aa7c6873d7ae1bc311.1683206686.git.anand.jain@oracle.com>
References: <85f3af8298a4d7b6e40045aa7c6873d7ae1bc311.1683206686.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0319.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e6c2df-c96c-4662-001d-08db4ca76906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uRbhuh5Dfak84n6QXK5I37VB466QKqtkppxmHTWrfbXeQNosiADkQ6nhJzN5JrHZ8YN9ZcH55G7r/6pSsu4Ju2DLJPZKXQkH8bv92twylDapzHnOZNxeDEdxMspyhWSdde1dsLPccZ/juaBNiYDTXzF++oDnb2h/Y6fE7rr6q2M/EIZyfeFfsdmJ+mepcYf3L8vlZ0nOEdnQWvnmpUO2dAxfdvVe4H273WrlUOerqgYl4BocHughnjQpK/qTuxPwDuAOjr7LwJ1MsCg3fEZQnv4ssILk1SW5Mx+rbRu8ewAiOtuHWQy89+FgOLP20MwzgKhD0GtepgX6+V/LlSmMwtIpGaFdr9d0ZfEyASH3xR5Psr8slYSdbeC5RxAIo3iowjTxlwJ1nTyGTAl1cI9xROEPVS7fyuhnjVzpD3/4jPcFR28ekA9RRAkA6m3aTOPSHjSnk7XWrBqoJzb2gyvM0eyuvpLzEg0+YmnCZiVVVc97AhX+VzBKZ4hBQPb7IchhhrzdadwC7UpR1UWt/e9nKU093hCpmTBTYApnVwJIdQdZQK71Q6D3t4I5uHkIPvu2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(83380400001)(2906002)(478600001)(5660300002)(316002)(66946007)(66476007)(8676002)(8936002)(41300700001)(44832011)(66556008)(6916009)(38100700002)(86362001)(6486002)(36756003)(6666004)(186003)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QYpl4sXUyAcmeZDddiwSJSHC/KTMnh9qaZco138E72habuv4HiGVTysPeEsk?=
 =?us-ascii?Q?D2qhhsPgQpboiITunJQ6vZndUDw7ZImy5vSWpzvHuMAKBIevXGbT6Koi0/DK?=
 =?us-ascii?Q?60hDnQFvUVbT9nmLz+DgiThV2fIN43wXTNXPXkimH3+0e0kuVgd41Xbsbxx0?=
 =?us-ascii?Q?mp7rlBPnJ4adTjCf+O7VZDFA0o+xiwOA2EAHDijY4HofLNwgdGlvaBYd/gcd?=
 =?us-ascii?Q?GkXdUcAEPF+XsRxFRR+I+gcdT5NCVx/bgF+yvDVy4psz6TDePdX3oq4cAWtj?=
 =?us-ascii?Q?eyjBJzWx0JI4eH9PispH1+BBEjK4AEOffJ0qfCv4emj1GtRi40RNzWJ9P868?=
 =?us-ascii?Q?GdHBegQjYFi4afWOE0vz8qgB1mFmrDnrY06Ari2P2PnY+W83f5W/ECJwNlp4?=
 =?us-ascii?Q?OUptOdI6sU/SyVyRAAhxYsYhQavktuWCqIh/mxCWKko+dgUfIVlS0MDs9r5l?=
 =?us-ascii?Q?tBmxCDsKRJmvTI6yvbMbPPTbUZQUCBoLQxpLjMg/QA0/oizEn6oQaYCEOjpO?=
 =?us-ascii?Q?BS4LEy+ivk3oIvJTzNZsiN9WRk0AnjwmUKUZ24EiN4IhZJ/KvrSoqj1ZMIuW?=
 =?us-ascii?Q?6ND8IKOb4PDs5o5ZNZTsK8kkAlSfYOWikmJ8PhFHBdgFjvF8DNiaX96TQIyr?=
 =?us-ascii?Q?xkWpUA2CQweRmhEkir+bnDVpSYZwJdbGXeIBTWGy2ujzGl74my1X+hzeAe2M?=
 =?us-ascii?Q?P9BbFziCRcGHNA8ITbKei7pIIq4FMVgxyJ7LhMz5e1p22ZoZFUSeHxzrPRI2?=
 =?us-ascii?Q?RvX+K/NYnqMOl094qn8z6iCItY8mCcNqnotMgN0uUX5DKCo2M4/mmG8urg51?=
 =?us-ascii?Q?nVQnCo7jpQhEFpQxabRTMKjbp3fRW0txz6VTo8nNb+RqYy5JUB1J43dCU+2G?=
 =?us-ascii?Q?xppLNk2AAbXCTt7tTaUIidRYJ+sCNIAI2VkP5zlF4zx8TunmUkemg8lVMVG+?=
 =?us-ascii?Q?aOQ1j6vqi+dVyjX+ERgxm+e0fxe5s20OY71K+yXqlnsOk4QVc2b6ukURb2ZZ?=
 =?us-ascii?Q?kcvTvNve9Ulg/4Y1xoxnnEVeGJ1BTiQDpRvIvOW59+R1qfadY1Yq3cbEmLyc?=
 =?us-ascii?Q?H7fqF2CO11+f4ogl1SZrmY4N6WyEcGuoOIadEqjL3kACA75+HQgq+CuONO9P?=
 =?us-ascii?Q?BRPYArgd1E9EJ5MKIwPsdqy8ItIaw6/e6FisIGO/fshBHiyFIx1KRbVDrez2?=
 =?us-ascii?Q?j6J1KWuLHUbRoxnWb8XmcPFPMx+Gcl5uI5hMuiaLt5H4lBc2kaWO0DONCrdX?=
 =?us-ascii?Q?p+6S6g3sOrxiiZN/n89IOfu7rlRFZwVI73/kZwtIjAnFoKef6yimnL9R30B8?=
 =?us-ascii?Q?maGBCFUE1v3tPpQOsCRocqdI8y04QyGjmsXM1JcFc2HVq7bSV8Io1jcfXtdI?=
 =?us-ascii?Q?kpJRZeXT9SipCQU/A0EudiQnDWHD0x1YE+F9qeVE6KTUkZ2zyEyvCwgkZqet?=
 =?us-ascii?Q?3ccPQ2NYJJtcaI7J/xbVQydKt7jhdQuqTwVAlyn92x7SUOqLQ2ejwSFqKSlH?=
 =?us-ascii?Q?NQgdHH3lkJJlQxQB3vX7s7EPHosGk1pCT3TVBkK01DR3Eq17yq3n8wjU4lRE?=
 =?us-ascii?Q?LP9TMTr4RCiL/2S9hPiXkCnkAWCvs4m5m4NygN02O+JnoBfx0auhPFdLTNAp?=
 =?us-ascii?Q?JAFy0pZzLpkNCJNQ540w8JA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Kb7uCG3t8sIGnQayxUh0HA6eVWu+Gj5vMxvlVVuv71n5TI0zbFWfJSS+F2WUKSNpGxvsK0OtcCerEGVY1wM9mBmvLi1ohOYzqGnuNk5BfQuA99edyaX4dWwWNChgrXArPzvm5m6YOQy0fzLw2ymF8d2xuGcACHdWFqNkKYTqgTCdjNodnYKKOmw4KZwSMYdphea/GKae/TM1L7GrzmMUyuoBW6hShzlffuTJAv/itc8LNRx8ExRV5LRqr40r9JtP0zyn3tWL2Ww7DbwXpM3wbZoLg5ZycByycLPY/q2f+jeEpFviW35R7cyDvrxAQ4+vS58vmRpYIegKrxtGQ+VpgVT7i5azsdtLYnRUbqsxxZZb8r1szeKdM38Ld5bjSnRcfEEZ3cqcSn0GhDek01nZBIAUa7Su+VDZAnvSJS4bIiNvdbUK0pD5QsvfwP/NoRCrWvFDn/qO66hoc3sNol3I0gpEyRBmluV+5KnhRhD9/W1X8bp+bpGEHhovng5phOvPCY1yTF44FkXpS9nVI/xj+kE74vWAdCk1Js9DFA1MWgBx5Fs2zM9VHQV8tPkvS5XzrWthp/r0WEG8ZSTJ0gt1kpZt8cHW5tVu0RoAelv0HCzSF1mJq2CnEWZcV+L0IguwY9FHLQeUQBpllV8wVnhEYmFpDEZ1U2NFTZuO4Xb8AS8kvN/GJqD5UxSbsRuzyD1r3PmPAAL3cxh2j6RIsuX2tqdKw0Mx7ZpsilN2OMXDaBuYJhTavVjzKUV9RPVwJJ36
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e6c2df-c96c-4662-001d-08db4ca76906
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 13:56:50.9913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYKIBmf/Y+F7M/0tqAuB85XjiFRG7DepXbPqCNwfBS2jbkHLfZXDqlJwQiXRQZFJBqCQBKQ8dkCqKyY7otW3IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_09,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305040114
X-Proofpoint-GUID: xGD19JZTN4rtZt4HVL0vw35RT5qxhR8z
X-Proofpoint-ORIG-GUID: xGD19JZTN4rtZt4HVL0vw35RT5qxhR8z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make is failing on gcc 8.5 with the following error. It looks like the
definition of static_assert has changed

[CC]   btrfs.o
In file included from ./kernel-shared/ctree.h:30,
         from kernel-shared/volumes.h:23,
         from btrfs.c:24:
./kernel-shared/accessors.h: In function 'btrfs_device_total_bytes':
./kernel-shared/accessors.h:118:58: error: expected ',' before ')' token
     sizeof(((struct btrfs_dev_item *)0))->total_bytes);

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/accessors.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
index 667dcbb8cf47..c917169f447a 100644
--- a/kernel-shared/accessors.h
+++ b/kernel-shared/accessors.h
@@ -58,29 +58,31 @@ DECLARE_BTRFS_SETGET_BITS(16)
 DECLARE_BTRFS_SETGET_BITS(32)
 DECLARE_BTRFS_SETGET_BITS(64)
 
+#define _static_assert(x)	static_assert(x, "")
+
 #define BTRFS_SETGET_FUNCS(name, type, member, bits)			\
 static inline u##bits btrfs_##name(const struct extent_buffer *eb,	\
 				   const type *s)			\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	return btrfs_get_##bits(eb, s, offsetof(type, member));		\
 }									\
 static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
 				    u##bits val)			\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
 }									\
 static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
 					 const type *s)			\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
 }									\
 static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
 					  type *s, u##bits val)		\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	_static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
 	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
 }
 
@@ -114,7 +116,7 @@ static inline void btrfs_set_##name(type *s, u##bits val)		\
 static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
 					   struct btrfs_dev_item *s)
 {
-	static_assert(sizeof(u64) ==
+	_static_assert(sizeof(u64) ==
 		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
 	return btrfs_get_64(eb, s, offsetof(struct btrfs_dev_item,
 					    total_bytes));
@@ -128,7 +130,7 @@ static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 						struct btrfs_dev_item *s,
 						u64 val)
 {
-	static_assert(sizeof(u64) ==
+	_static_assert(sizeof(u64) ==
 		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
 	btrfs_set_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes), val);
 }
-- 
2.38.1

