Return-Path: <linux-btrfs+bounces-7338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A3E95896D
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 16:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2519F1C217C4
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46D31917F4;
	Tue, 20 Aug 2024 14:34:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315EB383AB;
	Tue, 20 Aug 2024 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164486; cv=none; b=oOLXyek3iCwfQ5IiU01juBStUvfda4VWZylBXdU2BzD3NSPc8NrLDzXcRhC3smRgBrn7xMxv7k4Tps32UzLQebYKFLp0lHr4PBbGhlIx0ORKV16IZIyhhiAn+/lCn/UMJV0+TP4y9l4COnHa+jQf2BUSkbiCtXdGqExxYx53hss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164486; c=relaxed/simple;
	bh=NmW+/4j+XOE8AKYHXmgfsvSTnHon1cvkDwSjmHQLefw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8NN715kMO4SSnguva/BA3sh+aTJ+vPK7DIujCTQBEauKM3mxDpywapWd6HiwqtvPLBDF1B5FvjknyJenRWEnE3e9OtN2P+70AZ39WwV59XwZ5mkCe7+HtSY2Baqo5LcIjj6nK6vqKbONWjxP49crHO9hCqdfcnw81GOlZoFzQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3719896b7c8so2355280f8f.3;
        Tue, 20 Aug 2024 07:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164482; x=1724769282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANPAYpDLFXL/eVBywbwjgQ8jM68fc9YCyYFv0xsTcFU=;
        b=F1dni4w+2KmT5mkfOiBmt3wQnKeNCXMaMSLvHaPvuKIKKp5D7OTlC5m5frw6ItkQsq
         bHoQbciAWAt8yQ9q1kCeYSmOuBLDlDpPI6JReCYwa9OdtzmlAiVw0x7FS7WDZ8oqaExf
         uVzJs6gUMK559L8fulSJndBvWqY1LRHTE3A72Vv+9kfkvGyqY0Htcsf6pxzdCQd5yuZZ
         23zePCs3C14l2JDunM13stMWUidNogCHk62NpW4Y1h+CVnvBYyeDvIbGCeNO8LodfyU3
         1ecVYGL2ytgi5j7XpBWAcfOb5hfLaKyf9yKJax1ZWsKhgSwUSLsRlcH/ZR1OqwPS+Lu4
         Dmfw==
X-Forwarded-Encrypted: i=1; AJvYcCXj4OUJcmjmRMReMrVJxgMirq2sn/93cJp12WtjXfSHIC9x4308Uce7vXwQRqjayR7W0heE2beY8EzBVCITmGQ/7ulMdz3G5lze5TXfd/xXNPmuaHu9stKJqoIbm3wlJ7O5D+Ivtkwub2s=
X-Gm-Message-State: AOJu0YwW7++/TQZkVriLHqPJg+D5pk7QIXYowDTLl371wwM6yB7SsMPJ
	5xL39TmeZ68r451SzTXSRShnJ7f5zlQTk65SNECQzhcvGYAIfbgA
X-Google-Smtp-Source: AGHT+IEpbB/vD16DyF0XIm3mlf0iAIbm6tIOqSFJ2OTJVuOwrT+zmMJF5X1mEggltotKlEGEX1MxjA==
X-Received: by 2002:a05:6000:2cd:b0:371:93aa:4056 with SMTP id ffacd0b85a97d-371c6060cfamr1657141f8f.61.1724164482080;
        Tue, 20 Aug 2024 07:34:42 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f732f200fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f732:f200:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897175sm13202865f8f.83.2024.08.20.07.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:34:41 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: stripe-tree: correctly truncate stripe extents on delete
Date: Tue, 20 Aug 2024 16:34:33 +0200
Message-ID: <20240820143434.25332-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

In our CI system, we're seeing the following ASSERT()ion to trigger when
running RAID stripe-tree tests on non-zoned devices:

 assertion failed: found_start >= start && found_end <= end, in fs/btrfs/raid-stripe-tree.c:64

This ASSERT()ion triggers, because for the initial design of RAID stripe-tree,
I had the "one ordered-extent equals one bio" rule of zoned btrfs in mind.

But for a RAID stripe-tree based system, that is not hosted on a zoned
storage device, but on a regular device this rule doesn't apply.

So in case the range we want to delete starts in the middle of the
previous item, grab the item and "truncate" it's length. That is, subtract
the deleted portion from the key's offset.

In case the range to delete ends in the middle of an item, we have to
adjust both the item's key as well as the stripe extents.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 50 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 4c859b550f6c..c8365d14271f 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -61,7 +61,55 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		trace_btrfs_raid_extent_delete(fs_info, start, end,
 					       found_start, found_end);
 
-		ASSERT(found_start >= start && found_end <= end);
+		if (found_start < start) {
+			struct btrfs_key prev;
+			u64 diff = start - found_start;
+
+			ret = btrfs_previous_item(stripe_root, path, start,
+						  BTRFS_RAID_STRIPE_KEY);
+			leaf = path->nodes[0];
+			slot = path->slots[0];
+			btrfs_item_key_to_cpu(leaf, &prev, slot);
+			prev.offset -= diff;
+
+			btrfs_mark_buffer_dirty(trans, leaf);
+
+			start += diff;
+			length -= diff;
+
+			btrfs_release_path(path);
+			continue;
+		}
+
+		if (end < found_end && found_end - end < key.offset) {
+			struct btrfs_stripe_extent *stripe_extent;
+			u64 diff = key.offset - length;
+			int num_stripes;
+
+			num_stripes = btrfs_num_raid_stripes(
+				btrfs_item_size(leaf, slot));
+			stripe_extent = btrfs_item_ptr(
+				leaf, slot, struct btrfs_stripe_extent);
+
+			for (int i = 0; i < num_stripes; i++) {
+				struct btrfs_raid_stride *stride =
+					&stripe_extent->strides[i];
+				u64 physical = btrfs_raid_stride_physical(
+					leaf, stride);
+
+				physical += diff;
+				btrfs_set_raid_stride_physical(leaf, stride,
+							       physical);
+			}
+
+			key.objectid += diff;
+			key.offset -= diff;
+
+			btrfs_mark_buffer_dirty(trans, leaf);
+			btrfs_release_path(path);
+			break;
+		}
+
 		ret = btrfs_del_item(trans, stripe_root, path);
 		if (ret)
 			break;
-- 
2.43.0


