Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195764389F4
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Oct 2021 17:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhJXPmA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Oct 2021 11:42:00 -0400
Received: from michael.mail.tiscali.it ([213.205.33.246]:57680 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231394AbhJXPl7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Oct 2021 11:41:59 -0400
Received: from venice.bhome ([78.14.151.87])
        by michael.mail.tiscali.it with 
        id 9rXD2600J1tPKGW01rXGcx; Sun, 24 Oct 2021 15:31:16 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/4] btrfs: add allocator_hint mode
Date:   Sun, 24 Oct 2021 17:31:07 +0200
Message-Id: <bf30502eb53ea2c1c05c2ae96c3788d3e327d59e.1635089352.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1635089352.git.kreijack@inwind.it>
References: <cover.1635089352.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1635089476; bh=bnPaRKVlhRckOuonAzpgHCtzu7Qe+vN7oFYduUkSHcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=DqWuaQ9Bf+JJZWH0SRbPkgbsPLcMsI0hTeE7AZM85H3PpRBtxayQqD4ruRNnWkVpE
         FRZA1PlrU6Rm96JR3FMa8n8hGkxaX34csjvMQLKH2zoC2zyBiazs4WTjWdEVgszee6
         AqIbAUvDKhk7IL/17onekT9soHSj7ScVESAmcuW0=
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
index 8ac99771f43c..7ee9c6e7bd44 100644
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
@@ -4997,13 +5011,18 @@ static int btrfs_add_system_chunk(struct btrfs_fs_info *fs_info,
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
@@ -5166,6 +5185,8 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 	int ndevs = 0;
 	u64 max_avail;
 	u64 dev_offset;
+	int hint;
+	int i;
 
 	/*
 	 * in the first pass through the devices list, we gather information
@@ -5218,16 +5239,91 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
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
index b8250f29df6e..37eb37b533c5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -369,6 +369,7 @@ struct btrfs_device_info {
 	u64 dev_offset;
 	u64 max_avail;
 	u64 total_avail;
+	int alloc_hint;
 };
 
 struct btrfs_raid_attr {
-- 
2.33.0

