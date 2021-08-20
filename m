Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009B53F2B38
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbhHTL3u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 07:29:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41806 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237660AbhHTL3s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 07:29:48 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KBGbrA022487;
        Fri, 20 Aug 2021 11:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=k0lFz8N/DW/Z2h1h7pKMFkz3jPGoUa7rRuQFqjRlK1w=;
 b=v602Vg2K2FvfTkrByoBcQvRIxiJ7fu3UI7ms1HUyZpWO1sAPg8RJjmTH6q9Ou1YrLd0t
 D2e+EMVvm0qJwd/RNDAxAsnerRSjQZWFtfkivv6Zmia/bCjsZjdi5Iaugb3vpNt7LL/K
 Bh33IesC5wjI7fhXxRXoaBDcS0iAfYPcXS9Y+lFbjtrd4RQ4VC0ze+zGOiFd9o6rP83a
 KqU2DsqKMIFTO+g9yHlc3BAMl++e80O3Vi8TJkLAottnyMgj8F7RYK1Xs5T3F0LwzckL
 RoYotiJqFb3uO2znDLQFjTPcFTDluZf2j+TJZH1bJVr0VYa4k/lxyev2zcONk/If10XJ ZA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=k0lFz8N/DW/Z2h1h7pKMFkz3jPGoUa7rRuQFqjRlK1w=;
 b=j0Mil8jHMuwvD3sqdEbcG/3yToP6KiMUcb+tJCp0eezUMVYzaQQ/fe7HI2qanSjKb/CH
 W68lpw/4x7t2639y/aHgZEpskrFZ8N3shPW1Yj2pSobORwuQhGtZzJMoSfAWZ5KHG7rN
 E1v7ZGXlhjcSQMK6FCUnuIXncyF3SYxD93L1WdUbyIO29Pp0ExGm0NDry5SjQL8n6jW8
 MjYC46sq48gf5pBNtS/MscP715/gGgwUXwR8vJGKIkyvJK8OcP8umlbhmUtni9eaKGEs
 Ufn47TNoXgKs13mp7Ljg4LvLXvkULBGKzhyRE+AkAg/iOy6hI/ZxF5etQMikaWcs3OrY MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24paj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:29:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KBF1bN008856;
        Fri, 20 Aug 2021 11:29:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3ae5nde5nf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 11:29:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crX9fODTT9wZjWj7Y4iI5KULRgNYZ170nKDC+rT8/8AGBslJYaJ2ddPOrEkAeQvG4rpG0nQwyhb3tYXoR/gJVHV9F7JYJ033e5Wb1g1EOjC6nddyitc1W0FGg8uga4IbPC0Nnws9PhzfsYFTFzwVQQT1jnqqKN2Pu9EaNUhreZknF3c1F44D68sN9OewzTixJYUA01w+i1xRug9XNS9jKLP65IdIg5Ob4OXFm3NuontsXw2DwNndEL6hpQLiKOlv77e6FPbTsHtT9ut3zM206D4ow2tUYLwB8msrUFPG9PcAE5PgAZSCzjemm7tUM6D2nVfwjIuxvEsSAyOp/xCftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0lFz8N/DW/Z2h1h7pKMFkz3jPGoUa7rRuQFqjRlK1w=;
 b=e47smsF6/ni3ZhnAjm1VtR929BPRTSyPEpTvRJzpeyBNXTstA2AT3vZ8/W4qb+dUPftw0vx4Y7yTLCZHy++dCHvy5ugg8nAxEyATGCx6mTazsrNLUHFYQ52WdUnKpZjTdCj/ZncRRJasEYlz23s5DgIYSvTLttxyvZh0EPv2M5171fYSUCOifbVeiAniwte/y9HIxIVY8OMaSzh3T9bmGRCodj22Lqngd8KINYVtsWUpnDlIXdoxlEi63TNn3rb+61dQvWx2J8Qd5CRH9Z76gk7ezXP888tnNb4A/4oP3+ys4hZ/Jxa/PhRrJY+yYN3rysqEklp3FIxHmFtjmvoMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0lFz8N/DW/Z2h1h7pKMFkz3jPGoUa7rRuQFqjRlK1w=;
 b=ktf0XbQDW3rMcJOTOM/W39HJw6NOkYXwwpqyyrhF0QUZiUeuyf6nuFWhQSrmRg4kokZQIlMuf+WsrwtKIi4sbjdIMSo+y289q5zPefun2qiaPUN7XGfvB4hpPTBiaZSTFAgD3mJQAQHIdGyJMQLLZWLYftufRgTiSmGCu43IKXM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4094.namprd10.prod.outlook.com (2603:10b6:208:11e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Fri, 20 Aug
 2021 11:29:02 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 11:29:01 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH v3 1/4] btrfs: consolidate device_list_mutex in prepare_sprout to its parent
