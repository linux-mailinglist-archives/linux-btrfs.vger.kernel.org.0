Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C211E4F67
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 22:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgE0Uh6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 16:37:58 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:56405 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgE0Uh5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 16:37:57 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-35.iol.local with ESMTPA
        id e2oDjlBCFLNQWe2oEjo7pd; Wed, 27 May 2020 22:37:54 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1590611874; bh=MAKLhVKArbhRtT6gAgKnnO89f/z0b+BhhmYUXSIonlQ=;
        h=From;
        b=cUiNCpEuePsokYq2OnV1nnoDurmLioLz+lfzwumFlzzy+b0ErbYK+4uGumupHGSFs
         IaVQLD7IwZ+hJjEJVdhsZtVxnAMLey6UfoJoPj820qNNyoglPghe8WY12HYHug5sFu
         FckUPz1qZmimNUsZRTeeFKlqDEEeQuZdGYQTTQL7CZaQUJomPCooOnGqXfEOpUBKet
         0HQlZ5t/96MpKlhLcBvlPs4W/LbA64h22phlY0yGW4OSUq5gKscp+6BHwJIHGZDBSs
         0HgeIeVDthhJSJdqEWWsENKaJdUHhMqUPIEPqPpuc/w+yv0QWBDCVb4kJMdx40tj7Z
         lO0yswLg6LOSg==
X-CNFS-Analysis: v=2.3 cv=LKsYv6e9 c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=_DrukUx0PzI0n8-yImAA:9 a=3LsFpPV6-A-viFYZ:21 a=pYP_qhgvev49joqv:21
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     DanglingPointer <danglingpointerexception@gmail.com>,
        Joshua Houghton <joshua.houghton@yandex.ru>,
        David Sterba <dsterba@suse.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH] Add support for RAID5/6 to the command "btrfs fi us".
Date:   Wed, 27 May 2020 22:37:48 +0200
Message-Id: <20200527203748.32860-2-kreijack@libero.it>
X-Mailer: git-send-email 2.27.0.rc2
In-Reply-To: <20200527203748.32860-1-kreijack@libero.it>
References: <20200527203748.32860-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHf1WVmlbQFBby4NokLPJbGeGwF55xax9BA0sav+b0UYMK/I0wWaVOXRxlKPeI0ulvG5+kBdrWC2X35GurGgNPJE7kaxauOlQGzBDH693pKxzRXcD5ML
 Dh29O5BZ6W0sROk5JbDNr2Wqc2kaJf9Pntcn83ZIVWoARouczqdehOrzXurx2PUWsaIbKefn0BJULm6epVpif4SgVwsSjSlzjsK/hVsj709kaoxhyWq5XzLD
 A3iMJfs2k3FfjUQN8GxIMwwi9bmDyBfgl5CNR+RtD+PDnVQfgdWeF0/3WHRjxnmlmOyVc9vqlWTLzUDTpr1GeQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

The function print_filesystem_usage_overall() prints the info on the
basis of the r_*_chunk, r_*_used and l_*_chunks values computed for
data, metadata and system chunks.

For the RAID1/10/1C3/1C4/DUP these info are easily accessible from the
info returned by load_space_info().

However for RAID5/6 this is not true because the ration between the l_*
and r_* values are not fixed but depend by the number of disks involved
in the chunk.

A new function called get_raid56_space_info() is created to compute
the values r_*_chunk, and r_*_used for data, metadata and system
chunks in case of a RAID5/6 profile.

The r_*_chunk values are computed from the chunk_info array.

In order to compute the r_*_used values, a new function
get_raid56_logical_ratio() is created. This function computes the ratio
l_*_used / l_*_chunk from the ioctl_space_args array.
So we can get:

	'r_*_used' = 'r_*_chunk' * 'l_*_used' / 'l_*_chunk'

Even tough this is not mathematically true every time, it is true in
"average" (for example if the RAID5 chunks use different number of disks
the real values depend by which chunk contains the data).

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 cmds/filesystem-usage.c | 144 +++++++++++++++++++++++++++++++---------
 1 file changed, 114 insertions(+), 30 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index b091e927..12f63db0 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -282,24 +282,111 @@ static struct btrfs_ioctl_space_args *load_space_info(int fd, const char *path)
 }
 
 /*
- * This function computes the space occupied by a *single* RAID5/RAID6 chunk.
- * The computation is performed on the basis of the number of stripes
- * which compose the chunk, which could be different from the number of devices
- * if a disk is added later.
+ * Compute the ratio between logical space used over logical space allocated
+ * by profile basis
  */
