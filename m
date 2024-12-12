Return-Path: <linux-btrfs+bounces-10299-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A006D9EE0AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E083A1682F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A3920C495;
	Thu, 12 Dec 2024 07:56:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C01120B7E4
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990165; cv=none; b=OOJDFdvca2oW0PKcUwJPd0VaAjwQDzQ0eojMm1uoqL4I/u2QCMQVxlRUYiMQ5rgFacC1WXsBqS7VxPJoEbOKOqH5XuutZsz5QiZBN+qqXi8uicHYgBGX5BNNnLQ/1TkorrLMkZqgTszCVsTUz3LNWTl1YwJaXdi7B1yKBCzTlFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990165; c=relaxed/simple;
	bh=FPGDS49td3ziVWZjlkQ2zVAgMkp4kA/i2ehvigPCw08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgNl2wEuu8iZplbaZtiStMy3mGbI+VXjTLUCAAzok4xTEnqmv0fwIIReJk0oMsoeEeWwGIREpB10R7IWawWleRAhlSLtvvO56XKg93nEoViBZpOOg3vgvstotIwwM0s0wYC7tnBGuqY5rRVmgz+BEQgWZgp0Xi9HXUmaEleddoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so40476766b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990162; x=1734594962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XErpM1vqE1dV6Fu8tSD8IkYMheM4WDtZLeIjdrqirXs=;
        b=a3RFSSxHZkZZlxdvM2LPhZTER1aGz80JctX2k7Pno7PW3VnnbafYgjHaf7g6i02vo7
         GNZKxLTECWULbdcUqUaF0S/vP2izCPh+h9PKWxcqzzejc88VNZXzK6x+n9/q+B69DVsC
         RSPSZ7sejLQqXXBl0h/G9ZN8yqI2JGJykXP3PPsLiHkb/ndf2SJAHQoi7t/2tmwFgjp2
         mD6/crJ6Mm255K1HmfNveekPHFBO7No+6Nf5D2YfVvy58K1EzDrxnThl28hFf1I05Htk
         ueRjR4H8oztR/VqlqhqH2t/61QtlY6VewODtdE+FUj7Ct1/cvdVKr+NojNF4wIhfWiQ0
         eKKw==
X-Gm-Message-State: AOJu0YwRY1dOe4t2FiiZ+2fy57NP/0uFGkvKTrQYHxIbfL41HolKOlp+
	obNnv9IF37HLu35v5w28m96yqzNUxPorKFoudoo42yeb2hdBlqO6eJ3YI/Kx
X-Gm-Gg: ASbGnctAGu9SeOXdoP062rF3ZoPVycydvK2fwqcu0xORbxyKKm+473au7E2v67l/kWo
	E6QDO31maS2ahdRqZkkNPPNiexLDTYezcTVNf7dgH6BWPIJ+kOk+nYk8leqgbF8EMpayMYqfIeK
	z8vH0WfLquMSFqSqqT2DEajBaHEnnhu7SpBFT2v7C6EZBqsZ2tHqe/kc84eGrwvO93irEPXwneY
	Qbu25oOqcZ3PGYT9wDVsoICZtUua83U+9n5SsKnniQd6uJ9D5CjG2JZA1BvyFMTesSbxezPKx/r
	sFPqYa5okwzzD/AYXDOQB3YPsAHWJlWiVMc96BA=
X-Google-Smtp-Source: AGHT+IGl5IBEM2MToTCmg6zSlS/rZ0QXQR9HNDAZOT/se0ve/gEQzXkWlwZSNILB3PZNx38FfqXtwQ==
X-Received: by 2002:a05:6402:5299:b0:5d0:fb56:3f with SMTP id 4fb4d7f45d1cf-5d4edccdea2mr263049a12.12.1733990161827;
        Wed, 11 Dec 2024 23:56:01 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:56:01 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/14] btrfs: implement hole punching for RAID stripe extents
Date: Thu, 12 Dec 2024 08:55:26 +0100
Message-ID: <038e3971d12f2f8aef69a96c999916f37165f12b.1733989299.git.jth@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733989299.git.jth@kernel.org>
References: <cover.1733989299.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

If the stripe extent we want to delete starts before the range we want to
delete and ends after the range we want to delete we're punching a
hole in the stripe extent:

  |--- RAID Stripe Extent ---|
  | keep |--- drop ---| keep |

This means we need to a) truncate the existing item and b)
create a second item for the remaining range.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.c            |  1 +
 fs/btrfs/raid-stripe-tree.c | 54 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 693dc27ffb89..5682692b5ba5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3903,6 +3903,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
 	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
+	       key.type != BTRFS_RAID_STRIPE_KEY &&
 	       key.type != BTRFS_EXTENT_CSUM_KEY);
 
 	if (btrfs_leaf_free_space(leaf) >= ins_len)
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index ccf455b30314..6ec72732c4ad 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -138,6 +138,60 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		trace_btrfs_raid_extent_delete(fs_info, start, end,
 					       found_start, found_end);
 
+		/*
+		 * The stripe extent starts before the range we want to delete
+		 * and ends after the range we want to delete, i.e. we're
+		 * punching a hole in the stripe extent:
+		 *
+		 *  |--- RAID Stripe Extent ---|
+		 *  | keep |--- drop ---| keep |
+		 *
+		 * This means we need to a) truncate the existing item and b)
+		 * create a second item for the remaining range.
+		 */
+		if (found_start < start && found_end > end) {
+			size_t item_size;
+			u64 diff_start = start - found_start;
+			u64 diff_end = found_end - end;
+			struct btrfs_stripe_extent *extent;
+			struct btrfs_key newkey = {
+				.objectid = end,
+				.type = BTRFS_RAID_STRIPE_KEY,
+				.offset = diff_end,
+			};
+
+			/* "right" item */
+			ret = btrfs_duplicate_item(trans, stripe_root, path,
+						   &newkey);
+			if (ret)
+				break;
+
+			item_size = btrfs_item_size(leaf, path->slots[0]);
+			extent = btrfs_item_ptr(leaf, path->slots[0],
+						struct btrfs_stripe_extent);
+
+			for (int i = 0; i < btrfs_num_raid_stripes(item_size);
+			     i++) {
+				struct btrfs_raid_stride *stride =
+					&extent->strides[i];
+				u64 phys;
+
+				phys = btrfs_raid_stride_physical(leaf, stride);
+				phys += diff_start + length;
+				btrfs_set_raid_stride_physical(leaf, stride,
+							       phys);
+			}
+			btrfs_mark_buffer_dirty(trans, leaf);
+
+			/* "left" item */
+			path->slots[0]--;
+			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+			btrfs_partially_delete_raid_extent(trans, path, &key,
+							   diff_start, 0);
+			length = 0;
+			break;
+		}
+
 		/*
 		 * The stripe extent starts before the range we want to delete:
 		 *
-- 
2.43.0


