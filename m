Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEEA4333CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 12:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhJSKqJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 06:46:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8672 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234955AbhJSKqI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 06:46:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JABhl8004726
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 10:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KvN5DcEbMygx9e4FpkCSiHgm5IBf/2dBm4TB5EiTMTc=;
 b=xI6JOIbbjYakkQufqiot6LLMD92v6zzxtbg/6Er3nyO8TIdOyf65RchJM8FrX/uI0jwL
 9DKTTr+xspiujvKcm0DCtUFSsfrF2jqpx/Z8663Kf+UWkdz8nvUNWva7UKakodecm3Jg
 iL52CBFvdrs2zfdjzYrbkZIwse+znv32S2WkEz3ptPtIKbopAFZoi07YfKpkkWj4pZhC
 5WlEnBpJz4ov6QuQjuf05HxsMmzEzYf7YW8Jam4h093TsO3ctoBbk4WQoT4OJUq8EfQA
 TTnPKXj5ilSwt9wsmg/IlX7j1F/ONIDIKiPO/9vwJvUx31rPg4m0jqj055/lDj4FkeML ZA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsqgmhgp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 10:43:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19JAem2w057861
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 10:43:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3bqmsehq3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 10:43:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOv5eWzAWFXy4VjZi2OKTiQsgS8Rn3zZatvQGkh84yvXnNBJgYqQ53NoO8fAaXPV8EKqlaCzIALuPLV6IfWUeinKotnSFsOXa+36gHZcObQHZcmyrx+0vP2qmsC4eyBbHSr6NLlvDHvT0W90gyzG8VQKOlWB3gJWnIwfA98YeGBYCmmEJm0h0HQk+I3V4H4ADl8YzLcQsMypRDu+T0vpMmqthieloE4YwpuUhNPehIlXKchLmQnM1/3EBYFtCgFQxnSgPsqnG+aQHDVvbpgsdCDcbtNNHNhwt9mW603Ii/yti+hvBtGHZ7BBlqWoofqR90yuruJdh3wcM016pczbNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvN5DcEbMygx9e4FpkCSiHgm5IBf/2dBm4TB5EiTMTc=;
 b=flQyCruJ/RZTCuoAMcqG5lvYltffCIKOxBjX2obnujoNi521X82y3F5KlWkZFSpGl/yBC3DCbT5ntNi6+ftrFKQ8HLMVDPyGPaZk9I3M1HDvomoV7XV6iLs2P7vjBZXIFUGIQfa95mBFwX72AifWLfX9md8rDH8aA0ARdXEEoppzzYLP0Bns9jmPd6JtmgH7pEXH3X70Us5ScNcVZqQOpEo+DbsB39MeBi75w5kzjdwvYFULnUqQF1DCPfD+WVN+KQYOB/lU3aLCri1AbDGOYa7uE1rNNBFJEi1EuM/9mse2b73IEEnrsWMbNwCrlvAPBWls+RSnACdjIHXJ1d3mZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvN5DcEbMygx9e4FpkCSiHgm5IBf/2dBm4TB5EiTMTc=;
 b=q6UdPdFjTOLPgPB955ZyqoVd4cIEkMgGCsFGeD8z6khYQu3LdQKokMH4B2FBIcrhjr1KH730YSkotTgZhbWt9o2Un7had0bF04FLYAVhaRa+R8Fl0ASckn25zaNM+coc3w3FHlvddBfLji0waWoDl75L/LPIoMJBcOTnOH3BCcE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB4932.namprd10.prod.outlook.com (2603:10b6:208:325::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 10:43:53 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 10:43:53 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH resend] btrfs: mount: call btrfs_check_rw_degradable only if there is a missing device
