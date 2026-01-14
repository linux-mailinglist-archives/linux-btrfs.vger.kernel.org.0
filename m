Return-Path: <linux-btrfs+bounces-20477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A11DCD1BE49
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 02:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EF103026AD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 01:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35822356C6;
	Wed, 14 Jan 2026 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntCZN9Nt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDBF184
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353224; cv=none; b=SwxUa/NYEutNQzlIO9GVw1cpYXv3csolW3UOTgh3x8sF+XAv0lPHLYhSdq3PsvK27OO7V0Dy+VDblDTmFl3NCt1ldaU6t7KVjNFq3GXB6yurmxFwgVfHcET37ISTjTGFYrZtQMhszUCsLeFEiSgcjQ1qpMPBFrYA4vJjGD7cBhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353224; c=relaxed/simple;
	bh=LPF0sxafEG7ny8XUQpeOqbK63tgsdTi5cz2VL+rh5ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hooDLtBl3Kh7P2+EP2oyOyNaNxdeTKafFdgEf/n05H2KS2HeyGs7byNixzt/gkjDb/qxLDNEzPVOyc1tojJHKTbDeIoIXC+KD5APU3dQ1ILtBlTDBAF0Fu11KoVwFqg7VPfM+cOXBi+sNtZydGU9HueKr6BhKfUJace74sLSr70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntCZN9Nt; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7c75178c05fso3135984a34.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 17:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353222; x=1768958022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=np59BT8UQoyo4NCHoG7Gy1aCxaoQiBPKFat5KdX+siY=;
        b=ntCZN9NtYghEl+NYjw8h3IVAPVc+O7oDRH7klTatogNdYtOc1+KNJfmDXRz574WnAG
         orfkYiHgqbC3gqUnfO2x7A0hyXpGN0WNUzOlaK3qF6qfjJL/65JqjXRK27xv98ttF0Or
         7/Nb4dLI5HpdJcSRQxuKwExJ5WAUKl8K4OMHYYzV7m2JQmE0yOPS5ZRenVCc7VvqETWo
         jB8w0mxLLV4OQ8aoSC6nRR5LAHL7WFL2r7QDPdCBZ/k2hIKw2D57VL51d8yGPROMz9QT
         EtxUyhRYrc+XaR0R0kaUPKg972/cFO4myee1j7N2/r+6OC+ff293cgNU3SvGKUxw9bNi
         MpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353222; x=1768958022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=np59BT8UQoyo4NCHoG7Gy1aCxaoQiBPKFat5KdX+siY=;
        b=Zaya4gmJNMqnLsdC4mVLL+sFlGo6Uf7ZCj6M8ZeDgMik1fReqN1DZmGT0/6rT5n9o5
         JBOULOFP4xC4xLOwGNfOCCxWRGJHcTDd+kuX/xA2Ggq80So8FHqreLvHz8xJYRGsxkvS
         B/1oKs8PJmnP0WIFDpy4tnwZYsP5Tk7LUYwVo+B3yb3Vq/WWMwCLLcTDtoj7MUqPeAgb
         ivvWIDPJHJOtFC6xzaqxUlJjYeQtt9eyjMLnrrWFtMpB3r3nIFfrgjXu9CxGFjQE4wzC
         6WSGajNCRP+gRW5I+ypPdfFu1DLGGmKmu2ymGDcUeZ+a84ydiwhWIeO4y5M7jsUj+Dmq
         IiBA==
X-Forwarded-Encrypted: i=1; AJvYcCXYNnmSi2MF2DDEx1QZizb85QR1OKxzJt55RiW03FwIiXNpRs4uDcH5gdJ2sVxWVEHR0EJk9YCy9j/Mtg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjchsph5dFuO7neGnCbbTx6GeyeDIXD7XyvQ9ROs5Mr9lEkDIW
	vBVX64iGS/MVTKpComUoCw+oIVAlVKZeoEf8fWqXfeh2Mt/UbPfhgylzjUGs9nh1
