Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882F929E4C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 08:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbgJ2HrA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 03:47:00 -0400
Received: from out20-74.mail.aliyun.com ([115.124.20.74]:36802 "EHLO
        out20-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733195AbgJ2HqL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0896989-0.00029668-0.910004;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IptkHuJ_1603949757;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.IptkHuJ_1603949757)
          by smtp.aliyun-inc.com(10.147.42.241);
          Thu, 29 Oct 2020 13:35:58 +0800
From:   wangyugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kreijack@libero.it, wangyugui <wangyugui@e16-tech.com>
Subject: [PATCH 2/4] btrfs: tiering data and metadata
Date:   Thu, 29 Oct 2020 13:35:54 +0800
Message-Id: <20201029053556.10619-3-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029053556.10619-1-wangyugui@e16-tech.com>
References: <20201029053556.10619-1-wangyugui@e16-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This based the patch 'btrfs: add ssd_metadata mode' from Goffredo Baroncelli <kreijack@libero.it>

In most case, only 1 or 2 tiers are used at the same time, so we group them into
top tier and other tier(s).

We define a mount option to tiering data/metadata to slower/faster device(s)
When there is only 1 tier, tiering is auto disabled.

mount option: tier[={off|auto|data_tier_X/metadata_tier_Y}]
default is 'tier[=auto]'. 'tier' is same as 'tier=auto', 'tier=OF/TF'
the policies to use the device(s):
    Top-tier-Only(TO)       : metadata only use top-tier device.
    Top-tier-Firstly(TF)    : metadata use top-tier device firstly.
    Other-tier-First(OF)    : data use other-tier device firstly.
    Other-tier-Only(OO)     : data only use other-tier device.
data_tier_X is the policy for data, support OF, OO.
metadata_tier_Y is the policy for metadata and system, support TF.

Signed-off-by: wangyugui <wangyugui@e16-tech.com>
---
 fs/btrfs/ctree.h   | 17 ++++++++++
 fs/btrfs/super.c   | 72 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c | 80 ++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index aac3d6f..812d231 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -574,6 +574,20 @@ enum btrfs_exclusive_operation {
 	BTRFS_EXCLOP_SWAP_ACTIVATE,
 };
 
+/*
+ * tier policy for btrfs data/metadata
+ * FIXME: per-subvol tier policy for full tier support.
+ * FIXME: per-subvol profile(RAID) is needed for full tier support too.
+ */
+enum btrfs_tier_policy
+{
+	NOT_TIERING,
+	TOP_TIER_ONLY,		/* TO */
+	TOP_TIER_FIRSTLY,	/* TF */
+	OTHER_TIER_FIRSTLY, /* OF */
+	OTHER_TIER_ONLY,	/* OO */
+};
+
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
@@ -831,6 +845,9 @@ struct btrfs_fs_info {
 	u64 avail_metadata_alloc_bits;
 	u64 avail_system_alloc_bits;
 
+	enum btrfs_tier_policy data_tier_policy;
+	enum btrfs_tier_policy metadata_tier_policy;
+
 	/* restriper state */
 	spinlock_t balance_lock;
 	struct mutex balance_mutex;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 8840a4f..c8dfa89 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -375,6 +375,7 @@ enum {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
 #endif
+	Opt_tier, Opt_tier_policy,
 	Opt_err,
 };
 
@@ -449,6 +450,8 @@ static const match_table_t tokens = {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	{Opt_ref_verify, "ref_verify"},
 #endif
+	{Opt_tier, "tier"},
+	{Opt_tier_policy, "tier=%s"},
 	{Opt_err, NULL},
 };
 
@@ -501,6 +504,40 @@ out:
 	return ret;
 }
 
