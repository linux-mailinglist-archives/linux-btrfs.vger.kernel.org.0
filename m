Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281FE77BD0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Aug 2023 17:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbjHNPaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Aug 2023 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbjHNP37 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Aug 2023 11:29:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D094110D0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 08:29:57 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiUmE017544
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=3X4kVVRFRlrCshuo5UOVeuHXZoihQi5k7EjEcbS6AnI=;
 b=UUEVayLdaK6kAVSw4Cs+Ze+RKd64Qcm8S5ZUG/y3RUm3RqElCNiW1eJ1J9+kuvBu9hGd
 6jOWxnWJSzWNggKIaLHQtV+S4pjTzScuUPp2+QZdVzctXRuFjN7NIXAuLmHRSCvfWTfs
 Af5VGM8gx3hIOtZ0DP3eGrlNnn9LjLELQuutXaFvnimUfrX60PsIsXGR3cPzrVkB4xn8
 awL/i8+DpmZN68F4fYhSePep5JKkznljRR0blwIoKETTUjRvgUBsKIE6icdO+1tbt0EV
 e5i5U7j3tKqjPAmGSxfKA+fO1dF8mjM++NwQvvi7GH8xnI4Lj+9PtX2dFBRlqVmTh+iT SA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c2sfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EFAUBa005498
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2c1tm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Aug 2023 15:29:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQIDYHK5ph5Oz6CBxk/seVslvUuLrCnOxTspE5gQD8j9Pb8bToE934BIF9uuScl04blFZMUKv+O3ipgMvfrR34jjFOPFr8p7AW2lKQrt6qdxST4TbAqbW9myyWyhL4Vunx0e3YJTsrfkXxpHzXzbzAzS4AT/zh0R3cvl794FbEmW2KDF2MRDdcvbCfAQPaj1aRvpijEVXTewXPMNa2k5ppsqAk022fUANNk3jkQp2gB2B1Il8yyLU1hfioX/I4o3Lv/V6LdC09A44V+yqno9pavJRdnJ1QwotptnjuxE5oMeRjsyRGGn9pRl0mMqrhfmG7BkWiGMOtHIXWtyO0ye/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3X4kVVRFRlrCshuo5UOVeuHXZoihQi5k7EjEcbS6AnI=;
 b=gZvkhVjnAgZTb5uDsoiIC3XnWVGJ96NZ9ApkDodLMA9xyZHFCMCRE1bT68nuXJ/bVO3o8WULa8WeeLltjY4nd9Pf4G9tnS76w25R2kP4qhLupKchp3yJ45K7p7M92uNaZ11k0L9RZiE4waSAzX2i0VWYkff/4BlGg5kpYzv2sEB3keQDQWsxekzoEOwSYb085FDooxbYAiduSJAowz5+m8cstCAfdZAnuGp1eEZEScmaNEGjfNIScw1CpZDQJBvAS0kyWgtwax+dy6b+NEbNxhIgiNxmlJYH8NlJb8Fz59JplJOHsPYcKWunexd8ZLBs+eqU85dFQ9+YSX0h7usx7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3X4kVVRFRlrCshuo5UOVeuHXZoihQi5k7EjEcbS6AnI=;
 b=haRulPdidwNpIROOu8QYI8rQYyfTx61pZPniZeLOnHQqum01qF3275TbyS1thzWsHCDjNqyN/R8KXoNbW2iT2PhHNsFSLRAqUivUDoEJiusvfXRKtm0u4pLTMmYEK8j05C0klt+8Kiq85zInSqwQz+AQ8Gs7MhOI9ULmz6ywKI4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 15:29:54 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 15:29:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/16] btrfs-progs: tune use the latest bdev in fs_devices for super_copy
