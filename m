Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52418741093
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjF1L5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:57:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41966 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbjF1L5R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:57:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTTGb005365
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=HpsbEeepyNUf/ydbzfxK3MzrqTMaQ945OFrlXzKl1EU=;
 b=E3KzGlxUBP7SNKND4jh4T5TFlph4Q5wGjHpSuzSYJy8qlCQDNa790IjNA8nRnt7mcUq5
 0NSqxf5qJWWhOdbUdJDwrYFXj8I9GyOtKsq/qvjlCvhr7iM6VGvtOIyJJh1+yxEntOvu
 7aJFhQzZfO07oUVrjX+YFDBkcXR4MnaoNVm2GSJvEimiUua3Up5xK1vhoSYhhg/61PsS
 vzW0pRDXDIS0lE6SJ9LE85EMuQcP1qVFfYE04jpU5QY+t9p47pJUdE/5+W9x7457zI8w
 ZAXO69rIzhkN0SvqU8njRKo9ckI2SwYuD2wlDXX2Qn5bOmVoyGhMDIWqVk+7xKDRNYs4 uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrca732f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SB4WYl013185
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx64wcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:57:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMRRzxMz0R3D3BP0a+Kscg9S5Lw+gItE/gThUx2dJ/ifYe0nWfscv0FRlmLBtuptP6sh9UyFlwbaEp1G11ZqD8ETNmYBiOmp8CIu1eeqR4ZTUI5ZHGWcjVdwqfuSg+BvBNuwc4nu556P7DTGshI1PVAgy/d6W3QxqC5iLVSu7syc9GguEMaaLHcFP8pzUI1roB/mc+SdL/J7vMLI+Rg4JWMdZ5ft7LtUIuegmYF791FcvM/zCmZniLDMJ7+IUiGdHIcqWjOgs1YNBstGeu0IrDO78PsadNuOi3DpJ4V8hP5jveFBRnYO1FC67A5FLD973lLzeqY6S4boczkwtsoeag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpsbEeepyNUf/ydbzfxK3MzrqTMaQ945OFrlXzKl1EU=;
 b=PInycNeW73r2fSZH07HFtcGXNyrB/uD4j/lGYtbDGrVxtqwhG6H5/twMB7Hik6rO74LjajgBChXcSkgnIFEOHFgPDZ3mD73oOus0UXBDg1wyUb/Y09TE6Bwl7HtQlr0nRpj1BjUXkk/Zk3/iOzBQNBrQxGd3yROYbEeKNjD17s/x6z1GfAZCvwQPP18fD5fcMv8elOFICGTy6j+fmxCrAvDfi9hd55uCh0nFMFXw4FM0ldYeZBe98/v4+u9y8bLlnVFBfZxdJ+q7ltmQWNO7xSVqyUK/De011C8uGY/T7M2vhOeodc1936EM4iCRkTwmlmnGfcNX6Uhh7cgp1Qex9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpsbEeepyNUf/ydbzfxK3MzrqTMaQ945OFrlXzKl1EU=;
 b=G3e/aEykWRboAVlyRbYyGeSod8l7nXInwHUU7I4WR0mS4KmzLuC5DyFy3Vau2sXlLa5YpIslkV8kyhRrpakoq8dMOiUL8ccRU153psmPk3BuQGocyBGIQYEJPnuMSfY+YjBxOi6envQmRjiYuye+0Tv4f2mTWKN1AHz6/0aY24o=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:57:14 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:57:14 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs-progs: check: introduce --device option