X-Gm-Gg: AY/fxX60CtKGK+99QH/M9n2zwZfpTAwjbwfnl8NveJuwLZOGNCwnVvQwPGE1ybg7CNb
	fDVGU4f/vO0eVJsuRS+uL0yMzAn0YspSkCdwB5Jx9Vw5+fOFW3mwZ+8MJdCfMzu7v3hrSWkNgF8
	gDBLhgS9t4ZQ8xGQ5j7uwyerZbIFr01nDC1Ei6zGOH4BZiayOlDDXdMK6PPMP1stN8WceKCa7b7
	cYPiz8J2iKMNtln9NsKRNIO1DRsoT6I17TV2r7G3tFI4yyWzXFfEcRBFUjPnr6DGABHC5I4ceqU
	DjSKCOlh2ZOy8ERL54qqyFSge7uktEj6E9PCBvpB0Kx5CjUpkUzHWmwgE8pk3/2TYPTDTFAKaza
	TfDMadTOk0w0hLaPzK192zHJaj8h6SaIup4KdNY3j8q6fMez0LTKqpg0Zby1w+xJMXXvp/1uxrm
	nN47JCuyXpYFfNvBKTT0HRKQEfpq2wk9Mu
X-Received: by 2002:a05:6830:44a7:b0:7cf:c613:d311 with SMTP id 46e09a7af769-7cfcb6997f3mr246667a34.34.1768353221562;
        Tue, 13 Jan 2026 17:13:41 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ede38sm16705215a34.26.2026.01.13.17.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 17:13:40 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: boris@bur.io
Cc: clm@fb.com,
	dsterba@suse.com,
	fdmanana@kernel.org,
	jiashengjiangcool@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] btrfs: reset block group size class when it becomes empty
Date: Wed, 14 Jan 2026 01:13:38 +0000
Message-Id: <20260114011338.44172-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260113215705.GB1048609@zen.localdomain>
References: <20260113215705.GB1048609@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Differential analysis of block-group.c shows an inconsistency in how
block group size classes are managed.

Currently, btrfs_use_block_group_size_class() sets a block group's size
class to specialize it for a specific allocation size. However, this
size class remains "stale" even if the block group becomes completely
empty (both used and reserved bytes reach zero).

This happens in two scenarios:
1. When space reservations are freed (e.g., due to errors or transaction
   aborts) via btrfs_free_reserved_bytes().
2. When the last extent in a block group is freed via
   btrfs_update_block_group().

While size classes are advisory, a stale size class can cause
find_free_extent to unnecessarily skip candidate block groups during
initial search loops. This undermines the purpose of size classes—to
reduce fragmentation—by keeping block groups restricted to a specific
size class when they could be reused for any size.

Fix this by resetting the size class to BTRFS_BG_SZ_NONE whenever a
block group's used and reserved counts both reach zero. This ensures
that empty block groups are fully available for any allocation size in
the next cycle.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v4 -> v5:
1. Remove the Fixes tag.

v3 -> v4:
1. Introduced btrfs_maybe_reset_size_class() helper to unify the logic.
2. Expanded the fix to include btrfs_update_block_group() to handle cases where the last extent in a block group is freed.
3. Refined the commit message to clarify that size classes are advisory and their stale state impacts allocation efficiency rather than causing absolute allocation failures.

v2 -> v3:
1. Corrected the "Fixes" tag to 52bb7a2166af.
2. Updated the commit message to reflect that the performance impact is workload-dependent.
3. Added mention that the issue can lead to unnecessary allocation of new block groups.

v1 -> v2:
1. Inlined btrfs_maybe_reset_size_class() function.
2. Moved check below the reserved bytes decrement in btrfs_free_reserved_bytes().
---
 fs/btrfs/block-group.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 08b14449fabe..343d7724939f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3675,6 +3675,14 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+static void btrfs_maybe_reset_size_class(struct btrfs_block_group *cache)
+{
+	lockdep_assert_held(&cache->lock);
+	if (btrfs_block_group_should_use_size_class(cache) &&
+	    cache->used == 0 && cache->reserved == 0)
+		cache->size_class = BTRFS_BG_SZ_NONE;
+}
+
 int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 num_bytes, bool alloc)
 {
@@ -3739,6 +3747,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		old_val -= num_bytes;
 		cache->used = old_val;
 		cache->pinned += num_bytes;
+		btrfs_maybe_reset_size_class(cache);
 		btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
 		space_info->bytes_used -= num_bytes;
 		space_info->disk_used -= num_bytes * factor;
@@ -3867,6 +3876,7 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
 	spin_lock(&cache->lock);
 	bg_ro = cache->ro;
 	cache->reserved -= num_bytes;
+	btrfs_maybe_reset_size_class(cache);
 	if (is_delalloc)
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
-- 
2.25.1


