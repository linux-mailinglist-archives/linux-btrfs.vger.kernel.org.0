Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6891C70D9DE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbjEWKFK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbjEWKFA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:05:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D49D94
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:04:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EBse000311
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=kbl4jLlabfg9ePPYlhHR2x+o4Td/3XXoELqq2Cn8JL8=;
 b=jrwXIXeTwd1s+py62YzicIqaN4NNgvDFFVQqECvwXly9hi8/lfZDFqO0adZofbfYT8fp
 FekZTr92RWCi3xUAtsdiBeCBunNZ9IKbQ/iX7MLKkxNb5B4/t+PMuv2tMX86jIGxs2Qu
 yu8PhUd51bcx9FCc+eQPRMskWS9P3Gja4a14wjVBka9FirLY2zKigh8jqzBky0W4r2sq
 UrAgGJA/tRRd1tpwSJODhIb93ISRkCyOteB72Nhg8R3ZkRJ1w/maC1Tqhz6HIlmiZgjo
 J/JWpPseivFbUmpxwuVmcLIFQuIk2NJu3EAYGQiGUAPHwtHdVa204kEeGlpmIbXJEUJN Qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44mp81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N8xAEf023642
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8u44ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcVd03zI8yycpdOiYg47qo1jEnRADFhZy86FQNNa27Atzu1KDcXGxy0Vdo0Wc8vAnthSDMhL21hdYZg0uvsMGe7ZDgZQdlXYglxO6hElaIRfPUVPE5KTCXzHXFr6v9MZ93HKgCi5BVTxJ8T7+3nGW6YPnMusx8opk1GJVLD7+OfaRing5voAUpCL1q3dSGs5P+nd1ATotzYT8MlXeq7WBwfz0XV+STFdoHObTiiOBvz/76nnotd6nxpMyOWGjvoODhYO2oYuj59nqq+QS8WwwcEUYD3zll2shz3I+EOYiyNLLKNz7O19sh0YQ4AWaK9SlyBeJ6zztnh6nInBgJhkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbl4jLlabfg9ePPYlhHR2x+o4Td/3XXoELqq2Cn8JL8=;
 b=HPKRm0y+aV10Dsi05fFztxRkzojIRo13/n2xMnLPM/DOnmHW/nG/+ocjEQsMGo4shIVIa4zK2r7voScLHKiIvP+aXBFPM8dCoMYRTE5NHUbitoMy1tDJoMSwpWIQt297DYyflQFlHL8o3GmxKP4i0Ogj9+9uJRgYpIv7A+e4OeKD0jneL/GK5mA1ANhqku37795g33o0LLaUIWmmS5xeP9Vef0zfVaGS0Kx/aFuc5Kacq97wIrTj59rfhcQ6uNz955HStuO5y8XEQkq/iPmW0zdWGAtj86U3/Yw/+Aua5AJwQNDBsce9X7H2SuLQ8n+Fq8vduQqfTysD2y+OzozIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbl4jLlabfg9ePPYlhHR2x+o4Td/3XXoELqq2Cn8JL8=;
 b=g/0YKr3TjO+tllZ/8L1ONgL3j8UtbG5GAGy6Pevlnj1Di+GZZW0twJb3lF/X8x+2GnGH+WgHCeCXwHbkMo9GODGyf987aOT53zyOkriA5vvcMkTIdXsSZmPNcgjrMvC/xvm+UQBgk7Oo0BLEHAC5VDZOeKBLbHZoGxnXJL+beEg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:04:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:04:55 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 7/9] btrfs: refactor with memcmp_fsid_changed helper
