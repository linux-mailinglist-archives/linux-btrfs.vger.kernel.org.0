Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776C11B1FB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgDUHXd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 03:23:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52010 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgDUHXd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 03:23:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03L7J0GA123838;
        Tue, 21 Apr 2020 07:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=UI1gtjPJR+gz3lma5sGbr8Rhg7EllDUyYZjfJ07m7rY=;
 b=NDZml+Y8iPC2pPxAmrZ6JO6t1jlpIqbacNfFWdOBiIUv4memli17jqG37p5FAlsuWzQQ
 9/QhSUxPudT1Iw4h7flYVgqqx7Y78zuDsRWnWHbGr6jqTznZfRwVJrThOLQ2vSNp+44Z
 0eikSVsCK13CS/87aSIRP2wFwJW/PEiQiFJvbDX8sZw82Eni7v9WhOp4T5tvycKcvmlK
 eN0JhuSWL1vlFlYq2DbZ5DNtCsVOWxhtdEQXCA36/tDyjl9LwWmvQFq3WPsaV6v2Zbxk
 igK6+ZP7aENjJAOMlYsAvgFzHul0K3DL2nffMDnGl5Bk8FPyNj2yDFNi0Rg93n7/OJtx 8g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30grpgfras-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 07:23:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03L7IRPq015796;
        Tue, 21 Apr 2020 07:21:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30gbbd063s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 07:21:26 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03L7LOQx016042;
        Tue, 21 Apr 2020 07:21:24 GMT
