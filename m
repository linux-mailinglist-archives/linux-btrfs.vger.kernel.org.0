Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F28725B34
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbjFGKAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240085AbjFGKAh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:00:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4CE173B
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 03:00:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576Jtkh018042
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=EgqiLk9JFJUD6wCdMkIRGRTWKubUOImJ4OrS4+jF+pc=;
 b=RyQ4OYfsMtlYb4bJ3VR2Kj6ye4AWddwzdcuHZUCJTu2uDrgMhg2at0NFwpGbuC84wARy
 kVBdLeegcIp7DiPoemrFhjuNbztzKGgAnHg0NyzIB/ceNt/9UAjj9vob5a0F7btgMsDZ
 o0y4Le320IMDxXliaZ1aOHg8UAjX9WXaCi/YSVin3xW6BESpnQKwQTMTCvm/SvhuvFgF
 N9DK0VRI2MQkFxAVldUikA8K+1iPsBYEYxP6iuONyBvuK8NMfyWc6OnyTf6pp0IL/HjY
 O3pLR+203DDAZJv0vqcjH9JxwlGeDprYUKqT7nZwTtYp3xkYzAZ8zOv5pqmc0hcT97Xe 3g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u9c9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579efnS003011
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Jun 2023 10:00:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6k1dub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 10:00:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzFEmLXsrxm7aAzbVqSsIkb/V7T5EephEVaKGozgq7q6CIjLyCnRu05Fmca+AkUqgo25ic/H8QODNoCVfZfkB5smfJz8dLRxvOntOJMNYgoPCSJy3nIlxOYzJQp6bIaCEkPlWcvJIz4b99BaExKK/tMqFDNYV4++jJqCCLCn5PqFPfAnqTvyofol2SvXgcR7q637Iuf531TF80B4tR9IcnEGVWBjgjWXLF7UyZmzbTZ9X0f4xZ4ry3v3Ic2b7De3pU3ZjBBKDA2Gw2NWOoJc94/GAiyWG/UYCdmKMRbznO+DjvgOtERntY9i2MmRYib46xOSIlspolrCJzGREU41SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgqiLk9JFJUD6wCdMkIRGRTWKubUOImJ4OrS4+jF+pc=;
 b=A9dqcZlHmRC9XJzvpeMQuz7BgB99I6Xp6+AA8XQyb/XjHBTeIh4f+8Kc5Fawyc4I7E58+smzRkBdq35k8O+0HhF40t0C6EiX5e+5AD9Bwue1ClXWNntoEwPuOOBKA+zyNVm3THDmSSEwSffBfyXi5Xgy/B5LY4Jv9MgG1OTjl5XZ7LJfXMmKAsNDGFFxqvKD/ga+NRM2ge6NPsOfu5ctLdYkXbPXKuXzgAo9rS5bPhQQEVLZ+7Zdwt4PwHbWKDknaxTyoa1Pd4zxGmuv6chXa9Z03WYYcuFrua809AwjU8gR6jvqjEQ6hmLFNpvgFMIj7IHGRDbdFEVefQ5SdGuoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgqiLk9JFJUD6wCdMkIRGRTWKubUOImJ4OrS4+jF+pc=;
 b=K0lP1nyeY31QBlcadpDDo1lYKLpO3QTpjhJtoOzimLvNtv0N4qgrq8gGrzQDCYr6WNYnmxDTeIfUg3ezcCqK7nCazn0kJpVMOH3GGUE+zbjIwdp2JZWKoHui4wW0tJw5kbWa6T/aj6iIDr8BJQRxOskUVHltKcsT+Qx02NumHFw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4762.namprd10.prod.outlook.com (2603:10b6:806:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 10:00:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:00:32 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 08/11] btrfs-progs: refactor check_where_mounted with noscan option
