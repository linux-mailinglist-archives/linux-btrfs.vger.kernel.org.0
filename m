Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF044E2C8
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 09:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhKLIH6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 03:07:58 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11332 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233189AbhKLIH5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 03:07:57 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC5n9mu024095;
        Fri, 12 Nov 2021 08:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=UvwyQMRusv+o34X2OvJZY7Y6EhyNifM819wzUq98AsE=;
 b=CkgUZW2r8HS+bPIBPr8wOcc+8nuSeS6JTYKFidhSXE4rFK1xR5OefJPm7xPVZyY5CReH
 dkE3KP9TU665dWIY/cRvap6KwTWuBP+HDn9E1nKlBWNzArIWezp07iPFfw/QmZPvCia1
 jGnpIVJ+GKUnT93hdFf5uAVeU+jNvvbs6ZX85hFGDQ+kRzqFPLN/BtjqCIiUrB10MYkB
 s/39Qs6zx2MWewl1H/CCjQRMuCAYdwPj2HvY8FKJFdElDXHSgFzwfssXJyAIkQOoo1a7
 dB1kS0CfPaWkvhhPC0LzIiJg0mQN7WobyKOCIMDvV0W08zXXfegCtfks5PZdf2/MYBZ8 JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c85nsp8tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 08:05:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AC7uPjk135522;
        Fri, 12 Nov 2021 08:05:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3020.oracle.com with ESMTP id 3c5hh7se94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 08:05:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjn+RwxpHQMbJl+bWAJewqTfFmcs8pdo5LIODod0l9zQ8wOiA8nG6cXaBL83ZjxnYaTx84VXJ7bEVdnONVirpVbWsjEt7rlr+NV2Eox+ZEud4vHb+vWZolmNQUYd2ca5xDEYfMJIcL/gGiPBZiv0gu/RlyWgmt6jXYIMzimsZJdR+eMFAKskWbrtZdHzi9EpZpl1AiIRuDz4pqI6QKThH6VHezw98W7smrXx7mZQZL5xjBMR8shwJkTsupqZ1ilR6QvVdue+H4Uy+NeoJHsQNfxlysFzgjO8aFNiyWYLmsMR7++0ljjOCau/u4rC3xyGmgYSdXG9q/O83kUPcW08Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvwyQMRusv+o34X2OvJZY7Y6EhyNifM819wzUq98AsE=;
 b=ChJJItvcG2+2RiiF1owZ5CfcDQatioZcuODSE+hPg7EHqXBTH+nVQHzcI0ImFiiiHRqQNahSq9/J1x394Iy2ecLOxNfcnqFH/L9F3wKNc8gKmhlgTHBnFjgHbSdxPBBfCr2A7HnBj7PMgs9Y9K09pJbpbUNphA4yuzqK235i60yNn+gkx3ptwPQJZrcAQzvyDQPRlgLJ3qJZ5EhTiY2JCnUPv3NX+oSc7IuSLkT13Ti/QxsMxuj6JTzK+7dmh370TLUuJEKGcUVmuIJn2nyWDXkSwl5DAG7uBzSJzEX1bQBZSLYZtxQli5W/sjdQbykEs6wC4JLMaZ9PdacQq68r+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvwyQMRusv+o34X2OvJZY7Y6EhyNifM819wzUq98AsE=;
 b=YWpJtvw2MufEvddpArmXwStyynBUgidb1bUrbR3KsU+1x/yC7dbUaEinUru7cMalN3XGPVWUd1U/m6PyV5wjJMbUm02LyR12f2V48FybQNVWbvpjrN1hEvlHRw1s2q7B779rj4oiu0szHW8w9mYXVhuAj5Z/5i4SwJUKE8qjuCo=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Fri, 12 Nov
 2021 08:05:00 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4690.020; Fri, 12 Nov 2021
 08:05:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     josef@toxicpanda.com
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] fsperf: add a new test case diorandread
Date:   Fri, 12 Nov 2021 16:04:39 +0800
Message-Id: <af44c9d2a1006c2566e7629f22327001b109fcdf.1636678033.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1636678032.git.anand.jain@oracle.com>
References: <cover.1636678032.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18 via Frontend Transport; Fri, 12 Nov 2021 08:04:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1066eef1-ece2-4dcb-eab2-08d9a5b31fab
X-MS-TrafficTypeDiagnostic: BLAPR10MB4980:
X-Microsoft-Antispam-PRVS: <BLAPR10MB49801E42A4B60451ED286168E5959@BLAPR10MB4980.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dl4UZDs9Lk8EKJCyxgUi00kxk5GcXilweO8r8k3qzb2429rClY7CyWhvbZCy8V+imFf8AS0LoXEnWXYzRi8rgAendpgHf0VjLQu5jtiaK9TqheWF1RVUiIWGT+Rf/dWXXccKRCbt1KPkYclrGdvVpZlC6nIEg0axSEe6STC2+GrvEXByj5tIa/ORmPedILQBrJkWbbbz7oAKvtipHA9s3jT9iXdUY/y3G48wBD6Xyy7RxlK2ucKBuk7/tVdHcdwuhTvkRaidAqGSr6lCQH850yaYxdrk/Ekzaekk0LHkQhq29TOd9VgxBGY1pZU2Zt92VkYbk9F9dCYXT8lIgbUQUAyDJgd7LlGZ66HfERhlJD33X8sMC0IVnftOX6VeASli74KXd31FlvnCluVkj8DReUmN6U55JbFsRxAB3zvB/yQUsOa/Huq/BZ5Kqd52bHD8M8vBXQPUwM9mtjxSOcxtmjmttw6FABQvF+bHjfbx0QTotX/uA3jtV1tJ71wmvpIkkgNk6BUA9IZMUmFzf70szx4FiBHppyOd1xn3LLNQKTO6iXknmhqwWAqDbo2BQgs22CFuy/IArcZTKRE8IX0t61PL8ncxsqtfucfNSMD/XFEEUZUCwgi/xwyhupUahxzM2C97wiN94c2iUGTFiG1o8mMfLOMEob+YSyo6fAaImZqAdVszvVCA82bB4EKFkMl5MSn4r8AOcf+5aOhwtBFLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6506007)(83380400001)(44832011)(66946007)(52116002)(2906002)(4326008)(6486002)(508600001)(6666004)(38100700002)(316002)(8936002)(38350700002)(66556008)(66476007)(6916009)(26005)(2616005)(5660300002)(956004)(6512007)(186003)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x/z/HNsm4b7J+V5cHb4LhVS34352hZTmQspCSKxcrx4BJCoo9xVNZ3WYhvN5?=
 =?us-ascii?Q?bDYC8EaCizeMqST0pl1TNO+Wl+iAc5eBmJZnqEVRVu12la6CqkKjowFgNbYQ?=
 =?us-ascii?Q?j6hRL5lgrBdsqhcKP0dmuze9fpJ/NZZflaCJq0SbNIiSuaD/pERVwNJTeWkI?=
 =?us-ascii?Q?PZByc22t6xPSguwJ55j0oospb+KeUAzPZTKte9hkMr4ZFKlpuBuE5wkVqm9r?=
 =?us-ascii?Q?8vvMkCXn0f2MBJ5/ykBHsrNLH3rxwbU4yNwR8XD2uZLcqYB1ahDtN9dGgkKe?=
 =?us-ascii?Q?IF1IodE2662ZgXl1aVnZpOw9GhC39+KUD+/oXnIh2QxwUIOrefSWeFPYQ0pm?=
 =?us-ascii?Q?W1XPgLg/9FDJACVd8HQtGUu+4gN4ORe0Gjmr7vnA0623wlqN57vkTWikDo3c?=
 =?us-ascii?Q?yPTyp1V6MWHF1/GUUpL3+jD0d+466u6XrVavQD3uPY4b+5fcqlcALwZuuIW4?=
 =?us-ascii?Q?EfS2DN734VpqClkmseDU1APSxsItCX8ANktKskMjsj3Qpp6kRR+r4W5t7qsR?=
 =?us-ascii?Q?WUs6DP2mB+9KKfJcCAikGNpxepBzwpDcyFnOG4gxZszL9IUjF1TQnbAxlGqg?=
 =?us-ascii?Q?1sCkfFTVyXqmjD7wKtxhZHSa0EerYdctnDJLnXoORAXNB1bG2PbRKCqtoHpr?=
 =?us-ascii?Q?Pr2mscVjyAUe1BP1S8ekLyTiaj9k8NXY2Jltb4IPv65Z/NPtGYxKx7rHwwsF?=
 =?us-ascii?Q?K9rliLrmkMGQxl9iLUUom01Y01MRAHdd9ODVEn12q1c8qskBdTh8xz4DjrLR?=
 =?us-ascii?Q?q4mmP5Dygqq0sRxXpL+mD3AhPZI6W9Rp5k6fIDprlqJFQ+ekLZN5W3QasIV7?=
 =?us-ascii?Q?qu1d/VufDRFW9v7/DuJF1h5RHXsR6z1HTzASkY3WBlSfs1WJiCkikWyZGE04?=
 =?us-ascii?Q?UnaC/zOQBtlHbUfXQCCiNS3YS1nSvQl74NlKOi8amUWyV690Ujz5X21OYmx8?=
 =?us-ascii?Q?8R5U0awR2rkCgxsSTDSF8jl+n4Ep8rCrrrChwIiQyTHFqR0gV9MH40lfY1To?=
 =?us-ascii?Q?9pioYz2UJcYVqCJsrd+t1YPUejl+7HF/npUv966wOY+tsHAXgVrtKjGW8n1c?=
 =?us-ascii?Q?sTPMZ3gWclQ5cCQSC+FvrNoK1r3SjcRURiO8AydFCVj7TXF2fbGO5oliqt/x?=
 =?us-ascii?Q?qa65Q7lK0w8lT3+jmWft59UIeLHNlQxr30j+9lPqMHOnvs31se/RrggvYW/S?=
 =?us-ascii?Q?DbzCuv+A17Tb75g46k+j3MlcnyM82m+uFdIZ2AI0Z9DO+2AiugiLaco/7D8G?=
 =?us-ascii?Q?VZ20ylnL6yhltnNtdY5lQf2uh34qPzQjhlBplc9WCy6Zs5UAfkjRuvPoxpFw?=
 =?us-ascii?Q?jJ6LVttd3JbZVA8qQGyybFeFx4ZbGBDuEG+SGTTTHkFpuGibGPu681ZMqdZ9?=
 =?us-ascii?Q?lIfr2qYajeiMyEE3byhDb3TtE6xa1nq2TJt5Ph/mZ/eqTZfpkFRUObnPvEG2?=
 =?us-ascii?Q?jDLURPMwmEO6egCoQfmGbXkbzgsLCPBRExFIB0WJsK5j7WYDUh/kBBiqmG0c?=
 =?us-ascii?Q?pHhBMJ0SrZmZ+4dD3R4/yKVqX6ijOkDXLbS7O9Va4zquMgIkoqejfzDM2UR8?=
 =?us-ascii?Q?Qa2RfWbGkk7l4ocwUHNEcgUkDbpjfKRGVOOAeySAJnZPrfGSVLtQuAidhPay?=
 =?us-ascii?Q?1qZVsyRoBwswrM5uFWckO6c=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1066eef1-ece2-4dcb-eab2-08d9a5b31fab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 08:05:00.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+8pEY9O+tgFXSW1GAZBWXGgnnO3YLZp/nzBMeacv2PP3uDyumWzaiC0sqIq+t4zYrG5/YAvob+6hG8azvCMOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111120043
