Return-Path: <linux-btrfs+bounces-20372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FDDD0DD67
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jan 2026 21:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A160B3028D5A
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Jan 2026 20:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E506228312F;
	Sat, 10 Jan 2026 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8EMJTE7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C5500966
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Jan 2026 20:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768077226; cv=none; b=g1C9l2wTX57bnM8Hwh3KGPhEMgV17BENsfqETRX2TFyC+9HP6HpLnm5TPdrXs8WkciyFm0IKbRENMHiflQgp2d29GzYaLAM651Wt5AYLTURCgXjsxQWRS6dElpsIauZUAQqBsWK1d/mVpo6lnQ9n/SzBMVCLQH9h72s5Tkllx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768077226; c=relaxed/simple;
	bh=qA4Qh4+2GHwSNaTQLaDtoV60/NRTMzxmifxRYVm/pQM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sKrBY/V73XCwxtEAY50ru1TyWpPhiP2Ug+rvrCugXbq22kzMhj7v36zR15BBdrVgJuI3ilOrQnvtv+ac1vUt6xcE9CAIIxcYnKEbglXyjDmN+VLDr9ylrI0lcDh4P2VUMLFHp0c5LYVMFSe3jsHTpi8waLtrBBOUNgV9hPcGEMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8EMJTE7; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-79088484065so54362507b3.1
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jan 2026 12:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768077223; x=1768682023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7jyLzqOg69IlsYf0ayGsuQaCXyS420tWXAZAo8eRZCU=;
        b=f8EMJTE7Htl2MfzKNnDBtfxSGfPDsyFy0hS4CfRu6WrNGKQNKKmRxevmVF85hxtjps
         tyTnOsHLvhg8OIHb5/dT6jboMoV9h5jQ2GRaJKG4KACT9o7KFv0jdB85JVX502QzFd4m
         6cw/E+m9Z71KYbCogVorZbPBfGc/sKDOQQQGbdM2Y/QiGUd/MbmawoQPwOMk/n+4V6uB
         OQuwnPORoqXnjpOA9BXxzRRQv8hQJT4f2669bcVeCURhHshFl9JLNO/nPH6mrdccyE99
         oYCzYRS5UGTs3r3uh9mSui0zNLFcwUFNMKMl2y0alCWFQ621eyuXBGVDf8Fbxolm/1JS
         kbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768077223; x=1768682023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jyLzqOg69IlsYf0ayGsuQaCXyS420tWXAZAo8eRZCU=;
        b=ppdH3jsgw6ng8O3yI8PNH8/6NrWWTd0CDL1MR/Yt6nQilzAudWRwGSyeY19SRF/X7P
         qHF8RQAXcFEU9NeDTmqlclRHsq7o+d4hkMmSOb0thnjhgAulK5HCaBV7rHvOInC8V0Ob
         tVMQGOS8J2LfgRlDV+yw6IDElQ3BYk2tYdCQdBZNLek4egAChXuJshmaqzMVjEGcNe+c
         C5Hrwq4Q2HP2AvWo2unEQZGHXlLWOJNRJPQ8hPyX4AOXPH7UYb6AK2uIRb4pJOSNYkb1
         5mEoVpYkKgHwq9IvVYZ8Z9o2/F9xPAkB8+g565kskPoDMkvjx9Ep2TYgSzAf/O9YYoyj
         KXTA==
X-Gm-Message-State: AOJu0Yz3uRLCYTPrRdTXjd4vM7ljSHa84Z1Ecn6VKH+Ksx7G7hSkGm4z
	3IEuaei3QyV425o40lQGZGRfiG8PD8agGOtx/ZwrHZ71P+BA9k48jHwb
X-Gm-Gg: AY/fxX4IPn4xPOSOHp2kqDYb2iyV7Zqd+p1U7bjgrLl00o9N3JtOZKRiEKwpRHKxGGR
	R7Sl1gJcU7BV64HTot2y6i56Hf8VMPoRTVKHMahriTLSjqBQZHMR8mADMfL2j8gjZTCwB60z41e
	xASr7VD7cV4U/PUq9o7u254Nh6AZBPlJWx1q7PVpTYdbWX+okLvFMO3sqXptJjvLIIl7UIZAUs6
	BXEguWAulF+khx28pMqjNZSHvUz6xNIE6yNd7XCIvWPVFSJCy52XKxjSgqyWKfi8ZovSdIuQzZa
	J8XMrN6+BI3/5oU0SvXEbDRWKXn0+LPFc6YOynfH1TxoVZsA5drttqTpUMYAA2ULVJrFxPX4rUp
	V4RE2GQoAzKA+BgSkcnlemmyqG4DEO+8UYfd+nyVl+nY1uI4MxGd22j0iUWm2J8SBFwWqB5CCm5
	vzLVl/eE1g4PEtqLjjHeHSjQRuNoykBd0u
X-Google-Smtp-Source: AGHT+IHP0DwyL4sk124vfJjhzyvVlvegUoSf6mDk2LmtqQEqZeGr3f3ysWRLuFO2Hb/poY5LFANeCw==
X-Received: by 2002:a05:690c:7349:b0:786:5afa:375c with SMTP id 00721157ae682-790b5857c92mr264232327b3.67.1768077223138;
        Sat, 10 Jan 2026 12:33:43 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa5762f6sm53927017b3.15.2026.01.10.12.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 12:33:42 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] btrfs: reset block group size class when reservations are freed
Date: Sat, 10 Jan 2026 20:33:40 +0000
Message-Id: <20260110203340.12443-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This leads to a state leak where a block group remains stuck with a
specific size class even if it contains no used or reserved bytes. This
stale state causes find_free_extent to unnecessarily skip these block
groups for mismatched size requests, leading to suboptimal allocation
behavior.

Fix this by resetting the size class to BTRFS_BG_SZ_NONE in
btrfs_free_reserved_bytes() when the block group becomes completely
empty.

Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 fs/btrfs/block-group.c | 11 +++++++++++
 fs/btrfs/block-group.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 08b14449fabe..1ecac4613a3e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3865,6 +3865,10 @@ void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
 
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
+
+	if (btrfs_block_group_should_use_size_class(cache))
+		btrfs_maybe_reset_size_class(cache);
+
 	bg_ro = cache->ro;
 	cache->reserved -= num_bytes;
 	if (is_delalloc)
@@ -4717,3 +4721,10 @@ bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg)
 		return false;
 	return true;
 }
+
+void btrfs_maybe_reset_size_class(struct btrfs_block_group *bg)
+{
+	lockdep_assert_held(&bg->lock);
+	if (bg->used == 0 && bg->reserved == 0)
+		bg->size_class = BTRFS_BG_SZ_NONE;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5f933455118c..7e02db8a8bc6 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -395,5 +395,6 @@ int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
 				     enum btrfs_block_group_size_class size_class,
 				     bool force_wrong_size_class);
 bool btrfs_block_group_should_use_size_class(const struct btrfs_block_group *bg);
+void btrfs_maybe_reset_size_class(struct btrfs_block_group *bg);
 
 #endif /* BTRFS_BLOCK_GROUP_H */
-- 
2.25.1


