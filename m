Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D6B72DF67
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239257AbjFMK20 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241193AbjFMK1r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:27:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B92619B
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:27:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65OmY007957
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=zOYczwhFiwIt+o5MJ4pkVRAZwB0Q5X4QUrE2xAjDb+E=;
 b=WL7rbpjhMQLNDq83mGIHHyjRdyywOWiyJD9i88wckphwX/ktMB5EMKUkeWTgZut/K+Em
 CnslG27Awik0cJtTyfVYwQ5YoCnoXtzKwRWzd/2Ir/FQavuq/fLOoHa4rorIHXQFGdJz
 8aBkMvO+bheaI46DwsNHTu0BWmxX5+AD5+G41aqgnVzEuhNlor0UVuUBk+EJrrmVNA2F
 VbR5fHaeHllhoQBcvPErBYWLy8Rq4s28k3Jrtl4SWIrbiBJK3XJCKZ3y3WgcqyGV56S7
 ZMr3OLtaul/PRDAwoC8tZtE35gqz5lHYdEeqyrt6be8qg/+3sRGEz65rVB43g+9Zob1a UA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fy3cw2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D949W6008378
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fma817h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:27:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/XGH211aNPRV/j+l5cSLNYQV979w6u67CgpNUX6i1OUkTaO2sTM6mFi9FELVY7JL4av3GVlHLn7qwZdnNiLAoVEkuGmWuE809mJMYLBNoc9FtzRHSZmf9gd1Cz0bwnnqoL01dP4xjfV5eQ75VF7vIxXcY5KRLeiuT562UJxcklMhpDTo/D+Jkn6Fc9Ih7w8kKU5Fdu5aG7IKK3DodjaJC1QllNpR6bVSLD7S0r57WmudvwCn4m/zKPpWyTOLTiROWdArzy1/Q6LDhj9C9uCF9Aac/VQOodmhNsgIz1391TCRCKS/qnaC14Hr9V005xPKV5ulq45Tbm7rf+03nr1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOYczwhFiwIt+o5MJ4pkVRAZwB0Q5X4QUrE2xAjDb+E=;
 b=MOYyhVisCH389OfcgpXmp8j5QEUG/TEsSgoO0rvSJZurvUy3vWuMziIIIk6rNN9YfT298g9sZlPxAOgMHAwl3CWjEP3xPYWRBMQDn1MEj2hyMgs/JM2lNz0x1x8YHyfxnsKIssoAI+C7TnSex0JicomSy9uXJ8nv9J5C96WW2MbFg6PbDj48LH7qniwBQFStOGdhWxNRhOoIBRU0nVWuiyDh5l23RDQyrq4IIwilhXoX3aZ+b629uHzOAhgUOBW7SN4OVOHfIbYZM4OV9XQE94a67I8wRGqO0vEz7s30yGcrc87hrRcyazAPfJ8/9h312w/T4xDEdNtsDZFAIw6nqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOYczwhFiwIt+o5MJ4pkVRAZwB0Q5X4QUrE2xAjDb+E=;
 b=H2dCrGppEzCLTPzQ3aL6lQhL+a3vQ6Suhho+6ZLnwr4k7GYQFqEnAtUdU/C0LeY7lcHNO2duK90R6j113RzdB4uTPrGMaWfQOgvifv0C+6O19i8vDVVCNARF3W8PcwJZfS9oKNVSTvdvurtLCGvfyNhJQnMTJqqnlktgB1FX1tY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN2PR10MB4398.namprd10.prod.outlook.com (2603:10b6:208:1dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 10:27:42 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:27:42 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs-progs: factor out btrfs_scan_argv_devices
Date:   Tue, 13 Jun 2023 18:26:56 +0800
Message-Id: <e635739e6aa18e70036ddcf63019cf0e4d4493b0.1686484067.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484067.git.anand.jain@oracle.com>
References: <cover.1686484067.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN2PR10MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: a3da2556-4df7-4633-f2d1-08db6bf8d222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3TXKmgQJy/DKkFGTAGgkJbDoxw+JCeshkNGxw0gAafzOrSBFqKWANsNLcaH3S8npS4bv6X2sqET5qj90Us3G9NYiFucqZrqaBSfbK545LpuZpOGx0O7wBGAl9Wb37HUJCzC4QvYPAIaaDLwnqOKDsSeyIIxKc3F32gTUWa5Te81YmtNorxnzDCIhcY+9teDIaXIHaRqzG121Twf9YLdG/6cmhZKiB5ysAqpdXVt3U+ei+Lk0VEzzcrQXydShL9ZPDRLHkMhKyCe9rIVgraUbbtXsCKXG/bdUaLdyIGogxDIP1bPvOCxSY6OTuKPPZ4okhstQg1yiO0t8ro07s8sgmJC8ya7b7uPFsgOY2P8/onjuDC3E8U65SaMunCjMe5MKvKMHs+qPA5V70ZO3ji8g71WZ7LB8bL7TgMmgN/l+kHd13l5s0eWnYiW3xBARwqjmbIs4CkSBYCo+bH5rybji+ZW8zmA4R/uDnPq0e2f3JSRa0cTEUFDF6KTYAwA+uNWxkMdSaAFonNo5cV5WvdMSeoBrS01mGCF5fVkc+xw6twOaLTiZVv52Xvgs861n4EXi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(38100700002)(5660300002)(478600001)(316002)(6916009)(2616005)(8936002)(8676002)(66946007)(66476007)(41300700001)(66556008)(186003)(83380400001)(6486002)(6666004)(26005)(6512007)(6506007)(44832011)(86362001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x3M/CWomUTqqNCX2Hew1BdBvaXGb95qpazensI9CLKV3C1HkuHYjGxWzflTp?=
 =?us-ascii?Q?+JdifzpCN5qQukbuIsGe6bzv1UJJV+WrieJro2RIKBCu0uD26u3mB+NYwUrZ?=
 =?us-ascii?Q?X14kQD9cbYjhPfbZOYg3jt74a/gHCi3YDTmNERGV5HVQBHN4mkCf9BMVIBo3?=
 =?us-ascii?Q?HtPI+bYeVVi7EOfQyjLMqHnufcEbTcjJ2hZRu4k3mi64Z8KpIpnQQvSu+2gH?=
 =?us-ascii?Q?A+/YZSckLskzCSBMwxb9kCnuGowkq1mLff50Xz/KdMLxbQ6LFLiTB6xiC4t4?=
 =?us-ascii?Q?2Me1LWb7kmUjGkjhWUsuq6L5tKX8Ej/hqYL5thJEhOJRcrpaF5+MSL+Uya+w?=
 =?us-ascii?Q?rHu4DZNkQqdPxoQqwlptu4qMrwoC1zIzjQwS2X/4yfJPf/hBLmlu79ICwVhD?=
 =?us-ascii?Q?Pvr7iQAWNLIna+LLAqjYfXgk63hbaDNjGCpA53g03WGAmUQmz00A9gpt3QxM?=
 =?us-ascii?Q?SiIGjTDFwtjgOUk3v0JZ7g0CdUD0awfK2nfK27cYmH/c1B/dgqrcu12XSJao?=
 =?us-ascii?Q?sV+MBoOjcKQ0s8Bjgx21S6Ujvk/i43ihtcm1EPK3HifWoO0kqdd1TOqD2UYt?=
 =?us-ascii?Q?f0CMjfn/5/ZLjXO5QBUnCIoopgLitGoDaqknkRdkXsO5m5eg3HaDd/7zj/f/?=
 =?us-ascii?Q?mnbHctWfUp/kPUQSXVf4vu510PCREbUxBd4mklSW7EZ4DlzOym6EVjSQKmb8?=
 =?us-ascii?Q?SqQLJ3MDohhmkJRjOTJuqWr56IKmDfHIKSRIJaflN8NsrPjdenR4qPTVE9CT?=
 =?us-ascii?Q?UUi1doERWKiVf9i1urLwQqi3kI9hWGk+M+FVJRjHM9Tno/ihprv4356q+8js?=
 =?us-ascii?Q?MUvpuVAwdPbsXHjrUIc5eCndi3viSsj3nXrfkyt8hO3iTwh9GTtm8VGQCCXO?=
 =?us-ascii?Q?3qjpqc/ZUZX54BvJn1XSZw+7me+Iipx/ANR8nmuB3T3hcvow0kfKzsDYd3Xt?=
 =?us-ascii?Q?edMwPwEs0BAjmJCf/BFQfLm5hw7jYNhYamzyYdQedLCUhychU093b/Be9L2d?=
 =?us-ascii?Q?h5QiH5SGpTMGVQfkSP6HR/QuVDrgPWILjI94XT0TYax0m9Jc21GR3LG/oFXg?=
 =?us-ascii?Q?PldVEOmqSlG4/d5t72CNzLK3+5+B8KW1QtI9LYaNUTZfQfLwVp1LmypMdxq1?=
 =?us-ascii?Q?+4aLx53LTTP2Kri7k5ib4PhaMZYkZmqMLP9NCqCrLf+uPsp7ZaHgis7CdK6B?=
 =?us-ascii?Q?Y4AA7M3WCgbnaouIyGrBcSS90D/NBZSrHtNM8zoJkbiuOICLrfdegZpBDU3B?=
 =?us-ascii?Q?gcsI+XIyZCFTDEiEBSXC+FpGlNMBX6gqMr0+VVQbJhRLaOQFlYJs6T0vuwh/?=
 =?us-ascii?Q?yH5TZL9Pbglqfztdimr9Rn7O7aGK7anui6pudcEArChWq0CpO1uXUItl3XTg?=
 =?us-ascii?Q?xESMrJ6cLIp86LTSOYx7bQczb4ANSkrHVH6O8/zcM7vwMM7coL4DnHN7TkMj?=
 =?us-ascii?Q?7+r12GLpyhpM2uapxP9ctna9/QFIEYShCMhUDLD5UVGMvShLjsLsOz2NV97x?=
 =?us-ascii?Q?ivkaoOrvrCaS8ugugFd+z8cATaC5IRSsgJLmAXVq4GYQXTATVGWX/QeGASio?=
 =?us-ascii?Q?EuaeD+x6cKAHYuiN/WF1M0wskrjG/Xw5Wsh5irnY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y44xIa+DeIBJL935LaGgiwpqmtV4xsENMf0NI2kp0PMYrV8gqOZQ83myj4DZpag8rA+oywjBQknJX5qMHSVj5b6CZ65xatHmjcuR9kk2XoYQavnSUS3sS6N1nss053lNL0klU8aqhETLMVi5pXQcMoh+l/owgV371mkfFL9K0y1nxccOzlBuy/KNu+7hQirzBViU1JPAlh+sBIx9omng0iEgqP9w8xbV0xXmojd/L4INkbB7/HW+bYD/4V7iU2L+sKm9WQDn5Jz9gfi7DhpYZa40E03MJ7OtCfapYHAxByp8oHEKPFsmP3LaFu+hibeVvzkR0ISDtff5hCzBqoqDS/VfYhgCGET8wlL6EFP6IYBpTcPQpLkWL6Ox/RtTO1+rJuJrmR1NxOJDns4ofVmRuvbuYOrqInzXdiHO75fZWtfQca5xRZvdyu3j4PxtH1QKyrdw8gIz0FtiWds2iklB5G3UKH4rDrUHS+56zwJ+To4zb2HrEtMdAqxe5QD3Qp3o6jhzDmbByDnuQzrQZ2ttmPP0ec0U0WxQHhXUe0GqVqU5vWFPYdyi6D3kIb2is91nFAMDpi+lcJocCPerkYDezzz63We1Q4Dv0u3zDP7BO/LXjQkCfxgOEpBC1mZXNRLkd+rGX6EpX1ljUc/xeXD440GTUZMLG7enJ4sYbU0pIRc2ePw2miU/FaxTkdXQn1KP8BlorDL/zmBtD8r4UXHvY4hb25Ts2g444G/VTdFXTWPZi9YuJBq2d4POCIBofFKjRrnLPC3xET1iSj7qyUrrbw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3da2556-4df7-4633-f2d1-08db6bf8d222
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:27:42.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXsMkGoHmgl3/jJciAdeI7ogadF7Rvh79gX7MKyc5hL0PpgcvmnKcV2M0KL9htyjLO6mpW7jQRGFCgbBNYHAHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130092
X-Proofpoint-GUID: rHLmFGgvk2-avRYMA4WbCTgFfGCZk9Fv
X-Proofpoint-ORIG-GUID: rHLmFGgvk2-avRYMA4WbCTgFfGCZk9Fv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To prepare for handling command line given devices factor out
btrfs_scan_argv_devices().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Rename args of btrfs_scan_argv_devices()
    Rename factored out function name from btrfs_scan_sdin_devices()
     to btrfs_scan_argv_devices()

 cmds/inspect-dump-tree.c | 37 +++----------------------------------
 common/device-scan.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 common/device-scan.h     |  1 +
 3 files changed, 44 insertions(+), 34 deletions(-)

diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 1d2a785ac5c3..50b792bbc4e7 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -327,7 +327,6 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
 	bool roots_only = false;
 	bool root_backups = false;
 	int traverse = BTRFS_PRINT_TREE_DEFAULT;
-	int dev_optind;
 	u64 block_bytenr;
 	struct btrfs_root *tree_root_scan;
 	u64 tree_id = 0;
@@ -455,39 +454,9 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
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
+	ret = btrfs_scan_argv_devices(optind, argc, argv);
+	if (ret)
+		return ret;
 
 	pr_verbose(LOG_DEFAULT, "%s\n", PACKAGE_STRING);
 
diff --git a/common/device-scan.c b/common/device-scan.c
index 515481a6efa9..68b94ecd9d77 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -500,3 +500,43 @@ int btrfs_scan_devices(int verbose)
 	return 0;
 }
 
+int btrfs_scan_argv_devices(int dev_optind, int dev_argc, char **dev_argv)
+{
+	int ret;
+
+	while (dev_optind < dev_argc) {
+		int fd;
+		u64 num_devices;
+		struct btrfs_fs_devices *fs_devices;
+
+		ret = check_arg_type(dev_argv[dev_optind]);
+		if (ret != BTRFS_ARG_BLKDEV && ret != BTRFS_ARG_REG) {
+			if (ret < 0) {
+				errno = -ret;
+				error("invalid argument %s: %m",
+				      dev_argv[dev_optind]);
+			} else {
+				error("not a block device or regular file: %s",
+				       dev_argv[dev_optind]);
+			}
+		}
+		fd = open(dev_argv[dev_optind], O_RDONLY);
+		if (fd < 0) {
+			error("cannot open %s: %m", dev_argv[dev_optind]);
+			return -EINVAL;
+		}
+		ret = btrfs_scan_one_device(fd, dev_argv[dev_optind], &fs_devices,
+					    &num_devices,
+					    BTRFS_SUPER_INFO_OFFSET,
+					    SBREAD_DEFAULT);
+		close(fd);
+		if (ret < 0) {
+			errno = -ret;
+			error("device scan %s: %m", dev_argv[dev_optind]);
+			return ret;
+		}
+		dev_optind++;
+	}
+
+	return 0;
+}
diff --git a/common/device-scan.h b/common/device-scan.h
index f805b489f595..0d0f081134f2 100644
--- a/common/device-scan.h
+++ b/common/device-scan.h
@@ -58,5 +58,6 @@ int add_seen_fsid(u8 *fsid, struct seen_fsid *seen_fsid_hash[],
 		int fd, DIR *dirstream);
 void free_seen_fsid(struct seen_fsid *seen_fsid_hash[]);
 int test_uuid_unique(const char *uuid_str);
+int btrfs_scan_argv_devices(int dev_optind, int argc, char **argv);
 
 #endif
-- 
2.38.1

