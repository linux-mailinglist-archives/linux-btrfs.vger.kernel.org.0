Return-Path: <linux-btrfs+bounces-15634-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D88BAB0D864
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 13:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF66A1896569
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jul 2025 11:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6FD2E3B1E;
	Tue, 22 Jul 2025 11:39:24 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7D2E040A
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184364; cv=none; b=hBcPncy0b+RfNi6CkJdCl1dMhwUQ3RSoxmcasqCpMj9CihzfjdPNTiDdPCn1ixGwswLtR+NX5ApSdoPcNY0xpLzRLQN4XwWVnGmpBgGYHF930whBRUHqTSCpUEB5VbGTgIGZLEwyXxuYlxHsl9oaKb8o516UqqdrCf02yEeRuvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184364; c=relaxed/simple;
	bh=A1/NFjkf5i6r+FQsEcfwoTPsOhhsSoYIbusX8yEyyt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IheUdV3Mtrhj5tsr9dPcxGqX2rV/ewV2Ju3T8Hz2vvHO6gCGX5JupYswIuCZtdJqC5seqXQcZhGCm83bxDESep+d58hKC1Dg2PacjQ/xUmQbXdc3VNNZIsgnnqgcILAe1cRNao7KQbvTkmfs+ecMTqyzIAaEMp8xQ4XnQ2t2uvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a54700a463so3050815f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jul 2025 04:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184361; x=1753789161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+jV0B03MdU7qfHrHfqL9Q7WlKssksLDCR93BvOU3DIw=;
        b=Kn3GgNgJ+T5aISTeVO5X73eY7K4IvQElTZx8sW/xeNSqCSMWKUzYxeAguuKc59xFHd
         CdpiGDwb5poyAZksu7+brzgpu0NLuPH1ZMU3YC4t2ysD6TFA+sd59w98Nn0V9IniNxzB
         CNabzxdWrScksU3gnL0BDQSlrF79juhk/6ZJidKARNc37Gy6vRhOX2gDyE+ok7EhYzn0
         Hnw/pNH6LnL0TqhIaILtQjyaaHvopv2jfZH3zusUo1b8t/LvPFsIp1NfolBCumWMUuQJ
         hcGmPZcmyGZOW7erEjo/FRtKfK3OXi0zKGEnukLzDOx3u21t/NanFZ59ILNKXDyGGwnR
         w6zg==
X-Gm-Message-State: AOJu0YwGk9S9rB3SCC61kU58o5f44lXu0YiCt4cO7hiIE+qO3YPKhP/n
	6/LV8NLiQughMsY/3uLqyP7cMsoYBEKzF/DfS74fhumjHeazwFeFpJbqBTcXPaov
X-Gm-Gg: ASbGnctdKov3zpDCpYN/qEk1y644tqZNwA78juuou/6+bpygZh9yTrIDVxXDI3YcZXf
	AbLHdQHjPTIn9SgjKeNZKVc+msjHZ6RUnGZXesyCrSMU8PCaYCyM8mKT4oM/cmne/d+lVXOlUUC
	Zc+msMW/Ip6eqrGWjwM0ScY42ujP2Sb1hbSW3L/k2kEB68XTngnT5PhedV9ITMZKILGTfRmZU23
	evghDVmK6YIKykRkBx/l503tyVx+mJKYef2c9s/uiZOoHYANDWFnod9MNzbDJDKJFBG06YGD1R5
	qD+YwlSJ58O9Xx+NAiQkAAv5+E+FK7tgCnwuRE2cU6bVRW5aK16y4ZqInjI1YkCtgp30vDWsAaj
	Ewmos04vqkAkOXp/Eio3O4BHzyzx1++Tq3NXQ5r1cWXYxSjUz2TqJqHT60ZK8ze2D1xh5KLInwh
	u8BOQCAQIFxg==
X-Google-Smtp-Source: AGHT+IHNzsukRKvkjNWjIzjvIKxz7MpmeJtWvUcybGGQVBxQtFTVhMSrOc3mjY9teRcLKN7ZhNsfow==
X-Received: by 2002:a05:6000:1885:b0:3a3:64b9:773 with SMTP id ffacd0b85a97d-3b76349151cmr2423522f8f.10.1753184360432;
        Tue, 22 Jul 2025 04:39:20 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f71c45003fa4d1e815666221.dip0.t-ipconnect.de. [2003:f6:f71c:4500:3fa4:d1e8:1566:6221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca24224sm13278255f8f.8.2025.07.22.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:39:20 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 2/2] btrfs: zoned: return error from btrfs_zone_finish_endio()
Date: Tue, 22 Jul 2025 13:39:11 +0200
Message-ID: <20250722113912.16484-3-jth@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722113912.16484-1-jth@kernel.org>
References: <20250722113912.16484-1-jth@kernel.org>
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
returns early, there's no need to do this in the caller.

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
index e997b236d00a..279446e98516 100644
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


