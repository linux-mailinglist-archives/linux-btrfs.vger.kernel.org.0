Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C419C769488
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 13:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGaLS2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 07:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjGaLS0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 07:18:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA86210D5
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 04:18:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VAiWqe009162
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=0iphXl3wszl2ZoFjkUmhEF5Ocf+tW1ckf0BXPRikpFc=;
 b=EVGIOgCZxXuKMVFLJB6uEoCt5F4NiG13mbloXgKCYLNyUGy28JVURWaFnWLOAcOJKAWD
 xvAc8pbmeWTzLk3YeQ3lk6c1DhHaAnhYQnkWaLLB4I3RiLOicQkdsppXwtH2oA5tkFM6
 sIGJEhQ3ZDWH4wryk8xUB2g9ZhXofa5mWUOX/3wzKz3SeRmm4LRYwvkvRlv/vOvaSQx/
 8GLw4RxlVmc0Sl3MmNCv3DijA5EpxFdDE50+UBq2FsjUjjeqHx3AIbqH3zNKH8D51TRN
 h3ITVC1S8vfwty+bzHCeaJpD2a1gPo6dRNGmOP2Yq1zU7C9v++9+lT4HmmfrD1Pr1n3Z Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uauta0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VB38U2008751
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7aw2p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 11:18:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H08Wic+bvDzF7RsW7e+yrb0CwnUVrP8fkQ0cym2gTXcncD7wgf/8yDCQkp0NdWFrQx2Lq5uQouCzJpNt4JxY8TmqSLAsAbgUoxhQNL5VfRMUERtQYElYCV+aCPj8y7VVQq+SzZMmfalQz838k8EH0E8zIFeOgHTAN9ltU5qM1DNv3x28ZlrkWkMe74O5j81Uz4IX7C9KGj9jBhV4ovO3tc7XLnigrUK3uPx+57WyuF5cg+PUP4dKkCBTxAVDi9SztX0bIdjCFXmhUOJqyP7Y5Cxo1np8BWtsGXoXnos9xLwnb6MyYEEsNKQlRKXYbU1qiM4NLEc87ZfzubkxrHw5og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iphXl3wszl2ZoFjkUmhEF5Ocf+tW1ckf0BXPRikpFc=;
 b=EMeGB7ZGbRLXplXY7TPvKlBpwQB6kEGdJzKv+KSfxLoBeTEAtronpX8igVhKbjZn3r37SV4C9Hi6j0J32iF7X6WPwyk41AzSvx56mRSBoqAa627vjdAX27U6lFRKoyZIZVi1ooeWOsWLubLW0QSPEa2XCy5si/WJgVAwjkfSVjXJvHpqRkLjt90Y1lekTqVCIsIoQ9tQNnYf7JxDOyT/7c9yHECMP50jrlA9LOk+Zjn2A3PdcFS90i/IUEufcWk2/H+e+XeTV6auy5WW4B2lq82u3MelBEpoTyjKk487ZLw0VZf8WOtfWxUjWpBcZ07jGA+TfBROVG+2KMtaux4oXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iphXl3wszl2ZoFjkUmhEF5Ocf+tW1ckf0BXPRikpFc=;
 b=AaORQZZV82FC1lHc8ZNmycSckm4CiUR4NsITxFYR24K3oAA4mm6l9YfyezXjAdIMMFpDSqPaIYhXccb5Bph0a8+XJ09wnOdCkEWOeO0MVCWcMueDIfvfk+ErfOQ+YyZ2VHlCXv3XifBC7a1vsYasbo6PZMfeV5aiKXbEYb8BLuA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 11:18:13 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 11:18:13 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 6/7] btrfs: add a superblock helper to read metadata_uuid or NULL
