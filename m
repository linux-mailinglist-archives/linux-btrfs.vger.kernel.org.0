Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DEB59966D
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 09:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347192AbiHSHrA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346383AbiHSHq7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 03:46:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E795D7422
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 00:46:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27J70bMF016178;
        Fri, 19 Aug 2022 07:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=PGq6k6beqWKEFtH9hN8XamFwsoL8k+BlMxQpbZ906S8=;
 b=WAQfcZYrgUmf7NepZHrlNepU3NeR4snut9WbTQUXAEhRyR6s4XFxLJJeXEK46cSsfr07
 xvOmSHTXb76MjCaZnDfm6oH8CROj50N4hAiM/YcPqbLRxBVyLDHTZEkSM+swLmBt/pJC
 BYtXY5kdmXOKPNbCTKSIhaSOq7OZOqBocpnQrp3zc/PX52RjY5pX1Zd+txdma7pOJgeR
 sGWHJw1gfqZ6NZjI4by2gcA/9VeqtAEOgnOJcj6v3S37LtQMP+HiTYGhmBOeM3onPh5Z
 OsNSXcsJ/uUSiktxZstkKh6ZIzh9Gh48S/zxogi7tsyeCsVhCjYGFTDlAvlHGb0Byl3r /A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j25r6r2f1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 07:46:30 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27J6LBjO020788;
        Fri, 19 Aug 2022 07:46:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j0c49jm21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 07:46:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcCqaRdGgx1rwy5x1QMWDhtLz4/Dnb686EKOg37DaSs/qkyl0aiEae2lmSO8LObd6U1TCJ3iXi1xqROyZpk8PnXTcE6sczxt8xe26JZy2pBheOLCtqwFGr4SevNwaV5lc3vXfHrhlpJEGJFZctJR94fxAoJ/VRwy8BlxNzkl0iWU7f+RfplMJI8y8TR/eip5dSOHaLSbWWj/RoO5A8VeZKpDFyKEUfRQUc1qBAuxJsQpzrvt2zs8qWOJ7Er37gIxHxXB99yb3KPP3C/SkIVLFsp1GrGcn4X44QtXWFNIkXFVTbpDcM5wv98VfgvuJxYQVbgTFlHElLNqAraOXjqhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGq6k6beqWKEFtH9hN8XamFwsoL8k+BlMxQpbZ906S8=;
 b=J48XAmLKZlWRFnetbZr1DVFbUxVv8IDhxmfbPrUJP7ttYnlWs+iyGvHi5VfXMMMX1xutFpxJF9/INOzLrqpKLknNWLxRHrbjNkbI1EoRk9ma6Z66mco2Lazs1/H3xA3RnlOCtGvseRVJeLJgcRvQZ/vuhwx9YIVOSC6jr3Gz7MBWD8nVyo3RoqU0of+isRTY4boXrv/IJrDD/KvIJWcq1nFnpZfFF0On3OLoTMkrUC/NkKmNiIlLNvRcR5Sd/JkhF8uaZlEpjDGVW1rgYy5OaUkhE3Vbhd5UuAs+Q++C/vCrfgw7Hfy3/Fc2j+K0QG2ns4SNfJRxiazQSrw8W+UUmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGq6k6beqWKEFtH9hN8XamFwsoL8k+BlMxQpbZ906S8=;
 b=Ft3/Zv47wsbzb/onmSDGNnqGmZ2GJ7Z/4ao59STLoF1cdiDvOP1FUdbgH8+0QO/tY6xQMXP0JUylMlKsHS62BfGf1vOMDFFmOSfATLZGQ336FSzYXR47mFbYGrOL30IAkN1gnzh0KEQ9DZtxdiobhCCtBCPXhBhDhf733pwloe8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6241.namprd10.prod.outlook.com (2603:10b6:208:3a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.27; Fri, 19 Aug
 2022 07:46:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Fri, 19 Aug 2022
 07:46:26 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@lst.de, dsterba@suse.com
Subject: [PATCH] btrfs: use blk_opf_t for opf
Date:   Fri, 19 Aug 2022 15:46:21 +0800
Message-Id: <c60c370689f63591795394d2c05a4678ebb622b0.1660889735.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0ed0cc9-181c-4871-6fd6-08da81b6eb6e
X-MS-TrafficTypeDiagnostic: IA1PR10MB6241:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LUnqH6tioScPRRGNTcni7QFfxFnn6eHjp4G8PZtBpPAEFkaAMwcRTQKVziTNErmjPXypOXzFuEnaWnxd2b9e1rkeJrJeR9TaveSMa6gC6Q1HB/7jn69hhvBT+W/XdxSic53m9ZbZvle1OWYrIV/6LtAUuZFKqUwtHS2MGy+tqlsnDu/eq0SPjof8LR+8V3GNfULpEp3LBEA8+0jAZO9OQK/HRQNlNVphnzTYEOp8BkOOcVfUIqnmsg804mOApyk+gmpNA7H9cuIOgQSnt14n4XolXD8jbJE415KuMaRbLmFZuruUCap/fVHLlV+YQtOzsVmAXXqZwGFIHGgOCyBAVnwDpATPyetDdq/JT9hiGRNkaQ7iIU5I19dvpQDPwVTOKjOaka1tlRcwxSUfzodsAAV+5v9BdViMatyI5ht1/c8HzpB0CaBfCnaVyW8zbtR7uXf1GF1EAx8qXywnjv0txOINlrNdZGOEneFhTX7CN6oaaWkKy6/Rb3NTMBag50AZPM9eLt9MESmGS2L5dT0NJsem6ZNCMnaZN6DSKp+yximvewtssIXo3RhPbr+N62rVKdQvn15E9y5iEvlh5RbdgTakTW0GIAzWGRcKMqrHluXtKZBraItrMTgwAL2LqEjy3Zoryjg3zb4uW62fcZPzBQiB8DBeCTRcaYVYw2qxRnjo8j/fwUtx57uXpzQpOTJkU2qSUfmfHCahW6K/HE5fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(376002)(39860400002)(396003)(38100700002)(2616005)(186003)(44832011)(66946007)(83380400001)(5660300002)(8936002)(4326008)(66476007)(478600001)(66556008)(41300700001)(316002)(6512007)(6486002)(6506007)(8676002)(26005)(2906002)(6916009)(36756003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UIHnMvVcy1hLHbAjRDorLmmR+X8wWs0eY2OABv/NBA5Y+j122C8jmWAK4lRN?=
 =?us-ascii?Q?jg2que5VOE0XO5x32W98yyT32pygZQIoVH/ARDGMEz+la1otIp22TQWLdzGB?=
 =?us-ascii?Q?S57C/WTQf/p9HC105MHnD7tOLWRvhzEZaW7r6c72bVgntkTw+rFY8Izbk1xV?=
 =?us-ascii?Q?ShoRg3BqB6IcNssivqE7OY5yFQZfywCKgTZMr4TjbIWjKK702sM40FvvY5ey?=
 =?us-ascii?Q?0Jm0WlZd9z5L10vVZlQwyPMJvouVjssdkt2ivlk1iXEXgALbodpzh55dIfM5?=
 =?us-ascii?Q?gywUu+EEk2ol5p116fToN5iAGEHBEjfV/PlSZ4v1MMYVv9XmJmdPlZxpffjM?=
 =?us-ascii?Q?RXsr7yVeJw10JQpy0VULEktv2hlQ6C1gao/oIAlVSVQ9jgZHdOJL+x41oQDC?=
 =?us-ascii?Q?hNtJXZa/b1Us81Wuwe3TFuvZWObsWhRTjpU88PWH/Ix9IyxyfPftExPUZcRC?=
 =?us-ascii?Q?XAd7RIQ+9i4e2rj4OHcqd3/CS5Y5K3x2Q/uucvziTrfevCvX7JCo8E0uyVTO?=
 =?us-ascii?Q?C9xygOgURAWbUJjBKxfKjFu/FLCYMHv8nNokMnaFOlYH5ZKlQoezT8QYt61+?=
 =?us-ascii?Q?rMwU7x4dqNtrtq8fokBJ6O/+NNT1sq32nP/h/8goNWGbCgiY3shdRV+8Aasi?=
 =?us-ascii?Q?5sTx6AdOlulblnHxgpUlacEqH6UNP/92Xl4+5ZJR9xiyDzbuhRV1JFSDQ3tu?=
 =?us-ascii?Q?wPhd5tgL77bMe2EIKkLmD9CCdcibK3npQ0jsCSCi5Kqm2IdXPiZ6GqE9bRSb?=
 =?us-ascii?Q?HsuYQq0B6zgJM5+PEyjdrEyFeEwlEL121e5r8ny/mSZSKIx4FKsH70HGh/nm?=
 =?us-ascii?Q?5OCf7Et6ApMgxdnOPqDAi8G+Qbm8iSmHE4f3Z2lIYd8sfPWHOfmW8kZNv/I9?=
 =?us-ascii?Q?vQ9AONhVdC2AoZPfCQKspC0Ew2SdivHGdm/RuJkG1WuBRgb2mIATx3ltJ/cE?=
 =?us-ascii?Q?hUuYUf7KskRIs2r/2E0aitxgaP65BSBdrxyUMMIJVIKGLRDW1keTo/fAhMjL?=
 =?us-ascii?Q?Wcdlz0DMW5CvOUWIh1XkSWVQCepNBb+T8NKK07EcTspoJsKEksVYBaQFvHtk?=
 =?us-ascii?Q?KFPcHfC+moLxq0NKlnOVuU+0fTxjRlrIIaYPVzaagnfbHGcwdkjJ4HYdNdv2?=
 =?us-ascii?Q?NciOd0ZgVpX1A3hRPHd6Aw5UugtBQVVx0fE8TtPMGUEyrdmlS1L0w8h5HkJv?=
 =?us-ascii?Q?0wwPh6e2aSqdDWo0xbWFeXrNtfLXjJuuPDF5yxP5YV3QksP1RcYLguszwiwX?=
 =?us-ascii?Q?5cd9Qm13Td9wP/e706Bx/2Oj+KeH/gi2gIddhs2QC+PyMJR71aSuBNE3JP0A?=
 =?us-ascii?Q?n5ONUs4/UJJcPPhEb9+ROEdoLmzYqcRdCsMBqa1SIwWftLO+Qmmgfa527SBG?=
 =?us-ascii?Q?F7GE1/5iYDYSSTMh9LU2H7KAyvOIQszJRnxQOFmmO4a0McqnPo/O/qATL8ph?=
 =?us-ascii?Q?vYL254UbvvnABZK2ueGny0S7rkhxXN7Nb49M7td9/7Yvkz3c/YWVlOh7FTwv?=
 =?us-ascii?Q?efhq8zTLzBt1ULNb7J7u5/8LQnZSrS8moftxBu6KupqYdb4J9Axbg+3dysQj?=
 =?us-ascii?Q?1yA02iaInjBHaxfeVQBzGqG37NEWoL0wLBbaDnHG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vAChWquGtAXO5n+6W08vZjQELjSuxBDjxdEg0xmPHd+LDnLfKLvsPtHw1quuWgkIhXMP44L3FmBBX3G8D17L6TNtYo6La/AcqB68Z86+L5SRgjBBRkWeSGRaM6R6tMcublNmbNmO7DCP9SoWbXYjZFot0NSfHE8RnRrtIh+oSa0fnjmHDfY88h/Et834J4gcGbB0sz3Cz2jlT2CrQFS1ZFYJT9VqwRe3qZRq1G/d483tBMYPZlxYoI+JLiwpF286F6AHeY8U4jPuLn+KvOHSCpw6BSULR7hVh9Zgb6HafaGd+yJmVjnOjwd2r06y7Zfp5EB/8Deyw2nxq8GVqP7/jfrCchpklAc8O9KLKTJL5RvRlEvfG4V88zM/Db7xDKsDKtbmTsF/eHZHSaGgxFLBe1H8POEE4+u9yzyr+e2W5DVHOK1O8POZ1vbSiMGSoy3yZ+w6DRYC7ahRjyXGNuz/28DB8qZUDMwRAXx/CHLi4CbsKiy+6B3UVyNpT5Imsexc1rKEAqD7BrAbzeJUxWLqpCvu++tfKvjGMIymQ8vX7conoW6ZFGKc+0ZPdvRluwiMElagLmijAQ6l8P9Tf+LOqKtYS2DDd701BRQ1UHbd6nMaglTwFfvXAiNuoHF/E9IV9Ii6eBqd1VvRaJZljcl/YvuTsjd1jRUJDBWSISrGXFLbxtxaFJ37xjbQ61aWZds5xOZKKDedOFpsw3fIIyMNXNWavvrmdV9Y0HIo00wdpLcS88saQFE5u1afbe3o3ga3wmWL52ENBnNFYJBkwXr7Ar2a333LINdAkKJZS9B7RLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ed0cc9-181c-4871-6fd6-08da81b6eb6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 07:46:26.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZrrRHo64RCBpjUX+D+2/C9RvJmDgs0pKm7LJJr5LN8sFFMVUpntH3P1Ly2yJ6RJY1V513sqqeKPAFSMl0LOo0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6241
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_04,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190030
X-Proofpoint-ORIG-GUID: 9jukoC-nCMahxSOM6zy3cY5BclAXogoH
X-Proofpoint-GUID: 9jukoC-nCMahxSOM6zy3cY5BclAXogoH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit bf9486d6dd23 ("fs/btrfs: Use the enum req_op and blk_opf_t
types") is now integrated. We can use blk_opf_t instead of older unsigned int
for opf.

Please roll this into the patch
  [PATCH 03/11] btrfs: pass the operation to btrfs_bio_alloc
in the ML.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 2 +-
 fs/btrfs/volumes.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 19c1d4df87c8..a41e7c3cd112 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6627,7 +6627,7 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio)
  * Just like the underlying bio_alloc_bioset it will no fail as it is backed by
  * a mempool.
  */
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf)
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf)
 {
 	struct bio *bio;
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bd108c7ed1ac..d057c385f17f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -393,7 +393,7 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 	return container_of(bio, struct btrfs_bio, bio);
 }
 
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf);
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
 static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
-- 
2.31.1

