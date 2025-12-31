Return-Path: <linux-btrfs+bounces-20050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C802CEBD86
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 12:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDAEB30334F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 11:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2D12882C5;
	Wed, 31 Dec 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgPqXS0c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D432C26F2A7
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767179805; cv=none; b=A7ld4YArQIUgQ5ku/vMTaW988fj1IeTCaHz9RfsVebpCbdgFMbQNr4CUlpSb7C02YZ7gC0pWcvZ5A/LKkg/VcDwIazDcMNm/745BYvSZ5QBrJ7KlKjG5+WGfMsxsbe85oyD8RNesTtJkxuzwzwaTpmZrHS1tHZLdg8nxCOo61OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767179805; c=relaxed/simple;
	bh=2OsgYlc725jcEzOkuv2wI/cvLZJyBmVNjAM4Qcnf/1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBbgkKXiEn4ZgOprY9yluhYyeeTbBKXZVd8oQRDfvkH6VRnmnz5t2Yd15T3ORC3bU4VzWlasUBhguzIkj3J551dUDtIV+OPMiqPZstuZR9UDqVDzfzCCgnTBQDKt+HaRkEYumtQ7DaxnWl0elyXUbaJMjGa0BXzajW3lXVhdops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgPqXS0c; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a08c65fceeso21652375ad.2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 03:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767179803; x=1767784603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yc5BVX4vlkKRPratXYSZiJ8QSBQmd5goiiLUujAwsZM=;
        b=RgPqXS0cI0lWue27eFz4WbxDMrRRUvAyrt/2Ler0BBMlCGSNtE8LedF3NhHqZOFtcL
         1vx0m5HvotH0//5/nLbiBfP3m+QCCHdK1yGJijX9S8tDz6fnH8XGeG6s2bJknt8nB1+E
         mnpua5jzgFtn8vE7+NXW1/7TytyRf47SMnxymY1cZfqAfrr+/SXauEbsfgXkn1J7EvS+
         xGUDrwtK1X7kk9FVhEb8GkLvHObexnQ0eOn/5xN87CCqifVDChmMPiUppQMzL4mk246T
         ZlgCgK2Mzie0vwJHgUwoNmiWoicM21FnE4k4pZh07vSN0nqX87imuGLR4m3Rg5YhL+iO
         gBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767179803; x=1767784603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yc5BVX4vlkKRPratXYSZiJ8QSBQmd5goiiLUujAwsZM=;
        b=ntDLqyGR46fQPNfs6kpvdsQwnJX6L/WnmqhJxKp6H+hiVWeGYoGstH7Lw5JD+jOD79
         2Rjkv8hDJd9JpJPmCX7P1gd62eg9ZZEAxQocq33cH1qQ4tSTbTw0o1gIbMWQ+ZJCwwiR
         P89DYZGK48pvDEN2msw61eT2EX2+Is6vEl7rqAWa7OrpXAYpU7s0AeCDwGb4TDO+9a+U
         fW7HQpKqatSUxLuSurgyc9VrRtAxPaNHJJaZrd0jYWSdoYbPWvMf1Uo3pH/2n2fDfH7b
         Lxst663t+moRsDY13ELOIHk85kFNFdLR2ZzPkupioLIilzjYpW3vLVsTV7p7zd/N2bAj
         x9nw==
X-Gm-Message-State: AOJu0YzSbfJskdYpVrk76NmN5Rc3l11ycD62UmmBTwOHv3P3zc/FK1eA
	mE1wKmU6Zh7psihLZSIW/DLkbzUb5pV0MQ6WqY43aCGxa3bqa5iQUAzau9XspRoeMz4dBFdH
X-Gm-Gg: AY/fxX7E7P/ieHp2MV1rH/JyIm/CwvjniV1jVPosyKcCKLuVHX7xviysimBm8dve3C/
	GPNsyjwYbqh0rpAkLqqSD+UCSg5I7T5qbE0g0dVUDuScAhXEKXzmot7BmK870yQ0TU4A7kMnI+T
	CdXBfX/wlebEqhquCb8wlmk2A954JjZy+uFv8RDtV0UHrgC9yfdGieylZOOk2MlFfeRnNqR4yyR
	q7DT8JSozqJLufQNydYZLW65tVBv0ZWl3Fm5I7DXrysE7z6V63eTYPjZgPlzNPhndJ/4NvtFUpF
	TA3LmozYn0IBfTyvJijnen+ymJleq2OWgwW52TGL3IPvFj02i2wbgL2r8d4LiYetMGmfjlsJM+P
	sOkZWjT/5usKkrh04CdPpR9mD/lPQJDk6z2aXyxa7qX1keqpJwLcsOiwllEnQfCMdGUfIXYwk+L
	sk0mHW6+omymXbnhI3yV+YzfknS2cJHZ9uYg==
X-Google-Smtp-Source: AGHT+IGTrUNz0zlR6q6NjmfPyuwc6nW+DMZrnD4j9fHA51FCpK9a6mlFUAO4sPdAS5w9xob4ml58SA==
X-Received: by 2002:a17:902:e785:b0:2a1:3846:a750 with SMTP id d9443c01a7336-2a2f1f6a11emr230054135ad.0.1767179803024;
        Wed, 31 Dec 2025 03:16:43 -0800 (PST)
Received: from SaltyKitkat ([175.145.176.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm321394385ad.5.2025.12.31.03.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:16:42 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 2/7] btrfs: reorder btrfs_block_group members to reduce struct size
Date: Wed, 31 Dec 2025 18:39:35 +0800
Message-ID: <20251231111623.30136-3-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231111623.30136-1-sunk67188@gmail.com>
References: <20251231111623.30136-1-sunk67188@gmail.com>
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


