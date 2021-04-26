Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BF836AC29
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 08:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhDZG3C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 02:29:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41929 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhDZG3B (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 02:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619418500; x=1650954500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mpGVlOUdC8AuE3mwl78pptXRCSgby5exq7T2yTC/kzk=;
  b=jk0whuhbWybjYUUpYfDnhre1/vXeipOuU5mFg+cGG9uV9Op3BAxIWs45
   KSNdvmyoowdLA1JgQ2wiYRT1ScdoKt7EPEPa0q6Y/V1iO7K0teMricT99
   Kx+lxYhWOfMJHek5mAPc661E0N3iANDxMra6JxfpjTJHtLvFe0T2ueQnx
   qJf7DKWiPNqasFlXk0eO3HLlVicrdj7JJnekiNJjW9AELY/jHGyxsPS6H
   3hsruJJAkvXm6Q34kv8vlTiwDQwTSv6fCtpkG7epXSmtgRNL7xt9Ba++W
   maVNfV1EeWhQSRaKh4Gg1CheAhj4MlvrcqtKe2xY5PcgnZVNgzLMtc8mG
   A==;
IronPort-SDR: jSl92k+pzbwTzrPctefAPHm5/asSbkKOEaBQ9xwITHHlf5MGTmpfmMJafIQrEzoicmG8IXJfZl
 d5G9RCbUAE3bwi5nMoKceaxzfiOWeJ5tQDGpUgICzj1iqRvTCyhpd7RM4qldRW8t1LV4OmaLGf
 bpC8Ys65kvuBuKvB2zJFY/YqYxa2QT6cEbG+atfGn+c6uT60LrqIBtznDRZxWyKXpwnhLClSJz
 pjD+DWgnDXzf3JMuVobRjKHODFn+vDJ9JoLtL9OJmt4z2sT5EQUp1GGSZ7r3nHwk/kqPYYuW9s
 MU4=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170788123"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 14:28:19 +0800
IronPort-SDR: gFNHEvRRWDWAwKFY7vCx256Eg2QwSUUUPl+VW0q/D2fucYI6okh27T6E9j/s0Wjn42+/hvf8n9
 bG7D9uihZ6OX1PRwioMRMCEoXXdI5MA+FT0PH8QLGx6S19rk1TngWbxnVfX9NpJ2h7EJrZVkGe
 IcbETgHmlflp+zuK79qEYqHJCkIsvFzlzGInMk4CFpTfhjn37L5jnuspfLHjMGgRxOjNrD5ZrR
 N1XIXEoh68m6kf3TOF1WU4/f+hlZYkxD4t3YaUQ9e6jMxyeDW03ca54S2M5UF/C/ynAlSPafL9
 JreEbS+sWkRRLCQusBcNzvTC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:08:44 -0700
IronPort-SDR: PRHMjpndclVfBe7jMJu/9hzuvWx8Z0rVnPk2+yAmHysaPrvvXVbE4zTDJsZm+r9dDlI0PR3bWu
 78AXF6rdUxpedD9y+Ty39IPGoDY535s6clcIf53Nz3EOz8ki7M6ixtN3hE7sZn+h/0+gZCXrtR
 Q13g6/SNLRz6X2X3/gUzg+RP3MmJr8TBesIHZSoufBSE/A9z0x48/DTSdHd06sSuEFmTmVc5xf
 61nK3NHg9/UEov/m58W95Jk9su86A/fIP62pSX2PDT8nR7fve0G/E/rN6JyErVkTKM2Szz8PeG
 yYo=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Apr 2021 23:28:20 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 10/26] btrfs-progs: zoned: implement log-structured superblock for ZONED mode
Date:   Mon, 26 Apr 2021 15:27:26 +0900
Message-Id: <3bb3fbb1f36ad682c949eec3476dcee00a15a132.1619416549.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619416549.git.naohiro.aota@wdc.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Superblock (and its copies) is the only data structure in btrfs which has a
fixed location on a device. Since we cannot overwrite in a sequential write
required zone, we cannot place superblock in the zone.  One easy solution
is limiting superblock and copies to be placed only in conventional zones.
However, this method has two downsides: one is reduced number of superblock
copies. The location of the second copy of superblock is 256GB, which is in
a sequential write required zone on typical devices in the market today.
So, the number of superblock and copies is limited to be two.  Second
downside is that we cannot support devices which have no conventional zones
at all.

