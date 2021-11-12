Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010A044E2C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 09:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhKLIHw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 03:07:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26924 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232346AbhKLIHv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 03:07:51 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AC5gG3J002573;
        Fri, 12 Nov 2021 08:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=gJlLx6aBJ2HO1hsn2ueVLwZDm6sVW2FWg9Hq1JremYg=;
 b=1AIn0Mr5Dlh10fb4YiQ4hYZ4/xE/GuMjGs7DtVwHR6u1+YNZPMPMUpxUsMAHQsq0XHfV
 W3uYLt7hy5cilxJmMjVqcl9BbFS3O+EZZkEdcRmLxD3Urupy+8Zyio/eZgCw1OwBVc+6
 JdACetqtFxEH+pfx/DDJDAuqMuV0pF0sej12cDwbNvmuOXpm30YdFQoeeOLIwprlKBkn
 95i5A0w838DB2uIBe8MygwMqMwkFyxLc9OopL/x3bO5w0yKB1j4URwmwgPOr8sGDMB3V
 f3MlnshRwu6HIQeQgN9pEMp9Y15Hj0Blvs7q7pKsNwIdk1ig4XKbPhYIXux5/unxhjQN 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c880s5h5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 08:04:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AC7ummO053105;
        Fri, 12 Nov 2021 08:04:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by userp3020.oracle.com with ESMTP id 3c63fx89fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 08:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnMmar8HMaHwxsE571/6X9UUIO4Osb1kRWMJx7Iuo3WyyY8iTBcO1NE6NS7r3l7SYS6VFx8mQyLvxt6A+g/BzjKuX5VrjGmYALg3C+BrCsCFlRSn7B1TFJRyOrAJMAwrDXK4UFQ55oHMDk9WB7bzdEbdRmragGf+0iKa+QJoh7AmT8CtkLJsEvccfydtX0HiVixe5FWKANHkwEzLOEq6u1bcDiOrjES3mmJVUhWzF/8w2apIj0cacQ3aiyWnJcWNGH8tZpxpFV78zpltMxMQ+Qcs1HNUS5O16ew/W6XBNdAdxE2cTO0fPgoaCghbtuNLUVVF8mDZGGtEvFp8ZbEDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJlLx6aBJ2HO1hsn2ueVLwZDm6sVW2FWg9Hq1JremYg=;
 b=N2jGhFu9/hNzqEACXnrusTqs1nyIk/TiP3iDpjn3NOAxH3oFBjrq5a/WhMPO/3JhfbwHjD+LdakfeFtsK9IfXM72Z2lhupbTUL0QzjDst94dqyMvXRD2ecH7ZQoFTc721x1WfqJ6RGyWmYTxQVDWAZmPreJnUlXgTVQM2tIt9KztmZZWzOtk5zn8WDfqViNlvPLcBXrvJtRSMF4WRRoKHGpVnhUrmlTcYsP2IRCaXmNbr8B2/NqJMLT5Afst+USZM9NEKYdvXCL0oFu7zEKQ5o6Y3j7LX5Av6hiqU5RoQ6vk16CVc4Kt+s5/wFZIHjJsy/gnK7I+0RE5Tep4HBLNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJlLx6aBJ2HO1hsn2ueVLwZDm6sVW2FWg9Hq1JremYg=;
 b=BwYKt1Qct3qi2zla39zGSXM0noil5Ma4CSOH03bZMgID2N8MDB/vvhEcwEq8EB+oB9ZZnmWmh+Gbz565AYV7ZJstl8p4s+9qmgcfMBDwL2EcEVjpFDNqATQQimn2AH2T+25A8J0Pta/PV2321Cm3+TYipaL4gbk2+nXXvnbVzd0=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4980.namprd10.prod.outlook.com (2603:10b6:208:334::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.17; Fri, 12 Nov
 2021 08:04:55 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4690.020; Fri, 12 Nov 2021
 08:04:55 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     josef@toxicpanda.com
Cc:     dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] fsperf: add a few helper functions
Date:   Fri, 12 Nov 2021 16:04:37 +0800
Message-Id: <af5326c5a3eeda8393e0f2b52932ec5c8e9d850a.1636678033.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1636678032.git.anand.jain@oracle.com>
References: <cover.1636678032.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18 via Frontend Transport; Fri, 12 Nov 2021 08:04:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdedbd7c-019c-4d58-9741-08d9a5b31cda
X-MS-TrafficTypeDiagnostic: BLAPR10MB4980:
X-Microsoft-Antispam-PRVS: <BLAPR10MB49804A5633EC6217AC874989E5959@BLAPR10MB4980.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9OMcrksLZrSKri+p33XnqR6ndjB8FqaEa9k6RQ/FxXjfJBiVcNz4fyjwAQ+/+Jug59q7yzVD7dByL1hrHEWCTzhilB/wIWs8W+oSE+p8LEay7sV0LGBDUhmrEioqaxiGFm8X0Zgmoh7g4kIeVlZeBi/QGWWHeJPHnStzgdHkzfrBb098k+9X/TeExX0M76dM3lEF/gdh1uEORa90SomycXW/VEbqG04FPuOY1Gmdia9EdFGYwFUo3FbxA6DEPHpm95Zxo+EWiAmGtw9sNuJ5yUjSc8Ko7SpaIAPNxzlYfiMgpfzF58Z2FDPhig4f3z/LV6GfnXXyzx8/zSvuZkFcFTbHCcayponqpiFzRraZ8PjKfm/JxcDLtuVoKicZDPpdgX8NJ85qI4EgVdFslardg7UW4RdTnA+3J5IvsHFqNJynFcXQIE+X6f2qmwMjOre/wSQAlk5PAFi3VM1pDTYGZJaVZdN19c3n8gL2v7+Y6u2NXNeyqW2bQC5bmjXoaNB+A7c8Qb9+XOjuTx2rKoLNdyqYJS5ng+omAUaiS6czgRLosysLYYv3lu6ZkitM4geD4mjqZnbuliIDXZtKhrj74aO1KLDIuv3KnlmmFRndyYHv8IWd6EYUsh6MvbE4UOGZrmaznXInSDsun98bCUWuWF+niPZQ1Pfo5w7BIXlI5Vigs9vRwk3qq1yxMU4QR2U3RsVDM+wsrfwujeFSLY6HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(6506007)(83380400001)(44832011)(66946007)(52116002)(2906002)(4326008)(6486002)(508600001)(6666004)(38100700002)(316002)(8936002)(38350700002)(66556008)(66476007)(6916009)(26005)(2616005)(5660300002)(956004)(6512007)(186003)(8676002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NPFDy4exjchb5VKcvJdJ20RI1niD1LP3Hv8vFZusxL+uqhq+zsxOqAaJyq5M?=
 =?us-ascii?Q?5OCUpHGkiAI8i/zi5zb4l1YFdqF7rptIwoaQ5lBA8NXMW0wkgmcdu2NXn/Vf?=
 =?us-ascii?Q?pcJp0sVlwtxyw10OeWH6KC9Gq6mMct2PZVeR5eqdqqSr3ac+3dOLXM4UmmbN?=
 =?us-ascii?Q?MUAasmuJ1NsO0oCDLpiCLGNg4ho1oBBwQOo9kLDkw5/ZLuNpeL9oTjBy2X1H?=
 =?us-ascii?Q?MNUsQUeOotQp7rnjl8HyCxm46IPUqlX3Mn2Cjfmup6GRH+rO4ANsqkA8WORe?=
 =?us-ascii?Q?0CgHAZ4esZf9H637W3tqZpgbpTm7wqUDq++j2IqFLXKdrjyc2+wy1Obm9vBY?=
 =?us-ascii?Q?UbGA58wGRPUHhCQZEO+bJ3CvmJQ2zc6qAj8Y2RKrXYsiUmOT26qMRWZDz0nz?=
 =?us-ascii?Q?k9piGAD0jkIQ0LnQRiKDNiJQv68/ZJraaTiMw7PVSCTpjr3blGcwq7nrmkQd?=
 =?us-ascii?Q?RX+XPoMiLxF7OGh6t3iuSVVgyJboDDaDCciTuCgsEalqJpX+p875VmhIA0Zn?=
 =?us-ascii?Q?jkFBhOxgkLu15fuchzQXdI3e29t6RhQyF2nCSDc+Pb5ffcKjamDN6JDSmaKt?=
 =?us-ascii?Q?2ytp0aUsll4qcAcYCZpJAnhE8lAh3IUvDHlG/0jpPCFfqKiOZQJfD/Nvd9MT?=
 =?us-ascii?Q?KW+sKa9timbJ10jrPNt98bjiptGl28XZSZDd7bveVo3qJW1gkdKrGc33Gyf9?=
 =?us-ascii?Q?aRRoRafzOWj6fkKFUB+4GnHLR634/2/0QEJZUo0JwKknE7G4OFFR0iK0ihB0?=
 =?us-ascii?Q?dlqE/0FalEIUN7j5JHy/C8VNOfnbHcbuFZmxWOzLiLBpcalbYtIDwPpUsbGf?=
 =?us-ascii?Q?BRgeqXjrifZ1JeSXGsg9iZgcm2GDNAjB/cSJOuIxAM00VclNhohJwbtV7zf/?=
 =?us-ascii?Q?lTMJuNfIX6P6e1OFnXURL3zhTREEVjGJcrznSwhx6EKRvn0yp8jhC/Aa9zPE?=
 =?us-ascii?Q?s8MEhQgvZpyDcmHAQpTxrnY8B4UPiEd/E6gKdxRn1NlourR2O1IuiYXhS/vo?=
 =?us-ascii?Q?HNfjaQmL7s3tdbq5IUxdkU/zDi9rEzjrHTJF6ESCiDKdgUjGnsZQ0uHmoAzo?=
 =?us-ascii?Q?w3YaIimY89bkVl30smwcVqP79VMhU+KPRLl5J2ubG6LtDe1OczuTDGgaUC9Z?=
 =?us-ascii?Q?LIg62X/E5v4RmhbhRpnJBJoN4tbr+cHEDIi58nwtHyyc25pR1FypCj+Q1tyC?=
 =?us-ascii?Q?wbqRlBurSvUIVZ6kdxzLLT3cB1kcujT9n0Jtr49YttJhvmWuiyQZWzltUgJp?=
 =?us-ascii?Q?kSUE1BkgrF3N51WBa02fTw41icDs8q/HsIiUh6dVNFKUuC8cyHeE/S1M+XqR?=
 =?us-ascii?Q?2YQsp8zve9O2dnhtP0clZ6MiIQzFQno42U65zeWwW4+T3teNsLCpD+XA+ZC9?=
 =?us-ascii?Q?pFeE/jdETMZH+rR9NjLW3pmTFu3xmXLLRa0ON2sraHZmcOpCctc6scqRf145?=
 =?us-ascii?Q?dENB8aDeDeh2Wx3iVdgIXJCaxXznCWl+d60tVG9OvwjMTw1siBtWjQSrjAco?=
 =?us-ascii?Q?9uK1gLsePnB51uBUllgMvvFgyNBSlJzgOY71WssY7LiHHiLSHAKp+mFlwcZc?=
 =?us-ascii?Q?WFONyrW9rkWDpai1gI1vovIOgpZDYmlyJWQqDXurzMBA/WY+eVE25kiKQFQR?=
 =?us-ascii?Q?unNGm8HInNv1XrdIlqm+JYo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdedbd7c-019c-4d58-9741-08d9a5b31cda
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 08:04:55.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UwI1cCQ1IErEHAt88zK0dpdVe+ftomCuNcBzTiMqhASlEyqO5h4PktHCihk+aXz5JRPpILvmcMI7IekiUVdmTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4980
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111120043
X-Proofpoint-GUID: pZ2p4vyi8uVOZIoLChb-_gQonAPIAdXJ
X-Proofpoint-ORIG-GUID: pZ2p4vyi8uVOZIoLChb-_gQonAPIAdXJ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is in preparation to add read policy benchmarking add the following
helpes
	get_fstype
	get_fsid
	get_readpolicies
	get_active_readpolicy
	set_readpolicy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 src/utils.py | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/utils.py b/src/utils.py
index 5629894ce1fb..a7f0f1baf448 100644
--- a/src/utils.py
+++ b/src/utils.py
@@ -8,6 +8,8 @@ import itertools
 import numbers
 import datetime
 import statistics
+import subprocess
+import re
 
 LOWER_IS_BETTER = 0
 HIGHER_IS_BETTER = 1
@@ -230,3 +232,46 @@ def print_comparison_table(baseline, results):
         table_rows.append(cur)
     table.add_rows(table_rows)
     print(table.draw())
+
+def get_fstype(device):
+    fstype = subprocess.check_output("blkid -s TYPE -o value "+device, shell=True)
+    # strip the output b'btrfs\n'
+    return (str(fstype).removesuffix("\\n'")).removeprefix("b'")
+
+def get_fsid(device):
+    fsid = subprocess.check_output("blkid -s UUID -o value "+device, shell=True)
+    # Raw output is something like this
+    #    b'abcf123f-7e95-40cd-8322-0d32773cb4ec\n'
+    # strip off extra characters.
+    return str(fsid)[2:38]
+
+def get_readpolicies(device):
+    fsid = get_fsid(device)
+    sysfs = open("/sys/fs/btrfs/"+fsid+"/read_policy", "r")
+    # Strip '[ ]' around the active policy
+    policies = (((sysfs.read()).strip()).strip("[")).strip("]")
+    sysfs.close()
+    return policies
+
+def get_active_readpolicy(device):
+    fsid = get_fsid(device)
+    sysfs = open("/sys/fs/btrfs/"+fsid+"/read_policy", "r")
+    policies = (sysfs.read()).strip()
+    # Output is as below, pick the policy within '[ ]'
+    #   device [pid] latency
+    active = re.search(r"\[([A-Za-z0-9_]+)\]", policies)
+    sysfs.close()
+    return active.group(1)
+
+def set_readpolicy(device, policy="pid"):
+    if not policy in get_readpolicies(device):
+        print("Policy '{}' is invalid".format(policy))
+        sys.exit(1)
+        return
+    fsid = get_fsid(device)
+    # Ran out of ideas why run_command fails.
+    # command = "echo "+policy+" > /sys/fs/btrfs/"+fsid+"/read_policy"
+    # run_command(command)
+    sysfs = open("/sys/fs/btrfs/"+fsid+"/read_policy", "w")
+    ret = sysfs.write(policy)
+    sysfs.close()
-- 
2.33.1

