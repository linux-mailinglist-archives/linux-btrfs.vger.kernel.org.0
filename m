Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EAF492985
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 16:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242496AbiARPSe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 10:18:34 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33210 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233767AbiARPSd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 10:18:33 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IF4SLi004505
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=Fh2BqFvi3b35SdvXZQLDDmyq8lIZL+QIEh+cziLEMBw=;
 b=t5rVxnlAcCzJka2un1UJpjr5qhJICDzxmmSZ/QVhIYG9wAyuV7c64LbK9WX3LEdrj0ZK
 YgylFhjb9XsQNC541Q+DPEZDsqtBZE2Jzs7dW8qsv5AgWHd2PJ5PPUmPWVlTIpRPkpuz
 ifUE6Ss8LEVxwrMrarxy33Vhm75jifJpwddTnCcW8gSCBfkU+deQq9sSvoGhFbrMxRN3
 SeJOqMCGBjpsB+34U9+CxgZ3ZDBuixOQyoPNjeqZ2INDew9aQw9h/80ilwTQQU/5RYro
 ixtUt2HInSEhvtCrxDrTt1EvDuobfXXSH1hu5ot0lXkweoGDlMZbxVslY+b3Y5vqXiTu Sg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnbrnt6hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IFGZo1110893
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3dkkcxergn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jan 2022 15:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlBam7frjTpx3JmTxRZ2gp1M3Xh7hM5vCJh7X2IHQMFx790gUnDrrEFwr05ALKfws48/sK+Bb0ZJcoahmPl7uqFMw0iqLcC1ahB0cltB9iJqvJSjhD4yyPBpJBuilvayw2Euhgg/fEUutgW0nIIsVg74mDET7Md+/6d0F3r+XHIz1+l9NKrA9uzeAwpApmM8j50vcrKNQY3dJFUnkN0V3d6v7FvvDWTP3VjUS0xKFzBVSYO0ioaEgCD4gUzKpDlAtISHw50nSLXpB2r9wpgZR2m2A6UnhLnSQJhRAt8Nn84I8R9SAzIc/iB5EJ3x9ZiGUQx0lmTym5OR7cr4UPeFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh2BqFvi3b35SdvXZQLDDmyq8lIZL+QIEh+cziLEMBw=;
 b=ibu3hSYas9dtsqYHMvjCvR7u0tu3Z4BpuUBWtgAN81sZ+NbCOrQkSHBBxXbRZ2CeebZMJjBvWIRX51yYXZ1MPVYy76jNhurUq4Y/lZNwH/Vc5XT+LMO8S1nNZP37YU05NZhYoO0MY6jj2IYOSWqEu88riqIaZU1Q9k+22xuzTaJ8zcAsYxtk2pNcnniiQvNDytbItbcyqXqAuLVGhy7ekyhsolLlH/I/rnd2hucKqoPD2Y9GGqQymR3iKDPbDLTMChNtXQMZKmzgliH/I9s/SM2N5eQ4nEcqGzPPYo1e8laMqfhKD6QLRSpRzNPEU+YRj2KUTYiZVjQ2+joatq3Thw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh2BqFvi3b35SdvXZQLDDmyq8lIZL+QIEh+cziLEMBw=;
 b=KOFM/r/c/JpsUok7VnrR6h/CsdoGEDt7gt7Cwwd1ByFHSBtHD38Sz6PMy+XeYNqy/yj8ig1qkE2bgO7YvnzDBSIY2M4wR9zpksVqlXDFE4FzBoKrx5B1x/nZmmYZERRNcQMDN1KLLEuwhMhDwPJGbqbN1AXZSzr2fnybzkz/zpo=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MWHPR1001MB2158.namprd10.prod.outlook.com (2603:10b6:301:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Tue, 18 Jan
 2022 15:18:29 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 15:18:29 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: create chunk device type aware
Date:   Tue, 18 Jan 2022 23:18:02 +0800
Message-Id: <4ac12d6661470b18e1145f98c355bc1a93ebf214.1642518245.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1642518245.git.anand.jain@oracle.com>
References: <cover.1642518245.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0199.apcprd04.prod.outlook.com
 (2603:1096:4:187::13) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9abd03e9-c396-4b6c-94cb-08d9da95c83f
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2158:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2158BB86F7F784498C148EDFE5589@MWHPR1001MB2158.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dHnGCTnpeMauHtzj3ToyfQY7gzhhdzzuMK9gJNOTqcuB9yJI51KX6K5APZfdjrN6wFnzTK/u4T4bbYG6ozgkPUaxTWKO8mO4WthjxfQp6FAENHXGxqo3XeCyVjgiZcsB5u6JQPXz3QETsNHmLhEmv0YDOkVwT7HRWRKL6tdh+/0zeC0m7lP3uzlxlrzi8XjEIqkPEmuKT143lzoW8goYXkfHZYfEKQNOUgfPyiDqbp2DlxGmBjSJtO32xcprrrEdF5UySRD7yUHkyx/IfnMJnBpvpTh2InyS95s5H+cjfLA78xt5+b/zfOAoDxms2mdYyRLGpBdTTj/K6qu7Thlha5Bj2+2W9PHNC8ppN+/plk6HZxt8QUBJ9Ekj+G/5leGpYCdGI+7MD9oDJrJsPe87rpLtKZxhCSxhYYkcbuyYWla0S/LF8xjqlBHoM3A50kq3DTRit6e5COWdtvv3o9n1zRtlvHBd3SB9qDJ2qF92rwCtsXFMrKzNKsRnwY/CHj0EISDIyOMlg2ahbvoGy3vBrkYyuy87nOmveNPfYe8Txvbp4dCGrIFjZQVPae6qgb2+G3OGyZ+wB365yf5aZCSzzPAZJqGsl8nsbYItXa9z9D9GXA5w1eB+go1m7kA7buOIlM2OBhS/WgbROx+Uc2dxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(8676002)(26005)(6512007)(6666004)(5660300002)(8936002)(316002)(6486002)(186003)(38100700002)(6506007)(66946007)(83380400001)(66476007)(86362001)(36756003)(44832011)(6916009)(2616005)(508600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ql6pDv9WjYE1ssi0dyssPRHIXdgGUtJvYBj9NF52X2Ds1I6yWvscA0KzbuzW?=
 =?us-ascii?Q?MoGDBUQMrHqFNbUn6C4my7p99Hendw6VDM4TSIlWFiDZxoZBKVc93iFvS7Wq?=
 =?us-ascii?Q?WbAanBlk2zV2FsBiCPv2O2HaLLmSQ8DGgMkaYsqXl9p5sh2Q7Af69EwAzrF2?=
 =?us-ascii?Q?f1JqiEszsBxaTLSNX3HolWX7wj1B3K0818viHRVRjmF0cvHwgvF8OD2CQTYX?=
 =?us-ascii?Q?HAvl/0jIF+7CJZlTVytWkXHU80X4vhzaGwMWRnh0XpiUqViijnEZ6YPrcsBT?=
 =?us-ascii?Q?s6VdahrtGHAkyx4Y52of3GrLl5/thMngP0xwgrIghka4Ch3lfuNKiTVU6pga?=
 =?us-ascii?Q?8ei0w+rBReMXNYrb3FflRBfVs+lbhjWhzivYfpl++j4pJxKMSOo2i/REimFh?=
 =?us-ascii?Q?FoXNlvEMAUnB+FMLfWGoCSSGkuRncBBemjMW6p83xrK2/ozRtbUGjBB4gqMu?=
 =?us-ascii?Q?jv5cQc5HttmI+3NKJqJOUMcV6HRugh/iUQd7hJ/jHpk5v81bBkvAKhEIFjxy?=
 =?us-ascii?Q?ZpSh9NP8wsGQ2U0lfCVce0jz1SuPhnGXk94/bQn9Fa8diH6DH4n/O7LqsYEm?=
 =?us-ascii?Q?4Jhr5p62CA8Zj31MjorvcmZPonda7phY09uu7bHtHPU6IUKMlvlzoAjV8ek4?=
 =?us-ascii?Q?0v94QJuO27qsUTqXO6D9WnGrm9EiNcAoX+sM0eTZBIKFX3Ixjo+ECv8LX4F7?=
 =?us-ascii?Q?E15n6YoldsjskTXnJ/MD9OiGka/h/p8+t4xEodywqFJfxsJj60jh4pp9l+/u?=
 =?us-ascii?Q?OespArRTH68XqyR5h3GRLxErnaTitKUmw0Sgxyxj/SDzEUCUpCxiYijNVxIV?=
 =?us-ascii?Q?ZNvV7kERA6+cfEsQFLxm1hZNBwjMHgsRnFslAlDwax27Gbtq6F1uQ6aLopLP?=
 =?us-ascii?Q?WuDrjiE3VAoXNgWJMpFcChvLDSmvAhYI6KJ5l86vz4uiv6zJGbh1fL5KCn5y?=
 =?us-ascii?Q?rnM18FU/YZ3xR8ZgdgVvPrB8Rk+QI3PElXap1mGrUsFKamYfy5RAi6TjtEiD?=
 =?us-ascii?Q?15t3TkExJ3mtDBbkEn8Q7JxE57iSQgz64T2TeNV9r1Ds4dim7JOTxSwVPC2G?=
 =?us-ascii?Q?7vyS22kApfTnLVnmvYVyvIFshkvnTUlK8pHu4WA88NL5Ngc9bBQViaxsffdu?=
 =?us-ascii?Q?35wHpq87T237dgE/k882NtO47j9t/xwUFqcIfTnGqPQDA0nlWVbi7jjJU8Lb?=
 =?us-ascii?Q?QVBSqWivk2PcJbUs2lZ4q2dWIMhLVcdvVm/zy8IfAr85YPEkxFEil8izr2Ee?=
 =?us-ascii?Q?0+71DZFYSMRFpiKubqh7v4CrU5efNB5E/Zy/faFcKGaswqrTS+UUivgwHrCA?=
 =?us-ascii?Q?fUZoBd+8NG3MoSGzdvUDvatYV9iOGb8OG77x43m5jtsLnh1zLS/vgPi1zPth?=
 =?us-ascii?Q?POHmHyyDHQhDralXtfedzMyoCqxi4bWvcYA3gqx7GWyje70Z4K6bEN24qQdQ?=
 =?us-ascii?Q?Uk/z+aQ6Ojdxp7Rbh/uSWmn/LpJElQoI3alpw8BFoGuzGuM41408xayGYXns?=
 =?us-ascii?Q?C6GAMzOFrP7zR2JQjeC/e56pHE/joUskdV4IIjHPIUgQ42ixYTCAbFCg5lV1?=
 =?us-ascii?Q?qbJY2vplnTwWLWREUpqmIgRgF8/0bYMvs5J8EGZN9ocHPOhivqjs8OJmh45Q?=
 =?us-ascii?Q?yddnVSAEao+1ZTE1BysEuLY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abd03e9-c396-4b6c-94cb-08d9da95c83f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 15:18:29.7520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwOaNya+Yvh88j/ReLQUJxHRX3pO92JUN3rR9xCVlitymUo9rDB2HEOjvMEswInaKBPcucF/ikS1ujDALYk8Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2158
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10230 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201180094
X-Proofpoint-GUID: mHO-tKgTw24qhrYRX1w5C4mAJaGukYQU
X-Proofpoint-ORIG-GUID: mHO-tKgTw24qhrYRX1w5C4mAJaGukYQU
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mixed device types configuration exist. Most commonly, HDD mixed with
SSD/NVME device types. This use case prefers that the data chunk
allocates on HDD and the metadata chunk allocates on the SSD/NVME.

As of now, in the function gather_device_info() called from
btrfs_create_chunk(), we sort the devices based on unallocated space
only.

After this patch, this function will check for mixed device types. And
will sort the devices based on enum btrfs_device_types. That is, sort if
the allocation type is metadata and reverse-sort if the allocation type
is data.

The advantage of this method is that data/metadata allocation distribution
based on the device type happens automatically without any manual
configuration.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index da3d6d0f5bc3..77fba78555d7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5060,6 +5060,37 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/*
+ * Sort the devices in its ascending order of latency value.
+ */
+static int btrfs_cmp_device_latency(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+	struct btrfs_device *dev_a = di_a->dev;
+	struct btrfs_device *dev_b = di_b->dev;
+
+	if (dev_a->dev_type > dev_b->dev_type)
+		return 1;
+	if (dev_a->dev_type < dev_b->dev_type)
+		return -1;
+	return 0;
+}
+
+static int btrfs_cmp_device_rev_latency(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+	struct btrfs_device *dev_a = di_a->dev;
+	struct btrfs_device *dev_b = di_b->dev;
+
+	if (dev_a->dev_type > dev_b->dev_type)
+		return -1;
+	if (dev_a->dev_type < dev_b->dev_type)
+		return 1;
+	return 0;
+}
+
 /*
  * sort the devices in descending order by max_avail, total_avail
  */
@@ -5292,6 +5323,20 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
+	/*
+	 * Sort devices by their latency. Ascending order of latency for
+	 * metadata and descending order of latency for the data chunks for
+	 * mixed device types.
+	 */
+	if (fs_devices->mixed_dev_types) {
+		if (ctl->type & BTRFS_BLOCK_GROUP_DATA)
+			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+			     btrfs_cmp_device_rev_latency, NULL);
+		else
+			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+			     btrfs_cmp_device_latency, NULL);
+	}
+
 	return 0;
 }
 
-- 
2.33.1