-static void get_raid56_used(struct chunk_info *chunks, int chunkcount,
-		u64 *raid5_used, u64 *raid6_used)
+static void get_raid56_logical_ratio(struct btrfs_ioctl_space_args *sargs,
+				     u64 type, double *data_ratio,
+				     double *metadata_ratio,
+				     double *system_ratio) {
+	u64	l_data_chunk = 0, l_data_used = 0;
+	u64	l_metadata_chunk = 0, l_metadata_used = 0;
+	u64	l_system_chunk = 0, l_system_used = 0;
+	int	i;
+
+	for (i = 0; i < sargs->total_spaces; i++) {
+		u64 flags = sargs->spaces[i].flags;
+
+		if (!(flags & type))
+			continue;
+
+		if (flags & BTRFS_BLOCK_GROUP_DATA) {
+			l_data_used += sargs->spaces[i].used_bytes;
+			l_data_chunk += sargs->spaces[i].total_bytes;
+		} else if (flags & BTRFS_BLOCK_GROUP_METADATA) {
+			l_metadata_used += sargs->spaces[i].used_bytes;
+			l_metadata_chunk += sargs->spaces[i].total_bytes;
+		} else if (flags & BTRFS_BLOCK_GROUP_SYSTEM) {
+			l_system_used += sargs->spaces[i].used_bytes;
+			l_system_chunk += sargs->spaces[i].total_bytes;
+		}
+	}
+
+	*data_ratio = *metadata_ratio = *system_ratio = -1.0;
+
+	if (l_data_chunk)
+		*data_ratio = (double)l_data_used/l_data_chunk;
+	if (l_metadata_chunk)
+		*metadata_ratio = (double)l_metadata_used/l_metadata_chunk;
+	if (l_system_chunk)
+		*system_ratio = (double)l_system_used/l_system_chunk;
+
+}
+
+/*
+ * Compute the "raw" space allocated for a chunk (r_*_chunks)
+ * and the "raw" space used by a chunk (r_*_used)
+ */
+static void get_raid56_space_info(struct btrfs_ioctl_space_args *sargs,
+				  struct chunk_info *chunks, int chunkcount,
+				  double *max_data_ratio,
+				  u64 *r_data_chunks, u64 *r_data_used,
+				  u64 *r_metadata_chunks, u64 *r_metadata_used,
+				  u64 *r_system_chunks, u64 *r_system_used)
 {
-	struct chunk_info *info_ptr = chunks;
-	*raid5_used = 0;
-	*raid6_used = 0;
-
-	while (chunkcount-- > 0) {
-		if (info_ptr->type & BTRFS_BLOCK_GROUP_RAID5)
-			(*raid5_used) += info_ptr->size / (info_ptr->num_stripes - 1);
-		if (info_ptr->type & BTRFS_BLOCK_GROUP_RAID6)
-			(*raid6_used) += info_ptr->size / (info_ptr->num_stripes - 2);
-		info_ptr++;
+	struct chunk_info *info_ptr;
+	double l_data_ratio_r5, l_metadata_ratio_r5, l_system_ratio_r5;
+	double l_data_ratio_r6, l_metadata_ratio_r6, l_system_ratio_r6;
+
+	get_raid56_logical_ratio(sargs, BTRFS_BLOCK_GROUP_RAID5,
+		 &l_data_ratio_r5, &l_metadata_ratio_r5, &l_system_ratio_r5);
+	get_raid56_logical_ratio(sargs, BTRFS_BLOCK_GROUP_RAID6,
+		 &l_data_ratio_r6, &l_metadata_ratio_r6, &l_system_ratio_r6);
+
+	for(info_ptr = chunks ; chunkcount > 0 ; chunkcount--, info_ptr++) {
+		int parities_count;
+		u64 size;
+		double l_data_ratio, l_metadata_ratio, l_system_ratio, rt;
+
+		if (info_ptr->type & BTRFS_BLOCK_GROUP_RAID5) {
+			parities_count = 1;
+			l_data_ratio = l_data_ratio_r5;
+			l_metadata_ratio = l_metadata_ratio_r5;
+			l_system_ratio = l_system_ratio_r5;
+		} else if (info_ptr->type & BTRFS_BLOCK_GROUP_RAID6) {
+			parities_count = 2;
+			l_data_ratio = l_data_ratio_r6;
+			l_metadata_ratio = l_metadata_ratio_r6;
+			l_system_ratio = l_system_ratio_r6;
+		} else {
+			continue;
+		}
+
+		rt = (double)info_ptr->num_stripes /
+			(info_ptr->num_stripes - parities_count);
+		if (rt > *max_data_ratio)
+			*max_data_ratio = rt;
+
+		/*
+		 * - 'size' is the total disk(s) space occuped by a chunk
+		 * - the product of 'size' and  '*_ratio' is "in average"
+		 * the disk(s) space used by the data
+		 */
+		size = info_ptr->size / (info_ptr->num_stripes - parities_count);
+
+		if (info_ptr->type & BTRFS_BLOCK_GROUP_DATA) {
+			assert(l_data_ratio >= 0);
+			*r_data_chunks += size;
+			*r_data_used += size * l_data_ratio;
+		} else if (info_ptr->type & BTRFS_BLOCK_GROUP_METADATA) {
+			assert(l_metadata_ratio >= 0);
+			*r_metadata_chunks += size;
+			*r_metadata_used += size * l_metadata_ratio;
+		} else if (info_ptr->type & BTRFS_BLOCK_GROUP_SYSTEM) {
+			assert(l_system_ratio >= 0);
+			*r_system_chunks += size;
+			*r_system_used += size * l_system_ratio;
+		}
 	}
 }
 
@@ -315,7 +402,9 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	int width = 10;		/* default 10 for human units */
 	/*
 	 * r_* prefix is for raw data
-	 * l_* is for logical
+	 * l_* prefix is for logical
+	 * *_used postfix is for space used for data or metadata
+	 * *_chunks postfix is for total space used by the chunk
 	 */
 	u64 r_total_size = 0;	/* filesystem size, sum of device sizes */
 	u64 r_total_chunks = 0;	/* sum of chunks sizes on disk(s) */
@@ -333,13 +422,11 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	double data_ratio;
 	double metadata_ratio;
 	/* logical */
-	u64 raid5_used = 0;
-	u64 raid6_used = 0;
 	u64 l_global_reserve = 0;
 	u64 l_global_reserve_used = 0;
 	u64 free_estimated = 0;
 	u64 free_min = 0;
-	int max_data_ratio = 1;
+	double max_data_ratio = 1.0;
 	int mixed = 0;
 
 	sargs = load_space_info(fd, path);
@@ -361,7 +448,12 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 		ret = 1;
 		goto exit;
 	}