Date:   Wed,  7 Jun 2023 17:59:13 +0800
Message-Id: <610d67e87fa1020c1e6dc5b12bc457912474ce3e.1686131669.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686131669.git.anand.jain@oracle.com>
References: <cover.1686131669.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4762:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb84226-2962-4fc1-84ce-08db673e07c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+txgP/q4cBsgqP7SKBUcJuP+bT0fvgf0B12ydDRC9j/R2DKXguibusXlsMeWpymT3ZV6odfpDG+gmmo7O6Je54yDn6U6LtYkgHZE0P48fLxIOQ3ax+QW8D04xDt90sg6srQgYzPZ3e+3S4CYNc6E7gMdBg9gVAUZh5CUCzX1kKwI0m2APaYh2p2VqkzQ1JeDkinZxzujE8VqtK7+fERci/MkMlnwbhhcs223jTNXhN/wyN0LOSRIfZ6kD9gOxA2lweQfMacmj9TeWWDOLvt4NZn45fTqM4Zqp7IaV0MfeaD7Pm8NR9IwhdjA96JzLToIZbUUQt2nlX6UB8aAndqidDpN5IqwVIJLAaP9GkfILh7yYh6h8bwXE6CGYFK8xTFRJucrIij04molFvqtk/kssugN1wqh2QemP259lgbDgbtOakKUY4CUkWZDWMYxOqzHgrp8jWwdCMoGfo6AGAktm7wdPeKp9orcyyw+SGY1sjnUEc7AeyxJd7kXXSnErVCx9FqZ9Jn6RzGntP47YrjFgJezEzYUUcn5xiseVywglxn9eFzAccRhsuWUaiE0K/k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(38100700002)(41300700001)(6486002)(316002)(6666004)(5660300002)(107886003)(8936002)(8676002)(478600001)(66556008)(66946007)(66476007)(6916009)(4326008)(6506007)(6512007)(26005)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U0DiQvpimB/zJfSCnGecFrKqYlr7YO/USo4roIGf0Juuu8RPiYEIO1+d3Rl/?=
 =?us-ascii?Q?L357o6ZfHj7/hKyRmyGohkvatFosGAGmMevy+etv/q8PlfZLF/HScFRCzMOF?=
 =?us-ascii?Q?U16f/jP2Xnl3jiPPHk6R06t4PZo7m7B1JM2efWkfdOXG9WR2tZGuTEzEh1da?=
 =?us-ascii?Q?72eZ44D/245knA51/ApaVBQh518e+0Bs8j7KQcrwRibepsibCt8tYAz2crJQ?=
 =?us-ascii?Q?qCy5/+H5QJ3fh7j6dpMPkqN7Pz2QrtUllKf6gbRL+gxZ6g6JieBVHNFaXL61?=
 =?us-ascii?Q?ZFCMRBRLbMuZlAlaQ3X4UqgBuesDANy4Nxhg+tjI3Q5Ol6GSaeTJ2jbeq6sS?=
 =?us-ascii?Q?VHH0KL2GbsMYPQoqFGlOeSCmjb9wTrVsarFnYVs0yNJnEKvfbP4JxPe6hZx4?=
 =?us-ascii?Q?JFpeu2J/6+ZqGib/iJiLz6LgdrRd4ws5JeLD0B4TjTtdT+j8uOKmXP/jOYrD?=
 =?us-ascii?Q?VTpbanUN2UglWNIWC+xm1ujmHYX+tPw3kgq4D6hxyF54wVN18So7AoNu4I9z?=
 =?us-ascii?Q?fYMYmwOyBAuwuh2L4tA4ldVkH6Ne8jhMoPCHLM4VFo8rKG+gHRyZFHKLlA7A?=
 =?us-ascii?Q?zyf70ZEqptTrdxpdtmxSc5ZnjD1Pl4bp1e0zim24PfzDfTdVaVfl9Z0F1zko?=
 =?us-ascii?Q?3BW/qvQAeRCru5LBg1MXUbQnUvU5kANB+NUCAdhZ/xQ0hFWlCncCBf5f94aI?=
 =?us-ascii?Q?Tlnf01I8IVJEC7tNz2zd2rPUsjDIuJA7rpM/K/Xjg078a1tYFUkFFek1AHZk?=
 =?us-ascii?Q?2IbRpHm6RT8swQjWL/HqbbbQtdG5eXUEHzdLPUJhHNYifUftz8dmREnrHgov?=
 =?us-ascii?Q?uIunYS8jbsTHts3Cd/PS2f42HtlB5kcmrkkWZutXoUSrWv4kYUtGvhxdGGpd?=
 =?us-ascii?Q?tuUARFkDfu9YAEkABa3GaNZ5nliPHgOY0xV3CIANZ2o99QuDeWLoJK6MsUyA?=
 =?us-ascii?Q?nC51BRZ1oaXxiVYP5KQGrSoldXmaSa0Wt3VFj6we9k9mdVJ8DsOBvIemZQVH?=
 =?us-ascii?Q?w0mKzEB+VX3BKocJJ+GfkntFoLCuhCzzWDG/vfj7sYs719g7mgwTF614wUok?=
 =?us-ascii?Q?Jw0fSURVI2eicqGjlCPu+uvPDfYiAlTtXG8+xEEGnimHeb3UV3EuOOw9y4d6?=
 =?us-ascii?Q?D4BU6E/mKpBlqWlc7p6xKjmW/fYc3m/UbQaqXeije9cAQWKHTN9geUcyUIhg?=
 =?us-ascii?Q?SKwC/+dwsGA0KN38Vu6dAOyBD2y34nOBSfqIqlL/ckOvUYWodskkLeKNdyRI?=
 =?us-ascii?Q?ISUaNhfbLwDO7Akix0waN0f2cGDPiDtevy0M7oGJlU0N/+1w5xWPSL+CWt8y?=
 =?us-ascii?Q?MvGIij4lyUfqna76RkVZItdowmxsU0YffF9aiVfX7y9PsltOTTPI4IWyunfC?=
 =?us-ascii?Q?qJ8ULJH2hBJRjWfYbdXIR1V2dryiVCKoq7NSsfEYu7K/cu+A5HJxUJ3uqBOk?=
 =?us-ascii?Q?sgrC4U7B8/hnkvPKVlS/nL9UB2Vg6WLOLZy6BPD1Gp5tKQe4qZS6Q8+BcWyl?=
 =?us-ascii?Q?hyXDDCtuFoZGZ4f4mOkmxcDdY475yfRNOG2p8WixM6TKujyJB/uKbbWgZOjp?=
 =?us-ascii?Q?5UkzcOmRGiNpZmp0j0LblOlzGdfOg7SqLuR5nqzK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iGLotCXFQIePqHjvtCkqxFz3ri9HRtqs/IIEokDdPnXK2CyaWn0hyhkZ5DloYyLQZh5sjWP9qhsklPeRfsq9f38dLNALoOH7djrtg+pQwx3LZ/+T6UhT3b9YVJAmH+ll4fwAKgBUBeKJplgat92tBHW/GPlh01M/Atk/xLFwXlG20m2tdFix+lhRSX7/sD4D/Jt3vJ6ngjbcbg9qNkWVa2q5U1eL3KZyOZTsA2C3HocIrp6kSBxgTeLKtPKe47fZULmDJrCDllhbgyRDtSOqNQNOxuzB28xIebHTi8vpSX51mxaX8iFsn+yEscc6kJCqMhDeCt4jUeDcmU1qEbcn8RLMEfhmOuXKbvYHAK4V34f82BSa+Mvnx9Uo/m5POIg7zs4Obtqb6Fkfw4YTSpjN3f3fVEPoI/VB6Qu3rn3DYzZ3Q1RN4bkahAWwU4PBHB4jN/6Kqo1zEXBMe+kLrs92fhFqAa6RqKnelG/W5o0vkrEGUVa+7pdJReyW2a08b5CaxljACneaXlb8mCH7zSIXt3e2v8gxQUkuSghBJzYTWrj2HMMmwXo6eNrJfgEvjSwBvAdX5mhh2Io3pCCmSblZIDFtOnoQ/5j5N8/5nUIwLgiOiQK86kGNARu0NzfTGW5SD18nkJK9RU3xIz7m90UduTHPPJZTVm/wsZCf5onejHMjaHA0TuZCxhAqSseJVtLxAAYXGCVla2hC9bIPC/Qu8sJJbwRYFBT3LGQlzOHozhEPUfZOV1RgPHrKzJwSLjn8GLTIuzW3GY+5s1MY0ldBCA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb84226-2962-4fc1-84ce-08db673e07c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:00:32.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3Vr7TfsiQzQ7/AKtUbiFZlV+H5ZNINt0HdLZZOJi9cvCFGfuufQMN2gzqVh5mYvgoym+ZIH2ARuu8iABKj7dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4762
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070081
X-Proofpoint-GUID: eYKcn6k56O8i7ynG3IB2ZQ4wleEueOMX
X-Proofpoint-ORIG-GUID: eYKcn6k56O8i7ynG3IB2ZQ4wleEueOMX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/open-utils.c | 9 ++++++---
 common/open-utils.h | 3 ++-
 common/utils.c      | 3 ++-
 tune/main.c         | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/open-utils.c b/common/open-utils.c
