Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A6E3157D4
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 21:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbhBIUkR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 15:40:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:45414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233714AbhBIUgi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 15:36:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D98CB165;
        Tue,  9 Feb 2021 20:31:29 +0000 (UTC)
From:   Michal Rostecki <mrostecki@suse.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     Michal Rostecki <mrostecki@suse.com>
Subject: [PATCH RFC 6/6] btrfs: Add roundrobin raid1 read policy
Date:   Tue,  9 Feb 2021 21:30:40 +0100
Message-Id: <20210209203041.21493-7-mrostecki@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209203041.21493-1-mrostecki@suse.de>
References: <20210209203041.21493-1-mrostecki@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Michal Rostecki <mrostecki@suse.com>

Add a new raid1 read policy `roundrobin`. For each read request, it
selects the mirror which has lower load than queue depth and it starts
iterating from the last used mirror (by the current CPU). Load is
defined as the number of inflight requests + a potential penalty value.

The policy can be enabled through sysfs:

  # echo roundrobin > /sys/fs/btrfs/[fsid]/read_policies/policy

This policy was tested with fio and compared with the default `pid`
policy.

The singlethreaded test has the following parameters:

  [global]
  name=btrfs-raid1-seqread
  filename=btrfs-raid1-seqread
  rw=read
  bs=64k
  direct=0
  numjobs=1
  time_based=0

  [file1]
  size=10G
  ioengine=libaio

and shows the following results:

- raid1c3 with 3 HDDs:
  3 x Segate Barracuda ST2000DM008 (2TB)
  * pid policy
    READ: bw=217MiB/s (228MB/s), 217MiB/s-217MiB/s (228MB/s-228MB/s),
    io=10.0GiB (10.7GB), run=47082-47082msec
  * roundrobin policy
    READ: bw=409MiB/s (429MB/s), 409MiB/s-409MiB/s (429MB/s-429MB/s),
    io=10.0GiB (10.7GB), run=25028-25028mse
- raid1c3 with 2 HDDs and 1 SSD:
  2 x Segate Barracuda ST2000DM008 (2TB)
  1 x Crucial CT256M550SSD1 (256GB)
  * pid policy (the worst case when only HDDs were chosen)
    READ: bw=220MiB/s (231MB/s), 220MiB/s-220MiB/s (231MB/s-231MB/s),
    io=10.0GiB (10.7GB), run=46577-46577mse
  * pid policy (the best case when SSD was used as well)
    READ: bw=513MiB/s (538MB/s), 513MiB/s-513MiB/s (538MB/s-538MB/s),
    io=10.0GiB (10.7GB), run=19954-19954msec
  * roundrobin (there are no noticeable differences when testing multiple
    times)
    READ: bw=541MiB/s (567MB/s), 541MiB/s-541MiB/s (567MB/s-567MB/s),
    io=10.0GiB (10.7GB), run=18933-18933msec

The multithreaded test has the following parameters:

  [global]
  name=btrfs-raid1-seqread
  filename=btrfs-raid1-seqread
  rw=read
  bs=64k
  direct=0
  numjobs=8
  time_based=0

  [file1]
  size=10G
  ioengine=libaio

and shows the following results:

- raid1c3 with 3 HDDs: 3 x Segate Barracuda ST2000DM008 (2TB)
  3 x Segate Barracuda ST2000DM008 (2TB)
  * pid policy
    READ: bw=1569MiB/s (1645MB/s), 196MiB/s-196MiB/s (206MB/s-206MB/s),
    io=80.0GiB (85.9GB), run=52210-52211msec
  * roundrobin
    READ: bw=1733MiB/s (1817MB/s), 217MiB/s-217MiB/s (227MB/s-227MB/s),
    io=80.0GiB (85.9GB), run=47269-47271msec
- raid1c3 with 2 HDDs and 1 SSD:
  2 x Segate Barracuda ST2000DM008 (2TB)
  1 x Crucial CT256M550SSD1 (256GB)
  * pid policy
    READ: bw=1843MiB/s (1932MB/s), 230MiB/s-230MiB/s (242MB/s-242MB/s),
    io=80.0GiB (85.9GB), run=44449-44450msec
  * roundrobin
    READ: bw=2485MiB/s (2605MB/s), 311MiB/s-311MiB/s (326MB/s-326MB/s),
    io=80.0GiB (85.9GB), run=32969-32970msec

The penalty value is an additional value added to the number of inflight
requests when a scheduled request is non-local (which means it would
start from the different physical location than the physical location of
the last request processed by the given device). By default, it's
applied only in filesystems which have mixed types of devices
(non-rotational and rotational), but it can be configured to be applied
without that condition.

