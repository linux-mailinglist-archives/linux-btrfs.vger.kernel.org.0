Return-Path: <linux-btrfs+bounces-1161-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E747B81FF67
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 13:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752B21F23E9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Dec 2023 12:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1C1171E;
	Fri, 29 Dec 2023 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YUed6LMk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ScLM9zwx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90B11701;
	Fri, 29 Dec 2023 12:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BT8Ofs2009485;
	Fri, 29 Dec 2023 12:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=xE+SLTtEHhOf0HJNjp4iWCAdTlyI04ys4X+syMPFgqA=;
 b=YUed6LMkMEjStrd5U9GqgrlljLK3SOwHLSz9206Gk68pmIaE3Kt7Ao+FztsIPBqUlJ9o
 yOv8MqG9AqhgXCfhzlvYjodtIWII9w0GnMRlgDzS04JTNrQIQcFO7cYgjOGFo8+QT767
 nYQuOsU5MUNg3iipxg3IQf8VN/m5VSYTwckNqrgqz4WAuI43buf/nibTshfI/1Kbwp6i
 bn/Yrehc0y/mXmEOtm8088GcS13JSU1L36j+bB24YGpnyJFzYV/avMmEhVNjiWjcyox1
 M7Tfaw4N5B7LBkLKAI14uPd8OoQ9gKLraDBsRr46TwuyUESo7o+iSnBw/pQroRcHmBy2 vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v5q5ufhb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:43 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BTC63lp033534;
	Fri, 29 Dec 2023 12:23:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v73ade3n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Dec 2023 12:23:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/rB0zoNUTj+R2xCf7y/wxxhxCLwLrYiZrNKjibU0qf4kahlyMhcAad7w0cX1rjFTmMZML7t9FzHnDLOW5WuL9AHMQMs8phDZQBMvU2obiY5vEhMbiEDVqzIpHs4x071SsfQEp0xtc7ErMLbS4aFPNmssBtTFdd9DeurBg8N3VfffZx5plL7bvpCyQ38UhaFW/s0TvCfVWOEoWGnPe8B2/ktyablHNXdwGSt2X+GGjO6G8XibCWUh9t08A9kT4RVduUvlj6nKB1yRnB95tfZ0cWAKZYdDSHbbdFjF1b5g2u4wr3/9xsaM3z8dZ/LN//TREfo4Vve4RhbQJD23fYIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xE+SLTtEHhOf0HJNjp4iWCAdTlyI04ys4X+syMPFgqA=;
 b=mfgIgKxlUhMfPXoslLWt8xXN/tVFpyTOXtB/8e+W1wSQHhQF4MZ1jgDWjTrXD9hPSXao3DtvY8ES4c6+rOKIJNnURQq24dwRoB305ZrJsOOdiZYzv4vqQw8f9XH7mp6G6cMbhO6wMT879YHJLyIC2w2Xj3I06rbhrcnvYwTaQ2/BDn3p/pSt/yXM+Qm+nlQfrVOHR1wTkrCHinKIle6aF7XSf9Nu0asd8/Bc3ebnFc+WJd/LpqVDqiuVjtVIit7L9j4YQaDjq+8al/fL7btHnkomBYeHX46CUWDrnuBsnUZBmKsN53faUnU67I7loKmw5MRio3HLPjNLODAWCB2N+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xE+SLTtEHhOf0HJNjp4iWCAdTlyI04ys4X+syMPFgqA=;
 b=ScLM9zwxeXyMPnGF9KcmWBH/TdwL11h5h5yAS3HqEgoxS/Zo31Z0nlyQY7kHGmdzZH3JzOE8L3+O3DMSxnGmPojrcW9KFnfTPh9eUYj0NaoVNpVWmDjohVz7qRk78ezNNMXQWMK50RQ4rjGM/OWrVpT+DFHXm7Ivsxq8IqNHvZc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 12:23:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 12:23:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, johannes.thumshirn@wdc.com
