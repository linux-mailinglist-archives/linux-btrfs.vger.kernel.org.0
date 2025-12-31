Return-Path: <linux-btrfs+bounces-20049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ABBCEBD7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 12:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F4F2300986C
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Dec 2025 11:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329072798F8;
	Wed, 31 Dec 2025 11:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQEdVQFQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C692820DB
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 11:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767179803; cv=none; b=GyLOYlPbf7Sr8UdTp+2XYCHgInHZzzsykyKIdzbL4TGDho8H0c0qMpD/G03qdW7ny0fywmv5PUbKDnH7vdIJw+6YQRae4iKXKPUXEoOHfBj4z1JoS1Fdjs3N/pFfj7L+FpNcf/gX9UsiL7yjd6qU/aeetPmOIO0rzmGrAmyJLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767179803; c=relaxed/simple;
	bh=zSOHfuK0qnqqtpp8lYv4gVJSFFo2OWUbGZWBbQ+ktyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4SO0BWJnQX9ru9Cur/y3qejlGO0WpKLZSgujtKAxoGVtZ+cJmqKe5DMthVy54attmb1d4O72o42l1wWjlr74egStRerTo2BUfL2yb0oSiDLIiwQyHW5HvPmVbvTNfrXhmpHi9FhZOTb1if0+YgoxURYGD/jUvkITCL2lszmjjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQEdVQFQ; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0a8c2e822so29042795ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Dec 2025 03:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767179801; x=1767784601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30va2jyav8kU4LcKy3KeBE1gBuq2jsFrBDRXEdAY7BU=;
        b=jQEdVQFQpoRKIr/B54xoaPde6C6GnLOieqMR5nCQdv0/buy7dz40R7aVze945D3nBq
         liorsfw8UOGT1gadvg/YvItg+R6gP9dNtl1T30kg/c5fDFphylT4yMZ0Iopjmmkviqhi
         V/vMZnxl7izqD1zBhtTRIkNVJmDeXmPf5FTbokGOhmPdM9V2gjWnjQW5Pl+wCl09MZvV
         YUdoOz+1gmv0fEBOtdY5jujrmp5z5kPmYWavr7O51b55MxIjWarMc5ooSebwECFDkrp7
         Zu6sABnhPX+qkq89GbBuI+xNY39Uh33HcMQhOCRuAkUc3/ujAq3ePeu0afJajHs2Z/nB
         EDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767179801; x=1767784601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=30va2jyav8kU4LcKy3KeBE1gBuq2jsFrBDRXEdAY7BU=;
        b=Zrq6j704PfyWjYIqA7AEMBvtOEb+YJyau4DIiMUdnHrGyVi6120l357lRrTly2PHYv
         LZ2kLp5RJJX/KwUxx9ScB7a9BMzUGX2UB+lq3hfv8+1fsIdNFPwi3VO2WKTDeDXNwYPf
         lov4tVTncha4GN97E23i33yThHhfWgACfwvubBJzi6P6M7dVIkkA9IqG7ecffp7W3VfG
         MMI1yEl0x5cvEf9WDdEr78YUamv+3fouPxdapAaZVjlxAEMkp/lToTN6CBYhOg0zwNiZ
         rve0G+35gu2bq3euJJ605VcnIZVzwX6aaVNOoitugCGUH+MSGU69M9G2m1G38KKZYdrN
         GuPA==
X-Gm-Message-State: AOJu0YylbcsecEknaehH+gWPGlVHonmgCG6nrWaqB4XMXccDmMBjn2NM
	DNtOotcMzHdCV4vdwA7TSnplnmzpmDN50xruRfhYDu2nGRjM85fvZAgXbpHBOcvAkdj+eIiT