index 1e18fa905b51..e34abee97f60 100644
--- a/common/open-utils.c
+++ b/common/open-utils.c
@@ -53,7 +53,8 @@ static int blk_file_in_dev_list(struct btrfs_fs_devices* fs_devices,
 }
 
 int check_mounted_where(int fd, const char *file, char *where, int size,
-			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags)
+			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags,
+			bool noscan)
 {
 	struct btrfs_fs_devices *fs_devices_mnt = NULL;
 	struct mntent *mnt;
@@ -108,6 +109,8 @@ int check_mounted_where(int fd, const char *file, char *where, int size,
 	}
 	if (fs_dev_ret)
 		*fs_dev_ret = fs_devices_mnt;
+	else if (noscan)
+		btrfs_close_all_devices();
 
 	ret = (mnt != NULL);
 
@@ -132,7 +135,7 @@ int check_mounted(const char* file)
 		return -errno;
 	}
 
-	ret =  check_mounted_where(fd, file, NULL, 0, NULL, SBREAD_DEFAULT);
+	ret =  check_mounted_where(fd, file, NULL, 0, NULL, SBREAD_DEFAULT, false);
 	close(fd);
 
 	return ret;
@@ -168,7 +171,7 @@ int get_btrfs_mount(const char *dev, char *mp, size_t mp_size)
 		goto out;
 	}
 