The configuration is done through sysfs:

- /sys/fs/btrfs/[fsid]/read_policies/roundrobin_nonlocal_inc_mixed_only

where 1 (the default) value means applying penalty only in mixed arrays,
0 means applying it unconditionally.

The exact penalty value is defined separately for non-rotational and
rotational devices. By default, it's 0 for non-rotational devices and 1
for rotational devices. Both values are configurable through sysfs:

- /sys/fs/btrfs/[fsid]/read_policies/roundrobin_nonrot_nonlocal_inc
- /sys/fs/btrfs/[fsid]/read_policies/roundrobin_rot_nonlocal_inc

To sum it up - the default case is applying the penalty under the
following conditions:

- the raid1 array consists of mixed types of devices
- the scheduled request is going to be non-local for the given disk
- the device is rotational

That default case is based on a slight preference towards non-rotational
disks in mixed arrays and has proven to give the best performance in
tested arrays.

For the array with 3 HDDs, not adding any penalty resulted in 409MiB/s
(429MB/s) performance. Adding the penalty value 1 resulted in a
performance drop to 404MiB/s (424MB/s). Increasing the value towards 10
was making the performance even worse.

For the array with 2 HDDs and 1 SSD, adding penalty value 1 to
rotational disks resulted in the best performance - 541MiB/s (567MB/s).
Not adding any value and increasing the value was making the performance
worse.

Adding penalty value to non-rotational disks was always decreasing the
performance, which motivated setting it as 0 by default. For the purpose
of testing, it's still configurable.

To measure the performance of each policy and find optimal penalty
values, I created scripts which are available here:

https://gitlab.com/vadorovsky/btrfs-perf
https://github.com/mrostecki/btrfs-perf

Signed-off-by: Michal Rostecki <mrostecki@suse.com>
---
 fs/btrfs/ctree.h   |   3 +
 fs/btrfs/disk-io.c |   3 +
 fs/btrfs/sysfs.c   |  93 +++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c | 137 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h |  10 ++++
 5 files changed, 242 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a9b0521d9e89..6ff0a18fd219 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -976,6 +976,9 @@ struct btrfs_fs_info {
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
 
+	/* Last mirror picked in round-robin selection */
+	int __percpu *last_mirror;
+
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	spinlock_t ref_verify_lock;
 	struct rb_root block_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 71fab77873a5..937fcadbdd2f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1547,6 +1547,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
+	free_percpu(fs_info->last_mirror);
 	kvfree(fs_info);
 }
 
@@ -2857,6 +2858,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->swapfile_pins = RB_ROOT;
 
 	fs_info->send_in_progress = 0;
+
+	fs_info->last_mirror = __alloc_percpu(sizeof(int), __alignof__(int));
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index a8f528eb4e50..b9a6d38843ef 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -928,7 +928,7 @@ static bool strmatch(const char *buffer, const char *string)
 	return false;
 }
 
