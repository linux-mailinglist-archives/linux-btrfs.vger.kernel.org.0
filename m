Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304B2725B31
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjFGKAZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjFGKAY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:00:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AB21735
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:00:23 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576K1lZ002221
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=md8s22NrjrDYjNiwJsiqYISTfgNvlvFKnI5RoPVMaDU=;
 b=ocNfuBqsY2Gon3aVV04zAoPLuIdRrAScNViCN6cuOxO95JyH7yFvThnmgraOpXD8M7C3
 rzAGZMjMhmMocV2vNCH1KtUi0plBB7F+61YZ50LTGXk9Eu+Hvjlw67tw/M+iluoENuRH
 OxPbizcWiaR75QW3BBGaawArdbzsexaDTZBVmFBCmDlwVWQCFBBvTgb0WGOync9dyjHj
 1PIGEj4317fCYwVRMrKeWpRoMIoFPANAM5Jx84q4ARqRjVf8xLD5cSjT4ndmDk3brsxT
 s3c8xQuK4vdpmqSUquwZdVQH8ditZdaMvvoboJa3k46abAU+1WkYkVsrh3N2kH5rP88q yQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u1cgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579ZQTT015714
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6kh7au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3p7+c14BSiR6fX4k2q9j4xVLwR+wftW4V508a/5eH1vFy0YgPkIkWbP/vkjurswOSfUN8vYim2PY4/ZTyyLolC1DQa3mU+qutLY6s8ppuFdXr4RGxd2Lqk5y2RMiHtFn0PCuECjfkO4A4i5R9EvlHTBQlAdcUZhfE9BKovOrIjrr23ORCnL8X7TnYCCsnWbjrk05JeDF0OIZKmVQXMIzxTPK3LCNvZ1MG35ZzMnPRhLc+4XMYVocTPuI9XtaG0Xdxo3HMFF8PFGlNOuz+Xr6+czTPfUdq5aj5lR5OleFNSkGwt/f0YJJK/vJvFfLL8rJq81Zybj00AGydxF+c8R8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=md8s22NrjrDYjNiwJsiqYISTfgNvlvFKnI5RoPVMaDU=;
 b=ofAPHArW9oxiQi3vhJbRiKEudmTJoTO4tsb5103G3nZs2KQOG6nKDfP56RRh8/sYo0hTKvKAsl0frqsAAOAIuoJLVHLCaLZHQuelZUQ/GIonKTb3CktX2+as6GG2INAIyBwILWhBMCNbJ7B/Vg698h9lB//nwPUyNjT/reylbTLHsA2kNFDPt8lGq4ErQ+DmgvE7CBgmuYDi62e0Se/t3CN/FMgVLrqCCKM0ESUQibmTOFc6bihSZ9zK1ujjqAjp/dNVzJyXkiRWC1SQMi2AxdOx/pLCgS/NbQTQGXWAQ/lNmBN3Nk42tnKRAXzn+iSs01gRYMrMeDQB3mQ/FnmDGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=md8s22NrjrDYjNiwJsiqYISTfgNvlvFKnI5RoPVMaDU=;
 b=YeF0+5/FIoUGq0TuStJ4QAZQQLbFGafAym1MeST/zeE85nrVh5+Q3idequxnixpNy2QoJT1BVppUHYA2QbAsvrTqRemSeSMC3yjDlaf4i+F8gsgF5UXYVnRW0ij2+eR5rXjBie9CvVNrjiUZ9MF77EKCb0pMtbfSarmM0yll0+Y=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:00:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:00:20 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 06/11] btrfs-progs: factor out btrfs_scan_stdin_devices
