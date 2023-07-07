Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D2174B4B1
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jul 2023 17:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjGGPyG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jul 2023 11:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjGGPx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jul 2023 11:53:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9259211B
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jul 2023 08:53:58 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367FiRZX007117
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=YrOY3sThUYk2M4Ooej5hFugZCdb7LS6AuH3PTDriM3M=;
 b=RLmnhrcnOq2f/GKhriXc6nW/mIfB4M/Iur2MKF4AZ7VQGbxdi8hR0l1g05l+VeHNHFAM
 EKInT68DiEYGWfMJ1QH2AVcnrMEksLAbJJyuIfkPMMqxF1B7S4C/IrO9Oc2Mdf4/OUTL
 cBvvmYknDY1QrZNtc+KgY+7TnUp+y6qg8MkyAiC+Zcg7tRYZUqdoBceKCQzQrzIBCdHC
 0I9eqI75FJPclwSTn/v8tD4UBiWtJRE3S4cR1vk6czc4HJckV2kjvPk0pyi6fnUdBg1C
 9C9Vu357DmPgLwu2a2wWpHmHWbEudMZc57nIdc7q86uP2B4EzYcYhuH45Gb2AvMN8Jsy gg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpnm0g0rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367ESReR007181
        for <linux-btrfs@vger.kernel.org>; Fri, 7 Jul 2023 15:53:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakekdaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jul 2023 15:53:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqskk2a+LfIR0iE/55btemH5Nrqvj3ngz2TQWhuGMTqsG1EPsbvT5Xj3Jhw4SDEWG+CFqkgdsqh4viXDRgAj34ELQHdhHrWIY1KHYKyLsuH337MmqLreQVhGTt7LxvewOobMGB82bxCKi/AiHo+MoVKWEQo5cWziJ9753m9/Mq6060VL7ql8rQkZuf9Y66FRaZzv2AAFbrxX2I6CyJ7FHidrfHquyDkfTBZMkVj4AXBCcJMbQLS/O6tDReyiP32OKiCXy0acDHvT8BJF+nrcB/n9gL0jCT//1dr+UtkR4nUcjql+CQ0Wk5omuwhL75s4AJg/tktpC9jEZodRvNSHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrOY3sThUYk2M4Ooej5hFugZCdb7LS6AuH3PTDriM3M=;
 b=YTye92SNdY9VvQBVMsb7+28hV/oQGIBAQeBOvPKYCGz68nCB1Obg/Zb/3hqigXMBsaoq18CtQeZslaOgzkL22v7BacR3LUEQwQVvZZSR3YV7BrzwKk+Svq29/fXuNAQGHnNLidvUAgoKjlG5Fpb19rJtdgSFOJGxONQRCDOsfeo+U/tNZE8tiG6VsjnDsacsgnKzIr1oQeb51YYGbnzoGJbLChk0mVl59k8pHjPQ/iHaIWP8OedYC0LEXRiztKqkzB9wtyKQ9qyJmMdwn9gstqUSGj0q2Hhp+Pa4UYr2ThmPFAtuqV5ofJPwQnVOxIXzqPMuvbuKhvL0vVKUqh04Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrOY3sThUYk2M4Ooej5hFugZCdb7LS6AuH3PTDriM3M=;
 b=b8HbL+QexNykzNmSFF7p9We/PKB69pUT7jqggKH0KLFcErAW4PHYvopA3wFiaRMaC2tTG7t4zH4RJDAe2vfVl/b/IepE+qOBKrOQ/GoKnZw7oTBzT9DCCXA5CR1JP9ZjtRJDFeW0aZ3AM9VohRz19hBTx0uiNK39W46SxfO8O1Q=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 15:53:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 15:53:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/11] btrfs-progs: track active metadata_uuid per fs_devices
