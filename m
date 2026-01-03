Return-Path: <linux-btrfs+bounces-20090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FD6CEFF5A
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 14:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C8203034A37
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661322F691C;
	Sat,  3 Jan 2026 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEWcob6L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED3D221FB4
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445607; cv=none; b=bj910rhPnmO8BEJYYkpDXm338s87m5MZLYK4NF07OE5coo+qVuPT2akFYhPfEdlkY8Hjyhl4D7yJqAXQQfVoh0YXSpfMD4tW2m0pclov591TIpSPZ9ciInCmnip1V28sSEVAhZgRvuRXC/Mkz2M/jXrp0olKyIOra2k5FRnhV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445607; c=relaxed/simple;
	bh=2OsgYlc725jcEzOkuv2wI/cvLZJyBmVNjAM4Qcnf/1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOCEataHjM0sB470brh+TJ3TvPhh+7pOnLY7uKK4RrFL1GchvWgXs8KpY9dVpW7MUEbdJ8bUoTQfaTU6RZS/SfzvPdLBxylLG+WwZJO1XuUhnj0mIcvZMAdH+bsSWZNY9M6kWxDFEcv++wr2QHB+GGh44RA3lbPmorK96eVCnho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEWcob6L; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-644752b3105so1486643d50.3
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 05:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445605; x=1768050405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc5BVX4vlkKRPratXYSZiJ8QSBQmd5goiiLUujAwsZM=;
        b=EEWcob6LQKk8Xg/DSwvMFAS3HZQ0dtOQbzHyWy/FTitG+JM/oFwtEgpecR5NKIDMSN
         +pOy1+VmX9rbqAE0TdHLNx9nuHUt0wvMoz1WpCgwVgY9nPuNsIu8CC4QhVtI8GCJRZDr
         k0uwEWbHtVn6WDpYy2e8JfB9v4YObrQYY9KSrVazcL46RHlWG6U0sNpon4wZz9opZRfp
         3jNV3egby3t6aHsrT6BE/QLOdlxzt8kO+Y3Jt3EfZOaqTwjPcuG/cdc3CBy3vvspT/Aj
         DN11RzZcP2fqHrvvY+zvI4jUEVsxtA4+dP3HGp6qArKIBjGJpLjAfsrrRmm6Bd1o0frB
         XpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445605; x=1768050405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yc5BVX4vlkKRPratXYSZiJ8QSBQmd5goiiLUujAwsZM=;
        b=SRfoREgrZMyHE68Wdz7quT1BuJsxknQBeH9kSmIEHXqALenNcMDoIAZc0lS1HyeCvZ
         4aW091jlPJc2pI2ZHWWuwsDF1X/gD61RD4XNzqCzeiEMPxRuc/QI0E8E5Qf0tG3PSdEJ
         jmyHeL8+XsY3Q7+p0HPa+ETAie8M4mSWQij7Zd2XBc6zuqc8BUzyTn/oi1Q/RiAxfvcK
         0yH6H0B3DasP5dDKgw25Zg7xjH0srOCPpVRFAvJPPoD51p31ybIVDMAzA8zLa22L+zGu
         UOA+lDMUo3/jwhbNYXxJ7NB0lAnsm9YErQOnV3fU/mNQt1SSWyf3LK1NdDCeg4CLudwY
         gDrg==
X-Gm-Message-State: AOJu0Yyrz1jhfXsLgwWXIsfF6oxLOjsaqxNw9SIx8Dum3c6BRUWRn2Z7
	hgruhUpfA6BrLsKeO3ZGqGiS2i2b9CCRYP60JPRvjIR0+FkVjxk2tDuQt+7Id1hbT1sxDA==
X-Gm-Gg: AY/fxX4WySgpN0RZPPY11Zl2ZLl7EQmqNEvWm55bImvc/zCbspT3+4ULrFHIgfRN1fZ
	y42ohtFQ4l2YeGDgq5ip5+mEtBgF9OgHRqfWkodTFO56QkIpbNXkM/0sJ+1S3vVD6flngFWwqKz
	dGEqbuZItGihSN7OBVtN+bjcxcyyOg9xpYW1TJebGLQId79jAyMU5eGIW1qG4uJJ+lUmm7lFufo
	2FXvM57S8BYG0W/UK2N7rPC6Uw81yj8xpVgsNChSPEwoZtkDtg8TK6jVG1yn7h3t4QUFYWj0RMk
	vd5F0pon5ypQfumP8fW67Syyh+t8Dob/M9vkK4DpuxDQhQYlnv13YyIkbfpxqWbUGdk3kLhZjGM
	2cnoM0tsa0h7iTq9P+qCRtJpD7XZh5ycdwMApC3hHi/9aPz+8ftABI6LWE+yPiuwVuhpNmCJ7Es
	QAkDNb8Re/FSAXERZM+sA=
X-Google-Smtp-Source: AGHT+IFQtvmkSxLwMzKQgjRuDlBiDM5kWfDCEXXKbehyeId0CfOTeZAOa/rmGGg4btITXDgNEiNICA==
X-Received: by 2002:a05:690e:144e:b0:644:3825:7582 with SMTP id 956f58d0204a3-6466a8f1343mr28592324d50.5.1767445604823;
        Sat, 03 Jan 2026 05:06:44 -0800 (PST)
Received: from SaltyKitkat ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ffebd2690sm112554957b3.15.2026.01.03.05.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:06:44 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 5/7] btrfs: reorder btrfs_block_group members to reduce struct size
Date: Sat,  3 Jan 2026 20:19:52 +0800
Message-ID: <20260103122504.10924-7-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260103122504.10924-2-sunk67188@gmail.com>
References: <20260103122504.10924-2-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder struct btrfs_block_group fields to improve packing and reduce
memory footprint from 624 to 600 bytes (24 bytes saved per instance).