Date:   Mon, 14 Aug 2023 23:28:09 +0800
Message-Id: <909e4475e288ce2a559d4cd7bf5a9d84206c3f36.1692018849.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1692018849.git.anand.jain@oracle.com>
References: <cover.1692018849.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7053c7-ef2c-4cd3-cabb-08db9cdb4eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KwFaLc0Hy32lxJ7SzxEMKxBgCljETIjWu1METBq9qOkLqf53rh39+gG5yUu8CJj1631qsIAQwGyv7p4WP98gaZAl09iQwrpHwkuF0jy0ZLtX7UlCjciP83ArH3R3t8sXN7cLs+gRU3Yut41pQo0PQ3grq1OXMQFWfp8ocs9Jz4y40RG8/29ZhzGjGCTQ7tIK+3E1y2S7evZ9vYSrcxKQisX8bTonbBc4+6vUPQxPkL3dYhVQzHuCVcxS16oh6zrvj77zfo1yL6x2DQ24RZThRIXebx5ajh8JBDSa96ANaHNht6/Y6txGWd4EzPQSULBb0c3ZzbX8DOUcyRQ4YR7RTPFB58VcgB/gZg313ruY9PSb99eNMiGQ3Q/181lmNVKWr85njetF8zEbMJKy7k7eff1ICJKZlDhhoIHJ8W6RecBi4yB+NFekrkSHWUdXrjSJEpHyuL+qlFJhI3GhfvEe/FkhRMosF92SOV0CG+gY3vxKj3MwhKHT/U4QfQcnuOuj7x0o1KVv7G6K4ppgNcz791MUTdRKriw+rwOZrJWW+T7sXlmhQRX5aCa9AFAfEvY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(186006)(451199021)(1800799006)(8936002)(6512007)(86362001)(478600001)(6506007)(6486002)(316002)(8676002)(66946007)(41300700001)(66556008)(6666004)(66476007)(6916009)(5660300002)(44832011)(26005)(2616005)(36756003)(4744005)(83380400001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q0slAULS0GPprdhl2Evv/4ElXBTbYQyO3YxH866lwpxg3rFZ5E6N7jzohBGJ?=
 =?us-ascii?Q?CCigVBKjS7DlJKQR9DQCrtwcOUUyFyDK9MaIH85NiSvnGsoIY3Vtfw8gmAkX?=
 =?us-ascii?Q?3GALfoMRjVD5jOXyI+/SrMkfTIXQLCkqtckJJ4Zr43NhBZ33ABMuKpagU/mE?=
 =?us-ascii?Q?rAmW3m+oSlkmUnYqx1N4W2jKUhbtK7aSHmkRdmknBfd8W3e4gfiyVi8fNx2o?=
 =?us-ascii?Q?iNk9Ni9cPanNd+1oGfK60JDCsMYiamFaPfDswjKJvyCWFD7HpQvIeuuA8GS1?=
 =?us-ascii?Q?9D6H7lFlQcc1yO6GXfa9CYnTaAOHEjNc6blm7yoe3SvX0F3nDo58bRVebNm+?=
 =?us-ascii?Q?DVSSI8sYsQh65NraVRU4FN3pxyYZ7fekrJNt5bOdMDIZfiUZFHTgxUsuoRMC?=
 =?us-ascii?Q?KmRhlTusm6yf+6e2L5qSH92W+KK2Ne5TerzPfOe4R6LXGskM4PtjtGt2TaWc?=
 =?us-ascii?Q?o2eO0B8Y6vVCO1ai0oSMHGIu0FtR6fMttXI7+L7lymYyzrlWTlyvQeLtNNa1?=
 =?us-ascii?Q?XarOmJ/SYICyDOn4ghpgbAqVf2D0cNeuZNI5F0cZdIu4p/PokuhNF2xG6tOi?=
 =?us-ascii?Q?p8XXkHD0+oobLQqwb5qqOsCfDZhV7adOCEJH44zVDCaUQdUcRPCpFprjrOSY?=
 =?us-ascii?Q?ACgoxZ8flKgsHJJK4YC5mtk7NH5fKNWQAdPmYjxoJYlxTAWjk+IOK3Ot4tSh?=
 =?us-ascii?Q?WWkwRG7W6f9NTVUCuRD/FjnYHIDKJs8b7DwmaO2WTEZaLwOEdqyxe7R2gst4?=
 =?us-ascii?Q?bpwO8jZ2TsMihLyBolqUzBkYY8ZD6yGneEsUklVpgScoINy3KJZa3j+I5I0O?=
 =?us-ascii?Q?Z5q+MazhfjCnAiZnb+ihUMBlc0+LvKXudYoX/PQF1Hj7CrwDEokmMk9AqCuV?=
 =?us-ascii?Q?sfdN0eJDYIAsA2So2xxctHznO1YGU/9YsFTaCxNGYZdlbR5CaP1Sda7QefsR?=
 =?us-ascii?Q?bvL3JQlbU9UwaBs6wBnywkdEc5eb0hQBaTGONXKOSk4ykc8Pdr+K60xgN8T3?=
 =?us-ascii?Q?MYIVAFPLDJFqSdh40JrjGJx5rQdGvT2eKJSIrcXnCDYw72CHT6fDT75Rw1hw?=
 =?us-ascii?Q?cNG3MFc8PknBKDW6vYlpNp+jekMIO6bqBjjzApYcvHl5lX5CftdO3qsMI5wt?=
 =?us-ascii?Q?JZx/T/elcwYBuuCtSmWFXkn3Zdlat7I8jbCNNphxKufjDsno/TVIjOmGqdD0?=
 =?us-ascii?Q?w2cWhqqtqogjbK+HXCz/Pb0nsgUuc3WHTGnM/ZjHYlaXVAkN8kIcRz8+4DLr?=
 =?us-ascii?Q?XiaT7iT+2fgkWzkLaCBwVEdbRquuf8m+4GLiz2h747YcP/MNNDs7XF1SNhf9?=
 =?us-ascii?Q?kiNNwRf4jnPJiW+yKQdiiFNVUOTSkuLO47WO1Iuy+hyGZL8Z3Le+/OVrGKcC?=
 =?us-ascii?Q?WCD1O7gmoYrv4umu7oC89lSkbzTqQKl4DHYop1cmHpq8YTH6rzAW8raQVmTO?=
 =?us-ascii?Q?pRsYyHQun9irNQMlROP6CUWefEbhekoOj+cWe2RvDfGTY4fLPJaMCtg1ozsK?=
 =?us-ascii?Q?iuxwzHcCM4xFyy6MQcSXB49gpNfHaY54BzJ/UN96RB8X8MoQKUNH1WeMysdS?=
 =?us-ascii?Q?xQr5zvZQCRapGm+z7SBUzUDpPB7jlElAEcgxlBTe/gcH+OV8VLdIierU09y1?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qfKYKbzsAWIxG7DxUvXVqVQ0OPIyAdFlXyZGqlrE/0gB7PVDnTrIDDJ2U3PDjB72A9xeaEY8Gcr01W+INGuPJMLN68sh86KdtXot2QJiH6F9POVBwzGA6mehegDR0t6nlhp+aD6jp+dHtamBCBM2XhG6SRLWZKagualnmkQUaKrxEpGsHR8YHVZ0OWx2OJawo0zL44llJ6xr/ofI625whTuvbUcFTPjDVe9zuuhY7eiwWotOhaDPa80WbSvI44+UOr7S7k//lVfa9mUPdaHxGFZd5UowGOeFdedf5/EJ94d7L05V129DGK6XqkQ0f/2N6XXxSmIzfJPEjoFhqhTciWQ7IaUxo6uklugqQwWVA01GypQMaVF2QdDrg9FJcwTnFPneporW3nb1iAxkfBGSVminoefym3JIDpISUPBJMuINwkKc+ZaU4iFybmI68U9xFJ3kZM/8BCu3ZUOk8HbaEW+wuqJhUTIMBKeMjdaNY5anCJyX9v+KSBo3XDZWtzWqmq030x5qvgHhxS3YhzHBq6GJoCF33241/CudLliEkPUvHAO5pkUonnU+od3kML7WAkYBAthKF9sCbEmdG/887GyjZ8D8IRJw824RsqnW1tNNTbblj+dbG+iLncEc+y0lIyQ1X6PxLK5oRW15mdQgUj5gBkVJ+nJ5S4tTHORs8QCmNKuF9gjLYg2TX9Cg21v6wpOxZE6zGFXGlKHKrdNorO8y74bNtE86xio+LxzGMGkUQZWU+woTxsCMsQDSULFxV0SqLfi91tzqLJQ1h823yw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7053c7-ef2c-4cd3-cabb-08db9cdb4eec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:29:54.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCtuj1p+a6haXMwhquOyGEvo5wPVYDxDix395jaY0ZSVfEXrnvuBdTMqTd0YsY32c036AJHg/8LesMtlSR4RYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_12,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=914 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140144
X-Proofpoint-GUID: 51ZkpmXZkA7RNb1SI54N3vDGAhhIOtAX
X-Proofpoint-ORIG-GUID: 51ZkpmXZkA7RNb1SI54N3vDGAhhIOtAX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfstune relies on the superblock of the device specified in the
btrfstune argument for fs_info::super_copy. Instead, should use
fs_devices::latest_bdev.

To support for reuniting devices following past failures of
btrfstune -m|M|u|U as in the following patch, use
fs_devices::latest_bdev.

 btrfs-progs: add support to fix superblock with CHANGING_FSID_V2 flag
 btrfs-progs: recover from the failed btrfstune -m|M

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tune/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tune/main.c b/tune/main.c
index e3b199c10dad..e47047450b24 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -290,6 +290,9 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 		goto free_out;
 	}
 
+	if (change_metadata_uuid || random_fsid || new_fsid_str)
+		ctree_flags |= OPEN_CTREE_USE_LATEST_BDEV;
+
 	root = open_ctree_fd(fd, device, 0, ctree_flags);
 
 	if (!root) {
-- 
2.39.3