Date:   Fri,  7 Jul 2023 23:52:39 +0800
Message-Id: <6e1ce53ea4e08063919db1b9074990a559e8d30d.1688724045.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1688724045.git.anand.jain@oracle.com>
References: <cover.1688724045.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: df8cd27b-8e97-4df5-36a4-08db7f025dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MWsT7Ls6YKDQDl3WRTIkacvHFVO2KyoA1KwL6wgQON4TUZRh007L5U3KWXhojnsH2KUxVcDYrBMzxdHpvA0Bi4Fh3D3IQDRSbfUePY+zVEJXlFDgl6xEX4U48y6yk47FU5UiWYgPFhw6UxhuIYDhg+I4h/2gNESwSn7wuhp5PnvMLWLApEuYy/D9mSgE3IcMiS5+1+ngwhIsaXjOuuuSvll3raORFd64hkJPlT/KPj44SAfFlHw4DlG6rZn3zjH3AXAZrhL+twMF2xVhLjoUxHvJxxlljy14r8SltJEwFLQwlHa+QKEnF+TLW1UCeWyINk2QxtYfbPLXRfWkDCwktSu/WGnt+/zEirDxYmTJo1bz5GJ2RfHGPlTFKM1NU68LqX/nEYj52EHKq0uxBm4cS13WGSjJNc8+TfsGNh4P+EDISwa6XmgLK8dnnwJtpjG0mvsdQ/czv1ER4NfQyaAAYn/If7y8phlMQlMUn0Ashe9rDp4hltK8EPg2FdlwGULdeCRZzO17YMLewbU0K/Ewho5fH/9nL93owELru1hVgdYhS9n8OAPMjrTTIEk0edtb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(8936002)(83380400001)(2616005)(2906002)(6916009)(66476007)(66556008)(66946007)(6666004)(6486002)(478600001)(8676002)(5660300002)(26005)(6512007)(186003)(44832011)(6506007)(41300700001)(38100700002)(36756003)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D09iipMGlXnnG9PCsdvL1kqHO/IrC4eDxKUGMxpO5U6crez7/zMG6W8K+phk?=
 =?us-ascii?Q?eTazDo79VwT64/2kdh2I2joVcnA+1DdZBAv2a62FGxtoj3a3eK84uHC5d22M?=
 =?us-ascii?Q?yJBrDRII7MbYdUOVJaGQIL0Gw6ndmyjYy14tHMJ6nFuwfxJRqoSx8dwUQJB0?=
 =?us-ascii?Q?nql7r1N2xuAm7SJ7i+/TW7DXbpazOROMevYQOT/Buy1qdpm+KpoIW7m+uod8?=
 =?us-ascii?Q?oYA9+k/VASYZ/xwl735nmmSAm1dDrZJbE5fiZr0aS7SdSsvGfXJ8B2Aiq79C?=
 =?us-ascii?Q?I7Bv4ErJqkl4Uop3zidf6kBG0m0SmudWmsCoimbe2mb4TZ1xFXqs1+2947Gr?=
 =?us-ascii?Q?aponXK29akcBLgiB/HugbSYxJ3IApo2ge1tm9GiS8rgFGe/gs6C5oFjN4oOe?=
 =?us-ascii?Q?Y7KTr3hwFOq00XhoImt5NTbpheaHzgiTIdLTUueIEaKFnyOaz8S5xikJ3O9u?=
 =?us-ascii?Q?D1v/7fiiehCXbwFTqcZvQMlgUVNVfkO5xJOsp7+VGCQtOe45hw+c1sXm/faH?=
 =?us-ascii?Q?8d12x9CG0wOaVBBmMNMe3NQYIelTdGiR61WjMtA2qK51qq0LEXfXgS0VCqX+?=
 =?us-ascii?Q?g2v7unRm4Mop4I+6urmWSdpuM9uZgXtmVebGgJgUn2eqXThGAQsS2o7gNoi/?=
 =?us-ascii?Q?+DDAC6p8kbbTx8ObmwojIJfCZ45zbygT4mla5FKksA413GatGGYtmOSGEAy8?=
 =?us-ascii?Q?GLm2qs9NHMUIfhNxoiMB6UKmmkPQ+UczLuRrchdd8fy+l7g1Ukk7fqpiI2En?=
 =?us-ascii?Q?E1FGD6HzgTIFyOHaZG/uDSrD+jSMRh3nS6ppplKsXoQMsb03Qi6V8LfayHHH?=
 =?us-ascii?Q?ApO8osg4FR2OCDvHUPZRrtnFX8YTUrA9Op/jOlavo/4vpA8jNaYt1lWL3daB?=
 =?us-ascii?Q?PQFnLUi0PYNm5TzrNsFrhjfKngEiyP+MrrBzPowg0Pn2BuA0xHnECSbvEaoR?=
 =?us-ascii?Q?xKOdh/+yGJHQAw3CpCN+zBPtRKic+Brq/vXp5lB2JCmae5SAO8UmMdYPOuQH?=
 =?us-ascii?Q?xZRTMdb2nBs+I1o/s0a4zULfLxYCH83pQIIp65K9K8M/mgaomUrubMzRglYu?=
 =?us-ascii?Q?bV2e8/HGK0wZF09Zi5YDuhIrNsJMUThUs7/TeeGfFINWozzQ8FodadLZKnYq?=
 =?us-ascii?Q?sr1etphHFZUZazoZM5nwOaERJ2fDazyL/7z55cdBekjzMyjEVEdMkC+9c41J?=
 =?us-ascii?Q?T+dsmMHbH4qxm6hKNM1Teea1jq5yHIhANKH3TvHkgiltnljnl0aAeUtG4tt+?=
 =?us-ascii?Q?YQQG5xs9EkjmVAAigH5AupVM6QTgfxUrLEALqCbaFvl7+wd3/0TOSwPuwkuh?=
 =?us-ascii?Q?xEVYDiDaB0R3mSqQInqCzrNpUD9ox6fpvjtjOIG3YxW282OnaqXFT16E/OBK?=
 =?us-ascii?Q?DLkCgTWoNGbmqXbWUqzdzl+mv4nCyd3Z/+LhDCG5B7AbMQvtBjWhxV6DWUXJ?=
 =?us-ascii?Q?3CIeAywyMJpEB9yTKz2pr6dRhGVyU2EE3w/dNCMalP5OHfNoDATuL6tyXu/k?=
 =?us-ascii?Q?sGlTEcsTgP0D0MaktRiQn7qvMGeo3sn4aOrDC2RjNSbpcO3pIG5rwscq4anX?=
 =?us-ascii?Q?40u5ULyIy0p/JmvFsOFykuEZ65oQ7gKoPDCf9yzVC8OAg2M6knOohgLGo8AH?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sTYP7BVKfVbLRha/92clLEAinKgK7nPD7NB9B1GtuNBYAc51qnMXKQEIRe328oG9VNzF28FX+swDuEVZHtovHbJf8xSxUBbfzdNDQfvZWfo3lxQu81te4a6cs+CO7rYGtargd7DsGSCNp5a/3xg64AhcCFsX0955AHzNzdUgs6NXIcHR7YbwMJq046pcRbQyt+vAt6IsoR5/hixDGMPqlAGeqyx5F5dAAIGNk3ukxsY5gkt3/KGYWwGE+oyJn2dYYr82K3xFolU8ykkcYOr5KUsHjyyG/oqIQoytE9lbZrsIdZ23jhflkmvP7GtDLNQ4zU1mxHG/T+d9PlutZkDaDhCA1e2t2mMX5FEeRZUuwMlQc9p+YprfIdwNrZG3iL/veBrqvtkW6mPz3A51xDCuS/2fHMGJynhW4whvfqtzJCN1dIqO8thtC5maLlzfC94iK5LcwArbHZSKslu06LiH8WU2Nfgr4zwbOGjKSlUyN/HO6R1bxFnDF8PenoF/Anji95hsg2JLoPgue6YSMq+j6frmuTTpK+3wJfTh4OhNv6xLOn55hHbNpcBzU/RZrq+y3D4h/Mw5O42yJ1TKrLIs4xx4x694RuCKndjqTvr+EoZl5h7luBAViDNFTZEfXgQmpFvlBKCRwRfVsw4uJDRJl9fNDjpeQBD1V3Fes1+/UKWoVKZCucZcG2Tg9MEYLGW66MjR2WUn/GxiItLrxVtbl1R/3tKWMn/Mz0wL3xvOHwrmNvmD4vB1kaLpfvXwgiEl
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8cd27b-8e97-4df5-36a4-08db7f025dcd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:53:54.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyN1INXogYN2x0NcK+F5Z4EjD1ysY2p+45dwHJMV2Ke7Hn0kR0cFKrt8MaKB/vOGmXhmBNHzuz6B+kjcVG78QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070147
X-Proofpoint-GUID: z_U5zXuD0AfIOsZx30FJurvbvuHUa9tv
X-Proofpoint-ORIG-GUID: z_U5zXuD0AfIOsZx30FJurvbvuHUa9tv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
index fd5890d033c8..ac9e711a994f 100644
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
index 09964f96ca37..13d08cc7eea5 100644
--- a/kernel-shared/volumes.h
+++ b/kernel-shared/volumes.h
@@ -103,6 +103,7 @@ struct btrfs_fs_devices {
 	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
 
 	bool changing_fsid;
+	bool active_metadata_uuid;
 };
 
 struct btrfs_bio_stripe {
diff --git a/tune/main.c b/tune/main.c
index dc72944a2b67..3ca9c5716573 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -444,7 +444,8 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	if (random_fsid || (new_fsid_str && !change_metadata_uuid)) {
-		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID)) {
+		if (btrfs_fs_incompat(root->fs_info, METADATA_UUID) ||
+		    root->fs_info->fs_devices->active_metadata_uuid) {
 			error(
 		"Cannot rewrite fsid while METADATA_UUID flag is active. \n"
 		"Ensure fsid and metadata_uuid match before retrying.");
-- 
2.39.3