Date:   Wed,  7 Jun 2023 17:59:11 +0800
Message-Id: <44721179d1ba7264ba8bdbbd160dde414ff3861d.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
References: <cover.1686131669.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebf2c05-8842-405e-352c-08db673e00a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeqrWUKu0qlgmOP/apU7CbtXGd7PbyEOwgvUvxWFTbkWjgauK4KUKA2Y9+81R7Nzr2oeY7edNBvv8NgVc8x0D/XdrEF2hv+byOCOlcBUI6FFtSz06tBCVEYnggAXLgjaPwLayokA/YCrTGC9978BeVAHhGGfPGL6gXaXm0Z4nvrAbIPbHcwCUDNmFiBDjJLvCLQGiLZKgOV5mWR7duTUBmezMurYEIfQhvGq4ER+cclJbNKwBGoVX7WE7CklnImv2m2MQQcOejl2rGF4xgmTwIeGgXg89lAbjtj+XvzUSkMJCDITW8dRteePhRoKoaOLMWJLnMa5TOr4+uGftGrB45Oc5DXwuUpjm47Ncww0IB8jZXZLAtR3v8AUEYfXLGmQHEdTCMBPDCCoAq1xXl+d1h/oisuV19GGYi6JvCtmyS8T1HDiZrsYFhWFS9a9/XfmZucY3sGaymllnSGeo/l9D6HCh0vzrSdjdNyj/eil+o27wsT0UB5+idwfWhWvuIyGJ7HBAw2AjnCX8tNwwRqE8KtllZE0fFOysJbHuSZKy6TvwroBC2g+AEhr0X6w4S+S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aKeiuKHgH5ny3e/zzThrDwccfKWz6vKrbYNeBv60IaksqE3M5rAer16o1/t0?=
 =?us-ascii?Q?1/vwiGIHi76FgPLjT89s7UjL53x4tasys+uBHJDTZdDpO2M3cFz6i4KHa5CI?=
 =?us-ascii?Q?ZefokAXN0YCYeFKNKxzB0XGtPUgKUJHYmpB5U0JT/A6jfXYuTlKuXCToZOUE?=
 =?us-ascii?Q?jKYXiG3+g8TYtdD5l0iGDIjrCM1LnvArPa1Uv31OcxVCtRgxvLvtXF0GGgup?=
 =?us-ascii?Q?hR/elkOdYj8PoydXRzSQA3oQb2i4m8mbspdBvBw+YP9wXLRCTGrkYPa4b3KK?=
 =?us-ascii?Q?08mhuDnlY7K84zCPzE9D5V18NaScjF/kvyo5uzw2m4TypBqexqks8Yfqi+28?=
 =?us-ascii?Q?2Kzkx+949nM1UUJtJO4CO95kt2yqi/oZ375t/S7NlilWfgg7qAMP1wXhJAEx?=
 =?us-ascii?Q?iY09XaxUlDEtvFX/PiDove7CdteeQQpKpHizpEBCWOfXuRhcrI/wYaQ2qC6h?=
 =?us-ascii?Q?vxp/1fCiM3xI26wRKmqcbeLewGrTWaW/99XDS7rk2/8/hLsqHcmCv9hQh3LX?=
 =?us-ascii?Q?7OHVRIimXU7qIqM/ICRqbQPRjN4E83THbmu7JHflkfm/8dbNZbvEgc28jopQ?=
 =?us-ascii?Q?ySVmRIIko/LVMnNz3fUMVvePU/cIi4T0BuPAcoR67N+tmityXT77vzKVjeWD?=
 =?us-ascii?Q?o2pv1IVtEL9TK6bXtiRB58WXdKvQaBghKReN1aIDIqBVX3bv5SmFnjBJ1TbT?=
 =?us-ascii?Q?8txIxAAUqBD7tkMHcx9kvg/Fd0LN2/POSj0uCn+qzASJ4UnZ0nHlegvhLvBk?=
 =?us-ascii?Q?FhA3vA3gm0PiGoxQ0Ym2wiwGrxyXQ6YGtYYySCpcKkz9T2NHSL/Sqg8xI4ao?=
 =?us-ascii?Q?5zn2QpfOsY484rAq8FW8RjdPfescc3FPs6VDL2CKyau374NsGI/kRurOw14E?=
 =?us-ascii?Q?ogE2Cl6QBP3TGsOC5Kop2ndfVrMFQRxhE9TiqxlSzFX7jW58bVEtJaUs5PTh?=
 =?us-ascii?Q?lRwPqlteBDKFbcHv9ZwkXzzg5uBz7/Onuftxths5jjw8c63RlTUJsdpXkqtF?=
 =?us-ascii?Q?+0yaBn4e4sPa3v8RV1NQjslIxyi1JR5BoVjyV+zIXRv30y5fiLmD14VHObd3?=
 =?us-ascii?Q?UIraUrQtiYZyZnCVZ/SktNhEsX+8goaSzRyg6YD/xNjsA/0+kkKY8Uw4DNGl?=
 =?us-ascii?Q?gp1uN4enNuMAF40yxDfnHWTdSjlk1HZaYHS32fzQq0SZunC5GU/gruiaTjE1?=
 =?us-ascii?Q?1xzHE5mQo2ApW4AHL6cAZH26sEGhSs7F+xYsGOReb14gq5yZoZ21zVQ0SREv?=
 =?us-ascii?Q?wGwi9F3fzmQxl9leuIfjtPL8kxy7EyZiZwWHnDnLFbvQGgnWlGsJEmgAPuYF?=
 =?us-ascii?Q?DZ52ZGkWqRwBmksSfTKkVk5o4mC2EZYB43SdaOQYQb8fHBlnyvCCT53hpwRb?=
 =?us-ascii?Q?2ZiXBnvX4dE8SVmxB5qh+fP/UOn1eALzdrLUOKdCcREDG1rvNTZewKMxMdan?=
 =?us-ascii?Q?1S4vPKo9pgjg15G9q1A3s0xNY3Y2iBLpszxMVc9zC2pqVFVGdcsSNSc1v5pw?=
 =?us-ascii?Q?CtxTs7iEF/I0ODxtgT+ceDSonUTVZavv0Wnw0ypRW+5JkOxCVe9GlBbH5ZaB?=
 =?us-ascii?Q?ZPBciS4mmceIm/o3Vgkr6LLdSB9O0a5bgvuetdqGWFITJZWEA1vS1BsWjixj?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9Ot4bsC5cM+zt2e9+MFZiIzS9wuHqtyDF6eKEkMYHXauj6yCWd55/Ju3Ih6/f/xDR+4EQM+YEiQV1DZEUiBTnHiJp53YrrHOfKkpyLFrybwua/byLnARYpudyMirVa8B+mlP70QY7Fkmroe/l0ajM30HCQz/EuI+rdPLhsnlgAUK0bobSlKqHqpjs6TIo1lJOSODioGoAfUlx1CCyPwDoOvus5OWsX+Me3WiIKPRwFrVWvceZwR5NDTAWDINxUWQfl9eTmbVrgJORqA/JHKsf21hPN1FKLmLGKXPAHxzaZAHpuSxXTyHC2uuSz14fnE1jF85P42jsl7XKqWtcfwJR58Xq+4flRVwaMdSZxQr5woFukxrUU9MBrBWY1lQ+JhBhQJBwFNDQucew5wEcWlkP7AGpWTV8HGNyFtBsdDmbaiOwuEhKaEc8i5aXQn1K0N+Mw6KiMrHrwGD8RJmUkP5DaCm8IwtVxJr0sz71H/wwir/7ME3hoanIK3SaSTCdJJ0wIjNe8ak4cpaUCEP9hAEd+dz1Jeuzn02WBNUGduqQWYTsm7Tp9J0fZFpKh9i4vl2oOqixG/UlIc2eCeFT6vggDncc1qsK5FOYLoYjCo8ubgGcyM8GbisVyD62mj+vCByoNt8eKa6RsPyPQl8757oH9UaKOx7And4h4eaE+z8M35LgvHjrU9zmiLKFsrx4xXMBTsdkQFmZOT1k5N89SoLPMhY/0YKxm+YOKFt4VoJRverGMrWO+iP7tXfKZALMCveJNQUVRQMeVcRXDC/m1bpiA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebf2c05-8842-405e-352c-08db673e00a1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:00:20.1840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzieEUa4FMagtm0D+H9gBG5U1D2Jn265ePj6iz8D9a7sNvEB7ya7TPDJJkyRa3F9OF8HvOtFC4YQ4+hZqBV0GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070081
