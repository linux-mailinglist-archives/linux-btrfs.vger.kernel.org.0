Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A973F299A
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 11:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbhHTJzI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 05:55:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20206 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238917AbhHTJzI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 05:55:08 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17K9kATS026176
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=l6VfUg+lRffqx7A6ae3ilsIbWtZkFKcke/yVifY+Uhk=;
 b=f6O5Mtg2YOG9MkVwjCziGVbY6f7Ed5sMkLit8h/iMxNTCergXMQFdxjIs7SrPBsHA313
 AA1T6KT9kUahcAI8HFjDUQL3hk3vrW1YdA0npwkezBXDPcgreRkYKIa5nuox44BkZPnl
 3jMzzPzaMpo3x1oL+OKaZlGein+LD5rDcpsnsgzAi8R5NkbKvzIcI4Y5FEOHdTWyPLSs
 R2aIU3nuPD4t11hLivde9oQJdvOwlsl4XDrSUgLGJ72bIjzv4QNciTgWxGs9mQaO8QoC
 T3TpHh5hejh0lHHdBBRZVsbQEvm0BaxkXq+RpZ4EAZGzNYFj4eIUprA4LL8FovOt9ehz Yw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2020-01-29;
 bh=l6VfUg+lRffqx7A6ae3ilsIbWtZkFKcke/yVifY+Uhk=;
 b=jqWza0MkhEI7BLIcSzGhxq6TUoJYoGvGADQDJVcUQ9qFKU+hju0I1al+WZ8+0wyCZfUH
 JmckiFqExTzAIWptGCHI+y1tTyXMjG+HUd3g4zFFNJ0tj+8Ei2sube9nhCoQ09HplYzB
 cqOM2jbKqe3Iok4HLXE8XO+6pox8NgiBSqEOmjvblUDecEeWi5S9e1XRJbuMnUnbWEyM
 4bgCT+Dt++rzDYJAxnyu1nrmcn4QCSE00rrVG7KsN67kEtXqciHFIhNMxBAfIstWjqST
 sWaiseFKOGKIUl/SoO78XW44+oY9yV8onZDsvymQRTxVmwBTMiXiRTsCtUO7S5nvPI+Z lQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahs40j2ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17K9iwkt137393
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3020.oracle.com with ESMTP id 3ae5nd9s6w-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Aug 2021 09:54:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfT2H6CYaz286VbLviY7k1pXUHc3mGLPSdWMKTwCkgcBlIYKFrWRRSiypE9XtWyI+eQr+0cMTnDkULbg2IXhGRJ4Gmzh2MW+KVh9QjVKJ+A3KNULdTcYxLlpElRmwJsDN196u0DRywxu+K14b+Wogkb9WHD3Gf77bWcVv6Y0JvB1bqktZmOBJKUA2hU9h1VNLDsAmUeGrqYunXsHfnDZboE9a0+91lrP4NtsMHQYyjy6dNl5iuIj2g5hCHxI4B+vZfLMtBgc+yMT4FLY2aIEhT/6+MTdJz7vycuUXj4t+PFuD/gtvHauzVx4lMUXefv/iaSV37F6swl1+9L0TGzQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6VfUg+lRffqx7A6ae3ilsIbWtZkFKcke/yVifY+Uhk=;
 b=biEp87TCWkIv7co/nusGMt3XdzZn8pgv6MyuaPqmB4rsoJ/x4x3ThUlbTOxgOfFjwRu3LHYvFThFaQgzP61J2+QxCGPsJZqhnB5XwSnN5SY1VBb5pwBzBmU7STFTG7MUfeo0xaMyNuPXU/AcKxAnL3ENJiR2ncn0U636a9UFzKaJUgg3YnDWmweSuhmf+zGvJAalICwZvcd6BFEHhv77ItTaOUcs+Z8pjjL9JdF44rdspaSC8bQrDXwHzbD/7qO8Lc/4uLeG2UUbBGPtR+HtVhvkcvI7gXK2DQZ8lUAJVRecKtmc8B9BhiPjzKQv5KPObnze7xNJZXATCEjN5oNlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6VfUg+lRffqx7A6ae3ilsIbWtZkFKcke/yVifY+Uhk=;
 b=s9KSFI1vbKILzwC6mntIYrMTMf89dciWUqAyaBPAx5JFEPQ3RY8pzhdnlvI1u9eBRFaQK+9v7jQzJkQfPLgr7ycljd9Ze2ipXftpkez8qybgamLy2lVxPPVkVf2gOMK2/1XiDGki+YRGs+WOu7dDG6q6PVRKzo2PV5iQ7HmriEk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB3427.namprd10.prod.outlook.com (2603:10b6:208:7e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 09:54:27 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4415.023; Fri, 20 Aug 2021
 09:54:27 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 1/4] btrfs: consolidate device_list_mutex in prepare_sprout to its parent
