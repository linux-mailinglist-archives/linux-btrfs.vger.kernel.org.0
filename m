Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C8470F5D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 14:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjEXMDe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 08:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEXMDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 08:03:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDCB130
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 05:03:31 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OBx9eQ011561
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=zYogcXFnOTNkFf53H8FmBfojrQpj6PpldmuKHtyls+U=;
 b=VBc5fIkkoQz1c4EZmR5peqnmjqi3sgvsFf41sitYmmpX2vUZjviTuiUgPNNREVAfPGmv
 K8xi3AatPUNgaVOpoSWvRgiGGAZW9QKDp7hUy9RK23FwipbAp1yI4Fy3Sc3Q0zkQRtDf
 NXcftihJktVJXzvUeAwr8zuN28MBZbbwe/IJPHmhoGBl2kVjCDtWqIHwfw7aYdKE1VG/
 nwlHO3PbCwMxmRNAkXC7TH2LgYHezBwfLRe+CM6puUd4ZapHKuo0yAqJFckOUFWTwag+
 xAnu7WcIf1ssySrfMeCMrrFqLa5Wz+mXlXPfYwQW+iPoNnZmLPQl03LHBsTOjve+Y91G hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsj2bg0nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OAHjjq013202
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7g5u59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 12:03:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eroB59jh2A33HI5grWzCi7o8nElBb2Bb1IEL/oGrMSNDF4Ajs5xYi52AB7dgh1umKH7hnui2bPVG8znRv+LLzgh4YEwhRk/IHD3GeFgEwL0fwrcRj3/GLK5vt183MJMpHLfCxOLg5/+8by11A7LZzzJcgpovXvF4smLjgSHwCvab+3X+0CIabcK6y+tMusZXxk5edZx12rZMgog1ZKxzBBadJMZnDADmiAu/iSZjs7hRiER79J9lS1Ha0UYS72MSCFqdBxmJiuy4iSoFSfvw/bBy6h/2xu4UjfFE3tJfVqfGX3fLeoWlAPRlFmMoZZ0OVzvKdRkwyARYx6iYUiVYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYogcXFnOTNkFf53H8FmBfojrQpj6PpldmuKHtyls+U=;
 b=R1D9Gf7ChcXNqEgmobzZOO7JzpI4DHAU72x39QdCbSX1mwvT/PtjJrP5qKEm9gjDd3hQXw9IDlfxstB6U8jrIGTAjxV+YFBfojsNYavjbk8soTW4nbmfzo0nyA28ZtsiEYLH2GFpUkiiWEKHhTO2YwTc4DPY9ujZWBOhXE8tKQ8evEqETB5hnsGj47YVmIEXqNwBLSmFURxq0H/Ej7vFDQWFAboj+XerhmeuLbco49Us06gXzP4B8ABRNPX10RH4lEt0wPTvTFRCLQ4KEKaUFqYC9hOlwY0KQWfYzIMLGKQv8ROK1forbK5mPpQ/l7f1bXpnEW/cu8onIZFXcyRHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYogcXFnOTNkFf53H8FmBfojrQpj6PpldmuKHtyls+U=;
 b=LoI8G/lf7vUD6hWiPHNAQbLxY7tZd6iTmCg09hpfjU9TbgwjOFd9oQ+VnJ7db2OlSt19o/IgtrlDO4upWdZhkjC+pkNIBYvnMfNS31MUr9GElcwUQsRuLu0v0RWkyFelCfU7aSfVNE1Vd5jfICwytJuHLd1uzgt1KiKUYyCOpyM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6893.namprd10.prod.outlook.com (2603:10b6:8:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 12:03:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 12:03:27 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 3/9] btrfs: localise has_metadata_uuid check in alloc_fs_devices args
