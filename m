Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C42412DEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 06:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhIUEfZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 00:35:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:16584 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhIUEfX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 00:35:23 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L47Wv1007424;
        Tue, 21 Sep 2021 04:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=p33w5FOe7jKumaa/gC2avNNKMRFAZ7FwwUAcHVT71y0=;
 b=iiZWuWFS830qRvEh8l9VRaeLP1wMYjGHGlhSeiDBFlLCGZgQOrpHJGbgPuLB66o106Sr
 6MH39DWiuuu/BqOmy1G8HxV8yVVIkbsbrIdmOtDPudx+4/R1PZJQU+QNYd++JC8+gnls
 4HnNggHpMx6E4DGbNELABXOVQnBdD740uO5TBdEAW3JBv6a+8ZTRVJqusmqKNpRXv1B7
 Dffo1C8ceF1v4/cs39014/E23O//oEiYtAmVFC96l/mNqUeJ/eVwE5qc/ao+LT7OpgeX
 OGocpK/BHGsFvT3YnkHHLnIcJFQVBBove/5cE3dTScsbwgCAOMeXOajLfNygh7pZw84/ xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b783er26v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 04:33:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18L4VXH8144541;
        Tue, 21 Sep 2021 04:33:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by userp3030.oracle.com with ESMTP id 3b557wfk3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 04:33:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGuxbu5EuJl3ZzUvS0eaRagwlqXsCZRNQ8KewtymqlQ+o8dTSr7suw2vq72qLAKDff5ClexUUORz2ldKxW8WvXfyGPw2BOb1tUAGQJ0GuVkhmg03CTPrmlhZaPM0dCcWra5v+02mSTRI6pq1BM6F4I11fCU+b3n+ac7Bhf0U8YnizgXwBCx6VUwp0lH4/SIAkBqabEw4YYSBGxr6P1fD7C5JiKpu9Ev7pG0WAJM5G5EyEnGFsdnxtLisYCZWDa3KdfUA9yDGljDQ+WFkQri3wcN4DBDWeqxALOJ4HAU87xGnQVTV6Gp76v7GWiOiDByDuQ8LEDLDachgAFu6rC9YRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=p33w5FOe7jKumaa/gC2avNNKMRFAZ7FwwUAcHVT71y0=;
 b=gSan6idtfiCSmsbhL9t33g+SSX5k1LEVxAcTqz4CcNaeIO+wdWxiWcyzqsepwjS4G/xAgCJsGeKoQFEZxRVSs3HV78KXpOJW94mH/eFj0QaGhLG802OMxzpufuX0LYJFi0B26JNIV8AHgbutDGqbV++6F7wFArg6LFBws+O3N7uKLtChxT+RyQg051Rsur8deoPGslFKGx5cHZQ9hGscK7SvPJGsDAwmKDLlz66gzYFdSRdJwG2mXwdW4edT0wXk/c3qWAfbt2UWXJb2NcMHX748oUgQJ3+AnucX5mJcr43R0dfwF589MYjshA/ymArewSjqXvOStNwq/TdQ+pUUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p33w5FOe7jKumaa/gC2avNNKMRFAZ7FwwUAcHVT71y0=;
 b=JNHSRyS28W9TL03/Lex/gdOBI5Vk2p47gcB4oGg4XWfwaOllZtLrAyctlmMwLCsWswF77lPLYrXhY8/MTlxxnVSgOkiXxGAff08vg/GR4V8QjzOQqR4ITwseI+ykutQFo5IcZFEUxwG7uxVJjCt4ZUMNBFzQNsaISIUSkH37/sI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB3984.namprd10.prod.outlook.com (2603:10b6:208:1bf::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 04:33:48 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4500.018; Tue, 21 Sep 2021
 04:33:48 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH v6 3/3] btrfs: consolidate device_list_mutex in prepare_sprout to its parent
