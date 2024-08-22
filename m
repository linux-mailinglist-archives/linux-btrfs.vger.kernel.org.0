Return-Path: <linux-btrfs+bounces-7403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB5F95B3B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 13:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F3028355D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9621C93B5;
	Thu, 22 Aug 2024 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="I+AGRzXm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B516EB54
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326039; cv=none; b=VVB5j2NiAANRgJLEiFpbbFRC37YvAjRuAKd9g0iabKlJ0YL9Za3WGrphUQeOXRHDRmq1edy0arfdoElehPfWBbu8vuKNaTmTXQ0q0p3ncDqkce8SrA3qQ2FLQV9ixCM36FRoNqZG0CvxXaGFvhIBN+X4C32EaG9xwgiswG3KliU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326039; c=relaxed/simple;
	bh=0egdaud3XJnLrHOfKJR02AkJ9G1kwMRfcILmqDKOvbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W4fzt3PitVDXIo8XE9WsRiKIugZFxxMHDjCx4aIYQc9oxcWa05QfMbR51ofcKJGGm6fSnoWHe2mjl+Os8R6+WghswpgClksfRIsiChT7BC7/csailTxU2m5H913mlejY6wPC3VHsgbw9+GvZA+NhpgRUgV47CEaBkc3+c0sqo0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=I+AGRzXm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3e9fb6ee9so7287981fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1724326034; x=1724930834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OdcrbgUwYZCbvTxgX6hl7dn8mDljxmv7MhBnsCIJfOc=;
        b=I+AGRzXm8LJ07LPiI2Y6KctwlfnF0wefl83XokyCP5SfwVPnPAoJVZPbE6o5vEC/AP
         Eiip3H4W30vxtlxg+LbywQyCh6+oxgdQawGMM08tew1Ilxqt5g0/zTImTLFW5yaIBBP/
         aBbvAa6SjCgQKOeC6YylMOlrp5t9+XfeZl5tO1KHc6HoiWGV77MDgJ9sC/NyMBc846Mj
         RztnlxbeFd28laXSluC8PN9sUkyR5gi3WrYM75+/W3ue0LsSeN6wlkn/OsELoIzpceI4
         le7ZUeQt3b8Jbb3PShxTYwIucpb1Y9o95d5AWgM8cn3tnRzO3Pmco9Q+IJQGTSZWLNoW
         WL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724326034; x=1724930834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdcrbgUwYZCbvTxgX6hl7dn8mDljxmv7MhBnsCIJfOc=;
        b=RP0hdNFGhwUBwWItB1BOqQz/lZqTeQKZrdnoSU314++/5qqAIBjsy+WZGJ3bZOsmqV
         lZCGwX/Kdm3D0EHR74uYSijVMpP3kwhrHmzj0eLdAYBwQWRGZYPLwb3YPPEPMGNu9/yE
         htDhtbNnlJreMx96zjPZpdBqT8knjHqP3r8vHKB4oZkgn4CavBiE8SOU5s6kaO8RzieN
         yMrAZp9+ixd/U+nXD20b0YtbN3xhfftfBufOhuQYjnlhX3avratdAZAaZfVNz+JZOSdc
         UAecMEaw6FOz3xWuwYBKye0fQLaL9eGZ/EFAbxrsS6eLpH/ewAu4K7fd2qw6KXTXGUQn
         NxAw==
X-Forwarded-Encrypted: i=1; AJvYcCVwO1iHijZ9TCqMcYDG8szp1pF9eywdT6Msgdr4LKRJik6zYFwCjsb31Dq1SM5Ia9rHpWWRoGaxLnC4mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ty1pTq7PmwND15sH5FxLzi8VoP14G34E7SI/MKyfE9R9l9uq
	FvE6EEHAqdmdhmg8TWDCZndbdTobnwITBvCKswHGKuJhxWDoNBawHyA2DEKikLA=
X-Google-Smtp-Source: AGHT+IHAU8FDGqmIJEUfnfRLVt+aTgE3s5SHVaHgmnI/b3XT2WX5U2lY1l6UDcY90CmnGCCqaxafaQ==
X-Received: by 2002:a2e:f19:0:b0:2ef:2d3a:e70a with SMTP id 38308e7fff4ca-2f3f883066amr30830081fa.18.1724326033653;
        Thu, 22 Aug 2024 04:27:13 -0700 (PDT)
Received: from localhost ([2a02:8071:8280:d6e0:e324:b080:c95e:f348])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddbccbsm803653a12.11.2024.08.22.04.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 04:27:13 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: swapfile: fix SSD detection with swapfile on btrfs
Date: Thu, 22 Aug 2024 13:24:58 +0200
Message-ID: <20240822112707.351844-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've been noticing a trend of significant lock contention in the swap
subsystem as core counts have been increasing in our fleet. It turns
out that our swapfiles on btrfs on flash were in fact using the old
swap code for rotational storage.

