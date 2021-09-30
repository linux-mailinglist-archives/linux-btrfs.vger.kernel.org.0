Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C1641D982
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 14:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349478AbhI3MSe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 08:18:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63018 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349389AbhI3MSd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 08:18:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UAx9c8012998;
        Thu, 30 Sep 2021 12:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=OwNh0FMAx2fDU1awHlqAJv96tWxTOf7aN7biiyHy7Hc=;
 b=OFa6iHPjaqdZIjJ0m2lGZo/pNjpqKEMKoAxj2Z8Qah6v1bZEXnMYdmusA4Ym30sy5akf
 YLGPr2QFqWrqUFuQDhCb7Rk69mS5Sel5GiNdleIbZ9ynfT8Z9vGdlGx5K15528uMWr1U
 l8vR5wR82NI1yv9hCqjaRMR45U0lysRSOsnICrZCgdYr7pGknYGSH5CXo9JlF7M5klNR
 4w5jhgWukvRDeT9ZHqLy1yOkRS6DJQ/zetv+j9EUTxIU8eNNk+s0YYPhmMNZ9mDkX9XW
 4fImNIw3j5F0+2TIL7dncEKOvW4p8lsPX48tVnJRBslCgExkF3+rM5qE5rsazR8CZemO 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bchfm24x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:16:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UCFAPV017015;
        Thu, 30 Sep 2021 12:16:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by aserp3030.oracle.com with ESMTP id 3bd5wb08wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 12:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbaqDAAz8VM1sPEbnTxR08e4lBZ2Sq8plNnjLAoKyflEP/a9K2mg4mVDbIfozXGPKd/s4utrGymbqMZflmWtLhcsvFccUx/wK5Y2ltcClDFmuiK3HAbxLEtrOtFg9uYyKQ+TCN9Uk70LHk2vV9xMhQICwpCyKMzCvTOpqkn1kO92ZWAtLIe/b0I0MDJWnPK7Cf7ckibRbo1vRQY3yOWSN1tzFfxX9Yr3iTmaKmbW906CjPw21TYkNJG2LSwQnOKUPeOaEHQcX2isecfWgz3WH3AOHBG2Vu5pMziU1i3BaKOlW1kGHMf34Yv6x0vbe594yubh+2mBd65F2c1HBtZt8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OwNh0FMAx2fDU1awHlqAJv96tWxTOf7aN7biiyHy7Hc=;
 b=MJTY6WwQ7W6H+HIUBb+/gOO9u63UalyUWgpgpGMe+WsXYE6lybxBUdZrMKpFBejw+I3irKXFGfVPj8wfrr8YJShMAn7RaE9/gmJeD6BV62AAsWT2ycCd7VncRNa7eNUEpu1K4mEvOnzxjj3EH4sDq5/q6xUXCaI/TT86jEDBNtaQQvHqYhl99TjBFFdcNWFpR3hEt4qxlLfYdrKGyHAaS3cQjXyjIpclUKmt4Ji8L/OYp6Sy2LVOSrO/ENRwiKoaiLzJS2otfY12Ru7lLGbN02JVDjZ0Y3hkvxvc4FnPmXoDPMOcYIf7L1y4tJ3G5GYs2u5p/L3tmcPtHIRbSk7jUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwNh0FMAx2fDU1awHlqAJv96tWxTOf7aN7biiyHy7Hc=;
 b=FB2wdq/kzGJwcONwLD+sihHftlPBw9LvEJH7jXr5rzYtjEfDQNjxUx6HzYNgC6cudjUs4CiC8kd8QExqQ5yXci4KSUTBlBBRk1e9BWsNvcvF1eEWpSG7VUxbw98d49omo/V9Q2NbMAk/R58AjQg710Vi1FCZsBisQTsG+/wPyVw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4141.namprd10.prod.outlook.com (2603:10b6:208:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 30 Sep
 2021 12:16:45 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%7]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 12:16:44 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     nborisov@suse.com
