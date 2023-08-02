Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD64376DB95
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjHBXbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjHBXbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:31:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6102D2D49
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:31:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiAmT024947
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=XLaP9aAyX4ILfVTZ0oY5MhkqI/nwH84NYbbUYU++yY8=;
 b=qz0K/mjuFTaNsrfpxrfqtX9kGA2mLy0LsqUDNsEDTl9qczVgTUNMZuohJ80pir/FnlnW
 MCcwhqQhwUsoR/dBUDjrsHvXFEEFRI9nh/MHvQoz2PzF759pOJbzGyOajxu+ihrvj/S/
 dooXA8V67tZL02eV9QYkqVVrA34GaDRbi43VX63yjY/grY4wIGHGjA0IU3SbbjusVSTT
 8bUACWHBbGXZSD0FopNFDMYVlEcG/5fZ6RXTRxlmmnzKu39J8rLBTz4L46noVCp7A0VQ
 0DKDSlZn2mHc7tFUCZr6r1REKzHRgMa6qIoEmYiv4t/6BQjBXq4hVmoiNlYrI2unoRPN qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e8dds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:31:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372MNfqa020585
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:31:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78tvvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCXpENkLYmG+5jvabrgKmNFtawDkHmi8y7GnPfFWXHXfnr9xQUfp9hJT9G8VzzqfGyt1R2OQDrUoJXrHC9acnI7vf0bbw5pwcoK+jLMX/+T4F0bO9wJavJdIQTqf1TSeh+70kDmeE75ZEb6qoO19NaMmMyXh96yc9agEri/1JQBkl6mL4sWf3DRrksOdG/kTrm+MINccS0VadE9Q9h2v2MuskwpPWd/yKwO0RiHG0rmHcjKnrEEqMUNUCZJOdsB9WnbULt/ES4KLcRc2EmXwjJ8s2Os/9VyTLiP4vWTA6X8veoLqVbsiboslt8GZXhZw6hEuvdMrYAE4VcjeLAQ+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLaP9aAyX4ILfVTZ0oY5MhkqI/nwH84NYbbUYU++yY8=;
 b=Uxekwc+0BmEkLY1I9xr3UpvEz3r6k6Q2Bpb7Jmd8lcrB8kCuLFw6DU+C+MdlT8Sdw32XU4QVl/14vaxYCIVZlHLnJsS62TUIksNZmAZgXPj4ZWDWUWBnIW+mq9gsIu84x2qFX1ZEcUq+gBKgoeLS2jXNdm+pv5OMVxbTzRNTuqs47hoyoheAGNwZoOaqadS2ElK4AznvggM6RqQyNcLkLbS2f6siK6FCS3xuiNNAO976WTCrbS03vfiN2wuAVp2Kw5o/I4wCMvT8W85ye53iLPLxy4jXkD7Xcs7nj7OZWIdbqEsNBOaa3r2xnDZRuo9rmgU5O0upKm08iU94nElQVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLaP9aAyX4ILfVTZ0oY5MhkqI/nwH84NYbbUYU++yY8=;
 b=vbEiQbeSR2KnIriBxJexp/YdvboGazBOJzasOsCvq5A2KuiXeiQIVeWPfDWV54ja30XrSpKtuXk2cJikm8hoAYD7O1wVtGMLKWTDMJx2UB+CVPId1iU6TK5h6eLJk58cD99Zpj/cAjjRSM+fLpU2jCg8ZRBAunC171mR9gr+2Vw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:31:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:31:02 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/10] btrfs-progs: tune: consolidate return goto free-out
