Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96A318A6DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 22:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCRVUN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 17:20:13 -0400
Received: from smtp-16.italiaonline.it ([213.209.10.16]:56106 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726757AbgCRVUN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 17:20:13 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2020 17:20:10 EDT
Received: from venice.bhome ([84.220.24.82])
        by smtp-16.iol.local with ESMTPA
        id EfyqjciCzjfNYEfyrjb08g; Wed, 18 Mar 2020 22:12:01 +0100
x-libjamoibt: 1601
X-CNFS-Analysis: v=2.3 cv=TY3oSiYh c=1 sm=1 tr=0
 a=ijacSk0KxWtIQ5WY4X6b5g==:117 a=ijacSk0KxWtIQ5WY4X6b5g==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=sfptgZULkobmiDc4ytEA:9
 a=Cgh7EZMwUPSdKskH:21 a=nJ9zBByAM1OEFezB:21
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH] Add support for the raid5/6 profiles in the btrfs fi us command.
Date:   Wed, 18 Mar 2020 22:11:57 +0100
Message-Id: <20200318211157.11090-2-kreijack@libero.it>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200318211157.11090-1-kreijack@libero.it>
References: <20200318211157.11090-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfNt8DaNn92UbypI7RFxnP/hN1ZFlt6GERVlignL1DvV8fjpEOCxCTpbTKIYnsex0VD1WEtQi+PcRM/XNpwrkKfsbin3h0+7IGpetM63oMbOZIxDchFUR
 d+3prT2oOPLY5N9d2tKrA9uD5pBLSeoIi0ngDpWFiNCSc/Gi3ZGSGlpTqj4yPnXgH973ssi5F02vivCX4/qhOkvunnNCitWiEE0MXmlGhi8DkpYBDgW1L+Fz
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>

---
 cmds/filesystem-usage.c | 140 +++++++++++++++++++++++++++++-----------
 1 file changed, 101 insertions(+), 39 deletions(-)

diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
index aa7065d5..a85a209b 100644
--- a/cmds/filesystem-usage.c
+++ b/cmds/filesystem-usage.c
@@ -282,24 +282,44 @@ static struct btrfs_ioctl_space_args *load_space_info(int fd, const char *path)
 }
 
 /*
- * This function computes the space occupied by a *single* RAID5/RAID6 chunk.
- * The computation is performed on the basis of the number of stripes
- * which compose the chunk, which could be different from the number of devices
- * if a disk is added later.
+ * This function computes the chunks size of the RAID5/RAID6
+ * stripes and the max raw_size/logical_size ratio.
  */
