Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9214674108B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjF1L4u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:56:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49372 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231743AbjF1L4q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:56:46 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTqjU022794
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=cbcO8yxPKmp46k7uri26D/xzTqdDhJAWykt9keeYsco=;
 b=dQSP+Gu7N0P7kU7Uf0ky05A4C8a/M1HUcTzppLSC36gXCEbZKP+mUX7VOSH/p0Cqd4Jy
 3Xb3OUFBkDZYk3gfW0ktmyNUSc/hNJoDo6Fla2FtX+PbngfzWBIrQrQbTKGtZht/lbyN
 WO5cwm7MU8HNGdonJkg0tQK9pcwPyrFBGj8PJ5Pu1qpVDYt+CxXKxtzeZNq5dCdXhNep
 6XbRkhMyv13Yvrl+W62+lU4O3maLCFvi4aiN7YEclBazk1dhSrVOPm+sMcwYnD3kjJE4
 VLj2vfHaGnVC99FfIIi6XAr/H/RFZbgXanbpqkEGs+aiYPANl6zjEtt6nM4hsockDW+u SQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtq9y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:46 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBN3MD013097
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx64vsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7EPJjR4I6kOREvyvTnfXY3gelc3F+THxGF+eaWD3rpdqBRPEmZjbNfvv2CcVT0jvCToc+C8CnP3wqKrOPXHqP4HfYj8DDx4RLtGwW2T80PcGPp/pEPkNshJAoVbZZdnQU2jZtwd1nWy6xUHS6r80VR67kODFmVkl/y9c/85SRaooRGg9F2d3QRmAgOVUJ7D9wgwKUQScgRsqBGBKe/VG0TStC72qiJ630zyIvNXyhD6bTYNP1LJnnTPn7Fp+UVSVzFiaDukeeglyCY00nH596gIKT/dp9c7ycjiOTiWS5LfljdNMsQ9TZSNgzhCofhLwzbGR7e7urlUi1IxPTS86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbcO8yxPKmp46k7uri26D/xzTqdDhJAWykt9keeYsco=;
 b=Dh5XZ0MZQayVhWhAmNI61Lb6+uCo147stUvfExb3ZCzo49Dmuo6HsUpCimKBnSkeeE5CYgUTwgAbd46DRo0Z+shfmpsqfkmT/1exsOo7yGRebIzWGhAT+v2/rFFTA1LCWFj/h9yiGR1D5GuCIwmQCbvXoq9EbHWN80MBn5dneE153ChBvQgvFFqWPFqV7+IKYxIJEjXQNEowwS2q3XELvZ+zHIRPBgkovfNsgBco54oCCKbSN8T4/3zrHuIBUoaJW5iOw05NxiXBbI+CBFUmhehXAnVfM3rXNu61sSMxdWdJPPbSOL4DfTSO+XARfiUkrMa3yV2zlAAxExSc7rz0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbcO8yxPKmp46k7uri26D/xzTqdDhJAWykt9keeYsco=;
 b=jTU+Z5iRxUHz6MHHqtj37ihqcH44FQmmVhvNmIDfq+Dg7o8SwdGYj2KkDGkiuSaOTKfdgwcpvHKKWNfWw6HxLQ9DBfx6ElfCyTQpPTkfkvnK+pPyRvWUZJqtbuoTzmMwBxspMtt/jpDr3DzfdatNWKMTomgVv/xpIul2mRxCBso=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:56:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:56:43 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs-progs: tune: introduce --device option
