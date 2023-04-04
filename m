Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A5D6D6609
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 16:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjDDOzw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjDDOzu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 10:55:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA4D30DC
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 07:55:44 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334DuUgP017267
        for <linux-btrfs@vger.kernel.org>; Tue, 4 Apr 2023 14:55:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=uV+UzZUnPLSTyHAApaWwqKOvZ50RBFRipFuX+616ZOI=;
 b=tOMK5RGUQjKIIpZkMRsJeH1WX1P9JD/+0MuedLgHvOpUcJKcpLAhLrVSrlkF4vBywc4r
 bmfm32hSreLr5mGHYd+J3KSRzBCyT+u0wI7g/8Xwzrd8XufElmYPARUo7Q0rWvSdmhyJ
 q4f3YqkvGzJOQE4A4w9ZpBF0+Rsigv/4pg7LqN8q39DMSxVZfQ/igMH3MtibqiG7CHuT
 h2CkesKPsp3DfvSMuEmZYfaa0qkmhezAO7n54b3Vdx5FBnvAHRX4fAP/4PKVheyj4M7V
 HgbJuPzm3fkS96kdHtlnwwWQj98o9Moxiif4baQpJ+QrVIDuM9g4LzyZ+hdVcBW+M7kQ iA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbhbx1yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 14:55:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334Dfpwu002275
        for <linux-btrfs@vger.kernel.org>; Tue, 4 Apr 2023 14:55:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3h7nf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Apr 2023 14:55:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyxyAioI6Ak/hzSUe4MNfRJMr3ifNW43jYG+4BGPwkkz365cvZUtkvV+mrjpd+2Vzkc3CRmnRcNtynU4Uls8LR9ZZT+8z1unMMyI0FdySgdSrvxx67i3M2EHr+e499oQ05BjEy7FozucHSSPsyO2EQdIpTTs+WaL+ukjCJlA1hln+5IdeWMjB2RPODewtpixlAvoQEugHUj1ubaykkkZFXvtN45/rZqzOIoLK3oyprPjGEgyeORO0mfXlY8ftgv8dl341ZZ7LbGirlFDFmgqEymecFJWKI0GoMMMYOx9tH6o9PqvphfTG8GOkQBV9GPHL/HTl6aUe4FoFOUtH5+gvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uV+UzZUnPLSTyHAApaWwqKOvZ50RBFRipFuX+616ZOI=;
 b=RvqgHYPOjTR6/S9blOhDo/VVLSrEpdv5fkwq6Syoi9Ikp7U+X0aKr+QkbmJRu0rmRucfZP6kUlYOZqeG+mhaN7RG0eH2N6RbZ6M877SilEvSiBq2wzv5OZPnypLm4Hh+CS/qaUnJVMciEC1LEhUw+MFNlEqcsikk1ed2GS+YCYisTyro1gZe2/QRiA/qNIJcwX+2rjqyZzKfper8C5StrvktqL8o/YoYHpjurCbUm3IP4luUmkvx+vOgRMS/LycV9ajbg//mQ31/lMBhGOyVcdKoO6Uft4a902D+b3wxi4bnxXR8Sa/VMsAocnTnZRQNDTKHaKxZDyQ1JR6t0HSuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uV+UzZUnPLSTyHAApaWwqKOvZ50RBFRipFuX+616ZOI=;
 b=LOUYbsLEugySb4CiOB7KWX5FQu5DV5E6Mi4wSvGtJEm2IpYHeUHklWTHYcWpYBJpcsy+vIk2gOIR7afI/ho1RGB1mE6Ko1LqIGoBXuP0n7460e8ffhbEL9tQKpJfwzPbxyEM5sm9Gtvu0bvvr7iqIsvk9qTCNrT7dJfCA/r7YWo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5790.namprd10.prod.outlook.com (2603:10b6:303:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:55:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6254.026; Tue, 4 Apr 2023
 14:55:41 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 2/2] btrfs: remove redundant release of alloc_state
