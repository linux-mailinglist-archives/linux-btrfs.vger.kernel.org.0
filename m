Return-Path: <linux-btrfs+bounces-15625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD9DB0D61A
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 11:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAB06C3705
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51B2DECC5;
	Tue, 22 Jul 2025 09:39:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5EC2D8DDF
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 09:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177168; cv=none; b=JR9+VV4OhXeassWsOEZOCesX5DZies5mGKuwfJXk1/o1vwfRjC3kpGRfn1AMkGiOjeYrr5yVGHblJUxBWE3+Oo1mTfRJFhueaRpz0YM7B3DkZiWGAWw/miVRbXTQUs61pq5Zz3rFLTHY9s66jarmqMVCq4lRXLLlJfs/QqXEJkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177168; c=relaxed/simple;
	bh=15bTGv2d0YpEsDCSVy+MLhaQTSQqdZNVR+5eUhW/kAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtYBs9hTiBEWYegYNqfoYmgoOhiG0By2hYWcv4W9aMFmAWYqXGGpS6jz1KBN2Ug5yu1Kz1V229xEL4uMQSWScjKvXwBRwI6RNi9EiOfD7HV+kr3SlgbrS3nIBMXjhxTDVupFHj8yvS7YZb104xLiGrgo0DlXUPNYPBQ+VHa7fSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso3051971f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 02:39:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753177165; x=1753781965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWEfn6+1hdFE1mCFZ1T1gP1dH1SKN2Ob9duQLOBH0tg=;
        b=u/VSgqpwkmraWiLJ/rGejdvp85JncneN1HQXXAfqdH79hN32xiQzAwbHO5JxlEaxAT
         aD6PL0bPA0u7gV0hsYMv0mbTdllovYt9kIzW7OnXP0MjFnVUvBA/PeDJjR9vDfxhKk1R
         uKZnKQQ1OftPcLWjFLzWecFNng9KkR176NBCo9bWfJmov13laYu3vxGiQ5u2tZK+zOqb
         ikGfZtq5ydvnXB2WoNb87HkvqFOXQu6WRSsFN2buIiBKLgr0bt5F3TWJ/B4WG/OPrgq5
         Bq+R0f96Fsc5G7QHaFrAv5BZ+lAdIrHTjyFRw1efaudF9LII1tavuu/ATKEQejauNNMm
         ifgA==
X-Gm-Message-State: AOJu0Yx2QFsyL8xMQkYdqxh6bwxiWaHYcU9C/enKIFaGs94ujpHxA+Ch
	JhLDPgyS9K24cAbykiF32wBhYkpeRxmSYUhgnRAikuJQcUmSOUT9sAH4KFSqS/IA
X-Gm-Gg: ASbGncuqj9Jh9n5zmCw6lxi6neTO/aIPi8lUtj0SB+o77r/jCUsHREngxp3PmQITSFO
	XDLi+CEhzT5ydGGXadsz0K43hXs6oJxUbZZEepby+qTOFZLO+qhHBdQ4AwEzHDtRSGzIMv0fhyA
	0vl20/+h2r3CFBA7qdc6O6rRJJh9vrP5GXqDVf+Ik3rBBxbf2dZnXQwbQYwcF5rTC2VKKkXRh3T
	n7rriy3MLrxRwqfrY0VeZnVnqVXeyNEWjO/pksSLJIk05SNm6Gl44nvsN21qYjNBgiYXiSLMw5p
	liWk8EQSq1R0+2R6JIwIMHmGEyZz69wLaZt7hoP892Vnwo/TddyK8GwSYuitoX0pMEc4UaCgoYH
	JLSS3LK0ag0YyLqamehSM5vidVqTZM/deWfWipmOxlVdTq4y5ndee41RUfY31bYgc+vbFk+oPg1
	zXMA9lfbyp3w==
X-Google-Smtp-Source: AGHT+IH0nNynJlp0HUnRnG0b7mjGA0MPr9HODPS/TIApYKFMvT0oe46Nf0QiBsxviYrVLBP+IIy17w==
X-Received: by 2002:a05:6000:200c:b0:3a5:52b2:fa65 with SMTP id ffacd0b85a97d-3b613e601bdmr15646964f8f.5.1753177164984;
        Tue, 22 Jul 2025 02:39:24 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b5c7e8bsm123225895e9.14.2025.07.22.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:39:24 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/2] btrfs: zoned: return error from btrfs_zone_finish_endio()
Date: Tue, 22 Jul 2025 11:39:15 +0200
Message-ID: <20250722093915.13214-3-jth@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722093915.13214-1-jth@kernel.org>
References: <20250722093915.13214-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Now that btrfs_zone_finish_endio_workfn() is directly calling
do_zone_finish() the only caller of btrfs_zone_finish_endio() is
btrfs_finish_one_ordered().

btrfs_finish_one_ordered() already has error handling in-place so
btrfs_zone_finish_endio() can return an error if the block group lookup
fails.

Also as btrfs_zone_finish_endio() already checks for zoned filesystems and
returns early, there's no need to do this in the caller. For developer
builds leave the ASSERT() in place to check for a block-group lookup
failure.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/inode.c | 7 ++++---
 fs/btrfs/zoned.c | 8 +++++---
 fs/btrfs/zoned.h | 9 ++++++---
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d9a8d8bea4c..793b1d520e8d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3109,9 +3109,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	if (btrfs_is_zoned(fs_info))
-		btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
-					ordered_extent->disk_num_bytes);
+	ret = btrfs_zone_finish_endio(fs_info, ordered_extent->disk_bytenr,
+				      ordered_extent->disk_num_bytes);
+	if (ret)
+		goto out;
 
 	if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered_extent->flags)) {
 		truncated = true;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 5a234f31c8da..0e61e49b8ce9 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2431,16 +2431,17 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags)
 	return ret;
 }
 
-void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 length)
+int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 length)
 {
 	struct btrfs_block_group *block_group;
 	u64 min_alloc_bytes;
 
 	if (!btrfs_is_zoned(fs_info))
-		return;
+		return 0;
 
 	block_group = btrfs_lookup_block_group(fs_info, logical);
-	ASSERT(block_group);
+	if (WARN_ON_ONCE(!block_group))
+		return -ENOENT;
 
 	/* No MIXED_BG on zoned btrfs. */
 	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
@@ -2457,6 +2458,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
 
 out:
 	btrfs_put_block_group(block_group);
+	return 0;
 }
 
 static void btrfs_zone_finish_endio_workfn(struct work_struct *work)
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 6e11533b8e14..17c5656580dd 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -83,7 +83,7 @@ int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
 bool btrfs_zone_activate(struct btrfs_block_group *block_group);
 int btrfs_zone_finish(struct btrfs_block_group *block_group);
 bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices, u64 flags);
-void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
+int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical,
 			     u64 length);
 void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 				   struct extent_buffer *eb);
@@ -234,8 +234,11 @@ static inline bool btrfs_can_activate_zone(struct btrfs_fs_devices *fs_devices,
 	return true;
 }
 
-static inline void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
-					   u64 logical, u64 length) { }
+static inline int btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info,
+					   u64 logical, u64 length)
+{
+	return 0;
+}
 
 static inline void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 						 struct extent_buffer *eb) { }
-- 
2.50.1


