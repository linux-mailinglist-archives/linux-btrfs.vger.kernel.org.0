Return-Path: <linux-btrfs+bounces-10770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41299A03FC2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 13:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DD2166BA5
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jan 2025 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA1D1F2C5E;
	Tue,  7 Jan 2025 12:48:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BAC1F1303;
	Tue,  7 Jan 2025 12:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254080; cv=none; b=eZah443A2MfBMS2yoyUppzOScfksCC9iHyyDSLaxHmOce+37nxWB0gFuy1g6JKyELuXx9OvhWhTA6grjK18FKZH3HHL7sfo/QVfSc0aaTmqL6800iRANa0359xdSNe+P+C3Zx0cOtNfirwOgvsu5lG0uPTbtWKF65/17ANOkE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254080; c=relaxed/simple;
	bh=58Gd8KQlYpvqTrF5zIUph//YzaJlr3jYRa8+CqkE9RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GImwIvLqdiWKWlxduN6OdUkxrw/dGEE8DU1AOa8mry8Qhp0J/dMl8Q+EsQYXDHJVrfx3iOTIEnElHWa//mPXTnETwkgIM8CI1TEY8MMyLpnvxOIjAWa8FCT7z8FgoQSchWtVcDrKWfDOWOPJxX18hOBapsrjxSg171XEWDozoOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436345cc17bso112069945e9.0;
        Tue, 07 Jan 2025 04:47:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254074; x=1736858874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92WJlMl4zxcREifQvN1xZFLk6LPYCZQK0qlMkK8xgPA=;
        b=j027mBJCnDZVEnv3cqxywVAxnnRvW4aeq8vgXFtQ631JXXLxAbAAOIisx7rl2xzc1O
         /+mJ+MLJhDAwnVtbuvAxMzbvqYy58+0lYbnz03CcO1kHQ8TS4Hx6Y/IlZYEbDw07sNe+
         R/KQoLz5gsQMzUgmzCdJyRFpv8eMVFbRIVzyYpw87ucxOXpEEft9qTk1MKUc+XMZVIV/
         0P5STJL6anfGRBu/HX4oRnBdHDl7d79FiSAGeqe3ocF4o6b1Pngqot/P6FwxLAMlybNP
         bkmuayhJe4+GV3Dg6OE7Fce389vC+Cz0hcuZ+A3X6SXknvoO39bk51S0JIeG676Br+MR
         vZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgYakQI0RlbA8X6rnIvIn4CPtLlcd70IxRlRXpGdxNtFQWW/8xqWPmOpNeiTC8FBo7PuF5f4oydPIDm04=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkibBDhko6GK3vry+qUQMDsEmSl0UekLAksJI+BQMvBzGeL3RJ
	m+Lo4YT7pJmiMqxd18ne++WObsEmXViwD5qd+r/+ZX9tEVhw4x+p7PwsxQ==
X-Gm-Gg: ASbGncsK9Xfx46usoOWxfH77yuWST4Ix83a9pQVCrFzK3kDfXYylT9GtZ+Mssgphe87
	Byz2WcFoWuCS2g5U++XnAO3RcP3I8PBIazIixvezxBonVrXDB3yOxFrUvI/vl7hRNXNAcm+phMs
	N/52gn5lPvt+ayJbPlwO0f/xIIA1T5+Uucwslosb+ihcWFmFgpnO5lXk+v3APA8HbRAwmyajKre
	SGZYHdCalv+c8LDLneXhYaRg2WJay0sywdNduODGpMXB80KXarPbFuqRs47IAnQ55PrJUtKS7MI
	v4xtmDLoBUbqcpOn5+Z85xZaLaX3VrctQcTA
X-Google-Smtp-Source: AGHT+IFnOgjCf0tKCouKaof1UjLBpqMB3eg6bVsVfeaw04pfslFiwJ87ZOKmKaRP3D1cYLNOq08KJw==
X-Received: by 2002:a05:600c:1d1d:b0:431:5044:e388 with SMTP id 5b1f17b1804b1-43668b5e172mr497511865e9.22.1736254073912;
        Tue, 07 Jan 2025 04:47:53 -0800 (PST)
Received: from [127.0.0.1] (p200300f6f7218600fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f721:8600:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c508sm596884845e9.33.2025.01.07.04.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:47:53 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
Date: Tue, 07 Jan 2025 13:47:37 +0100
Subject: [PATCH v2 07/14] btrfs: implement hole punching for RAID stripe
 extents
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-rst-delete-fixes-v2-7-0c7b14c0aac2@kernel.org>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
In-Reply-To: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Filipe Manana <fdmanana@suse.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166; i=jth@kernel.org;
 h=from:subject:message-id; bh=AxkJp5qY5UjE1UdyCqOfRthbS1A/pn7c+ONIah7ZhWc=;
 b=owGbwMvMwCV2ad4npfVdsu8YT6slMaTXKhVynbbra9l+NUd81etvbF92363ft2vr5YcsCgWpe
 8Wk31lyd5SyMIhxMciKKbIcD7XdL2F6hH3KoddmMHNYmUCGMHBxCsBEJjUyMpzVeb/adOrpEHVW
 aZe1r35VT9l7SJfLKu5xnj/3Pvbw0A+MDM+z2lLjghaqbXwxrzau8NTM7YfPX30+Y+0q598f3SV
 c+BkA
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
index 893d963951315abfc734e1ca232b3087b7889431..d15df49c61a86a4188b822b05453428e444920b5 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -138,6 +138,55 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
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


