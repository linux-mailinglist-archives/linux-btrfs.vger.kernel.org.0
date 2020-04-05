Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C0319E9E7
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Apr 2020 10:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDEI0n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Apr 2020 04:26:43 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:41152 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726397AbgDEI0n (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Apr 2020 04:26:43 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-16.iol.local with ESMTPA
        id L0c2jLXg66Q7RL0c3jMMgM; Sun, 05 Apr 2020 10:26:40 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1586075200; bh=/BXr8591p4PK/phE+gfior2koorzXXDfHeDpQ4lsseo=;
        h=From;
        b=MKVVk1O9POZLneOBg3DO69KNNNM9sMZOyRZtAm2B+MRBys6lH2jwcVVO9trKV+zk5
         frkuMJ7PW7XCXe8u7SyphxpNUBZObi2q2lyIq04y1MoRU6tn/tM0YcC1KDEt3dQqDA
         dAsp9RuD7bth6A7nXAdvmWefVp2KJY/HuP37os+2xxfHj9s4MLLoJvZTulHi6t61jq
         /czz4yDiSVxZEar1r2YZSgGiFjxIdp3A/YIwU8HeNNxnidvgglpv/b/vw4qo8BdH8t
         HWY8DzcG+Ba0P/VCd9O8MdQye52vM9U/lEVqejX4NPTI9Nfr+RNNS/qFQ1Ry3Wr+Em
         2y8xDqRy69xIA==
X-CNFS-Analysis: v=2.3 cv=LelCFQXi c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=DCztETCGzjQpL7YV058A:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Michael <mclaud@roznica.com.ua>, Hugo Mills <hugo@carfax.org.uk>,
        Martin Svec <martin.svec@zoner.cz>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH] btrfs: add ssd_metadata mode
Date:   Sun,  5 Apr 2020 10:26:36 +0200
Message-Id: <20200405082636.18016-2-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405082636.18016-1-kreijack@libero.it>
References: <20200405082636.18016-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJV1vPs7lfH28JFZAwpqMcOAakIbcOw1a7X9mMEabdJZrObkvw86L0Vyvm/OmLTXBy1OsEb/bUk/0oHenJLhVskldVjtJUGjpp5PVPu6wImkLeBcpfGU
 FcBkEaXEAk7Jx5U7nwORp0S/Is82fyBaOZ/Vu3jDHkAQL0236cYNYNYH+eTh7opFinGF1nBY6iUXOy0LjERNWnKfQ8dauUyS3W2j96J6g7mUk43oXIlbnGYX
 yzFCcUxshI/k5smn3WoMo4YaohZ0ovUX/Mfiwi6ZHWc6vd2cn7BVQpXXQBDBXZfVyG2V9xLpCw6/Lakk5PyUHnI8MaFhZvGxirJhJeX8MfU=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

When this mode is enabled, the allocation policy of the chunk
is so modified:
- allocation of metadata chunk: priority is given to ssd disk.
- allocation of data chunk: priority is given to a rotational disk.

When a striped profile is involved (like RAID0,5,6), the logic
is a bit more complex. If there are enough disks, the data profiles
are stored on the rotational disks only; instead the metadata profiles
are stored on the non rotational disk only.
If the disks are not enough, then the profiles is stored on all
the disks.

Example: assuming that sda, sdb, sdc are ssd disks, and sde, sdf are
rotational ones.
A data profile raid6, will be stored on sda, sdb, sdc, sde, sdf (sde
and sdf are not enough to host a raid5 profile).
A metadata profile raid6, will be stored on sda, sdb, sdc (these
are enough to host a raid6 profile).

To enable this mode pass -o ssd_metadata at mount time.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/super.c   |  8 +++++
 fs/btrfs/volumes.c | 89 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/volumes.h |  1 +
 4 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 36df977b64d9..773c7f8b0b0d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1236,6 +1236,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 #define BTRFS_MOUNT_NOLOGREPLAY		(1 << 27)
 #define BTRFS_MOUNT_REF_VERIFY		(1 << 28)
 #define BTRFS_MOUNT_DISCARD_ASYNC	(1 << 29)
+#define BTRFS_MOUNT_SSD_METADATA	(1 << 30)
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 67c63858812a..4ad14b0a57b3 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -350,6 +350,7 @@ enum {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
 #endif
+	Opt_ssd_metadata,
 	Opt_err,
 };
 
@@ -421,6 +422,7 @@ static const match_table_t tokens = {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	{Opt_ref_verify, "ref_verify"},
 #endif
+	{Opt_ssd_metadata, "ssd_metadata"},
 	{Opt_err, NULL},
 };
 
@@ -872,6 +874,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, REF_VERIFY);
 			break;
 #endif
+		case Opt_ssd_metadata:
+			btrfs_set_and_info(info, SSD_METADATA,
+					"enabling ssd_metadata");
+			break;
 		case Opt_err:
 			btrfs_info(info, "unrecognized mount option '%s'", p);
 			ret = -EINVAL;