Date:   Wed, 24 May 2023 20:02:37 +0800
Message-Id: <e1d339629f44c0661d8129939d26f18a5b49da6b.1684928629.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684928629.git.anand.jain@oracle.com>
References: <cover.1684928629.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d78e13a-2728-41c9-d207-08db5c4ee1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kuh7fkUqW5DXB45qlUSm96+RlvYuZdwvWTT3O62chEZiyVs0KMSHy4Ks7ZUyt02jh9Ri18JqZ2mKQKRgBooUKMIjAwtpWSsQwyuWePHT/oz/eUtQlX515NMblawXCHs5GwlNPUq55euBq4YJBz2wJ3v8lTigdPrssVlDNCiYrLGiHltfIOX/HAIhASHIKKEUpifJEbOw7z2dqSxfoQScndJ9FBwJg4gyQpiy0Hw3E8jkspcBTnC9CaftotL8EzBO7HPuSHpGLqcHcc4KIvViDgxUH3xvDAGDi2BRj94rhiHScYgqkpaAJ5KOVHtl9lG5//FUuXCzk2vsY2DnggcWo0QKPSX/gLvebJIQKJxbikCo8f3dbhkX10f3XB+PWu+5t8lqv9+4jd/T4zXccZnQGwvPCsHO1MGRLKAs8E3PvdGazOBynZq/+Rhpv6gUhJRN0S+XNa64ptrSDOZFs529GY6pFIdyXa0RLTwXudNWkSy/eJaux75b4LNNPwDgIGlCheo425TC8f1pOzEQIxo/H/2LCnLaYhXjJvqDlA6ePLCY2fq/XeKcBVgj16YCUSBA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(38100700002)(6512007)(83380400001)(26005)(6506007)(107886003)(44832011)(36756003)(2616005)(186003)(2906002)(4744005)(316002)(4326008)(66476007)(6666004)(66946007)(6916009)(66556008)(41300700001)(6486002)(478600001)(8676002)(86362001)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yOuZCGTqDiELmys9OMaZFYc3FC4SCR8zflP1Oc5qTc028tmm2VhrVu/AfVGl?=
 =?us-ascii?Q?bptoS5WR7WeS4nDeLVLdWphxb26bpqgQjRAq88owYI6T37ABfMKfWUPavUve?=
 =?us-ascii?Q?6SQ11dbTd+QZvc6Brsw1bCLcsFdywWZap8yJfbGextt+5+iZFmjqSQCMwumz?=
 =?us-ascii?Q?u5aJGoZDEg8UJ7XN3L8CSyy/R7SHOGH/VEPUCjW06bcvbMvxIkzRrFufRkk5?=
 =?us-ascii?Q?xNiUBvbzTGgeM8S9hbasJnmjPFVgDGfngE0tmOlz0294kNNs3cTD/dKyxrAd?=
 =?us-ascii?Q?abxQdHovt6jevKKgbtUnBTjd+5jLmJVsG3Zq6K2kgrkVxVs7eLg7481rxBBf?=
 =?us-ascii?Q?A0FoouUB6WeoZsfc55tGuXHipTh6gmOo0LsV2fLB5TP5yofq44kEDuJO2Dvl?=
 =?us-ascii?Q?AmVVuf7Y4KeWbivH+QiZvk7jVFXnKkqZGR1CaQefUdbSYKOwTTabBbJ8z9cg?=
 =?us-ascii?Q?uO+WA+oVIjGh3I7WtH8FqicihwH4WFQ8JizDn7iA1HPF8GCNK7O34dzEU056?=
 =?us-ascii?Q?v9EV4ZZdLASVtMlfK3JO2CMJsMyye87A5eEPOZABkD7e7atu4wq3loT9WtfN?=
 =?us-ascii?Q?YeC66aUFX0dYWHrYrceET/XmVXHeh7D766GIazyphgdCyoL/EmGUSaHStACh?=
 =?us-ascii?Q?8OKkKpWnohtoTliS4L1aOAELpA3LfgIU6Ntn5XR8/oSR2DPbdMZFSThp0e7b?=
 =?us-ascii?Q?JPtE5i0ZH0jTIigroieQ//y6oD79lt1pNmTexpt7wef2T/Vwh5dMAsujzYOL?=
 =?us-ascii?Q?/sELv5N8k28rTfJa1vSMSLRqzlHdb5KQVW4QQfOpb+j1Q8ADHivPoNnIh8Oa?=
 =?us-ascii?Q?43P6jrF0s2Lt4fje9cizaI10dmno3TSTmVMW0KFEkn6c9mkQ6Y+QViUiKBSX?=
 =?us-ascii?Q?WyTRf119XvWSdU261Kj1jJbr6Kc1naJ56HckbhRjrY83mNKgNSVUsfGBnnqv?=
 =?us-ascii?Q?WxrgBCsSN5HWarDnEeIVb5B8jpPbdQycVEW/KtmxWKr/qSxboTSVzJDar4j5?=
 =?us-ascii?Q?lz0edU6hyIROJXIjcvdAulDHY+7DCwkSyXoUjIy3khWMxnHfX7NWIhWuaOo6?=
 =?us-ascii?Q?ww/9Bj7LzYRjYkSDQBU2mS94xTFMIMrs6sUEsIt+HQtrucp/EjNNPFKleB4Q?=
 =?us-ascii?Q?gGHTceMZtiSjCog6G8h5eWkuKaKm5+BM5CtSIZBbd4DprIoTTadlZ/WCVfHp?=
 =?us-ascii?Q?MLxAL57F/1tMFRD4bAbxAHCvvwH1aiIEurHbsaje7RwkSa6FXisqj0rsTtfx?=
 =?us-ascii?Q?oyGikcxEsG4brEznzpUvf8yhV7lqERQoPw/dnBU0oZjxJAeb/1rxe6Y0j1F+?=
 =?us-ascii?Q?7m7UxdJS+YBHgr7CmqV5QiIzpTCMj1YOeWWhV2bDrAegACO57ENM94mpOUzm?=
 =?us-ascii?Q?cayfpTH23V0xlLCkz0WQp6F3NMRgVvdjKjlSWqEEn07erO+lLSzSE28a2c3g?=
 =?us-ascii?Q?KTGPELPrQszXkY55yusITZQBucm+IJnjsY3R+0Uf8/PJOoc81MrOa9wEygPt?=
 =?us-ascii?Q?fDXEtu+Dpc6jFL1U4gt7Niakl5f2UM+dodNqdajD0G6vXnFOK7J3rbWWQmWX?=
 =?us-ascii?Q?d+eFthn0bmH334aRyvnlHpmSJrJgb+2sfrUdrg2qD2Zj4+uioePpCMpW3+bc?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: m1O/VgpQAgNUdaQdPXTpQ5iYdZn67SDoAiebC+vaCIVIKxoZ8AYnZWIYEC73SvsItQ7RdxSQ1psXyWmzUHREbT73ASexPShBMXm/fdxQHcvF1akaX6IERbadfRt2BeXI7GLSRBDPP65ldFYx9raFbkDehBLhm86fJHrxR4qr+FwU+Hr4j3ghrTMc5wsRu1g4fE5jySGGIjKeQYM6XrT9durBdTJKd8j4KezQ+VpzlBRiA3H2Jwm8BxqqoXOshrx1sWijfKeX265laxLfxwUDIcWHLDo2d4Zbiq9VB59y+HTdPB1PEi6c4CFFhGmo+AhUFY2E2jYlQYdO5cjlmYgxq7UtGV4tkrqnMN32FbmgumcmQENt74G1XTjlxSN0Ll1HGyFl/km1ygdB1fQ5CTsylwqHb0Sq6J0/bXwYe169GZnceuPTXi4ywxiq6hOFjimIHouF59IIqkHm2IXte2NrK4nLPKvDNoztbychZTAwN+0TURat0YfhJUJBuPWIWqFQ0Bk60m5id9ehN7W4zNLweCzA8BRSWzQoZ9T2qKnmV9wj4IMJpLs9KHhwkQlxeyp7g5PZ/XCpztQvjMcZcy5ppQ+OMX5gV0tAm4TQg8cTvpc1wU4jMmseC0leuGFmvO0HtY9GAUAGbFyRDWeq5v0IACF+WwHsx8pnEPaLUfaT279VC7Tq9AtOfAxLisrFJETri6tnOq5ASpQzUFHxEIrcy8na7KFgPoFGdurp9bdTsJ/lsjWwetPsKUAix8MskmNXFhitC8s1bcTbip1mtmmQQg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d78e13a-2728-41c9-d207-08db5c4ee1f3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 12:03:27.2198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1J+5/RP5ixEkBV3n7953Y9LZ/9Ly+o7ehwP5lxQ4uciPoJ4L7KkEXtFsWVvXgTEGFwX+/7PIZSn6GT5UPvhnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_07,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240101
X-Proofpoint-GUID: KzSjGmivGhRxyxlqJx1AhlttgoQJRsOd
X-Proofpoint-ORIG-GUID: KzSjGmivGhRxyxlqJx1AhlttgoQJRsOd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Simplify %has_metadata_uuid checks - by localizing the
%has_metadata_uuid checked within alloc_fs_devices()'s second argument,
it improves the code readability.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: None.

 fs/btrfs/volumes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4b35b28c8746..f573f93024b0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -791,12 +791,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 
 	if (!fs_devices) {
-		if (has_metadata_uuid)
-			fs_devices = alloc_fs_devices(disk_super->fsid,
-						      disk_super->metadata_uuid);
-		else
-			fs_devices = alloc_fs_devices(disk_super->fsid, NULL);
-
+		fs_devices = alloc_fs_devices(disk_super->fsid,
+					      has_metadata_uuid ?
+					      disk_super->metadata_uuid : NULL);
 		if (IS_ERR(fs_devices))
 			return ERR_CAST(fs_devices);
 
-- 
2.38.1