Date:   Wed, 28 Jun 2023 19:56:14 +0800
Message-Id: <64679fafee4e8865de841c120444ff6b31189d78.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
References: <cover.1687943122.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ccc909c-1c51-4e2b-9e68-08db77ced00f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i8oBj99zUA3se8exTY19bPGhFnY8eQC8EgwRjksbbg2HZJf6axPvdj0rklRKXY+MDJRYYWTBJaH0JqifHKKrMU1lhn2DGZ5KocsiFzF30t7eBP2+wZ/KKv5XBWiHISqLTP10sPV64IIgxBMboTdwaffquZbls5wej0KZbyz7d9x5BSnkB9OHXis2mSzKUWjma67c30oAZCFpnfV6nrOpVW9Lq0Ql+L4MZKxXKMVh4Kg3bU5eVr/EECMKZpObBHPEWS7TrEr+Qsjc0xFRz3gQ2GXK9W+X6afDfk8T2y9NFnSEPOXbQBL4DFcPICGQdsPhTpYEL0KKFoCLoVOkCERKa1JjJp6POIPLVYW+iMOqMiaSMgsSB1ikKVH9KnsJSagu/Y96NQ3m446i6xL62teLLI/2RQt5eB/IG5F6bS7frbxIOeSPDyqP+oH/8wA7RoGVmOAl+ADqTiaGLEI5yDw/KQxcZWcQtKHdabXmHN1sUXBoRH6XtmDO6S7o/qgUhxWEhLXTq3Z1UwzjEmz+InV/I3KLGKgC7ogFzSG8T1M7fu3deZ0Z1S2OApmy/TF8qFri/moWL0AugH+NAzU6UeJe6k5iaP+L3Y3kSbhmwcDpgko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(6916009)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(6512007)(26005)(2906002)(83380400001)(2616005)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dUIt8ToNT1y2Yjid8NjEmXX5Z313AJ+VAxNQGKvghi7tni86U0dxvy2fl6hm?=
 =?us-ascii?Q?toG1YvAKC48Iu5h6f9AFwV/mDKtSCRWVcWNaxSgKqWrioTjUszKMwaNXxvPY?=
 =?us-ascii?Q?mbfM0IZfmEuksHrvrihTJoZXhF/3o3WwHkG7HI1p/eo6eLi4V0ike19n1VGj?=
 =?us-ascii?Q?SmMmDM743Rr3lhZ4hBerDUGu+nKCa0WTHVy9NsSm74bgBXdoEpclLFnQX4FN?=
 =?us-ascii?Q?x1iLR5EBJhExHYGWAHo+x5HggoM9LAXBw72x/5oSxmNrxIa0u3U1HbThn5Qc?=
 =?us-ascii?Q?JBlohJP16FFfzJFfAG21LQGbo7MdRnyRTDjcuX9p2xVTHRWjiJ5QKbFSk2ni?=
 =?us-ascii?Q?M9JbVW4Xg7imooz990oBEqwOQGOf8aJ21Wn2HG+s3yduJjQDeSoiPg+aODWV?=
 =?us-ascii?Q?diVM7qCP4nHgB3vy/F9hWLOY+kBwE6BVy4FgsnYNhVP4JcDl/eTzOBW6Xg5X?=
 =?us-ascii?Q?ay6aKac0G2tdGcUlRh6Q3TGRLIDGGvbJ5Gu30Cb8ktgVaUOIG8qMHvVK2HyM?=
 =?us-ascii?Q?MoaTZ1NbNyZ5NM3BoS9DpS0oYQoFfc+q22LrgYxDn6t+Q9kXLtPIwK6uN1bS?=
 =?us-ascii?Q?8ndmZxbNe99AL65AW0NeCKgLfTP4rqBAn2VrVzB6Jhhrv8DMBMV0lV3XIkA9?=
 =?us-ascii?Q?VCJYeZLflbNsre1L0F8sMzJq+HwZ32L+xwEBxiSnlun4zVq7Xz92+Qt21uhr?=
 =?us-ascii?Q?veXMsa6+9eguZwzFMQKkb8hfebpdD7TZK9Svohk4zjCucQCDFeOq5X0F2HjB?=
 =?us-ascii?Q?jpQyyM4BSLZmUDixkKmkfCQMLS+AwdwnVzJYR+rMLZsX8aRos1Q7U/1inqhm?=
 =?us-ascii?Q?XAik4ldv3PEA7YtM6FXIsyI/JoNo8sEuXmGH+93f10VVdKgjUy3vImVrk9fR?=
 =?us-ascii?Q?/0WezzNjdntQ8ZYkZpDHO5S1+GpMh0zgomUSunJLQloEe1b4yOirCz3mxYiv?=
 =?us-ascii?Q?aBR/MWZ+PBz7Rxr8agREMnzlyg1a1re7AZ6BICaxOTgqbBhxIxCmFoASMAk4?=
 =?us-ascii?Q?q3Cjw2/vSgjhlbiFlfo06+PhBUm00R6gLQbHEoxEjgtkxHDXO6MQ26N/K259?=
 =?us-ascii?Q?m13evyKiYli6HIbY9oXiIhUgflCTAZJStS2cbLTIAfVAnOuZ5G2sLTTHbNcJ?=
 =?us-ascii?Q?VQ/SC+VPhVXSKDxdiYrWW35wmOYh3DfqzUJmYpH66lSQGBLDCbBeZBwk7Zg3?=
 =?us-ascii?Q?jjXw35abwRwrKuX2HEK31Gbc7n4+SmKpS3QuEIl4MDYEvVJhSc5qCcOAGqW3?=
 =?us-ascii?Q?R42SQZDy5XAMAMERADVzfivGVJSAArFCKT3uFKYxXzqAxjuZDukB3asVydiX?=
 =?us-ascii?Q?RxLyq8OBTq6dSvdHFadySx4GcZG9lOj2hKb/DXsUIIi8Qo7L4UC3SM9cZrf6?=
 =?us-ascii?Q?tW0uc+VbY+IsetwOzPbTVvJEID8k2H9zkc+TeKQyIXNJgk5tX3jW0TTyohB/?=
 =?us-ascii?Q?Dca59vsdHLPdpJCbFG5yRH1k7EKlLhmwCVGz1biBKBZU/OumB9ivXv4++Nk9?=
 =?us-ascii?Q?BCggIMT4A1Y0FN+d+I7PVySo7KFfJBCFpmWerUxugv6SNuzDPrqGB1LRdVdf?=
 =?us-ascii?Q?Z2Pxh+AhFrEfOWQLB1LO1y8TfmwK2IVaWPKBUWO1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bFjixbtcAQkQvQRX+0/zox5yTwjfl1eD/KcaUFOkER3qnMfb1UDa8s04GPvb/Z9TiSZT3IWGtqnHZcZ/SEPEJUNdTMvOinsDCu/rJvkM7icdoTPcua8x2njFULWeHhwR17miyuu5hKBdfV5K93NXyC060tCGXOajQMuipF0HGy4oLyf0ENM6x1F9Paks4HxTxOEbUpdX6CUiCmvBFeOowPjzV8vTdetkkszkHgpnLqtCdQVFvdFRkwhdb457wTSNQoOS+vwSyymRm9PQATjq8AACD1fENrijCsLm2QQ0PIKGexEBKfljq5WWHEUxBFIS0M0r31CsJUvxHt75FZzoAiPl/nG+XlVs0dVeeiZWzpaO9cwkdjxSZRyA+JGZSrUOgsyCNEZr+J1TJ51XTGkoQwz2bN42AHdKsXkm32vKtja6kt1e1a/JX0Lty8flXx9sPmKqAcejsaPSYxDXTDj/qBCWgsUFq8FWiEaSrx9OePl2chFZu2D9L4qYs+kFVvvPmGKYZ2ASrdtE32Mtd9frTI9U47++tUgctN/TY0TBAIipP1Cz6c1U75ZqzsecSiheMEvljCsKX+vFGB2ggVhrUtLNfLGGgZJTCq8SsY0+iq2qiuG39NOkuRKvtR8B51W5QiTsB3MKH+Fizg5N3130cXbQBhgjkcefv+wMFo7td2VWyvjNUpbCVzb8WtCGg9EnNZo74IBf5veLfpiqKwHO1FUWWB73XFGBbrzRo7C85AOWyWIVle5Y9OsZjtkXc1AU79I1L4XX+MlEQ86c7b61vA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ccc909c-1c51-4e2b-9e68-08db77ced00f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:57:14.3410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xUdLWCPco43diI/trw09jOqF5jUEHOg3NcRCp+kGq+5p1/AotuzqO6EGet/dmi8qy3kNFGMSCyuJnYIirJ/xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280105