-static const char * const btrfs_read_policy_name[] = { "pid" };
+static const char * const btrfs_read_policy_name[] = { "pid", "roundrobin" };
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
@@ -976,8 +976,99 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 }
 BTRFS_ATTR_RW(read_policies, policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
+static ssize_t btrfs_roundrobin_nonlocal_inc_mixed_only_show(
+	struct kobject *kobj, struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 READ_ONCE(fs_devices->roundrobin_nonlocal_inc_mixed_only));
+}
+
+static ssize_t btrfs_roundrobin_nonlocal_inc_mixed_only_store(
+	struct kobject *kobj, struct kobj_attribute *a, const char *buf,
+	size_t len)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
+	bool val;
+	int ret;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return -EINVAL;
+
+	WRITE_ONCE(fs_devices->roundrobin_nonlocal_inc_mixed_only, val);
+	return len;
+}
+BTRFS_ATTR_RW(read_policies, roundrobin_nonlocal_inc_mixed_only,
+	      btrfs_roundrobin_nonlocal_inc_mixed_only_show,
+	      btrfs_roundrobin_nonlocal_inc_mixed_only_store);
+
+static ssize_t btrfs_roundrobin_nonrot_nonlocal_inc_show(struct kobject *kobj,
+							 struct kobj_attribute *a,
+							 char *buf)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 READ_ONCE(fs_devices->roundrobin_nonrot_nonlocal_inc));
+}
+
+static ssize_t btrfs_roundrobin_nonrot_nonlocal_inc_store(struct kobject *kobj,
+							  struct kobj_attribute *a,
+							  const char *buf,
+							  size_t len)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
+	u32 val;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &val);
+	if (ret)
+		return -EINVAL;
+
+	WRITE_ONCE(fs_devices->roundrobin_nonrot_nonlocal_inc, val);
+	return len;
+}
+BTRFS_ATTR_RW(read_policies, roundrobin_nonrot_nonlocal_inc,
+	      btrfs_roundrobin_nonrot_nonlocal_inc_show,
+	      btrfs_roundrobin_nonrot_nonlocal_inc_store);
+
+static ssize_t btrfs_roundrobin_rot_nonlocal_inc_show(struct kobject *kobj,
+						      struct kobj_attribute *a,
+						      char *buf)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 READ_ONCE(fs_devices->roundrobin_rot_nonlocal_inc));
+}
+
+static ssize_t btrfs_roundrobin_rot_nonlocal_inc_store(struct kobject *kobj,
+						       struct kobj_attribute *a,
+						       const char *buf,
+						       size_t len)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj->parent);
+	u32 val;
+	int ret;
+
+	ret = kstrtou32(buf, 10, &val);
+	if (ret)
+		return -EINVAL;
+
+	WRITE_ONCE(fs_devices->roundrobin_rot_nonlocal_inc, val);
+	return len;
+}
+BTRFS_ATTR_RW(read_policies, roundrobin_rot_nonlocal_inc,
+	      btrfs_roundrobin_rot_nonlocal_inc_show,
+	      btrfs_roundrobin_rot_nonlocal_inc_store);
+
 static const struct attribute *read_policies_attrs[] = {
 	BTRFS_ATTR_PTR(read_policies, policy),
+	BTRFS_ATTR_PTR(read_policies, roundrobin_nonlocal_inc_mixed_only),
+	BTRFS_ATTR_PTR(read_policies, roundrobin_nonrot_nonlocal_inc),
+	BTRFS_ATTR_PTR(read_policies, roundrobin_rot_nonlocal_inc),
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1ad30a595722..c6dd393190f6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1265,6 +1265,11 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->total_rw_bytes = 0;
 	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 	fs_devices->read_policy = BTRFS_READ_POLICY_PID;
+	fs_devices->roundrobin_nonlocal_inc_mixed_only = true;
+	fs_devices->roundrobin_nonrot_nonlocal_inc =
+		BTRFS_DEFAULT_ROUNDROBIN_NONROT_NONLOCAL_INC;
+	fs_devices->roundrobin_rot_nonlocal_inc =
+		BTRFS_DEFAULT_ROUNDROBIN_ROT_NONLOCAL_INC;
 
 	return 0;
 }
@@ -5555,8 +5560,125 @@ static u64 stripe_physical(struct map_lookup *map, u32 stripe_index,
 		stripe_nr * map->stripe_len;
 }
 
