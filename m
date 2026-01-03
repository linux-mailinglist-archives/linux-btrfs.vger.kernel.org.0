Return-Path: <linux-btrfs+bounces-20089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D242CEFF57
	for <lists+linux-btrfs@lfdr.de>; Sat, 03 Jan 2026 14:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316D5301B2CA
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Jan 2026 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC342F6907;
	Sat,  3 Jan 2026 13:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8uwYsh8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825CA15A86D
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Jan 2026 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445604; cv=none; b=hA9bMnXQfVQP0zsdEDqiaZpUWA+nreDsw5uQYAtdzjKytV74HExqssHicbgYCXlX+nq9M0Yo6tnTymWFGUhWx5u/j9prRpj4yeWIXW/AXEYt56eCHAwFsoitpT1RTzUK/rAkRkubQ7mA6cDhdjItHTQNytsMJReoAKLZCRxVS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445604; c=relaxed/simple;
	bh=Wc2Ayl8kYzVlsqITtOEb3SCtKLI36jri/f9TCVVDdX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pp11yD0vYsQdIenCNgPN5XsypkaYX7XjU35s6AyZsdonpRf6lQsSMoIoPq9M4s1b8ZS7rJMgKVtoszDWemjyXWUWXh/XLNAzpmLEyGwuoQpQBKB3F/ay1ZhRoAnYymb9JF1q0R/8jBXfmDDLJyQmc/+pkoIMtfHyVQ7u7ubSLuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8uwYsh8; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-78faffe6ce0so4125797b3.2
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Jan 2026 05:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767445601; x=1768050401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORMCU5j8d3VJ6QcX4yF8o3pbZb2v63Akw/l35QLMUEU=;
        b=g8uwYsh86mh668C8QxOj9rmQnoDRnG8RS1rI41BjVX6A0LaIi1oecyt+8L0NMrn/9P
         6I+vgwovGWh8xRooB3ELGuOjwvP7g/YRIKwAZ5chqI/sJ7RTe1n1vUWHV7avUlO+j3YE
         nJaZWmQlyskU093wTADFRUD8/12l8Mfi11Coszeamy7svBwEpXBbQC7L0YRMEnscr7MZ
         O7Sj7KWl94KgFwxciR7kUWkLxGspFbtQ4yaui2qcLmUNeiNcUfRpIA3wsmvug599QM7o
         TiYsJrLfeJ0ZKvp2d6n3sjfHqFGKWHXRz1l+xr9nQJAu6iwd2tHxEx+mMadt1QkHEZMl
         1lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767445601; x=1768050401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ORMCU5j8d3VJ6QcX4yF8o3pbZb2v63Akw/l35QLMUEU=;
        b=usw9poEdL3suo78YJyUjIwPIyZrUuVPPEwrkKLQO/DY1vzSzKRvv7XRYn6CKQnrx/f
         i/eGvZjQD6cmuSMQt9tu9y1DFIOObrwSVmj+SXxR0MHlww5gS6f35hRfUwwkN7Y9Gw+f
         TEBJ51t0SXPu2vWLg8d6S9DzLcG8ihfhlwP4SpBdkMu5IJ+t3B/+hwjPdufljOBpTFEC
         pFBOkdJa62uyuQ43o0ci5n501h5E7uO5lawMsFw+9RIN7P/zDkiUkuJ22CTP3nhKThpN
         PrJ9vKiOZOvOBt6tdj2wJhwwO92cCcpsGwt51t8zDLgQV1SmrofKPzhq7Foc2prP1hU6
         nnoQ==
X-Gm-Message-State: AOJu0YxWz7KDOAIC6PDlpc9BDRYdYKLXYG6LSAkN+hwl+VP4z3ZS5jUk
	orVo8jAiN7VCH39A1Rx4AMSnkUBUg4Lec8rg1VqacHySHQKoeh9UlgKisEwsCsUnrv1kgQ==
X-Gm-Gg: AY/fxX4xo9JLdES0n03NzmzahcZPqP7Cc9A6d/l7QXDGltH1+npUvnc9n9DTGfsc8HU
	nUnCiDMYdUCLpd+ttHePEQHmShJBPHp/UBIdtpoZBdDi2AkKdpUhLPXXcSxKJ5hD9tylnl/dhoe
	7SLFhrEPebox3naA85q0eTGGGWJorJlPRK5pH8ikat0neEDiISugHMu+fb3t55OTEwopLpbk/Xh
	58afJoOuUPlUqE8/54w0dTl7mcl4Aw6CUp2JleSwdx++qRtWrt+RfWvJR7CBy5AiRDeWFOA+JV0
	Br2DC123i4aeiujYMNR6ZniDtmo/1mZ6PYYiN5khfHQWExKKqn2PYzdPDtDfdorJ1QDTXUDxmb+
	4nlAmjN3cQf8+SLs7vT+RHCELLOr1QCL3Quu7/yZUCewVUxIWh0A21rZo3DeHGWLBoooasivNDM
	+XMnVBjzvlbfjd2cgoRsk=
X-Google-Smtp-Source: AGHT+IFKh3iE7S2gdLbmmgebTur3Yrh+BhIkNQNmct3TpVsS5ubGhjx7Fmvlk29WVe3cvBq3NJs0gg==
X-Received: by 2002:a05:690c:c507:b0:78c:2c4d:3df9 with SMTP id 00721157ae682-78fb3e6940dmr322230537b3.0.1767445601328;
        Sat, 03 Jan 2026 05:06:41 -0800 (PST)
Received: from SaltyKitkat ([193.123.86.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ffebd2690sm112554957b3.15.2026.01.03.05.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 05:06:41 -0800 (PST)
From: Sun YangKai <sunk67188@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: Sun YangKai <sunk67188@gmail.com>
Subject: [PATCH v2 4/7] btrfs: change block group reclaim_mark to bool
Date: Sat,  3 Jan 2026 20:19:51 +0800
Message-ID: <20260103122504.10924-6-sunk67188@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260103122504.10924-2-sunk67188@gmail.com>
References: <20260103122504.10924-2-sunk67188@gmail.com>
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
index 94a4068cd42a..f29553fa204a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3728,7 +3728,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
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
index 3ccb365549ff..dce21809e640 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2104,7 +2104,7 @@ static void do_reclaim_sweep(struct btrfs_space_info *space_info, int raid)
 			will_reclaim = true;
 			reclaim = true;
 		}
-		bg->reclaim_mark++;
+		bg->reclaim_mark = true;
 		spin_unlock(&bg->lock);
 		if (reclaim)
 			btrfs_mark_bg_to_reclaim(bg);
-- 
2.51.2