X-Gm-Gg: AY/fxX7Dd+g8bPVcho+ufHVaV5+4Yo+wjLzIdM2uuglxoUlzMlXwOZy7A6mhxapf879
	2bcUPCogGCOgf0NKuet8x6UIBGuuRoq1h7r/eDTR6pRQphiPK8a+NHLXFj3ZVu97M3InGu8i/sz
	pxp5QoZJIJQvcGjvfVKjy4h4GfM7kNWBKM6z24s5fSL4uiGaqj2+2J+jLGJIv/n+v7e8e1xrwZb
	N4w2TOYINqHC0axyio6JVud0x0WfBM5CkXnN7Q2r77Kvh6xtEo9EvujWXadxsY4XOuaKHzXnjvo
	F0IlQTr6FB4fhbFij8M4SgR/vX29SqaftBV7uOv9vWBl1rgGCC3dPJPx2yWVKjQJPo1rh0yXj3d
	wrsxKoLh/op9Ops/vEXXBt+zp8h+whiEDzhPEQSSbXvuMkCJ0NeFjaAD+CW+jsQg6KQpM/hjlBV
	REiFrUULJa6iDjQWoaUNRDpfE=
X-Google-Smtp-Source: AGHT+IE0Wz1A+0utV4okWNo/qOXmuCbrZ4np/zDmyez6pvSyHdrkSLVTSooJdznX+PolKfrvruQI/Q==
X-Received: by 2002:a17:902:f611:b0:298:535e:ef34 with SMTP id d9443c01a7336-2a2f2937c7dmr279280055ad.5.1767179800964;
        Wed, 31 Dec 2025 03:16:40 -0800 (PST)
Received: from SaltyKitkat ([175.145.176.205])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c74490sm321394385ad.5.2025.12.31.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 03:16:40 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH 1/7] btrfs: change block group reclaim_mark to bool
Date: Wed, 31 Dec 2025 18:39:34 +0800
Message-ID: <20251231111623.30136-2-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251231111623.30136-1-sunk67188@gmail.com>
References: <20251231111623.30136-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reclaim_mark field in struct btrfs_block_group was a u64 that was
incremented when marking block groups for reclaim during sweeping, but
the actual counter value was never used - only the zero/non-zero state
mattered for determining if a block group needed reclaim.

Convert it to a bool to properly reflect its usage and reduce memory
footprint by 8 bytes. Update assignments to use true/false instead of
increment and zero.

Now sizeof(struct btrfs_block_group) is 632->624.

Signed-off-by: Sun YangKai <sunk67188@gmail.com>
---
 fs/btrfs/block-group.c | 2 +-
 fs/btrfs/block-group.h | 7 ++++++-
 fs/btrfs/space-info.c  | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e417aba4c4c7..1dcc5dccef05 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3726,7 +3726,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		old_val += num_bytes;
 		cache->used = old_val;
 		cache->reserved -= num_bytes;
-		cache->reclaim_mark = 0;
+		cache->reclaim_mark = false;
 		space_info->bytes_reserved -= num_bytes;
 		space_info->bytes_used += num_bytes;
 		space_info->disk_used += num_bytes * factor;
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5f933455118c..3b3c61b3af2c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -251,6 +251,12 @@ struct btrfs_block_group {
 	/* Protected by @free_space_lock. */
 	bool using_free_space_bitmaps_cached;
 
+	/*
+	 * Mark this blockgroup is not used for allocation
+	 * between two reclaim sweeps.
+	 */
+	bool reclaim_mark;
+
 	/*
 	 * Number of extents in this block group used for swap files.
 	 * All accesses protected by the spinlock 'lock'.
@@ -270,7 +276,6 @@ struct btrfs_block_group {
 	struct work_struct zone_finish_work;
 	struct extent_buffer *last_eb;
 	enum btrfs_block_group_size_class size_class;
-	u64 reclaim_mark;
 };
 
 static inline u64 btrfs_block_group_end(const struct btrfs_block_group *block_group)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7b7b7255f7d8..41f1507f460f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2104,7 +2104,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 			try_again = false;
 			reclaim = true;
 		}
-		bg->reclaim_mark++;
+		bg->reclaim_mark = true;
 		spin_unlock(&bg->lock);
 		if (reclaim)
 			btrfs_mark_bg_to_reclaim(bg);
-- 
2.51.2