Subject: [PATCH v7 09/10] btrfs: add fstests to write 128k to a RST filesystem
Date: Fri, 29 Dec 2023 17:52:49 +0530
Message-Id: <33e0709eee01e7af870efede1b880260359daaec.1703838752.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1703838752.git.anand.jain@oracle.com>
References: <cover.1703838752.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4360:EE_
X-MS-Office365-Filtering-Correlation-Id: 97f68618-81b6-4614-db82-08dc0868fcd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/5QTOwNu89dfLI38UTbxAbfSjict9O4yrnSZriPWY7chjaLNI8lgp6nCOmxFJ1de6FDMiSY9b4IS/euBCxTJFzdbWfu/KHhpbPu3OjAUmnTUpyIdr6KdP+9h+sikYfwQ8FLMzGikLZfKBNzZWj3DswgTnELv5/336g9bf7ocBkiG1KOYXgJXkTidamLUhBpna9VQrBCzBUk3ADV+2ZCABrNAR/KAGgie/Abnk1geAAJSe3yzmQM1He14Tx6sstgtFhNDEZm0JF2eckBwoM4WsehCEZsyVr0ZplldKxOfVweez0fI164HoeuvleJUoiDsID8UJrGw1GFhr8gcrUZnYxoApp6dBvfUmXlLr5LHaijSjG2FkAQcR4bJqZgulmmHCPhUDOJYfguo/hbsib6zIqXJYA0PeoWIHe3beZRXuO9EslMqy8p08VvOiaSfI3U+PaBpdZnR0SKtNGJHFBZRopHuczQPNQX8HnrZVJPNVoiRQm3bFuNApGOzupE0Puqs5BsXIYt8d8+bbbn0Iaq5+hP/bbVGSYU9zuDzAxw+gxZXBJnxAlycCOXptD3hx3Wt9obGTF35h0PmwIBQgVjgBqrkNZW3PmtjngTMp9I0Q8U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(6486002)(6512007)(6506007)(6666004)(478600001)(66476007)(66556008)(66946007)(316002)(6916009)(41300700001)(38100700002)(36756003)(86362001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kYVzkPpefmc/UA6OmcNcyMB9G3Oa1gurKHfPSj3h5/s8hoYcC94yuNbU0oBx?=
 =?us-ascii?Q?Iu+qnLaBuR/lyzAwNtfwNclxxZzGbs6HHw+f1iP2OUMizLq0OqfnLrV93PwK?=
 =?us-ascii?Q?nk5KVY4l92nnHuZ/4P6qbqRrGEwgnzt1xVEntYT60wkkbUmnR2uO6Sqmslmb?=
 =?us-ascii?Q?Ve8ss+btcemBa2qvsLupor+679/NsFYu4UTReqKVBidisMm/wvzf7qudJ4DJ?=
 =?us-ascii?Q?25n6MmSaDxGVyv6oYTI4tB/iIzpGJDgOtY4cPQdrs2SJyDjyyNdNhBKJ8MZM?=
 =?us-ascii?Q?eflkNGqZN1lOeRv/FBImBkT6WXiz8Bcg2S+LV+FTxuyrxO0+D8gEuMg+Gsop?=
 =?us-ascii?Q?ayCNhctJSaNYvFIIHoq8O4R7EjiWhKdGn4K+zqDaZ8fQIlFosr88eJN6J6Da?=
 =?us-ascii?Q?znHHLIawfezZoaqPDKCSAZnpXY1IQH56tlGB2jcgq0Cz/lVO475tMnQp7BXj?=
 =?us-ascii?Q?Y6jClKvybh1ubOTE4ZgJ9fuEG9vswaGmHg+PAI/3KDF4wuLfe5QLzrT5fYCq?=
 =?us-ascii?Q?wrs1H0Ux3Ekc/DzFha33QJUk4unFuneFxb7ddS+bGqnuzTSP3XBgdePWfhHa?=
 =?us-ascii?Q?xqp7/+xugdUEFE/BYzvY3Y+F9DYATTluIl0iKvPEJqEeF8QcXqIR+Vxb7VTS?=
 =?us-ascii?Q?U+7MPrrQ6NCNQcI7c9gCyEtNLeagVHQ+gRTOfNvABApXPDopsVzpsL2+uD+k?=
 =?us-ascii?Q?ALGLJKdyjAfDAj6W/lW2XO0SffEuSvWodcyAJ1I8+CKko9/oWGId0UxgSy3e?=
 =?us-ascii?Q?ctESg67/+2VHg069DOR0OsTQVkAditYigoNrosLFsj1hZa2ShE7qf18/o7dK?=
 =?us-ascii?Q?UQw6kbFlZExZyo4j1Yjuo+szEw+MCyOjAAO2SMZs508EWfLHq/Uu3GUSCVbn?=
 =?us-ascii?Q?eFE/jcd4Bpjn57OUzKCqKDA5M/itBTuORmN2DZ/vbdnlluXOq1jQbWkCpxJd?=
 =?us-ascii?Q?aA3sky2wPWcywGGupDqdtQrmfHlzB4RCo4pdzEjoTqExjQ0k1+MpEPxf83UO?=
 =?us-ascii?Q?V1ShZ7RzOeGZ2by7e2XrKcRn1tB+PPsoMzvZCpWCBW0jmVSL4qTERTAriMHD?=
 =?us-ascii?Q?pZgWe1CJ7zSjcJDzJB70Y6V7duNz5uW3mKeDwR8LGhTe12S4hx3flDMFalHL?=
 =?us-ascii?Q?WOA3kWz1I+Z6AoDFU9FWmIwVD0UxsGoqqR19g2QIuVZHvldAnPWBhsf+Z8Qk?=
 =?us-ascii?Q?nbEQMXscyHI13FPllmdKqh7bNpr1sWnDBg3Vd9Q9F9GNCq/7bTF8obZ5hsXn?=
 =?us-ascii?Q?HTKO4CR3tvpJ92mDk9y4xNX9NOtCVuufXjtunLrDOb25KHxpZUmAwsxLQXH1?=
 =?us-ascii?Q?mclUCae45F3b64aF/sCVcrs8pHSVgX53b8mhf+K60KXqCEhQfZwgz3Blp9dZ?=
 =?us-ascii?Q?WNDuYrh7HvjfZdnPt/i5ZRqR4CoG4L0LD3iubkaPoUo4exOp5ysUZn9Elb8E?=
 =?us-ascii?Q?LTP1LDh8kX5m4RjPPeyUhOnjzn61txpD/27jHACJm3cy5YJR67hp30ykUnlp?=
 =?us-ascii?Q?Me1GZQdybE959msSyjv1VdjB2dCBYNE3fshrJQapc1+atS1A0g6LIb0c6kbf?=
 =?us-ascii?Q?DudQMET7DGb+p0wxewV3hvq4r+qfxIjcJGMpMR26yS8k1QxnHKBHFBuFWWfO?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rIAS5HwH/CBUDYfffTRihZIXa2L1BXxMOE+gI7PJ/0gNN9bM1a02PVCu/Z0lI4I6dME9hrOz2n9ySqwuYPnapqDQGoZmhevXgkq22ojXgmekjHIHS+7xSWeF7YNDRfb1ooHx6/avGfOI3LTA+3ZZxp2Ve/PXbN+pJE2EV2cYTM+h0lhDUuoMD3BEDBhzdf0PfXqMEZ/LNB/FEC1jJMppw8WF8gB/Hm3ASowqwDq8RqhUOY9FpqhAN46g0mImGBiPhUDQ4EqY3p22JeZodyq8f2uAe9JmVDe5HjPDDg58u5FLLaL/VnUNYesli16Kw0ZQxUYd9p4TlsImDNGmm/ly21U2iyhn3OzPYyjEKZI4bSrsT0tn3OKYJlGwNxxmuZqL0logsZ+gpqAyf6Qd/gvOd63mNG9sPdxqXH/Z/4LCbcjr5fWaCw22UPGP5OgiOF6rYwNxydwgGBrLH19ZKz5FpMb7Vfy8RG5Wi0RQkPvIMbNIfxdY3c7chUXTMjabbxgTdASW/NFTrnz42YuVz2s26ph7Ida4A38WRUDHF2DP/LFzPK99J/KVOT9SLzGijv0rH8ORWcxH5HQ8yglvScnXwh0V5NPBJbYpeB9E4PTHjbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f68618-81b6-4614-db82-08dc0868fcd1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 12:23:39.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW/ATe4E+9rtq1uioIs0iVsZqghbmLgDBJC8f0HTPIdd5nkhPA0S5HF/pwO87vxiDCbtBOSMb7nh0mZD0QVsQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4360
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-29_04,2023-12-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312290098
X-Proofpoint-GUID: buCNF2gBxSKDXxt_P3pEmLWY2-cTiIGf
X-Proofpoint-ORIG-GUID: buCNF2gBxSKDXxt_P3pEmLWY2-cTiIGf

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add a test writing 128k to a file on an empty filesystem formatted with a
raid-stripe-tree.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
[Fixed the test statement and trailing white space in the .out file.]
---
 tests/btrfs/307     | 59 ++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/307.out | 65 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)
 create mode 100755 tests/btrfs/307
 create mode 100644 tests/btrfs/307.out