-static void get_raid56_used(struct chunk_info *chunks, int chunkcount,
-		u64 *raid5_used, u64 *raid6_used)
+static void raid56_bgs_size(struct chunk_info *chunks, int chunkcount,
+		u64 *r_data_raid56,
+		u64 *r_metadata_raid56,
+		u64 *r_system_raid56,
+		double *data_ratio)
 {
 	struct chunk_info *info_ptr = chunks;
-	*raid5_used = 0;
-	*raid6_used = 0;
-
-	while (chunkcount-- > 0) {
-		if (info_ptr->type & BTRFS_BLOCK_GROUP_RAID5)
-			(*raid5_used) += info_ptr->size / (info_ptr->num_stripes - 1);
-		if (info_ptr->type & BTRFS_BLOCK_GROUP_RAID6)
-			(*raid6_used) += info_ptr->size / (info_ptr->num_stripes - 2);
+
+	while (chunkcount > 0) {
+		u64 size;
+		if (info_ptr->type & BTRFS_BLOCK_GROUP_RAID5) {
+			size = info_ptr->size /	(info_ptr->num_stripes - 1);
+			*data_ratio = max(*data_ratio,
+				1.0*info_ptr->num_stripes /
+					(info_ptr->num_stripes - 1));
+		} else if (info_ptr->type & BTRFS_BLOCK_GROUP_RAID6) {
+			size = info_ptr->size / (info_ptr->num_stripes - 2);
+			*data_ratio = max(*data_ratio,
+				1.0*info_ptr->num_stripes /
+					(info_ptr->num_stripes - 2));
+		} else {
+			/* other raid profiles... */
+			info_ptr++;
+			chunkcount--;
+			continue;
+		}
+		if (info_ptr->type & BTRFS_BLOCK_GROUP_DATA)
+			*r_data_raid56 += size;
+		else if (info_ptr->type & BTRFS_BLOCK_GROUP_METADATA)
+			*r_system_raid56 += size;
+		else if (info_ptr->type & BTRFS_BLOCK_GROUP_SYSTEM)
+			*r_system_raid56 += size;
+
 		info_ptr++;
+		chunkcount--;
 	}
 }
 
@@ -315,6 +335,7 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	/*
 	 * r_* prefix is for raw data
 	 * l_* is for logical
+	 * *_r56 is for RAID5/RAID6
 	 */
 	u64 r_total_size = 0;	/* filesystem size, sum of device sizes */
 	u64 r_total_chunks = 0;	/* sum of chunks sizes on disk(s) */
@@ -322,23 +343,29 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	u64 r_total_unused = 0;
 	u64 r_total_missing = 0;	/* sum of missing devices size */
 	u64 r_data_used = 0;
+	u64 l_data_used = 0;
+	u64 l_data_used_r56 = 0;
 	u64 r_data_chunks = 0;
+	u64 r_data_chunks_r56 = 0;
 	u64 l_data_chunks = 0;
+	u64 l_data_chunks_r56 = 0;
 	u64 r_metadata_used = 0;
+	u64 l_metadata_used = 0;
+	u64 l_metadata_used_r56 = 0;
 	u64 r_metadata_chunks = 0;
+	u64 r_metadata_chunks_r56 = 0;
 	u64 l_metadata_chunks = 0;
+	u64 l_metadata_chunks_r56 = 0;
 	u64 r_system_used = 0;
 	u64 r_system_chunks = 0;
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
+	double max_data_ratio = 1;
 	int mixed = 0;
 
 	sargs = load_space_info(fd, path);
@@ -360,7 +387,14 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 		ret = 1;
 		goto exit;
 	}
-	get_raid56_used(chunkinfo, chunkcount, &raid5_used, &raid6_used);
+	/*
+	 * the data coming from space info is not sufficient to compute
+	 * r_{data,metadata,system}_chunks values, so have to analyze the
+	 * chunks info.
+	 */
+	raid56_bgs_size(chunkinfo, chunkcount,
+		&r_data_chunks_r56, &r_metadata_chunks_r56, &r_system_chunks,
+		&max_data_ratio);
 
 	for (i = 0; i < sargs->total_spaces; i++) {
 		int ratio;
@@ -389,9 +423,6 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 		else
 			ratio = 1;
 
-		if (!ratio)
-			warning("RAID56 detected, not implemented");
-
 		if (ratio > max_data_ratio)
 			max_data_ratio = ratio;
 
@@ -404,14 +435,26 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 			mixed = 1;
 		}
 		if (flags & BTRFS_BLOCK_GROUP_DATA) {
-			r_data_used += sargs->spaces[i].used_bytes * ratio;
-			r_data_chunks += sargs->spaces[i].total_bytes * ratio;
+			l_data_used += sargs->spaces[i].used_bytes;
 			l_data_chunks += sargs->spaces[i].total_bytes;
+			if (!ratio) {
+				l_data_used_r56 += sargs->spaces[i].used_bytes;
+				l_data_chunks_r56 += sargs->spaces[i].total_bytes;
+			} else {
+				r_data_used += sargs->spaces[i].used_bytes * ratio;
+				r_data_chunks += sargs->spaces[i].total_bytes * ratio;
+			}
 		}
 		if (flags & BTRFS_BLOCK_GROUP_METADATA) {
-			r_metadata_used += sargs->spaces[i].used_bytes * ratio;
-			r_metadata_chunks += sargs->spaces[i].total_bytes * ratio;
+			l_metadata_used += sargs->spaces[i].used_bytes;
 			l_metadata_chunks += sargs->spaces[i].total_bytes;
+			if (!ratio) {
+				l_metadata_used_r56 += sargs->spaces[i].used_bytes;
+				l_metadata_chunks_r56 += sargs->spaces[i].total_bytes;
+			} else {
+				r_metadata_used += sargs->spaces[i].used_bytes * ratio;
+				r_metadata_chunks += sargs->spaces[i].total_bytes * ratio;
+			}
 		}
 		if (flags & BTRFS_BLOCK_GROUP_SYSTEM) {
 			r_system_used += sargs->spaces[i].used_bytes * ratio;
@@ -419,6 +462,29 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 		}
 	}
 
