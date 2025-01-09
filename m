Return-Path: <linux-btrfs+bounces-10856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C81A07B93
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902483A3EA2
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA54221DA3;
	Thu,  9 Jan 2025 15:15:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC66221D87;
	Thu,  9 Jan 2025 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435727; cv=none; b=AZVwHx71lSAtmeoFuexjfZPFjYqiXfPuGuyznP7htL5g4pvqYmQ9LzucLeRmtUXfG/p0sXJ8+c+MlploB+tFdHJ6HKOd4ubnM7HVGWe4RI/DI6+cm7WlWW4nyLPKCKa4UADdGqrkJOrTlAEreljRwTXdsvqZ1Zjlo8oZHVBgVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435727; c=relaxed/simple;
	bh=5+GO5u/tRwV2HB0C8zTuqEoqQvdwsnHEErFsy2/1Kgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=toHZ+6Gbymy2bJzB8daKzrpnb+6YfYUGCMrFP5JoORDuoby76meiHDPYmJmyjxSywOoKB49G99Gp0/xuC2s2TizFZaVb+YfL0gkeCjLMq0GWXhE/YbIBE4gFZLillAOSqD9BibwmgFzrCfgr0w/XqlQAHABnPUtzPGiOgPHcmPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso179506166b.1;
        Thu, 09 Jan 2025 07:15:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435724; x=1737040524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3d8/nVjfNcp0Km7LERY2QbSQIyI1MyK/I+gtmInxFs=;
        b=IVTZANbuOURrwUOuwMjLcciN1S38RK+2/0AeM5zcUIloWdfBXE/MMei95v05yISRle
         dP1zVPl8zF/aC8kuDzcaz4M/7/fagE0JEUygWwhhIGsPFxT+4VNsB0nU+B/3uTuVfQDG
         4c5oB82Tu/taBf9eG/DJmcHyLBD34RFb6IzeTTFWZX1KPKI+93q9DjKq06Yc0H+L7gl5
         9AQX4Klv5OOWMBpdFNCp0rvxqumz7tLjpEmvj+UrLVpDKqoiTPHcDdeeZKLpdSkzZQv8
         cLEBF6e1+45RS89M+lI3twh3Gr+EPXVVDg23NvTJcqY0/HSP7KRxY3JU3E7GHUWSizwY
         4YSg==
X-Forwarded-Encrypted: i=1; AJvYcCU80WHWYpVLUc6VpASUkTa4kEYAuPWdY332Zs4AYvYdt/KFDAs8NXy5R5HjtxKDUD21IWymbcCtFlH2Wg==@vger.kernel.org, AJvYcCWac2NCDn3haqLfzpAgZlx8+9p+hwRpx1yONVHvmv9jn6C658w76qkUWAMNQ9OkfKYnQYUcfFK7ihAZXBL1@vger.kernel.org
X-Gm-Message-State: AOJu0YwYU4Pm8dvnL+pSOiXnUVGMuACxh0N3yS4o/IpFdEP13/9Wjh7i
	2S+pkjPkYoLEfvfUsHc5lzy0xlgPzK1kQKxvGX5ceHAH05uMrRd9ZINusw==
X-Gm-Gg: ASbGncudrkeKjubHYB529mjO+l0bENgZljaNA+Rj4Y1uDSBp5owEsoVud9JvZ+0YdIj
	2ZD+NBs6EewURp1kqnW9O0ZGvXC1L9of21mqGOEZiGKwt2GK0cvO2HOlDWBdzdTtx/IRgvxl4QT
	gijwVfkTGHYb8mORgJjMKNBibCw71QqZHvdmj6JW8U4sf0oXFVG7ePQrrC0+yCD4KfZITWYcVOk
	a8ioqHKmtY58HUo8O5VYxNXVJii11od6w5AviE40LSKVbfG3JK4YVMkNu95BvDXfqfnSeV1EZ0z
	MAUcFJ3cdnRkiPYg8HsTitm2pRXhJ5yJ1RsG
X-Google-Smtp-Source: AGHT+IF8O34911EEdzAt8qt/e9HM8Sk/YAFRhXRHiBJBlPuEkOAgaheD/qkb7Tr30p40exllObRCXg==
X-Received: by 2002:a17:907:787:b0:aae:849f:3255 with SMTP id a640c23a62f3a-ab2ab709e27mr609965166b.34.1736435724278;
        Thu, 09 Jan 2025 07:15:24 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:23 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:07 +0100
Subject: [PATCH v3 06/14] btrfs: fix deletion of a range spanning parts two
 RAID stripe extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-6-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=jth@kernel.org;
 h=from:subject:message-id; bh=ewxDBIkZMuYfdG9lr4vnlMtFx3CMq9782G1Np1tOcSQ=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2Cxf7gh79T1bQtiIxvi7jT8CUg97nRvhnKpg7DVm
 tMRdb95O0pZGMS4GGTFFFmOh9rulzA9wj7l0GszmDmsTCBDGLg4BWAiHdMYGbZlmCuWHN5gw778
 2VY+jk93rgg+4HQ63Gw1aeW9qFt1Ya8Z/vD0WhVcUKtil/K+mtH5rKHlyfP559/GZgpvPTN/M7d
 yJSMA
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

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
 fs/btrfs/raid-stripe-tree.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index ef76202c3a38460c5a36d7309ac0a616f73b0cc0..7ddc139ae1cf2d4844b1955ed3ecfe1b91f40049 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -99,6 +99,31 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
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
 
@@ -152,6 +177,9 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
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


