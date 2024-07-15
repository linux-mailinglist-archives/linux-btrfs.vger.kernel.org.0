Return-Path: <linux-btrfs+bounces-6475-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE9C931558
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 15:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E374C283890
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBDE18D4A9;
	Mon, 15 Jul 2024 13:08:36 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABBB18C16D;
	Mon, 15 Jul 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048916; cv=none; b=cx56DDVcdtC9TVRL3drOsBEvzJPwQsHJqbE6KWSOMFXqFSY9Uf3uiQTA1ZD3RClYPqIzYaRH2R0M1f2CgQCELyWDP0RfMFI5DzZwJpMUepa4bMcaMlYqMDZq1YNgcZPQHqmA79xNulRMVid0CwRM2mv0a2H92n187wjp069q/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048916; c=relaxed/simple;
	bh=EDZP059plenFt28uw0V0eC5w9BbEx78ROF3IDIofSYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1j1iYubhbJTP31GVg+kKuYAJPoh7zzWgi6xNqhJxweYCmelvvKtLSdaoOUIt6VUSMmtADdnt6JjDcj033doxC0VospaafHM9cNs+vf6YRte0PosdZyue9RrT+fKrjkCgEJElDWdulyjOk6vLEiQ9wgVrNpZsbYDyphWwDfqgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so7880915a12.1;
        Mon, 15 Jul 2024 06:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048913; x=1721653713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mN9oE6P50Gu84NfU0zGEZkck2rnm4DusfnagcSf9agQ=;
        b=xVGDpAubxuJ1uawqCWU43qVtUxsXyolIbzRKAHVOeVO2ihpcY01FUVvRkSiOwi6E9w
         WjPA6TvB4ZrFC8SdslRn8Xk8JwRHgU+n/AGDDukA6FCNv6isLDNmRMzSCsfrdKPtnccJ
         Ww4xvCXVExwtkz10/5PXLXAqJcowC13VENpeh5NYknmb2bfhVACjEjGlgl7vrZjLK5A6
         ZMy9IoiRIHBtljnn+RQhFdoeRT637U8NTEVNM/W9LFk+Iq/apyZRkWHg9XkIBnm6ru6a
         XTbQkE8uGN58O6wwWAe7EkWB5AYMUZyH5kuHFGvl6lM2vrLdVScP/WiSQkgMLD2QPpdp
         efKg==
X-Forwarded-Encrypted: i=1; AJvYcCVgivJ+5a/SbAWp0UjsHaxocsA0qMqyeb3+ubXOY5C87W5dB+YR/ZjZl7O4E6pbmg33JZLD0G2nvhe5uJlMv5huO9jlx55TOHWERPurSIdJ5dklcrhWhTV2wPRRdZwRNUAmUoCpCeahuas=
X-Gm-Message-State: AOJu0Ywc/M8pG7mb5oR/8cIcE/Q68Xoablkw72bbvyYe/6CaXfDvO4v2
	tv2WeIY0QiTs/CYTf2L+yDV9luSCS0Ok+bMKwE9ajNb4AGLeyH3l
X-Google-Smtp-Source: AGHT+IGV55i1WARhIjOu9gWKsRuWftTHKuhl6H8KDHNbKUVqZsCJ02tr9Li02Zw3eyhBW48plv88Xw==
X-Received: by 2002:a05:6402:50cc:b0:585:9e73:8ac6 with SMTP id 4fb4d7f45d1cf-59964ac31f1mr8756266a12.16.1721048912446;
        Mon, 15 Jul 2024 06:08:32 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f73ce200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f73c:e200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a76fefsm3349204a12.16.2024.07.15.06.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 06:08:31 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: 
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] btrfs: don't hold dev_replace rwsem over whole of btrfs_map_block
Date: Mon, 15 Jul 2024 15:08:19 +0200
Message-ID: <20240715130820.19907-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't hold the dev_replace rwsem for the entirety of btrfs_map_block().

It is only needed to protect
a) calls to find_live_mirror() and
b) calling into handle_ops_on_dev_replace().

But there is no need to hold the rwsem for any kind of set_io_stripe()
calls.

So relax taking the dev_replace rwsem to only protect both cases and check
if the device replace status has changed in the meantime, for which we have
to re-do the find_live_mirror() calls.

This fixes a deadlock on raid-stripe-tree where device replace performs a
scrub operation, which in turn calls into btrfs_map_block() to find the
physical location of the block.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>

---
Cc: Filipe Manana <fdmanana@suse.com>

Changes in v4:
- Free bioc in case we need to redo the mapping
Link to v3:
https://lore.kernel.org/linux-btrfs/20240712-b4-rst-updates-v3-1-5cf27dac98a7@kernel.org
---
 fs/btrfs/volumes.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fcedc43ef291..9437e779d020 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6650,14 +6650,9 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	max_len = btrfs_max_io_len(map, map_offset, &io_geom);
 	*length = min_t(u64, map->chunk_len - map_offset, max_len);
 
+again:
 	down_read(&dev_replace->rwsem);
 	dev_replace_is_ongoing = btrfs_dev_replace_is_ongoing(dev_replace);
-	/*
-	 * Hold the semaphore for read during the whole operation, write is
-	 * requested at commit time but must wait.
-	 */
-	if (!dev_replace_is_ongoing)
-		up_read(&dev_replace->rwsem);
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case BTRFS_BLOCK_GROUP_RAID0:
@@ -6695,6 +6690,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 			   "stripe index math went horribly wrong, got stripe_index=%u, num_stripes=%u",
 			   io_geom.stripe_index, map->num_stripes);
 		ret = -EINVAL;
+		up_read(&dev_replace->rwsem);
 		goto out;
 	}
 
@@ -6710,6 +6706,8 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 */
 		num_alloc_stripes += 2;
 
+	up_read(&dev_replace->rwsem);
+
 	/*
 	 * If this I/O maps to a single device, try to return the device and
 	 * physical block information on the stack instead of allocating an
@@ -6782,6 +6780,19 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		goto out;
 	}
 
+	/*
+	 * Check if something changed the dev_replace state since
+	 * we've checked it for the last time and if redo the whole
+	 * mapping operation.
+	 */
+	down_read(&dev_replace->rwsem);
+	if (dev_replace_is_ongoing !=
+	    btrfs_dev_replace_is_ongoing(dev_replace)) {
+		btrfs_put_bioc(bioc);
+		up_read(&dev_replace->rwsem);
+		goto again;
+	}
+
 	if (op != BTRFS_MAP_READ)
 		io_geom.max_errors = btrfs_chunk_max_errors(map);
 
@@ -6789,6 +6800,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	    op != BTRFS_MAP_READ) {
 		handle_ops_on_dev_replace(bioc, dev_replace, logical, &io_geom);
 	}
+	up_read(&dev_replace->rwsem);
 
 	*bioc_ret = bioc;
 	bioc->num_stripes = io_geom.num_stripes;
@@ -6796,11 +6808,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	bioc->mirror_num = io_geom.mirror_num;
 
 out:
-	if (dev_replace_is_ongoing) {
-		lockdep_assert_held(&dev_replace->rwsem);
-		/* Unlock and let waiting writers proceed */
-		up_read(&dev_replace->rwsem);
-	}
 	btrfs_free_chunk_map(map);
 	return ret;
 }
-- 
2.43.0


