Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF8972E011
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 12:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbjFMKsh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 06:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238417AbjFMKsg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 06:48:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C11AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 03:48:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D65iNw030504
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=PhXKyqk/JFEDBfM6pbecuTvuacX+ONObJZ9Juljgp30=;
 b=Jdd7I1oAI8+ADu/9BpRzlMLgWE3IXbXUKptYArvCVO5oLgsbuuTacNnjIa+mgafHOVZk
 G1bks4NMdOjbSLM5TPHVBW4L1zgzeGHYFwBvOEL68690kED4YHWKdjcARJrU4wDl0UgB
 aUeAjwViZMm1ALHGBHeVCZ5g3QMVFfS5lbGuqG7zZoPA5rwIl9fyi7oShHyHfiLKE8Fl
 Lkb9z/ScUjnlpvsCIgcLxMsevAyC/PQa6OPt+9BZ2uGO46tZAKEal8zd/XoEMbvjfgTs
 DcYAHnNjtdXfKqFdTxKooy1tGqEmNmG1s65ulRhhuURZl+oJQbQk8VB+jcdrImsb56QY qA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1w0pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:48:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35D915Vj021642
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:48:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm40fqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 10:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhiqZlgZeOXIoAXADEyX2QvIVtFgRjp6DaxyVIAMIBSuilmIwdfyR0AmXVvUTwnLFmN6MSj96ILwyipWPNA8fjfBzHHVkxxp1AGnZL0pFU5Pml1XK0aeFRQhkTkkDxwfvviuBqCPG/DKhbmRN49H8dH0a5Mvz3LpnRWcjglgg8V4ALO3AwWT0R55p61n/5sKQVGMvObffDER6zDEOlcJuhxnXzYbSQQspejS60dOSnkxbudXji1OBHmXqUNA1N+A9jFBeJ6zmngpTOgr+EOU5kWdAcTahznPq4CYlkxiw8lclprBlT1GZtt/D88xx9uvyzN2PkkBytEG6+w+T4iEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhXKyqk/JFEDBfM6pbecuTvuacX+ONObJZ9Juljgp30=;
 b=bxwqZah5nvurXtW8zCOsLpGTbMJ4TR2OY4S5GFn95N6o4+7cH9x1E+x48U2skG3DApKbCFxjf4kxjaoOord8I6jKS+a/wqKXQp4HsJJMpLiBiDNGK/I6Bmsc81/5eth8WOvFa56vA/vVJsKH1Vj7jnMlAN87dbdVRP8mcnT9b1SbWkgN/Vd/tOKHSPaxrrv2ZG8Jhbp5+IruK5bbMXuipT8tgMcHHE6u2wotnFOUDUX0gKCqwnDOY0gl8jz1dTO9naa3+aUigkbiNpF3zEZrJzjpK/dC7fThlce1MtUyQgJa0rH4qE5yNov9pgd5jLzJwUjqF2zMcYcoAYBsL5iFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhXKyqk/JFEDBfM6pbecuTvuacX+ONObJZ9Juljgp30=;
 b=mGfg3cw3TN8yfmn5n6lGOtBNyq3/ybA4qp0HTyenlnTwQn3JiRJW+MXmQMnk5x0O/rsfTVl6gaQL64r3lHEFGkjLRKaftSqX/zrSnmnqjvvAgPQX8+qDesMgMvQ5/parjoPTp0jmQfEenKDtI33ayf68bgeIISg1uqCPQVoK5zI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 10:48:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 10:48:00 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs-progs: docs: update btrfstune --noscan option