Date:   Fri, 20 Aug 2021 19:28:39 +0800
Message-Id: <c05d9fe48a644d329bcba1aeaa0875e5a0452994.1629458519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
References: <cover.1629458519.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:3:17::28) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR02CA0016.apcprd02.prod.outlook.com (2603:1096:3:17::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 11:29:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b073e1f9-7a5e-4cc9-9007-08d963cdb598
X-MS-TrafficTypeDiagnostic: MN2PR10MB4094:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4094D7B133264E6C43783DE7E5C19@MN2PR10MB4094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1oVd8SzV95eu35VxvLD+Wwy7jGJkHU+Gz0f0JK7SySfjaa5LnLxUF5WAO6K4ZQp2637OXY8roIhsR2+wTDzZu4HiEO1+6+0bdJ4d2LjQOue9qWfiVAbdARMr1bIe9MpF/abQblOtjo+p8AUsLjPEqygniZbm1CC/bRcTWVO3ZqeUiWR5e7rdiRKMQPUgrhJehkMlbVB43VHNEwBKQXYj+jCnOkcL8qw0Bvic/fvCXUrij5UM+64bNcotRExcuCQhOrepPW7bpqm/hhuNi5Z6En+PLREXX+XBEVopw9lQe1dSFS421zypb1AL2vY9+KQboXGlgn8BC4MXTBV/5wP0jPVA83PawrdZfkfSZ8oBhVy6fqNaf/WMkHuAliCQWwpu0G4MvbJBxd4eY/DOiiYkTHMN53hSAOePQ8Pedg09EQJAGt1N6R3Sw73qAz3dm0124cSrV9DG3dqErGGsfaVvi4SeuT2SC5ZvEnMt983VDrnqOvuDYuzsQ3d3DSdw9i6o13XUKrbU63kcW0Rtnrce3JMATMCIuA+3uybF382l2dhnMpJxbvC4XKRX1JhltLdIvYPm/6h9PZ8WoO0RlgQMiFYEd/yxWZ/kLFUNrleP4syg6adyYK4HwA9cljNhM+eo9RQ8Wnc72SXoB/A+ecn5/GYgBdprQCSbhW2LD+lpJYbEzWLigAvb7ZAZb/BplUrPC8v3nfLyf7rpgs01q/PEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(136003)(366004)(376002)(5660300002)(956004)(44832011)(8676002)(8936002)(2616005)(478600001)(83380400001)(6916009)(6506007)(6486002)(4326008)(316002)(2906002)(38100700002)(38350700002)(52116002)(36756003)(6512007)(86362001)(66476007)(66556008)(186003)(66946007)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lQpo2HanDh8clODzU/JZKbqZT0vxC3+n/zC4d5+DwVHQLOU1MC4BtjLbDfzi?=
 =?us-ascii?Q?mxWqNTIzZdLqXUpiM7tpTCT0pMd5255ZT4eLBUNiXzIbHSBVp6mMOd7U9dKk?=
 =?us-ascii?Q?9UKHnov2sBLOb3pX1f8LAbpuZljiqce495kLLkf/AxL2FOHsVJdu5C78sUNh?=
 =?us-ascii?Q?zb51PMODM1yY5/Qtk1nwgsfGaPh24kLDKz0IQ+fl0jzkYRE3xlhh2icW57Eo?=
 =?us-ascii?Q?loyuf9EI8mhGzbDjY6aS60DTSwU8tsxVE2QZTt9UHuO/WHHf5CAAwkcfHqTm?=
 =?us-ascii?Q?ymh6oHWU3Q7qvYi8UYGc6YcNbh/k9lUQxP1ez+4lwTmZXG0HkV/RDY+lLg9l?=
 =?us-ascii?Q?Ke/flRARL2nTro17vA7gJIYyC11VoaTlxgYl6q2/sWZaPZQgfGZF8nXOIAWH?=
 =?us-ascii?Q?xXxYceT8Wl/E2asbA0WmWvHS/pkjd5jLjR582aq0xW4EiMk5Q7s/HQEgAJ/6?=
 =?us-ascii?Q?DoNk++c/f675w1/bw2+1vavwCuZ1U3xueHGcfKYsYZ9B8iT2hjJwZwfj5BOf?=
 =?us-ascii?Q?jyLRqsEYMSvBzq6rquZuUSjdez2mAtnSn3FYI4uflYHauy5ayHV2mMcohkZg?=
 =?us-ascii?Q?iIcv8Q1FiVtAjw1Y3/ftqwynsF/DMj76Y7tLlvS+lBQ+zfCstE8aFOdIjrrW?=
 =?us-ascii?Q?hBFnlNSsODzVXaECdJ4j1Bmh7mZDXypHTDir6lG3dw2qXskFpzl+PHpllWTq?=
 =?us-ascii?Q?865Dti9HIduSjuVl50f60VYkHGXZfPYJ5AVeaqlYZjidv75KFS59M8pYH3GY?=
 =?us-ascii?Q?pv/mDv3A2BbAkGTL5GK+mhZ2q5LyuGju6BdTstXnmRHLJEkA71wtgY8VcpQH?=
 =?us-ascii?Q?qdXb2pL5kWkxywT9l4FrFcJStWn+1FcNKPWlEDCr5EMUOxp3WCJ6Vt0bs0r9?=
 =?us-ascii?Q?KaN74XQILshirExpuZLmC3zUwDKXF3gIlm7dd9kkHHg4o+L6L9/2frpqNT9F?=
 =?us-ascii?Q?x/efEsEQ/1ZWHoCCadIX3G9VoG7t1yzpElUZ1dBB34WtynsEtlAapVkLx8Ep?=
 =?us-ascii?Q?4DqRx2mnriBSTicn7YnJ82Bzm1inNDqxXTCfB8z+8l8UkQz35rFapyWhtDf1?=
 =?us-ascii?Q?R7yaaKOG8hg1LZ1r/W0ERoJNzqx2sK8/v0C0zhR1cpri+Fxa+AFCUBzp44LA?=
 =?us-ascii?Q?2TAe1bUvt+6nB3ucNfSSROK1UHpKSxOoJ/fv//viJZnxWuOFuUHvP8NxXjet?=
 =?us-ascii?Q?50RN1sArz1phrN9eExVRV63FzX5SkZqxoSiqIyFjvIFEHO8NY3OTHuC4FR5k?=
 =?us-ascii?Q?JAZfOxgj/+m0xKjATtNrcbPgbTWBMbshYp/mJoJUttSmYnp5Ocyau0lD00tv?=
 =?us-ascii?Q?6W5hzWpG565DtR3v4ikJw3KA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b073e1f9-7a5e-4cc9-9007-08d963cdb598
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 11:29:01.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYnZLvZxBE3Le1/nm2VWtU5jKBXWfg+KlHvzKLNRWSLSnd2YkNdSFFRi1d+bgVVhcesVxZ2BNsVysk9BVJMbFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200061
X-Proofpoint-GUID: Cr-UllZen35MkESGGtcUw9_nvvRbhLXJ
X-Proofpoint-ORIG-GUID: Cr-UllZen35MkESGGtcUw9_nvvRbhLXJ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_prepare_sprout() moves seed devices into its own struct fs_devices,
so that its parent function btrfs_init_new_device() can add the new sprout
device to fs_info->fs_devices.

Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
device_list_mutex. But they are holding it sequentially, thus creates a
small window to an opportunity to race. Close this opportunity and hold
device_list_mutex common to both btrfs_init_new_device() and
btrfs_prepare_sprout().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
RFC because I haven't identified the other thread which could race with
this, but still does this cleanup makes sense?

v2: fix the missing mutex_unlock in the error return
v3: -

 fs/btrfs/volumes.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e7295ec3865e..51cf68785782 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2366,6 +2366,8 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	u64 super_flags;
 
 	lockdep_assert_held(&uuid_mutex);
+	lockdep_assert_held(&fs_devices->device_list_mutex);
+
 	if (!fs_devices->seeding)
 		return -EINVAL;
 
@@ -2397,7 +2399,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 	mutex_init(&seed_devices->device_list_mutex);
 
-	mutex_lock(&fs_devices->device_list_mutex);
 	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
 			      synchronize_rcu);
 	list_for_each_entry(device, &seed_devices->devices, dev_list)
@@ -2413,7 +2414,6 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	generate_random_uuid(fs_devices->fsid);
 	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);
 	memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
-	mutex_unlock(&fs_devices->device_list_mutex);
 
 	super_flags = btrfs_super_flags(disk_super) &
 		      ~BTRFS_SUPER_FLAG_SEEDING;
@@ -2588,10 +2588,12 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	device->dev_stats_valid = 1;
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 
+	mutex_lock(&fs_devices->device_list_mutex);
 	if (seeding_dev) {
 		btrfs_clear_sb_rdonly(sb);
 		ret = btrfs_prepare_sprout(fs_info);
 		if (ret) {
+			mutex_unlock(&fs_devices->device_list_mutex);
 			btrfs_abort_transaction(trans, ret);
 			goto error_trans;
 		}
@@ -2599,7 +2601,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	device->fs_devices = fs_devices;
 
-	mutex_lock(&fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_add_rcu(&device->dev_list, &fs_devices->devices);
 	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
-- 
2.31.1

