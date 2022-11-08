Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690306213C4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 14:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiKHNx6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Nov 2022 08:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbiKHNxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Nov 2022 08:53:38 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699BE63F0
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Nov 2022 05:53:28 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8DqBP8011403
        for <linux-btrfs@vger.kernel.org>; Tue, 8 Nov 2022 13:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=kpKPFOjy5JIg6uM9XspJ8Tx2LEOAinrXNHvYNKNl/UQ=;
 b=HjAZwsIHZ/WnTKyYweJ61iLJz9UkhzLj9P2G9/WkD0NoQVAPy1yNZ3l4dfshdI6/OghL
 qBEdiUIPmSSJP/hwvBqU0PAHbd5xpKdxsBFm4aVGioSZM8Bs2kzKgm1sQ+x0bj6pP4YR
 j+vXRdpoQkqlXIXlOZDiK+PGE2gVduVAGpq97Va+UZNgURs45F6bUr0g7xYso3UOxFsQ
 6MXBaDJerk5BfHKU31bH/ORrYtrUe0MDh7biN9d8U9PbDq6Iwu1NiBIcQdQDUn7jPmRg
 +L998VC483rnjzIT7b8reiTFAB88JdZouYnfRqRPwU03hna8bwl1tYKr4YltuEClqwsL 0A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kqrce005h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Nov 2022 13:53:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8COj4b034422
        for <linux-btrfs@vger.kernel.org>; Tue, 8 Nov 2022 13:53:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kpcsdfd3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Nov 2022 13:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHncL4m9m3ohhSaKQ1dspgDbfr3t/Np1jEqfuICvCxUxtMZ87PxrZ47krXgs+yAGEDdQu+aY6pXwJ1X6dmKr3dyDSWVG14jtofJYoPCIlD2/kbJA3rpMTiR4OJpa5ITTUYR3b2TVFGi6m8mGsT2oBheLeQIPg/CGMCpr/SuwkPc5mMgSf83jr51cgJY421l01PHmLYkopYbOGLVQKeMAKfC5CtkvikilGulj+zUsy8WygjU6T3s5H9KkzH8d3wYT7fCrQ38+kjG+C3dqwbVvDC2AETE1LkR/HiMfSv1rKCzbollK9gyQ66TQ22w2wRtBnuGOe9dcKdP4tC0S0+vOTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpKPFOjy5JIg6uM9XspJ8Tx2LEOAinrXNHvYNKNl/UQ=;
 b=mlrdARdxcsi2bZEVJr5tZh17z05V2+FPe7vjDCsfJpArMH5LyG/JRgfIazE39F1n+50ioyN1O7h0CxOByc1sPOMnEzZCcsCH7ejnciD5Whe7NVky3MrpHbvbcrvPIeoqWP/ONTwiyrsEa0BqwEo9SHN8BE+Wjdbh/wjXN2LPawe9GcwaiLCqypuWIUsh3K6+5GFHnYN0umgjby8qGs5q20hhfdawRFor8rjexk9tcOBx2bE6hZrx7Ahk+vULjKh1YN8GtbHe5P8F9/tJ7UoyPfPJgTp7VNNFekWE9OYlwRTnTCpENSAyOIkW2gIoVS1yhD710bYrmt5Nbg5KVLQyUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpKPFOjy5JIg6uM9XspJ8Tx2LEOAinrXNHvYNKNl/UQ=;
 b=X71trM1HTMqM8bwBTSEJia0nKKFuEz7plRBQy+URu33szCKOcUzqssVyIa0ITUSgWw9Ejis+ocSbMw+2PpIIByvRQTquMphlkZDxIfB2OpchMxRXGFV0G2+jylm9WPkRwDRrjq29lSARtB95Pd+83YogSU/BA/EzQHiJ9qbqBEM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6186.namprd10.prod.outlook.com (2603:10b6:208:3bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 13:53:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c0a4:3fc3:dfa1:8f56%4]) with mapi id 15.20.5791.022; Tue, 8 Nov 2022
 13:53:24 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: drop path before copying subvol info to userspace