Subject: [PATCH v7] btrfs: consolidate device_list_mutex in prepare_sprout to its parent
Date:   Thu, 30 Sep 2021 20:16:27 +0800
Message-Id: <6585e7d938e6600189c1bc7b61a7c76badef18dd.1633003671.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG2PR02CA0052.apcprd02.prod.outlook.com (2603:1096:4:54::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend Transport; Thu, 30 Sep 2021 12:16:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1442f8ef-c108-4c19-e537-08d9840c2b14
X-MS-TrafficTypeDiagnostic: MN2PR10MB4141:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4141B869C0000FD3C24828FEE5AA9@MN2PR10MB4141.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbL7evYV4b4s1KK6GIXpCl4AAhTIiJmTOCgz7d+wGHQEtENItfniTj6WZVH1SSGeeyW01va5Z8tYCp7K1xcsJERGbcDHxsB/FbTq2N0ac7nasfwlRWn+/lteslrHF9FK2EO+Zf1wuS6uEp5Hk8vzk3KJlsCxRlrWIzofp8uB5yoVrvnAUQbXuc2mb0v2vdUXBjCuLgVAUW830W1ONX9Pn+xKLyFiFzmIUopwxTNUKr69MrvWy/i4aPBd2T5UBayGLk5YFRAdtzk5q9VKATG09NMVAlEsFkN5sfPBJ1oQvSV07VS8ogQSGeSciYv52GbXVPl/XNLa/QOa5LDQ/NRWxx2ICYZbfUj5MT4pMRujEjSej2zeHGtgKIRj534eyFAJFo4bkPhqT3AxaGiYprq0J+jkNH5dZF4/27DQsXx03vpZn14uzM0+GW3chV3GmXJMZaV97mVXtNY+tHRoG4jE0TxNBuWpLlPg8XCAFYh/tW+Qn75Uqmt/Oyj1IFitVJmh1BToh9rATB9b3S3wcL4aJSGIZqAz9L3dy/CqnlFzWBEl0zWWeLuJE+cakQoB8OpqxLQ4CdP/Z5fzI0cW4Qyx6X9WMG6QoV4IsSF6kq3TqtzsbHTEXP6ul9cujKyNhlqVuCBNML9RLo6Wv3DTynschs3w5e6X9vgmy+9EMTxur0q4oM/J1MvxwHNJyvb1ZMnV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(66476007)(66556008)(2616005)(66946007)(316002)(6512007)(8676002)(508600001)(36756003)(6486002)(44832011)(6666004)(4326008)(52116002)(6506007)(6916009)(8936002)(2906002)(186003)(86362001)(38100700002)(38350700002)(26005)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wgqk+J/BID3iIqYyQtqoxrlFFB/lgyQPeEZFRzuleyI3fwbAqYDHSP7HPqd5?=
 =?us-ascii?Q?mbYmSqaYDf7MdkuNG3n0Th4YH+3R3FOr3AmxeRTVjAZ7L7JSmMMGPel6Mv0e?=
 =?us-ascii?Q?/2t6lzh9dMNJQQ0eVH+KVo+7kUmkT5x2SRXf4c6T8C5g7+DuA4fIFcVlAyy3?=
 =?us-ascii?Q?BmjEUTkRfs/ROE5hS70HXvZM5pVu93UNMQktL2hnmhcSbRgnKWDgKwiVk7xu?=
 =?us-ascii?Q?We6NCRVloX5bLrvcKjMRnHRPBIAW9NQl8WDX9fANgYHbMkG6H0aNumGAy/Xj?=
 =?us-ascii?Q?MQASZjZT9hFIpF9fQiRQLPNHJJkJJeJXSvRaL03BtgMflWCLbmdS7YVg4iby?=
 =?us-ascii?Q?We9YC7qVxKJVHO0pXwJRT2vqm3Dhb4LM1IVa9LPyk2Lz7IbDlq7DesxmlOil?=
 =?us-ascii?Q?2vmqXkH+P5WqnAJHUENjj6Ht6JsTbeLf9LpKew0yjkMYoZJMz86Yr4Er7XFE?=
 =?us-ascii?Q?WQjWKYko7BRulTY8AY/2dK01gHpLo0XNyUxyNRmHp2Ve7B3wX7c1/EUKiQHu?=
 =?us-ascii?Q?R/puOyW0kdJPbhnGbBxPmS9lOPp6BuY9CntaqcXF230W57JAqMQs4VAUS8sn?=
 =?us-ascii?Q?UldfTWnGXfM6Uk8v30ldFjC/mL0S7CD2HD5yT+glYE67ImgR9Au6VKYBaf0H?=
 =?us-ascii?Q?OskaIPFMZdqxWoK3r/Udmg0mE3oV6aIt7UxrKUshtrVLZgFd/li380eKyKiR?=
 =?us-ascii?Q?M6q1if4dGyK7cWdac0SUZGEdlNrqx9UdKqAddK6ZmeCVyNq6xVEVRPSLN9QW?=
 =?us-ascii?Q?OOLwLjc6zR7Pb4X0g0O/6UvQ8DS6DfOKLETgMzxuD8NxxCCpPT18aidbjmQB?=
 =?us-ascii?Q?aE2+6gOYqByZwi3qyDfNhOGJ3UWPXhcET58zGOG7DUr3HNQvYNtA+o1spPp+?=
 =?us-ascii?Q?9iB/ZNxr948ECEdmEebXqrc+22CGcaG9IFgaOjWSxvD5iG4Zn9KTeI46Kesg?=
 =?us-ascii?Q?3e+ZsLBysKHnSauAsHJNAcbI0dV9Wmd8qnvlofgw8hXvSFE8tw1d5D0uRPjX?=
 =?us-ascii?Q?vvqJXXvN0ZV+ZOOO9WGsqa4/pT1qWIIZzFZBFR/EcbeJol/E2/Ixi7Ld1DPm?=
 =?us-ascii?Q?76ZqTrHRQYm7AKnhPMj8fh5zw/NHgT66U00ntVoYk4vjZ1q/o3BWjkLHuM/0?=
 =?us-ascii?Q?elZHbEoQA7wwL9pcK20NhWR2Y8LP7gGeK07WUpp6QBMzjeW7UtgkTfTcfMB/?=
 =?us-ascii?Q?Pq6lXwaM0KqxLHQMDO22TKrp5dRQwJYJJZgJ0CVy0GXXlv2eZ41F828s+xpY?=
 =?us-ascii?Q?mICAB8RexnbNvO9dl73EaZ4XKqWTlwRiaWcX8LX8DyK3XkThGJ7r0YijJRjm?=
 =?us-ascii?Q?VQCWLSZ1z/8+AxJd07kBxtci?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1442f8ef-c108-4c19-e537-08d9840c2b14
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 12:16:44.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faQjH9navdo0I7V8oCW1iG50cSkNWUHlZFgyEMiV49ZHXEt3Wro/5OU1dReKm0yvW083gSueorkzXdXjLDC/Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4141
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10122 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300078
X-Proofpoint-ORIG-GUID: L5kOWtTt4v-zhCF7a0XrZen8Xg84y0IQ
X-Proofpoint-GUID: L5kOWtTt4v-zhCF7a0XrZen8Xg84y0IQ
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_prepare_sprout() splices seed devices into its own struct fs_devices,
so that its parent function btrfs_init_new_device() can add the new sprout
device to fs_info->fs_devices.

Both btrfs_prepare_sprout() and btrfs_init_new_device() needs
device_list_mutex. But they are holding it sequentially, thus creates a
small window to an opportunity to race. Close this opportunity and hold
device_list_mutex common to both btrfs_init_new_device() and
btrfs_prepare_sprout().

This patch splits btrfs_prepare_sprout() into btrfs_alloc_sprout() and
btrfs_splice_sprout(). This split is essential because device_list_mutex
shouldn't be held for btrfs_alloc_sprout() but must be held for
btrfs_splice_sprout(). So now a common device_list_mutex can be used
between btrfs_init_new_device() and btrfs_splice_sprout().

This patch also moves the lockdep_assert_held(&uuid_mutex) from the
starting of the function to just above the line where we need this lock.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v7:
 . Not part of the patchset "btrfs: cleanup prepare_sprout" anymore as
 1/3 is merged and 2/3 is dropped.
 . Rename btrfs_alloc_sprout() to btrfs_init_sprout() as it does more
 than just alloc and change return to btrfs_device *.
 . Rename btrfs_splice_sprout() to btrfs_setup_sprout() as it does more
 than just the splice.
 . Add lockdep_assert_held(&uuid_mutex) and
 lockdep_assert_held(&fs_devices->device_list_mutex) in btrfs_setup_sprout().

v6:
 Remove RFC.
 Split btrfs_prepare_sprout so that the allocation part can be outside
 of the device_list_mutex in the parent function btrfs_init_new_device().

 fs/btrfs/volumes.c | 73 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8e2b76b5fd14..10227b13a1a6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2378,21 +2378,14 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 	return btrfs_find_device_by_path(fs_info, device_path);
 }
 
