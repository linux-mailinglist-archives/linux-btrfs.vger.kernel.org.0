Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FC56F42E5
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 May 2023 13:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjEBLjt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 May 2023 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjEBLjq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 May 2023 07:39:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1070C30FD
        for <linux-btrfs@vger.kernel.org>; Tue,  2 May 2023 04:39:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342AKd7b017187
        for <linux-btrfs@vger.kernel.org>; Tue, 2 May 2023 11:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=6BNjsde0SBHHsgqKx7yn3b7+tC5+OTpqR5wYMerHTvo=;
 b=hk9DErJAx//vU5Y0d1Nu2yOyxUSr4VuKrBndeGzO4Op5ZZtm+DC78FFaoyRqLH14TrkK
 NIKhG2XRqV6zS6f0OyKbjH8uowWQJtbAnsu3RtLfOpk79U5PoetoHgDU+Jjv+QEKDNc9
 4wJLahu5KTVPZN4avMGwMl9z5OBV2/0qH0FceVHlKKwY41W779lULou2d+Do5YjaEWa/
 kfJgTorXog+fpodoNzVAHLk2ttsyE3U0HuVwGCdqcyHImnQ+wSBL21JFkKwODRF4Utnf
 ANbjeBnBwQcWayekS0oq8LKBk16uH1y0i8tL6OG2e0PXkujqGeFvygyCRQ/GoG6NcNqy xA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4amf4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 May 2023 11:39:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342AaYGc027240
        for <linux-btrfs@vger.kernel.org>; Tue, 2 May 2023 11:39:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spbvcd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 02 May 2023 11:39:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDE5dmM8Pv0KajXGG9co4oM/kX4hk8ZThCimvyom37O2eOpyCnA1rKBd5Dc2sZqnJVqbZ0ShYo3NQBgQzjQpZ7698eAmtRLVbWjw7vM9afWzuLxmATJslCalkQyUpNgl+uoyogblyKuqcxbohn0YB16Fv7+WVUTFe9rgI6aNnkFmoeymXr9XwYHCKuoMPq75il+NZGJQbxSeJczE0Oxke1sA1IdLy4hApzLiKieoOQ2Yf43OepETRedNiDru+DeRs8zfZ9X0GtBCJEG8EDZ8atKIz6mGiA7xwbA25dPBSC+B84RJR36zDuf94C725bXwSFC9VaVds22QtMpd/AiX0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BNjsde0SBHHsgqKx7yn3b7+tC5+OTpqR5wYMerHTvo=;
 b=aTh5RycxjmvEjNidOGKV0QF4bzfrgf52mdJ2FtK98dgRGzSClbvGh8t5jZMgJfecOhCDsFmu/J09zsv3pnAIOidgIqO+iFvVH5/JOsiEN+8NnnEcooG2au2sZzQm1x0Tlrc/p0LF6no/TXFkXsw/I2/MtDRTlbX2SALKZrSGiCCH2nTGKdLD7yZajptV+4etBMl8J1Jr6sp1CzduiCC2xwLiZcYSpNNys+5chvYfvI0WsY66TNB6suU1UZz2cgcS0FCgWLZgVcnF02AQTOZ26Z4bYKPBTPwdnNrnJIJ0bcr5rXbMegsnAeCqho7bsa/fWIyKMVDDlPFnVvYCTWMw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BNjsde0SBHHsgqKx7yn3b7+tC5+OTpqR5wYMerHTvo=;
 b=v4JyZueUMZxjLBNLgcaNBF7hC5zbuvUANNK5RsBUocFYj/w2Ojw602pz1Z9TA9bN/lReWsOjQj/JJ0UBc43WGGIXHTV7k6/hCEXmHyBEX7NDQVzbZTKdnc2YtH1kIQhl8FqYTfW3Is7J5psakLelhCq8w4YydeNNdc2mR0WVTUY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4781.namprd10.prod.outlook.com (2603:10b6:a03:2d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 11:39:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 11:39:41 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: tests/nullb fix kernel support check
Date:   Tue,  2 May 2023 19:39:34 +0800
Message-Id: <fe9a6082f152726145233e31e011f71ea4719217.1683027204.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4781:EE_
X-MS-Office365-Filtering-Correlation-Id: 141c4f1a-4850-455f-25ea-08db4b01eb4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odjEa8Yf6NB0dZfc5Sw51yjcvI1xesKQZL8bYh0GXcCjrckxk9asH1ypkLV9a+PQV6P2Zj5o0AZhEQKbtTrOTHnT3RPgkI0YTvyRFRZOqlCgZo9UCw3FIcx0SLgDd3Pa8YvQ3jAFJoiv3g2PC2jUxpBwtXqGfFXDq4E0G9v9yIh8MT7j1wc5tspQDIiy2maJphxU1NGxQCp+dHMGQnK1xjjVNg48PYx/yZdS4Kc1icd5Z/MwNRXEdDU9iXgopmfOlcJxhuiMe4jGVUFSgYGqF7eYJ9IEKHJfMZGcAk9pj8UfWPFHch00BPKJ4yuvgcdQkwkBovogbYVfRhkQRmuuewwnLWGRs7oBpWdtb1EUwLXPiQ3rNvSs4IWjG2vCAtoxBbBMRmrORzy+prB3pDM7VeoPA+3lqPdpRmP5iNB1GKqUzUgq3jCoNMCwQuIUk4yDlEpM8nYkWorDHiOxG1/nz/0mPxjVfcgvGNU7Nuvnvb9tTiZP9h8rtZe7iKedvdXEAA2GxZESsrBVy410gAOeU5ZLT9oK9n0JdcgLVTI/lFIfu8V1DP4fnfliaJoFPhMK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199021)(86362001)(8936002)(8676002)(41300700001)(5660300002)(44832011)(83380400001)(38100700002)(26005)(6506007)(36756003)(6512007)(6916009)(66556008)(66946007)(6666004)(6486002)(2616005)(478600001)(66476007)(316002)(2906002)(4744005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tpVH2O5CWNMU6uB9mEcBuC7oB7G/X2+v1B9pa9J4+aJ9gtMXF13kprrn0IfV?=
 =?us-ascii?Q?ZQWSTp0wOA1RP0pFqb8YYxJYb0q9tAN2fmmFiH03+76Qw0e3Bec7fLxSGBmx?=
 =?us-ascii?Q?ANjq4Pt76sB6Dk5O98zbhkgiINARsjvBEvlOHIDlOxJkzztMmA0WA3P8BOFe?=
 =?us-ascii?Q?6Hl6brZyC9Ee8fkL2Kbrx/RGKDtdnVQtXTVoxpyJQk1VncZEtpmMxAQUbPct?=
 =?us-ascii?Q?xwGVZi3XRaLbBYpmmyg61rMeJl+H5rXKXrBeS6stNhROpVwCB1BmxfTsAERA?=
 =?us-ascii?Q?sqZkcDjYo7nN57ROXpOge+vUO8334V2On5h9iTWp3MWiEDVWAKyi9uENQoRM?=
 =?us-ascii?Q?11T9KBs13S4zpXlUBpJzdiYpldFexRGqoqOXpF9wC2qKmxKK4IBHaiRjNNuh?=
 =?us-ascii?Q?Nskl6EUYtwjdYeky/7K2PcvhI1Ag7hZaoFfxNXJyJZfwryweXwh0K484I1Wt?=
 =?us-ascii?Q?p9cJ1SF9X9/d3np5osVBAVG1aF/bAT9378/SkeuFWzGRYamNAfPfX/zJsOL8?=
 =?us-ascii?Q?YzSeSUOZpuUx4JF9PGsoT2/RAqjEdyhatA4pJkzN+HcIJh4sN09vohAoDlGT?=
 =?us-ascii?Q?+FSBcrs62ucLsRVSg9m7u+ck3m08mivubTn8HiA2nyBRRUjsHb61VrXgmx/d?=
 =?us-ascii?Q?BjQEhm5y1DHq+3ohslNa8zXjW+wPcpqCAP8hQZJ0Fprj4EgbhHkOhYK2jdcZ?=
 =?us-ascii?Q?pjZ9VkMjrrY9hBBh6h/FQyuBsQE48p+pxffUeS5EXKvn1isBD2kmwjzTjzE5?=
 =?us-ascii?Q?Gcos6QmX1oEyxVCnNjDO33h6n6isKIaQvGBOOHEsj41N/G8suJkK6S5P4zMn?=
 =?us-ascii?Q?PLCyoMsWwBmQW7zSvRC/SofKBFnauzN2l64sR3L01VyQAMaf/ile/UB4PopX?=
 =?us-ascii?Q?yIY3jaJbJG43C6TcVcHgdXDUNMyEEaAjgucbM+vKLDpu2c+6Jt4ZQlGUZtCX?=
 =?us-ascii?Q?D1s9lE3doTLehFJCSl6nXvlHDCbIVbrc9HHfthpAMS+wdYlyjqpdKSQZCBfK?=
 =?us-ascii?Q?PnuSf0S0S5O9HiztAwRnejiM2ZR1fUA5mNlOz3Pkdg7bRkBKDbdNlSz3KgAK?=
 =?us-ascii?Q?Lc3qmkYgeEXnFNIuOVsQMgPajjhQVHziRSqO7cY7xNWQ3ywrY2lbT5A6XHie?=
 =?us-ascii?Q?S9MZ10ZO3MJaqsNLLQlkInuwo38TSQmSXY4nRb5hq4pAA9D31CNQKXR8GUK3?=
 =?us-ascii?Q?OJvDdBp55qnluRKI4hcivrdVcSFApRRBiIpAUJdE60WRAHWRD4IwyISIyGVK?=
 =?us-ascii?Q?k8Knehxt4lHU7z7J44Lwzini9uCLBhxwHYmiBVmvC/jWGI8XcicatqhoFRYB?=
 =?us-ascii?Q?CA2gESneNMF9MvBM8LL+L3jeRrn9e/3hXnMnDUi0RkWNkMOC8uic6IujGNaq?=
 =?us-ascii?Q?V9PQQyFfDjjX8Xi2zTblTDEsLKhDVCy21V9efrtWDeWcLGyTIDtSSZm0YSnm?=
 =?us-ascii?Q?Zy30MJR8i4IV0Hm8c04X/9AtqPd9cpcZyP8JTPzYTCjwZqXrI2Q7dnAX2z0C?=
 =?us-ascii?Q?GYnRCGr2YG3OWvJAtVoKwy4s6YHKZv4ARwZjfqaITTWvawDR8ALxIqoKUhVn?=
 =?us-ascii?Q?3VKsTxpGH/RX8sAt50KNc2RQgkCEP6W6c7PA4hSc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ggrL+uEjb8tSsOnshNMbiUSSK9Aq+dvgrU/hZUPP2bkZ7CFhFWsQp97CWcaG7zGZ7p7cZoibSpsclR6WKdger0U408y+N3I36N/JTY3P2ZBsnrKKcAPNs+uHa5gJTNAHd4ANCCqpiAT5eV+rO2zlilhxCMn1w5e5zTXZYxfJ7jXCFBmO7BFvihgV0ZlYrFQRTeh/piT+9mhDTkPjeBYIDvQ0FyTanh+FJC6yiyELDLxaYV9J01N5yrNZSzDwCw+Zosd3mGFpRWvk82ls+2U7z/MsxAagwgAFlk62ieNoPs/JBCFiLhG0tbDR/k7T5Yhx3Kw9Ydr0Vmk+WaIELkhYu9L7wPKlX/QODGk5SuSEh2aG4ca4pQk1dmmgpE3zvJ/NMLsxNH1HhD/zHOGGd7EB9hDHvSF0JoLiW5szoYPy9xvNb8oSm8qwmE6DWlf5Y+kf1/aYltSeYoqMvpVXlInpa8XSUxe2+5SIncTbqsI29WacyQ9dB5HeI4IsuJEjpV8H+i1C0S5JLT4yjG+OLTlXms5cyXHrpCTaf338OqfsOvTteqHE7ynG/lOh4QlDTkp7nQI2KPIhWvo8RE5+ACpueh4qwA9fJU3faBXNivxt/E/DMQy2DP6/Y1GLrDKrYCpOQ1H9kbhTfBMqdNl3wU8SS9+uUNfK8RBJcDNYa+IjS8NW1elS0MAMQB92ixfvHUU9IfOHXKxT7RzaFy5q1pMJ9REMX6idryao8jliHgfL7V7YnHCs93iauWujCg+AVO3ECP3UxUZ7IB2FyzCbQk89mQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141c4f1a-4850-455f-25ea-08db4b01eb4d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 11:39:41.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdwCMlmFq4QaxMNjQXfP/yZ7Q5ukrX/eHpqGf+Ic3kf8eSlEoS6gL0fJHw+rHs6ccNXTpyL2Z+8dtlcDMpBWtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4781
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_05,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020101
X-Proofpoint-GUID: zHHWPDSQE8Zjd3Yh74wCOl1AENJpPKe0
X-Proofpoint-ORIG-GUID: zHHWPDSQE8Zjd3Yh74wCOl1AENJpPKe0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have a setup where null_blk is not a module but is built-in, so to check
if the kernel supports null_blk, use 'modinfo -n'.

Also fix a comment.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/nullb | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/nullb b/tests/nullb
index 3fda4a2b02f4..bffa9f331333 100755
--- a/tests/nullb
+++ b/tests/nullb
@@ -8,7 +8,7 @@
 # - load required modules and mount configfs
 #
 # nullb create [-s size] [-z zonesize]
-# - create a new device with given sizes, allocating the first free indes, #
+# - create a new device with given sizes, allocating the first free index,
 #   device is /dev/nullb$index
 #
 # nullb ls
@@ -51,8 +51,8 @@ function _dbg() {
 }
 
 function _check_setup() {
-	if ! grep -q null_blk /proc/modules; then
-		_error "module not loaded"
+	if ! modinfo -n null_blk > /dev/null; then
+		_error "module not compiled/loaded"
 	fi
 	if ! grep -q configfs /proc/filesystems; then
 		_error "configfs not mounted"
-- 
2.31.1

