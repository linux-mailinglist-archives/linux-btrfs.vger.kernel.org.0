Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD5C76DB89
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 01:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjHBXaR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Aug 2023 19:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjHBXaL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Aug 2023 19:30:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE830D7
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Aug 2023 16:30:06 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiBwc024972
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2023-03-30;
 bh=o1fIyC+wjWJyDATEsOJy+iLRD+G4RkafQ+cYZga4/mc=;
 b=TTYYHKza1B0nuPo1qEOyHrRlcx1UwAlxuWDhWOsGj0Q2jQaz//SlFU3/QtTiJRU6PgP/
 sXqaxI9l3r5JL/KjhoEbFzt8VtUpUJv/U/AOZhASBrVh/KR/kZmwvN2sAqVE5Otdtada
 SF0Z96nAtHc7dja25y/9uz1W+gipPoSt8GXKXI5GsUuVaqA4y6F89Uzg/4iGqvyfGfz7
 ib8khJxk2aurjgL2GDSgagFiz20Vdmi71+gcelbRYNktrEz73vZSIGrlw4e1xPlnLKq8
 q/OSrOwxtX7erGOeORnnJDld3RB80eGujuE0ijayDH8wVU+DQ1qVKUXxo3BU58qpXd0d zA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e8dcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372N5RA7020534
        for <linux-btrfs@vger.kernel.org>; Wed, 2 Aug 2023 23:30:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s78tucd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Aug 2023 23:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljE3EpApKVx3z3gNSXWQ6wMYEX+a30L8QIugjkrW+oz2XJ7F103MhfstQwZVZ/zP9Z8Jv5biKNoUE5FGdUyVa3Nm0QYSkKE6tWhhsMsnLP4wSahJ3kZWLC05y2Rz0aCX/HJ0YBwv6qbinTjWBwYM2eZ6u6bqbvtO2iEj9gBYH1QSWenaKIeRiIAv3raSyOIYOHf6Aby0OR9OPNvO9AlLgFrsrwVOuRT3H5J/yYIutzjYMyj2B+wXoO5xutGoZ1gi5x2A+H8RN0aw+AxIVtIHLr20cyajH87qJ2NmrR4BupecBLY72zbB33UsZawDWxoCXK9o7963NSrVSffuEXRl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1fIyC+wjWJyDATEsOJy+iLRD+G4RkafQ+cYZga4/mc=;
 b=bgq8BlmFcHFvZvVSolvlyb2dMgDEHNAo69II5e3zB89H62DRNGfY05LuYJLxOqCEDNlOSLAX6xtvCepmVeIlePb4fDZyQG1XSvOWUH1h8na5qyLRJ19TGJdzIpgM/3YczmDgOU4IkTengDu4HrHk4r2baVYfdtBCx4cvf2xkuzszJm13U6ODwsyrblPjXcUQJubpQ50UjM1jazUpPRAT92jFA2EkEJ7OmBUldUY6pzPox6UL3qIQTN6fY93jx5Up7w9qS4aL8H2xsmBL2MxbFpdN/vljx4s+L+UxY7kuAg1eiGb+LEhfJhQInt8xAgiDPdmDSq30plVZC8lL3w62EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1fIyC+wjWJyDATEsOJy+iLRD+G4RkafQ+cYZga4/mc=;
 b=t26nfMqamGBR9wXofGEKHqbI27x9UD0nlhw8s24+jZkST8Kxe+Yh3crvCDdXxIl5DIKWm3hyGDGZZDxjdLY4nSAyFdtYARjs5g0K35ft9qgHiflXGOTZSAudduaYHM4aDku9oZ6Y5TBRkmAo/QV53pqA/zfuuxGq3cvmRVsv6lc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 2 Aug
 2023 23:30:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Wed, 2 Aug 2023
 23:30:02 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/10 v2] btrfs-progs: dump-super print actual metadata_uuid value
