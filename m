Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA564322140
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Feb 2021 22:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhBVVUJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Feb 2021 16:20:09 -0500
Received: from smtp-34.italiaonline.it ([213.209.10.34]:38903 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231351AbhBVVUF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Feb 2021 16:20:05 -0500
Received: from venice.bhome ([78.12.28.43])
        by smtp-34.iol.local with ESMTPA
        id EIbml5cmb5WrZEIbwlGlol; Mon, 22 Feb 2021 22:19:20 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
        t=1614028760; bh=hbuPDumVgTT49bBH7toJhn5xvC+fWg/mnlhWUgc0kTQ=;
        h=From;
        b=KPE3qzMOLRKwTCcNfmxGdehmgqAmRBSioZXyGnykLHdkMcHVxkzH54Z+o4QEWJcm4
         DI50HOL3o6FXywu1xFHr0GVdEJITIJpYvrIG8LeUJs/uWoSboI/ot0wLHIbltDv5Xs
         bJTtoDmOHS24iaF+Gey+rS7sHU5JxdUT7DoHQE8xjHC2lB1mf5JQFM0MWPdee11BdR
         oI6GnOpq5bKkWMqj87cIZkpeqv7DUL3uH7K56nIDT1xF2n5P22jxGRqC6fYyo+srRJ
         HiavKzxQK5pBXUZVAPg/k8omUFeSt3eBU8lsxfQ7/jA34qEDY+WpZlTJKoOsOvCrlH
         5V2KSWXFK58+A==
X-CNFS-Analysis: v=2.4 cv=W4/96Tak c=1 sm=1 tr=0 ts=60341fd8 cx=a_exe
 a=Q5/16X4GlyvtzKxRBiE+Uw==:117 a=Q5/16X4GlyvtzKxRBiE+Uw==:17
 a=mBwWaMFk0AQlTOBnrgkA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/4] btrfs: add allocator_hint mode
Date:   Mon, 22 Feb 2021 22:19:09 +0100
Message-Id: <d4ebb03b09a9aceca099830ec7add523a7ed949d.1614028083.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1614028083.git.kreijack@inwind.it>
References: <cover.1614028083.git.kreijack@inwind.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCal3Sg7EakDGjxUtmmyvugb4nbwuNm54g/5a4Vt9sSbXly5L+cLCw97fO2acXZ4iHdEn+wPavqxIliwAmfOQweVtSUB1iExoEJv6Usn/OsZ3iaQHfb/
 HpFLYRd5FZUFPTJ+Mp0Iw8wcoXwa4CVjjn2L9a90GpX4sg1WrG8PE9E8iwE9+aH7LmYxQ6rz0eaGVmxjz/D7Gt8H1/P4V6Kol+b9ssFwWW7lu98EiogB84Xy
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

When this mode is enabled, the chunk allocation policy is modified as
follow.

Each disk may have a different tag:
- BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
- BTRFS_DEV_ALLOCATION_METADATA_ONLY
- BTRFS_DEV_ALLOCATION_DATA_ONLY
- BTRFS_DEV_ALLOCATION_PREFERRED_DATA (default)

Where:
- ALLOCATION_PREFERRED_X means that it is preferred to use this disk for
the X chunk type (the other type may be allowed when the space is low)
- ALLOCATION_X_ONLY means that it is used *only* for the X chunk type.
This means also that it is a preferred choice.

Each time the allocator allocates a chunk of type X , first it takes the
disks tagged as ALLOCATION_X_ONLY or ALLOCATION_PREFERRED_X; if the space
is not enough, it uses also the disks tagged as ALLOCATION_METADATA_ONLY;
if the space is not enough, it uses also the other disks, with the
exception of the one marked as ALLOCATION_PREFERRED_Y, where Y the other
type of chunk (i.e. not X).

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/volumes.c | 98 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h |  1 +
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 0c649b444dcd..7ab10640758c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -153,6 +153,20 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	},
 };
 
