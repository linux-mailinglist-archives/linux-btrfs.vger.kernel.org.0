Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86176DB94
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjHBXbD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjHBXbB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:31:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2CD26A2
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:31:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiQaU002262
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=kw0RkFQ/8vk+TXFXb3kcO/UIb0BkeD0BgW25fa+dyBE=;
 b=3dxVDPpgO2KZzyhsoPKMdtUcnGNPVV+lz0SzLThsAXuMlCxQstDf/bI9JAlgcRHmP4Dy
 Rjbs6FOo8cQvUgGkTuw5J+qpfQRsUHbrQoyidNNFU4mXwjh1T7Ibnpw7qVVfGPm+HI/Q
 pRsjUI5/Vz7g+ee4Y+D7s9mNED+2ZmosTfXDYdQ/YgGmKGTOT3/r3LiT7mpgh7rmy6AA
 9iAbamyAhgGEMfaCl6CvVQ04gR07mgphc5w9HlwqcvWxCB8qbUXhF+X9wmQm/53UW0HC
 CN2JFm/5tw86ty1LgL4zZf33cIjwEgOHB5W7PD9jw8bnvxxGm/VDFtU5rlbVxhmg3fVK PQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2ggg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372MTca1003917
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7emfpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa4mdoqn9DWN7YuixWB7r4nEWlWGBWrO0WKZ+LAotkQ7WSxpldAcFel0+6AluuGldJ/wgw+MGlMHdmSsahOTnW04qSf3CbmCW3vGwgg2/H9bkK4A+mw4WAXEv4rWp51lTCPiwKc7VR8WDEwMyEBQUWHGi43YJgpwCK+yTAkUQphw1YqtoSYGvd8dWoUGw19YgP0vExOGp+lcwDY5RyLuTMnyJ+GNb+H6uBiz5Hc4WAZjhvkb0oINqqE+CYtuKIX7CZdku2Kel10sFiRjMcQI69UsA83HyPwQKauA7rv1Ag6WktTmc5e4AUpKzBC6y07wPSrBTs7beq4TLP556OdLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kw0RkFQ/8vk+TXFXb3kcO/UIb0BkeD0BgW25fa+dyBE=;
 b=NrdXO31UIUbfeKZYWtvQka37uI/NdcRAP29MYaTdO3Klw8IgdsChUl2UstsBe71hED1Z8bdnQu36w6frkrvAZ1DEnvVMN7lfcEVKwLWU+e88jU96fWNDq4CYzcBT0+UKbU6vEDTwd7Oh7A/YSs08ctcDWiHSQ0ibGSD1rc+HYPyJk14AJk+bP4nsP8NeCnj7hlAfNAhdm4Uu5R9hgJArzLkcddc2CPfoqtMP8qHQFCdNoAB0jrPVoS2nE1+aWlUusCWAedtQNBTvhVxwJJ7kG9FX3niG2n0zop1NOceaAu6hWeoSoouVClPEP4q35qce6FBX+GE9G2fBHXTHA4+bhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kw0RkFQ/8vk+TXFXb3kcO/UIb0BkeD0BgW25fa+dyBE=;
 b=bBje7bY45K4ZkIUFyZyQHPsJyBO1Mp365lCz1Vgc4WibT+g0f8CyoTQiQwmZdyejQ1raBZN2/DP/J/fNOyi28JOYGmZ9KR3BeEKyz94wIKNMmc/DTz7swe80fytX1Ghl6vMLSnN1InWE/XCXknzRh4vfchg+cp7YHh+oQ1Efdtc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:30:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:30:56 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs-progs: track active metadata_uuid per fs_devices