Date:   Wed, 28 Jun 2023 19:56:10 +0800
Message-Id: <b8c9fefa4886ee80cf8c880e939df956b4e6b6dc.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
References: <cover.1687943122.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: a47e479d-2d5b-4bf1-c44e-08db77cebdca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVYPKs3MuQOo7VRWqQD+K34Wikf4w3VBgJ3Dp/2jlrDxlUO3KWpw7WdmAgcZ4yvEVXEyExluYB4yQrZqrTCgiCH9nYFddvAQVEVjIGTPnc/gevdz5vb/kc/QO13A2Fu2uD3GO7zl76z+yaiYwCkDZysEdf5q8MtCMcTmFd5eEHGg9aVtWmHHX5kMBXW8yqYEindk69s74Jf6DDgHXT1LZNnNgeRL6KnHK6xXYGw0mx3wjf36eFeeSOUXcamOYF4oe9i/0nn9q9zNvtWFdj/ggxasA/635shlCAmhDYtZ23G6mUON3KlogMZOBkYt6OQECGXsBK3OrsQip4Kdu3tOyye44h0al6DPeE0TjwCWzuEtFffB/gDaeL0/bZPNSNHZOivgMz348wJ08+dthZal4N8tjplU8g3wBjQwHZsMMG2xgqQ2lY/Qc4qGORNg6uULRl0dxMRwpZANyh9IM0DGcfDkGFN+AbcywwsT/1PxdwYigB+9+9FcGHF+g74u5acXF7ejI+2mKYZfYAu4jQcac/wxOWjlwVuTLyTCqSG1+5u+OqK98GKMTftmKy0ws9UT3MOtcZgTZUAJIX0+MumUiuFGlhdEyGWB3biSHo41xjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(6916009)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(6512007)(26005)(2906002)(83380400001)(6666004)(2616005)(461764006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S8XAagCqoWQBt0mF9araySDAoHfdxOvQUvvnVoy3DCJWVgQtJrMkmR+imMCn?=
 =?us-ascii?Q?9IQIIpVwKkoRVzc8fPPtFxTByqXqtnsVPoxBH83eGOadp33U9GKg6Rpz1vu/?=
 =?us-ascii?Q?PmUfRDoKYRkfVH2cCRdnim6h1r1TjJdL9gvXHMzdbt5jcy87f4F4ZDjE75o9?=
 =?us-ascii?Q?J0e3eYQ4n1+CNlVhXs/WRS+s+SYnHkBwu8QbX5l5yDJJnNggQM0MpfgCrehI?=
 =?us-ascii?Q?pQ4h0jVFTn89jqqVPT1Wo6UaQOxbVsVxkWDBemETcjm7pqX1v21kOC871wNP?=
 =?us-ascii?Q?xkiTPFdhiYl2rafLMvvLlglRmGypfCoDMsljx7s3mgoRE375NlaiVe9K/iQV?=
 =?us-ascii?Q?z+UafYw5xMmvplqGo3qw7Wh9aWTARSj3mSki+VSySQhjAGID2VRvd1Dvtcmq?=
 =?us-ascii?Q?s42IpBfCd2QBACYUgI9ubDhiwtPprdmrvrAihXkHmPLWhvIRY+rTVQ9w9UCF?=
 =?us-ascii?Q?jVjSdTQkboN1HlVDBnD9PkTsMpnNKt8PCVhAFGXz1K/XXDYjsJjYcio6y+DZ?=
 =?us-ascii?Q?yZQJBnAr6HLVu0bQeCpc/I6sBsat/RaRU0cPFLDZZ/aZS6BuYV+lrv06IPkf?=
 =?us-ascii?Q?TtNXBRT31vxrQHMuXf5x3zO48yeraIpgEVyrswIdeFs/Tm7gXFDPrgKfehzs?=
 =?us-ascii?Q?qNULUAsDiJ3eUEyWsz+giO2Tl619aQaKtcoYCRP/bKuZi5Z4cV2RRplo2O8A?=
 =?us-ascii?Q?EdiCa1mnDol0fqGDXW5T39kBajoYogH6PJP49nT+CQb2h9uG4dFYw5DvVfN8?=
 =?us-ascii?Q?p/UGNp2X1KaRzVjYxKZqhYV+qszZ96cvJhDeh6+mvAUNUssnLUz9TpX6TKMV?=
 =?us-ascii?Q?odbgM4c9uDNcqakjZjKTkpW0QxUR34YMzb4aDbd0xaKi2gmrDadq/Pl3EYoR?=
 =?us-ascii?Q?cpTb4YdAMsR9odwqPArBuMDqx5NC5LACWJKp8KK9n8IFUN/4usuyMvw/Z27X?=
 =?us-ascii?Q?MPMnmpvPNpA87RyYK3pTGe3fCuOwTjlUY7k78Y4a11VEneIF6851anL/pYFY?=
 =?us-ascii?Q?FeWejekCDR5MCAxoaQF7Iia/ub9sKFFu8o6dNreSZXOkDNDt8b80tJ6DE7eO?=
 =?us-ascii?Q?tErrMXomPmWniXcGwQwzi1Gtfp4UzGleEdj08ZGye/0UXrMImm1AfQN8Z8Mq?=
 =?us-ascii?Q?8cb1rG0A3QhkfvueOsiI3C6uOj4UGAIoqKW3J+nxtlIma3HpL0G4DeZ9LbQR?=
 =?us-ascii?Q?YvIqdwXtzZUOXJ/SrgmB1U0nTfGyN6yvkhgcnjJZWHCUFfmJjExoSRL/7/hr?=
 =?us-ascii?Q?QyQCvGMarcVSvINx4XJBJsY9Ke1ka+iT9oE+fEa6vffllaspeUsPWf0aMS/2?=
 =?us-ascii?Q?Hiu0OU91gO9XtJpItoitThTmEjzDLBrQHgExh6zenINmJ6K8H2XzjnSd9TE3?=
 =?us-ascii?Q?Iq+kPcZARKdWITX8e1vtm9M1DfK/TX9AHGfUe/PcKClCogKi5IQp4w+Ff4KI?=
 =?us-ascii?Q?tROcMK/aq7ZKDX5LapJSUcJ6NwiJJVi5E+mv1BkI5I1wnMhIqpbtagrwj8Q0?=
 =?us-ascii?Q?/geNSF+bg2ozZKmSnADurk5hnhvxm1eJOzBtOTH2uEycUP+T2NeosIeIE6a5?=
 =?us-ascii?Q?V0nthQ2zJC+Fsf4IDjgOX6EoajfOWIV+C62y/+dG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3AVEajBi/+YFLGd75bl1DJHODsQWmTrH2UciNKvOGJSK06Gbv/idEMIBTKo7UZ6IV5cx4ox6z9ep9vi0qTA60hVLmVln4lpaZFd657e+s1z3yHPm2V4mJzhD3sfQFsMI/WsFabdDUj2ggpn5cVQIZlelh+caEIM4WwpWMaipQVi87hcVJep3DAzwPPNjsDOXWZKc/PfBWxhpcWFv1acPupA8zw13gTOMc0dNNNb/gWpg40mgX7kDYfDCjzKMOTggn7inhiAm7qGnop6LbwA5rRPqm8GtF656hntBrxfGOquBYUqQptSuGEEmQK3KsaXhiN2RXhkuV0X6LwJmnAtb4/ugQEJFI2LErKkifHKiBuLP9z8n1J5RGqGU6Hhqmi1ZgA7lMbDeU60htlG9vFdpntqAR8boO37xhd16ANE7ZdxpIOLKpXB2S5ljOo+4XRRNrrE6xU0t6WB+WvPd0OLgbRr0gScKxlpXGbGF83JxMiOxJCsHjz3fiDQ0zbLovtc/haGljINE4rjFYBYpCw0HvC74+bOweRfZdtqnPEtgmdqmrhrXDbkMISdTnRHX9IbICw83jmXGJHKytof03ydYUiGwLgYD6GwBy+WJe8OsHQ+owloyqeBOpzrYLf3lI5aeeK0HradeS9K48xbFkuxWJs1dHlggosQipK1U8nRryMD6BBVNm4+vW0ponK902mNVUyQbP0scB0Oh2tRdGtFX1CbXIPdKQV0kvewmdPHICsyYQGO/48BJbJLXrC3BCL0jfxEochGxEXBwTFBrOdbAsg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47e479d-2d5b-4bf1-c44e-08db77cebdca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:56:43.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwZlOfB3TyVnbpkjSiNOH/sGIpWoUkHhbp10ExgrAVH93SYgA9ZrRYDXTJlheuR7S3lWYSYdHo2mVe7NfFY1Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280105
X-Proofpoint-GUID: G54r0Szj94EH5w0pgXzj8-jOrHsZasXk
X-Proofpoint-ORIG-GUID: G54r0Szj94EH5w0pgXzj8-jOrHsZasXk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As of now, btrfstune only accepts one device from the command line and
then scans the system to find other parter devices if any.

However, this method mandates always accessing the file raw image as a
loop device.

This patch modifies btrfstune to accept other devices or reg-files from
the command line using an option --device and scans/registers them.

For example:

	btrfstune -m --device /tdev/td1,/tdev/td2 /tdev/td3
  or
	btrfstune -m --device /tdev/td1 --device /tdev/td2 /tdev/td3

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tune/main.c b/tune/main.c
index 0c8872dcdee5..63e3ecc934cc 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -23,6 +23,7 @@
 #include <getopt.h>
 #include <errno.h>
 #include <stdbool.h>
+#include <ctype.h>
 #include <uuid/uuid.h>
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
@@ -117,6 +118,7 @@ static const char * const tune_usage[] = {
 	"",
 	"General:",
 	OPTLINE("-f", "allow dangerous operations, make sure that you are aware of the dangers"),
+	OPTLINE("--device", "devices or regular-files of the filesystem to be scanned"),
 	OPTLINE("--help", "print this help"),
 #if EXPERIMENTAL
 	"",
@@ -144,6 +146,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	bool to_bg_tree = false;
 	bool to_fst = false;
 	int csum_type = -1;
+	int argc_devices = 0;
+	char **argv_devices = NULL;
 	char *new_fsid_str = NULL;
 	int ret = 1;
 	u64 super_flags = 0;
@@ -155,7 +159,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		enum { GETOPT_VAL_CSUM = GETOPT_VAL_FIRST,
 		       GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE,
 		       GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE,
-		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE };
+		       GETOPT_VAL_ENABLE_FREE_SPACE_TREE,
+		       GETOPT_VAL_DEVICE };
 		static const struct option long_options[] = {
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP},
 			{ "convert-to-block-group-tree", no_argument, NULL,
@@ -167,6 +172,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 #if EXPERIMENTAL
 			{ "csum", required_argument, NULL, GETOPT_VAL_CSUM },
 #endif
+			{ "device", required_argument, NULL, GETOPT_VAL_DEVICE },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c = getopt_long(argc, argv, "S:rxfuU:nmM:", long_options, NULL);
@@ -210,6 +216,21 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		case GETOPT_VAL_ENABLE_BLOCK_GROUP_TREE:
 			to_bg_tree = true;
 			break;
+		case GETOPT_VAL_DEVICE:
+			if (!argv_devices) {
+				argv_devices = malloc(sizeof(char *));
+				if (!argv_devices) {
+					error("memory alloc failed");
+					return 1;
+				}
+			}
+
+			if (!array_append(argv_devices, optarg,
+					  &argc_devices)) {
+				error("memory alloc failed");
+				goto free_out;
+			}
+			break;
 		case GETOPT_VAL_DISABLE_BLOCK_GROUP_TREE:
 			to_extent_tree = true;
 			break;
@@ -285,6 +306,16 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		goto free_out;
 	}
 
+	/*
+	 * check_mounted_where() with noscan == true frees the scanned devices
+	 * scan the command line provided device list now.
+	 */
+	if (argv_devices) {
+		ret = btrfs_scan_argv_devices(0, argc_devices, argv_devices);
+		if (ret)
+			goto free_out;
+	}
+
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
 
 	if (!root) {
@@ -438,5 +469,6 @@ out:
 	btrfs_close_all_devices();
 
 free_out:
+	free_array(argv_devices, argc_devices);
 	return ret;
 }
-- 
2.31.1