Date:   Tue, 13 Jun 2023 18:47:15 +0800
Message-Id: <fe162242f3fdc976c7dd2ecb5beafc884c9a1d0a.1686484243.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686484243.git.anand.jain@oracle.com>
References: <cover.1686484243.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc6a411-880f-4153-513e-08db6bfba7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFhABU7E7z/U8Giig7OnbYGQohrUoExjZa1Cob5FNid4fu/rHFbU056cP2Anw0LqpJPSAX6yyu4RjYNDfD7FMkpc1+O7RrgTfmeXiTZ/yL2rcbMuQh6J92oDMYDrkl9HROx+bRQ/+WLgSatcOBytzaINnxLhFD5EWTHcw9BOqUm3FwUnUeyCGapVXz0+Vt48D6MEL+bzwcQkXqYWOsM3wjZn9FwQdXnAe9LeinyCFaQ/aOHrTSpPLiKxoiR9J3LxPVwVG96dckXfV2YiQ0dqlteNzhe2RtIfoWhnMwnVFNeBXfDGbkpsE+H1vAuqQOYyREKvLzvC66Hw2bREvdrH6lV5e/f5aDbLiuK5dvBlE5jrKnsp4t1d8hi0t4kmL9WDTJyV+EhpRXPkHpzHiO+M6ocJE+DoYCL3W+aDxrvpDO0VvikLXDxIUic4H03xkpx/VuHdVgQ6OLSwMiVNvdjasxNxOK5lnFFNS431g17ffycNS449yK9462swq4DNkEtPjNQCARQuIHOwqzARxDlvln1kIvNyMf1J/iFXX4NrbZD7SU9xQhg98DNEAd0rhlWm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(86362001)(4744005)(2906002)(15650500001)(2616005)(83380400001)(26005)(186003)(6506007)(6512007)(478600001)(38100700002)(6486002)(6666004)(41300700001)(8676002)(5660300002)(8936002)(66946007)(66476007)(66556008)(36756003)(316002)(6916009)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F4sDGUL4qNfS9Rao+oiYd7z00Rc1XoZVAldhvsnlVTcuK8HeQ49ouY0lxzu8?=
 =?us-ascii?Q?JXS26s+lxXTfk1YeX4vdo3iQamG6QH9mWLbFFJm2cqXFV83acr5y2k62fYDC?=
 =?us-ascii?Q?KEsKYR2Gc30l3Vjg5p/AWOFAWmlQ1P8TTetCsQGVx9qTjSoEp0mD2q004RrJ?=
 =?us-ascii?Q?9s0/4dbGPPfbJn5/vPdLVQrEMdMToiBEmO4nhwOeF04Wveg3fgcoMqeezy/G?=
 =?us-ascii?Q?B5h9WQze68Zt7ABbGAG5W/bkKSvkeYaFCylGZ3NXTHtIGvpYgzqkQ11CTF1O?=
 =?us-ascii?Q?JzSqKR47J46ly3q+4cpnDjngSE3OuWUGj/+98JtS4wEB01NDIuILYG7T7094?=
 =?us-ascii?Q?6IVLvDXfu3wU+0PE/y/LavOgPtCg5aWY/3BYuOEWL2UAtOi5LFCzhL8gKKDp?=
 =?us-ascii?Q?jNnNs6g3XZPDcmgJiSoB5tndyP0Mntu+uORycElyYCsqFiNbABopu8NvS9o8?=
 =?us-ascii?Q?RcXO5qjgM1Vq7pgLeNn9kKFXSItc7U8EQNGlEuw3M1NAPVRzP7QEfUPc2Sqn?=
 =?us-ascii?Q?iwjSFykFE9NaGmvpy4DEybi03rDHckole8l1iV34AlQWD2MkjyfL8EaFPV4n?=
 =?us-ascii?Q?TWz8XyRGnaZy/rALZ+hH8BBfvyqyyuFi7Ui7m6YqdzUNWtLbOgAansP32VWT?=
 =?us-ascii?Q?81CEljowNYkyxiHPbKuDbNgrqNexHzNYQBDKmoYlS8Nuvz29pql4RzaVA4Ln?=
 =?us-ascii?Q?vvtPImR4K9nrHSOI6iU9adI7NK02Q7cu8QAqYDgiJOkG4g87FIjyFDYeMuve?=
 =?us-ascii?Q?UAf4RPX6upZLcXEWWDtMH7CGvvLJKMOLLseIPrvRKpliG5pX0hDfX8OFXXoE?=
 =?us-ascii?Q?0rN4m1siBxBxjEOE6oNG4eaehUDWyPdNisoWKHgDD0kcnlQ4rHZZrnCiI+PB?=
 =?us-ascii?Q?awkEB/SGQR5NSS7Vi/TKd8mQoCdTFIx4Guc1twatQaHZfUbl3+8hWcXm8O9/?=
 =?us-ascii?Q?dBZ48kfOfmVW1gDao7AmSLBYZ41uq2060dbuP8I93QG+AMoNWNIAcrA+rObF?=
 =?us-ascii?Q?SOurIQj8TTL+/pYKCnUw5epS5RZnW6ggwBrLMjKHvp7rv4eTjUzD22ENFNgu?=
 =?us-ascii?Q?uTY62aG2+ah/0sOhxBpAu++78zGWj1I3DdAblwztVimFg7uEfP4WwLrnjDAi?=
 =?us-ascii?Q?o0UG2c0ayyi2men2GmOzznpTX+sKDeW+V0JVC/JgUnoFhT1xpDS1IPlxyScX?=
 =?us-ascii?Q?Q1noZUBVpvSmsjTJv+Yx0hCy3mIDAyMD5xjm5SdwsC/OzgSI6+tJBsaD0Vxu?=
 =?us-ascii?Q?M6I+CmMMv8L5FkLB4RdBUVkwitJ92bjGNeEeDi2cL0ZDLwMlHTSo7P4ndVn1?=
 =?us-ascii?Q?FhQgR8A0ljDgfXeWgYAka/Quo/t4hFN9Ta4KmzJEVTnPvYSLocK+HDOspyz1?=
 =?us-ascii?Q?qWdMMgEoaoaVicqRbRk6k/FT2oW2CinL3+CNvvHDZ1g7ixNGPbf+1rrLJJcQ?=
 =?us-ascii?Q?iyjSnc0mWJXcVVmlUWAl7N7/5R+H/jtCONjvdpf0kFezYEWgThchaLaO/HpG?=
 =?us-ascii?Q?3Vu43aZcSOLmTiuiI/B06HOoBec6G/Bd7vGQ9Blk7jYzyXLUJHC6U+QdELON?=
 =?us-ascii?Q?uLbw4JSrkSWOVVYXuVwOSqe60cjnClUxcDFw4UUBJ9UBv430J/dvzOTGY0Qt?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2cHIcTtPt1c9CJ/kY+s2LAHqSwFTT47L9xCcjL3DX60eZFglVOdgzaZl8n1oEa2kzBqEBUrB+RdXkTEzVXyItT03/3GO8n9wQfdUgKlGJCnehy1yAdJMt+rKLOQX645yki30sV0Gn0Q/ebVcelt/uivsP8ZKINKrAX2EJiDwQiWzfWZDvpSKvLSpj0y0jPvbTFILW28VIFntvp2YNRS/kunobQzOnxoctxQEjILgN+RDbW1tSooWZSEdXY2UYERa3if+Da9/XNMvLeZjpMjT1efv1CNhHoqgCvja/r2pgy+ybnh5IDb4s8TZOVSbt1wzXztpTxnBWSV08w5+Y6Mbw5dR0fsmAzhr+c4gRXr8UJ/wC+xfqWIfxfQA8h6HAGFdCN7jajr3+ADDGBHaaC5RIsuSET0CIHkRB3En6T8hqcOkYNgvbmamcLzlccOxrRXVA5plLsH2f9CYSSizBEheGPoJjFt3suIGQ1oiVJIwATkjGrssAoYURuvBiRy88zVxgqSL19IycFoCAKHxxRY09mHCjbH/mzcKSZbH901hNWajH9LE4p9AEjiL5vk6ZOYEclT3FIfMvXnFZANu+1erx3vKlo8Jt4uze9jPiMMT7oP1IBjpmmnWgOq2mWNKccj87XT7Qc52dMG59+fClEWr9xNlaILbloxiGOTeyywdJF12n5g7kMWlTw7GOZJo5+TmXATtXQLEjixrHbT3CDidCiILvIMINg236FS8ZXmiUlDvZavf4mP4J8QJSQEB5j2Bfg4gGnMeymEtWJl4shUW0g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc6a411-880f-4153-513e-08db6bfba7e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:48:00.1357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8jIAeuOSsGOycaixrpN4isZ/YlSDZYIB5PjYIfAJER6nQhcTGd/z6GOsHVUSMDpXIrsBKMclL2AnbL3y4xtgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130096
X-Proofpoint-GUID: xOysMe_UzkpCgHzzNR6nUzbxcHuNwLYp
X-Proofpoint-ORIG-GUID: xOysMe_UzkpCgHzzNR6nUzbxcHuNwLYp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update the Documentation/btrsftune.rst to carry the new --noscan
option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/btrfstune.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/btrfstune.rst b/Documentation/btrfstune.rst
index 89f4494bbaf0..46793b3d4a77 100644
--- a/Documentation/btrfstune.rst
+++ b/Documentation/btrfstune.rst
@@ -49,6 +49,10 @@ OPTIONS
 --device
         List of block devices or regular files that are part of the filesystem.
 
+--noscan
+        Do not automatically scan the system for other devices from the same
+        filesystem, only use the devices provided as the arguments.
+
 -m
         (since kernel: 5.0)
 
-- 
2.38.1