-	get_raid56_used(chunkinfo, chunkcount, &raid5_used, &raid6_used);
+
+	get_raid56_space_info(sargs, chunkinfo, chunkcount,
+				&max_data_ratio,
+				&r_data_chunks, &r_data_used,
+				&r_metadata_chunks, &r_metadata_used,
+				&r_system_chunks, &r_system_used);
 
 	for (i = 0; i < sargs->total_spaces; i++) {
 		int ratio;
@@ -369,7 +461,7 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 
 		/*
 		 * The raid5/raid6 ratio depends by the stripes number
-		 * used by every chunk. It is computed separately
+		 * used by every chunk. It was computed separately
 		 */
 		if (flags & BTRFS_BLOCK_GROUP_RAID0)
 			ratio = 1;
@@ -390,9 +482,6 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 		else
 			ratio = 1;
 
-		if (!ratio)
-			warning("RAID56 detected, not implemented");
-
 		if (ratio > max_data_ratio)
 			max_data_ratio = ratio;
 
@@ -435,11 +524,6 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	else
 		metadata_ratio = (double)r_metadata_chunks / l_metadata_chunks;
 
-#if 0
-	/* add the raid5/6 allocated space */
-	total_chunks += raid5_used + raid6_used;
-#endif
-
 	/*
 	 * We're able to fill at least DATA for the unused space
 	 *
-- 
2.27.0.rc2