diff --git a/tests/btrfs/307 b/tests/btrfs/307
new file mode 100755
index 000000000000..30656bcf0d96
--- /dev/null
+++ b/tests/btrfs/307
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Western Digital Cooperation.  All Rights Reserved.
+#
+# FS QA Test 307
+#
+# Test on-disk layout of RAID Stripe Tree Metadata by writing 128k to a new
+# file on a pristine filesystem
+#
+. ./common/preamble
+_begin_fstest auto quick raid remount volume raid-stripe-tree
+
+. ./common/filter
+. ./common/filter.btrfs
+
+_supported_fs btrfs
+_require_btrfs_command inspect-internal dump-tree
+_require_btrfs_mkfs_feature "raid-stripe-tree"
+_require_scratch_dev_pool 4
+_require_btrfs_fs_feature "raid_stripe_tree"
+_require_btrfs_fs_feature "free_space_tree"
+_require_btrfs_free_space_tree
+_require_btrfs_no_compress
+
+test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
+
+test_128k_write()
+{
+	local profile=$1
+	local ndevs=$2
+
+	_scratch_dev_pool_get $ndevs
+
+	echo "==== Testing $profile ===="
+	_scratch_pool_mkfs -d $profile -m $profile -O raid-stripe-tree
+	_scratch_mount
+
+	$XFS_IO_PROG -fc "pwrite 0 128k" "$SCRATCH_MNT/foo" | _filter_xfs_io
+
+	_scratch_cycle_mount
+	md5sum "$SCRATCH_MNT/foo" | _filter_scratch
+
+	_scratch_unmount
+
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t raid_stripe $SCRATCH_DEV_POOL |\
+		_filter_trailing_whitespace |\
+		_filter_btrfs_version | _filter_stripe_tree
+
+	_scratch_dev_pool_put
+}
+
+echo "= Test 128k write to empty file  ="
+test_128k_write raid0 2
+test_128k_write raid1 2
+test_128k_write raid10 4
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/307.out b/tests/btrfs/307.out
new file mode 100644
index 000000000000..2815d17d7f03
--- /dev/null
+++ b/tests/btrfs/307.out
@@ -0,0 +1,65 @@
+QA output created by 307
+= Test 128k write to empty file  =
+==== Testing raid0 ====
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 1 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 24
+			encoding: RAID0
+			stripe 0 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid1 ====
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 131072) itemoff XXXXX itemsize 40
+			encoding: RAID1
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
+==== Testing raid10 ====
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+d48858312a922db7eb86377f638dbc9f  SCRATCH_MNT/foo
+
+raid stripe tree key (RAID_STRIPE_TREE ROOT_ITEM 0)
+leaf XXXXXXXXX items X free space XXXXX generation X owner RAID_STRIPE_TREE
+leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
+checksum stored <CHECKSUM>
+checksum calced <CHECKSUM>
+fs uuid <UUID>
+chunk uuid <UUID>
+	item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 1 physical XXXXXXXXX
+			stripe 1 devid 2 physical XXXXXXXXX
+	item 1 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 40
+			encoding: RAID10
+			stripe 0 devid 3 physical XXXXXXXXX
+			stripe 1 devid 4 physical XXXXXXXXX
+total bytes XXXXXXXX
+bytes used XXXXXX
+uuid <UUID>
-- 
2.39.3