X-Proofpoint-GUID: 74N7D3gwE66pFnXNHZwnPCR4JG1MR5Rf
X-Proofpoint-ORIG-GUID: 74N7D3gwE66pFnXNHZwnPCR4JG1MR5Rf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As a preparatory to take btrfstune device list from the arguments factor
out btrfs_scan_stdin_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 cmds/inspect-dump-tree.c | 37 +++----------------------------------
 common/device-scan.c     | 39 +++++++++++++++++++++++++++++++++++++++
 common/device-scan.h     |  1 +
 3 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 35920d14b7e9..311dfbfddab6 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -327,7 +327,6 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	bool roots_only = false;
 	bool root_backups = false;
 	int traverse = BTRFS_PRINT_TREE_DEFAULT;
-	int dev_optind;
 	unsigned open_ctree_flags;
 	u64 block_bytenr;
 	struct btrfs_root *tree_root_scan;
@@ -456,39 +455,9 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	if (check_argc_min(argc - optind, 1))
 		return 1;
 
-	dev_optind = optind;
-	while (dev_optind < argc) {
-		int fd;
-		struct btrfs_fs_devices *fs_devices;
-		u64 num_devices;
-
-		ret = check_arg_type(argv[optind]);
-		if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
-			if (ret < 0) {
-				errno = -ret;
-				error("invalid argument %s: %m", argv[dev_optind]);
-			} else {
-				error("not a block device or regular file: %s",
-				       argv[dev_optind]);
-			}
-		}
-		fd = open(argv[dev_optind], O_RDONLY);
-		if (fd < 0) {
-			error("cannot open %s: %m", argv[dev_optind]);
-			return -EINVAL;
-		}
-		ret = btrfs_scan_one_device(fd, argv[dev_optind], &fs_devices,
-					    &num_devices,
-					    BTRFS_SUPER_INFO_OFFSET,
-					    SBREAD_DEFAULT);
-		close(fd);
-		if (ret < 0) {
-			errno = -ret;
-			error("device scan %s: %m", argv[dev_optind]);
-			return ret;
-		}
-		dev_optind++;
-	}
+	ret = btrfs_scan_stdin_devices(optind, argc, argv);
+	if (ret)
+		return ret;
 
 	pr_verbose(LOG_DEFAULT, "%s\n", PACKAGE_STRING);
 
