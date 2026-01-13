Return-Path: <linux-btrfs+bounces-20468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE03D1B4E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 21:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E0BD43013D60
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 20:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613D7321F27;
	Tue, 13 Jan 2026 20:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Boh8UKif"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE23191D1
	for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337739; cv=none; b=psOWrcK43T0nmCYUINvnh6LUTyqmkfupGsYnixuhohkVyaoik6fUUDG69YUK/GhuPOFaFr5ADcMaZsgNxxOxH1spr69YW2QQAQLoLMa1tWNBPu+CQBULRz7nxMrcsFEcEeL53nVpYm9OwMMidOsQQ+5PAvFXJVfp2TSCHJmU0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337739; c=relaxed/simple;
	bh=sij+zoexnWppQ2ihhwPzrCR1FqbRGPbuFYgbLfSeL3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J36gNOKdReECqcvLAbS+HGodl8Dvpy/Amy6t4yelBYfHBQy2Q4rSgEbcp7t8p45znozvaeuS+uKkITowCVOY9kWFO/xuNxn7bMPdka+Z8IhyWomaCjBro8bY62arfKOuL44tuCR+kl2u9Mw6tVleSjYzz1NSklwWVRr7Rbsa+5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Boh8UKif; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-78f89501423so2857127b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jan 2026 12:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768337736; x=1768942536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g1ZsvGsx2nm1P4yPpEV7+WbS+tP/MjMFVscDshGg3U=;
        b=Boh8UKifb+Ambd+K4HEqec6AqBaQIHM2eL42UuErenNG2V5wyNbpMYPbV0+ouUbtmW
         yXN7HXULy8hCXuazpztUrousURijbhI3/ExRe5KuHThwcm0D3izcCBeHTxBMiGO1AUuX
         yS3j7lGh+R/x/C8PpFz9QRqcuulnCWds652jzWlLUNHgFiR6sR7Rjzpv5gJ5EJIhzReZ
         2h0bQxhNFrMB8WvCHjmzhv0kf2VqvBMryPVDaUtfvnjLo1jS6GLkCn1qjWU5W7HwfEWo
         cmea+jhmUAMR+DZ2SemzcS9r0/tcdhJ+YyTEWV7W8raOKDh3hfwyg5etkGzacI4Q6Xzq
         DEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768337736; x=1768942536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3g1ZsvGsx2nm1P4yPpEV7+WbS+tP/MjMFVscDshGg3U=;
        b=q/w0DtMZ6k42Uu4ugCaYX7sXjXxRD86MAvYUx9PggL1lj4zUWtqt9n/dBP0hQ4GfWi
         mAnKl9e80JiwOiNg+VPoDlKvWII4EAd4eL5Zs7b/KGTlW426zXNSadJpYV5ChIMFsio3
         dUrgI9t2GPdkU2vwYxe3VDysbDSyNw60xA8bay2cgC+v/llnQTKqi3bQXGy1V98gWXYd
         EO+Y9vwG2LzjqsBbYaIaDPPctNu+EIapmzkbzo9t1A4qdcztYFPyHBtEIQSTDe4wben6
         IiwVcLCVthzg6TkULPac9oY1t7AS0S0q+DHN68Uxiirtai8NQhcUN78SDhkd1+OwgxnB
         zh/A==
X-Forwarded-Encrypted: i=1; AJvYcCVqh+Wi/apcJX7jrw2EexlPBH1k6/1+OwFMAT6mfT/bezk5EAIKruxaRDNI24Hoh82AEudCa4wUek/H0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdoLmFDhlbtWEzhFlsRxP46AyfQF7A2Fs/bRZwNDHNc52hx9t
	1/cMB0VKCCn30w69B6I5JCYdpoMuOBsxkwE582qCG3tjwkS1F+3qvDEr
X-Gm-Gg: AY/fxX5NcRXNU7aw8CJI8ih1jcnXF3Aazwzlc/DeW2Ce8vevsd+PnU96DxThbs1ijvi
	U1aqa4TPts7obMvtUFpWirnpqqzC20ovAjYoOca0NjZOyLkQUjZVOVbTGZU8XSiu8BnSKDSFeP/
	NTj92wD/ZBhYX0BKFLo/KvApAzccm9cZEijBOWVL9WuP4ThAY9f96ORMyuEV01LsXecChoWyXev
	rDU88HIaD8uvamCLLu3wnoAegRNYXZduUD4SQq44tf4AhY0e+Otn0yc7zQrs4QXqmY0wO4xhaWd
	O5zUUYIxZTHhQgXTR0qH8otsrevx1hCGAjelH8hGpldEdSrbQoAaoobnCJucvuBUiwNukhlItzb
	J44Egr2RZYSyY6SfN+0H89RkFIrB+jtkQiWr+WHZ4rsiqiDmx5u3EEUb3Kf+rHGnKU2IVmM+HK8
	K7z7ocBeTShsEI0p6Bn/OpFswS+gp1Kj7r
X-Received: by 2002:a05:690e:c42:b0:646:69a2:d400 with SMTP id 956f58d0204a3-648f61f8d26mr3813349d50.10.1768337736012;
        Tue, 13 Jan 2026 12:55:36 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b2623sm9712831d50.20.2026.01.13.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:55:35 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: boris@bur.io
Cc: clm@fb.com,
	dsterba@suse.com,
	fdmanana@kernel.org,
	jiashengjiangcool@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] btrfs: reset block group size class when it becomes empty
Date: Tue, 13 Jan 2026 20:55:32 +0000
Message-Id: <20260113205532.42625-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260112185001.GA450687@zen.localdomain>
References: <20260112185001.GA450687@zen.localdomain>
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

Fixes: 52bb7a2166af ("btrfs: introduce size class to block group allocator")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

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