Date:   Tue, 21 Sep 2021 12:33:25 +0800
Message-Id: <ec3ecca596bf5d9de5e152942a277ab48915f0cf.1632179897.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632179897.git.anand.jain@oracle.com>
References: <cover.1632179897.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0129.apcprd03.prod.outlook.com
 (2603:1096:4:91::33) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from localhost.localdomain (39.109.140.76) by SG2PR03CA0129.apcprd03.prod.outlook.com (2603:1096:4:91::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.7 via Frontend Transport; Tue, 21 Sep 2021 04:33:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38629b15-5199-4e45-970a-08d97cb900ed
X-MS-TrafficTypeDiagnostic: MN2PR10MB3984:
X-Microsoft-Antispam-PRVS: <MN2PR10MB398402F5A44146F75B6E648BE5A19@MN2PR10MB3984.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEmsLsl43qtY8wyZPlpy1mZPv9UIR2ccxJ83V4QH4zDAD+3/idnEGNiDOcKVVf34MHNyDJzubPs4xpR6ofMTnNCuhXMYs+KjStgJruFQdxheRNQ5UPKlIu/yOX6SiSMoJZtqFNHkm2Jjy2qs0r8LdBnd4lo6yIuibNUvn6JTDQkkvIaV28ISkXFlr6KNks84d13RPUn60T6YC9Egp8pefmEZ8O+uwpdGk9tkVwNv1Aod8iL6cqL6N++trV2qQsmtY3vfzuOD38gkgMS8I2HuVf8imV2FyuXWaminEe7CPrWDnC3M5+iQrt/O7OynBVAeyNTmteEFpoWQ391xuM0AwRJw6zeWuMGmGjbMwGqO856JXSL8deu84xe7K++8q/mjzYWG5IetmgI3yylX/wYkrm/iU3nzOT137Q7E43qJTM350YxYaEgI0DMPx5PTbjpWMvSuPVC4ACL+lC4tPElm/ae4pH6+PD86X1e/XXYFTyHGOK3/CqHWX+7U0QVoqGvtqGHTcWpnqs1jHLrwnyLEf9qsk628t2AcfYaY75vGDUCiu2Zy2POSowxOMTvZK6drbJow6D8RkXfSqgB1cU7Y704W9aqr1YUOKjn3XM/zgZsP5CK+gwJomjYpH8LLt5ixlu10ZRncMfsoU6x2Z9PQk+CoA2mH4IKfVm0Jk/s7g3V6YWE6MnZDGLwhZmQD82+UzJOgR3OD7yeRlrTbmgPw9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(376002)(39860400002)(52116002)(2616005)(83380400001)(956004)(478600001)(66556008)(66946007)(8676002)(8936002)(6506007)(5660300002)(36756003)(6666004)(6512007)(38100700002)(2906002)(38350700002)(316002)(26005)(44832011)(186003)(86362001)(6486002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a6gW+kXlpG3CA1p9acIjNC8wI8EN64ya/QCXI/nF2MUEkXlCqlMBHWtLSVQD?=
 =?us-ascii?Q?OenwXQSEF4tPGrY1df0pQKrL+ZlmcnZ+73eT6e8MF+fXTrwHMxjfW5e3CXmv?=
 =?us-ascii?Q?x4SMLYHgTjjCrut6uF0WnaeX6PnjQFBnt2kX+q6ZEAn5vYUDRTeTISc9pJ69?=
 =?us-ascii?Q?QPWB09eHgRbQHAJ3814QT6G0i21akEHbhKQI8JSeVU6o4+kb+lCH6hxIA5IX?=
 =?us-ascii?Q?Olh6GwdsSgxYArW4esS4gMCvAhwUEGrgyvHLpFZBdW4i8Epw+g0iy3+UDiZB?=
 =?us-ascii?Q?qA1toFVVlXAH9gbLwtyPJ1rZg4y2KqUcyUTZS/GXOMIPsZyj1qECWX7+rKi9?=
 =?us-ascii?Q?+XNH8XgTwj3uXE7eztG0HSbsBR1cK4FSov8VymQjXZP9LgEbeWgXFZeWKzoO?=
 =?us-ascii?Q?EF+ZUkblRU69nCndwrrSn3dK4Fil8A9wb2B0eVl0FwaowFRI6zb2P3VDexBV?=
 =?us-ascii?Q?C047Jwakhp9x7UmVppd7lC5xius8si9rTcgJoa0RoPiCjhmj/NV74TYz3KSj?=
 =?us-ascii?Q?ZohS7pRRP6v2fbila1+R9gliVmBGle6gdaNmwTGzqLdhFkcoUP+ykqgzpQ14?=
 =?us-ascii?Q?zPEh7Minge94TMMoFkyIvcR3P8YxkZxXjqPAIge+eAaF9BmAwS0DTywX6L6j?=
 =?us-ascii?Q?h8WI5WHClRikTWgtZx3+FZyqmP7+CGYXks2Q+4LNEbwEoUgwbPL0YrhyDLA5?=
 =?us-ascii?Q?4l6I8Fl17EnuJTi7+hPorjLIiVX0OAj8PdTFqz6x+ex4LJk46E0vF9nIEZTf?=
 =?us-ascii?Q?vKzQij8QaENXMpNUMt6ph058+hTpW/LteNvURPWBtQwYHRBjKCDJ+PQbNvOf?=
 =?us-ascii?Q?/zjBp5N52/kiIXB5alRYYYfSUcu4tmo6UXLO8euTSEsnTWiAphlZyoamXJwo?=
 =?us-ascii?Q?FBEBXaCvHXXA2XqPoRzhe+yezS+/2qpNAfkTY9/Elr2XL9NGGp9pLqAIAuSH?=
 =?us-ascii?Q?HF8ktJ1qos9qODggem+M3Yx+TGi9PXfv2nxp72AW4ugSjw1f8+5nEW+A16+7?=
 =?us-ascii?Q?xFj642MHEQp9d3XAt1rbjapuhT6LRXs1QISdQTMcTUlyKqOqFzNBDRG2QMS5?=
 =?us-ascii?Q?24ciweXvyv+D9NdSKlUxaB+0Trb5IkJDWcAPc7P3NUnWBlT4UTpP0Ql9Y+NV?=
 =?us-ascii?Q?ejPS7/QTwKltLakDQ64mGH/8oNyVg6IYI2wGg0K7MZvapPs2kNA7SfFkeNLU?=
 =?us-ascii?Q?/vYd0qZMdzScSgqaBFJykIFzJDDGs3vAyXt20NAU2TvJgIbF+1YpLwmVfnzB?=
 =?us-ascii?Q?hlRNl1etusA8QWRpi8yMVzLrv/fs8/DSDyJC6hVI5Jgt4Hee6O+xfCI9ItZ+?=
 =?us-ascii?Q?1mnG0FtGv3ZvsSOhGw89PhVC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38629b15-5199-4e45-970a-08d97cb900ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 04:33:47.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtavwZ7GdqqjtBwc/c8ALcq569e/rFv0o1kng+N//5fYkmN/zzZA3fAbxmWnpyGDqhq33lrotX/vaS/3updvuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3984
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210026
X-Proofpoint-GUID: XlF5Fn75o-fSQhlj-rlxYzoixBJDpEVT
X-Proofpoint-ORIG-GUID: XlF5Fn75o-fSQhlj-rlxYzoixBJDpEVT
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
v6:
 Remove RFC.
 Split btrfs_prepare_sprout so that the allocation part can be outside
 of the device_list_mutex in the parent function btrfs_init_new_device().

 fs/btrfs/volumes.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e4079e25db70..b21eac32ec98 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2376,19 +2376,13 @@ struct btrfs_device *btrfs_find_device_by_devspec(
 	return btrfs_find_device_by_path(fs_info, device_path);
 }
 
-/*
- * does all the dirty work required for changing file system's UUID.
- */
-static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
+static int btrfs_alloc_sprout(struct btrfs_fs_info *fs_info,
+			      struct btrfs_fs_devices **seed_devices_ret)
 {
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 	struct btrfs_fs_devices *old_devices;
 	struct btrfs_fs_devices *seed_devices;
-	struct btrfs_super_block *disk_super = fs_info->super_copy;
-	struct btrfs_device *device;
-	u64 super_flags;
 
-	lockdep_assert_held(&uuid_mutex);
 	if (!fs_devices->seeding)
 		return -EINVAL;
 
@@ -2412,6 +2406,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 		return PTR_ERR(old_devices);
 	}
 
+	lockdep_assert_held(&uuid_mutex);
 	list_add(&old_devices->fs_list, &fs_uuids);
 
 	memcpy(seed_devices, fs_devices, sizeof(*seed_devices));
@@ -2419,7 +2414,23 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&seed_devices->devices);
 	INIT_LIST_HEAD(&seed_devices->alloc_list);
 
-	mutex_lock(&fs_devices->device_list_mutex);
+	*seed_devices_ret = seed_devices;
+
+	return 0;
+}
+
+/*
+ * Splice seed devices into the sprout fs_devices.
+ * Generate a new fsid for the sprouted readwrite btrfs.
+ */
+static void btrfs_splice_sprout(struct btrfs_fs_info *fs_info,
+				struct btrfs_fs_devices *seed_devices)
+{
+	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_super_block *disk_super = fs_info->super_copy;
+	struct btrfs_device *device;
+	u64 super_flags;
+
 	list_splice_init_rcu(&fs_devices->devices, &seed_devices->devices,
 			      synchronize_rcu);
 	list_for_each_entry(device, &seed_devices->devices, dev_list)
@@ -2435,13 +2446,10 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
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
@@ -2529,6 +2537,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	struct super_block *sb = fs_info->sb;
 	struct rcu_string *name;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
+	struct btrfs_fs_devices *seed_devices;
 	u64 orig_super_total_bytes;
 	u64 orig_super_num_devices;
 	int ret = 0;
@@ -2612,18 +2621,25 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	if (seeding_dev) {
 		btrfs_clear_sb_rdonly(sb);
-		ret = btrfs_prepare_sprout(fs_info);
+
+		/* GFP_KERNEL alloc should not be under device_list_mutex */
+		ret = btrfs_alloc_sprout(fs_info, &seed_devices);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto error_trans;
 		}
+	}
+
+	mutex_lock(&fs_devices->device_list_mutex);
+	if (seeding_dev) {
+		btrfs_splice_sprout(fs_info, seed_devices);
+
 		btrfs_assign_next_active_device(fs_info->fs_devices->latest_dev,
 						device);
 	}
 
 	device->fs_devices = fs_devices;
 
-	mutex_lock(&fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
 	list_add_rcu(&device->dev_list, &fs_devices->devices);
 	list_add(&device->dev_alloc_list, &fs_devices->alloc_list);
@@ -2685,7 +2701,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 		/*
 		 * fs_devices now represents the newly sprouted filesystem and
-		 * its fsid has been changed by btrfs_prepare_sprout
+		 * its fsid has been changed by btrfs_sprout_splice().
 		 */
 		btrfs_sysfs_update_sprout_fsid(fs_devices);
 	}
-- 
2.31.1