Date:   Thu,  3 Aug 2023 07:29:45 +0800
Message-Id: <3d9fedc25a03ffd184cceda162ef13e6427dfab6.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
References: <cover.1690985783.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::24)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 1620d488-6217-4d1f-9224-08db93b08565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pSV1+aZG28wvDEiGrwiZsgSAhHqTd38pMAFHrnFwsDh/pGYvfaiCZKMx18Ms4qYqpziPiGq1mh4DSydBhhyl9ubcYlZlsJHwXWPpl9VipAPRyupGyAn0auOQqux87cbxX39dfnpf4unk8JWmQdWAfw1kpqMBEwPwrDezsXqPZTX0Lab22CXY+OV0BkYsZs+/Duct0jNknow9zADpX/Pzf+yaonRpcmfQzDWhmbOg0vROc+nl0wRDLC2cXJLB2GWx2WsCYvF4peEOH1f2uh7x+dPc6EV1b8QeNw1wCTVo64vRpQj1/At3ErGGNrhSMKN52lH8AnHl/p7TJ48fa7pRhLsoGP2ZKdgcsLdVz7+secVY/ayvXYHFzTajwx8H7FXKxjeB4FwaAWvt0jR3QxLBh/VNX182ljNqa/gqgxyh1ggzBVhuflUhyvS4x/BiNtuF2mhIFMq+Y6LAnCkpwWb4m50OT82Rsb9APkItiIjZ9XiSgNu+XcR+LjiohEwZGgUGFLy0XwHbbf7Pd9sgTGAq57KEda3rE6NU9yy47aVyqfefFmCgzvYswwesqORYv6sz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lqIQiZg6vLlAJDNLqysq1NJH55aOURCNH94NlHkJGBA+VdymOcQQpXpcn3fK?=
 =?us-ascii?Q?O/g121bfJbIL2h65ZMWrTa+bK49L350B2X1VtyPFMfffnKEt/HgFYke96X5U?=
 =?us-ascii?Q?vQBXut/PeHkvkWDL71oHJxSHq2R8OM78wNzCH/DT/NXydv392dI7l4i48MOb?=
 =?us-ascii?Q?63Z5/dX6V5Z1/gQGCbKVVCEaPI91po5QA3ui4i2cHioVAHLr4wWtz39+pX1b?=
 =?us-ascii?Q?MUqnM/LTReJvXapvXUfvEiE9xWXFH1n9bRe+BJtL9QssN4Hussk7Mv+qhmXQ?=
 =?us-ascii?Q?JYuoqGdNwJu0/QhnADAFInqy2r+hRinh9a29D6rOzLSX4z+6tjS1Gvz9Dt1q?=
 =?us-ascii?Q?uXdBXEPZKpfIG9z+L7Co+L0zF/iZb34usx5H4eiZs6MqxTxg04Zu1OqUG9EQ?=
 =?us-ascii?Q?TxkSrOXDJh+GsZpH8TL+X8dgKkwUMbJqWPT8FcJx7IDhg49x3elqx0qlG90t?=
 =?us-ascii?Q?/1p2228e9gGCWOhuVthWf/VDs16tMDjNXLAab0PUeLg04nI+VtyKkiPrMtrg?=
 =?us-ascii?Q?Y4jzAnB0WAouNR7wywdMiID4XWZPcXnjfUyQbZMsevMoM0aal58HTsA+jhhG?=
 =?us-ascii?Q?pm8lPfC+7C10zRzQdXbT3/E9WhtABiPvRib2dx1Cpnq2VD72XKNYmJqq5dY0?=
 =?us-ascii?Q?ShQPtD+nLZWmrullrnaj1gEUBsoYbREYXVje4i+CpsYXBLFgpoUj66Mln/db?=
 =?us-ascii?Q?Qf2vqJTLNjxxgaPT3VDgWhTltuILN107sacPb1UHnRfV98s0fJJ6o7pq+e87?=
 =?us-ascii?Q?Jg5IZ0Pwg+k5rTHGlmaKH9hahk5OkenIO3I03b7mLes2tB/JvUGJ2s6ykIhG?=
 =?us-ascii?Q?/QAByms8PtRlKM/c53J8Yk+xjzjjO4n2D9ZVvEEbAlFf1P5N+42gRFCtWrm6?=
 =?us-ascii?Q?HjiVyFvNtaFh1Q62I+mUvw8xMpZaSouxX5dC4Jw2gLSlH2ME023mO5RGBPtY?=
 =?us-ascii?Q?cgp8qLFmpUgEE4HZEZDRqOSq11qjCnx+ZHS43Naeq/RtgRy4Xj/vqKpA/MjR?=
 =?us-ascii?Q?ImlQpjsF2ERKkmexo+XH2Evovzox2IA5emiQSoOtDAusZ9LPO04e2ZQXLKBE?=
 =?us-ascii?Q?W63PLLgbcAwWICQS1N15tPBins0k5pUcFriO64e1blMcCiR0/SMcFXvSgbz5?=
 =?us-ascii?Q?NtX344PL47P+oTNDOrkgbeFS2RmVt0p8dMLRmBJu7KRVz7EwBfi1Nso3FS83?=
 =?us-ascii?Q?qPn+lqWcYh95JUSCAoy8jSOyCz5yTKho/uB8hl68Z9sWvGDoTANeBmGzWffl?=
 =?us-ascii?Q?vqdLEQCwbriTU4PzhccuRcKyVt0XICuCFPHQY8mYzg+RPVFeRpkKUEMzfpc8?=
 =?us-ascii?Q?6T6nQTuqjdSe8PsbriXWdSApnLRG/uFyHwD2EuhFNqCEI91VxO1y/CguSzBz?=
 =?us-ascii?Q?/3m2akgNMX98sirC+4+3fR7ZFucHyVsWVH9ehmLuBpgKUCsL1JE883HNLpM6?=
 =?us-ascii?Q?sLxZvEF91TWLy9mWcYRVlluYYU+zC63qiIsteE5RZBuLVw3kNrCSIybY+Kdt?=
 =?us-ascii?Q?wvbccKn2zziKBjZfiat+FOCjeUcfi74888Of5SXLiWbvy/G9h4HoMRD01vkS?=
 =?us-ascii?Q?J84EVxIiXgIjAF5Xh5L8J6kQdEdb5b0AKnLvR26i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /IIlAHzVw3MTxwyjcVYPU/zrDaGO8JDRt/T8HSQ2Hso4wwzL9Ok6XvyKd7OH20lVEiNNGF3VVYHkJ1hxZUflLTq+DiqywfT7MmNSMcXHQC+K+CNVLyN3F/JD7xswBGM/GwC+YFuoVgdn5vOOoJ0hIYue2dnCK4pVysvFQ8junWKB5w78J5s+l1BouFnEAn21R3JCpHKEXAsIRQkGUsywHspTUUzYjEirLWRzgHU/LPaSt8fDvk+Xlx3iu72atrUdCd+Y4GcsySiopyPdFQ0UQ+qm2uhNeZG4GxNM66Lw/4I5hNNO91NDqcU4t6RpjcGrF4BMqAppxml49AFvgruVZQiOSRv1cVs/7KkWjJOUTtddWeC15qw/dFhI6Rqxgoh9gSyFT019KZLNPONfFW4IsPx4Vwpe4MQRZu5WnNKQd45DZXct+VTXjWBxf0A2B13vpyyRZiKw+0e0o8dYcDEft8WaTgGjgsVtBV5Jy862vpQGk054frWPKcKC9O6MnGu8xm4RZE/bc/MCUay5HRTXwQWnej4+lVSsd27FHH4iDfF0hYpvsgv0u9A+s9YRQFi1oK2Zz1QHx2cwQeCD4kha42I/bvyzA6C1BRas1ngmestz6dPTDUDQKMqSExSs8h9JKr3zapAxiZZvH2GlykpnBfo0CY9fmcQq45k47oF/W4m2kW/kKBYbt1XCutbEJNwsmoBvyJYI/jRSHW26fZaAXGJhlslDJX9i3TRA2WeKr+EaHEDBuieFALeZZyT5k/rteZlYrg0kbXNctsS7ALygwQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1620d488-6217-4d1f-9224-08db93b08565
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:30:56.5858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcEL+066HD/DDcdXU1iecrOWyGKWO3TyU09pL8AG+gBLlm0OTy9ffVwHgACynOVQTa6Xm99XokBLFLdd4v8PLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020208
X-Proofpoint-ORIG-GUID: g63NxqVnjcOVTw8tTbTkMlAYrDMKHi5z
X-Proofpoint-GUID: g63NxqVnjcOVTw8tTbTkMlAYrDMKHi5z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the fsid does not match the metadata_uuid, the METADATA_UUID flag is
set in the superblock.