diff --git a/common/device-scan.c b/common/device-scan.c
index 515481a6efa9..38f986df810f 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -500,3 +500,42 @@ int btrfs_scan_devices(int verbose)
 	return 0;
 }
 
+int btrfs_scan_stdin_devices(int dev_optind, int argc, char **argv)
+{
+	int ret;
+
+	while (dev_optind < argc) {
+		int fd;
+		u64 num_devices;
+		struct btrfs_fs_devices *fs_devices;
+
+		ret = check_arg_type(argv[optind]);
+		if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
+			if (ret < 0) {
+				errno = -ret;
+				error("invalid argument %s: %m", argv[dev_optind]);
+			} else {
+				error("not a block device or regular file: %s",
+				       argv[dev_optind]);
+			}
+		}
+		fd = open(argv[dev_optind], O_RDONLY);
+		if (fd < 0) {
+			error("cannot open %s: %m", argv[dev_optind]);
+			return -EINVAL;
+		}
+		ret = btrfs_scan_one_device(fd, argv[dev_optind], &fs_devices,
+					    &num_devices,
+					    BTRFS_SUPER_INFO_OFFSET,
+					    SBREAD_DEFAULT);
+		close(fd);
+		if (ret < 0) {
+			errno = -ret;
+			error("device scan %s: %m", argv[dev_optind]);
+			return ret;
+		}
+		dev_optind++;
+	}
+
+	return 0;
+}
diff --git a/common/device-scan.h b/common/device-scan.h
index f805b489f595..e2480d3eb168 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -58,5 +58,6 @@ int add_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[],
 		int fd, DIR *dirstream);
 void free_seen_fsid(struct seen_fsid *seen_fsid_hash[]);
 int test_uuid_unique(const char *uuid_str);
+int btrfs_scan_stdin_devices(int dev_optind, int argc, char **argv);
 
 #endif
-- 
2.31.1