X-Proofpoint-GUID: fGvEr0pku_4GXwdxvpwtsEencpPhY_oG
X-Proofpoint-ORIG-GUID: fGvEr0pku_4GXwdxvpwtsEencpPhY_oG
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The test case 'diorandread' is a readonly direct io test case using fio.
The primary aim of this test case is to benchmark read policies.

An optional read policy parameter can be specified in the local.cfg file
as shown below
  readpolicy=pid

When the readpolicy specified in the local.cfg file, the setup() in the
test case using it shall validate if the fstype is btrfs.

To compare the readpolicies the developer can run './fsperf diorandread'
with the supported read policies under a section. As shown below.

For example:

$ cat local.fg
::
  [btrfs-pid]
  device=/dev/vg/scratch0
  mkfs=mkfs.btrfs -f -draid1 -mraid1 /dev/vg/scratch1
  mount=mount -o noatime
  readpolicy=pid

  [btrfs-latency]
  device=/dev/vg/scratch0
  mkfs=mkfs.btrfs -f -draid1 -mraid1 /dev/vg/scratch1
  mount=mount -o noatime
  readpolicy=latency

$ ./fsperf -c btrfs-pid diorandread
$ ./fsperf -c btrfs-latency -t -C btrfs-pid diorandread

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 local-cfg-example     |  6 ++++++
 tests/dio-randread.py | 22 ++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 tests/dio-randread.py

