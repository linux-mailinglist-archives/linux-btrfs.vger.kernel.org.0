Return-Path: <linux-btrfs+bounces-276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD547F40A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 09:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD40A1C20991
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDD638DD2;
	Wed, 22 Nov 2023 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RHVZ0qOl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xXQIQcHa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E4F4;
	Wed, 22 Nov 2023 00:56:12 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM7O0uo006197;
	Wed, 22 Nov 2023 08:56:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=1h2nWQ5+416DWKDWaOKJGDna5cfWsLS9TipCMH1CJ88=;
 b=RHVZ0qOlTZLzhpSc0r9OwrtkjyVKr4fWzo4SOpXO6Xwxdwqn37C0z+zlB9cdhHrQK1Uj
 mb5veYenWzgcswH8BJGhVipuByeIBZmO0a9IK4bXLduzskna2kRAyMxysRkufdTNGOLk
 E8RgVpMIYcA0q+FFzFyThE0PxOuegi1WlLQYLeYKDuj+17Glkk4tNM/CuaoltJCtE6JT
 8lrIY4BM2tlVir4i3PJhjRFNFPL6HscXxFHMEE/odZhoeXEq5EhunPjCrdLUjcWQTO2+
 dsMMChVFzWBuvKN0F66hcOp+WqzkAmR6RjyfYbTH9OEBnxirLSKrcxy8s0TVcbIldBti EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uenadpyvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 08:56:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AM8TUQu037450;
	Wed, 22 Nov 2023 08:56:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq8dwj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 08:56:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTWBjziQR+xLUz1MyF+LQG1P9zMmBbXAGT7lnXcHKNX1i9UwR7j+G78tfyudpx5QbtrBjDIrSS8zfo1aUe360ifDVxrgOI3/XkvrjZBjng9+gpOMaXMAP3DnOXS47UXqb86VUfUqpMGXWCMEzg3k8tjbo9HfwuQUIPCiML0E/4ut3lUSKJYe9tDcsKEm7bBAKvECyXpRbWI0Ao0hH8u6dZKP4KgNDiofQxd+ExndgQoMulOPUzEP3YIbw7aG4w8o4a5oQhFNSh0eNc0AXYeSsodx/D93Xpocap0AG69TLtyPKuAeBZOEXpIStyK4hXnQZITVhsaY2mK1ca7+AjvQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h2nWQ5+416DWKDWaOKJGDna5cfWsLS9TipCMH1CJ88=;
 b=GaDNUburC9fd77VODgeP0pjHdTn7Wu6vo+ubw6LpI1tKuKLXf64S2S0DSVqBFC67/ehFa7VgMzT0gVbmM44FEp6tGZeeE4YMNUKFvEtWffCsO7Sob71CIG87YdrmaSeJlO7H+gKFLZCWQgf23GiJtuA/B8aYftjsfcOPQhz3TFTesDlRpm/2A9meg7OQ5lt4/EcNHIxw9Qxn2pxgASbHDBL4ZMZLQOrO7bV0hyww2WEgHTAdCo6QUM/0HSvZ9tbgKK554deTsahcUOBluy+xr43Danm/KAyuceBIzHIb/KMy+MLpPcnUOLcWPrcyjIYnCqrE/tMazv90Na/yDR16Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h2nWQ5+416DWKDWaOKJGDna5cfWsLS9TipCMH1CJ88=;
 b=xXQIQcHa0f8XxbG2rkADOe/elvKjbG5FEn9IKCPQBzaeTnxLy+aTcMV+MruE0ClQ/z57JAfTE+Hl4tWtgqss3Kxh80ptIlSyLiQqKcgZVUoBP1n2R3++lMqVTw9CoLIsWgcfRiiKws1zBCMZlgOH7zJPuB87WH1NG4ZaRU0G6XA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB6636.namprd10.prod.outlook.com (2603:10b6:930:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 22 Nov
 2023 08:56:08 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 08:56:08 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH] tests/btrfs: add tests to the remount group