-/*
- * does all the dirty work required for changing file system's UUID.
- */
-static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
+static struct btrfs_fs_devices *btrfs_init_sprout(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_fs_devices *old_devices;
 	struct btrfs_fs_devices *seed_devices;
-	struct btrfs_super_block *disk_super = fs_info->super_copy;
-	struct btrfs_device *device;
-	u64 super_flags;
 
-	lockdep_assert_held(&uuid_mutex);
 	if (!fs_devices->seeding)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * Private copy of the seed devices, anchored at
@@ -2400,7 +2393,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	 */
 	seed_devices = alloc_fs_devices(NULL, NULL);
 	if (IS_ERR(seed_devices))
-		return PTR_ERR(seed_devices);
+		return seed_devices;
 
 	/*
 	 * It's necessary to retain a copy of the original seed fs_devices in
@@ -2411,9 +2404,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	old_devices = clone_fs_devices(fs_devices);
 	if (IS_ERR(old_devices)) {
 		kfree(seed_devices);
-		return PTR_ERR(old_devices);
+		return old_devices;
 	}
 
+	lockdep_assert_held(&uuid_mutex);
 	list_add(&old_devices->fs_list, &fs_uuids);
 
 	memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
@@ -2422,7 +2416,41 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 	mutex_init(&seed_devices->device_list_mutex);
 
-	mutex_lock(&fs_devices->device_list_mutex);
+	return seed_devices;
+}
+
+/*
+ * Splice seed devices into the sprout fs_devices.
+ * Generate a new fsid for the sprouted readwrite btrfs.
+ */
+static void btrfs_setup_sprout(struct btrfs_fs_info *fs_info,
+			       struct btrfs_fs_devices *seed_devices)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_super_block *disk_super = fs_info->super_copy;
+	struct btrfs_device *device;
+	u64 super_flags;
+
+	/*
+	 * We are updating the fsid, the thread leading to device_list_add()
+	 * could race, so uuid_mutex is needed.
+	 */
+	lockdep_assert_held(&uuid_mutex);
+
+	/*
+	 * Below threads though they parse dev_list they are fine without
+	 * device_list_mutex:
+	 *   All device ops and balance - as we are in btrfs_exclop_start.
+	 *   Various dev_list read parser - are using rcu.
+	 *   btrfs_ioctl_fitrim() - is using rcu.
+	 *
+	 * For-read threads as below are using device_list_mutex:
+	 *   Readonly scrub btrfs_scrub_dev()
+	 *   Readonly scrub btrfs_scrub_progress()
+	 *   btrfs_get_dev_stats()
+	 */
+	lockdep_assert_held(&fs_devices->device_list_mutex);
+
 	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
 			      synchronize_rcu);
 	list_for_each_entry(device, &seed_devices->devices, dev_list)
