Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E3D3F49D3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 13:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhHWLc4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 07:32:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63070 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236361AbhHWLcy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 07:32:54 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TcE1025296;
        Mon, 23 Aug 2021 11:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=dqpql+IAG8k4ySAS2rvhebcaMTltN/38p7FfI2On0WQ=;
 b=kgowXTzXmEomRVyIQen+sf+G9lHzCqzdwvLqthhCqhpkPWH08eoTwxlaUAzSUPz6ta+T
 LvkEWeChMQZKvGXUgnTeZLPbYwI9EvbiZf1lumabx/4OsjO0Ds5QrjaYndMAyNs1+aC0
 fdkEpBxcfPUVtNVW4sO9GAEi69s9w54Ad4z16D0M1V7Xfb25L4Xc6xxNrTtsstJ5wpcz
 ROmAXXbQysdz/noDyhwxwEzZzHPjqrNjBhDhLAp4yw1IquDESxFTeKB+hIakLOsSW7B0
 DYhSRqoxYBDVY6j++wul9OLSkb34IPOpJLjG0IUAmWlBUPrRqmv8JYDFVQakImafMxRV FA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=dqpql+IAG8k4ySAS2rvhebcaMTltN/38p7FfI2On0WQ=;
 b=bS3JsRT20smzUKxHJKCuTFlRo8apGbnayjF/4Xm2Dt84heDrg3HaJwdw7HI3vIAr4jC4
 ZKa5fOoSy9my4m1Sd8GKXcHit18eduXGhvmaOJkWMh7p6EDtzVPweVpicfTKclHMlEnZ
 YJQ9B6sMW8lziG7r3JOvVxMHr7F7ahcpMKqxsyc3L8lxR1/t2GcZ85vec47vr0yTN9GJ
 44Gd6RJR6+G+AzVhuYyKnK+nOISWVS6CF3gQLnw5pDVvpvWIZpvVK6WWnAXoIg+lQaF7
 KU7itJwzyVEzlvLvmWyj6lEGc9R+GNQhbLLLhMpEP+VKIv5lYC1bHj2U35HE/ylNLUrP VQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aktrtsav4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:32:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NBVLxV021994;
        Mon, 23 Aug 2021 11:32:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3020.oracle.com with ESMTP id 3akb8sh71r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbDKJSNvQvFO+Ezsj6TdGGi5yJ7m1riRRKEq4bJQwxqc4odA2g/ndMamywLZAY2STijXr4PLz765VX8xTkaC5iMzrgChru13NclNUbUBiPkZj661vgrogNRntyO+6v9xPw21v+/vNwWaiQUBJxgXmV/RieK0eIRAbzAmVaCe3ojwjYQAtmhBr0lkAb98qrYgc0XFEEaS7UUs2aEXFSpI6981o4ZuRzag1tInXpvCjkQuPwZA/Q/FBmpLSqZFXvPsOfSOCIF+iEI1Z2spZb2JWjrxbS5pJX4fmH5kBYgq4Kn6A0FYq/LhjVsBhhSy0CWyAA32rHKS0UDVX5tH50gs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqpql+IAG8k4ySAS2rvhebcaMTltN/38p7FfI2On0WQ=;
 b=JBlYb/R4fQ4gV6HOVjl1ZxvZIzplA8DGyjlI5WfCYLdLNqIb6P1BucuKt3OBr9iTVTg/vm5ajYDiKd1fMvhX4D5njycHXg6sk6cd2Gf60MDSRJS74NXRoYgVQdCEEatrqU0D/casQ3XnIJvV53t12/lLUgutn2lBRnNftDu5LHL0bs2YZVo/3F8nnR/8I5b4wZcShv39Vg8rR+CNxxIGj9cV0lCQsLm4DOjJ0QZ4FS85+oX2M/dPmyUzFvNXofssy/xpd6OxqKlnLAoH/QQA6MS8ZDTcLBRlOMDyOLWX4jJXq7rYsYgrYRFK8PRVyKm9yzsg2Gii5yYmAg1ZQjoPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqpql+IAG8k4ySAS2rvhebcaMTltN/38p7FfI2On0WQ=;
 b=j61S/ZtYTf+hNiX3tvLsjDFRmpDmXlFHv3jj6x6vydBFlyABpdltvLhVAuRFy/gL7wZSH2tosMX0lQ+uFSOfL/CRv6RUtjTs2y/gfLVWGSwTjQ3rRzm8tCNw3YmtQ3qyXVjGHbm60L6po/0jMFpjVP5V3GHt5Spnc2bNwqflF+4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4206.namprd10.prod.outlook.com (2603:10b6:208:1df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 23 Aug
 2021 11:32:00 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 11:31:59 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, l@damenly.su
Subject: [PATCH RFC v4 1/4] btrfs: consolidate device_list_mutex in prepare_sprout to its parent
Date:   Mon, 23 Aug 2021 19:31:39 +0800
Message-Id: <c05d9fe48a644d329bcba1aeaa0875e5a0452994.1629458519.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629458519.git.anand.jain@oracle.com>
References: <cover.1629458519.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (39.109.186.25) by SG2PR01CA0142.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 11:31:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ada1d51-3295-4459-8c19-08d966299eea
X-MS-TrafficTypeDiagnostic: MN2PR10MB4206:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4206AD16DCEFBA33665273CDE5C49@MN2PR10MB4206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: My6T+ITnqLgO7zTgUlOAfeNh6k9CaAB/pBogrOyxUMimBS3SZPrP6gkkhgN3FKUgCNZRX06ibFzs5aFhcmovpIe+f1sCZW9DlYmOw69JdNz+UVPp3x2n7I2TVuEQbik9xIpa/CxvXJ04cPx7rE9rnN2SksxXL3IpAcXh+oo3EBFnBZlE9cJYE2Uccz09T3d2fOepnROr5wZP7aZnV3VOfkL8S94LnRRV0OXF5yz2RY+CBNM8wzfpCDtqyXFABw4cUDFeaptGnhRfB7eavCqC+3IQKdw//50LPelnU4D+sCTJiJYHqTDIiCpMIcRhT05kHNjor51uGSTv5Rq9lqc7djY1ejbi4zNEUYnUa7KSRj9DwbfIDyCvKUfL5cV7jaS3t2zG28sx3eEvVX7V8pRN+yLq20iE2YgNZ9QKzECpYfpIyqwgi+2Z3l9o0oGcTWFZN/W6HkIcbzVtXwRNUoGsY8Vh0kxi+GmHyDtyOj/SyZexovamF3gERveZykxfnCUifHXC+8AOdKGX5PzMedsguY3lerrg/QUaugbHV8x+luMcYqNEm2jzkLFGs+Bm+j/oMcwTsf5risZGWjDTTPlg6HM1H6IGPcZ7MdoDC5jRATSxqDGCyKLfIKW5D8xxn/8vXJw/0aOCUjwLxmDkYayePOoxdlOpnOWeOP09T3HDP7TqrHKGlMRLTedFA5VyzMJ1R9A+II2YCCM1fhO7Ddf3MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(6666004)(52116002)(66476007)(38350700002)(6512007)(26005)(478600001)(38100700002)(6486002)(6916009)(86362001)(316002)(83380400001)(2906002)(44832011)(66946007)(8676002)(4326008)(6506007)(8936002)(66556008)(956004)(5660300002)(36756003)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPG6IVp+Vwu9rmAHw6hgn68ZvQyBCV//MZue5by1BnWGY5SMDBQmeFkkyS2q?=
 =?us-ascii?Q?Wfby4eDjrpobNytUSotbLl7rm9LVNA+oMuZa1yrQCqtmOfhjD2BfhA+5qJ1X?=
 =?us-ascii?Q?I1a3Qw34MxrkwGqjGr7W2hDS4aVBsa75Gf42qk7g957atSdkq0SDkqyfGgV+?=
 =?us-ascii?Q?jbx0U67fDselSH0JDOcC7nmDYcmsLLZ0fMUUNiLvRWS2FUY8OEjS6q+SfRnU?=
 =?us-ascii?Q?4vDJv61m2j6mm9CXCbUIzV/noRaoxML1diAdReZD/nkokSG07AXHB6iq5/Eo?=
 =?us-ascii?Q?Hda6hQ0kGUV2lg4qy2jjHcfD41fDsjwicYfF8g++o+W+8QaUxZw9uHKwDH2H?=
 =?us-ascii?Q?bT4ijwIgR6HuyzAx+xczXBnULP6VhqdH8ywRHpw29PyHDmGG96I/RSALQzec?=
 =?us-ascii?Q?3hO4+ktiR7Kea7DM0KE7jfZBP/1jyYLBDMQI2LalxnDD171lWIGi87PTPMjp?=
 =?us-ascii?Q?1GDb0xZS6sUJ/dp89CTCRa9VwCtRiIyuQOQQJgOgVBX49AfFO2bDUBJoiwWv?=
 =?us-ascii?Q?mLQ1B0KSwEcdvSChA9ax7auQiv1pK5i3dYwyftzrctepJ1lj2e2hy0DXyjuc?=
 =?us-ascii?Q?CbQKNerFkshUBwWHmbMURushBTU68nqxrCrf1UixIFEwtLWO5q2BKcuCayhu?=
 =?us-ascii?Q?Su7DUPUiac+2wF6QweKdQDSPmBJQjrYLuM0l+X0iZCHKW45VhlvcwfuAngLy?=
 =?us-ascii?Q?7HskEA9dIV84HmQBeVgjhtNv4ubKav+tvRZxs7822q+GrScQLkT6o4xdwSb1?=
 =?us-ascii?Q?wf70qCXH7E5wL3q3d9pHEMPHzpY322mvnOx6pAAzBB8ilGArLgS1LsngYUvD?=
 =?us-ascii?Q?MFuQMVJyW2vyBeHQFJ0do1wIM9jaITbjAOMHJtTOocnjz4DooMGyYRpDCy4c?=
 =?us-ascii?Q?9nyMALfgAOeu79EHoDbAfv/6xc6eP51kuxSy+lEBGXkLxLRPxjfAEDBpURK8?=
 =?us-ascii?Q?RShNYMEiW3IE/o7qTH2rMdwBf1H2XkwQ5T1T/E9rDFMxY4dMW5mQYqV9EBE7?=
 =?us-ascii?Q?W5pVcJy3sC8QHBsDhQyUsCEYx6+/gfjvhTnjw5wCUZrjZunaotd6gUlBvZ3N?=
 =?us-ascii?Q?ZJM1q73dY4QhtM/wCy7JuKbaO7vlRWZxuSUWLcvlokv84daRLWWNPq42LTi7?=
 =?us-ascii?Q?XUzEY8YPXB9S0itxJ6woCs2vwjS+DqcR5kOx0Z+vTCOvshHGc3pf5/V/5+t7?=
 =?us-ascii?Q?nS9itxr8lCh3YDXHd4v9TEgoyZMKROGuKKE5hjjQTGoM6ZJeZRjkXqT8Pv6d?=
 =?us-ascii?Q?kWaZ+S/qbE63DEaTqoi0V+s7YbwlJZnvEAzToJSsRTvZSgyeRN5t+YEEmE0L?=
 =?us-ascii?Q?5+AcMICbLlhohfqZcl0yo0Or?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ada1d51-3295-4459-8c19-08d966299eea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 11:31:59.8665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sxu3ODrBQdUBjUIhrRLs3eoCiXG5Hjd5mQvh9aGkAufRGzPv+X+L6z54G0XoWpglKrFgbK+tG+K0mr//f7w0fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4206
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230077
X-Proofpoint-GUID: oR4jESiXOIJTn-E1OUatFWqDvHoydS2Q
X-Proofpoint-ORIG-GUID: oR4jESiXOIJTn-E1OUatFWqDvHoydS2Q
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
this (if any), but still does this cleanup makes sense?

btrfs_prepare_sprout() calls clone_fs_devices() which holds
device_list_mutex. So this patch also needs the following
cleanup patch in the ML, that removed device_list_mutex from
clone_fs_devices().
 [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs

v2: fix the missing mutex_unlock in the error return
v3: -
v4: -

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