+	/*
+	 * Add the size of RAID5/6 chunks to the total
+	 */
+	r_data_chunks += r_data_chunks_r56;
+	r_metadata_chunks += r_metadata_chunks_r56;
+
+	/*
+	 * Add the size of RAID5/6 data size to the *_used.
+	 * This computation is not exact. However it is the best approximation
+	 * with the data currently available.
+	 * E.g. in case of two block-group RAID5 with different number
+	 * of disks (unusual but not impossible), the real r_*_used is
+	 * different depending which chunk is filled first. Because we have
+	 * only a cumulative info (i.e. only for RAID5), we made a linear
+	 * approximation.
+	 */
+	if (l_data_chunks_r56 > 1024)
+		r_data_used += (double)r_data_chunks_r56 * l_data_used_r56 /
+				l_data_chunks_r56;
+	if (l_metadata_chunks_r56 > 1024)
+		r_metadata_used += (double)r_metadata_chunks_r56 * l_metadata_used_r56 /
+				l_metadata_chunks_r56;
+
 	r_total_chunks = r_data_chunks + r_system_chunks;
 	r_total_used = r_data_used + r_system_used;
 	if (!mixed) {
@@ -434,21 +500,11 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	else
 		metadata_ratio = (double)r_metadata_chunks / l_metadata_chunks;
 
-#if 0
-	/* add the raid5/6 allocated space */
-	total_chunks += raid5_used + raid6_used;
-#endif
-
 	/*
-	 * We're able to fill at least DATA for the unused space
-	 *
-	 * With mixed raid levels, this gives a rough estimate but more
-	 * accurate than just counting the logical free space
-	 * (l_data_chunks - l_data_used)
-	 *
-	 * In non-mixed case there's no difference.
+	 * We're able to fill at least DATA for the unused space in the
+	 * already allocated chunks.
 	 */
-	free_estimated = (r_data_chunks - r_data_used) / data_ratio;
+	free_estimated = l_data_chunks - l_data_used;
 	/*
 	 * For mixed-bg the metadata are left out in calculations thus global
 	 * reserve would be lost. Part of it could be permanently allocated,
@@ -459,7 +515,13 @@ static int print_filesystem_usage_overall(int fd, struct chunk_info *chunkinfo,
 	free_min = free_estimated;
 
 	/* Chop unallocatable space */
-	/* FIXME: must be applied per device */
+	/*
+	 * FIXME: must be applied per device
+	 * FIXME: we should use the info returned by the kernel function
+	 * 	get_alloc_profile() to computing the data_ratio
+	 * FIXME: we should use the 4 (as RAID1C4) to computing the
+	 * 	max_data_ratio
+	 */
 	if (r_total_unused >= MIN_UNALOCATED_THRESH) {
 		free_estimated += r_total_unused / data_ratio;
 		/* Match the calculation of 'df', use the highest raid ratio */
-- 
2.26.0.rc2

