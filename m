Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5DD7B103D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 03:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI1BJ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 21:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BJ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 21:09:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED6BF
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 18:09:54 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL6I2M029442;
        Thu, 28 Sep 2023 01:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=PB3BLbjaYAA8iZ2FbSAc2SKnKJnxIMM9qMc32Kb9qH0=;
 b=WLkOpkclFUpZiWpGXe59DFkvLcH9ZwX13dgHTuadLrf/bNCFZCJ0gBR6jN04oyCFt/LF
 d/oDCYxl0iRCoHn7iDZAurXns0kWWUkiq5zRiswedGukWaS3bzZiEmc0cZl+DjKHbKjr
 i82/bJnfr7dnh6pswW4HFEwTKOcu160xJ/GhJcmFsvXV6EDrHhErx1tksqNXS0m4molJ
 T8EPxyJcAeiOJ7A0JiE5AeAS6aYqaFiWiWdMCVuhhU0AiNhoictLaACabHw3ApiT80f6
 20VYd9/7Pb0wcUcl2TeSvR75d6UipOJn8d11ct+8GH9TKmxU6QQMnIcHWbwfckXuEpEN mA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbjw9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:09:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38S00pwv018004;
        Thu, 28 Sep 2023 01:09:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfet4wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 01:09:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8q21SYWCUTf62fUmp2GC1gaKQbdrHnqkGa1ofr0Yy/5NiwwRxcWdv6+mrW5qUmySwf949hCT2L3+vkq0fg8XCJyXbHJWW6nT2EYXkdKhQ1iiC+JG22x0ohj6Wz26E8whdKBRLqOGiyNqdX82E3jVJ7fJT1m5R0y0VXJQVighyU8TKPqbcKGaLVWUvnsKK+UyqF6Ctt5NAyuTHmloCzL0r4UWekVoPTWdT9EqCUOE3dGz2lHVNYPpgZc8YMWDJAPTSsZQNauKwTn4rGJCjdD5SIUC7gqFg8IHHc5gTjlI/VYPkzD/VK6o5d8TrtKsFOsdkIuf9Q5sLMfGjhEQEMpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PB3BLbjaYAA8iZ2FbSAc2SKnKJnxIMM9qMc32Kb9qH0=;
 b=in6UlieD/LWrx2BMlCO/DNm1V2+HdmTu/aFoIVae/L9HxqPQFogLoHbGDIOigOh6wn63OknvI3ExpTAxCctYKIg5hj+vmv8sJcH108zrtEqEjzShyMiH9hFfDLLxksPTKh+ea5R6Oqi89gFqVS+M98JapdJZNjIneguC/ApoZ4jG/6tPgeX/bPGrdQgDiqaBcaonZ3kky4hW6wZnOQVIxUEi0JLpf2yGi0Sctjs/9JfM8YZ2YKKHLmJgJ6PPBTzoWEnZRHn5/1gMnhNm774hNbW7DsJWW38i3YvBwY8THzkAbSas+exbdeeJGHXGEKe/sgU8i+1gzCU8DaiPUki8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB3BLbjaYAA8iZ2FbSAc2SKnKJnxIMM9qMc32Kb9qH0=;
 b=La7K0fJ6b0aMJPWa93IbOlH03417TMQYIRQ4i2ioQBZUAagAo6ZJ37RXbASry3JJetPzASyfBQmvj3CZTkIZtomXRfRgdYWipSxOjzd2GAWZlvxrcgrtpJ0nneY70vdpW/On1vF7FSR6A5sGBm/Tsl5KT5XdBLu5zK3AbU0kUkE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB4996.namprd10.prod.outlook.com (2603:10b6:208:30c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Thu, 28 Sep
 2023 01:09:40 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 01:09:40 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, gpiccoli@igalia.com
Subject: [PATCH 2/2] btrfs-progs: add mkfs -P option for dev_uuid
Date:   Thu, 28 Sep 2023 09:09:19 +0800
Message-Id: <e1bca34459f2f61fc2cf40a930b930b6f33d69a7.1695861950.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1695861950.git.anand.jain@oracle.com>
References: <cover.1695861950.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: bc119c43-8460-4588-0923-08dbbfbf9726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hoclg6+LSRl8gKIRsOFSNKVhrSQp+wTRhxJ9uf9EzWqt9s4OHmSQ48i1zgZfUt2E8PrX6UJ0Di+P+lLvmhANzI2YsAXKtK4/4QY9lmDF7iDaaoC7bj9BrCjCBXK22nsWsX3DDEiivQVDm0CY46NAlWGFx6NVzUy1wYvyYwObWfIYy3MN1yLOovdXzAlxlR7ZzJrPMmxCUH8JVWkuMNEqRgNIq1GabOxYU+O8zrX8DBBBaNN2TY4Q4uw6KXhVwEH6Z11Pw3SU0O5Heu7MOcfOVh2RlY5nssKygPPb74VTta5e/ecbyfVTITYVENTin1XvEIoC/aId8yEDnk34L9q2iWfDGwYlI1bN87FJ+YbX0i6l56iVoDQbtctRLjnFVsOPGFn47dQoN9/rmm8YbO65dpvSU5Fzx7fiEdLP9GVw5QUAqaWpQ8WbdfDCBCxCCO6n5z1abYSOZsM5MA07i5H2wpwqw83GIGfcXFT/6OlWHN6JFE0NTLu6XGiCnvwTulwj0ngh0Z8wFHOS7xNWDvRy9HwOQny1GpEEQfAo7u8xl0jgbX3E/h2O/mcLcGH6TAa7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6506007)(6486002)(2616005)(83380400001)(478600001)(6512007)(6666004)(26005)(2906002)(44832011)(6916009)(5660300002)(66946007)(66476007)(41300700001)(66556008)(4326008)(316002)(8676002)(8936002)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FI+Sd4HY9FGdR5eMPAQgclDQ8C7+ATfrW1nw3GJsSIAaxK/a0vQI5OLBeB4s?=
 =?us-ascii?Q?xL5QkF9qVLZiIERVLzlxN+LB6JfN2kpiZfoEWNh7HCrEQcdqBZcsZScYi6jo?=
 =?us-ascii?Q?/oq16XtkCqOe8Xaeo82HXhRgJh0oWA8wNzevvahAdIJLlIqUEu0tKb8NVEX5?=
 =?us-ascii?Q?qay0QXct5uvFe8etgySiLZeUleznY64E+a3QhKXoALm81Qzc5eN0ZcBbfJY5?=
 =?us-ascii?Q?id9qtLxoG0EAePBo5l0eCpDyTPXz7Ks+g+w1/fyNmYXSwPpYbnvmivb7wofn?=
 =?us-ascii?Q?uz1rWSwVq+l7F1ZMKUY3851p3lPTupPTRZ/uhEeg1s+ztHrAe09GEsBBZicT?=
 =?us-ascii?Q?JZcuTekTXIDSJ6AYFyzqBLfuirKVMIZmylKBl8qAZqsc67ad4RnWLDJm5E0G?=
 =?us-ascii?Q?Vf/6tVy2ss8/7zZvN5hjjI2AhTy4rnlCJ+Vi77CNiOz1lNzXTjrQgfnQpuAw?=
 =?us-ascii?Q?ZjvrHQJar528zeyyPe/4N/L9Vr2u2j6z0nxJxqOvlod6U58Vqvg8UnEYj6WM?=
 =?us-ascii?Q?bAVI1T+tKaNqVE0TCrxTDEz5yPi/GZIb7ICh7obzw9zbQvn0dml90ZRjaVTI?=
 =?us-ascii?Q?GQH9PSsiq6W+HNF7kAAQfkVX4bpzpLanuiAybTa0S6MktJEcJ45JXGV0yAaV?=
 =?us-ascii?Q?hxSbDKpw0ck2JMZxin33HGZ49sfI6xUIbNaK7Ak2A+xy41tFkZRh2o7t0rsR?=
 =?us-ascii?Q?ojNmdstgfT7JEkhrsK6jhnxDmgOR1+lGYpqdEKLzfOrge1NoSGEZN0jnwSex?=
 =?us-ascii?Q?jmxzmua50mD4+QG5vHdK0LyU21SEzYKOE7B/7IW511MjTJ1aE9Bpbq04HxRb?=
 =?us-ascii?Q?OYOPNCTvnjwneXe5GXJ4q7mNqVNkvSwyQHxo/6FXi6VrN4GhNhgnXTjoA8n0?=
 =?us-ascii?Q?YjMj9/GVdbbtUKA1v9D7Z3AFD/mG5EVlFbOfafwpz+5X0dQdAArkAhzcJaJe?=
 =?us-ascii?Q?cMKkdwgOltS/UfP+vBnt/L5A2yEfM+0t3SCToUX9k5wHJUfoFjVL2pVpJBu8?=
 =?us-ascii?Q?zfP0ZTXS5TgJPbi/XrjgV1JylfNSWrUJIPQnmzrSliRJO8lQL3x60EK80gyb?=
 =?us-ascii?Q?myEYQYgI/f5dTMbP0CV3CgHn6X4gZjU9nr/3ix+ofx/zsN1EJehNoeQiyIRC?=
 =?us-ascii?Q?EkSNXCXfW+/nXa90/R/bvP1kY39Dch7bc8Xy/NgASSJsEPdKA3Ua2JRLzc8J?=
 =?us-ascii?Q?12jrGisUPiiJ5CBdTmW8Mnodt2opsciRGs4YZgN0MjvW15VMhmPV+KC4vdbO?=
 =?us-ascii?Q?QTNgoCyv20XK4hH640Up/w/LBAmMRLN3EFmWBXQUFQe0LCNqIzwhPFKeW3HT?=
 =?us-ascii?Q?IL8mVpNlqWcO7NbWVoqo+CZ/rLf0pFxZiNZe1dFzc47hkTBnTKvX/CzEj17m?=
 =?us-ascii?Q?lYPBZ++HJPJCstOtiCkuox7KFTGiVhAoaKMY819WAMQhq1ugguWOeEhGaYAv?=
 =?us-ascii?Q?Ur5Y6ShJ5PAYrzFvX6jptFgHq+mgtc4PNwr5uZ8rF5x+KpNL5hOB4j7Uo/d7?=
 =?us-ascii?Q?NbxhUioRQdSGd9wVMBa/eem0pTJ/y/InSy8jn88tny+aenoYV9xQkxj+zrnV?=
 =?us-ascii?Q?SN6d4ISzsoysXkHKAJY817fINZ6XKhp0wzg12Ooke4Nz9cRiO767++njvFzN?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 79qo48YTkq3UreDMgEVbUfBN6AiEY4CklfAUVWpnDwzLM3SFWga/8+N3AkUJTfyC+YCKtDBmZ2FlOuF0eCJ8RAx6dhKc915SOPAlr9/xfrqpUmCR43gCVkGrpusA1IBEYQmefcvsOhrn+5ueNV0+jwzQRk+qqjlmT1+ap8RIQcnms1PR5TKCeWuChiccWr93bICt8H2D1rRbUdyKq6MO78w4pe4KiM9bOpl26MeqpzUJ6k3nvbRkrpDuviU0ALEGMeCXrMgiSU7f/yE+NSYvjF614wE8K92S1WtJglvCkVjZ3mYY0zQ+B4yO8wVRxzkKwZwECumw/dTL8xl273j5BaFA+i7c1m2fQjb+y2vWiawlqr/qXls3Jc08byoa+WXFrldKRsNRelxON+yIzKPgEzX2Cd7lmwUNuBtvom2s7XQqFtKBuqtHLi8e+lcSw7FAEVdBvZC5XjuXtlUbBh6nFlwAN46o971alUrmUr93TolpDcDSpEjrR0xiKuuKAP4A7iMuGg8klNQ06GJvcT2hkF/ceO7mnhTXNLYKJXjpDEbl54xf0QSDSUTX4pFMY7FRkv1UfCNe41SgYKPK2FGJ1R+/TJboD45HebpBOp1LWDNjO/weyQTkDYJZDFfNvVl706X+0ds2Fw4Chqpkm9lz1Qd4jHqzuB+VabpX/uah68CLLzKxbHn0pxfeJO9ht0Vp1JY1ADIBhODh02uV4xroeQIoaWeMpUXhQ4PmdAQ8dwF3v1rOOeG+uj38ao025N+iSfqKiRkE+powhhGVVOHXITIpsbEE+/0zrUD1eHVkpkK6xvKXGq05s9baPYX18Ztx
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc119c43-8460-4588-0923-08dbbfbf9726
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 01:09:40.5651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E16Vl6Ka76k6ZQkG7ZLkBXc0zzuyYzcUBBevOHG2yNgUbujHy22JF9hSXD+cRfoZnbiSMgeGCLE0Djy4VLnVBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_17,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309280008
X-Proofpoint-GUID: CkaBEgs3sXYR6cZSqsfZ3vgqv6RHy2AO
X-Proofpoint-ORIG-GUID: CkaBEgs3sXYR6cZSqsfZ3vgqv6RHy2AO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add an option to specify the device uuid for mkfs. This is useful
for creating a filesystem with a specific device uuid. This is
useful for testing.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 mkfs/common.c | 8 +++++++-
 mkfs/common.h | 1 +
 mkfs/main.c   | 9 ++++++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index d400413c7d41..e9a2fd5e4d3e 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -340,6 +340,7 @@ static void mkfs_blocks_remove(enum btrfs_mkfs_block *blocks, int *blocks_nr,
 
 /*
  * @fs_uuid - if NULL, generates a UUID, returns back the new filesystem UUID
+ * @dev_uuid - if NULL, generates a UUID, returns back the new device UUID
  *
  * The superblock signature is not valid, denotes a partially created
  * filesystem, needs to be finalized.
@@ -435,7 +436,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	} else {
 		uuid_parse(cfg->fs_uuid, super.fsid);
 	}
-	uuid_generate(super.dev_item.uuid);
+	if (!*cfg->dev_uuid) {
+		uuid_generate(super.dev_item.uuid);
+		uuid_unparse(super.dev_item.uuid, cfg->dev_uuid);
+	} else {
+		uuid_parse(cfg->dev_uuid, super.dev_item.uuid);
+	}
 	uuid_generate(chunk_tree_uuid);
 
 	for (i = 0; i < blocks_nr; i++) {
diff --git a/mkfs/common.h b/mkfs/common.h
index 06ddc926390f..d512ed853987 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -91,6 +91,7 @@ struct btrfs_mkfs_config {
 	/* Logical addresses of superblock [0] and other tree roots */
 	u64 blocks[MKFS_BLOCK_COUNT + 1];
 	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE];