diff --git a/local-cfg-example b/local-cfg-example
index a9034f98fbee..4b7fd0703feb 100644
--- a/local-cfg-example
+++ b/local-cfg-example
@@ -6,6 +6,12 @@ device=/dev/nvme0n1
 mkfs=mkfs.btrfs -f
 mount=mount -o noatime
 
+[btrfs-raid1]
+device=/dev/vg/scratch0
+mkfs=mkfs.btrfs -f -draid1 -mraid1 /dev/vg/scratch1
+mount=mount -o noatime
+readpolicy=pid
+
 [xfs]
 device=/dev/nvme0n1
 iosched=none
diff --git a/tests/dio-randread.py b/tests/dio-randread.py
new file mode 100644
index 000000000000..05ced875bb6d
--- /dev/null
+++ b/tests/dio-randread.py
@@ -0,0 +1,22 @@
+from PerfTest import FioTest
+from utils import get_fstype
+from utils import set_readpolicy
+from utils import get_active_readpolicy
+
+class DioRandread(FioTest):
+    name = "diorandread"
+    command = ("--name diorandread --direct=1 --size=1g --rw=randread "
+               "--runtime=60 --iodepth=1024 --nrfiles=16 "
+               "--numjobs=16 --group_reporting")
+
+    def setup(self, config, section):
+        fstype = get_fstype(config.get(section, 'device'))
+
+        if not fstype == "btrfs":
+            return
+
+        if config.has_option(section, 'readpolicy'):
+            policy = config.get(section, 'readpolicy')
+            set_readpolicy(config.get(section, 'device'), policy)
+            policy = get_active_readpolicy(config.get(section, 'device'))
+            print("\tReadpolicy is set to '{}'".format(policy))
-- 
2.33.1

