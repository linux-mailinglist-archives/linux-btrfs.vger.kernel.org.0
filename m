Return-Path: <linux-btrfs+bounces-20408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0BBD1397C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1F0031E4702
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 15:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F262F2DF144;
	Mon, 12 Jan 2026 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy8SUOPz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB4A2DB797
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230176; cv=none; b=iWDrgYaWZwMrjyGNiK6qxaxld2ijKcySEgbFfHFwWmak6IDKt0qgdHy50l5MRdQ9EpTqqf0P8OOUiX1CrZL/6K8bUB/utFZLHlM2adkPR6WdRs0rYZxXjLfekSFqPInt/R801dksZHUHX0V5GgHRM8ZJKyosfpgU39MBSTXENWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230176; c=relaxed/simple;
	bh=oaj+1KQRb/TnihudJZJAP4TYRAcFQBAu10VP3WkIu7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQz5hYqyRQDS5cyTlllFnX6wPwJIgMRyNjrawNFQgjQdk0+cGT9m1D9CTkj6BkC96yuUUG0Nhnekb3MomuqW5oOE9Ja8ygbu2SwVbDER1LjTCR6T+0NjuOKLA509VT0L+TNr+UCiDqWeHZLiTYJkKPpVgabg53roi/SQkEHmj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy8SUOPz; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7c6cc44ff62so5221515a34.3
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768230172; x=1768834972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQbUZBlwnVIE/0tOVdzdzTy0LaUN1JEnxmyyVOiPwHw=;
        b=Vy8SUOPz+zy/BU43QGnC4VYKoiPsMyLhM3GPepeGlyY/plN82D3buH+8WX0ZXn1IrP
         EuTmwJowxEZJ0UanM75aw2Z+kqfjVKZkw1iBi+Z3TkR78vzh78t89W5UJlOBhkeS8BsC
         0vD4bpQYgRMPiTKb5ja/NL9hYwn2oKa4Maj50JLYy0dn2+kIEa/qcik9qq3QHS6kPJBT
         Q84JhoWvAOD1Yj7e1N0ywOnC6W+aY5sKb2kAsco7AkeYLT6I3jXRLgUbrGn25b+wQ4qd
         UwdO1304sHFpKGrAeIm6WC81X5rdlXXKfI54J/amL+pEIRQVZBAWlFBwHcdR+OOlt5HP
         mnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768230172; x=1768834972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kQbUZBlwnVIE/0tOVdzdzTy0LaUN1JEnxmyyVOiPwHw=;
        b=qNkXIFURMW0Q6gsojcoZYXsMxKLUotgXxrs7imHmENWSzPyy19mB8OY2D/llIurvUu
         ieqY2uB42BFT1kpiGmLU0KUYhqnvPzdFji3RtXApsxcAP1jPcXC+cTlQrgn8+Y3RdEBT
         x8sN0D1eBpn1+4x5jI3yyB0lt+Oae+S19iLtb/CwSJOPrhG2qH6h1xsFKcoaF+tz1Yq2
         hodXDzThTJIXTooofBR6mK2cEbZvnNl8HLV7TpwslM/g5p0tsWsk3uirz+2hhbadhBzC
         EhxKmYoZOg+rN3WJZdWal23OWpIGQ2+IEnKAuApSxgePE3qFEPuouSlNpEK6i8TItBVR
         DX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWq/7sE8ue7Wy1lMg0f+Y4fsqqqo/+iJmSELX/YEbVnX2k+U43L/CuV8HuMjNF3sSdeE03i27pBzZv2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHubv3Iz36ZGu92Z3rZdG07iriFLFEFa1+GXGGN8ceKyaEHPNl
	OE8+EpmA5PGulpTKEXYPxuuKpzh2J3VzFnPf1Pkg8J55ZL+BYTRMb/Yw
