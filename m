Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3A4877EE
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 14:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347379AbiAGNEp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 08:04:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8764 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347439AbiAGNEn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Jan 2022 08:04:43 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 207A8ecV016699;
        Fri, 7 Jan 2022 13:04:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ec2dzrFg+UUE5EvDJ/Sd380+rfrMac33syoilGrk55A=;
 b=ZGlD1W/Dqrmpcmkk1xmXe/qLuj2T/iArU0klerRZrWDYffHppRkB8lzqBdMsPdbbpGrL
 DwEDNoY5DuxHh4jIAFgZy8/dblZbTVqArq9xuFlxslnOO8zoDP+rBJDonEstiQ8hGMpG
 QcjxghvNFhKYKVCSrFQpPzs4KcN0XhlDvvt42WbE41Eo04CuOfWxhfjNeCO1jBTsimZI
 D9hJb6FT/jqSkMOPhge/YlZwnrNLA1yWAJwufYVeF/0m6zf8qXG5bLZk10zOTl0YetIS
 0ecPtu2gNZjw/6cBaj+PkOSGTSgwo7T6drU6RmKgn4rv2neIKtkIJfnXNWevpkDgkNxI Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4v8a01a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 13:04:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 207D1kY5049308;
        Fri, 7 Jan 2022 13:04:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3dej4srw91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jan 2022 13:04:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmoJm+frOuBheSWcN19Hswzv5Irji50RJcqihA1++M4QClp7FpgE0XcRVLZBIXtx5XWMdvpuDWNwPIWkbu5H6HvIwJm7mD/fR8x4zM8R65i9AJdlC29bsQ/JCWWAfaTpMITrpH7r0C3TDdfHKY7id9Z6xkYii3rukunxj/wj4D6rGO4CnmAB3baKraziJVZSNPyH+8xpabovgdJ7K+CJEvN6kFlrc6XcWli4YjEJP4qu9C5BGlVOxlBYTvlRs4KET4EF6VlSrQuEAXjmz1dOt5EztXFPd0XfCFxyw9wDY5FfapUOKaprhfP7M3vmZPaRYi2+EIjJXDZjMEgCQt8yyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ec2dzrFg+UUE5EvDJ/Sd380+rfrMac33syoilGrk55A=;
 b=O45KVNKLG9qAGBawHLqv7618bKqR5zON13VFqWFpAyJJStMA+WriA5+30MT0M0mmbtbGDf+pKH7xM8XQU62xCtRQJGqMMNKO9hiVddadb/mkKugGI5EsAEh5gzK5ENXKoI/tJSeaMMWxhaF2Ji/1LQqW0SSnL6dA8MW7IFHI/ErP9/YL++aAAJiHej+icarz8GBnbwVnl8+HeuCfXgE36F5TAesPB3nMvIBQsnicbXBqqE97KNjv09ot2ayB4wB4r7RDU/2EKsYmrcdzxHYgPnNb6oD7B/jL/uf3AS7SwlELNrjm/4asqmvDOXTiQoFzmMKq8rGkfeTL61msggiRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ec2dzrFg+UUE5EvDJ/Sd380+rfrMac33syoilGrk55A=;
 b=q4S/RJr3FKm8m4dPl9Tvk5QmjiPP1+PaMMbDjG2YpmiLT8DR0bdqA6hWgTtYTK5pY4EpFHzEpLl7yAKaAxto4tm06RCUjyAAMQEE9Eg8LUvz0/sAAfpjLancw0JHAYxFPMGrT+dr8ouPNqJb8y3ybn3yKbIE5kFxIMA3bmcA9N4=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2995.namprd10.prod.outlook.com (2603:10b6:208:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 13:04:33 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 13:04:33 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com, dsterba@suse.com, nborisov@suse.com,
        l@damenly.su
Subject: [PATCH v3 1/4] btrfs: harden identification of the stale device
Date:   Fri,  7 Jan 2022 21:04:13 +0800
Message-Id: <e418fd929f03644b70c6be6a1b081bb97dbed254.1641535030.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641535030.git.anand.jain@oracle.com>
References: <cover.1641535030.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0070.apcprd02.prod.outlook.com
 (2603:1096:4:54::34) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1c7daa2-6d98-4401-b932-08d9d1de3f9a
X-MS-TrafficTypeDiagnostic: BL0PR10MB2995:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2995D8B835644B3EF1515C02E54D9@BL0PR10MB2995.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XCoj30t6j64yK+KNeOL65tcDX3Fap0LwEd1C5prUyc/sEygVYqQcBev1Gi0GSMM5GzDKYQxcFsZF2lzj1LgjYTyeCazbRaaDePpbdqYEGWEn4o1QP+YMVPZ6UmKKSj7J0ZrMym1/EEeSWNg64WRN2jFs1EbN/+WDGFDtohToLJYi2Gd0NEbAvU8+9zbK98ZZnCKDSA6VT/ta5UUjaBf/qmScii8cP4s5E9hWQZB/SRdeDeEgmWMNvaQA1rs3XN/61k+/FiYexpyMoqxt2Q6sDb0KbEJBbvv5IPmJILhTs8ic7KGdoqPzzeQa4n3LDzqyK962twM3HZ2yJd2x6wiaOSdR4dbRhSDkrLBuhNBphVcWCjIbeirSQQHo5UM1NiBn1GXW9zw/leBSFRO0rlNWL6txdUuNxL+QGK/FQ5aRlvxzMMbIZ1ywZ8cmzHNf0MzvnC8Oy4KdDMVzL3un3CLmLTfybpTYF4gDXyOxZd0VjASbnHz6Erf337kzbgX8UQ9PeKQk7MI0IOUDL5xKgRGw4CmhWSIetfiru3VGeN+lf/dV8DGLLU4e+3B5lp7BNQB66+v6uoBTvDLZLdwbefEGdGmHnhcFC6ugWkMYj2OqzgfhLpT6Mdq2sK2IPjlnys9I3h/V5Ttvw46+YZhTZUDPFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(6666004)(186003)(83380400001)(316002)(38100700002)(6916009)(26005)(8676002)(44832011)(66476007)(508600001)(2906002)(86362001)(6512007)(4326008)(8936002)(66946007)(2616005)(36756003)(6486002)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kkNODTYh0aGbQ5DMJX6YJOguF5cBrMX7Hk/moGGtomnDuLuZscd0INWuO6Up?=
 =?us-ascii?Q?2wrv+PxF+1eYgNLY+jHU4wYwePNqA49U36z/YUka9A7B3jO6qZgiHI06JVns?=
 =?us-ascii?Q?SwJJqkK9aULiMWxF/GgHhZqTCcbe5uGkPxUv5sMKjKr1kubIKKMaqSOvQOh3?=
 =?us-ascii?Q?HLvg1B+Vrs7EXQD6EAUHaJwwAiqrv1zVm/aDU6268bAuivXJqdMfPSmEdU0F?=
 =?us-ascii?Q?OmECPQOfVMeQ4K22RkUfDYiMZqrMRyerlYFBinUAHOA6VWSDA9QtjEfaZWcx?=
 =?us-ascii?Q?EblHNg+zoke09N9eLo51Y/RKM0cq9WAwPOYbnuz+hlSXTdNpDVuydin6Qp6P?=
 =?us-ascii?Q?fs0blRGBn2H584PI2pt4raoDlL4Y5QPVaDRi6X7QC3G7WxZa3k4txQpqxFXJ?=
 =?us-ascii?Q?SqS6kA4Ffo5g0fu6OCkWDP0R4vytEe/hil6j11MVbyfXN41En8x8WvBFRJgs?=
 =?us-ascii?Q?CAR4PvgBSHixz2nU7/nvMYfm03yS2CN3qi4M9mbkZA8d7Ke23O0ErVKUXqUi?=
 =?us-ascii?Q?0qJCD8PIG0EUEpm9XGctc0PJtLqAcrGeyfISFc8wmDlQO1h2b/VwA8yG/1eO?=
 =?us-ascii?Q?9JiKa+nMndxjG6uIc0Wv4d64qUpj1nDn8F6LXEMrq/OXW1zcs/zNxCUlzWfi?=
 =?us-ascii?Q?b5DgW30YLvVwXxUuL88/OSu5ooUdd42O/LAYDr9V8IJBHfAspR5ihunBO9rE?=
 =?us-ascii?Q?/zFQvXTNb1C7/2YYkbSEvmXv1Xh3jASLEN4O5w1mKGdSyuTzcO3UQTftozs7?=
 =?us-ascii?Q?tt/q5fpDQzq33jbuDjEBLP5veLW5qS2N3VlSsD3v/c7F/3SqiDBQSG7Zy2Gl?=
 =?us-ascii?Q?tP8ohJyfqVAvNUSDIXJvpRzIFDPFkLpeVWlzXEqomf7fJGj2qOSf6QUz0yzY?=
 =?us-ascii?Q?cnaJXfxb5bvhQ5yfQ03ThkpTQRagT3TK+BzkXV8k1HkWNJn5xZ075DeRkJjl?=
 =?us-ascii?Q?fMoVrR7olp0QCWNIrC0Il8XCoOS2zED1rVcvKzkX5PrBCHK17PrRh1Xb4zhI?=
 =?us-ascii?Q?SjuMdQRC7UGsNm/j76idDWKQx6Y0AgoIZYLDH/NnxnAjBOhe9HGL8NnUXMgs?=
 =?us-ascii?Q?c6DvBRZW7T2vJlFy5UTXc+uQuL4XLTml/z2zkWKAKJbSdhGkINbxn0mxw9gu?=
 =?us-ascii?Q?GvLA6NDOP9R+hS/lsEiWfGuUomapLNw1tDxkMSDlajbFyB16HNLfkVaLTGdy?=
 =?us-ascii?Q?JScEtUcS4NmhBguQZlADVR/oMEgheJTuECkC6PEAbjYCuQSrbcAspUd7n06I?=
 =?us-ascii?Q?deOfLnWro2RkhbHbbdsWZU4I3qD6WiV5zYLUJoddMljCsqpMBAdAAbUy8FiK?=
 =?us-ascii?Q?SQTUTH9F8n6jgWGLXf2lIc/d3zePIB2pFvy/+SYd7vJNn7vFZfEjZ8KpNui4?=
 =?us-ascii?Q?0nJBRXeaVrvpDzF9xsvMboXqKPDEGH+zaWUlJqlVcCH7Ab6yENiAhOeFq8WK?=
 =?us-ascii?Q?/JJKTDuSOXy9k+fvLwc9MvAgOS3pOZhSNXCKKD0v4IiQDMZPzZ32rQMGcoN2?=
 =?us-ascii?Q?OPVF5PpK9vJT+/OlwvSAuOJQbuAuld9hrwmXe01W3yPOmg9I8IOVbYzErWOe?=
 =?us-ascii?Q?cJruefvugo5f5Dpwn4Ee5iFHUnAbyvgqznz5w/BY0mxQkbfqNf1WJlcR2H29?=
 =?us-ascii?Q?ZVMmdRKC80a+rYQ8hfduUMM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c7daa2-6d98-4401-b932-08d9d1de3f9a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 13:04:33.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV8HkzbUONlasUoY1T0v0tf1usNQQPgmYxmBGCKzUeqvBOsTFSqu7C+z9Kr1tvbg25e8DiOtrJ2BeKd+936LPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2995
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201070089
X-Proofpoint-ORIG-GUID: 24wJTErwl86uq5Kgvw7TZ7MitXJtaBa3
X-Proofpoint-GUID: 24wJTErwl86uq5Kgvw7TZ7MitXJtaBa3
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Identifying and removing the stale device from the fs_uuids list is done
by the function btrfs_free_stale_devices().
btrfs_free_stale_devices() in turn depends on the function
device_path_matched() to check if the device repeats in more than one
btrfs_device structure.

The matching of the device happens by its path, the device path. However,
when dm mapper is in use, the dm device paths are nothing but a link to
the actual block device, which leads to the device_path_matched() failing
to match.

Fix this by matching the dev_t as provided by lookup_bdev() instead of
plain strcmp() the device paths.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: -
v2: Fix 
     sparse: warning: incorrect type in argument 1 (different address spaces)
     For using device->name->str

    Fix Josef suggestion to pass dev_t instead of device-path in the
     patch 2/2.

 fs/btrfs/volumes.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4b244acd0cfa..ad9e08c3199c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -535,15 +535,46 @@ btrfs_get_bdev_and_sb(const char *device_path, fmode_t flags, void *holder,
 	return ret;
 }
 
-static bool device_path_matched(const char *path, struct btrfs_device *device)
+/*
+ * Check if the device in the 'path' matches with the device in the given
+ * struct btrfs_device '*device'.
+ * Returns:
+ *	0	If it is the same device.
+ *	1	If it is not the same device.
+ *	-errno	For error.
+ */
+static int device_matched(struct btrfs_device *device, const char *path)
 {
-	int found;
+	char *device_name;
+	dev_t dev_old;
+	dev_t dev_new;
+	int ret;
+
+	device_name = kzalloc(BTRFS_PATH_NAME_MAX, GFP_KERNEL);
+	if (!device_name)
+		return -ENOMEM;
 
 	rcu_read_lock();
-	found = strcmp(rcu_str_deref(device->name), path);
+	ret = sprintf(device_name, "%s", rcu_str_deref(device->name));
 	rcu_read_unlock();
+	if (!ret) {
+		kfree(device_name);
+		return -EINVAL;
+	}
 
-	return found == 0;
+	ret = lookup_bdev(device_name, &dev_old);
+	kfree(device_name);
+	if (ret)
+		return ret;
+
+	ret = lookup_bdev(path, &dev_new);
+	if (ret)
+		return ret;
+
+	if (dev_old == dev_new)
+		return 0;
+
+	return 1;
 }
 
 /*
@@ -578,7 +609,7 @@ static int btrfs_free_stale_devices(const char *path,
 				continue;
 			if (path && !device->name)
 				continue;
-			if (path && !device_path_matched(path, device))
+			if (path && device_matched(device, path) != 0)
 				continue;
 			if (fs_devices->opened) {
 				/* for an already deleted device return 0 */
-- 
2.33.1