-	ret = check_mounted_where(fd, dev, mp, mp_size, NULL, SBREAD_DEFAULT);
+	ret = check_mounted_where(fd, dev, mp, mp_size, NULL, SBREAD_DEFAULT, false);
 	if (!ret) {
 		ret = -EINVAL;
 	} else { /* mounted, all good */
diff --git a/common/open-utils.h b/common/open-utils.h
index 3924be36e2ea..27000cdbd626 100644
--- a/common/open-utils.h
+++ b/common/open-utils.h
@@ -23,7 +23,8 @@
 struct btrfs_fs_devices;
 
 int check_mounted_where(int fd, const char *file, char *where, int size,
-			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags);
+			struct btrfs_fs_devices **fs_dev_ret, unsigned sbflags,
+			bool noscan);
 int check_mounted(const char* file);
 int get_btrfs_mount(const char *dev, char *mp, size_t mp_size);
 int open_path_or_dev_mnt(const char *path, DIR **dirstream, int verbose);
diff --git a/common/utils.c b/common/utils.c
index 436ff8c2a827..b62f9f04ad5a 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -230,7 +230,8 @@ int get_fs_info(const char *path, struct btrfs_ioctl_fs_info_args *fi_args,
 			goto out;
 		}
 		ret = check_mounted_where(fd, path, mp, sizeof(mp),
-					  &fs_devices_mnt, SBREAD_DEFAULT);
+					  &fs_devices_mnt, SBREAD_DEFAULT,
+					  false);
 		if (!ret) {
 			ret = -EINVAL;
 			goto out;
diff --git a/tune/main.c b/tune/main.c
index 2ea737bd0c0f..9a6223f4aa0c 100644
--- a/tune/main.c
+++ b/tune/main.c
@@ -268,7 +268,7 @@ int BOX_MAIN(btrfstune)(int argc, char *argv[])
 	}
 
 	ret = check_mounted_where(fd, device, NULL, 0, NULL,
-			SBREAD_IGNORE_FSID_MISMATCH);
+				  SBREAD_IGNORE_FSID_MISMATCH, false);
 	if (ret < 0) {
 		errno = -ret;
 		error("could not check mount status of %s: %m", device);
-- 
2.31.1