X-Proofpoint-ORIG-GUID: rqGIbUiSYJs2QnFaDPP09jWKzUBes0VM
X-Proofpoint-GUID: rqGIbUiSYJs2QnFaDPP09jWKzUBes0VM
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As of now, btrfs check only accepts one device from the command line and
then scans the system to find other parter devices if any.

However, this method mandates always accessing the file raw image as a
loop device.

This patch modifies btrfs check to accept other devices or reg-files from
the command line using an option --device and scans/registers them.

    For example:

            btrfs check --device /tdev/td1,/tdev/td2 /tdev/td3
      or
            btrfs check --device /tdev/td1 --device /tdev/td2 /tdev/td3

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 check/main.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index 2f4fa5ada339..7eb57f10aded 100644
--- a/check/main.c
+++ b/check/main.c
@@ -51,6 +51,7 @@
 #include "common/messages.h"
 #include "common/task-utils.h"
 #include "common/device-utils.h"
+#include "common/device-scan.h"
 #include "common/utils.h"
 #include "common/rbtree-utils.h"
 #include "common/help.h"
@@ -9953,6 +9954,7 @@ static const char * const cmd_check_usage[] = {
 	OPTLINE("-b|--backup", "use the first valid backup root copy"),
 	OPTLINE("-r|--tree-root <bytenr>", "use the given bytenr for the tree root"),
 	OPTLINE("--chunk-root <bytenr>", "use the given bytenr for the chunk tree root"),
+	OPTLINE("--device <device>", "use the given device or regular-file"),
 	"",
 	"Operation modes:",
 	OPTLINE("--readonly", "run in read-only mode (default)"),
@@ -9989,6 +9991,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	u64 tree_root_bytenr = 0;
 	u64 chunk_root_bytenr = 0;
 	char uuidbuf[BTRFS_UUID_UNPARSED_SIZE];
+	char **argv_devices = NULL;
+	int argc_devices = 0;
 	int ret = 0;
 	int err = 0;
 	u64 num;
@@ -10010,7 +10014,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			GETOPT_VAL_INIT_EXTENT, GETOPT_VAL_CHECK_CSUM,
 			GETOPT_VAL_READONLY, GETOPT_VAL_CHUNK_TREE,
 			GETOPT_VAL_MODE, GETOPT_VAL_CLEAR_SPACE_CACHE,
-			GETOPT_VAL_CLEAR_INO_CACHE, GETOPT_VAL_FORCE };
+			GETOPT_VAL_CLEAR_INO_CACHE, GETOPT_VAL_FORCE,
+			GETOPT_VAL_DEVICE };
 		static const struct option long_options[] = {
 			{ "super", required_argument, NULL, 's' },
 			{ "repair", no_argument, NULL, GETOPT_VAL_REPAIR },
@@ -10035,6 +10040,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			{ "clear-ino-cache", no_argument , NULL,
 				GETOPT_VAL_CLEAR_INO_CACHE},
 			{ "force", no_argument, NULL, GETOPT_VAL_FORCE },
+			{ "device", required_argument, NULL, GETOPT_VAL_DEVICE },
 			{ NULL, 0, NULL, 0}
 		};
 
