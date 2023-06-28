Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B5474108D
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 13:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjF1L4r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 07:56:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37880 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231161AbjF1L4k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 07:56:40 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBTD8V032742
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=AQUOyrJc5//iZmCmNe48oI9hTZBhAJBsg5w5WX7TDI4=;
 b=LEDT5o02qVk4P2AGrB+mwMGFrnihYj5p4wTdqyEILqXID5IyyOwN0G/R4z754qO/ltZI
 1URzUUeKUjvIb84pwH69R0QX1UaohGFZdQ2QiQ852vKo0zVZXPEyyQIXd/Rf3+hfU7i1
 iRJJAOmw/8piUV2vF89K2ggQC1WjJDlim2ZzGLsksw4FpavL9m0LdVs3ND2vcwakGyC4
 E/w45/riZY0lLIck0pU2kTduSWWfrLHFKqpDAmv+VTMWD1d0i3ntaRnAyf2A4M47riHw
 Fa9z2fie+JPjX+jMDna3T/D3+vJ9fzUnWXFABbBqh8ELHxO9eOrGOuYcA27WOFVZhIyr MQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30yds1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBBweT029619
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx5wabf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 11:56:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bc+Y6YXOiqDhNvvClkYT/vNfmY/ComiMTiGZBoJ//IKHQzTOAWfAWaMIN/KHwJIuFuo1tUSCJNYxReZyHLho3b8T0BFNsGwV1Zl9NZRCJcKfB7OnBN1J6agJCQgTb1F4SfoEA4g0v19szJpdzrCZQlV18P7Ofo2i+AAYHSHEz0tbjyw0buoUZaAnDJZJWT3+3DqKcBXG3S1m7KLUXSm5ud1fFz3IJwXuA8uliw6dBd8WBG3keuwCR+mwf8kIw3zsaZ9PbydaSMm7Bk2ygnjvwUkHm/JNwb9G3nWkeCJRPRAkDWrZAXLZd2rwFwWcQQzbNSEGt1Qr/EOGjE7bh3c+PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQUOyrJc5//iZmCmNe48oI9hTZBhAJBsg5w5WX7TDI4=;
 b=QGaLLYLvKmtSQqf40BiXyBVBjrzmysUKu8NTzEX9PCrrSMspjJoJ0xqd90A/GPcJqllTsl/9tMxDOzX4l99lN/+uU9XdaXa2mKKceqPM2i21uAoN51dE1jhw4KvHV9q2psbo6+w3l0N+0SwXWCPkhveA7WTBWzKjH2XS0T1xyU+DjsUZ743mwHPMgqgiFmIsx+ZLrALfVfRwRXkxLtMx+cXMgvWnSGUgslhOy87UxQMX8cVt6VCAFbbSPH1lRKbAFcvExqTJRmhb5ZWKifOZ+Wsg1KdGvc6634jHugQmrAHMxOpOTwZTMQdVLVntpCRPASbIlAkOrwAz4aDuN2n8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQUOyrJc5//iZmCmNe48oI9hTZBhAJBsg5w5WX7TDI4=;
 b=U17VBAHxaJMU0WCebqGeQSr4jTufUt3vsbFex88v0VIoHnG/63D8kDluvpyGavYWN8nZRSuRJ7xl4Yj0xzQgbfPgixwwKAIbDVt0XvAPoKh1ePh0ndujUcsDlVZZ4iw1FLfSahmFIcVxQalfG/HQf+yvZYLPUuW+3DkQsavHqU8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 11:56:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 11:56:37 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/10] btrfs-progs: tune: consolidate return goto free-out