+	char dev_uuid[BTRFS_UUID_UNPARSED_SIZE];
 	char chunk_uuid[BTRFS_UUID_UNPARSED_SIZE];
 
 	/* Superblock offset after make_btrfs */
diff --git a/mkfs/main.c b/mkfs/main.c
index 68ff5d7785d3..f0ff1d6cc936 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1097,6 +1097,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct btrfs_mkfs_features features = btrfs_mkfs_default_features;
 	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
 	char fs_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
+	char dev_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
 	u32 nodesize = 0;
 	bool nodesize_forced = false;
 	u32 sectorsize = 0;
@@ -1144,6 +1145,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "features", required_argument, NULL, 'O' },
 			{ "runtime-features", required_argument, NULL, 'R' },
 			{ "uuid", required_argument, NULL, 'U' },
+			{ "uuid", required_argument, NULL, 'P' },
 			{ "quiet", 0, NULL, 'q' },
 			{ "verbose", 0, NULL, 'v' },
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
@@ -1154,7 +1156,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:VvMKq",
+		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:R:O:r:U:P:VvMKq",
 				long_options, NULL);
 		if (c < 0)
 			break;
@@ -1262,6 +1264,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				strncpy(fs_uuid, optarg,
 					BTRFS_UUID_UNPARSED_SIZE - 1);
 				break;
+			case 'P':
+				strncpy(dev_uuid, optarg,
+					BTRFS_UUID_UNPARSED_SIZE - 1);
+				break;
 			case 'K':
 				opt_discard = false;
 				break;
@@ -1667,6 +1673,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 	mkfs_cfg.label = label;
 	memcpy(mkfs_cfg.fs_uuid, fs_uuid, sizeof(mkfs_cfg.fs_uuid));
+	memcpy(mkfs_cfg.dev_uuid, dev_uuid, sizeof(mkfs_cfg.dev_uuid));
 	mkfs_cfg.num_bytes = dev_block_count;
 	mkfs_cfg.nodesize = nodesize;
 	mkfs_cfg.sectorsize = sectorsize;
-- 
2.39.3