Date:   Tue,  4 Apr 2023 22:55:12 +0800
Message-Id: <b824ce907b5081a1eebea8c206f325d20d36e655.1680619177.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680619177.git.anand.jain@oracle.com>
References: <cover.1680619177.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: a821c8f8-1ee5-4286-c33c-08db351ca8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OOvCwe8b2N6NrQt3pvtDLtTriltETzmrrng/bAtndqzmI6+rJz7TPbO9+Fc/vp/uB2NTRhvARioVHVm1+NcerEeAX84yEkSTfUFb1mgeUheThclePuwaDz9Kzw9LaV2B3uAVdKuYH8vok+0PcTp6yzEXZl5osSxKElzvr9szcujjm9/6fnmUMGbjNLhEUrcldSrCtXV9uueBDwJPcKr5z5J8AMSqqNVT6TkXGamUc+szYazGtAMxJSDLXHZZiyg9QMLX6UFBymk9hmP+rgXmKLwDlhszOLkuylWmRBhsNYHf24X+sGH6vZiDo3iobx9ueCwMtHtATYvd+kz8Z8ezDacQz2BQXDRCdDm3wUVnBCl1iQHZ+z4TBF53f7yhSLcVS9bfIF/jgtpuZ3a6JcF3dBQ8S+VoZI5mWVjGknrQ3LQO49jlePzO0N/DUY2vwrd9DDgm42WSDQBeSk07lP5smSZpsMmggQsHWpc3EKqV5dFN1UtRqCMg50wO6Ize9vLHoZ16yBCEcCuFfAXXV2YoBAqXSSO76GwQohlPe+Fn6Wszru4KruxPegQSLfDym7Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(186003)(6666004)(26005)(107886003)(2906002)(5660300002)(86362001)(8936002)(44832011)(478600001)(66946007)(6506007)(316002)(6916009)(4326008)(6512007)(8676002)(83380400001)(2616005)(41300700001)(36756003)(38100700002)(66476007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qfR4ZPwpQWdGKR3Jwkk7Whan6rTYaKw18uDUvV7P1Sz9MbDm1uNG4BLl22BY?=
 =?us-ascii?Q?ZY9JGJapJmQrNiWv3bRRg4aafS6AE3sPumKFPDPjszmDcTjcCw3TQOltGBzg?=
 =?us-ascii?Q?6cjeBNjcKBeZbQ6JiPik3iEUIG1TP/gFPU8lN+h2Fe7ldFSFJuaTCEUbNW9r?=
 =?us-ascii?Q?9QOxgc1dLU9PMHaSd41CGEBOHEnyKaEcpgUlXp9ELR5ieHV2TyNTnAYETaP/?=
 =?us-ascii?Q?3M7vr0kznM8T/u9/YVeiUGfDWNn0d/66C0nbJnrAwoqI9sk51WEXM+shIRw2?=
 =?us-ascii?Q?VqWPHyGuAmk+Fjz1RNf1k6shhaqawHZGCStwhW1PT7F79PJ8m5tsHOksOJ6r?=
 =?us-ascii?Q?FrxrYQ9GLLaoj3x5Awkq5mGd4SR4JLzl1v0x7wQizSH2VrpPHRcnV4UFGiJU?=
 =?us-ascii?Q?J0Jjz/inYIJA/vi8YH7E7e0gtBymtbPTWf5RLQ5/CBJPTdm1ZpBFvu1B746H?=
 =?us-ascii?Q?TC8o17Deys5Ra82jXjuKkbshSNCVn2tIke9Qp9LhD/ikfELLIvOfgh4xNEJV?=
 =?us-ascii?Q?jyQLjKI6p0uUrJiMegqhMJpRABCZJJFol/LAk4Q0rO7P8hYHklYRhSRtHJOy?=
 =?us-ascii?Q?Np4d/rMAO/g0aEqtXfOPjSwCdSzuZ+onSEGULvDEOap4P7PE0/Mm+kRUoHBu?=
 =?us-ascii?Q?OKlFzZHc4E///5oVa6lrAFHCFJ4QYvXN9MUPZH9WQv2R0D5WLJIhjoR7IO8f?=
 =?us-ascii?Q?AWisftvHGS68nKB5EJfgyDSTNdKOfWcHP4Cp64ul97LDuYZcLYdX5lBE9Ryz?=
 =?us-ascii?Q?e07Lp246b+v9qW66/HgJh47D0nAlvPdl4R7iNgDcIyPWVALua1r+VlO94lax?=
 =?us-ascii?Q?T8Gc0m3mSWbrFmPvuw7CFdHOsWUFT2BXffxRE2JQLT1B897NDPNwwyXSC0I+?=
 =?us-ascii?Q?aUiRDEhqqSQoIpkNJyaADuQhgzMj7eXWNYOD+Ocus+lxu3cNiopDaqKcVmxs?=
 =?us-ascii?Q?5vM07wpW2G21xrzVOWXIhCHQ/sQVk+XJToC+drZuH//Fkd9IDOVXcwYK+Mpu?=
 =?us-ascii?Q?5pN/lEjj12aVLXBn0y+aTFjODWXHSCE8rLQPc2PSZFwB6FUow5ycFz7TscTM?=
 =?us-ascii?Q?qct+LGR+RVgnck+rBOVN7QktK6yKqcRNKlksb56ywjAvUgs/4XAOKQlOHUOs?=
 =?us-ascii?Q?tkTQ7GLPGRzVDc9djQ8zvwo9yP24irXPS+hTv51trv+3hEVJ2AvpmzHljO4r?=
 =?us-ascii?Q?KtutMX1DayOWZYG40tKEZNiaKgx5SEfQax3YCpj1d/tY00hIeC+5xDT+ZT7S?=
 =?us-ascii?Q?9izQ33hxxNCuhcp756TZAcml1lCgEZz3byjo4sSkZQ3pa+MvMwBZxt0DRLyx?=
 =?us-ascii?Q?mdPbPnrMdyugA8QmnOrSbEmLk4f2WxtuBLQf9PW8Kjpfu7KtIg1BGEnyu7G3?=
 =?us-ascii?Q?WEU0j8GuMvsrBaYpU8Lrxj8OBeElcBXr2Qodn1wTowv5CUDnjcyMMUmILUfL?=
 =?us-ascii?Q?4JSoZsFX24PSsKw5dED+vEvRV3YHj/hNp2xpL1Qfb+cvZWxYzLSu8Er88kTq?=
 =?us-ascii?Q?wUUnhELugzPKkymVPycgf+73iyVEOPkXH2FOKObME3D62s7b7p+GNM07w25O?=
 =?us-ascii?Q?QNVTtPIGYoqgHMDurKCc+Y7Oh0k3mKCSqxz/4oUy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Zw8PMaIQW0ptZVvnz3033o626J4KrETXliBNPtINs1CcDlujHiW0YNeOYvNq7gnWPs/0H4Qj51l86FZ+EFaKvy/9DCLpwaKn/7Z1YRBa/5hX+n9AD9luQDvhQuzmw7zVdCkfAw7pIvKmOT1PjOUXesT1tT7JLfmA2JMT+0mKDnBoPKPK9Xio822TynbbPO4WNco8LKfrjA/FJYr6++D9UxTR9mTegeLMx56t7JJk0wGfWV+cWiIx3r7gB7BH5yy/iKnVeriw7LbHvCbVZLnv8jtWI6R0LczxC1r72/KJS+gQqMt9D3z0LAOGGhwWhDtcZIbX3t0BSuTVh/Y26WhTOgY0570Hr1Z3AX/Z4hPAkXc3hOVgvYVyNjlQ1Y49dUVT5kXfsMXpTRbtrjRqPJTE9Sf9qQZu8kc3Yym7W3SID8ZIHr/bsSu8UGDWl8Di4lPsYnJPZ8Os88yryAycCe1kPi7RBO8iTqCsPgXmXavkGvzfuV6vuchCzmou4IahJ7sNzoSZTt4aaEGKL53NBkx3a5HVFhDBBQj/giZNAwgJuZHBaBPvDKHN44DhR63yv1uFNlftMpRNV1Iw3rbcu+e5hXZajLQqXss5SDGHZTzvjVbr0EveO/SlBX7CIpAZWWTOuAQtk14sHgABjj0z7afney+WlvnIGE7qlwoM/3euF2bF6QjZmodDLObDPQ+PTOBxokRTtVY7C4CnMIEN59LTO2PVL9GxC5Pr99G5FOwL4VcMw4dMxhO5412B7/40rzg5
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a821c8f8-1ee5-4286-c33c-08db351ca8b1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:55:41.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6etKEWQfN8m8870eEzaGyumkjZHNtDX1bXw/SCRZjzPIsEskd/mSfxLdFK3GRDDrdpkuVaOfnvaGCOx3rWhchA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_06,2023-04-04_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040138
X-Proofpoint-GUID: Hf6TMAdhWYV1t6O7fVOE90dmZ5N_C8FN
X-Proofpoint-ORIG-GUID: Hf6TMAdhWYV1t6O7fVOE90dmZ5N_C8FN
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 321f69f86a0f ("btrfs: reset device back to allocation state when
removing") included adding extent_io_tree_release(&device->alloc_state)
to btrfs_close_one_device(), which had already been called in
btrfs_free_device().

The alloc_state tree (IO_TREE_DEVICE_ALLOC_STATE), is created in
btrfs_alloc_device() and released in btrfs_close_one_device(). Therefore,
the additional call to extent_io_tree_release(&device->alloc_state) in
btrfs_free_device() is unnecessary and can be removed.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0e3677650a78..c201d72f798e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -395,7 +395,6 @@ void btrfs_free_device(struct btrfs_device *device)
 {
 	WARN_ON(!list_empty(&device->post_commit_list));
 	rcu_string_free(device->name);
-	extent_io_tree_release(&device->alloc_state);
 	btrfs_destroy_dev_zone_info(device);
 	kfree(device);
 }
-- 
2.39.2