Date:   Tue,  8 Nov 2022 19:23:19 +0530
Message-Id: <3d46bd74955e2087332e492a96f6da78ca4ed533.1667898218.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:404:e2::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: 088953e5-0d07-488f-11bd-08dac1909acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSQKYbZwtL4TMNkEjLOnBHqZsRF5lDjrOkhELU/9BfI9RWLnaWpCas25ZpYVIEc0WfAOCRxT0tpk+km6WHQcwklaNddik0nFnVDs3PYJOdhdj/jc1qeeNfpt1VEDWSw41MnLiYT1dnJVlWTv/68G3AyMzPRNEQLrJi8g3il/0NW+DgFQa4O6ZBlXRjppKmE3jAk6dlHSgZ113ei6JZYuf9Rcklz0p+H3lxi9xRlXHX3IgVqvFzaiUmWhcsqZJruXwJCL0oB2ZOU+2oyAhQhV5YZ0mnBovTMNz9b9jfxlYMOqiAuzKrMihusGkyw8Rvcpj2XIXOPsmQN2tw68F9AUCq0dapt8gpfXTdrgczh9LQUF/sK8/AjLVDXTNY+3fTRGwhi6xVUjq4lV353vkSZQxWGMDHX1Nn4pmaQJpRAsx7JnmqcdMLqQZVHXXoSKpfPKKjUb+CGM14hfyBsBdbJSbjkGMVnT78HvueXTmptGyYN7Vsm3B2LPST7PY8ZUwMk9Ii7QIGzg40S8GbsO3M9xzUXdSfxDIsdNoKMyT9ySUC/UhNklryd8c9ei9UP02ReVAhGpEv4+xWi6OZdXeECAFK/VVKWYIGdc5pcyeLIYNQ0JYV6rQpE++V8yDcTXYAhbNZwcYYk0FflLYwU+nNJjomgTnNlau7TgzjwZcWI+YSmKQycv+R0TI0WZ6zjD3PAoipRnycCONSgq2gwwEVMWqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(2906002)(66946007)(44832011)(478600001)(8676002)(66556008)(8936002)(41300700001)(6486002)(4744005)(5660300002)(66476007)(316002)(83380400001)(86362001)(6666004)(6506007)(2616005)(6916009)(38100700002)(6512007)(186003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0beIfU9ETdff/30hLSl0UqnwjWJGvCsl5FWcFu0OAQKj8CNcqISXI7ikRiv9?=
 =?us-ascii?Q?cs3dVCNpKu0NEubD8zstlb+qzd6iN/4+Y4+JgCFzU6xolLGMV+yJ3QiyKlZD?=
 =?us-ascii?Q?/U67G4zwHwJ/6a96ljd841aVPvUz6KEj96YsL5fVneTB9HUiafts5WD36iIl?=
 =?us-ascii?Q?kAgUaVfykPtymGdQzw+RceJdn0FInOc9tRm3c5SVKvhSo99TNZlsNNrk2UA2?=
 =?us-ascii?Q?AtGafNvuv0QCjQOg2yeA9UcqL483ofZGc0cO3/I2Yxp1QtMiO3jUj57J4zyW?=
 =?us-ascii?Q?P4J6YSS3sJzokGmJ/WraBxrjaEgAkSl/hDK+iwajf5KqcGECOJO6j1i5uRC4?=
 =?us-ascii?Q?EOz09DB88WsC8JcPB0HOTOigZWIoE9KIOOByzs5PiDXqTJzi6hBQzUvv9SI4?=
 =?us-ascii?Q?xt8iSiaGk826Umu5tPTcctQy7HrX4LGOhQqAzHgC4fv01XGDYRaNAaOiCBQp?=
 =?us-ascii?Q?xKRIlZD4ApKz+ayVRs6qgvDusLazxnJZ1lWid6R7TmreASPFLFtlruFfIngE?=
 =?us-ascii?Q?+y2ZuO2m9iS85wEvKsgOvfyYe1hm/CwvAzF8kRZJSxihw/Qjf3gpGwl5hkJG?=
 =?us-ascii?Q?Y8BbMnQFVUc8k0x3/CDM5nSaOynvdv4AGDAeoaQ5y79iKcVtaQFa0e6P/Vqh?=
 =?us-ascii?Q?cGp5MHD0cOsB8wuwC8jqioCPhJ2BdZdqeC0eKfaNSPZj4JMyBRYNoMDe2xlf?=
 =?us-ascii?Q?0M6ZHL5WC7gkBW8rUNSkFMEYbQdzeDoRHIXhbwnFvj4X0G0BScCv831rv6KY?=
 =?us-ascii?Q?9CnMElKwmbF7bzsqoAj32TTFOir4FY9uBKaQFg1kQM9HjlJYWKiLlPzFvUWv?=
 =?us-ascii?Q?ObkCNv6eixQE1fzLuQgELxegOmpU97IZPRJWGgOYDSDoWz0g2gfu2AD7442G?=
 =?us-ascii?Q?V0tOhIbWAHjY5khKdvCZ3ePtJlPKdWcy8vR1jAyMLojEepYzJCIYUW+v/2iK?=
 =?us-ascii?Q?LeDxh8STWhwRbM+0z2H6AO59F5bCuqpqV51BqJteHb0kSIFLjUD8y/yEu5c5?=
 =?us-ascii?Q?Y8g6BOZKY69dOFj/A8OzFgJK908Nrh5r5QFvte86LJRoksCyH4TUZQIK8R6u?=
 =?us-ascii?Q?+wRYoWwCtFSs+6I9jJQ+Men3a6zNcPoHnYLYxgWZp9h54GvrBq4+USxnOa++?=
 =?us-ascii?Q?50YXg6BL18Xcz7DUmEdMtrvoarjt8ZrzFLvl0s3srCAt0Vqb35ssDQeqmIYv?=
 =?us-ascii?Q?UIrTmbuz3AGZmGeSK5iufd3/GDwMWSNyduytwf4RwRau5qEhv7x5HySVzdeR?=
 =?us-ascii?Q?svsX+EHTCjFbHZtdjd+nCulWXlLKnFPjgGGfqje3Mino2Xwf5Bmnp82hn+3D?=
 =?us-ascii?Q?4ugwrTa+6WqKrmRaISEh7KgPihAqIWLC1qKRZhVNOGoa3qe7OGZN4j3uWMk4?=
 =?us-ascii?Q?3yGX/q9fqZT6xs05sZqMEgERr6b/oXI9b3YOUu22sLhxijNJSxrMahDTp3qu?=
 =?us-ascii?Q?dXU+QYNProCepzL6ys+wGvz8YvMuXn2DxiqX+rqcTj/aEB7vH695wZIoP2OG?=
 =?us-ascii?Q?mS6jVG8w8faXWPYsg2bH4Wq47rlwktDiKPYokFxWC8Vq+sf2CTgBhLoj+wG5?=
 =?us-ascii?Q?L+t2y1/qterzg82v45TOXfk7sp1zr+PU6qRyBCZ1Pwx5GdrjKEJej0o7hs1I?=
 =?us-ascii?Q?rWRlwWl0NabWq6AyVsqJcys=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088953e5-0d07-488f-11bd-08dac1909acc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 13:53:24.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7E0NADF26FHkz9X/0IGOGvyEGIuwGwYd7iSRzt3pw+WgofP2BcrJ45+05kHI5sCi6PvsQj9J6l3CAXEvgVDQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080083
X-Proofpoint-GUID: cSBA12TvEytsZXIX7p6xy_i05cRja7gz
X-Proofpoint-ORIG-GUID: cSBA12TvEytsZXIX7p6xy_i05cRja7gz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Similar to the commit
   btrfs: drop path before copying root refs to userspace

btrfs_ioctl_get_subvol_info() frees the search path after the userspace
copy from the temp buffer %subvol_info. Fix this by freeing the path
before we copy to userspace.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ioctl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a64a71d882dc..4742dedd8fd5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2214,13 +2214,15 @@ static int btrfs_ioctl_get_subvol_info(struct inode *inode, void __user *argp)
 		}
 	}
 
-	if (copy_to_user(argp, subvol_info, sizeof(*subvol_info)))
-		ret = -EFAULT;
-
 out:
 	btrfs_put_root(root);
 out_free:
 	btrfs_free_path(path);
+
+	if (!ret)
+		if (copy_to_user(argp, subvol_info, sizeof(*subvol_info)))
+			ret = -EFAULT;
+
 	kfree(subvol_info);
 	return ret;
 }
-- 
2.33.1