Date:   Wed, 28 Jun 2023 19:56:09 +0800
Message-Id: <07e80c700e3bdaf4acf7468237c5d31051d7563b.1687943122.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1687943122.git.anand.jain@oracle.com>
References: <cover.1687943122.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: a57b7df4-aa16-4ada-2ce6-08db77ceba5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/H10Bq5h+AI1DS+/XdIM1TdZtFPbIXhMelRk170v0+97liLWEFi8kvIHmGI/YgSFG9zpJbtiQBDkyPklGwbNAmihQXAalVv4b7LxuzDfyhL1XUmfccgzSUebt6BliOrUcfObG8GAyKWHuzuA5jP0IKpF6Xh7+TOJ7RSCDhZYvcZzflPux13xxN5kHCltqWFUObQI3bsvFrKLdiO8EMgjpFy0YvZiRuUCEB8ajeZ6vs4CeofedtC8h4lYe8+8jtDgIppVaYGsXFIzRXvNET4TZhaH5rtOat4JvgTp3WOKnh+Wq4RO+veGHSNPue73vwd1489NW7mK3QRF6BqJximSQU9BzDPVhGfeHBZw+7yF3g2sKaHSgkGbB5p5Wt007XhM0RdFR4g7vg33W+dgK56v1/oKtfo+/fIB3AaL9IOAwjlJT2KcXOqejFXmlDo2MY+gg602WryEO/U4a9rZjv/txOf7v7EzKcfXg/fV05Snjb0gBcNeUYk6Q8sOmFo6GuAMUnSVb1SQR4od0QjrL2Sqbu0wGiwIW1nEwnLgLZJfHa3jfenten76AuRB1viHzIW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(6916009)(8936002)(8676002)(66556008)(316002)(66946007)(478600001)(6486002)(186003)(6506007)(6512007)(26005)(2906002)(83380400001)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gqfvRyr/UvsW8Pz4VU2QML6/+aRmv/VtHjxJKxb3UbxJxRMl/d4EkdMBNpnV?=
 =?us-ascii?Q?5I+1xW2e4u3E9SyT3NGVN7j37hGBvh/OW5fLiL6iaUFvYbuOKTMV/BEgTiVC?=
 =?us-ascii?Q?ndrxjQIJGrYQMOy9I5TWwc5aW8CSuv2sVb6q0p2nQqUSdhMgC2XHKWQEleRU?=
 =?us-ascii?Q?O0Nah48eQWIIX60kvRxuHXtq3FEJDjT3cMAWXRxstRxI0+fsRaHJfSnF2L8K?=
 =?us-ascii?Q?QspUMksj364y50qOIY0jgxbXF8aL01to1WxP/vIvtPbMz4t7+a4vVoz1jkR2?=
 =?us-ascii?Q?qImsA4EZFGBP/SVeYEdbIZvfbdFxK5nkxoCCJTVGh6MMYK5j725GrAar9BJV?=
 =?us-ascii?Q?U91ZBeD3Q7Mt3raW/TTo9XAwjUk1+J32UafH5ciNZRSQD7vMyWdHVEDFry65?=
 =?us-ascii?Q?1yWhGqHdQQD/r36Kid0TKOGNbUV7t/fLxWDkp8SXvUWpe1cvjxsAG7vcAhPw?=
 =?us-ascii?Q?mOMBXYySNXUfOe+ifSzAeTkUDMRcKdmYjO6Oh5gDmKyU16yN1for2xOLvTLD?=
 =?us-ascii?Q?Vllyt1XlUAN7pm01Ne7QmsRMcCp4zn0J791fPvF6VC5gampvoQkL2XjYY6zn?=
 =?us-ascii?Q?+CSEL5Nz3Ff35OhJPFcvaUUjX07OM+lgt5iQV4ffvU5usIwdoyY47pzyiX10?=
 =?us-ascii?Q?Ixai301k9zoTGoDg8+urbz0mwMZ7MGuTpv60WatxdbkN5UPK1e9TMkukhrDO?=
 =?us-ascii?Q?jpc4HHNZxwQszedpp6L0O0G6fWgVr2IhiZIBH3a+FOzFXWzyy8gMk/fuz1Ba?=
 =?us-ascii?Q?xv0gVYEgxiojromqNw2lrPN6vd9SyQzdIIbg1qrc5hC7BWZW3Jh6zX9J21c3?=
 =?us-ascii?Q?tCPRMWI2Q8KKF2gy6A6AiRjZQ6GOCuEnjQVM+NlWwVd0iwaxzCxlvwJCInJn?=
 =?us-ascii?Q?QHOHCFafCx/Pah5KYnSquQXyhueBTf6APBWVrYcLTRdqlsvjN21kEI068jFa?=
 =?us-ascii?Q?AFvGeLQERsGhJqVxBzWKmpq1mrW8rgGtTbBAX1ZknCQ/F+QidiHlP8VXJTCL?=
 =?us-ascii?Q?+umJWUZoaYQbF6mPT54h5LVOKm2AoK2BdaNp5dr13SaPW76fD/YUQlloNhjH?=
 =?us-ascii?Q?Bts/8TFy38uOWNg7LGiWh5oMhUzvVynUX2gGOTNn8KsGImAfIWltg/B4Q038?=
 =?us-ascii?Q?aCna/525JRAnFjApMfOUPzXA4yiqN7s9MQge4bqFTjviIeKT98gSmVXTif2A?=
 =?us-ascii?Q?OZY0I6A141Kr2oQMvfP91l87rqVlnVQ5b4SWVYwuQ6lFniPwlBeQQlUJQ9C8?=
 =?us-ascii?Q?t2NXcMiPycLyeBj88icJPVfgscWlkw38+byAmC/jV8DQFFJTtbH1yJXnleQ7?=
 =?us-ascii?Q?jOzhOexuTaPzI8FhfqMOHD4/4qiQ40KoOF+Zeww+RpLHc0bYFxikrz68y3NA?=
 =?us-ascii?Q?Fq6kq4M4GRh3v7pzoL8PK073jaL0zExNezc5tNncBtdn0FXdK9W1nZ+cKbty?=
 =?us-ascii?Q?Tb9mFuisNynmrys7/f/aZdB6lfpu3DuqgeX3uCB0T/GPFbF6ub6VFAaD5zSH?=
 =?us-ascii?Q?6d2SVb38kTuYreMuOlmEv1DGihENieONSQ6EJyf1obcSymMkhaL7ovclXxsq?=
 =?us-ascii?Q?BcKie5MbdG2HZZVFg2Va/+q+jo+ZQa9LzooUUutp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vd/97IAwwxMHahNL7sorNyBEh913Bibquq2DszmQ3d55OgQdkdjbewE7NPKfmCupd/tq5gbTJJJw8yumcVmh1ZPJTCojpmuBST3LJ8LdiFrSAIVtA8r2wqiGICWl9k+f5zhEIRLn8bo79tJZzfsb7khviSdDE4nTsd9mJc06nwPgcs6ZvviaAryO4DZm+NXXDHAar4KRxJaPr1k8cxHeBrydkAN+ng9uI9pG3Tl4SyX4IDD97iADncKwIV9I7uvFtNkJOBXln6r55EVjglIPfL9vu5KHU/iDFS98oP7nc2AzDCRexzcpCg1l9ER7fldIeLE8S8oK/Uw3HGpoV2VupMHhvczSP1kD1I/fs7mwWM1qMY5Gv/JifvrG3p9NnJCpUlRGiuHpNOBJpEDBl8Yl5Hn2lhDHZdRYm/P14Ol1Z2OGJE0TfuIIgFCM1tj0ydO940jKVYwUrm/02K4zN81iNuwGemGtt36T/vi6BvJal32wo/OZXqAfchFdb+CCIjRXycc8JA9a+20Oo6jCaWAjSMXniPZ79B00SAC3jP3ia/qPqSwuRXa4BaQUQDJM3IWSbW+W3YNhKP4Nv2R3yubOZ8yaZTJxVJHBs3uCn+kdPCf3atObZiQahiOKLI3lLnKUAzFEkr0PPmqbRnMXxuQA/t7iZClqfIk1J9t2Z0yC3YuAg5yKUSaL5pBam/l/aefkwH09hZ6nr2hgPIAJOHICZvBtEiXNh0S1F6JRESC+nE01rEwnG+ae4JOzb1K2/uKrFOIYKFfcmHh7WWVEpjBiZA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57b7df4-aa16-4ada-2ce6-08db77ceba5b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 11:56:37.7713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ia95n5f0eYUKEhivcWwkCqn7cYNOUjbRYlz4Qef90fEFWMUHuw4INMmxRA35/olKWPgKIQmNPiR8HneG86G7qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_08,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280105
X-Proofpoint-ORIG-GUID: QTjKO0o60p1m825rZ8qS7VfRr57d3GI2
X-Proofpoint-GUID: QTjKO0o60p1m825rZ8qS7VfRr57d3GI2
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
index 0ca1e01282c9..0c8872dcdee5 100644
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
 
  	if (to_bg_tree) {
@@ -431,5 +437,6 @@ out:
 	close_ctree(root);
 	btrfs_close_all_devices();
 
+free_out:
 	return ret;
 }
-- 
2.31.1

