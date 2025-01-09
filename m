Return-Path: <linux-btrfs+bounces-10857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D42EA07B96
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9114E1622A0
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B622331C;
	Thu,  9 Jan 2025 15:15:29 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB3222563;
	Thu,  9 Jan 2025 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435728; cv=none; b=lIurE3wQPvaRLi9+mj6be1a0XtYc5pOH5d6DnQ4nfJ/klHqEBW+k7jftF2zL5Qk9LpcxJyH1WelVqi3BRplX1Fcn2cdAUArklN6tiqFvlwcVAuebu0jRQ8W1xX3YufCx6W+4T6ldcX3a9qMD/Vy1GxZY3vK4m0BgipMI+Vu9La4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435728; c=relaxed/simple;
	bh=41y7RZ7gEYvLkAxEzpK1EqpSSlg8rGbhKlFDY0WUQvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BHpBvaDZrTTBs9BRHvV1czvPf2RPXGpXCE8j5ZaHoBEQCmdC+qS9aZxUTe2zaZkdiW2DIRgqqEmI2Vn/U2i9xQhG8KYG2vsehEcPb0pKeXv7ZHUTpIMLPYW85lheqTR0N6UX0bIsdUGvV9rbgLi+Mo0wOajna3l0AW9U4kqKCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaeecbb7309so211219766b.0;
        Thu, 09 Jan 2025 07:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736435725; x=1737040525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbj3XbmfCs1NqrWpUNZLnYWPO6zpl4oL3yPP5bqydJ0=;
        b=cOFiK43raP8EK/1h7VezrbpLD6ul9WFWfsZhbT+P8ETcqZkIO6FTyYOdPviVwNsvXO
         zWM9sq7o0jLJ4sXxQJx3xaH0/xA+tgyXhxlAcVJ3wA15i5x1qEETDcjMQOJfRJD4/ToU
         KDJWqEqM+iTsxKITUTflJ1gVzMsTSXwQPoXIMD4XutpROm5DZ04EUwouXdJh6Bo6pcL8
         jMqlH+1gV+/PEUBuBtMh4goyyMybjV9ecClDJ67PANQAOEQvI8RLJ2c2VAVEM114u5QR
         6+xjQAI/zo/nEX0EMA53Jv23fyKSK38ZZaKk1Sk0icfho1jrxkjlMPnzUzfdEjZxsVRS
         7H/w==
X-Forwarded-Encrypted: i=1; AJvYcCVUB83bIvf9qIWbp7Mg/rk/YvYSFQO6dCXgW1Y2PNyT4wMR/8gSOt87k7bnRrE5fjf4um2JsNx6/sgshQ==@vger.kernel.org, AJvYcCVqGJxBqmaIdTR/Yd/2X/E028TJajyY/hv0krQzLKbKTjQNh/6/L5+3jmvvG+u1Ck2W6Wruag14N/KS0R3L@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOWC2BGv+Aw4ExbG20vFSrSNwLFjbFNvBdv0Qxrs9clrDm1hA
	NLkkXGayfXcHN08NcIPPmTZW7m3aC6maNkToY442gZ9V6lm9jcH7
X-Gm-Gg: ASbGncuGK3Zq8RQM6CbiLI45hjf0MnbNUenDPO3hnkimHGXBFxeXj+bB3OZ8KX4I7/a
	iAWhY9dNSBp29mQYlapIaaduqbsr86UZmL04H+lSBplQq+mpD5VWTsDfqmu14bGRMiSlLnTh7TE
	/VOE/ov6Ybq548LgEzSCs/K1b5pb8Yj5p95Ha+hTvw1Jm9NWGvJnjOL7CZlSP/dZOqunpyCu8rJ
	NCNL/JX8v/AD1SivW0f5AUsVC2Htn8AJKRD1eFBL8JeAP/w58yhgsICFgMBqAiKzNwQur6MY+jS
	fT9yMG9htBRGhdwF4eHhJTCOPp6LVzJ8OsYU
X-Google-Smtp-Source: AGHT+IG3vrh6023ytXDJw93ekDuO2rlP63qmfezgFi8yNraYUiHG3+Ckk1u+HcA9aEONKN/bV4GzTA==
X-Received: by 2002:a17:907:3da8:b0:aae:ce4c:ca40 with SMTP id a640c23a62f3a-ab2ab740698mr563703966b.32.1736435725206;
        Thu, 09 Jan 2025 07:15:25 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95615a6sm81539366b.94.2025.01.09.07.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 07:15:24 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Thu, 09 Jan 2025 16:15:08 +0100
Subject: [PATCH v3 07/14] btrfs: implement hole punching for RAID stripe
 extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-rst-delete-fixes-v3-7-b5c73a4b2a80@kernel.org>
References: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
In-Reply-To: <20250109-rst-delete-fixes-v3-0-b5c73a4b2a80@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166; i=jth@kernel.org;
 h=from:subject:message-id; bh=R9uOQGw9UkR9TkHDlN99eELkUGXAOXliXrIBwVbzV9o=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXv2CZsTRS5kns56KQ1l0d8yV2z3yt/GuLY9C9u4d8j
 qzfd3/prY5SFgYxLgZZMUWW46G2+yVMj7BPOfTaDGYOKxPIEAYuTgGYSHkaI8OJDXUXNu78Fvx5
 Z4ShhcDR5IVrio1aPjEyH5766LDd48RpDP+zTjE3rva9EbGvw9PtlvThfTWJiiefuySe1dMNYpF
 85sELAA==
X-Developer-Key: i=jth@kernel.org; a=openpgp;
 fpr=EC389CABC2C4F25D8600D0D00393969D2D760850

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
 fs/btrfs/raid-stripe-tree.c | 49 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c93f52a30a16028470594de1d1256dbec5c7899c..92071ca0655f0f1920eb841e77d3444a0e0d8834 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3833,6 +3833,7 @@ static noinline int setup_leaf_for_split(struct btrfs_trans_handle *trans,
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 
 	BUG_ON(key.type != BTRFS_EXTENT_DATA_KEY &&
+	       key.type != BTRFS_RAID_STRIPE_KEY &&
 	       key.type != BTRFS_EXTENT_CSUM_KEY);
 
 	if (btrfs_leaf_free_space(leaf) >= ins_len)
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 7ddc139ae1cf2d4844b1955ed3ecfe1b91f40049..e0bb95304dd51eb8e4bcf11281e65092e4551645 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -134,6 +134,55 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
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
+			for (int i = 0; i < btrfs_num_raid_stripes(item_size); i++) {
+				struct btrfs_raid_stride *stride = &extent->strides[i];
+				u64 phys;
+
+				phys = btrfs_raid_stride_physical(leaf, stride);
+				phys += diff_start + length;
+				btrfs_set_raid_stride_physical(leaf, stride, phys);
+			}
+
+			/* "left" item */
+			path->slots[0]--;
+			btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+			btrfs_partially_delete_raid_extent(trans, path, &key,
+							   diff_start, 0);
+			break;
+		}
+
 		/*
 		 * The stripe extent starts before the range we want to delete:
 		 *

-- 
2.43.0