Received: from localhost.localdomain (/39.109.243.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 00:21:23 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     marc@merlins.org
Subject: [PATCH] btrfs: boilerplate: devlist and fsinfo
Date:   Tue, 21 Apr 2020 15:21:15 +0800
Message-Id: <20200421072115.8258-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200321202307.GA15906@merlins.org>
References: <20200321202307.GA15906@merlins.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=3 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9597 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=3 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004210061
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Anand Jain <Anand.Jain@oracle.com>

** This patch is not for integration but to debug/visualize the
btrfs device tree and fs_info. **

usage:
	cat /proc/fs/btrfs/devlist
	cat /proc/fs/btrfs/fsinfo

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---

This patch can also be pulled from the branch boilerplate-v5.6
  git@github.com:asj/btrfs-boilerplate.git boilerplate-v5.6

 fs/btrfs/Makefile |   2 +-
 fs/btrfs/procfs.c | 600 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/procfs.h |   2 +
 fs/btrfs/super.c  |   6 +-
 4 files changed, 608 insertions(+), 2 deletions(-)
 create mode 100644 fs/btrfs/procfs.c
 create mode 100644 fs/btrfs/procfs.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 9a0ff3384381..8a894ee1d27b 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -11,7 +11,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
-	   block-rsv.o delalloc-space.o block-group.o discard.o
+	   block-rsv.o delalloc-space.o block-group.o discard.o procfs.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/procfs.c b/fs/btrfs/procfs.c
new file mode 100644
index 000000000000..6dc39bb31d9d
--- /dev/null
+++ b/fs/btrfs/procfs.c
@@ -0,0 +1,600 @@
+#include <linux/seq_file.h>
+#include <linux/vmalloc.h>
+#include <linux/proc_fs.h>
+#include "ctree.h"
+#include "volumes.h"
+#include "rcu-string.h"
+#include "procfs.h"
+
+#define BPSL	256
+
+#define BTRFS_PROC_PATH		"fs/btrfs"
+#define BTRFS_PROC_DEVLIST	"devlist"
+#define BTRFS_PROC_FSINFO	"fsinfo"
+
+//#define USE_ALLOC_LIST
+//#define VOL_FLAGS
+//#define FS_OPEN_RW
+#define BALANCE_RUNNING
+//#define OLD_PROC
+
+struct proc_dir_entry	*btrfs_proc_root;
+
+static void fs_state_to_str(struct btrfs_fs_info *fs_info, char *str)
+{
+	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+		strcat(str, "|ERROR");
+	if (test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state))
+		strcat(str, "|REMOUNTING");
+	if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state))
+		strcat(str, "|TRANS_ABORTED");
+	if (test_bit(BTRFS_FS_STATE_DEV_REPLACING, &fs_info->fs_state))
+		strcat(str, "|REPLACING");
+	if (test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state))
+		strcat(str, "|DUMMY");
+}
+
+static void fs_flags_to_str(struct btrfs_fs_info *fs_info, char *str)
+{
+	if (test_bit(BTRFS_FS_BARRIER, &fs_info->flags))
+		strcat(str, "|BARRIER");
+	if (test_bit(BTRFS_FS_CLOSING_START, &fs_info->flags))
+		strcat(str, "|CLOSING_START");
+	if (test_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags))
+		strcat(str, "|CLOSING_DONE");
+	if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags))
+		strcat(str, "|RECOVERING");
+	if (test_bit(BTRFS_FS_OPEN, &fs_info->flags))
+		strcat(str, "|OPEN");
+	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
+		strcat(str, "|QUOTA_ENABLED");
+	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
+		strcat(str, "|UPDATE_UUID_TREE_GEN");
+	if (test_bit(BTRFS_FS_CREATING_FREE_SPACE_TREE, &fs_info->flags))
+		strcat(str, "|FREE_SPACE_TREE");
+	if (test_bit(BTRFS_FS_BTREE_ERR, &fs_info->flags))
+		strcat(str, "|BTREE_ERR");
+	if (test_bit(BTRFS_FS_LOG1_ERR, &fs_info->flags))
+		strcat(str, "|LOG1_ERR");
+	if (test_bit(BTRFS_FS_LOG2_ERR, &fs_info->flags))
+		strcat(str, "|LOG2_ERR");
+	if (test_bit(BTRFS_FS_QUOTA_OVERRIDE, &fs_info->flags))
+		strcat(str, "|QUOTA_OVERRIDE");
+	if (test_bit(BTRFS_FS_FROZEN, &fs_info->flags))
+		strcat(str, "|FROZEN");
+	if (test_bit(BTRFS_FS_EXCL_OP, &fs_info->flags))
+		strcat(str, "|EXCL_OP");
+#ifdef BALANCE_RUNNING
+	if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags))
+		strcat(str, "|BALANCE_RUNNING");
+#else
+	if (atomic_read(&fs_info->balance_running))
+		strcat(str, "|BALANCE_RUNNING");
+#endif
+	if (atomic_read(&fs_info->balance_pause_req))
+		strcat(str, "|BALANCE_PAUSEREQ");
+	if (atomic_read(&fs_info->balance_cancel_req))
+		strcat(str, "|BALANCE_CANCELREQ");
+}
+
+static void balance_ctl_flags_to_str(struct btrfs_balance_control *bctl,
+				     char *str)
+{
+	if (BTRFS_BALANCE_DATA & bctl->flags)
+		strcat(str, "|DATA");
+	if (BTRFS_BALANCE_SYSTEM & bctl->flags)
+		strcat(str, "|SYSTEM");
+	if (BTRFS_BALANCE_METADATA & bctl->flags)
+		strcat(str, "|METADATA");
+	if (BTRFS_BALANCE_FORCE & bctl->flags)
+		strcat(str, "|FORCE");
+	if (BTRFS_BALANCE_RESUME & bctl->flags)
+		strcat(str, "|RESUME");
+}
+
+static char *bg_flags_to_str(u64 chunk_type, char *str)
+{
+	if (chunk_type & BTRFS_BLOCK_GROUP_RAID0)
+		strcat(str, "|RAID0");
+	if (chunk_type & BTRFS_BLOCK_GROUP_RAID1)
+		strcat(str, "|RAID1");
+	if (chunk_type & BTRFS_BLOCK_GROUP_RAID5)
+		strcat(str, "|RAID5");
+	if (chunk_type & BTRFS_BLOCK_GROUP_RAID6)
+		strcat(str, "|RAID6");
+	if (chunk_type & BTRFS_BLOCK_GROUP_DUP)
+		strcat(str, "|DUP");
+	if (chunk_type & BTRFS_BLOCK_GROUP_RAID10)
+		strcat(str, "|RAID10");
+	if (chunk_type & BTRFS_AVAIL_ALLOC_BIT_SINGLE)
+		strcat(str, "|ALLOC_SINGLE");
+
+	return str;
+}
+
+static void balance_args_to_str(struct btrfs_balance_args *bargs, char *str,
+				char *prefix)
+{
+	int ret = 0;
+
+	ret = sprintf(str, "\tbalance_args.%s\t", prefix);
+	str=str+ret;
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_SOFT)
+		strcat(str, "|SOFT");
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_PROFILES) {
+		strcat(str, "|profiles=");
+		str = bg_flags_to_str(bargs->profiles, str);
+		str=str+ret;
+	}
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_USAGE) {
+		ret = sprintf(str, "|usage=%llu ", bargs->usage);
+		str=str+ret;
+	}
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_USAGE_RANGE) {
+		ret = sprintf(str, "|usage_min=%u usage_max=%u",
+			      bargs->usage_min, bargs->usage_max);
+		str=str+ret;
+	}
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_DEVID) {
+		ret = sprintf(str, "|devid=%llu ", bargs->devid);
+		str=str+ret;
+	}
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_DRANGE) {
+		ret = sprintf(str, "|DRANGE pstart=%llu pend=%llu ",
+			      bargs->pstart, bargs->pend);
+		str=str+ret;
+	}
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_VRANGE) {
+		ret = sprintf(str, "|VRANGE vstart=%llu vend %llu",
+			      bargs->vstart, bargs->vend);
+		str=str+ret;
+	}
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_LIMIT) {
+		ret = sprintf(str, "|limit=%llu ", bargs->limit);
+		str=str+ret;
+	}
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_LIMIT_RANGE) {
+		ret = sprintf(str, "|limit_min=%u limit_max=%u",
+			      bargs->limit_min, bargs->limit_max);
+		str=str+ret;
+	}
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_STRIPES_RANGE) {
+		ret = sprintf(str, "|stripes_min=%u stripes_max=%u ",
+			bargs->stripes_min, bargs->stripes_max);
+		str=str+ret;
+	}
+
+	if (bargs->flags & BTRFS_BALANCE_ARGS_CONVERT) {
+		strcat(str, "|convert=");
+		str = bg_flags_to_str(bargs->target, str);
+	}
+}
+
+static void print_balance_args(struct btrfs_balance_args *bargs, char *prefix,
+				struct seq_file *seq)
+{
+#define BTRFS_SEQ_PRINT3(plist, arg)\
+		snprintf(__str, BPSL, plist, arg);\
+		seq_printf(seq, __str)
+	char __str[BPSL];
+
+	char tmp_str[BPSL];
+
+	memset(tmp_str, '\0', 256);
+	balance_args_to_str(bargs, tmp_str, prefix);
+	BTRFS_SEQ_PRINT3("%s\n", tmp_str);
+}
+
+static void balance_progress_to_str(struct btrfs_balance_progress *bstat, char *str)
+{
+	int ret=0;
+	ret = sprintf(str, "expected=%llu ", bstat->expected);
+	str=str+ret;
+	ret = sprintf(str, "considered=%llu ", bstat->considered);
+	str=str+ret;
+	ret = sprintf(str, "completed=%llu ", bstat->completed);
+}
+
+void btrfs_print_fsinfo(struct seq_file *seq)
+{
+	/* Btrfs Procfs String Len */
+#define BTRFS_SEQ_PRINT2(plist, arg)\
+		snprintf(str, BPSL, plist, arg);\
+		seq_printf(seq, str)
+
+	char str[BPSL];
+	char b[BDEVNAME_SIZE];
+	struct list_head *cur_uuid;
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_fs_devices *fs_devices;
+	struct list_head *fs_uuids = btrfs_get_fs_uuids();
+
+	seq_printf(seq, "\n#Its for debugging and experimental only, parameters may change without notice.\n\n");
+
+	list_for_each(cur_uuid, fs_uuids) {
+		char fs_str[256] = {0};
+		fs_devices  = list_entry(cur_uuid, struct btrfs_fs_devices, fs_list);
+		fs_info = fs_devices->fs_info;
+		if (!fs_info)
+			continue;
+
+		BTRFS_SEQ_PRINT2("[fsid: %pU]\n", fs_devices->fsid);
+		BTRFS_SEQ_PRINT2("\tsb->s_bdev:\t\t%s\n",
+				fs_info->sb->s_bdev ?
+				bdevname(fs_info->sb->s_bdev, b):
+				"null");
+		BTRFS_SEQ_PRINT2("\tlatest_bdev:\t\t%s\n",
+				fs_devices->latest_bdev ?
+				bdevname(fs_devices->latest_bdev, b):
+				"null");
+
+		fs_state_to_str(fs_info, fs_str);
+		BTRFS_SEQ_PRINT2("\tfs_state:\t\t%s\n", fs_str);
+
+		memset(fs_str, '\0', 256);
+		fs_flags_to_str(fs_info, fs_str);
+		BTRFS_SEQ_PRINT2("\tfs_flags:\t\t%s\n", fs_str);
+
+		BTRFS_SEQ_PRINT2("\tsuper_copy->flags\t0x%llx\n",
+				fs_info->super_copy->flags);
+		BTRFS_SEQ_PRINT2("\tsuper_for_commit->flags\t0x%llx\n",
+				fs_info->super_for_commit->flags);
+		BTRFS_SEQ_PRINT2("\tnodesize\t\t%u\n", fs_info->nodesize);
+		BTRFS_SEQ_PRINT2("\tsectorsize\t\t%u\n", fs_info->sectorsize);
+
+		if (fs_info->balance_ctl) {
+			memset(fs_str, '\0', 256);
+			balance_ctl_flags_to_str(fs_info->balance_ctl, fs_str);
+			BTRFS_SEQ_PRINT2("\tbalance_control\t\t%s\n", fs_str);
+
+			if (fs_info->balance_ctl->flags & BTRFS_BALANCE_DATA)
+				print_balance_args(&fs_info->balance_ctl->data, "data", seq);
+			if (fs_info->balance_ctl->flags & BTRFS_BALANCE_METADATA)
+				print_balance_args(&fs_info->balance_ctl->meta, "meta", seq);
+			if (fs_info->balance_ctl->flags & BTRFS_BALANCE_SYSTEM)
+				print_balance_args(&fs_info->balance_ctl->sys, "sys", seq);
+
+			memset(fs_str, '\0', 256);
+			balance_progress_to_str(&fs_info->balance_ctl->stat, fs_str);
+			BTRFS_SEQ_PRINT2("\tbalance_progress\t%s\n", fs_str);
+
+		} else {
+			BTRFS_SEQ_PRINT2("\tbalance_control\t\t%s\n", "null");
+		}
+
+		BTRFS_SEQ_PRINT2("\tdev_replace.replace_state\t\t%llu\n",
+				 fs_info->dev_replace.replace_state);
+		BTRFS_SEQ_PRINT2("\tdev_replace.time start\t\t%lld\n",
+				 fs_info->dev_replace.time_started);
+		BTRFS_SEQ_PRINT2("\tdev_replace.time stopped\t%lld\n",
+				 fs_info->dev_replace.time_stopped);
+		BTRFS_SEQ_PRINT2("\tdev_replace.cursor_left\t\t%llu\n",
+				 fs_info->dev_replace.cursor_left);
+		BTRFS_SEQ_PRINT2("\tdev_replace.committed_cursor_left\t%llu\n",
+				 fs_info->dev_replace.committed_cursor_left);
+		BTRFS_SEQ_PRINT2("\tdev_replace.cursor_left_last_write_of_item\t%llu\n",
+				 fs_info->dev_replace.cursor_left_last_write_of_item);
+		BTRFS_SEQ_PRINT2("\tdev_replace.cursor_right\t\t%llu\n",
+				 fs_info->dev_replace.cursor_right);
+		BTRFS_SEQ_PRINT2("\tdev_replace.cont_reading_from_srcdev_mode\t%llu\n",
+				 fs_info->dev_replace.cont_reading_from_srcdev_mode);
+		BTRFS_SEQ_PRINT2("\tdev_replace.is_valid\t\t\t%d\n",
+				 fs_info->dev_replace.is_valid);
+		BTRFS_SEQ_PRINT2("\tdev_replace.item_needs_writeback\t%d\n",
+				 fs_info->dev_replace.item_needs_writeback);
+		BTRFS_SEQ_PRINT2("\tdev_replace.srcdev\t\t\t%p\n",
+				 fs_info->dev_replace.srcdev);
+		BTRFS_SEQ_PRINT2("\tdev_replace.tgtdev\t\t\t%p\n",
+				 fs_info->dev_replace.tgtdev);
+		BTRFS_SEQ_PRINT2("\tdev_replace.bio_counter.count\t\t%llu\n",
+				 fs_info->dev_replace.bio_counter.count);
+	}
+}
+
+static void dev_state_to_str(struct btrfs_device *device, char *dev_state_str)
+{
+	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
+		strcat(dev_state_str, "|WRITEABLE");
+	if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state))
+		strcat(dev_state_str, "|IN_FS_METADATA");
+	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
+		strcat(dev_state_str, "|MISSING");
+	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
+		strcat(dev_state_str, "|REPLACE_TGT");
+	if (test_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state))
+		strcat(dev_state_str, "|FLUSH_SENT");
+#ifdef READPOLICY
+	if (test_bit(BTRFS_DEV_STATE_RD_PREFERRED, &device->dev_state))
+		strcat(dev_state_str, "|RD_PREFFRRED");
+#endif
+	if (device->dev_stats_valid)
+		strcat(dev_state_str, "|dev_stats_valid");
+}
+
+#ifdef VOL_FLAGS
+static void vol_flags_to_str(struct btrfs_fs_devices *fs_devices, char *vol_flags)
+{
+	if (test_bit(BTRFS_VOL_FLAG_ROTATING, &fs_devices->vol_flags))
+		strcat(vol_flags, "|ROTATING");
+	if (test_bit(BTRFS_VOL_FLAG_SEEDING, &fs_devices->vol_flags))
+		strcat(vol_flags, "|SEEDING");
+	if (test_bit(BTRFS_VOL_FLAG_EXCL_OPS, &fs_devices->vol_flags))
+		strcat(vol_flags, "|EXCL_OPS");
+}
+#endif
+
+void btrfs_print_devlist(struct seq_file *seq, struct btrfs_fs_devices *the_fs_devices)
+{
+/* Btrfs Procfs String Len */
+#define BTRFS_SEQ_PRINT(plist, arg)\
+		snprintf(str, BPSL, plist, arg);\
+		if (sprt) {\
+			if (seq) {\
+				seq_printf(seq, "\t");\
+			}\
+		}\
+		if (seq) {\
+			seq_printf(seq, str);\
+		} else {\
+			printk("boilerplate: %s", str);\
+		}
+
+	char str[BPSL];
+	struct btrfs_device *device;
+	struct btrfs_fs_devices *fs_devices;
+	struct btrfs_fs_devices *cur_fs_devices;
+	struct btrfs_fs_devices *sprt; //sprout fs devices
+	struct list_head *fs_uuids = btrfs_get_fs_uuids();
+	struct list_head *cur_uuid;
+
+	if (seq)
+		seq_printf(seq, "\n#Its for debugging and experimental only, parameters may change without notice.\n\n");
+
+	/* Todo: there must be better way than nested locks */
+	list_for_each(cur_uuid, fs_uuids) {
+#ifdef VOL_FLAGS
+		char vol_flags[256] = {0};
+#endif
+		cur_fs_devices  = list_entry(cur_uuid, struct btrfs_fs_devices, fs_list);
+
+		mutex_lock(&cur_fs_devices->device_list_mutex);
+
+		fs_devices = cur_fs_devices;
+		sprt = NULL;
+
+again_fs_devs:
+		if (the_fs_devices && the_fs_devices != cur_fs_devices)
+			goto skip;
+
+		if (sprt) {
+			BTRFS_SEQ_PRINT("[[seed_fsid: %pU]]\n", fs_devices->fsid);
+			BTRFS_SEQ_PRINT("\tsprout_fsid:\t\t%pU\n", sprt->fsid);
+		} else {
+			BTRFS_SEQ_PRINT("[fsid: %pU]\n", fs_devices->fsid);
+		}
+		if (fs_devices->seed) {
+			BTRFS_SEQ_PRINT("\tseed_fsid:\t\t%pU\n", fs_devices->seed->fsid);
+		}
+		BTRFS_SEQ_PRINT("\tmetadata_uuid:\t\t%pU\n", fs_devices->metadata_uuid);
+		BTRFS_SEQ_PRINT("\tfs_devs_addr:\t\t%p\n", fs_devices);
+		BTRFS_SEQ_PRINT("\tnum_devices:\t\t%llu\n", fs_devices->num_devices);
+		BTRFS_SEQ_PRINT("\topen_devices:\t\t%llu\n", fs_devices->open_devices);
+		BTRFS_SEQ_PRINT("\trw_devices:\t\t%llu\n", fs_devices->rw_devices);
+		BTRFS_SEQ_PRINT("\tmissing_devices:\t%llu\n", fs_devices->missing_devices);
+		BTRFS_SEQ_PRINT("\ttotal_rw_bytes:\t\t%llu\n", fs_devices->total_rw_bytes);
+		BTRFS_SEQ_PRINT("\ttotal_devices:\t\t%llu\n", fs_devices->total_devices);
+		BTRFS_SEQ_PRINT("\topened:\t\t\t%d\n", fs_devices->opened);
+#ifdef VOL_FLAGS
+		vol_flags_to_str(fs_devices, vol_flags);
+		BTRFS_SEQ_PRINT("\vol_flags:\\%s\n", vol_flags);
+#else
+		BTRFS_SEQ_PRINT("\tseeding:\t\t%d\n", fs_devices->seeding);
+		BTRFS_SEQ_PRINT("\trotating:\t\t%d\n", fs_devices->rotating);
+#endif
+		BTRFS_SEQ_PRINT("\tfsid_kobj_state:\t%d\n", fs_devices->fsid_kobj.state_initialized);
+		BTRFS_SEQ_PRINT("\tfsid_kobj_insysfs:\t%d\n", fs_devices->fsid_kobj.state_in_sysfs);
+
+		if (fs_devices->devices_kobj) {
+		BTRFS_SEQ_PRINT("\tkobj_state:\t\t%d\n", fs_devices->devices_kobj->state_initialized);
+		BTRFS_SEQ_PRINT("\tkobj_insysfs:\t\t%d\n", fs_devices->devices_kobj->state_in_sysfs);
+		} else {
+		BTRFS_SEQ_PRINT("\tkobj_state:\t\t%s\n", "null");
+		BTRFS_SEQ_PRINT("\tkobj_insysfs:\t\t%s\n", "null");
+		}
+
+#ifdef READPOLICY
+		switch (fs_devices->read_policy) {
+		case BTRFS_READ_POLICY_PID:
+			BTRFS_SEQ_PRINT2("\tread_policy\t\t%s\n", "BTRFS_READ_POLICY_PID:");
+			break;
+		case BTRFS_READ_POLICY_DEVICE:
+			list_for_each_entry(device, &fs_devices->devices, dev_list) {
+				if (test_bit(BTRFS_DEV_STATE_RD_PREFERRED, &device->dev_state)) {
+					BTRFS_SEQ_PRINT("%llu ", device->devid);
+				}
+			}
+			BTRFS_SEQ_PRINT("%s\n", " ");
+			break;
+		default:
+			BTRFS_SEQ_PRINT2("\tread_policy\t%s\n", "unknown\n");
+		}
+#endif
+		list_for_each_entry(device, &fs_devices->devices, dev_list) {
+			char dev_state_str[256] = {0};
+
+			BTRFS_SEQ_PRINT("\t[[UUID: %pU]]\n", device->uuid);
+			BTRFS_SEQ_PRINT("\t\tdev_addr:\t%p\n", device);
+			rcu_read_lock();
+			BTRFS_SEQ_PRINT("\t\tdevice:\t\t%s\n",
+				device->name ? rcu_str_deref(device->name): "(null)");
+			rcu_read_unlock();
+			BTRFS_SEQ_PRINT("\t\tdevid:\t\t%llu\n", device->devid);
+			BTRFS_SEQ_PRINT("\t\tgeneration:\t%llu\n", device->generation);
+			BTRFS_SEQ_PRINT("\t\ttotal_bytes:\t%llu\n", device->total_bytes);
+			BTRFS_SEQ_PRINT("\t\tdev_totalbytes:\t%llu\n", device->disk_total_bytes);
+			BTRFS_SEQ_PRINT("\t\tbytes_used:\t%llu\n", device->bytes_used);
+			BTRFS_SEQ_PRINT("\t\ttype:\t\t%llu\n", device->type);
+			BTRFS_SEQ_PRINT("\t\tio_align:\t%u\n", device->io_align);
+			BTRFS_SEQ_PRINT("\t\tio_width:\t%u\n", device->io_width);
+			BTRFS_SEQ_PRINT("\t\tsector_size:\t%u\n", device->sector_size);
+			BTRFS_SEQ_PRINT("\t\tmode:\t\t0x%llx\n", (u64)device->mode);
+			dev_state_to_str(device, dev_state_str);
+			if (strlen(dev_state_str) == 0) {
+			BTRFS_SEQ_PRINT("\t\tdev_state:\t0x%lx\n", device->dev_state);
+			} else {
+			BTRFS_SEQ_PRINT("\t\tdev_state:\t%s\n", dev_state_str);
+			}
+			BTRFS_SEQ_PRINT("\t\tbdev:\t\t%s\n", device->bdev ? "not_null":"null");
+			if (device->bdev) {
+			struct backing_dev_info *bdi = device->bdev->bd_bdi;
+			BTRFS_SEQ_PRINT("\t\tbdi:\t\t%s\n", bdi ? "not_null": "null");
+			if (bdi) {
+			struct bdi_writeback *wb = &bdi->wb;
+			BTRFS_SEQ_PRINT("\t\twb:\t\t%s\n", wb ? "not_null": "null");
+			if (wb) {
+			BTRFS_SEQ_PRINT("\t\twb congested state:\t%lx\n", wb->congested->state);
+			}
+			}
+			}
+		}
+
+#ifdef USE_ALLOC_LIST
+		/* print device from the alloc_list */
+		list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
+			char dev_state_str[256] = {0};
+
+			BTRFS_SEQ_PRINT("\t[[uuid: %pU]]\n", device->uuid);
+			BTRFS_SEQ_PRINT("\t\tdev_addr:\t%p\n", device);
+			rcu_read_lock();
+			BTRFS_SEQ_PRINT("\t\tdevice:\t\t%s\n",
+				device->name ? rcu_str_deref(device->name): "(null)");
+			rcu_read_unlock();
+			BTRFS_SEQ_PRINT("\t\tdevid:\t\t%llu\n", device->devid);
+			BTRFS_SEQ_PRINT("\t\tgeneration:\t%llu\n", device->generation);
+			BTRFS_SEQ_PRINT("\t\ttotal_bytes:\t%llu\n", device->total_bytes);
+			BTRFS_SEQ_PRINT("\t\tdev_totalbytes:\t%llu\n", device->disk_total_bytes);
+			BTRFS_SEQ_PRINT("\t\tbytes_used:\t%llu\n", device->bytes_used);
+			BTRFS_SEQ_PRINT("\t\ttype:\t\t%llu\n", device->type);
+			BTRFS_SEQ_PRINT("\t\tio_align:\t%u\n", device->io_align);
+			BTRFS_SEQ_PRINT("\t\tio_width:\t%u\n", device->io_width);
+			BTRFS_SEQ_PRINT("\t\tsector_size:\t%u\n", device->sector_size);
+			BTRFS_SEQ_PRINT("\t\tmode:\t\t0x%llx\n", (u64)device->mode);
+			dev_state_to_str(device, dev_state_str);
+			if (strlen(dev_state_str) == 0) {
+			BTRFS_SEQ_PRINT("\t\tdev_state:\t0x%lx\n", device->dev_state);
+			} else {
+			BTRFS_SEQ_PRINT("\t\tdev_state:\t%s\n", dev_state_str);
+			}
+			BTRFS_SEQ_PRINT("\t\tbdev:\t\t%s\n", device->bdev ? "not_null":"null");
+			if (device->bdev) {
+			struct backing_dev_info *bdi = device->bdev->bd_bdi;
+			BTRFS_SEQ_PRINT("\t\tbdi:\t\t%s\n", bdi ? "not_null": "null");
+			if (bdi) {
+			struct bdi_writeback *wb = &bdi->wb;
+			BTRFS_SEQ_PRINT("\t\twb:\t\t%s\n", wb ? "not_null": "null");
+			if (wb) {
+			BTRFS_SEQ_PRINT("\t\twb congested state:\t%lx\n", wb->congested->state);
+			}
+			}
+			}
+		}
+#endif
+skip:
+		if (fs_devices->seed) {
+			sprt = fs_devices;
+			fs_devices = fs_devices->seed;
+			goto again_fs_devs;
+		}
+		if (seq)
+			seq_printf(seq, "\n");
+
+		mutex_unlock(&cur_fs_devices->device_list_mutex);
+	}
+}
+
+static int btrfs_fsinfo_show(struct seq_file *seq, void *offset)
+{
+	btrfs_print_fsinfo(seq);
+	return 0;
+}
+
+static int btrfs_devlist_show(struct seq_file *seq, void *offset)
+{
+	btrfs_print_devlist(seq, NULL);
+	return 0;
+}
+
+static int btrfs_seq_fsinfo_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, btrfs_fsinfo_show, PDE_DATA(inode));
+}
+
+static int btrfs_seq_devlist_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, btrfs_devlist_show, PDE_DATA(inode));
+}
+
+#ifdef OLD_PROC
+static const struct file_operations btrfs_seq_devlist_fops = {
+	.owner   = THIS_MODULE,
+	.open    = btrfs_seq_devlist_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+#else
+static const struct proc_ops btrfs_seq_devlist_fops = {
+	.proc_open    = btrfs_seq_devlist_open,
+	.proc_read    = seq_read,
+	.proc_lseek  = seq_lseek,
+	.proc_release = single_release,
+};
+#endif
+
+#ifdef OLD_PROC
+static const struct file_operations btrfs_seq_fsinfo_fops = {
+	.owner   = THIS_MODULE,
+	.open    = btrfs_seq_fsinfo_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+#else
+static const struct proc_ops btrfs_seq_fsinfo_fops = {
+	.proc_open    = btrfs_seq_fsinfo_open,
+	.proc_read    = seq_read,
+	.proc_lseek  = seq_lseek,
+	.proc_release = single_release,
+};
+#endif
+
+void btrfs_init_procfs(void)
+{
+	btrfs_proc_root = proc_mkdir(BTRFS_PROC_PATH, NULL);
+	if (btrfs_proc_root) {
+		proc_create_data(BTRFS_PROC_DEVLIST, S_IRUGO, btrfs_proc_root,
+					&btrfs_seq_devlist_fops, NULL);
+		proc_create_data(BTRFS_PROC_FSINFO, S_IRUGO, btrfs_proc_root,
+					&btrfs_seq_fsinfo_fops, NULL);
+	}
+	return;
+}
+
+void btrfs_exit_procfs(void)
+{
+	if (btrfs_proc_root) {
+		remove_proc_entry(BTRFS_PROC_DEVLIST, btrfs_proc_root);
+		remove_proc_entry(BTRFS_PROC_FSINFO, btrfs_proc_root);
+	}
+	remove_proc_entry(BTRFS_PROC_PATH, NULL);
+}
diff --git a/fs/btrfs/procfs.h b/fs/btrfs/procfs.h
new file mode 100644
index 000000000000..f7b712b58a5d
--- /dev/null
+++ b/fs/btrfs/procfs.h
@@ -0,0 +1,2 @@
+void btrfs_exit_procfs(void);
+void btrfs_init_procfs(void);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 67c63858812a..c9dfceff6aa4 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -47,7 +47,7 @@
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 #include "discard.h"
-
+#include "procfs.h"
 #include "qgroup.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
@@ -2393,6 +2393,8 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		return err;
 
+	btrfs_init_procfs();
+
 	btrfs_init_compress();
 
 	err = btrfs_init_cachep();
@@ -2477,6 +2479,7 @@ static int __init init_btrfs_fs(void)
 	btrfs_destroy_cachep();
 free_compress:
 	btrfs_exit_compress();
+	btrfs_exit_procfs();
 	btrfs_exit_sysfs();
 
 	return err;
@@ -2496,6 +2499,7 @@ static void __exit exit_btrfs_fs(void)
 	btrfs_interface_exit();
 	btrfs_end_io_wq_exit();
 	unregister_filesystem(&btrfs_fs_type);
+	btrfs_exit_procfs();
 	btrfs_exit_sysfs();
 	btrfs_cleanup_fs_uuids();
 	btrfs_exit_compress();
-- 
2.23.0