Here's pahole output after this change:

struct btrfs_block_group {
	struct btrfs_fs_info *     fs_info;              /*     0     8 */
	struct btrfs_inode *       inode;                /*     8     8 */
	u64                        start;                /*    16     8 */
	u64                        length;               /*    24     8 */
	u64                        pinned;               /*    32     8 */
	u64                        reserved;             /*    40     8 */
	u64                        used;                 /*    48     8 */
	u64                        delalloc_bytes;       /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	u64                        bytes_super;          /*    64     8 */
	u64                        flags;                /*    72     8 */
	u64                        cache_generation;     /*    80     8 */
	u64                        global_root_id;       /*    88     8 */
	u64                        commit_used;          /*    96     8 */
	u32                        bitmap_high_thresh;   /*   104     4 */
	u32                        bitmap_low_thresh;    /*   108     4 */
	struct rw_semaphore        data_rwsem;           /*   112    40 */
	/* --- cacheline 2 boundary (128 bytes) was 24 bytes ago --- */
	unsigned long              full_stripe_len;      /*   152     8 */
	unsigned long              runtime_flags;        /*   160     8 */
	spinlock_t                 lock;                 /*   168     4 */
	unsigned int               ro;                   /*   172     4 */
	enum btrfs_disk_cache_state disk_cache_state;    /*   176     4 */
	enum btrfs_caching_type    cached;               /*   180     4 */
	struct btrfs_caching_control * caching_ctl;      /*   184     8 */
	/* --- cacheline 3 boundary (192 bytes) --- */
	struct btrfs_space_info *  space_info;           /*   192     8 */
	struct btrfs_free_space_ctl * free_space_ctl;    /*   200     8 */
	struct rb_node             cache_node;           /*   208    24 */
	struct list_head           list;                 /*   232    16 */
	struct list_head           cluster_list;         /*   248    16 */
	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */
	struct list_head           bg_list;              /*   264    16 */
	struct list_head           ro_list;              /*   280    16 */
	refcount_t                 refs;                 /*   296     4 */
	atomic_t                   frozen;               /*   300     4 */
	struct list_head           discard_list;         /*   304    16 */
	/* --- cacheline 5 boundary (320 bytes) --- */
	enum btrfs_discard_state   discard_state;        /*   320     4 */
	int                        discard_index;        /*   324     4 */
	u64                        discard_eligible_time; /*   328     8 */
	u64                        discard_cursor;       /*   336     8 */
	struct list_head           dirty_list;           /*   344    16 */
	struct list_head           io_list;              /*   360    16 */
	struct btrfs_io_ctl        io_ctl;               /*   376    72 */
	/* --- cacheline 7 boundary (448 bytes) --- */
	atomic_t                   reservations;         /*   448     4 */
	atomic_t                   nocow_writers;        /*   452     4 */
	struct mutex               free_space_lock;      /*   456    32 */
	bool                       using_free_space_bitmaps; /*   488     1 */
	bool                       using_free_space_bitmaps_cached; /*   489     1 */
	bool                       reclaim_mark;         /*   490     1 */

	/* XXX 1 byte hole, try to pack */

	int                        swap_extents;         /*   492     4 */
	u64                        alloc_offset;         /*   496     8 */
	u64                        zone_unusable;        /*   504     8 */
	/* --- cacheline 8 boundary (512 bytes) --- */
	u64                        zone_capacity;        /*   512     8 */
	u64                        meta_write_pointer;   /*   520     8 */
	struct btrfs_chunk_map *   physical_map;         /*   528     8 */
	struct list_head           active_bg_list;       /*   536    16 */
	struct work_struct         zone_finish_work;     /*   552    32 */
	/* --- cacheline 9 boundary (576 bytes) was 8 bytes ago --- */
	struct extent_buffer *     last_eb;              /*   584     8 */
	enum btrfs_block_group_size_class size_class;    /*   592     4 */

	/* size: 600, cachelines: 10, members: 56 */
	/* sum members: 595, holes: 1, sum holes: 1 */
	/* padding: 4 */
	/* last cacheline: 24 bytes */
};

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 3b3c61b3af2c..88c2e3a0a5a0 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -118,7 +118,6 @@ struct btrfs_caching_control {
 struct btrfs_block_group {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_inode *inode;
-	spinlock_t lock;
 	u64 start;
 	u64 length;
 	u64 pinned;
@@ -159,6 +158,8 @@ struct btrfs_block_group {
 	unsigned long full_stripe_len;
 	unsigned long runtime_flags;
 
+	spinlock_t lock;
+
 	unsigned int ro;
 
 	int disk_cache_state;
@@ -178,8 +179,6 @@ struct btrfs_block_group {
 	/* For block groups in the same raid type */
 	struct list_head list;
 
-	refcount_t refs;
-
 	/*
 	 * List of struct btrfs_free_clusters for this block group.
 	 * Today it will only have one thing on it, but that may change
@@ -199,6 +198,8 @@ struct btrfs_block_group {
 	/* For read-only block groups */
 	struct list_head ro_list;
 
+	refcount_t refs;
+
 	/*
 	 * When non-zero it means the block group's logical address and its
 	 * device extents can not be reused for future block group allocations
@@ -211,10 +212,10 @@ struct btrfs_block_group {
 
 	/* For discard operations */
 	struct list_head discard_list;
+	enum btrfs_discard_state discard_state;
 	int discard_index;
 	u64 discard_eligible_time;
 	u64 discard_cursor;
-	enum btrfs_discard_state discard_state;
 
 	/* For dirty block groups */
 	struct list_head dirty_list;
-- 
2.51.2