Date:   Mon, 31 Jul 2023 19:16:37 +0800
Message-Id: <5ab449690af1ec46c64ff6dad0d3702c5ebbe18c.1690792823.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <cover.1690792823.git.anand.jain@oracle.com>
References: <cover.1690792823.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 7840dd03-fd26-45c3-3765-08db91b7d43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dm3GE7OX6KoRE32wkXG9RYN+kL3xA8dP3u+FJ53Iv0PiTYtKqmtHe5hJSvTPyBjg++wojyPDKLb51Oe0JG/RYtwG2KBXNAEZe19G4+B3m8hT2tXg8ZTfLa/7Zy7KzGburtZKz7gX7eLc33hPUQ4KQZY3TdeODi2jiYeiRgtoz2bkEyDR36SIuB/Ck6otU8sQGH77aCtbz7z5y3fknkUsHa7ukqKggDfydF01CKXnh0HKlEK8HI6KxExf/3PYoa3yZY5w15v7nO4yxyxqmUtGY4zVKUqlglxq633jInlED2RuA5pUed7JQTx/W5Ab70y3TVg1IcEBFrGLhCH2SXyvriL7Lm1aYs113+CH71S/4vjLxenFTZ8TVjFkH9ggaTImt7utOoaaB2564MITnZligblBxEXVNUF1b0I0aBI2O8+Wl4Oa0QfTXIeMxPeO6x/fX8CfrLxYbyEnfDnwOqxMfm9glT7Z0dfWvjNCW9FIpLxd+Nb7xwf7ASjMuAfQcVaxCtTrvqkfg56steErDIXgD4jthsUgz8cPZOoc1K5+IQlDUI3EoFoTu0YKm2RhVq3O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(26005)(6506007)(83380400001)(107886003)(186003)(44832011)(66946007)(66556008)(86362001)(66476007)(316002)(4326008)(5660300002)(6916009)(8676002)(8936002)(41300700001)(38100700002)(2906002)(6666004)(478600001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2oQY4j6H989kgb77tTusqKbccw3ijDNxTAb8fM4U17Gsghx+N53MsQQb3Xn?=
 =?us-ascii?Q?IGAgj7EwTGAD6PJ8U7tezWv0pTgU1icI062Y+UTDEkEYsl4Edcu/YulMRKxO?=
 =?us-ascii?Q?NQsINBUWeQJJII1FoDRRuHoolW8RMFOGd7TzXDyJfEUQE+GnTbdTqCMfNO2A?=
 =?us-ascii?Q?1QnSZgQY0qpKgurkadF/pjHcUTumMNuBFvRaB5J5srjKC3YkN+QlLk471dmL?=
 =?us-ascii?Q?14M9stU21MfKOnG0SuwJ8dIVUm6q/Y34lgHovj+U9iTgIzOHoprR07KRWP8a?=
 =?us-ascii?Q?ELG761YfZKtymGVpHgUKim3n/p46ERhO+q2IJ3SwLQGHPswUUIjfpkw6YTtE?=
 =?us-ascii?Q?zie5fG9pp5vergRS48nFuqKKMiXTQWzoFCtEbaUO51dtzMf4sSNXiExWxkUi?=
 =?us-ascii?Q?sjMKk2cmbMWo4P8sQ+rNhrYtpbG79+mYGjml2HVmQIJ+6hWXl/CZ7fCSQMoV?=
 =?us-ascii?Q?itsmL3SdpoeoSErYJ2TiOHcylaG0FIVtlJPx5774t+/TrUuVyOvpUF6/2sP/?=
 =?us-ascii?Q?vDF/o7ws4G6sw8Dpp60MHq61I8x8nDlem1PrTZRFUVxbjbt7xRFS+i41cDEh?=
 =?us-ascii?Q?HIIJlxWemFvR+v9v+6wkP9ufNQ30lf8d8XPNIIGEQezjZcPg5G/4B1K9CD1J?=
 =?us-ascii?Q?YmaNuiZif8flY9iS6uQy/gbx5VD7XGLJLiI0dYYz94oxQKLZikBuDob2Xvvd?=
 =?us-ascii?Q?N4ObMnO2ygX6nI1a56uuhZdhtaT7E3rKJEULqSCSLkMJKHUg3CLb3BUsO/xp?=
 =?us-ascii?Q?FmObaZFWnRGdXChU9ptM7Ic+wm9Bgr38/RDuR1TXJ2iz4ZTCKJGK6ffcK13R?=
 =?us-ascii?Q?+oAM5vluAEzxnmpHy1L7Z2LJvYZokm6vKKWVjBq08LjsDGNVlk6+5FkRHQdI?=
 =?us-ascii?Q?1fEbwwLHe11amAZvMushRUAdkaRw5wa5cQxo4xghTzR5TkCDW4pBy+o3hl9Z?=
 =?us-ascii?Q?SgjhH6UqHTlpZMuMyqjXxWGmcTq6yBjsu1X3aNIEe+vF8Yz8Opk5D6QEfna4?=
 =?us-ascii?Q?84HJG9QR9NuzJE2r31EqUkQ63IaOw+MiwlOGCuMr5t4YRHYduo0FPq/uaiNe?=
 =?us-ascii?Q?zcxz8yM1nMyuq8o25RO5mCzKOfw97AtCQBGNf2mAsd/uGHO7dSGb0v5mysa8?=
 =?us-ascii?Q?2d0fA+aMIoF+NQ+hUYAyJSBlOorUZFjtSN9mm0RlV4WTKTXgEuDMv7P77daa?=
 =?us-ascii?Q?G0rHaoJ61dwpVLzJ+fPO8bWXvq+XpBKEa0Dt7wNkboLTGeJJ8NMQLCUfGDK6?=
 =?us-ascii?Q?9NYTLAr2X6zPXX7DCMOdmDyMoz5zdwGh4wnyq2PFEz1W50jAUiICrdFYnrnm?=
 =?us-ascii?Q?AXZnXlu9otkb4tHfsfo8tZzMrKTn1cvkJVPG4eMh8Hf2tbbCdRZnEj9Jrxvw?=
 =?us-ascii?Q?alcXVbr50QwwN2f6bKagWdnmcbH5+WnjdsWKqWjJeuXH4N4V2AfiA+8Aeb48?=
 =?us-ascii?Q?UGefQNq3jSRBOnPVLhw+epfqLU9SmttLJQpjqvqZHErsTAJtb1nOukGokOKa?=
 =?us-ascii?Q?DvsaJrN3lwnRVCoaiqzWT6gzMRzfyiNvLX/RI/Aw/Zoo0bkU1aAKzRBnGLoU?=
 =?us-ascii?Q?Q2mksvL8GuOJSoaC9MeBblQe1brXvZ9NCixXL6Zd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6JrlGQH1yqMZ1kh0GLD7Z2p/KrdVK4k2wGjhpZQkUFqPg8Mi4GsvR+pWjzUr1PTVeKheh19Ip2kPzcTsJODbrKDoA/zT0Oovw9ahIXZkBHh2SmaFJoLxfuPwnhohVmmVS0zbd+JrAF4QW+6qMn1qNQ1cLVCQKpMvIKR6Lz2ryc4Wvl26LkioBFz/cC3aSO6uRZzuZMzjFvEBPlOINuDjnHuCFg17gYatJOq4g3QdATs1Abwq7hYcD/QsFNmS3B94jxymIaW9iN/SwL1KTqFiSCYUBKDR/nzoRcMxsZpdqiIsKq4DzcCJv4kVVHsqzq33yHDaMfPdvirKaH58wQDhSEKJGh2B6I9BEVtuwc7WtI4leyRWI/UWhgbMA9zP7sRKImy121QHK5w+aPVYoyIMz5ArVxlf3GD2oNcQcnCw8BUfWSVvAC4egeuMjXcMVwR39bgWhKDz40JSQR2cbXgmtjZyiJWcEe71xi1aWfdjYg5FLg7tL80Hruf+2nWNSFtdRHCmzFIUIpFd2Zc8UzjnFFT5royPKt1Qa25KULjce+QGRQQwIOCXy9kRYyNBADhL0IrzEnhxjvlCl7Wffx06WKikBuZ2sRH8dyVVtV2XgkAVo6yi0T1a5D7N8KoZHaalC6bGsBxXpBdcU7r5iHXv5BzNDNGXgcfZneI24q80fTQ4zdvIRy7LRwlX4OWFBO1DL2sw5d/U2re9lfG0iMkRc+FQltzNcLWtaTLvX5XHLv3pTIJTQYhbyq3OBzDhhRrmMEnTdwRIYnLM5lstPajrNw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7840dd03-fd26-45c3-3765-08db91b7d43a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 11:18:12.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boCiKn0AS+DTLxV0Y0AuCTcOaT64PTbbIcAxH77LxaTaBF4PDD47tt5hiUH2n1UwWvPw+pymOVTEvY6xoosWKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6798
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_04,2023-07-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310101
X-Proofpoint-ORIG-GUID: 2hUGWJzHP76NRb8iempGAlZJq6Sdu4r5
X-Proofpoint-GUID: 2hUGWJzHP76NRb8iempGAlZJq6Sdu4r5
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is preparatory patch next two patches.

In some parts of the code, when the METADATA_UUID flag is set, we need to
use metadata_uuid otherwise NULL. Add a helper function that do it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2f470404ff83..661dc69543eb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -681,6 +681,14 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	return -EINVAL;
 }
 
+static u8 *btrfs_sb_metadata_uuid_or_null(struct btrfs_super_block *sb)
+{
+	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
+				  BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+
+	return has_metadata_uuid ? sb->metadata_uuid : NULL;
+}
+
 u8 *btrfs_sb_fsid_ptr(struct btrfs_super_block *sb)
 {
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(sb) &
-- 
2.39.2

