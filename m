Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6B670D9DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbjEWKE2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbjEWKE0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:04:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570DFFA
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:04:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6E8Fn018876
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=wDFkkPja6zb+0DI10NIYa2N70njoA5Abmu2d314yNTU=;
 b=MOyxubK0zWrty4G8oXBEtwcmPB84IhCP8FQx1fCRHJhaj8ioFKNE71Itko+erW9EBv7l
 ofWob1xi0SLcuyA2bdvjZ972E1LB87u13ontmd2va66dFKHSib5TJgRxN39z3r221Jpr
 nKkG3b0TlxfpDGjxobJ4ozfrklzenb+SLjF8tmshJdN21zxOm0S1ITBXMTxJG2h3xemB
 i6akZdaFIPbVJw9sEhcn75fx5fcem1/DpKX6vqFpgADZ/RIz2LiXq5JYZJ0des6GulKQ
 qOrXCgwUX31fZgSPquRnGgMyVOOzRy8VdYKg3PycMwziPE9ozRvt6j6E+h21b0GWqqt1 Rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp3qmqjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N8QbHS027108
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2dbnat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 10:04:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDeEE8q1cQu/W8Us7KPbybBliT7q2QD5E2m0zMu6nVigSZ2iqEt3EYVhwiZ9guuTXaAM+C6jGP5GdXbY15Nx/iV1R3sUP3r9Tf8pnYn0FBhdcrbEIceJ8XLjmMV8i9eWu8l5FvulQfWpfGHN8t39JnjR9DKE5LdgDfFqeNneuE7iAPzq0mCTuNqoj+8NyhK2ReYWGdDsXWpcYtQvn7P3ohIaVPjpruloXtk3uvIikl31HN3I8R+6X7OhsO65DHcU3QHZSJCfjmfg2r5PLVe1bblX3C6KM998KC1yhOfc6LTkbnO4SbZXHcz+6Y3kVD10nQyA/uk7IlufBLETNcFwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDFkkPja6zb+0DI10NIYa2N70njoA5Abmu2d314yNTU=;
 b=AsQS+kwuox4/F+qA+Xo5+G8oUJBKkT1C4FsJhfbj4JF3Fttp33/S8+2eEGxOzewUyloCXmRi2RIWynZaBXGyCJHSm/lwI88fyzGhLMCB/2k1h8iOH05h4nNUkvDUpFXqu645rD7JNLC7M5jrH9iXu61JufRVC6HZUKywc2rt8N5kELW8vD/nzEsrEiNV2xTfpIMSzlPQKtXcBc+l9bZbsAoia2CeS+R2M5H2DpkP7iNHSAfComtqLbeprmr/h/qKvsxRk/HodA9RMZUNa+/UwLSRcI2UrKpcSO7vJPfK8z/e4ZBU65/eNngujIO4o0m+0g46sQHAqGh8xyLeTa8mQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDFkkPja6zb+0DI10NIYa2N70njoA5Abmu2d314yNTU=;
 b=AfDpKWgC0E2lk9Kz2N05m4JObRT/mGzOKHLNQmvigWYfxhGi+w+rXQfBMuXlX1/p7ZTrG8aUpNemyj7JEhqI1YYL2oQi/PHS0if4mnTG+04DqkbLv8d355UtgVqtJ0KTDzxL+kC67P6qysd4e9jwZHv9KG2BQBjUS/I/ZkkM+x8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:04:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:04:21 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 4/9] btrfs: add comment about metadata_uuid in btrfs_fs_devices