Date:   Thu,  3 Aug 2023 07:29:46 +0800
Message-Id: <27568376033263288027ccb60dbbc0d9f78c4744.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
References: <cover.1690985783.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd8e92b-1d8c-4859-17f6-08db93b088c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8YSlBp9tqESiDGuNPXCQGjnD9UNOojWk7BgDL/D9mooGqru1Jbhb1GuMznOswVQO6KlmC7xm2seH4G2k3j8Pcu0pauFsJSQRG/xHdvQ8v04avXCKMvuPOfll0rwjhzuNADTjIcGvZYpb+2qtts3Yueg1ZgpEyFGbCbbh3lmSn1IkqKmDuclcjZkcGbzG1Pk2gpz4W86M4W2UDxX+R+cOWuhpqcRxNsxBraPOfq9v1els8uCBqlU0jxcjCV7qvS/WReC1zUNXyzah12dPTTOaQNsMg5gIuwmBXz6nDAHMKV3fT8GrlzVf0OfhC7AtvtK5aV+y8QESD5s4Mvi2P7r1OtIR9ihqdhtJkpVoKxIn68dgI92C8VteqE2YQB1AK0nMXtrHyH8gWy1pAmXMul2gQsaI1tSEfHeLiEzRXbaLrRMgZuiZzYF0kN+UWSnY/DwVwqzAe5zF4aE2pTU/Rq6Q10ywSkrRpBx0tnHLgFD/SWR42u/t13gbhER8CM7xf8xRZKY4rYzFlq2aN8coXnKpncm6N6UCaxaOMUPnIXwT5hg0NduXAIcQX5asx3I6V+8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?duGQ8Is47Ex7YPpsrbvXHSgm3WiAo0mZGRfiyaZfzkOUyG7O69vNxl+4pwnR?=
 =?us-ascii?Q?gknZDJVLN7XcURPIgbLPBQfR7pFd18ddkJDJna0b6ysvzB5YCT4ZIRIJ1z9m?=
 =?us-ascii?Q?0v6Ij3YUhzrm7gY770kXhRZPiDNx6LDZt3tf5xpxJ0ylGwXxf5D7f0n65sTo?=
 =?us-ascii?Q?/vQCAkusQIX6bi8wPgtuTvetqYbnve2Ptabh7rNlfsVB2oBq31H+7wwkIpTJ?=
 =?us-ascii?Q?PSHgIn9s/Raa2tPzpl6AMOQpLuFubt1I7RktpfozLRc7pEbO7kg3Krllpgms?=
 =?us-ascii?Q?FizUqkYkv5meVSywjxT1s5d0IVxLcg4tTQR7tSUAmfrhwrSgIyLOV3N0bGWL?=
 =?us-ascii?Q?SqX0n/5bjotwG6FLiIKdHhvqtu4bQ47lX0rM3J7WtND+4ZVM9BhvQhptlnVw?=
 =?us-ascii?Q?R/Xd+GvGSuglxDGEv/SxSwAxwBPV7spw75xXPOFeIJRVTsfBV0bmGZrw3atx?=
 =?us-ascii?Q?lAWnjXDH8zUdoBRtLK7g31ZQ8L0oY/HM9vWq/EIZJoXU16MA9ykmUj9Ux82N?=
 =?us-ascii?Q?dp7nVaVkK/vq0ZlmROIHl4MXT6uGUhdoqR4MBUzgIdHDJvTsnqR1Zgwv7sig?=
 =?us-ascii?Q?Nb+NDFGCQ7EPcubAJBvIGsOu/FWtMMOeltd7nIRdUm+FgPeGqe11gzMLjZZW?=
 =?us-ascii?Q?qjK7jpoyshl9DljHjsd1ax7pk90I1cZBVZXWnLOFLMQ0zAqtdNQZxGxya7J4?=
 =?us-ascii?Q?fjh47fG+IrlX30Ws2zjeMzsJBNWYiJon49UXpYpi0JaOGMfQSZHgwYeoSJyb?=
 =?us-ascii?Q?3gB5OReOCid9cPFPNnNuh6DAq7YMjREYgxBBN6am3JMdwIw6qUalxB4bEGBh?=
 =?us-ascii?Q?NnaIGTQVPZtkMSJVhc2RvSZDKa8AXLKydkWgvCuJPQz+qi6vZAwYLgNey3Tz?=
 =?us-ascii?Q?8VqwpSSd126dRcJom6dxa1yk61tzuKPQI95SQ/cfjmkNrhuYVuM0hWT1H9BM?=
 =?us-ascii?Q?7qiGp3S8LZcutXwoJTS4pCsl8GS31UmLXPVxSxJ0F1vg3KRxjX1riOJ0vdFX?=
 =?us-ascii?Q?xRi+WW4yuJICul0dNEQaHf/sEDX6LlYoyaEWpI9fgs4j5zK1TM01ap/jzoBV?=
 =?us-ascii?Q?pBPBetqrKG1A4++/QVT3dq/E7ZNHER/qWtWMCHeLCfis1aUCEbGA4EcBmL7L?=
 =?us-ascii?Q?vCPVZpx+1O8QfGJAkRHutbkLdTvkCIUwo1g1NG+FjtSnBksdTBVF/Bv/wQxe?=
 =?us-ascii?Q?WoC/ZJy07gXBdQU/j1HEztnBDTdEfrP0iz/gySQ0Jo5Ood/7ThkXf5h+ltde?=
 =?us-ascii?Q?LY6sq05r60oF2j32u0N0G4vDNTYCf1U1qCIJc813Yy+8RvMKsssMYudI5IEJ?=
 =?us-ascii?Q?gREGAQCMYAZbtXEjE+5xmfkQxPPaog7gSYny3NL4TYANPmisKBMEw36cpQOQ?=
 =?us-ascii?Q?5Dz+pf533oQEaE1AVFhxfeNj1iK1vTdqZqZNdEeJoX/7wHWBJ3QVpul1ebuM?=
 =?us-ascii?Q?cRmWSTMFiclRiEBTKFDeBfSCo3Zou08fbYvnqqR3vNyy47knEUiCNitR/G/P?=
 =?us-ascii?Q?ZPMGRUXCB10T6MihmxctRRV4KUOHoQ9b74gVs1cgDeWm4LbRA6zCgq5OWd+T?=
 =?us-ascii?Q?RvdCoYfEUQNJxwhr1Adu0iYZVFnS0KmaUGOOqLNjxT+/ktK2ttXpQ5R0CRBR?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 32/pGIrYcj8/2QqrDH42VT+g9x8ieqtR5fiJuS/4onCHK7Cqth+j4qvKrS/GKLSFAtGapL88Y9aHJ9Hp2jnfT0oqVpRg+VAgda+Abedk0c513t1OwQJGjSdUr6/5tKeZMu8YS5a1iI/7nGet/+v46SOcdpyMcRaGdId1dDYvK5T8d9SlWoey5CRTNabryAHg4deWOwoCuArRFm46F6z+ujKmU/4DLZsznv2zWf6oQjPhl9munPGxhPndCmnrp/+jo18k+doyQkLdZv6dE056KSGI6YqDOnhTVUmt0azkaYg+mY/qN384lpVQw8l5UzGNfI0UULUhJPrgPs4Pkhhuz7/ODVR3xOJzyPTKY6++vHmuGfsA7kS+goGSp/DtCDckYZucDoo2gXmRoT8lGM1KnTZfUqOtMiivez5Iqk9cASeUllhzATwKDttXjnjVWF2mlSiul7aY1RAmUxEhqtMyW8Vp6c6kKj/5kxgwnWrxtLQc1zWKjy34NixMakFeJTFMAbpGo4JcqES9OiLyx9fvj4OiT1pFXI5/7nmoqbIHP2QAkt0FSP8xTCY7Z7zpDZdUbD2Of4tLPrqWu55F5QIWu+4szdX1AzVHJYY8Jw9PFsSG2eJi4BrT0BXgbj8j5kJ13I7ZWM+Z536Hf3rPoD7CFquJ5PouVXJoXbuE/8n1ZC/ZswEe68Xmi6xFzwAiTCDGWRBkjH4ZNvJl9zY325W0eyRHCKe2vGrARBM7cpVPyXrZb/gaaSdFFXOYiWRPDAXTgorhm/bqrE6kJ/kM+jVGCg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd8e92b-1d8c-4859-17f6-08db93b088c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:31:02.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/Tszfk2rxlJuTEK9/W2R+9lyaM+RczTJZ1PNykcgXcYHbfW6bUYbLApVlSAkF/aUVXzfigLIUBIbePH8s541Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020208