To solve these two problems, we employ superblock log writing. It uses two
adjacent zones as a circular buffer to write updated superblocks.  Once the
first zone is filled up, start writing into the second one.  Then, when
both zones are filled up and before starting to write to the first zone
again, it reset the first zone.

We can determine the position of the latest superblock by reading write
pointer information from a device. One corner case is when both zones are
full. For this situation, we read out the last superblock of each zone, and
compare them to determine which zone is older.

The following zones are reserved as the circular buffer on ZONED btrfs.

- primary superblock: offset   0B (and the following zone)
- first copy:         offset 512G (and the following zone)
- Second copy:        offset   4T (4096G, and the following zone)

If these reserved zones are conventional, superblock is written fixed at
the start of the zone without logging.

Currently, superblock reading/writing is done by pread/pwrite. This commit
replace the call sites with sbread/sbwrite to wrap the functions. For zoned
btrfs, btrfs_sb_io which is called from sbread/sbwrite reverses the IO
position back to a mirror number, maps the mirror number into the
superblock logging position, and do the IO.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds/inspect-dump-super.c |   3 +-
 common/device-scan.c      |   4 +-
 kerncompat.h              |  16 +++
 kernel-shared/disk-io.c   |  13 +-
 kernel-shared/zoned.c     | 280 ++++++++++++++++++++++++++++++++++++++
 kernel-shared/zoned.h     |  29 ++++
 6 files changed, 335 insertions(+), 10 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index f8d1506a6afd..04e81d8c3b60 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -25,6 +25,7 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/print-tree.h"
+#include "kernel-shared/zoned.h"
 #include "common/utils.h"
 #include "cmds/commands.h"
 #include "common/help.h"
@@ -38,7 +39,7 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 
 	sb = (struct btrfs_super_block *)super_block_data;
 