Date:   Thu,  3 Aug 2023 07:29:37 +0800
Message-Id: <53c1111fcc49df5f0563839146260c8f0950b071.1690985783.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1690985783.git.anand.jain@oracle.com>
References: <cover.1690985783.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::19)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 90836723-a483-4881-9baa-08db93b06500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uOlZOPum8WsAy9cne5/CFU4JnY3gBPzs0CymnVF7VV+jHYFC6ymkI/2vmkJQCEhorVc0QLxuZ7wPep8Ar7LMPdPlZWYRsZmONmukK6zDZ7X37uWZrQgH80PXa729ZogVdrZiMJz2zZSUkIfFcP1wGeXkvtqdgXQQiSX+5bOFQsMSr18q1Uc88A546gGRaHS2qfENHkzj46lctjY7GZtCc3YAkspAQnuk1LRfSJCky8eUvz9+72EiW8yZwcjg74xq0yuO35dd9HuOR5BVadPijrrhFrZ9vnmeWRRHJ6HZPnqFNjW/u2PgXHnCXzJXNTxTJFOGrN35T3WJ0PmXLr39l340m3pqBXNuqveJsCQOqDXLfZJ8Sbi1VJH18o6l+30roHhzyhHXS0PAJRfBNzODJ5b7ROjwV8+SJuBy7OdafiAUoOERHgmHOkGYqsjxMH20SAZzY8ijAZueBhjeqiK7ybQU2VzgfNTvDBru37M8GCsjpoI64gRh8nt+DKJdvga3mX1TeEHe4Qc4yKHm8CFI/UqN6k3QwUF5eoTCwGvuBMJY7KgsyB97TwVMXF7Ax8hz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199021)(2616005)(6506007)(26005)(186003)(83380400001)(316002)(2906002)(66946007)(6916009)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SXX9VyszXdO018bIZ+ghhm4WMUJMYd7niGAlCUBQtQRaO3O+umKQkCBnYlHg?=
 =?us-ascii?Q?4YsBtEdkg5Mp2dRWnhAdP2FGWYusGE+U8iwwl+TZYtH1f4fXgEH85wZaBK5z?=
 =?us-ascii?Q?JQ938URlW66iIZ64WH+N+qnBIhLuREJxsysp/Cg7m4+Z0hsREThtU8KjtbHk?=
 =?us-ascii?Q?7L04bUsjV2d8mxQ4tf24O/fccY+WRnQEt+ljwHWjvQDu1BrR/D3ZI0PP3ZzC?=
 =?us-ascii?Q?x10cFIhvmcELh30J4OKz9yb45/yeGKx/WJFmAylNoU+S0DNXGziJs/xY2x5R?=
 =?us-ascii?Q?xxsh0qAQdA76Be+L+dZ2RMzAO1Bw/Kc48Ve/QNe2NfQlgnTKdKFiijt6y5j5?=
 =?us-ascii?Q?oSeUPOs6I3VACL0Mqj/zZLSvMr4stfIP3v03x1PkYM7zyQUpnYNiWbY9nvL9?=
 =?us-ascii?Q?B6m9CSc1sogdwEa2jzSvOGWiDP19VEj7iiFWBGPNSdQVVSwsHfJbHSXKJ3tK?=
 =?us-ascii?Q?khuBxTROXc3vwKMFgD66HdgH1LTPA/l4CTwmxM6TOfjrQralM2qP3hctKcbC?=
 =?us-ascii?Q?UWxUuHCp+fsC/y27yMmNFIDFBdXcSHNgWj13Qalki8NRExgpV/g5yDef8Jet?=
 =?us-ascii?Q?37t3lJNRjlNECGUg6Oo1qCb4RF69o1mzLD2cb6JppKKQ/SUgEzrSEr2j1JRB?=
 =?us-ascii?Q?9+p7VXYf9ahyl9pG+NEwAkMt8bgL5oJ2FlhB6MZjGUTCPVLst81ymjEU8DCp?=
 =?us-ascii?Q?5F67E3IUFI2D/cxWpfzCwAXEYmfN9UEvgLeVfsfO7CwK2qNnbpjwfBj43zsW?=
 =?us-ascii?Q?6MfHRU0r3pH48O0987FJ1zTg+LCTxtgr858B5E8kBanL2NXp6juiRgkiFEAa?=
 =?us-ascii?Q?Agp/3uUGtp/5w8sNvCf0/iy/5xrXirgvvyaL3DwVR54Ve8NmwyM9TP1z9YKg?=
 =?us-ascii?Q?v1QrjbP9B2hggFmBs/QVSPg2fVOls/nNe6Ttfpw+kp/LkIjIwL1BczoxYVRx?=
 =?us-ascii?Q?zTieH6hKknxQ5M5AzTe0nSHBgCxbzphlxEvKQCvcs7EV8IyXPXxTCy9W6MUo?=
 =?us-ascii?Q?99EvkhkpGQzF4o7sEv8vhi1l7bMymAJ5uH//zVNQCMF5kT9g26Culrv6+hTn?=
 =?us-ascii?Q?qs79zOwM/DFwaC8WaYQwvZOfsH2lfnSUk2oyvqakP7v/PKElFRny0etQQH2N?=
 =?us-ascii?Q?paqpsDv3AKr0cJbS2vEsgI688PhzRlVJ/snEWE44DjzR6VNrVic5tyswa7Yv?=
 =?us-ascii?Q?FHj+4igwjvEO08FTGzd3bko85Rp4g3aUXeyaBIfhHifPjpdXZwlsnIdE3P46?=
 =?us-ascii?Q?HpJmCDpSsTVQ0mlWjVSGF9/iiHP8JVMK8GhH0dy0wY9EPeMO1VT+uJCC9nGl?=
 =?us-ascii?Q?v6G5WxCh/jVftUHcE152LKxqSHCgA6uoroxKBRz0w0L9xk+t3XPe28voDOjZ?=
 =?us-ascii?Q?CPrNbYcKJks2/0LV8zNqULMwASAMzcpyQLTBnojKT4qgi0SuzL/RTdnycodq?=
 =?us-ascii?Q?wip/uolX1SoQdl86WYuuF7cj900GKJeiiIfK+/+RlIB3nzJ4Gzc5jVLVvowR?=
 =?us-ascii?Q?+JHwwOXErPrF0+UzOfCdquAkV61WSRl2mf+7OfpwXh77ere6lisHu4AgH0YT?=
 =?us-ascii?Q?swWaKF3+Ph0b3BHT4B5wcHlNStAJ/BL3xWBq7rRT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B4C7jLaEn3drCX3RI3CM6uqS95GuULt1uTc/3LiMFGlAX7afysLa2Z9u5s+0uKouAmxM65K0gSUdd/wosn02wIgdWKFUhJeyjznybn5Vf0dSBoE0zNGlDThTzt6GiraOXbA9LqA/diFqZXB5e4wcuEPnKv0WJekYp3PjQudX6XOfhXUWsacJjLfsMISwSdsC/Q0Q1/UAmePx50rBl99y/tryhkB5s3zOpUcMV9MlRWVicXYVCbXKt1s98ZIMqpj5fgLF5EOrFfDsEEXO87xdbCNEH521VC5ixcD89wVtbSdrXYvqP/M2HQVpVJTbxE651YyjEcwFSSqw+Uljxw84jXPFbrNzHNfv/Q9qYJcSuL+IKES3M1KklckTWie0zyJcyhuwVQc+JErniKhROp2k/kjK9b8v/P5T9bYV/R3i/0zVKC+Y3aPnhjt3yB86RZQeutJO5P3GGdGtY9S5nXYG8oI8NiN6R5ahpcGrEoO2LdzgtrG0S3JbEqYXzJFRNAzIz+AmaD5yFCWVh1v6uQUdQfAd7zKl1hRlI+fmhP7PTpwYACcMUSAgYLAzSD693v7xCSAztnRZKz/49MDYWUGkPOYnWmTFXXASphZz4zJ7+DRXX9xmO0FZfbKrsZjhQb2zX+ok5v/mA7xCE3x9XMlbKBeoxc+dFsslkYLa5RVhiSCzrhT1bly3YuZS++U8v6OzjGiSO05MgJBL11Rm43eMmQ62Ip/IFfYj/W+XwF9LH246x7sVAx6XFXyUZC6TnDVkiaH80qntLCWdzvBbh+4/mw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90836723-a483-4881-9baa-08db93b06500
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 23:30:02.3153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl8BqdBIUhY25F03yIpcMqMPVBU1E4N3rmGDsXwebSJEge1cOsHoKK9ixoRS86JP94iD4nd6MwV9SCHHVLhfDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020208
X-Proofpoint-GUID: p9MYc-zNg0vtFTnzZI_g1hGKkGfAsi8-
X-Proofpoint-ORIG-GUID: p9MYc-zNg0vtFTnzZI_g1hGKkGfAsi8-
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_print_superblock() prints all members of the
superblock as they are, except for the superblock::metadata_uuid.
If the METADATA_UUID flag is unset, it prints the fsid instead of
zero as in the superblock::metadata_uuid.

Perhaps this was done because to match with the kernel
btrfs_fs_devices::metadata_uuid value as it also sets fsid if
METADATA_UUID flag is unset.

However, the actual superblock::metadata_uuid is always zero if the
METADATA_UUID flag is unset. Just to mention the kernel does not alter
the superblock::metadata_uuid value any time.

The dump-super printing fsid instead of zero, is confusing because we
generally expect dump_super to print the superblock value in the raw
formet without modification.

Fix this by printing the actual metadata_uuid value instead of fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 kernel-shared/print-tree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index f97148c47b5a..1c398c3dacab 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -2006,12 +2006,8 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 
 	uuid_unparse(sb->fsid, buf);
 	printf("fsid\t\t\t%s\n", buf);
-	if (metadata_uuid_present) {
-		uuid_unparse(sb->metadata_uuid, buf);
-		printf("metadata_uuid\t\t%s\n", buf);
-	} else {
-		printf("metadata_uuid\t\t%s\n", buf);
-	}
+	uuid_unparse(sb->metadata_uuid, buf);
+	printf("metadata_uuid\t\t%s\n", buf);
 
 	printf("label\t\t\t");
 	s = sb->label;
-- 
2.38.1