@@ -2438,13 +2466,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	generate_random_uuid(fs_devices->fsid);
 	memcpy(fs_devices->metadata_uuid, fs_devices->fsid, BTRFS_FSID_SIZE);
 	memcpy(disk_super->fsid, fs_devices->fsid, BTRFS_FSID_SIZE);
-	mutex_unlock(&fs_devices->device_list_mutex);
 
 	super_flags = btrfs_super_flags(disk_super) &
 		      ~BTRFS_SUPER_FLAG_SEEDING;
 	btrfs_set_super_flags(disk_super, super_flags);
-
-	return 0;
 }
 
 /*
@@ -2532,6 +2557,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct super_block *sb = fs_info->sb;
 	struct rcu_string *name;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_fs_devices *seed_devices;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int ret = 0;
@@ -2615,18 +2641,25 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	if (seeding_dev) {
 		btrfs_clear_sb_rdonly(sb);
-		ret = btrfs_prepare_sprout(fs_info);
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
+
+		/* GFP_KERNEL alloc should not be under device_list_mutex */
+		seed_devices = btrfs_init_sprout(fs_info);
+		if (IS_ERR(seed_devices)) {
+			btrfs_abort_transaction(trans, (int)PTR_ERR(seed_devices));
 			goto error_trans;
 		}
+	}
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	if (seeding_dev) {
+		btrfs_setup_sprout(fs_info, seed_devices);
+
 		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
 						device);
 	}
 
 	device->fs_devices = fs_devices;
 
-	mutex_lock(&fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_add_rcu(&device->dev_list, &fs_devices->devices);
 	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
@@ -2688,7 +2721,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 		/*
 		 * fs_devices now represents the newly sprouted filesystem and
-		 * its fsid has been changed by btrfs_prepare_sprout
+		 * its fsid has been changed by btrfs_sprout_splice().
 		 */
 		btrfs_sysfs_update_sprout_fsid(fs_devices);
 	}
-- 
2.31.1

