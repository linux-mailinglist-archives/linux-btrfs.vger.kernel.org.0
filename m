Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF506B8A03
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 06:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCNFB4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 01:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjCNFBy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 01:01:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC39173006
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 22:01:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DNseeq003293
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 05:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=hVAObZbpsJ5KT9dJWPQ9FJ1D8o60t1YzQmOqM+N9SS4=;
 b=VPa4iTPXXT7eJgkJwRK983JBCfjhaBuijs8sRM+qvBG3iffBSgwFqvlhDVLGMIkIp73X
 E9C2/UxcUwRBKYDXze7/obYZjAvAvL+QTYK5NFrFmnDnJ3FM/6uEsD7PvM40QTPqngF+
 uUuqe+EQC8huiDWz08f/NkvMhRi6jWbril+bH3iQsubfe3wPyQOKi7SR3OE/czzual93
 fcYcpsTocJ+ULIkGpSYNbfFyMlRtg6BVk/lJVtw1Uf1tzchaX91ybDcFysSGS//bJ4Ih
 nEO9q7KNIx1vdPqv5ATWtG5rvvGPMeDXsqG1T+0T4+mtjMnI9MuCg0i9JI6TtT7GfKJ5 4A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8h8tddb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 05:01:31 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32E2AHge025072
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 05:01:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g35kgk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 05:01:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpgycGwCJne1U1QVbp5vByL4EApaMfuXmekjzNfJS2MVZSVDThnGLwn6qRfVFbPz7E8Mqq4wyd2wWdP327AtHgkmdMWmKVxQE8y9LBCE39xboWA1ebAJn9IGRehgs5vrUDsizyxB+TyvoYE74y63Rc6btzdUQXHR7xn79D3+kSJj8wxotI3dZhC32nQolfM7DV5KDIISeUUkefUQKO4zrNBU5+57jJt7x8OpQ76Ha4KF3B7IUw4Y92DFJTMjXK9zWODv//e6zxiqGs5rxkM5cNbJMChbkwhUHpltkRVCw8hEcf0sikcorvCYtkts85OTQq5N7OLIkJejJQeyGPftdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVAObZbpsJ5KT9dJWPQ9FJ1D8o60t1YzQmOqM+N9SS4=;
 b=O3nB0tRJVvFJaJjxtBLgJWTculIsvyxR22zo54HBIEtOGv7nuaKGNq4UbsH8/OIGzUhGu+tsj26qxVpmzl8Yp0q8QuDQ+e2ODhwxoS/Af1XSTjYojs+IG41E2JdCWSB2BG1qbuzjlqzgGABHZ/GoerUhj1uCxDuJOy6J8I4US5Jg7dch1ghhasWXG571VkUu6O4ZTHZqrTd7We/Cp+XzG++bu7J2tJIshKN/A3BNP5EFeXxD++116nUBBGA2kKOWkEjkgfANzbb/lbSZLZD9R+82MEfPOQBtrwH7cWBlhTDMLMQpFBjU2ObMRQUPH4s4p2iYkOxKOAZzdcmxaoKskQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVAObZbpsJ5KT9dJWPQ9FJ1D8o60t1YzQmOqM+N9SS4=;
 b=dKGArV+7t7fczZ51ueGWTWvf92osC+tSxYJ/TxrKtyg4LfnYpFiLRs85yqcRRiBixWvKqwnzBkVzNamfU9nY+3+1u+dX5w9ialLb4hsl844tk8/6Q8lwv7MXEpDUMPNSP/Cspoe1USh1sW7SrPsKKzZWLU7o4j4Obhi7BRYuxVE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6988.namprd10.prod.outlook.com (2603:10b6:510:27d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Tue, 14 Mar
 2023 05:01:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 05:01:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs-progs: documentation for discard tunables and metrics in sysfs
Date:   Tue, 14 Mar 2023 13:00:50 +0800
Message-Id: <4800c5464b3fb4ace327180ffe32c378d6356e13.1678709623.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0239.apcprd06.prod.outlook.com
 (2603:1096:4:ac::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 98200837-5456-456b-cc06-08db244929f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXT4rpKVj/nFwOwCllsjjP2gnc2UKOyOSv5aTzA4ovoQhT0BPcz+2mEaMr5XI8M4MuQV6L7MG0qkYWj+ODnWn4qj93kWaNGdQQDel7Qy3hlN2WlderWeTbV4SxiNFM4Ea+iWA3upNVH/cAdYD1RbxFeQuIhs+uVCcgR2RL5EIPmHrEl6GKmn18OF+GwkN2SiCiIjr1dXj+Akg4xO96z45wJ/Au/B5tI2Am4j+0XBtZDVUfiUjZ/1YpQIgUyP8amycPDICCL4xiWnlDLBk8eni1T1P0z/M/eGtTnKb5zXGq5CmYA3d30AboyBTWhJk4Je5bJkFQa3AEpFwQ+fiL5xYjHTwbVeoNlrp9LhCTEmk3ixhibBsKHfDX6DxQzjxa9e3obO5IWSBL3JcWJn6IKpAL1XHbVAjKImN+kUpkVnUSJX2ykS2Uyw3GFFP9ERwcBpjmM7cniu1gFbPlP0+JLnnOB47l1xN/1Yz0d5oKHnJNOQN/ZvdInXtls06gaY5XNnWUrSXTjQOulOiPpYa/dkaMTqRPHJbbVSskKUAPMT2whW4UTnD/pA7RMFmZBQhCebyJ5k75gr8ZfaOSTWpMaw2oAosdI7HOxgAEOn9I4dkwSvsEdqxJVNs5zFlws8fufPWgZZZU+l5RAtKwB4vdsybg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199018)(2616005)(186003)(26005)(6512007)(6506007)(6486002)(478600001)(83380400001)(316002)(36756003)(2906002)(41300700001)(8676002)(66556008)(86362001)(66476007)(6916009)(4326008)(66946007)(6666004)(44832011)(8936002)(107886003)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gNNctoumIpLl402d3JnFbUK4P+hk3ZDGMZgWMeTG7cJ32BrsPfZdaRf+E1pK?=
 =?us-ascii?Q?Ql/lGEWHgbpLxxHz6Wi8InTjD7dQLFp/DW7T1WCzgIdMEK5ntB8DIkqHKUc7?=
 =?us-ascii?Q?vqE2gPP1iTya0wpXBx6KbElSyM6ZJF8eknfWPXs54Gxq6tJc/VbqBDsPs1X7?=
 =?us-ascii?Q?aNdlV580Y3XI3DhSdo3HNYLO6JXGvacdHBPCEUhAtadmKBGJXnSuk4o0rIiv?=
 =?us-ascii?Q?dZAEBnOTGyd2yWU34hB+6m6gKpdgXVoA4sUh+4TGgSJ0n+3abbQZbLIGsG+q?=
 =?us-ascii?Q?osK9uUKJTPuZRpgyJuUF3Rqb2tD30OV2F3IeXhcOED41m0IH4NmRDqR6V34n?=
 =?us-ascii?Q?+Ap6K6tfOjxPIG748ajkIEhM/sYyY3nneHVmdOVCJTZr5LYV+uQwTjagdq38?=
 =?us-ascii?Q?mp5+Cc/0ZIyXXGvAlYCBbjtoJvjmIy9mpWF77vLSyOxaLQneG2H/JTxO5R1I?=
 =?us-ascii?Q?uZZQkF5GcTa+RuzDeG1FtRJ0TrzfB5gnwNLE9vlLCS4sROcJjRrmfXGzBsZU?=
 =?us-ascii?Q?AvwgV3dliXyyAmMnv8/+C/jRh+TRjcNIbP5yBJavuALcjCQh05WEN/e6ycBB?=
 =?us-ascii?Q?kYpfX0MXi0M3IpqsbSps127ef4+BuEXrB/PLnHsqVIJm/H9BEuPrruSodtXf?=
 =?us-ascii?Q?caEV/1zX7RYpE7nfoWHfuCuvwZmyl2454MTG/2csHaA1/SYkeBDH3p/lj4Fr?=
 =?us-ascii?Q?NNM9erzOUr68FwFvZuF/NeqGns/2EjiCRXeyTUjMUP68sQl3YTKqVs8jJaTy?=
 =?us-ascii?Q?Gm4hFq92/CFO7nOnyoWbrmlP1dvLEjcQaWRb8aKJaOkP4oPzd8DmE8VtH2Ok?=
 =?us-ascii?Q?VCB3v7r+VciMObeNJ6/oCwylw5sST4WFS88dkZY14873ymyVWzfsg3RmbG/r?=
 =?us-ascii?Q?X5xcxXOwZtvZpFi44OV5q9p2r1eCgGVSmdNK046f3W/fSMD6GXqYtLZKuTK7?=
 =?us-ascii?Q?OPqIzlp5nXwLe7XQyjKNQRIt0KtFuhtCflsa944KeEM/REQrZxWHUZLRCXY/?=
 =?us-ascii?Q?5LfyH9eHsS3awaC+NxvbA4NOJ11GYgBwBIO+rZhUCfuNQeaEq+YrQcAzzX4D?=
 =?us-ascii?Q?bJ3GeHZaGiCTkXqTN8FJ9+gISosbyk3x/xXVbY6JoqFM6r43vnstS8SiRLVP?=
 =?us-ascii?Q?VUeYhloYuyuJcJ84H8CJD2kFeRvF30Y/ujTy+tbYXLI64lc98Gp07QXjed5I?=
 =?us-ascii?Q?dLFwAi9SMnN61gHFpjQktld0RNN9tpGHm1bvjV7dWT1nnxzA7fdxD39B0zb6?=
 =?us-ascii?Q?mbj2nv3v58beUSdX/xyd4rQcg/6bt9EW0WwjphrkTtFjbD85cxL8GVODHG1b?=
 =?us-ascii?Q?0ObvoEKS09XdkkTPJ6TlcFPAgyDIjWtq/MS+eAxYNFmZVxBetnqR8mx8AIsj?=
 =?us-ascii?Q?DSwr6fCSbP1a4nUfkwpouqi7zP31Wd9/LzDVRYX2v0pG11AQLi//2Q/bJxk4?=
 =?us-ascii?Q?3BlNdzZqlyBwuaVr7k7Oyrq7AZ/9TKKanj2dWqGzYRpwpBDP/kqhVNQ5WVlY?=
 =?us-ascii?Q?nz+kxZXmNUfxibu8jXdVf523UZrXsEdNcJmWlIht5VIUJz/iCQQu5AdSJhlB?=
 =?us-ascii?Q?HiYWJGWtXPcGyTxAHK5rybhcDHGcFZeVO3d1brxM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UudvOjWvOlAuGvJk1BUtAedh2Z0nVuwXkpzfFpuG8OGXKjMp1r3SlysSslbXpMdvmB7byVzkUMpqXxQgEuJ82Gu0kqzRmPI4s7GJ3KHal6tQegawW7cUOEircrWIRKk1lCUyZAiCEUP7voQ2YzmI8unNQKMxmmpczc8kNFmCahKaVSi5TDfqxb+PwdbWkxAix20F8ChfBYYi/FJqxOkVgtA5yv0UHUNmmrZnA5A2Wm163/Urgd0yRBV5SqD89Kpa3yXq7CUsIcRDVR9QyW3PU31pFNLT7c4N8JEmGo36uwcP+IIYsckTi+bgFS14ANL7Xe2cGZG2XCzjNOde3lAAbjVxVs+p3vgTBQsNoaZXVgRZ58JnD1OByFsNtrznYmithf0/JrfBRVz+7GmA+iefMFFLETzpTQLommP1ClbbMhDSRNykIuz7f544Z/2JBjFWzPw1oGGv1PNymQD8JJLmPRhSnLM70Qk8yag4Brk4YWqwnTOFD0EoXwN/Ml7T4mQzMboSbslXYWMpFsIx8Q1ExO6UFMzAavyv0D0MaGxpqB0DI+g5lVMuUlU3BRz0voLQDasDsUBwJVJPDf5kk2dvllocMW7TPamxLl/ex2DMhAOEl5rUeKY5qIdSy5qcogigEqxbLQW11Uav80zFZ730CYC/IRKnA6JlEeMTg/bI20WljwWdMxjQmKhiLcAgpbC3+5vXeFIwu/lFlSpeIzSbQjuXgar83Un4KkFWrWrckfTFH4+ay9sZ0twk8wVTm00o/AZjeUYS7zokOs6agf7ceQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98200837-5456-456b-cc06-08db244929f0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 05:01:25.9957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2w74I/31VbUYTIZ5nrbnhyEpi8Juv921mt6bj6sDcPRH00X09t5lrW0G9ArSYv1Kv0vypmqJsrn1+A1QNRU58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_13,2023-03-13_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140044
X-Proofpoint-ORIG-GUID: y3YUNhdly7CWuaw66o7IfpxRORMZuc2U
X-Proofpoint-GUID: y3YUNhdly7CWuaw66o7IfpxRORMZuc2U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since kernel v6.1, we have had discard tunables and metrics under sysfs.
This patch adds documentation for them.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/ch-sysfs.rst | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ch-sysfs.rst b/Documentation/ch-sysfs.rst
index b3cd8eec4c5a..055ebd457d0b 100644
--- a/Documentation/ch-sysfs.rst
+++ b/Documentation/ch-sysfs.rst
@@ -13,6 +13,7 @@ features/                      All supported features               3.14+
 <UUID>/devinfo/<DEVID>/        Btrfs specific info for each device  5.6+
 <UUID>/qgroups/                Global qgroup info                   5.9+
 <UUID>/qgroups/<LEVEL>_<ID>/   Info for each qgroup                 5.9+
+<UUID>/discard/                Discard stats and tunables           6.1+
 =============================  ===================================  ========
 
 For `/sys/fs/btrfs/features/` directory, each file means a supported feature
@@ -247,3 +248,41 @@ rsv_meta_prealloc
         (RO, since: 5.9)
 
         Shows the reserved bytes for preallocated metadata.
+
+Files in `/sys/fs/btrfs/<UUID>/discard/` directory are:
+
+discardable_bytes
+        (RO, since: 6.1)
+        Shows amount of bytes that can be discarded in the async discard and
+        nodiscard mode.
+
+discardable_extents
+        (RO, since: 6.1)
+        Shows number of extents to be discarded in the async discard and
+        nodiscard mode.
+
+discard_bitmap_bytes
+        (RO, since: 6.1)
+        Shows amount of discarded bytes from data tracked as bitmaps.
+
+discard_extent_bytes
+        (RO, since: 6.1)
+        Shows amount of discarded extents from data tracked as bitmaps.
+
+discard_bytes_saved
+        (RO, since: 6.1)
+        Shows the amount of bytes that were reallocated without being discarded.
+
+kbps_limit
+        (RW, since: 6.1)
+        Tunable limit of kilobytes per second issued as discard IO in the async
+        discard mode.
+
+iops_limit
+        (RW, since: 6.1)
+        Tunable limit of number of discard IOs to be issued in the async
+        discard mode.
+
+max_discard_size
+        (RW, since: 6.1)
+        Tunable limit for size of one IO discard request.
-- 
2.39.2