Date: Wed, 22 Nov 2023 16:55:44 +0800
Message-ID: <a8732c1d8994cced3560d4e35fd82c1b0ec4968d.1700643177.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: fc90dbb4-2647-428f-0c9b-08dbeb38dde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	D0BvI0mPvVVLSrxSHuy23/JWlNCBmddydtRIEiWDCNxhD69QnSxqM2sQY4O6tEUmDJdwhiG0aDYhGkQC2OwqvMDBU3sb24lPsUIEE5Q/q7A9p9GklORkR2RoBQ60XNT5PmJkjAOM++4U/Xie8xp6JIY93ps1jwhlxHF56jgB/wPhPk94JMvSuUGchfs+yjUqbzwzLBVvQP3r+sTkbOVkKVir/+EnO2QKTM8SYPqvLVcoSrWbly3CjPjxrFa4zTMIheYS/DnjtKTI39zko3+ky8cz1sarkXiwghdkTL7D3VuY++S7H/ObfevZSY+drE7Xu91GYZCSZnvDXa1QPrFFfuOFckUaQQ19fTo+8jrlxsoG1vEqG9GM74WWN8ljnRT+aq4I40YDxWWdKufHexHTBLZ5giIRSROTSrxGHBJlJipwkbhCYJkHKCCRJ1Wzp3NoRAkvXOK1cUZnoatxropEpjSaRyoYIEr7oMwyvkckBvJzlzmcxeoOU2ARDJFpE1MP2ovfBS+lLSYm9+sxyWYB2ru9lXWqLTxgCPUytovM79oifY4oIGsSDF/bY9vyRzmt
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(66556008)(5660300002)(26005)(2616005)(36756003)(6506007)(44832011)(86362001)(6916009)(66946007)(8936002)(8676002)(4326008)(450100002)(66476007)(6666004)(6512007)(478600001)(6486002)(316002)(41300700001)(83380400001)(38100700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/Kw9ciVJwxIJfzBgnu+fm7da1Qz3k2RHBH3MSz/mxPAlHTv3gYInPr6p36+5?=
 =?us-ascii?Q?GObEcLBPDXd+KhUBD5b2GIy5cwQTK93pPLB/Ito1d/+JiincLcABaGfIUmGd?=
 =?us-ascii?Q?6brOVcnJmHvVLRaq9vxSFi8geFTWN1kVR/U+3bSnwEFzHvF6+rWtDfvHiio3?=
 =?us-ascii?Q?/oJvC0KevqFYlQ7/t0TUcjLhtFcqFU0OZheA/AKnnvNj4+yU1VWD/Hgi7FhE?=
 =?us-ascii?Q?oHok8kzI7kK/F8Ud8sJ1y/4T1A5neNwdQjsf9bYUHzMvVpca5KemJMIE5R17?=
 =?us-ascii?Q?CneUfDH9HQPfGMx36hNSwEtwj0dV+FLs4UOItWGwLoZJRuVJbYQf3j1uGZBG?=
 =?us-ascii?Q?Y05Tp2Hc1NEEbyYuY3mVHNmoANDqwIxv3A46SSt20Kiu+m0j1hvkGCV6y5ao?=
 =?us-ascii?Q?gQvI+shdRk7/fxT8YwizyxZxYdJQPGVVFtqJDDHxpaHSPJ1mI2PcUrgq4oLI?=
 =?us-ascii?Q?fNCZM0DMaFKgDWwZZOjbKJ6YWl8dih8FW4NuEngug0yfGa0ChYvkA/cD/x8p?=
 =?us-ascii?Q?xqtUAzFEfrBnRlebjDdE7nbvgh4r//uth0wT1b4pFMI9Tua0Bon7Nr12AhCW?=
 =?us-ascii?Q?MY4M+Mh/zGWwso9svGZI/CMfeFZVTMVlCbnsdmuWZW0iF7GvHeXfyUMpsj68?=
 =?us-ascii?Q?MGwv6I5gbBhX1vcznyYB7J9ZRNgaQfpzVPIp9Nh0Mo+1jE90m9npqScBeYLQ?=
 =?us-ascii?Q?qFXBKVFNJHqM+Um1suXvlellh2nbfvgbXkhWtyVzhwXJp2MaicYH0cjsmBqw?=
 =?us-ascii?Q?XCN0oIT8fcraom9Omp9g7GNkitYm1VwVUWt7iRIqnDOaahU5T0yL6UzYEENF?=
 =?us-ascii?Q?/AeEaPGqjTJtcXW+Ai27fqSoXaC4FgVm1vHBzKaZozVDZ2rG8hv9ovUvDE+J?=
 =?us-ascii?Q?mwaOW81dJjSe1Xx2EoBPctIDCTFjvA/D36nrYaSbsJxrkF6ewItEcMLTovvf?=
 =?us-ascii?Q?MPrndwF6ifOto6Dwnp1c8A2154LvXEPFBhbSy9ynl3vRLdyINDd3dtFjmQHm?=
 =?us-ascii?Q?ZB/X32NAOzozllWMA7q7y92Qsglq3E4yq2jatNZtxrYZ6ue2OlAB5q6G233/?=
 =?us-ascii?Q?fN+iVlYz7fLjGFrnc30rlq/GkRShmi9xkIstdyjXFP3sqLpHgEbrssPV7UGm?=
 =?us-ascii?Q?22MMtUFa7FGYjBbpOgHOv68rAm9ZTgswQFbGrd8b0HWcvaqKr2/8bsrpj2Pf?=
 =?us-ascii?Q?xtMQrKsWx2BFMRFqfpn3RDMPkO/FKcjlMPas0nIy0pCPJ1p8OuzyhdmA+xCF?=
 =?us-ascii?Q?Hwpi63nCD/dljI0tHrP69ooTXk6HWH+jlfR9Ncr4E4uR5nCpQvZHVdUsczV3?=
 =?us-ascii?Q?Eqdpz7xzL7enLYCozbxW37D9XTzcM+NRmRTQra5qBy+rbS4ZALpI11RQIcf7?=
 =?us-ascii?Q?w4uGmtheGxYhTM3umg8Y0Y+/j6A1NaiI2sRP/VrUQg9XotHAKfuOUOIZ38QR?=
 =?us-ascii?Q?k8Wv0CkFR4rT8Ie2OIPhCi1gV1t1LJMVWuFLWFATF8YCE4Bd3xyFOeUdLB2R?=
 =?us-ascii?Q?06fcw8m9YMQ2CaQpPriK92u5KHVYIvSIfGDzGxuaFoaV/VS8gSPkPXogt0In?=
 =?us-ascii?Q?Djl0AZv5LB0/w7t22iiPU0ESwKfMrpeomx5IsTVJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L2njSlXYpD0kE8ibdcL9MEJ05d/YRvQI8XmqFRElMU8ijLEQ2u4UZZaKlJN+9LID+PSTYp3e6Spb1sb6rLeDARqZNwLlY2aU2pbkoE/3RGdZwJbma7HSRATedhs2GvU2cvxi+7qMEU99iVvTPxbyOhXDV5xFyvPVjKBOOY3E3OYxoZZ7kqC4HVjXp3ZJS6xZjw6fbC0B/toLyRRRu+l5SbJxkWf9cXdXH1dBO0VSda4QHrA7xAD56E4BXH3nrWcYJyVZECYr+1qVaNta4k0jOX5Ngo+4KWXpv2GUQ06qIEotnGW4xkcrWDDE6LaSe92+Nz6COXfvGdstu5GgBih7A6PQ37ipeOAaHGEFO8mWfbw4JXikMas63qX2cULBzRywR/CcFymxdPddkhpkMzASPffBU2ZfiRZnB6di8ffttWQmbtHCC5qrCMZazPTxqOlN4DyHacqeuNRjnPtkPfyJMejS6GjbFHXsqYzTTtU8QtmpAccde2rliVQqVcVzOO0y4x8EQtnGKeHh/lU1oDcJOkcCYKZ7oQ35D2TIea/DF0Y68wjZwGqvFDJTN1c65++BhhcC0/aTfrIJ7r+aPM/BfgHUNkoEkLB84fNRlN3bPO9BWr7rDaujQZok91Hepqn4hOfXECK9cepCmhQDHc3JApsum+C1QLR+2KEc0K8uy4aIEsratJDAuTdgjLxmJyC75DQVoi4YdIqRDbfj4cuZkyMyrSeiCFDbaxqkGm98wyKytoX9N3sfY4P2z/CBUpZJlK30vP9crt/gNe+atXFRlg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc90dbb4-2647-428f-0c9b-08dbeb38dde7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 08:56:08.1647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zw4tScELW8v6OHFwzZaLkmyI1B7z+KAu6WfSg5F5P4B3O29PhgSyDhQp7jiwfSisBoxylqF607jNElWrLBZ/Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220061
X-Proofpoint-GUID: M-WaZkDEr4_qIYpHlYrDEHMYhSJdkvte
X-Proofpoint-ORIG-GUID: M-WaZkDEr4_qIYpHlYrDEHMYhSJdkvte

Several test cases under tests/btrfs are missing from the remount
group. This patch adds the test cases that use -o remount to the remount
group.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/015 | 2 +-
 tests/btrfs/163 | 2 +-
 tests/btrfs/164 | 2 +-
 tests/btrfs/167 | 2 +-
 tests/btrfs/220 | 2 +-
 tests/btrfs/233 | 2 +-
 tests/btrfs/258 | 2 +-
 tests/btrfs/263 | 2 +-
 tests/btrfs/276 | 2 +-
 tests/btrfs/293 | 2 +-
 tests/btrfs/301 | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/btrfs/015 b/tests/btrfs/015
index 7398f9bfd84c..aeec8cc917c5 100755
--- a/tests/btrfs/015
+++ b/tests/btrfs/015
@@ -8,7 +8,7 @@
 # readonly and remounting rw.
 #
 . ./common/preamble
-_begin_fstest auto quick snapshot
+_begin_fstest auto quick snapshot remount
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/163 b/tests/btrfs/163
index c2a04791aa67..da31cfb8f1dd 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -14,7 +14,7 @@
 #   c6a5d954950c btrfs: fail replace of seed device
 
 . ./common/preamble
-_begin_fstest auto quick volume seed
+_begin_fstest auto quick volume seed remount
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/164 b/tests/btrfs/164
index 43c55c163cf2..bc62b535ca0c 100755
--- a/tests/btrfs/164
+++ b/tests/btrfs/164
@@ -10,7 +10,7 @@
 #  Remount RW
 #  Run device delete on the seed device
 . ./common/preamble
-_begin_fstest auto quick volume
+_begin_fstest auto quick volume remount
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/167 b/tests/btrfs/167
index fb271cfa1369..99c984f433dc 100755
--- a/tests/btrfs/167
+++ b/tests/btrfs/167
@@ -11,7 +11,7 @@
 # ac0b4145d662 ("btrfs: scrub: Don't use inode pages for device replace")
 #
 . ./common/preamble
-_begin_fstest auto quick replace volume
+_begin_fstest auto quick replace volume remount
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/220 b/tests/btrfs/220
index b092f40bc1e0..cc092c143274 100755
--- a/tests/btrfs/220
+++ b/tests/btrfs/220
@@ -8,7 +8,7 @@
 # * device= argument is already being test by btrfs/125
 # * space cache test already covered by test btrfs/131
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick remount
 
 _register_cleanup "cleanup"
 
diff --git a/tests/btrfs/233 b/tests/btrfs/233
index 6a4144433073..2b94a9c6befe 100755
--- a/tests/btrfs/233
+++ b/tests/btrfs/233
@@ -9,7 +9,7 @@
 # performed.
 #
 . ./common/preamble
-_begin_fstest auto quick subvol
+_begin_fstest auto quick subvol remount
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/btrfs/258 b/tests/btrfs/258
index e4a23dcc4e7f..a4d15c431e6c 100755
--- a/tests/btrfs/258
+++ b/tests/btrfs/258
@@ -8,7 +8,7 @@
 # in the middle
 #
 . ./common/preamble
-_begin_fstest auto defrag quick fiemap
+_begin_fstest auto defrag quick fiemap remount
 
 . ./common/filter
 
diff --git a/tests/btrfs/263 b/tests/btrfs/263
index 8ff363d15049..5bf8d49998f3 100755
--- a/tests/btrfs/263
+++ b/tests/btrfs/263
@@ -8,7 +8,7 @@
 # defragmentation.
 #
 . ./common/preamble
-_begin_fstest auto quick defrag fiemap
+_begin_fstest auto quick defrag fiemap remount
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/btrfs/276 b/tests/btrfs/276
index 8a21963c1223..6470a2f6e62e 100755
--- a/tests/btrfs/276
+++ b/tests/btrfs/276
@@ -9,7 +9,7 @@
 # and when the file's subvolume was snapshoted.
 #
 . ./common/preamble
-_begin_fstest auto snapshot fiemap
+_begin_fstest auto snapshot fiemap remount
 
 . ./common/filter
 . ./common/attr
diff --git a/tests/btrfs/293 b/tests/btrfs/293
index 5cbbee8fd1c6..cded956468ee 100755
--- a/tests/btrfs/293
+++ b/tests/btrfs/293
@@ -9,7 +9,7 @@
 # are removed, we will be able to activate the swapfile.
 #
 . ./common/preamble
-_begin_fstest auto quick swap snapshot
+_begin_fstest auto quick swap snapshot remount
 
 _cleanup()
 {
diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 7a0b4c0e1012..16126471a024 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -8,7 +8,7 @@
 # removing them in various orders.
 #
 . ./common/preamble
-_begin_fstest auto quick qgroup clone subvol prealloc snapshot
+_begin_fstest auto quick qgroup clone subvol prealloc snapshot remount
 
 # Import common functions.
 . ./common/reflink
-- 
2.31.1


