Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B027794149
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Sep 2023 18:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbjIFQRH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Sep 2023 12:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjIFQRG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Sep 2023 12:17:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE111995
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Sep 2023 09:17:02 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386FTtdY018924
        for <linux-btrfs@vger.kernel.org>; Wed, 6 Sep 2023 16:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=T++1vZWfd4nK5CogevrCCcDBIHkZv56x/Nykjq/RLZ4=;
 b=zTLXA28FOZP5PbhlowaM916wn7jK1zLfSFPAfVRhQRr5nrXB+TF+55zlSewt0OeOm2Br
 xcWPYL0jR7V6GZ03Zth0rkSoWJ3S6mdCR/2qDswa6hdr4Hhv9+d9CHOFHayZHm7IhQae
 wmJMHVB7sPnsbhTNTYGqRDtkcNEphU9vEN58oz9T9Eau+w2unV569+4zvyjVE3s5hygG
 lfTO9e+Jv3zNkNlfJfmaWMUaSECU476J7CGGaA0ndmFw8/vsRWtxjEA1FnUkJKe5dulG
 IYvjU+VOUo9GnD9Bfappt7K/sw7I106wb+yKpmVQx+AVot+FNls+EUTCxfyE85lFgdNG 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxv43r5nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Sep 2023 16:17:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 386G2ICc028173
        for <linux-btrfs@vger.kernel.org>; Wed, 6 Sep 2023 16:17:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug6fvgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Sep 2023 16:17:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETz+B9jOw7MlEL9ebGXdsJKYGP2pp7GIy/bVUU8oRJI6rGguCgDk4UHjlln8LuYFiHZcXjDGcxsTlwpKF9yL1ijp0t5pzntSq/smwgLQigx0fwbTolePc24+8PdcSNmSY8MnS29ws8l1QLEoGXDjxnvu9QMEqvMR6dTP8yhphuOev7GvyMWs1FcMsdSCxHAveZPOBRAgBnvoyLm3FhB2mvdv45A7Gi5uZ4SR9BU/eAH5jj14yebROrTqPiUehg9z3jnp0xyIWwB27Mpn2pLjV0qJ6OoFXqyMP4xjrE6TsZtNphT+WjJfBp/3ZNwVNFb8NAvoGKpysBuPlPcpLnkiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T++1vZWfd4nK5CogevrCCcDBIHkZv56x/Nykjq/RLZ4=;
 b=d2R/l9nbgvLUQHB5t+tad0E3k9qclaxXHCwLoMB975R16tDF9wejJbUCvRCWx/vfzvvzBrWPQ/k7Gnk6O/sqlLqpRxWkJQQlBC8CeMcKf7GZZm3vB5PGwjsncUJ/jH+UkybiTmj/A1onQObH2W/M7EevkFAL0Q9MBBVINmJ5SAliLxO9ttoSlxflwLKv8HJRNKVZJwexA6906N9TOhr+c4u+7R18AX6l0TivVmDaT5Q9avxOY3NXqN/XkbG+q0OWtfMkxiRJI+Te5Ke7WbbwGJBp/JfuvjjDvu7svYn7hrNZXzwpvbjf0CRzZ73442WErgWgLQ9gXwT2a+u8cOUl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T++1vZWfd4nK5CogevrCCcDBIHkZv56x/Nykjq/RLZ4=;
 b=Xt1qy5sFM1r7JnL3uC90V9oPnnlIQUwgTW/O0GGQ1DiFEFOfsDZJcjEaBRaBu8+RYlEYfurHZGazlpsU/q8A7ljC3VmScKCK0NhBF69nDSQKyCrUWnOm/BgpKoGvphfeWfAHuhPuJkdvPFVmzw6xkpuPQkJs8lBZDyNKPOem/9s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB5697.namprd10.prod.outlook.com (2603:10b6:510:130::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 16:16:58 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:16:58 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: comment about fsid and metadata_uuid relationship
Date:   Thu,  7 Sep 2023 00:16:41 +0800
Message-Id: <0b71460e3a52cf77cd0f7d533e28d2502e285c11.1693820430.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB5697:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0e8ddf-39d8-44e5-b879-08dbaef4b1b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++B5mjv+d3Uih67iB6BBeVTWbHZrNijuE3JJT+kwaviCwFkyy/LI8IhqnTIx72hkMLnEL7MZU6OJyVf7aY6DtfDYEBn0I+llVCJ54XzIZur/fjt/HCdKt00nRYmfgbNXSdLjwxdleUvweqok5BZWa328VUFnEFTgFYytrYqiurHOAhZbE/0PRykI3TRu+HYME4Rv6gT59tr7QC3xkrVGbdAy5wQ1fwogcbWARnkkxcB/4pikxJlDW8Rqso99kuvsHreCSPFOWr/EECqF1XVOl1+C+JnEL5eXAav5wJnP63RMjupWyjhI7Hz6NhC8yF78Hm+JcuxHCx9/StsSIYPDWfu0Okhk+/zfzZuexXNlsPXSto3SNc4/nO/ZDX8XwJPtjHEq2RmfSuqRaUH998BQAEHzjme1inpf2e1o1qnt/r2IXfRVpvoihPfskncVqKs8OhvjTUV0tHqMt2DRU37bbV+9wQARDM3gmTnkUgy37Zgn8Mrg5ATylQ0X4Q0s0OPKhdxWCes2NG6MkOelEugsESjZBPhtraE53Wo7flOBcQe9PxPpoLtM46ouWnsi6wSB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(186009)(451199024)(1800799009)(4744005)(2906002)(38100700002)(36756003)(86362001)(6512007)(6506007)(6486002)(66556008)(66476007)(316002)(4326008)(66946007)(8676002)(107886003)(2616005)(8936002)(41300700001)(6916009)(6666004)(478600001)(44832011)(83380400001)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1MUjLf0MgQHj4FZVrY72iKqyMdFPMCMGNZB8c2S1kPQZlTC33pek68wu+Vzq?=
 =?us-ascii?Q?7mqhVY0DiPvRKxuOM7m0HF0QDoNTEfSTsvBeuFSuYfU4A26Y2/JnBOPyYXAG?=
 =?us-ascii?Q?CRolhnl3cUGdQtM3ROrZ5n0FxDUewui4YEtov6TTsd/BaLsc/ULdFZRyXI94?=
 =?us-ascii?Q?uHz9b4YFSJ5RMP5yRPjR585d2DTg+hW75qsDrREV8swahKAH0RbH4ABytIBM?=
 =?us-ascii?Q?5P38CvsSyi09eMvVRwr5YF0L7acbJp8Yzz3BCi7FBvQ1GPa+QvxPiDDev9S2?=
 =?us-ascii?Q?1E7+WdnoDepzCXzVO58g9GpIBvfNoahsd8Pt+E/XWBdFOdXDU9cvskNVai8n?=
 =?us-ascii?Q?dXnER80QSBqSnsWCjpCgaepfP8lVmTXM2aWuzGrE6cWN7a0MVA+0cfAUwDjK?=
 =?us-ascii?Q?X/K1lwxYP3tPvZ/PO2FrNurH8Q3qCgvrtq5z2SkEeABn1joznHjnaXXYZ4so?=
 =?us-ascii?Q?RpNrZ1IgoY0yzIx+leINVG9+19xTXQ0hQuyI77zUyx6ZyTZ69DoY2PilrBQ2?=
 =?us-ascii?Q?lpN1v8FH7BPm9NLcn2s+Qm4E1mwNoYaOWP/AdysqDncxec4NhDuMT1Mq0LZz?=
 =?us-ascii?Q?KBXKnp22ijTYk2bqeQjO/loonxxXv3WgpKrsu7y8I/hbqEGtaVnL8hX93KMD?=
 =?us-ascii?Q?NnP2VuXtiCX/PqFPLywLu7IBzfbPOcO6s4HYKXXwslSERgHIDbMwJt2hbMAW?=
 =?us-ascii?Q?1HbVY8YTMquQAr0IEK00KdYlJOUiWvxDvrXAq3wWyayJnqNb9PDtGLA4r65a?=
 =?us-ascii?Q?5nKf1f85t95a50iULEFkxemnkjI7YLF0K39oXJ4kau58S8I/RYfQEwiqGGPe?=
 =?us-ascii?Q?0razbVkTTINFaPJi6Cwb6F0zEmZ2+/5ZzKkFwKI1/1IlVDomZd1uyjlZz+AA?=
 =?us-ascii?Q?/wiCeQpn9+D3hAt/2ixU8Gg3d3bMEXbSU///JrEQUnTP8qoZ/dGoMAdG57M7?=
 =?us-ascii?Q?a8w6+oDecq2l7TOjS1InF/gheP7M71FK1rA1BaIdMsN5RulEmCYmgF7zw8aC?=
 =?us-ascii?Q?B4ezq9+/wWqwR5OJStIryTbXhMXAfNAkDuY2ffaheprQTDeK/H1sgeI1s70t?=
 =?us-ascii?Q?+3Xv/ZkptfQxpF8F/QI9uLGKrZ86eltfH79xsLEERWmTMm8Ja1gE0QntqGF4?=
 =?us-ascii?Q?zTJJ+8Rep9hcQbWAtdJcaE/IyIcmh6Uo/5Y2oN7QGTaI8zLSFkck7WbOTD05?=
 =?us-ascii?Q?Kfxnixfs5vhPaW2itY2cxpTaChttA/IKxaL96jTw5hXJN12AFgcmF+wZKQhZ?=
 =?us-ascii?Q?6Z2Zgn0QHI1Jf5rIK+Z6g7h5T3GrtT9cG9IJ5E4EDBj0RYPvwdbzszgDuqIU?=
 =?us-ascii?Q?VeLOLmpmDlGDPzqkayps5g3ZA173vmRW5sT5+uW6oPPkt+x1Bc/4ABY236TB?=
 =?us-ascii?Q?pZh9cNnIEWtYc1yxoCFCtHEcwT7Bq6gB2bZjDXUbUyRsHUHIjYtJvWOR1JeE?=
 =?us-ascii?Q?8ovjiTyS/xCgDH71YsPWSSBaXsLHGk0p+D3W5eHZWtSe7uxnDzj4AyIOnbWp?=
 =?us-ascii?Q?7c2IsYYEnNgyYdLOUNARr5WbivNIpZwbzg2yYND/5hevXYb3XgK19zOrnz0W?=
 =?us-ascii?Q?YuUVH2EK2O0OBtKhEXCZTrE2bAh5Evqj5ORL/9eiNRHG9ZV1jui1f4fG1cwC?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yIyfX3kD1//nrEa3mnj6FimHrJQJIp3h1BXsOaprRgW/U/eVzvfgQtGB/0P1mlOeFa4O9abzqb8gO6H7r2AuncnmLTBzoaS78B5Igz3b+y1bdQzDqblBxBPNjVEHeKNfX+rpJp+hpDwPkSKfYpSgLiq+WoFeZxLDHX5Uef16/gr6G+lQOHohPjQNl/xDI7/R1BtanV1qpu+K9C7Jm5A5+rOYnfSkWrx6arPVX48E2vo4RdStvole72+UrW9m/JEXje+8jb2hbBuvyGTXiSkk62/gsNn30k8Gk8ijJHwp0ZJ4KhDyWnHbHn4/yVdAp/T+7onczAiZ0CrUfDsxma/J2dJC99R25G/2aDy/v01a2Df4dQWBdKcLJWw4v9chtgvbBhOVbOdxwBzpjqMOgWpF2zXKaNFvJXxR/PoHMpaP5N6l3Rs++kB4VoLTCKl/pdsbGVm21i0Hf+9oCUAeoT0Y7OlRYyjPiO9YnXbb08F/JVPBXMxrAsbrtRpV9xn+gnaHPDppjCe/jK9SxOQ5WwgHTyw0Ws7mKiPAsv14R2Y7qHSbnTAnLWrImAxdNe579DbeXGWVoBH14sTeN35To0PwxSX6GNwnYMRHBNOytMGERSBp4DuXqPOUwfVJbXvdm2FWAb9lZ+mLsBFLzPtdjjNq/6a+gijQzUdQAML2gi2qsma4RIdWMMpEwa3Pw4ESitv/NeG2QA0/u9aOJkEdBDExTvdCUkmSeizXCaKLhUf2vPrgWpHsC1MxQpgoCubo6QAI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0e8ddf-39d8-44e5-b879-08dbaef4b1b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:16:58.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jTjalx6Z3ecW/YfbYDv84Syn9oXNmkjfJ887mlzhUtV3kkIVFdmNRHXS+K1FOcflF3QSyu9pJSCA0JE0cNL0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060141
X-Proofpoint-GUID: e15K2vlxKPnLBWaN8qG4WW-XJadoFg4F
X-Proofpoint-ORIG-GUID: e15K2vlxKPnLBWaN8qG4WW-XJadoFg4F
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a comment explaining the relationship between fsid and metadata_uuid
in the on-disk superblock and the in-memory struct btrfs_fs_devices.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 2128a032c3b7..576bfcb5b764 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -290,6 +290,15 @@ struct btrfs_fs_devices {
 	 * - Following shall be true at all times:
 	 *   - metadata_uuid == btrfs_header::fsid
 	 *   - metadata_uuid == btrfs_dev_item::fsid
+	 *
+	 * - Relations between fsid and metadata_uuid in sb and fs_devices:
+	 *   - Normal:
+	 *       fs_devices->fsid == fs_devices->metadata_uuid == sb->fsid
+	 *       sb->metadata_uuid == 0
+	 *
+	 *   - When the BTRFS_FEATURE_INCOMPAT_METADATA_UUID flag is set:
+	 *       fs_devices->fsid == sb->fsid
+	 *       fs_devices->metadata_uuid == sb->metadata_uuid
 	 */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 
-- 
2.39.2