Date:   Tue, 19 Oct 2021 18:43:38 +0800
Message-Id: <f417a0730df69830b07db681eb0992a3ceb99d81.1630639255.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SI2PR01CA0038.apcprd01.prod.exchangelabs.com (2603:1096:4:193::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 10:43:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d1a9139-1712-4186-e204-08d992ed5842
X-MS-TrafficTypeDiagnostic: BLAPR10MB4932:
X-Microsoft-Antispam-PRVS: <BLAPR10MB4932E0D06F1690DAE197B115E5BD9@BLAPR10MB4932.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jb2dHYsENIbU/6HSPSJqJfaVTM2CNFEq5IFniGkr96AHurFLMqAPjSUaYhuraqz/s3aDuL8aVLiuI0AicKDYsb/q4cu5Vun+1PydgrugH4raLHsQHSno3ssQmw1XyZqD/KX8WnseDmnbBPTQep8j/d6Fulnhe1h6NWaPzTQOe96At1EUCjfa7HWE16z/LZx83663IcKJtD/H4rHdnBdpbxy1P9sOAWhLpoa5cC8l04EfgeDPcW8/A6l/Xhuj0GtoFcuNkLLTb2zZum3UrE2llzT7vzaArfGMlWRefkT5kiSpR3V2869gsDC4OeuLih3FEDIIGyv/ryqtJIKsPShEdnog1Eh756vD/4kuRRqfffnABOvR40r6BqYFKSBVfrh0AyNHShw0n7W2L93H7F2oktSvwze0CZ8lQEAXaaqzuPh0iVKNJo0TliydUUACCqQGUnadOFm5cc5+sI1/DRN4nCDaSQFOJIr8Gyhww0giD2uLbDvxTrXckgoJUubb3xvY+p7LMaAl2WC9tJYJrpBSPLsT2d1uTopEinp2s41BtpM9U2v2zjNMfBnbiSuwcakHzcAA4pej//0+mCMwiTY4my3bbnUBiQXPn7zO4XJOgZs+vSTKOd9e+pbjxc8MZHAGr74vJ27OEe4Vt6Eor7bGxVL1Vi0pzvc1SW/K9dcsO47h6dYtNiWlAVpTLN/+39FjHVi3wi8aj/YeWVXVke+Zlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(2906002)(38350700002)(5660300002)(26005)(36756003)(38100700002)(6666004)(83380400001)(186003)(6486002)(44832011)(2616005)(508600001)(956004)(66476007)(86362001)(66556008)(66946007)(6512007)(316002)(8676002)(6916009)(6506007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1KWHLtc/OkF+O/FuSMpSrouo35VjElFQAI6VKMIYeI1hdmMfmw63aLxm//G?=
 =?us-ascii?Q?hSujmyNNcy5QmD6Wb1O/uR8XR2FhocFoEwts2g3hkNP/GAafcBQNNWcspRf/?=
 =?us-ascii?Q?o+sT1t9iQiBfhFBt+t32fRlO1yZhfnkJqvJZBbw7k18YVUVPa1KCZ/AqXBY3?=
 =?us-ascii?Q?h0Z+KXIzPS8vICq6sUmcGb3Q7LNqNGhUO+BB4apvmir9z0SzpvMMQeBdwaCb?=
 =?us-ascii?Q?NwyLIXckFOmdsA4rjnvchQnNq/fKBg6ZbtI4W6qbSlGwtuGw3w6kTmPTrlyx?=
 =?us-ascii?Q?oySqkTKcocUXExgQYVc2Hsvp3wUUQeiwAgqFBByKjGeTq6T6tDeyBNwELfSE?=
 =?us-ascii?Q?DkmAXMUTrW1PUA6/kGQZXOQTAkxJlvyRV2uzICtxmHzyFTYJwr39g87xLOQ1?=
 =?us-ascii?Q?/nP2X9/iM9uaGWE7b67oKUU7Yl5qB1yorU13TlXLFnzWFex82203JQzbVh5k?=
 =?us-ascii?Q?4QiJGh/UxL8bUGMr/R141cd1uhyXSrUm/uD3AvHA6k+zLC5MHlOtMDNpMziL?=
 =?us-ascii?Q?CSiK1jOXtz1TGvovtD/shux1McseNGzvpIP2EYluzvObqL89MGURw9QhTDx7?=
 =?us-ascii?Q?D9kPmcJpd9sidIwPJl7AHxn8SEZBvGwv07p5Jx9TM2rm21/zoreQSEggsKqD?=
 =?us-ascii?Q?DavSkuAHrtRGWHw9+Bu9NhnOBdtWot9ulUxiSUuz6140WPQnmdsXrTpxLK24?=
 =?us-ascii?Q?Ih6+VqsvwygNvSLphIOresVWQEFCJVR8IjQvIDYO/8zSs8CdQ1uQBtGkkJbf?=
 =?us-ascii?Q?v6EKq0IbGXgZC4LtDk5d9ggzZirwyDvEFHckQyaQzqF6Ef1qe7ncw3Qma7UN?=
 =?us-ascii?Q?I/3/XiOej7nMTBMyk8LrHO3dZafAeza8C1M365v4jy0YR0Uc3gipwl1WLnZx?=
 =?us-ascii?Q?G12vZlhR/hyrgslpgQz32X66uwaPDCZe91uhOspvbsbY7H1SxmJmoASWZzce?=
 =?us-ascii?Q?a6LNsLfyHIjF1/swg0w/8fg1g4p3Uyx4Ny0lBdi01pdh6JGE4JATM5Hqhopd?=
 =?us-ascii?Q?StJAEIyF19kr1N/h/poZSkE+hs+OU+RCOciSM1RXk2WesHjHyqrkZPLKyR/7?=
 =?us-ascii?Q?RUbAWm6fTS0LvY3F1QDhF104JO7wtb0D90z6MQ/6Q0w4WQYtjEFHRj301Wsc?=
 =?us-ascii?Q?B0GmYFUSBUq80WsG4LWCt3RG/Ty2N6XcoNDNyCDL3H7Ci+nMoe+bYX29Vlpu?=
 =?us-ascii?Q?Jpl3v15rRnYz0mlqCHqt8zph7vOb8ADWfCi3J9hDt7N42GMSEXk74W0IvUkV?=
 =?us-ascii?Q?laMWVUhe1zmlfHyDTjqpFXaU1eT3/1maw77K8yMrginIkhLWlr2Hp32Y9SBf?=
 =?us-ascii?Q?r1fYVyrHbA8fruGpEvGz5dP8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1a9139-1712-4186-e204-08d992ed5842
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 10:43:53.6602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fFLgcNH2Px8GzrjQz5WSssTU8zmZcMnDnV1W8aHmrhS+w82vpqXAmPLfrU8HOk3HCKaL1/ejCTvW6hWM8nWmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4932
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10141 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190065
X-Proofpoint-GUID: tfyojZEy3qWVgxfHP2senxh0tjZUq6g-
X-Proofpoint-ORIG-GUID: tfyojZEy3qWVgxfHP2senxh0tjZUq6g-
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In open_ctree() in btrfs_check_rw_degradable() [1], we check each block
group individually if at least the minimum number of devices is available
for that profile. If all the devices are available, then we don't have to
check degradable.

[1]
open_ctree()
::
3559 if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {

Also before calling btrfs_check_rw_degradable() in open_ctee() at the
line number shown below [2] we call btrfs_read_chunk_tree() and down to
add_missing_dev() to record number of missing devices.

[2]
open_ctree()
::
3454         ret = btrfs_read_chunk_tree(fs_info);

btrfs_read_chunk_tree()
 read_one_chunk() / read_one_dev()
  add_missing_dev()

So, check if there is any missing device before btrfs_check_rw_degradable()
in open_ctree().

With this, in an example, the mount command could save ~16ms.[3] in the
most common case, that is no device is missing.

[3]
 1) * 16934.96 us | btrfs_check_rw_degradable [btrfs]();

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7d80e5b22d32..b86049a16a27 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3564,7 +3564,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
-	if (!sb_rdonly(sb) && !btrfs_check_rw_degradable(fs_info, NULL)) {
+	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
+	    !btrfs_check_rw_degradable(fs_info, NULL)) {
 		btrfs_warn(fs_info,
 		"writable mount is not allowed due to too many missing devices");
 		goto fail_sysfs;
-- 
2.31.1