Date:   Tue, 23 May 2023 18:03:22 +0800
Message-Id: <f20e34da9890944d60233c635730e92b7d0b6197.1684771526.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684771526.git.anand.jain@oracle.com>
References: <cover.1684771526.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 033ec4fb-5c4d-4cae-454e-08db5b7528a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7KL9YOMhHvVY7uoD+10wpVlmgJIAo1p3sqwtrcnXOsRHQMJtRx6PYsZ5UwlOC8lyTUdC0POhwcs3pMEdWTgAV8zYHYtpWEO+kui+kTQrOKWAQmgGhl/nbyV6voD3oRqIxdqDZVzlHnrcO0hquFEfg5E1rQ+b3v8EeKEMPe5c/MykqUQ51EcoU+S5Ns9KsebbIwSXK4qPO8+tOKlJFrEjaTT/fu7+vNqUuBwl8VNanQBJl0iUFTsGS/v8USZ94ConNIhZgWfz7SyO2+gNRGMJU8P5km/6ZDwwntqEA1oCl52lsHHITxiPVNbNEkQ117VLZ9QSYz4NKAU89WibKLtCS2ExEbUWxto5P+5iHXOnTpCxUkXahAmEwkASVT2ioaFJxdECajX7oZJj3ZKZH/JESzAWj8OBc21PuhlGldgso/utH7OgyOXVym2sD8ZHvIPxu4JfCbmLPbxs7TwyXnsjYVj7Yh64QFLAGvWVpBFSWEPfSg1nJ3/88y2C+Y77MK2M0T7/67+ZQBy2V4EJTS6ElK3VQzyq/VTf9dEf+U6fOAZex8qwvG+a6s/CmJ9IF2u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(478600001)(107886003)(6506007)(26005)(6512007)(316002)(6666004)(41300700001)(6486002)(66556008)(6916009)(4326008)(66476007)(66946007)(5660300002)(38100700002)(83380400001)(44832011)(86362001)(2616005)(8676002)(36756003)(2906002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v89gaJ9xQWHRK4aS7vjy4o8U1OogFIEN8yYjEbE2sdLJKOmg52mA7hDcjBao?=
 =?us-ascii?Q?QzdCTXXxe4u6MJfbNmsrbS2qr715+b1js3RbRCStXlMPnXTBI4/27YB3In4A?=
 =?us-ascii?Q?LHv8hzD+0A/t/78IdlKVRzbvYGiGR5wOZsORH13Si9doSlpYlXYpnZ7sZCQB?=
 =?us-ascii?Q?Yzp5eY9SDVkA1Z81NOyvdwqFCgITEoe5C1fG4ZHIgxE6elP0a7kMqweC/WVa?=
 =?us-ascii?Q?6j2bYd4kXwEL5vjpnsbHvOfMr4WNqtuObNISArEyqObfRNIQaxYvp00GOvcu?=
 =?us-ascii?Q?z0VqZ8VLkFo/Ck8pzXdkuAZVITKlwxPcOkn0mizZgjp+5m0XTtRPxZHwjiVx?=
 =?us-ascii?Q?/lFlra9MBtaWIUJUAx5bWb3aM7Etg3sEc6n7d1RJZ4qtTBvG1KcjATOWEtEp?=
 =?us-ascii?Q?uSDFEitoX9SCeBrsNw0UUHEXJdFRM2iP5QYnYQBN28tdDY/H7D85KZG64FJX?=
 =?us-ascii?Q?H36g1/EirE7c916sn64KSAWU0Pw0fY4GkbtQ4cAQrCYfEWtHb/9Rw8UNEEGc?=
 =?us-ascii?Q?bKIkxW7hJdblL/gnOOklbpMCgJo/bpOWxUPN+EZ448uwV1lTDZ5lgeEll5I0?=
 =?us-ascii?Q?oF00SVU+QdXfjZ5FRi2bbVMlYTw8j2nsEAcuOTjTNVVJTK5ueXKIhLeGVtNL?=
 =?us-ascii?Q?CvmzwsWCFTK/s9ODgfGFI2es3X2gkBVED+bOikj+QN2mc++or1Faix+N1gJo?=
 =?us-ascii?Q?iHptYdHWU2XQJ5EduvqAkLNt0G5vsKkIpqwCEoAJKACleISikxQ/W/9UpUQ6?=
 =?us-ascii?Q?LY7XJFsb+DEfXnlmoqnkqxLmmL+dtjL2QFV37UMPTXMau8hsmzwZ82lZAhoR?=
 =?us-ascii?Q?GKW0sCiFEkd1/F7Jg6tHcKC894lMS7/vsGUV27EuMFO1ZyHAmYxKqrmEP8Bu?=
 =?us-ascii?Q?cNV4vZ0i0/XhPYicgInEtPTJu4HYvG3rTy3yM006PcTzh4ijY+ddY14uW+mv?=
 =?us-ascii?Q?HlfZ/xmWpGSnaqcmefwDfYi2FIM64wJce4uhlflg7mGWZYv4k4pn3RZxcjYk?=
 =?us-ascii?Q?y3LTVuvUkUMufkh4fSbw6Sc9yb3+sFJOHbi/rYOpW+RYMahzVliayOYIgF/a?=
 =?us-ascii?Q?O+Pi/7d8yh4RTNwC13QiFhdWwcWWzoQeUKf5A37ooRiEcnw+sUchJJuMCjcy?=
 =?us-ascii?Q?ZaSvfH7MDbcf2rFRvLUhLZo/AXOZh/yNmEOi6Zm9ybiCtIaMAbMGxbdnIxk+?=
 =?us-ascii?Q?HkghJ+vhNLE+K6hKGoWHDpdi+Bgps6W5ISIZ2DZdmeadIlPZrTcwnoScJRWR?=
 =?us-ascii?Q?NiiZYAZkCufFkbSeejFGeIHmozKm6nYBevMqP2gwY79zaBaMXL7MYzF9w6iu?=
 =?us-ascii?Q?mreR9b6kR2fKBTguiAQba8ejKprrCUjBUMvTSKbbavHCC32Qi/K1Xy8obw5K?=
 =?us-ascii?Q?iV4CXnHWj2zK1OPBPJ5gjhYVWDDoNE1l14lEB/+NiHwpIAOZ8WTOaRXrlL0T?=
 =?us-ascii?Q?BuLGtl0G8aRWfhpyNH5E51j/kxYBusHGBtzYxmLVrTCjE6GTb4MTwDy5zoE0?=
 =?us-ascii?Q?ueRyiEZA5E+w7W6ILzLi5dfjJojBj8wr8Y1JBRbnjP6uG+zUSVeYX+TxWq6m?=
 =?us-ascii?Q?jrFAFvlXtIq/fXNBBKM8Unfwcf7i1K+30K/VmCyhLS1fXfcKsiOWUHCcTd5Z?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uG0sb3hSvtFTYSR+YryNQs6B+Suze7LXsWQnP+Bj7k/X53DbeMH3Gq7atPKscmVJ6de+jjOOJC6axrBVxglEMLVCF/sambeG39jdfExVjRtnBf1QFHVa7grN2CWaSXX96plL8xaKnFG59m69ylEBOQh+ZB6lVBDIJllsxrxWOy8HCRhDX5aU9Vuu2qar916LUzEthfInnVjCTQt5pH6HrgKXkyeavbCEHABfTQEMW1mYP+mbFXeDFQsgdX3k3ncotuJDWsE3LL0j5hLMdxm+Onr/dk1NgSbAi9CWftIK66mwJAIUtOm3ZOo4s655hPu2U12jqz/V87V+LsVoD/ITKjNWAD+rm2NkqWkOHSv427vWKAQO8z+RwUCKFifTW/9ZaOO8qHtFWd3m2sKRWd9oIBqnCN/1KK4nSnbBbglP97LqZ8WYVC9AliyPzquZJXB2G5KyQIkWzhGZzMvz9EAphgX6xMUiqpBkIQtkBtH4yGziCO/Z9Uqe9AJsSqiYf1B1iLr1qfhSyaixAlhzN585lwKW+ijDlAHSeAgUFGfoxElRFJsk1TpT9R6GgxzW8W9AJqZkzkTq6uR/RjSORw5YPJqnPYKK3luiQ3Cb7nKDADqYO22eHTcOLMNFseG1+lGXmrp+sISKByN5dVfzfXOf/pS6UgcdM2ozFor0yLvEykfQYr8MuoryiX8u5o8nhh0QMqXBX7FQoASj+UETB60u26Sfqp7DZUNRINLj6cvbMC2bwc0JRfaA4WGPHu4HhOf9Y5+E5vXnrYyL7TZ/JD63gg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033ec4fb-5c4d-4cae-454e-08db5b7528a1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:04:55.7086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkokJ/FefDFcCU9v0DJUeTR6Z3x2EDTDIWW7EBzjxJnIGzeAPb7a0FMXhml/TfVQ/0ZVgSu1dtkULXmoApVxgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-GUID: CccVi304VYWf_SkFTCYGrh06lX9syhIK
X-Proofpoint-ORIG-GUID: CccVi304VYWf_SkFTCYGrh06lX9syhIK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We often check if the metadata_uuid is not the same as fsid, and then we
check if the given fsid matches the metadata_uuid. This patch refactors
this logic into a function and utilize it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 48 ++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8738c8027421..730fc723524e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -458,6 +458,20 @@ static noinline struct btrfs_fs_devices *find_fsid(
 	return NULL;
 }
 
+/*
+ * First, checks if the metadata_uuid is different from the fsid in the
+ * given fs_devices. Then, checks if the given fsid is the same as the
+ * metadata_uuid in the fs_devices. If it is, returns true; otherwise,
+ * returns false.
+ */
+static inline bool memcmp_fsid_changed(struct btrfs_fs_devices *fs_devices,
+				       u8 *fsid)
+{
+	return (memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
+		       BTRFS_FSID_SIZE) != 0 &&
+		memcmp(fs_devices->metadata_uuid, fsid, BTRFS_FSID_SIZE) == 0);
+}
+
 static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 				struct btrfs_super_block *disk_super)
 {
@@ -487,13 +501,11 @@ static struct btrfs_fs_devices *find_fsid_with_metadata_uuid(
 	 * CHANGING_FSID_V2 flag set.
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (fs_devices->fsid_change &&
-		    memcmp(fs_devices->metadata_uuid,
-			   fs_devices->fsid, BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(disk_super->metadata_uuid, fs_devices->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0) {
+		if (!fs_devices->fsid_change)
+			continue;
+
+		if (memcmp_fsid_changed(fs_devices, disk_super->metadata_uuid))
 			return fs_devices;
-		}
 	}
 
 	return find_fsid(disk_super->fsid, disk_super->metadata_uuid);
@@ -684,18 +696,16 @@ static struct btrfs_fs_devices *find_fsid_inprogress(
 	struct btrfs_fs_devices *fs_devices;
 
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(fs_devices->metadata_uuid, disk_super->fsid,
-			   BTRFS_FSID_SIZE) == 0 && !fs_devices->fsid_change) {
+		if (fs_devices->fsid_change)
+			continue;
+
+		if (memcmp_fsid_changed(fs_devices,  disk_super->fsid))
 			return fs_devices;
-		}
 	}
 
 	return find_fsid(disk_super->fsid, NULL);
 }
 
-
 static struct btrfs_fs_devices *find_fsid_changed(
 					struct btrfs_super_block *disk_super)
 {
@@ -712,10 +722,7 @@ static struct btrfs_fs_devices *find_fsid_changed(
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
 		/* Changed UUIDs */
-		if (memcmp(fs_devices->metadata_uuid, fs_devices->fsid,
-			   BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(fs_devices->metadata_uuid, disk_super->metadata_uuid,
-			   BTRFS_FSID_SIZE) == 0 &&
+		if (memcmp_fsid_changed(fs_devices, disk_super->metadata_uuid) &&
 		    memcmp(fs_devices->fsid, disk_super->fsid,
 			   BTRFS_FSID_SIZE) != 0)
 			return fs_devices;
@@ -746,11 +753,10 @@ static struct btrfs_fs_devices *find_fsid_reverted_metadata(
 	 * fs_devices equal to the FSID of the disk.
 	 */
 	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
-		if (memcmp(fs_devices->fsid, fs_devices->metadata_uuid,
-			   BTRFS_FSID_SIZE) != 0 &&
-		    memcmp(fs_devices->metadata_uuid, disk_super->fsid,
-			   BTRFS_FSID_SIZE) == 0 &&
-		    fs_devices->fsid_change)
+		if (!fs_devices->fsid_change)
+			continue;
+
+		if (memcmp_fsid_changed(fs_devices, disk_super->fsid))
 			return fs_devices;
 	}
 
-- 
2.38.1