+#define BTRFS_DEV_ALLOCATION_MASK ((1ULL << \
+		BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT) - 1)
+#define BTRFS_DEV_ALLOCATION_MASK_COUNT (1ULL << \
+		BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT)
+
+static const char alloc_hint_map[BTRFS_DEV_ALLOCATION_MASK_COUNT] = {
+	[BTRFS_DEV_ALLOCATION_DATA_ONLY] = -1,
+	[BTRFS_DEV_ALLOCATION_PREFERRED_DATA] = 0,
+	[BTRFS_DEV_ALLOCATION_PREFERRED_METADATA] = 1,
+	[BTRFS_DEV_ALLOCATION_METADATA_ONLY] = 2,
+	/* the other values are set to 0 */
+};
+
+
 const char *btrfs_bg_type_to_raid_name(u64 flags)
 {
 	const int index = btrfs_bg_flags_to_raid_index(flags);
@@ -4872,13 +4886,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
 }
 
 /*
- * sort the devices in descending order by max_avail, total_avail
+ * sort the devices in descending order by alloc_hint,
+ * max_avail, total_avail
  */
 static int btrfs_cmp_device_info(const void *a, const void *b)
 {
 	const struct btrfs_device_info *di_a = a;
 	const struct btrfs_device_info *di_b = b;
 
+	if (di_a->alloc_hint > di_b->alloc_hint)
+		return -1;
+	if (di_a->alloc_hint < di_b->alloc_hint)
+		return 1;
 	if (di_a->max_avail > di_b->max_avail)
 		return -1;
 	if (di_a->max_avail < di_b->max_avail)
@@ -5039,6 +5058,8 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	int ndevs = 0;
 	u64 max_avail;
 	u64 dev_offset;
+	int hint;
+	int i;
 
 	/*
 	 * in the first pass through the devices list, we gather information
@@ -5091,16 +5112,91 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		devices_info[ndevs].max_avail = max_avail;
 		devices_info[ndevs].total_avail = total_avail;
 		devices_info[ndevs].dev = device;
+
+		if ((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
+		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) {
+			/*
+			 * if mixed bg set all the alloc_hint
+			 * fields to the same value, so the sorting
+			 * is not affected
+			 */
+			devices_info[ndevs].alloc_hint = 0;
+		} else if (ctl->type & BTRFS_BLOCK_GROUP_DATA) {
+			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
+
+			/*
+			 * skip BTRFS_DEV_METADATA_ONLY disks
+			 */
+			if (hint == BTRFS_DEV_ALLOCATION_METADATA_ONLY)
+				continue;
+			/*
+			 * if a data chunk must be allocated,
+			 * sort also by hint (data disk
+			 * higher priority)
+			 */
+			devices_info[ndevs].alloc_hint = -alloc_hint_map[hint];
+		} else { /* BTRFS_BLOCK_GROUP_METADATA */
+			hint = device->type & BTRFS_DEV_ALLOCATION_MASK;
+
+			/*
+			 * skip BTRFS_DEV_DATA_ONLY disks
+			 */
+			if (hint == BTRFS_DEV_ALLOCATION_DATA_ONLY)
+				continue;
+			/*
+			 * if a data chunk must be allocated,
+			 * sort also by hint (metadata hint
+			 * higher priority)
+			 */
+			devices_info[ndevs].alloc_hint = alloc_hint_map[hint];
+		}
+
 		++ndevs;
 	}
 	ctl->ndevs = ndevs;
 
+	/*
+	 * no devices available
+	 */
+	if (!ndevs)
+		return 0;
+
 	/*
 	 * now sort the devices by hole size / available space
 	 */
 	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
 	     btrfs_cmp_device_info, NULL);
 
+	/*
+	 * select the minimum set of disks grouped by hint that
+	 * can host the chunk
+	 */
+	ndevs = 0;
+	while (ndevs < ctl->ndevs) {
+		hint = devices_info[ndevs++].alloc_hint;
+		while (ndevs < ctl->ndevs &&
+		       devices_info[ndevs].alloc_hint == hint)
+				ndevs++;
+		if (ndevs >= ctl->devs_min)
+			break;
+	}
+
+	BUG_ON(ndevs > ctl->ndevs);
+	ctl->ndevs = ndevs;
+
+	/*
+	 * the next layers require the devices_info ordered by
+	 * max_avail. If we are returing two (or more) different
+	 * group of alloc_hint, this is not always true. So sort
+	 * these gain.
+	 */
+
+	for (i = 0 ; i < ndevs ; i++)
+		devices_info[i].alloc_hint = 0;
+
+	sort(devices_info, ndevs, sizeof(struct btrfs_device_info),
+	     btrfs_cmp_device_info, NULL);
+
 	return 0;
 }
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 0c07b8deecab..d192aa78f03f 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -366,6 +366,7 @@ struct btrfs_device_info {
 	u64 dev_offset;
 	u64 max_avail;
 	u64 total_avail;
+	int alloc_hint;
 };
 
 struct btrfs_raid_attr {
-- 
2.30.0