+/*
+ * Calculates the load of the given mirror. Load is defines as the number of
+ * inflight requests + potential penalty value.
+ *
+ * @fs_info:       the filesystem
+ * @map:           mapping containing the logical extent
+ * @mirror_index:  number of mirror to check
+ * @stripe_offset: offset of the block in its stripe
+ * @stripe_nr:     index of the stripe whete the block falls in
+ */
+static int mirror_load(struct btrfs_fs_info *fs_info, struct map_lookup *map,
+		       int mirror_index, u64 stripe_offset, u64 stripe_nr)
+{
+	struct btrfs_fs_devices *fs_devices;
+	struct btrfs_device *dev;
+	int last_offset;
+	u64 physical;
+	int load;
+
+	dev = map->stripes[mirror_index].dev;
+	load = percpu_counter_sum(&dev->inflight);
+	last_offset = atomic_read(&dev->last_offset);
+	physical = stripe_physical(map, mirror_index, stripe_offset, stripe_nr);
+
+	fs_devices = fs_info->fs_devices;
+
+	/*
+	 * If the filesystem has mixed type of devices (or we enable adding a
+	 * penalty value regardless) and the request is non-local, add a
+	 * penalty value.
+	 */
+	if ((!fs_devices->roundrobin_nonlocal_inc_mixed_only ||
+	     fs_devices->mixed) && last_offset != physical) {
+		if (dev->rotating)
+			return load + fs_devices->roundrobin_rot_nonlocal_inc;
+		return load + fs_devices->roundrobin_nonrot_nonlocal_inc;
+	}
+
+	return load;
+}
+
+/*
+ * Checks if the given mirror can process more requests.
+ *
+ * @fs_info:       the filesystem
+ * @map:           mapping containing the logical extent
+ * @mirror_index:  index of the mirror to check
+ * @stripe_offset: offset of the block in its stripe
+ * @stripe_nr:     index of the stripe whete the block falls in
+ *
+ * Returns true if more requests can be processes, otherwise returns false.
+ */
+static bool mirror_queue_not_filled(struct btrfs_fs_info *fs_info,
+				    struct map_lookup *map, int mirror_index,
+				    u64 stripe_offset, u64 stripe_nr)
+{
+	struct block_device *bdev;
+	unsigned int queue_depth;
+	int inflight;
+
+	bdev = map->stripes[mirror_index].dev->bdev;
+	inflight = mirror_load(fs_info, map, mirror_index, stripe_offset,
+			       stripe_nr);
+	queue_depth = blk_queue_depth(bdev->bd_disk->queue);
+
+	return inflight < queue_depth;
+}
+
+/*
+ * Find a mirror using the round-robin technique which has lower load than
+ * queue depth. Load is defined as the number of inflight requests + potential
+ * penalty value.
+ *
+ * @fs_info:       the filesystem
+ * @map:           mapping containing the logical extent
+ * @first:         index of the first device in the stripes array
+ * @num_stripes:   number of stripes in the stripes array
+ * @stripe_offset: offset of the block in its stripe
+ * @stripe_nr:     index of the stripe whete the block falls in
+ *
+ * Returns the index of selected mirror.
+ */
+static int find_live_mirror_roundrobin(struct btrfs_fs_info *fs_info,
+				       struct map_lookup *map, int first,
+				       int num_stripes, u64 stripe_offset,
+				       u64 stripe_nr)
+{
+	int preferred_mirror;
+	int last_mirror;
+	int i;
+
+	last_mirror = this_cpu_read(*fs_info->last_mirror);
+
+	for (i = last_mirror; i < first + num_stripes; i++) {
+		if (mirror_queue_not_filled(fs_info, map, i, stripe_offset,
+					    stripe_nr)) {
+			preferred_mirror = i;
+			goto out;
+		}
+	}
+
+	for (i = first; i < last_mirror; i++) {
+		if (mirror_queue_not_filled(fs_info, map, i, stripe_offset,
+					    stripe_nr)) {
+			preferred_mirror = i;
+			goto out;
+		}
+	}
+
+	preferred_mirror = last_mirror;
+
+out:
+	this_cpu_write(*fs_info->last_mirror, preferred_mirror);
+	return preferred_mirror;
+}
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct map_lookup *map, int first,
+			    u64 stripe_offset, u64 stripe_nr,
 			    int dev_replace_is_ongoing)
 {
 	int i;
@@ -5584,6 +5706,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + (current->pid % num_stripes);
 		break;
+	case BTRFS_READ_POLICY_ROUNDROBIN:
+		preferred_mirror = find_live_mirror_roundrobin(
+			fs_info, map, first, num_stripes, stripe_offset,
+			stripe_nr);
+		break;
 	}
 
 	if (dev_replace_is_ongoing &&
@@ -6178,7 +6305,9 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 			stripe_index = mirror_num - 1;
 		else {
 			stripe_index = find_live_mirror(fs_info, map, 0,
-					    dev_replace_is_ongoing);
+							stripe_offset,
+							stripe_nr,
+							dev_replace_is_ongoing);
 			mirror_num = stripe_index + 1;
 		}
 
@@ -6204,8 +6333,10 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		else {
 			int old_stripe_index = stripe_index;
 			stripe_index = find_live_mirror(fs_info, map,
-					      stripe_index,
-					      dev_replace_is_ongoing);
+							stripe_index,
+							stripe_offset,
+							stripe_nr,
+							dev_replace_is_ongoing);
 			mirror_num = stripe_index - old_stripe_index + 1;
 		}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index ee050fd48042..47ca47b60ea9 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -230,9 +230,15 @@ enum btrfs_chunk_allocation_policy {
 enum btrfs_read_policy {
 	/* Use process PID to choose the stripe */
 	BTRFS_READ_POLICY_PID,
+	/* Round robin */
+	BTRFS_READ_POLICY_ROUNDROBIN,
 	BTRFS_NR_READ_POLICY,
 };
 
+/* Default raid1 policies config */
+#define BTRFS_DEFAULT_ROUNDROBIN_NONROT_NONLOCAL_INC 0
+#define BTRFS_DEFAULT_ROUNDROBIN_ROT_NONLOCAL_INC 1
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
@@ -294,6 +300,10 @@ struct btrfs_fs_devices {
 
 	/* Policy used to read the mirrored stripes */
 	enum btrfs_read_policy read_policy;
+	/* Policies config */
+	bool roundrobin_nonlocal_inc_mixed_only;
+	u32 roundrobin_nonrot_nonlocal_inc;
+	u32 roundrobin_rot_nonlocal_inc;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.30.0