-	ret = pread64(fd, super_block_data, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
+	ret = sbread(fd, super_block_data, sb_bytenr);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
 		/* check if the disk if too short for further superblock */
 		if (ret == 0 && errno == 0)
diff --git a/common/device-scan.c b/common/device-scan.c
index 74d7853afccb..659f48c4dedb 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -190,7 +190,7 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_device_bytes_used(dev_item, device->bytes_used);
 	memcpy(&dev_item->uuid, device->uuid, BTRFS_UUID_SIZE);
 
-	ret = pwrite(fd, buf, sectorsize, BTRFS_SUPER_INFO_OFFSET);
+	ret = sbwrite(fd, buf, BTRFS_SUPER_INFO_OFFSET);
 	BUG_ON(ret != sectorsize);
 
 	free(buf);
@@ -267,7 +267,7 @@ int btrfs_device_already_in_root(struct btrfs_root *root, int fd,
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = pread(fd, buf, BTRFS_SUPER_INFO_SIZE, super_offset);
+	ret = sbread(fd, buf, super_offset);
 	if (ret != BTRFS_SUPER_INFO_SIZE)
 		goto brelse;
 
diff --git a/kerncompat.h b/kerncompat.h
index b2983ed60c4a..d37edfe7fdac 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -364,6 +364,19 @@ static inline int is_power_of_2(unsigned long n)
 	return (n != 0 && ((n & (n - 1)) == 0));
 }
 
+static inline int ilog2(u64 num)
+{
+	int l = 0;
+
+	num >>= 1;
+	while (num) {
+		l++;
+		num >>= 1;
+	}
+
+	return l;
+}
+
 typedef u16 __bitwise __le16;
 typedef u16 __bitwise __be16;
 typedef u32 __bitwise __le32;
@@ -371,6 +384,9 @@ typedef u32 __bitwise __be32;
 typedef u64 __bitwise __le64;
 typedef u64 __bitwise __be64;
 
+#define U64_MAX UINT64_MAX
+#define U32_MAX UINT32_MAX
+
 /* Macros to generate set/get funcs for the struct fields
  * assume there is a lefoo_to_cpu for every type, so lets make a simple
  * one for u8:
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 4aba237f5a5c..d79d6a00cdf8 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1615,7 +1615,7 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 	u64 bytenr;
 
 	if (sb_bytenr != BTRFS_SUPER_INFO_OFFSET) {
-		ret = pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
+		ret = sbread(fd, buf, sb_bytenr);
 		/* real error */
 		if (ret < 0)
 			return -errno;
@@ -1643,7 +1643,8 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 
 	for (i = 0; i < max_super; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, bytenr);
+		ret = sbread(fd, buf, bytenr);
+
 		if (ret < BTRFS_SUPER_INFO_SIZE)
 			break;
 
@@ -1715,9 +1716,8 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
 		 * zero filled, we can use it directly
 		 */
-		ret = pwrite64(device->fd, fs_info->super_copy,
-				BTRFS_SUPER_INFO_SIZE,
-				fs_info->super_bytenr);
+		ret = sbwrite(device->fd, fs_info->super_copy,
+			      fs_info->super_bytenr);
 		if (ret != BTRFS_SUPER_INFO_SIZE) {
 			errno = EIO;
 			error(
@@ -1750,8 +1750,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
 		 * zero filled, we can use it directly
 		 */
-		ret = pwrite64(device->fd, fs_info->super_copy,
-				BTRFS_SUPER_INFO_SIZE, bytenr);
+		ret = sbwrite(device->fd, fs_info->super_copy, bytenr);
 		if (ret != BTRFS_SUPER_INFO_SIZE) {
 			errno = EIO;
 			error(
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index ebaa2a81b2c8..1b235dc0a1c9 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -2,6 +2,7 @@
 
 #include <sys/ioctl.h>
 #include <linux/fs.h>
+#include <unistd.h>
 
 #include "kernel-lib/list.h"
 #include "kernel-shared/volumes.h"
@@ -14,6 +15,20 @@
 /* Maximum number of zones to report per ioctl(BLKREPORTZONE) call */
 #define BTRFS_REPORT_NR_ZONES   4096
 
+/*
+ * Location of the first zone of superblock logging zone pairs.
+ *
+ * - primary superblock:    0B (zone 0)
+ * - first copy:          512G (zone starting at that offset)
+ * - second copy:           4T (zone starting at that offset)
+ */
+#define BTRFS_SB_LOG_PRIMARY_OFFSET	(0ULL)
+#define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)
+#define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)
+
+#define BTRFS_SB_LOG_FIRST_SHIFT	ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
+#define BTRFS_SB_LOG_SECOND_SHIFT	ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
+
 #define EMULATED_ZONE_SIZE SZ_256M
 
 static int btrfs_get_dev_zone_info(struct btrfs_device *device);
@@ -117,6 +132,116 @@ static int emulate_report_zones(const char *file, int fd, u64 pos,
 	return i;
 }
 
+static int sb_write_pointer(int fd, struct blk_zone *zones, u64 *wp_ret)
+{
+	bool empty[BTRFS_NR_SB_LOG_ZONES];
+	bool full[BTRFS_NR_SB_LOG_ZONES];
+	sector_t sector;
+
+	ASSERT(zones[0].type != BLK_ZONE_TYPE_CONVENTIONAL &&
+	       zones[1].type != BLK_ZONE_TYPE_CONVENTIONAL);
+
+	empty[0] = zones[0].cond == BLK_ZONE_COND_EMPTY;
+	empty[1] = zones[1].cond == BLK_ZONE_COND_EMPTY;
+	full[0] = zones[0].cond == BLK_ZONE_COND_FULL;
+	full[1] = zones[1].cond == BLK_ZONE_COND_FULL;
+
+	/*
+	 * Possible states of log buffer zones
+	 *
+	 *           Empty[0]  In use[0]  Full[0]
+	 * Empty[1]         *          x        0
+	 * In use[1]        0          x        0
+	 * Full[1]          1          1        C
+	 *
+	 * Log position:
+	 *   *: Special case, no superblock is written
+	 *   0: Use write pointer of zones[0]
+	 *   1: Use write pointer of zones[1]
+	 *   C: Compare super blocks from zones[0] and zones[1], use the latest
+	 *      one determined by generation
+	 *   x: Invalid state
+	 */
+
+	if (empty[0] && empty[1]) {
+		/* Special case to distinguish no superblock to read */
+		*wp_ret = zones[0].start << SECTOR_SHIFT;
+		return -ENOENT;
+	} else if (full[0] && full[1]) {
+		/* Compare two super blocks */
+		u8 buf[BTRFS_NR_SB_LOG_ZONES][BTRFS_SUPER_INFO_SIZE];
+		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
+		int i;
+		int ret;
+
+		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+			u64 bytenr;
+
+			bytenr = ((zones[i].start + zones[i].len)
+				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
+
+			ret = pread64(fd, buf[i], BTRFS_SUPER_INFO_SIZE,
+				      bytenr);
+			if (ret != BTRFS_SUPER_INFO_SIZE)
+				return -EIO;
+			super[i] = (struct btrfs_super_block *)&buf[i];
+		}
+
+		if (super[0]->generation > super[1]->generation)
+			sector = zones[1].start;
+		else
+			sector = zones[0].start;
+	} else if (!full[0] && (empty[1] || full[1])) {
+		sector = zones[0].wp;
+	} else if (full[0]) {
+		sector = zones[1].wp;
+	} else {
+		return -EUCLEAN;
+	}
+	*wp_ret = sector << SECTOR_SHIFT;
+	return 0;
+}
+
+/*
+ * Get the first zone number of the superblock mirror
+ */
+static inline u32 sb_zone_number(int shift, int mirror)
+{
+	u64 zone = 0;
+
+	ASSERT(0 <= mirror && mirror < BTRFS_SUPER_MIRROR_MAX);
+	switch (mirror) {
+	case 0: zone = 0; break;
+	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
+	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
+	}
+
+	ASSERT(zone <= U32_MAX);
+
+	return (u32)zone;
+}
+
+int btrfs_reset_dev_zone(int fd, struct blk_zone *zone)
+{
+	struct blk_zone_range range;
+
+	/* Nothing to do if it is already empty */
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL ||
+	    zone->cond == BLK_ZONE_COND_EMPTY)
+		return 0;
+
+	range.sector = zone->start;
+	range.nr_sectors = zone->len;
+
+	if (ioctl(fd, BLKRESETZONE, &range) < 0)
+		return -errno;
+
+	zone->cond = BLK_ZONE_COND_EMPTY;
+	zone->wp = zone->start;
+
+	return 0;
+}
+
 static int report_zones(int fd, const char *file,
 			struct btrfs_zoned_device_info *zinfo)
 {
@@ -232,6 +357,161 @@ static int report_zones(int fd, const char *file,
 	return 0;
 }
 
+static int sb_log_location(int fd, struct blk_zone *zones, int rw,
+			   u64 *bytenr_ret)
+{
+	u64 wp;
+	int ret;
+
+	/* Use the head of the zones if either zone is conventional */
+	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
+		return 0;
+	} else if (zones[1].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		*bytenr_ret = zones[1].start << SECTOR_SHIFT;
+		return 0;
+	}
+
+	ret = sb_write_pointer(fd, zones, &wp);
+	if (ret != -ENOENT && ret < 0)
+		return ret;
+
+	if (rw == WRITE) {
+		struct blk_zone *reset = NULL;
+
+		if (wp == zones[0].start << SECTOR_SHIFT)
+			reset = &zones[0];
+		else if (wp == zones[1].start << SECTOR_SHIFT)
+			reset = &zones[1];
+
+		if (reset && reset->cond != BLK_ZONE_COND_EMPTY) {
+			ASSERT(reset->cond == BLK_ZONE_COND_FULL);
+
+			ret = btrfs_reset_dev_zone(fd, reset);
+			if (ret)
+				return ret;
+		}
+	} else if (ret != -ENOENT) {
+		/* For READ, we want the previous one */
+		if (wp == zones[0].start << SECTOR_SHIFT)
+			wp = (zones[1].start + zones[1].len) << SECTOR_SHIFT;
+		wp -= BTRFS_SUPER_INFO_SIZE;
+	}
+
+	*bytenr_ret = wp;
+	return 0;
+
+}
+
+size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
+{
+	size_t count = BTRFS_SUPER_INFO_SIZE;
+	struct stat stat_buf;
+	struct blk_zone_report *rep;
+	struct blk_zone *zones;
+	const u64 sb_size_sector = BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT;
+	u64 mapped = U64_MAX;
+	u32 zone_num;
+	unsigned int zone_size_sector;
+	size_t rep_size;
+	int mirror = -1;
+	int i;
+	int ret;
+	size_t ret_sz;
+
+	ASSERT(rw == READ || rw == WRITE);
+
+	if (fstat(fd, &stat_buf) == -1) {
+		error("fstat failed (%s)", strerror(errno));
+		exit(1);
+	}
+
+	/* Do not call ioctl(BLKGETZONESZ) on a regular file. */
+	if ((stat_buf.st_mode & S_IFMT) == S_IFBLK) {
+		ret = ioctl(fd, BLKGETZONESZ, &zone_size_sector);
+		if (ret) {
+			error("zoned: ioctl BLKGETZONESZ failed (%m)");
+			exit(1);
+		}
+	} else {
+		zone_size_sector = 0;
+	}
+
+	/* We can call pread/pwrite if 'fd' is non-zoned device/file. */
+	if (zone_size_sector == 0) {
+		if (rw == READ)
+			return pread64(fd, buf, count, offset);
+		return pwrite64(fd, buf, count, offset);
+	}
+
+	ASSERT(IS_ALIGNED(zone_size_sector, sb_size_sector));
+
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		if (offset == btrfs_sb_offset(i)) {
+			mirror = i;
+			break;
+		}
+	}
+	ASSERT(mirror != -1);
+
+	zone_num = sb_zone_number(ilog2(zone_size_sector) + SECTOR_SHIFT,
+				  mirror);
+
+	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone) * 2;
+	rep = calloc(1, rep_size);
+	if (!rep) {
+		error("zoned: no memory for zones report");
+		exit(1);
+	}
+
+	rep->sector = zone_num * (sector_t)zone_size_sector;
+	rep->nr_zones = 2;
+
+	ret = ioctl(fd, BLKREPORTZONE, rep);
+	if (ret) {
+		error("zoned: ioctl BLKREPORTZONE failed (%m)");
+		exit(1);
+	}
+	if (rep->nr_zones != 2) {
+		if (errno == ENOENT || errno == 0)
+			return (rw == WRITE ? count : 0);
+		error("zoned: failed to read zone info of %u and %u: %m",
+		      zone_num, zone_num + 1);
+		free(rep);
+		return 0;
+	}
+
+	zones = (struct blk_zone *)(rep + 1);
+
+	ret = sb_log_location(fd, zones, rw, &mapped);
+	/*
+	 * Special case: no superblock found in the zones. This case happens
+	 * when initializing a file-system.
+	 */
+	if (rw == READ && ret == -ENOENT) {
+		memset(buf, 0, count);
+		return count;
+	}
+	if (ret)
+		return ret;
+
+	if (rw == READ)
+		ret_sz = pread64(fd, buf, count, mapped);
+	else
+		ret_sz = pwrite64(fd, buf, count, mapped);
+
+	if (ret_sz != count)
+		return ret_sz;
+
+	/* Call fsync() to force the write order */
+	if (rw == WRITE && fsync(fd)) {
+		error("failed to synchronize superblock: %s", strerror(errno));
+		exit(1);
+	}
+
+	return ret_sz;
+}
+
 #endif
 
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info)
diff --git a/kernel-shared/zoned.h b/kernel-shared/zoned.h
index fcf2ccf34f26..82e3096eab8a 100644
--- a/kernel-shared/zoned.h
+++ b/kernel-shared/zoned.h
@@ -3,9 +3,14 @@
 #ifndef __BTRFS_ZONED_H__
 #define __BTRFS_ZONED_H__
 
+#include "kernel-shared/disk-io.h"
+
 #include <stdbool.h>
 #include "kerncompat.h"
 
+/* Number of superblock log zones */
+#define BTRFS_NR_SB_LOG_ZONES 2
+
 #ifdef BTRFS_ZONED
 #include <linux/blkzoned.h>
 #else
@@ -41,4 +46,28 @@ int btrfs_get_zone_info(int fd, const char *file,
 int btrfs_get_dev_zone_info_all_devices(struct btrfs_fs_info *fs_info);
 int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info);
 
+#ifdef BTRFS_ZONED
+size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw);
+static inline size_t sbread(int fd, void *buf, off_t offset)
+{
+	return btrfs_sb_io(fd, buf, offset, READ);
+}
+static inline size_t sbwrite(int fd, void *buf, off_t offset)
+{
+	return btrfs_sb_io(fd, buf, offset, WRITE);
+}
+int btrfs_reset_dev_zone(int fd, struct blk_zone *zone);
+#else
+#define sbread(fd, buf, offset) \
+	pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
+#define sbwrite(fd, buf, offset) \
+	pwrite64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
+
+static inline int btrfs_reset_dev_zone(int fd, struct blk_zone *zone)
+{
+	return 0;
+}
+
+#endif /* BTRFS_ZONED */
+
 #endif /* __BTRFS_ZONED_H__ */
-- 
2.31.1

