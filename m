Return-Path: <linux-btrfs+bounces-7339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04E7958970
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 16:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FD71F229CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5336B1917F4;
	Tue, 20 Aug 2024 14:35:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F86118E75F;
	Tue, 20 Aug 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164501; cv=none; b=rJh7myxm9+gPOGaXdK1+OLaS2Xi+omDCjpHFRXRSd8R4qjoS7zp1WQ/8Gwx+w4VvbHYOwXmCRa0NL8Mb3s/ftrOvMc0dZJaKks7lR1zxeblg9NZql1HdJQ1hvm6VB38qvcIBEZB0mu2FnXrmT0/Bm9Pv+RvwGuygzLq0A4CwoWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164501; c=relaxed/simple;
	bh=sBwLL71x8imLz5WtY4QO9IBNz2dBHJJacjXZAf5EclA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhdBgPtT+yDrrhFTpJwWQa2XR3ccexvTcdvd3v66ajB+w5fnqUFHg/tmeu6/nZ2BQXMM9q/UHF/sdrOGQTDh4C8f2A4rOhJKo5G+m0HjDCPKJbYfKlDMpYUq6pzRWe5xO0ZUpS/vdsP/h8y2Hs00Bq8938qlfgKYwljj6gTSh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428243f928cso45131485e9.3;
        Tue, 20 Aug 2024 07:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164498; x=1724769298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdFV9Xk9dEpiucgrYUuetxpj17k7df3kygfWkjUEyfo=;
        b=Oau9Rl9hsyGF8OECnshAmkELlOWGNyOlM/h1wbRo5T0crv6PripcpGDqOqFQlaFiki
         LTYw2hNq5oaAXu20KBJXNR04PMoMMCILETnlh8LoMbqGOn9yZSy/RTM666jKtmDZVDuh
         KQDZdVl5rox9xx0D+KWa18fwXDALiJ1DPcVZ6alpYpL7gCl5EVfumXDx6WAq6JhBNKWb
         xJi0f0mDMra5C6kfUpZvl8YU+RYmTOsIaEQPlsEV/EXtesF1tNxmec+8Qejk097nfABf
         EqGmz3YQWcIZSeUwPeDvGcm+0d5LEWQ6jIUX6sidc3Cs8N9Fby1BwTObD+0fNZChLZJL
         fbmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVRMS7JwF9TndAJhlmt3EgP7Dv9sgXZslxgLbQ8MqfIk1icJmpvzjg1+S9NOz5XpgFVQ4G3UWaY4C9wHdu@vger.kernel.org, AJvYcCXkllmuJYLEaYv43f5PFRVVt8m4U1IrvgFj6xfnMbbBU3LDyRr8leFjWGELBKAdStFSxSIHxFHbW2YiUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLaDMNh+sHAP7aYjssHBRlRDk6HNuJI7QK5WcaRhcpfkeckEyv
	NUhVq5QNAHB7bTXGiqx1X0iz5R+6WIwa4FCo6nUhRRoZR1q/+CZl
X-Google-Smtp-Source: AGHT+IHSYWa06QJe8fRfMbSZXheXd279QKsE2OCDaQzlKgp2Ksp+PtRKcEMXfVAv/SrMzrxb27FPhQ==
X-Received: by 2002:a05:600c:4fd0:b0:421:7bed:5274 with SMTP id 5b1f17b1804b1-429ed788ff6mr111411375e9.10.1724164498095;
        Tue, 20 Aug 2024 07:34:58 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a2d7sm13393812f8f.10.2024.08.20.07.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:34:57 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenru <wqu@suse.com>
Subject: [PATCH] btrfs: scrub: don't mark inline extents as errors on RST
Date: Tue, 20 Aug 2024 16:34:53 +0200
Message-ID: <20240820143453.25428-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

When scrubbing a RAID stripe-tree backed btrfs system, we're doing
extent based block mappings. These block mappings go through the RAID
stripe-tree to do logical to physical translation.

In case we're hitting an inline extent, there is no backing by the
RAID stripe-tree for it and the block mapping returns an error. So the
bit in the extent bitmap is marked as error.

Fix this by not marking mapping failures for inline extents as error.

Cc: Qu Wenru <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/scrub.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b3afa6365823..8240b205699c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -67,6 +67,7 @@ struct scrub_ctx;
 /* Represent one sector and its needed info to verify the content. */
 struct scrub_sector_verification {
 	bool is_metadata;
+	bool is_inline;
 
 	union {
 		/*
@@ -1479,6 +1480,34 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 	return ret;
 }
 
+static bool extent_is_inline(struct btrfs_fs_info *fs_info,
+			     u64 extent_start, u64 extent_len)
+{
+	struct btrfs_file_extent_item *ei;
+	struct extent_buffer *leaf;
+	struct btrfs_path *path;
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, extent_start);
+	int ret;
+	bool is_inline = false;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return false;
+
+	ret = btrfs_lookup_file_extent(NULL, extent_root, path, extent_start, extent_len, 0);
+	if (ret < 0)
+		goto out;
+
+	leaf = path->nodes[0];
+	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
+	if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_INLINE)
+		is_inline = true;
+
+ out:
+	btrfs_free_path(path);
+	return is_inline;
+}
+
 static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
 				 struct scrub_stripe *stripe,
 				 u64 extent_start, u64 extent_len,
@@ -1497,6 +1526,9 @@ static void fill_one_extent_info(struct btrfs_fs_info *fs_info,
 		if (extent_flags & BTRFS_EXTENT_FLAG_TREE_BLOCK) {
 			sector->is_metadata = true;
 			sector->generation = extent_gen;
+		} else {
+			sector->is_inline = extent_is_inline(
+				fs_info, extent_start, extent_len);
 		}
 	}
 }
@@ -1704,8 +1736,13 @@ static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
 					      &stripe_len, &bioc, &io_stripe, &mirror);
 			btrfs_put_bioc(bioc);
 			if (err < 0) {
-				set_bit(i, &stripe->io_error_bitmap);
-				set_bit(i, &stripe->error_bitmap);
+				struct scrub_sector_verification *sector =
+					&stripe->sectors[i];
+
+				if (!sector->is_inline) {
+					set_bit(i, &stripe->io_error_bitmap);
+					set_bit(i, &stripe->error_bitmap);
+				}
 				continue;
 			}
 
-- 
2.43.0