@@ -1390,6 +1396,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 #endif
 	if (btrfs_test_opt(info, REF_VERIFY))
 		seq_puts(seq, ",ref_verify");
+	if (btrfs_test_opt(info, SSD_METADATA))
+		seq_puts(seq, ",ssd_metadata");
 	seq_printf(seq, ",subvolid=%llu",
 		  BTRFS_I(d_inode(dentry))->root->root_key.objectid);
 	seq_puts(seq, ",subvol=");
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9cfc668f91f4..ffb2bc912c43 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4761,6 +4761,58 @@ static int btrfs_cmp_device_info(const void *a, const void *b)
 	return 0;
 }
 
+/*
+ * sort the devices in descending order by rotational,
+ * max_avail, total_avail
+ */
+static int btrfs_cmp_device_info_metadata(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+
+	/* metadata -> non rotational first */
+	if (!di_a->rotational && di_b->rotational)
+		return -1;
+	if (di_a->rotational && !di_b->rotational)
+		return 1;
+	if (di_a->max_avail > di_b->max_avail)
+		return -1;
+	if (di_a->max_avail < di_b->max_avail)
+		return 1;
+	if (di_a->total_avail > di_b->total_avail)
+		return -1;
+	if (di_a->total_avail < di_b->total_avail)
+		return 1;
+	return 0;
+}
+
+/*
+ * sort the devices in descending order by !rotational,
+ * max_avail, total_avail
+ */
+static int btrfs_cmp_device_info_data(const void *a, const void *b)
+{
+	const struct btrfs_device_info *di_a = a;
+	const struct btrfs_device_info *di_b = b;
+
+	/* data -> non rotational last */
+	if (!di_a->rotational && di_b->rotational)
+		return 1;
+	if (di_a->rotational && !di_b->rotational)
+		return -1;
+	if (di_a->max_avail > di_b->max_avail)
+		return -1;
+	if (di_a->max_avail < di_b->max_avail)
+		return 1;
+	if (di_a->total_avail > di_b->total_avail)
+		return -1;
+	if (di_a->total_avail < di_b->total_avail)
+		return 1;
+	return 0;
+}
+
+
+
 static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 {
 	if (!(type & BTRFS_BLOCK_GROUP_RAID56_MASK))
@@ -4808,6 +4860,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int i;
 	int j;
 	int index;
+	int nr_rotational;
 
 	BUG_ON(!alloc_profile_is_valid(type, 0));
 
@@ -4863,6 +4916,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	 * about the available holes on each device.
 	 */
 	ndevs = 0;
+	nr_rotational = 0;
 	list_for_each_entry(device, &fs_devices->alloc_list, dev_alloc_list) {
 		u64 max_avail;
 		u64 dev_offset;
@@ -4914,14 +4968,45 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		devices_info[ndevs].max_avail = max_avail;
 		devices_info[ndevs].total_avail = total_avail;
 		devices_info[ndevs].dev = device;
+		devices_info[ndevs].rotational = !test_bit(QUEUE_FLAG_NONROT,
+				&(bdev_get_queue(device->bdev)->queue_flags));
+		if (devices_info[ndevs].rotational)
+			nr_rotational++;
 		++ndevs;
 	}
 
+	BUG_ON(nr_rotational > ndevs);
 	/*
 	 * now sort the devices by hole size / available space
 	 */
-	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
-	     btrfs_cmp_device_info, NULL);
+	if (((type & BTRFS_BLOCK_GROUP_DATA) &&
+	     (type & BTRFS_BLOCK_GROUP_METADATA)) ||
+	    !btrfs_test_opt(info, SSD_METADATA)) {
+		/* mixed bg or SSD_METADATA not set */
+		sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+			     btrfs_cmp_device_info, NULL);
+	} else {
+		/*
+		 * if SSD_METADATA is set, sort the device considering also the
+		 * kind (ssd or not). Limit the availables devices to the ones
+		 * of the same kind, to avoid that a striped profile like raid5
+		 * spread to all kind of devices (ssd and rotational).
+		 * It is allowed to use different kinds of devices if the ones
+		 * of the same kind are not enough alone.
+		 */
+		if (type & BTRFS_BLOCK_GROUP_DATA) {
+			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+				     btrfs_cmp_device_info_data, NULL);
+			if (nr_rotational >= devs_min)
+				ndevs = nr_rotational;
+		} else {
+			int nr_norot = ndevs - nr_rotational;
+			sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+				     btrfs_cmp_device_info_metadata, NULL);
+			if (nr_norot >= devs_min)
+				ndevs = nr_norot;
+		}
+	}
 
 	/*
 	 * Round down to number of usable stripes, devs_increment can be any
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f01552a0785e..285d71d54a03 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -343,6 +343,7 @@ struct btrfs_device_info {
 	u64 dev_offset;
 	u64 max_avail;
 	u64 total_avail;
+	int rotational:1;
 };
 
 struct btrfs_raid_attr {
-- 
2.26.0