X-Proofpoint-GUID: gNPI-SDu0WeK65Y66LP18NGMqoRZyydh
X-Proofpoint-ORIG-GUID: gNPI-SDu0WeK65Y66LP18NGMqoRZyydh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The upcoming "--device" option requires memory to parse devices, which
should be freed before returning from the main() function. As a
preparation for adding the "--device" option to the "btrfstune" command,
provide a consolidated error return exit from the main function with a
"goto" labeled "free_out". The label "free_out" may not make sense
currently, but it will when the "--device" option is added.

There are several return statements within the main function, and
changing all of them in the main "--device" feature patch would deviate
from the actual for the feature changes. Hence, it made sense to create
a preparatory patch.

The return value for any failure remains the same as in the original code.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tune/main.c b/tune/main.c
index d6c01bb75261..7951fa15b59d 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -145,7 +145,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	bool to_fst = false;
 	int csum_type = -1;
 	char *new_fsid_str = NULL;
-	int ret;
+	int ret = 1;
 	u64 super_flags = 0;
 	int fd = -1;
 
@@ -233,18 +233,18 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	set_argv0(argv);
 	device = argv[optind];
 	if (check_argc_exact(argc - optind, 1))
-		return 1;
+		goto free_out;
 
 	if (random_fsid && new_fsid_str) {
 		error("random fsid can't be used with specified fsid");
-		return 1;
+		goto free_out;
 	}
 	if (!super_flags && !seeding_flag && !(random_fsid || new_fsid_str) &&
 	    !change_metadata_uuid && csum_type == -1 && !to_bg_tree &&
 	    !to_extent_tree && !to_fst) {
 		error("at least one option should be specified");
 		usage(&tune_cmd, 1);
-		return 1;
+		goto free_out;
 	}
 
 	if (new_fsid_str) {
@@ -253,18 +253,21 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		ret = uuid_parse(new_fsid_str, tmp);
 		if (ret < 0) {
 			error("could not parse UUID: %s", new_fsid_str);
-			return 1;
+			ret = 1;
+			goto free_out;
 		}
 		if (!test_uuid_unique(new_fsid_str)) {
 			error("fsid %s is not unique", new_fsid_str);
-			return 1;
+			ret = 1;
+			goto free_out;
 		}
 	}
 
 	fd = open(device, O_RDWR);
 	if (fd < 0) {
 		error("mount check: cannot open %s: %m", device);
-		return 1;
+		ret = 1;
+		goto free_out;
 	}
 
 	ret = check_mounted_where(fd, device, NULL, 0, NULL,
@@ -273,18 +276,21 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		errno = -ret;
 		error("could not check mount status of %s: %m", device);
 		close(fd);
-		return 1;
+		ret = 1;
+		goto free_out;
 	} else if (ret) {
 		error("%s is mounted", device);
 		close(fd);
-		return 1;
+		ret = 1;
+		goto free_out;
 	}
 
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
 
 	if (!root) {
 		error("open ctree failed");
-		return 1;
+		ret = 1;
+		goto free_out;
 	}
 
 	/*
@@ -450,5 +456,6 @@ out:
 	close_ctree(root);
 	btrfs_close_all_devices();
 
+free_out:
 	return ret;
 }
-- 
2.38.1

