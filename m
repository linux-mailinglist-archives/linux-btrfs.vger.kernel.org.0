Return-Path: <linux-btrfs+bounces-10298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8528E9EE0AC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 08:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7902F1682F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5E420C479;
	Thu, 12 Dec 2024 07:56:04 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445420C01B
	for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2024 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990164; cv=none; b=IozFOvEXHq6PgRloVDSYbCTkQqrmnQQ06tXfTMABvlwsdCjC26QfeYcQt4q4FbrgMdWs+7KSnttHEJiZmeNbBmfVKVtokqer85Mz3R7TSHAye3sYB5WQZzDEKKm1EXtxfXMlJ9e59Pnvmtzu/rke7Y1IRTzdgPWpDX78RWtYKsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990164; c=relaxed/simple;
	bh=t24b2IIGQIho4XE2mnR390bfmaWPWPUYgA93KXVxWb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuw3ZDJHSNxb13DVZhA6/cfOG4Tw4RDeqhlMkkJz+EuqsPXpjxCnfdeIsZ0imILZOUcQebOTt0eUtYq8yDKqmCIrhl5e1keReaa1rgLvlMX5pxt3yNLyyVebzTF2QKd8L78cKro9zZeaw2In/RBZmFHkF1HUYtYhD3/5sAzwNk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa696d3901bso50072466b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:56:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990161; x=1734594961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+hs0AA+wFdftCsQ9QhutGkhavg9W9yBT5CHlPrSZkI=;
        b=Ki3KPMir1nuPakyrsEcczZICI9EBl30TrTCb9sE3XgjveESKj8hN5f5gJ6tC5rs9YQ
         gqJkjWWnJwIR7djhvVqBGKfXj4F6mHOQo33YUxL30BgsNVTcrnww90AXBXYypGNGHAfC
         yhX366I9BrvNgiUohkOSjjs1tRcAhllCSWeik03KvcxZzJyd6TovmEN/9RN5ngnAdhVS
         dNN5zLgHZrfAMfhP5bcoGUaKKUoPIexvGoYnfIuZqLkKWqjwkZxn9MdHctu0p3tYo7Ag
         P31zArBa6JzdbGPV1VVApD/bQWC0rnP7M9yrouOI0YOByRvlJXD32nqaZURU5MYQ/T5X
         csDQ==
X-Gm-Message-State: AOJu0YxN7a2gyUY3l5ctrSRbQ3DLuWTWfgwrjFQ3ellt0jmgBMFh+Ixo
	mbXUMCWxCM6MPxTcJ5A/japZcx97KalphfwqAXmoP5B8ncLGkRcIAAmCayIX
X-Gm-Gg: ASbGncvzHvudCgi8hFYLvrB1if4E6l8tbP3gtcnCMbDLyrofma2kgVXe7/2rfwfx4ka
	epRq4fVC7vtYLgicazhkPKwj6q0ZmgICqIRT4cZRoZlvzkT+rIAyYoeb+sSfADNZp1zOd6qyIvx
	UfbPX+jZz93pyKNBV/5JCSeDygIU5meSn0MelG4wCW9miSLDxvBfAqcNWDusmbtqrX14nSrPmIu
	JlShcWihj3dtBc/9fWW8RRIdFU1S1vpRQMSvjOfXAi6JURNphOexTDLUF1IJJX5Zt1g99Uzq+aJ
	spBWfi8exaK18ps5J9aQWCKjx9xa69jthZYTXHY=
X-Google-Smtp-Source: AGHT+IEYijW8gz5gX9vbZcXfwAKhaYrMaLhmqpkUEJy9zdZHPPxnuoZqi0sufcUKhVusAWW36rqtDA==
X-Received: by 2002:a17:907:7808:b0:aa6:7c8e:8085 with SMTP id a640c23a62f3a-aa6c1b09cf5mr270266166b.15.1733990160702;
        Wed, 11 Dec 2024 23:56:00 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7081700fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f708:1700:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6a3a80d6csm350730766b.8.2024.12.11.23.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:56:00 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 06/14] btrfs: fix deletion of a range spanning parts two RAID stripe extents
Date: Thu, 12 Dec 2024 08:55:25 +0100
Message-ID: <73a3c0f290dc84b8b802c8705503370d8cb62bc8.1733989299.git.jth@kernel.org>
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

When a user requests the deletion of a range that spans multiple stripe
extents and btrfs_search_slot() returns us the second RAID stripe extent,
we need to pick the previous item and truncate it, if there's still a
range to delete left, move on to the next item.

The following diagram illustrates the operation:

 |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
        |--- keep  ---|--- drop ---|

While at it, comment the trivial case of a whole item delete as well.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid-stripe-tree.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 6246ab4c1a21..ccf455b30314 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -101,6 +101,33 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 		found_end = found_start + key.offset;
 		ret = 0;
 
+		/*
+		 * The stripe extent starts before the range we want to delete,
+		 * but the range spans more than one stripe extent:
+		 *
+		 * |--- RAID Stripe Extent ---||--- RAID Stripe Extent ---|
+		 *        |--- keep  ---|--- drop ---|
+		 *
+		 * This means we have to get the previous item, truncate its
+		 * length and then restart the search.
+		 */
+		if (found_start > start) {
+			if (slot == 0)
+				break;
+
+			ret = btrfs_previous_item(stripe_root, path, start,
+						  BTRFS_RAID_STRIPE_KEY);
+			if (ret < 0)
+				break;
+			ret = 0;
+
+			leaf = path->nodes[0];
+			slot = path->slots[0];
+			btrfs_item_key_to_cpu(leaf, &key, slot);
+			found_start = key.objectid;
+			found_end = found_start + key.offset;
+		}
+
 		if (key.type != BTRFS_RAID_STRIPE_KEY)
 			break;
 
@@ -155,6 +182,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
 			break;
 		}
 
+		/*
+		 * Finally we can delete the whole item, no more special cases.
+		 */
 		ret = btrfs_del_item(trans, stripe_root, path);
 		if (ret)
 			break;
-- 
2.43.0