@@ -10126,6 +10132,22 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			case GETOPT_VAL_FORCE:
 				force = 1;
 				break;
+			case GETOPT_VAL_DEVICE:
+				if (!argv_devices) {
+					argv_devices = malloc(sizeof(char *));
+					if (!argv_devices) {
+						error("memory alloc failed");
+						exit(1);
+					}
+				}
+
+				if (!array_append(argv_devices, optarg,
+						  &argc_devices)) {
+					error("memory alloc failed");
+					free(argv_devices);
+					exit(1);
+				}
+				break;
 		}
 	}
 
@@ -10200,6 +10222,19 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		ctree_flags &= ~OPEN_CTREE_EXCLUSIVE;
 	}
 
+	/*
+	 * check_mounted_where() with noscan == true frees the scanned devices
+	 * scan the command line provided device list now.
+	 */
+	if (argv_devices) {
+		ret = btrfs_scan_argv_devices(0, argc_devices, argv_devices);
+		if (ret) {
+			ret = -EIO;
+			err |= !!ret;
+			goto free_out;
+		}
+	}
+
 	/* only allow partial opening under repair mode */
 	if (opt_check_repair)
 		ctree_flags |= OPEN_CTREE_PARTIAL;
@@ -10214,7 +10249,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		error("cannot open file system");
 		ret = -EIO;
 		err |= !!ret;
-		goto err_out;
+		goto free_out;
 	}
 
 	root = gfs_info->fs_root;
@@ -10560,6 +10595,8 @@ out:
 	free_root_recs_tree(&root_cache);
 close_out:
 	close_ctree(root);
+free_out:
+	free_array(argv_devices, argc_devices);
 err_out:
 	if (g_task_ctx.progress_enabled)
 		task_deinit(g_task_ctx.info);
-- 
2.31.1