This turns out to be a detection issue in the swapon sequence: btrfs
sets si->bdev during swap activation, which currently happens *after*
swapon's SSD detection and cluster setup. Thus, none of the SSD
optimizations and cluster lock splitting are enabled for btrfs swap.

Rearrange the swapon sequence so that filesystem activation happens
*before* determining swap behavior based on the backing device.

Afterwards, the nonrotational drive is detected correctly:

- Adding 2097148k swap on /mnt/swapfile.  Priority:-3 extents:1 across:2097148k
+ Adding 2097148k swap on /mnt/swapfile.  Priority:-3 extents:1 across:2097148k SS

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/swapfile.c | 165 ++++++++++++++++++++++++++------------------------
 1 file changed, 86 insertions(+), 79 deletions(-)

Changes since RFC:
o walk badpages[] instead of [0, maxpages] for faster swapon (thanks Ying!)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c1638a009113..aff73a3d0ead 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3196,29 +3196,15 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
 static int setup_swap_map_and_extents(struct swap_info_struct *si,
 					union swap_header *swap_header,
 					unsigned char *swap_map,
-					struct swap_cluster_info *cluster_info,
 					unsigned long maxpages,
 					sector_t *span)
 {
-	unsigned int j, k;
 	unsigned int nr_good_pages;
+	unsigned long i;
 	int nr_extents;
-	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
-	unsigned long col = si->cluster_next / SWAPFILE_CLUSTER % SWAP_CLUSTER_COLS;
-	unsigned long i, idx;
 
 	nr_good_pages = maxpages - 1;	/* omit header page */
 
-	INIT_LIST_HEAD(&si->free_clusters);
-	INIT_LIST_HEAD(&si->full_clusters);
-	INIT_LIST_HEAD(&si->discard_clusters);
-
-	for (i = 0; i < SWAP_NR_ORDERS; i++) {
-		INIT_LIST_HEAD(&si->nonfull_clusters[i]);
-		INIT_LIST_HEAD(&si->frag_clusters[i]);
-		si->frag_cluster_nr[i] = 0;
-	}
-
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 		if (page_nr == 0 || page_nr > swap_header->info.last_page)
@@ -3226,25 +3212,11 @@ static int setup_swap_map_and_extents(struct swap_info_struct *si,
 		if (page_nr < maxpages) {
 			swap_map[page_nr] = SWAP_MAP_BAD;
 			nr_good_pages--;
-			/*
-			 * Haven't marked the cluster free yet, no list
-			 * operation involved
-			 */
-			inc_cluster_info_page(si, cluster_info, page_nr);
 		}
 	}
 
-	/* Haven't marked the cluster free yet, no list operation involved */
-	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++)
-		inc_cluster_info_page(si, cluster_info, i);
-
 	if (nr_good_pages) {
 		swap_map[0] = SWAP_MAP_BAD;
-		/*
-		 * Not mark the cluster free yet, no list
-		 * operation involved
-		 */
-		inc_cluster_info_page(si, cluster_info, 0);
 		si->max = maxpages;
 		si->pages = nr_good_pages;
 		nr_extents = setup_swap_extents(si, span);
@@ -3257,8 +3229,70 @@ static int setup_swap_map_and_extents(struct swap_info_struct *si,
 		return -EINVAL;
 	}
 
+	return nr_extents;
+}
+
+static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
+						union swap_header *swap_header,
+						unsigned long maxpages)
+{
+	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
+	unsigned long col = si->cluster_next / SWAPFILE_CLUSTER % SWAP_CLUSTER_COLS;
+	struct swap_cluster_info *cluster_info;
+	unsigned long i, j, k, idx;
+	int cpu, err = -ENOMEM;
+
+	cluster_info = kvcalloc(nr_clusters, sizeof(*cluster_info), GFP_KERNEL);
 	if (!cluster_info)
-		return nr_extents;
+		goto err;
+
+	for (i = 0; i < nr_clusters; i++)
+		spin_lock_init(&cluster_info[i].lock);
+
+	si->cluster_next_cpu = alloc_percpu(unsigned int);
+	if (!si->cluster_next_cpu)
+		goto err_free;
+
+	/* Random start position to help with wear leveling */
+	for_each_possible_cpu(cpu)
+		per_cpu(*si->cluster_next_cpu, cpu) =
+		get_random_u32_inclusive(1, si->highest_bit);
+
+	si->percpu_cluster = alloc_percpu(struct percpu_cluster);
+	if (!si->percpu_cluster)
+		goto err_free;
+
+	for_each_possible_cpu(cpu) {
+		struct percpu_cluster *cluster;
+
+		cluster = per_cpu_ptr(si->percpu_cluster, cpu);
+		for (i = 0; i < SWAP_NR_ORDERS; i++)
+			cluster->next[i] = SWAP_NEXT_INVALID;
+	}
+
+	/*
+	 * Mark unusable pages as unavailable. The clusters aren't
+	 * marked free yet, so no list operations are involved yet.
+	 *
+	 * See setup_swap_map_and_extents(): header page, bad pages,
+	 * and the EOF part of the last cluster.
+	 */
+	inc_cluster_info_page(si, cluster_info, 0);
+	for (i = 0; i < swap_header->info.nr_badpages; i++)
+		inc_cluster_info_page(si, cluster_info,
+				      swap_header->info.badpages[i]);
+	for (i = maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i++)
+		inc_cluster_info_page(si, cluster_info, i);
+
+	INIT_LIST_HEAD(&si->free_clusters);
+	INIT_LIST_HEAD(&si->full_clusters);
+	INIT_LIST_HEAD(&si->discard_clusters);
+
+	for (i = 0; i < SWAP_NR_ORDERS; i++) {
+		INIT_LIST_HEAD(&si->nonfull_clusters[i]);
+		INIT_LIST_HEAD(&si->frag_clusters[i]);
+		si->frag_cluster_nr[i] = 0;
+	}
 
 	/*
 	 * Reduce false cache line sharing between cluster_info and
@@ -3281,7 +3315,13 @@ static int setup_swap_map_and_extents(struct swap_info_struct *si,
 			list_add_tail(&ci->list, &si->free_clusters);
 		}
 	}
-	return nr_extents;
+
+	return cluster_info;
+
+err_free:
+	kvfree(cluster_info);
+err:
+	return ERR_PTR(err);
 }
 
 SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
@@ -3377,6 +3417,17 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	error = swap_cgroup_swapon(si->type, maxpages);
+	if (error)
+		goto bad_swap_unlock_inode;
+
+	nr_extents = setup_swap_map_and_extents(si, swap_header, swap_map,
+						maxpages, &span);
+	if (unlikely(nr_extents < 0)) {
+		error = nr_extents;
+		goto bad_swap_unlock_inode;
+	}
+
 	if (si->bdev && bdev_stable_writes(si->bdev))
 		si->flags |= SWP_STABLE_WRITES;
 
@@ -3384,63 +3435,19 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		si->flags |= SWP_SYNCHRONOUS_IO;
 
 	if (si->bdev && bdev_nonrot(si->bdev)) {
-		int cpu, i;
-		unsigned long ci, nr_cluster;
-
 		si->flags |= SWP_SOLIDSTATE;
-		si->cluster_next_cpu = alloc_percpu(unsigned int);
-		if (!si->cluster_next_cpu) {
-			error = -ENOMEM;
-			goto bad_swap_unlock_inode;
-		}
-		/*
-		 * select a random position to start with to help wear leveling
-		 * SSD
-		 */
-		for_each_possible_cpu(cpu) {
-			per_cpu(*si->cluster_next_cpu, cpu) =
-				get_random_u32_inclusive(1, si->highest_bit);
-		}
-		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 
-		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
-					GFP_KERNEL);
-		if (!cluster_info) {
-			error = -ENOMEM;
+		cluster_info = setup_clusters(si, swap_header, maxpages);
+		if (IS_ERR(cluster_info)) {
+			error = PTR_ERR(cluster_info);
+			cluster_info = NULL;
 			goto bad_swap_unlock_inode;
 		}
-
-		for (ci = 0; ci < nr_cluster; ci++)
-			spin_lock_init(&((cluster_info + ci)->lock));
-
-		si->percpu_cluster = alloc_percpu(struct percpu_cluster);
-		if (!si->percpu_cluster) {
-			error = -ENOMEM;
-			goto bad_swap_unlock_inode;
-		}
-		for_each_possible_cpu(cpu) {
-			struct percpu_cluster *cluster;
-
-			cluster = per_cpu_ptr(si->percpu_cluster, cpu);
-			for (i = 0; i < SWAP_NR_ORDERS; i++)
-				cluster->next[i] = SWAP_NEXT_INVALID;
-		}
 	} else {
 		atomic_inc(&nr_rotate_swap);
 		inced_nr_rotate_swap = true;
 	}
 
-	error = swap_cgroup_swapon(si->type, maxpages);
-	if (error)
-		goto bad_swap_unlock_inode;
-
-	nr_extents = setup_swap_map_and_extents(si, swap_header, swap_map,
-		cluster_info, maxpages, &span);
-	if (unlikely(nr_extents < 0)) {
-		error = nr_extents;
-		goto bad_swap_unlock_inode;
-	}
-
 	if ((swap_flags & SWAP_FLAG_DISCARD) &&
 	    si->bdev && bdev_max_discard_sectors(si->bdev)) {
 		/*
-- 
2.46.0