+static const char *btrfs_tier_policy_names[] = {
+	[NOT_TIERING] = "NO",
+	[TOP_TIER_ONLY] = "TO",
+	[TOP_TIER_FIRSTLY] = "OF",
+	[OTHER_TIER_FIRSTLY] = "OF",
+	[OTHER_TIER_ONLY] = "OO"};
+
+struct btrfs_tier_option {
+	const char *name;
+	enum btrfs_tier_policy data_tier_policy;
+	enum btrfs_tier_policy metadata_tier_policy;
+};
+
+static const struct btrfs_tier_option btrfs_tier_options[] = {
+	{"off", NOT_TIERING, NOT_TIERING},
+	{"auto", OTHER_TIER_FIRSTLY, TOP_TIER_FIRSTLY},
+	{"OF/TF", OTHER_TIER_FIRSTLY, TOP_TIER_FIRSTLY},
+	{"OO/TF", OTHER_TIER_ONLY, TOP_TIER_FIRSTLY}};
+
+static int parse_tier_options(struct btrfs_fs_info *info, const char *option)
+{
+	int i;
+	for (i = 0; i < sizeof(btrfs_tier_options) / sizeof(btrfs_tier_options[0]); ++i)
+	{
+		if (strcmp(option, btrfs_tier_options[i].name) == 0)
+		{
+			info->data_tier_policy = btrfs_tier_options[i].data_tier_policy;
+			info->metadata_tier_policy = btrfs_tier_options[i].metadata_tier_policy;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
 /*
  * Regular mount options parser.  Everything that is needed only when
  * reading in a new superblock is parsed here.
@@ -527,6 +564,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 	else if (cache_gen)
 		btrfs_set_opt(info->mount_opt, SPACE_CACHE);
 
+	/* default tier=auto */
+	info->data_tier_policy = OTHER_TIER_FIRSTLY;
+	info->metadata_tier_policy = TOP_TIER_FIRSTLY;
+
 	/*
 	 * Even the options are empty, we still need to do extra check
 	 * against new flags
@@ -959,6 +1000,15 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, REF_VERIFY);
 			break;
 #endif
+		case Opt_tier:
+			info->data_tier_policy = OTHER_TIER_FIRSTLY;
+			info->metadata_tier_policy = TOP_TIER_FIRSTLY;
+			break;
+		case Opt_tier_policy:
+			ret = parse_tier_options(info, args[0].from);
+			if (ret < 0)
+				goto out;
+			break;
 		case Opt_err:
 			btrfs_err(info, "unrecognized mount option '%s'", p);
 			ret = -EINVAL;
@@ -988,6 +1038,18 @@ out:
 		btrfs_info(info, "disk space caching is enabled");
 	if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
 		btrfs_info(info, "using free space tree");
+	if (!ret){
+		if(info->data_tier_policy == NOT_TIERING &&
+			info->metadata_tier_policy == NOT_TIERING)
+			btrfs_info(info, "disabled tiering(tier=off)");
+		else if(info->data_tier_policy == OTHER_TIER_FIRSTLY &&
+			info->metadata_tier_policy == TOP_TIER_FIRSTLY)
+			btrfs_info(info, "enabling tiering(tier=auto)");
+		else
+			btrfs_info(info, "enabling tiering(tier=%s/%s)",
+				btrfs_tier_policy_names[info->data_tier_policy],
+				btrfs_tier_policy_names[info->metadata_tier_policy]);
+	}
 	return ret;
 }
 
@@ -1472,6 +1534,16 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	if(info->data_tier_policy == NOT_TIERING &&
+		info->metadata_tier_policy == NOT_TIERING)
+		seq_puts(seq, ",tier=off");
+	else if(info->data_tier_policy == OTHER_TIER_FIRSTLY &&
+		info->metadata_tier_policy == TOP_TIER_FIRSTLY)
+		seq_puts(seq, ",tier"); /* or ",tier=auto"? */
+	else
+		seq_printf(seq, ",tier=%s/%s",
+		btrfs_tier_policy_names[info->data_tier_policy],
+		btrfs_tier_policy_names[info->metadata_tier_policy]);
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	subvol_name = btrfs_get_subvol_name_from_objectid(info,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index efffcbc..2a422ac 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4816,6 +4816,44 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
 	return 0;
 }
 
+/*
+ * sort the devices in descending order by tier_score,
+ * max_avail, total_avail
+ */
+static int btrfs_cmp_device_info_metadata(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+
+	/* higher tier_score firstly for metadata */
+	if (di_a->dev->tier_score > di_b->dev->tier_score)
+		return -1;
+	if (di_a->dev->tier_score < di_b->dev->tier_score)
+		return 1;
+
+	return btrfs_cmp_device_info(a,b);
+}
+
+/*
+ * sort the devices in ascending order by tier_score,
+ * max_avail, total_avail
+ */
+static int btrfs_cmp_device_info_data(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+
+	/* lower tier_score firstly for data */
+	if (di_a->dev->tier_score > di_b->dev->tier_score)
+		return 1;
+	if (di_a->dev->tier_score < di_b->dev->tier_score)
+		return -1;
+
+	return btrfs_cmp_device_info(a,b);
+}
+
+
+
 static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 {
 	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
@@ -4931,6 +4969,8 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	int ndevs = 0;
 	u64 max_avail;
 	u64 dev_offset;
+	int top_tier_score = 0;
+	int nr_top_tier = 0;
 
 	/*
 	 * in the first pass through the devices list, we gather information
@@ -4983,15 +5023,51 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		devices_info[ndevs].max_avail = max_avail;
 		devices_info[ndevs].total_avail = total_avail;
 		devices_info[ndevs].dev = device;
+		if (devices_info[ndevs].dev->tier_score > top_tier_score) {
+			top_tier_score = devices_info[ndevs].dev->tier_score;
+			nr_top_tier = 1;
+		} else if (devices_info[ndevs].dev->tier_score == top_tier_score) {
+			nr_top_tier++;
+		}
 		++ndevs;
 	}
 	ctl->ndevs = ndevs;
 
+	BUG_ON(nr_top_tier > ndevs);
 	/*
 	 * now sort the devices by hole size / available space
 	 */
-	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
-	     btrfs_cmp_device_info, NULL);
+	if (nr_top_tier == ndevs ||
+		((ctl->type & BTRFS_BLOCK_GROUP_DATA) && info->data_tier_policy == NOT_TIERING) ||
+		(!(ctl->type & BTRFS_BLOCK_GROUP_DATA) && info->metadata_tier_policy == NOT_TIERING) ||
+		((ctl->type & BTRFS_BLOCK_GROUP_DATA) && (ctl->type & BTRFS_BLOCK_GROUP_METADATA))) {
+			/* 1 tier only; NOT_TIERING; mixed bg */
+			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+				 btrfs_cmp_device_info, NULL);
+		}
+	else
+	{
+		/*
+		 * if tiering, sort the device considering also the tier_score.
+		 * Limit the availables devices to the ones
+		 * of the same kind, to avoid that a striped profile like raid5
+		 * spans to all kind of devices.
+		 * It is allowed to span different kind of devices if the ones of
+		 * the same kind are not enough alone.
+		 */
+		if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
+			int nr_other_tier = ndevs - nr_top_tier;
+			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+				     btrfs_cmp_device_info_data, NULL);
+			if (nr_other_tier >= ctl->devs_min || info->data_tier_policy == OTHER_TIER_ONLY)
+				ndevs = nr_other_tier;
+		} else { /* non data -> metadata and system */
+			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+				     btrfs_cmp_device_info_metadata, NULL);
+			if (nr_top_tier >= ctl->devs_min || info->metadata_tier_policy == TOP_TIER_ONLY)
+				ndevs = nr_top_tier;
+		}
+	}
 
 	return 0;
 }
-- 
2.29.1