X-Gm-Gg: AY/fxX52cLwqTAD9+riRWDsnbbXVpy+njEMXfZp11sIjnJfH7t/aU8UGk4vJUiBFhSA
	pYlUta7GQXRkNuKXjMPbXniJ7xOeKLeDP6Nwjn1m5yrzs5ggiL9CtidMNYTl/SabEG/HBGiRCVc
	kkV5xZB9BsGkVkgfH38EtaE8rNrc9AJQsJCZIaEX2RKc/7a0MxQXnjvipBufu0/0aQzOAaSqK5F
	5IHHBIQm+Zx50OyVtjEtto26HgXxpmcw1AF2gqVFTq7HAmmWpOf2h86ZOKGwo8W7XXpLtbr1jsM
	evd0bWe2k8d7mUi58zw3yAUoK2bDhJ8PtVF69LgXdVkvwRW9sXrryDqv5dKgaFXcRyhdLqOp8Qr
	HJE0yrO+P5mYob0bsUzx8jRznFkWbPIVHR1xTp5jvyqOgerQI6JBagYnqd2FEmEtylCKGGTZOcq
	CkqPMnkHZycoyx4V280zylHGZ4y8Po1uH5
X-Google-Smtp-Source: AGHT+IEQFur2qhGuoz2oKzCG1BeyVo4cXFujy/+8zzGLBZM+Y/h+R8u/nYyCPEY0B8NCAByJnQWVzA==
X-Received: by 2002:a05:6820:1613:b0:659:9a49:8ea2 with SMTP id 006d021491bc7-65f54f5e7f8mr8630491eaf.38.1768230172463;
        Mon, 12 Jan 2026 07:02:52 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65f48ab2d00sm7311748eaf.0.2026.01.12.07.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 07:02:51 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: jiashengjiangcool@gmail.com
Cc: clm@fb.com,
	dsterba@suse.com,
	fdmanana@kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] btrfs: reset block group size class when reservations are freed
Date: Mon, 12 Jan 2026 15:02:48 +0000
Message-Id: <20260112150248.32570-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260112143523.31542-1-jiashengjiangcool@gmail.com>
References: <20260112143523.31542-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Differential analysis of block-group.c shows an inconsistency between
btrfs_add_reserved_bytes() and btrfs_free_reserved_bytes().

When space is reserved, btrfs_use_block_group_size_class() is called to
set a block group's size class, specializing it for a specific allocation
size to reduce fragmentation. However, when these reservations are
subsequently freed (e.g., due to an error or transaction abort),
btrfs_free_reserved_bytes() fails to perform the corresponding cleanup.

This leads to a state where a block group remains stuck with a specific
size class even if it contains no used or reserved bytes. While the
impact depends on the workload, this stale state can cause
find_free_extent to unnecessarily skip these block groups for mismatched
size requests.
In some cases, it may even trigger the allocation of new block groups if
no matching or unassigned block groups are available.

Fix this by resetting the size class to BTRFS_BG_SZ_NONE in
btrfs_free_reserved_bytes() when the block group becomes completely
empty.

Fixes: 52bb7a2166af ("btrfs: introduce size class to block group allocator")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v2 -> v3:
1. Corrected the "Fixes" tag to 52bb7a2166af.
2. Updated the commit message to reflect that the performance impact is workload-dependent.
3. Added mention that the issue can lead to unnecessary allocation of new block groups.

v1 -> v2:
1. Inlined btrfs_maybe_reset_size_class() function.
2. Moved check below the reserved bytes decrement in btrfs_free_reserved_bytes().
---
 fs/btrfs/block-group.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 08b14449fabe..8339ad001d3f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3867,6 +3867,12 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
 	spin_lock(&cache->lock);
 	bg_ro = cache->ro;
 	cache->reserved -= num_bytes;
+
+	if (btrfs_block_group_should_use_size_class(cache)) {
+		if (cache->used == 0 && cache->reserved == 0)
+			cache->size_class = BTRFS_BG_SZ_NONE;
+	}
+
 	if (is_delalloc)
 		cache->delalloc_bytes -= num_bytes;
 	spin_unlock(&cache->lock);
-- 
2.25.1