Changing the fsid using the btrfstune -U|-u option is not possible on a
filesystem with the METADATA_UUID flag set. But we are checking the
METADATA_UUID only from the super_copy, and not from the other scanned
device.

To fix this bug, track the metadata_uuid at the fs_devices level instead
of checking it only on the specified device in the argument, and use it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/volumes.c | 2 ++
 kernel-shared/volumes.h | 1 +
 tune/main.c             | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index 1954bc230462..ea7bfc66a5e4 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -435,6 +435,8 @@ static int device_list_add(const char *path,
 	 */
 	if (changing_fsid)
 		fs_devices->changing_fsid = true;
+	if (metadata_uuid)
+		fs_devices->active_metadata_uuid = true;
 
 	if (found_transid > fs_devices->latest_trans) {
 		fs_devices->latest_devid = devid;
diff --git a/kernel-shared/volumes.h b/kernel-shared/volumes.h
index 088cb62c3c32..23559b43e749 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -103,6 +103,7 @@ struct btrfs_fs_devices {
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
 
 	bool changing_fsid;
+	bool active_metadata_uuid;
 };
 
 struct btrfs_bio_stripe {
diff --git a/tune/main.c b/tune/main.c
index 8febd0d6479c..d6c01bb75261 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -412,7 +412,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	if (random_fsid || (new_fsid_str && !change_metadata_uuid)) {
-		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID)) {
+		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID) ||
+		    root->fs_info->fs_devices->active_metadata_uuid) {
 			error(
 		"Cannot rewrite fsid while METADATA_UUID flag is active. \n"
 		"Ensure fsid and metadata_uuid match before retrying.");
-- 
2.38.1