Date:   Fri, 20 Aug 2021 17:54:09 +0800
Message-Id: <c05d9fe48a644d329bcba1aeaa0875e5a0452994.1629452691.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629452691.git.anand.jain@oracle.com>
References: <cover.1629452691.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend Transport; Fri, 20 Aug 2021 09:54:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b78b5de7-3533-4753-4301-08d963c07f86
X-MS-TrafficTypeDiagnostic: BL0PR10MB3427:
X-Microsoft-Antispam-PRVS: <BL0PR10MB34271DB49E6383EABE04B24AE5C19@BL0PR10MB3427.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtTrHUUMHkcYBPTeaZdwPok/oRBBI8T3fuiPNkb14e/18Sr/I/kH7VWpbyWqlN3p8HJlbIoqMbJKp+Cpzz/1jPCSk5YXBldxd1GFxkhU+9xo5FOZAXrrPLAmE0/yzbB5npO/AV8ZBuIFu6EgQjruCaC8KBekeJ4NF2cZRG2Fs8zkbS490mt2GlQY+I4H0GGyehbPzF+We0oNMARwHFRmUW/BN9nRUJfhgkHjV2VRLEMf6C6j27XJrJvwHuokpjV3oYcA5J7AKWyepXVRZNLZ5Op1syVfr8rhuc6hmhMdAxSY3gEBY8IomI03eZuiKhxm8RJm+trd3w4/bsOdpFxfhksZ8qMKG3OEX9TTUYEPsdLDWmXmg91aQF+G5uZy9EK9q40dF4B0+lltOcHUapXY7w2GIh29OYc6hhCrvbRKMUmnl908EJEZHDA55Lv2CqT4Qn0hRGbTJjKPNl6nPX8G8Yapdm4PHi/CBAAFQfgA7A/LELo04JJ+lNtx6RIncq7RxPUkSW1iSYXAhS979lvT7n65M2EQvwxHoR0acmG2eIU7VzwgiYBOBT4g4F3RrIlhsOn/REeUo9PCLjQ/8spZi1pUrfdlzdUd4w3Id0x5PP6umNlqKig4nthAlFwsQvkdpf8/8CzG22irjcQAXCdasVtg2nvndqyUgQmZ66pQVI4Y3PmKNB+kbkMRT6zcUDg6OuIFoXYfYIY+QJf3zu2zvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39860400002)(346002)(376002)(6506007)(5660300002)(6916009)(66946007)(36756003)(66476007)(66556008)(83380400001)(186003)(6666004)(478600001)(6486002)(52116002)(8676002)(6512007)(8936002)(86362001)(2616005)(956004)(44832011)(38350700002)(38100700002)(316002)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aoLe35/BOJ+tzcSPCcb4ZXtHZIsQ3AL0fISllry1ESAhLqJA3RTmcVeeSesc?=
 =?us-ascii?Q?UFnmEr66MHJ7zbvpbzaR0Oyu0Kws6Vu1iFKiqkayBy3tNP5/SvYWR3/81QLb?=
 =?us-ascii?Q?+MnEEdlHOgI/lOcpBnZRPgq3R2esq6XIXfPyVzlqtJbIJ9sX4HVSPm+gSDdE?=
 =?us-ascii?Q?FsXAY1uEne2jxehld8P/+a8vhFgQTL6jyT7zVUyWEdVqn4c6hPrAVFEJzTu8?=
 =?us-ascii?Q?31yLJQwiOdq/w+aomiOlL/U+0bsZv0AiIQetXeyS+gr4tNOrMX7F0MN+ImSg?=
 =?us-ascii?Q?Q04oDtBoB/0tkN/3U1mOY5AOTiMwb1TDR9jrk2dT7e07xNr4oywarLPAkHHs?=
 =?us-ascii?Q?VuvR2IaVAFLXzcx9gxcu8MpBdiicUUAHLIKQIkCH6oF3eAbtZjFaLgyG2hAh?=
 =?us-ascii?Q?DMUns5ky8t7jJ9TOEsGeDPmDBKtbNVVIHI8/ADK31x93Q/QpW+E6q03O6Eid?=
 =?us-ascii?Q?/DHg3DzuqheLwdhEwS69P/8hcgCazEIjMpgW15D+eC7bW2U042jkaEeaxwPG?=
 =?us-ascii?Q?AJEYAcRTeuRZjyk2SaZaleRoBwfN9/HIjeIu1CHSH/FgXFZ7+jNaYU1dDFdq?=
 =?us-ascii?Q?sxOqq5F+w6Y8nvpgGPBViIec1emP3pmS+vZinMRV+NxT4bXbL2JbeHwMMMIV?=
 =?us-ascii?Q?t3WjW2RfYEK7G9pmmphQJaRllGzrIS61n/f0pB+y/xEmgI9UUyZ/G/by6Pi6?=
 =?us-ascii?Q?zEv17g7a6r0mRPviQJ+AxmjkWhleoblToVk978bYXwF1ZsrrbEilatTlfckz?=
 =?us-ascii?Q?ilWXLLib0ux5yECuk4MpyAXANel3dhNPVS/JB2ewvbpoAFGsUUpo9kPupDPY?=
 =?us-ascii?Q?iIZ24P9JKAYunQzj4ZR+o3shYeQKZhxai96pK/gQBD+Z9GRhjJyRCPi2ozGK?=
 =?us-ascii?Q?amPCWufa3QSV4IWRVGO/vn92jfuSG1noXhbMmw0U7oXZqm/7i9nNT8Aag+v0?=
 =?us-ascii?Q?KGu7xHUQm/HfpLj7OBXsRui8tPeocYittRvfHw7qfe/L6mvZ93RRRFOMU+Np?=
 =?us-ascii?Q?7PcQ4R1bwxp157P7mgKWeQ4kIe4gAeT6sDTv2pogAYMvB/TU4n27+Bp3LNU/?=
 =?us-ascii?Q?ahN51ZHlSD+hH8izpcS8afwlni/9W2L7gYu+Mj2moFxH3kEwyochhwGzQ9tn?=
 =?us-ascii?Q?IzCcoK/lnRr22VgNYl1Tv/1Z6a0Tv0wCgw3svpU9D2zzj9tojswWgSQU5kD4?=
 =?us-ascii?Q?/19mIRFioBuynrC03e/4n6AbC74J2upQ9PwSuFcyhuBN8t61TBgbk6jX4+Sa?=
 =?us-ascii?Q?m8/skrw4OBw/dFCcjT4Gxbu4a8khkqmEIE9RnhOCa/KgLD+HqYwMASCszeej?=
 =?us-ascii?Q?e5d0soOwvpAo0Y1rJh84uWoO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78b5de7-3533-4753-4301-08d963c07f86
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 09:54:27.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gILHeq3FL2OVW5Prd0mXDvrBu8cgDXO5x0MGTp4o3nmIEf283ppMg919KyBtYW++npCcsxmg/AdE23KPxthbvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3427
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200054
X-Proofpoint-GUID: Ae5MkLTj1U8AyxjcyuYclTvHcHvStOx8
X-Proofpoint-ORIG-GUID: Ae5MkLTj1U8AyxjcyuYclTvHcHvStOx8
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