Date:   Tue, 23 May 2023 18:03:18 +0800
Message-Id: <3ba05b04df59f1549a3026326ff4a70d6abc302d.1684826247.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684826246.git.anand.jain@oracle.com>
References: <cover.1684826246.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f2aa1f-f345-4b53-e387-08db5b7513eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a0fNkN7mePtWws+fUt+0iuA6fkyGswrDjaWTFXo1hpprfmp6+Wc+i54tj3fyv4DhkkcRwqQ72NIJFTGOTu51XUw7pvuX/ajbyK43jcIDOR7VEArr1F2JMqmhgoX5lpiVPF4o6o9tZcuqoMArfN6hI1cDzB3GudJKT+PT1n0FFepynLhbGZ1ueItxXjtMzAcYROA3m4pgXHqoMUEO1D+PbaplNmgeUOqPJODan0I1PKvF6FGcntY6e46G/VfRepHg8+jxmrAOy30KQH9UU8bL9JhD8VsP7CqrKDdy+8rLBT1lDs0+6ZcQRbrhFCjNkyHpUkGYX53BC50f/xdgqP84gi8lh+1bLLHxdwnnJQay0yR3+MmJps/eiOAalsdkwVUGEZmAX18nsXNJlApAOI2xhs2d7Hu0q+lKgmBc89w0aTY8aSC/6HNqiodz/JpxZ5shsmHeD+xbqe0jwKgmZqJcPCI5VvWK1+3qRwZ06/g8R9x5JDvSxOyvP0Ccd9Lvfc7it3RfgTJ3dEWQo3JmJcSH0TxERNz2C1FUL3jB1cy2aP+1lGY3LFXdn6bXat8xUu9/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(478600001)(107886003)(6506007)(26005)(6512007)(316002)(6666004)(41300700001)(6486002)(66556008)(6916009)(4326008)(66476007)(66946007)(5660300002)(38100700002)(83380400001)(44832011)(86362001)(2616005)(8676002)(36756003)(2906002)(4744005)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hq0DjE+sEAy/aYsu1CCH2lOcZTtZjhjpIF2s9fWD6haVruWfEUtCqcyaNMd2?=
 =?us-ascii?Q?HBAUjc8MnkW5W97+IR5cuHVtzVnSzDDC81rJCq3FpsFe2k5kHzz1gwf6eycQ?=
 =?us-ascii?Q?dUJ259G1D5yTkKUMXIEoOtMGP8KxXXJE7Bmmg+L1d6pweXhRNPXqffNl0896?=
 =?us-ascii?Q?nOHdIC7hgs8fFw53/8Ov6gFXAIvz65MZku3tjiDfUZXgnS87UzlLbUW7uScL?=
 =?us-ascii?Q?u/Hs2JIM28Xy/1FbwY6eoFVQCIeZ8V15NXluZgOJW/6zX+LryWJkBUpjWKPn?=
 =?us-ascii?Q?nJWKvZgSHR6Ii6OBCKbHgUqNvMEtf5UL2Q8ENrteEGyayOHdYDAMfnceFbGJ?=
 =?us-ascii?Q?6qe4zxyiJsTs8mPLrydWrjcWCBfzHZCoKIgIrdlM5jsxOR5C/r5El6d2fWGq?=
 =?us-ascii?Q?3pOAW0V0lJY5XCTssuh8Vx/HmbjuqJRIuIa0w0m9QTi6h8cWTnI26bPGmz2F?=
 =?us-ascii?Q?IgaQOrzmYw/JKV4a0N9SaN4wubmzM8E2lpzmffDRElKYqATIDAliEZasdkpA?=
 =?us-ascii?Q?jWr7gso9ZJ5aul7t7oEmdzf2vXPP5HdzYAUppPhD9t8Z7c3i5RffN9jtkjYC?=
 =?us-ascii?Q?2bg4gfQsKhsdbPsYnVV3cNCK9GC631zd27UV+buoeAGKESebYZ3SbVsIKjPz?=
 =?us-ascii?Q?MxESuXkVsbvzaJ8icqTSCPz8BLen7aC3dKvg/NKlNMur2IlqGLDbx/5U5dsb?=
 =?us-ascii?Q?xeEP6y/7xgTqihCNuYDnc2CbGI+8xjfI0vbkqJFXEJOOaAQFLy/aipBFeiuK?=
 =?us-ascii?Q?7AbF174mLsXIyTif8OjqQWuGoZL2SxyJiPFV/J235SYzi2d/DcZ3mHgwXkhL?=
 =?us-ascii?Q?84UddgJF5WP9X3pBmL/Uf8Wy10InLfFQj0/7LNgfVfndErtR4JIgLYVONjIK?=
 =?us-ascii?Q?X9ROkA5X9aAZmf2gaIEOblx6KLIP9vlsaJ2UknzGJQbiK0ax+ueMAx3PegsD?=
 =?us-ascii?Q?KD8pBnfIif0NVTK2Nid3Kn4LJjQudQs/jbmP6au82rl1smzS/eOS3NVF82WC?=
 =?us-ascii?Q?mkQYJtt0YmS06dr8mL9f1N4Z0ATNqA+oznloMYCQqIYZqv9b169VsTpwu9Nm?=
 =?us-ascii?Q?6tC/j5lK0IDqiM+TTAuxwHMlS5lDJZhuLY+zbqBwxzJ2Zk2YogZgiKYUwC9U?=
 =?us-ascii?Q?i0J4at8ZBV2tLEjPIExghppGstH2OtC+suYTLmPhj6bjSsRC+iIt7+J8s5XX?=
 =?us-ascii?Q?sNesQ7mHiT14r96sGfRQlopFB5k2jKjwx1pCwQRP2bcB7M8Rpy8KPkYLbvki?=
 =?us-ascii?Q?3GK3RYrLGIwE5XN2L05sAaKkMmH3CsiConpI32yIE0okNIOX4Vei/ggG+slT?=
 =?us-ascii?Q?A8WGd5+rb3SHCAClbViS7IGdJXkMGGOF/NkAJmncE3gvwrXBnIvWUSEh1e5W?=
 =?us-ascii?Q?Kh1dBjRGLRXQJaJfV7sxGhOwXvqnwswjO+j/1z464wTWOJWXyeMeCMzYa7Km?=
 =?us-ascii?Q?06d9+Dki+R4r8k0Kbrp9Fj5ga5/6xE9McH4b7dXvF5HX+q34EaYD23oSeH/7?=
 =?us-ascii?Q?cOhfkS+3yyCfXeFDb89rw5ZTC9Ewrx4jPpHj0yfHg94AwJEFFnKp9E9vETQn?=
 =?us-ascii?Q?MBNClkcbHZmJ0skxlv+047mfC5XjQwG71gzvW41z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6vL3TUjF2/PeoU781yvndLOJc9Bfkjx5PhOoIaeJ90sSt2jUL42ELB+SwzsRirwKCwj2i6O9+um3+9a8gJPjfYCAMbG1PdZipe14zQFBIQ/MFnh54tvUK+HUcgdmg9v/NbQ/rS+Ee3ct0Zoru+UBTkZnCWHdPtThvV2OVTEgemYfsz+Wgd/DnO5Qplb4lj9G4ukc53/KTrvhblJn8ATWuhJRXkvcOJRoWNESKd7o00XuYjclbPAXaGjO0to29uMrm/eM06PIAA23WhzqGVUu1ncYUY9NqahroZ7/4WuPqyoBvnmPwFI9hjkoK72+YbdN1PyncQ/WaW6b++K8Ir7lnF6sl/BEZ6SHp4INAd6ZsE/qp+gp2RJXbrIjQDk+ttas19eD9T4Q9vAUlnx+lrcoOrShMcaOvpuqoRKrKUhWpAVWWUn7iqegT4Hz1f+mUhyZYTI6ofD6gA342CnzQRTVeThJF2KFbBlPAOb3D1wkIdHXSWxq7T1/3X+rgsOa6dc26ZdWeT0SXiHgtnmZlJQcoia/U5Iqvh8f+w6EWf0PeNZONJ5wMPzIwND/34pX6cqXL2HpxCi9AgnRv5jIn0tN85qv53ugSZmZIgi/CKn2zB5+IMRt7FJNEfZUXMIpHVGkeghXCvnMNMOaK3tg3gRKRtsRCN9j5QnclW5ZpUtP2eTp1TZ0g6JKXqmuXH9USiWsIEsJfmoutg6ivlqXtS2xoYLHQZ5+Q+FBVRZqWpYnEJI6O07sO4kFOQXbi/33CWepRRbOPWhXngNs+ODYs5RLHg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f2aa1f-f345-4b53-e387-08db5b7513eb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:04:20.9827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5yphP9SrGEx7EeGkeIQCjLrClW5PHZYOUv+j6fwER/gICS3f9ZbTW4BFFEJZg11hwxVHxlGdo4ECYLeu5egJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230082
X-Proofpoint-GUID: aNtLWCxhqugWPNFOFERZQBet-vXZlbWl
X-Proofpoint-ORIG-GUID: aNtLWCxhqugWPNFOFERZQBet-vXZlbWl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add comment about metadata_uuid in btrfs_fs_devices.
No functional change.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a9a86c9220b3..35d135bcdee4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -280,7 +280,16 @@ enum btrfs_read_policy {
 
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
+
+	/*
+	 * UUID written into the btree blocks:
+	 * Relations:
+	 *   metadata_uuid != fsid must set BTRFS_FEATURE_INCOMPAT_METADATA_UUID
+	 *   metadata_uuid == btrfs_header::fsid at all times.
+	 *   metadata_uuid == btrfs_dev_item::fsid at all times.
+	 */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
+
 	struct list_head fs_list;
 
 	/*
-- 
2.39.2

