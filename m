Return-Path: <linux-btrfs+bounces-16411-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30A0B36ED4
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E219836CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DAE371EA5;
	Tue, 26 Aug 2025 15:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xN5y2SSr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502E350851
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222916; cv=none; b=pgXHSYNcKhUQP7bZM+gXHu0CJpviXbsP+Z182U+ugvAzGYcpsybsobX+eOcnycxSZ0jL7C3lVTX+vbF9VK68wOPK2F9nUI4EsMFRUnneYkcDNL10aGMMRsHvEDYP6snMDGE75RlyCgnLqjZFj0+8tD31fE54m46ucu9+0v0WrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222916; c=relaxed/simple;
	bh=15ZHaqifmUtXWBqCOA5JgpHFW/qiYG0R+Rgr6AbrTT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM30xFtY0jHOmaSrDe4T2yfAX1KOQfQsJHYfY/1PWe1uCs4STtZEHB4BPK6U7xn5/lEMf0faauetRsRzla/EtHKHeU48bguB/d/uQChpd6fAvycBCSFjO5U8aF1nIjQncOq+lB0eIL7SeiKizJr9BN1nZhbv/bkH6xAjqTh9H8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xN5y2SSr; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e9537c4a2cdso2414976276.2
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222913; x=1756827713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVly6FxrnKPpCOutqFXtYnP9ubQ0AZJgXeTB84dIAZo=;
        b=xN5y2SSrcEr+y4YFjJrz/CqWqxmKDdbxvfMtq+eNSmraeQTtt3+Blc7gLZ4VUS2Ppo
         dXq8glu6chYeLj14rqGrlouI3msT7/+wS/zWRMPA5fnCC6t8TWqd+Kclk+kMeBZCls+k
         iyl+zHki8wuQKgexcSE7zDjRqFSuni6vOga+TRELBJly2hcT8ssQekSAjKYAQYuYZd6L
         ApYMSYho0CKC74ifJqUS5sznHVHfDPEam/CIcuxr56csfYc4ZQcKWS/9UPgkkx+V13ge
         4dQeTroBSNGpHdzYrUpIhn3jqO1wryoE8XdSTfefRSF/4zap7NRUe6gkNmpW9qjJpPlO
         CgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222913; x=1756827713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVly6FxrnKPpCOutqFXtYnP9ubQ0AZJgXeTB84dIAZo=;
        b=BH8DiyJZqg83GUNwsCrR+Ad1cIIiNzL+dwAxxsho2wd8h8BUJlEeyzBhKNHCm12g8t
         MtmJUEDsXhnVBW0M/Of8UUlpfM0QcLsGUb4m8mY/wTiFVKwlRRGocJ0GgoZUnzCmAp3G
         KkkS99LSN2y7EYVAnXskWtT8RI9Fg9Uii5sl0nXBQsc2V8xv8s+MTNydANe0nBGSGA1m
         MdwG+O8pM69K2WyIMuvQ5nnY5kysNsQul4h2hPNTsPqW1SCOZ7TZdrFCijqoCQHEQU3B
         +GK1ZaU29DIDMvlzJDAriXmUgUB0otAxM2+XATpNBoYFTUg5AiOFVQ/u9i8U6GaYVaHa
         boxg==
X-Forwarded-Encrypted: i=1; AJvYcCUYrrD1XpGjjR8kNWe4tlxbNMUXsyHyzSfp/H5vnGAtm9jTtreOFxdDtk3s7hXt/20u+tT4+daglKqoIA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3h9nRj9Ma27oC/u5vx3wlH1V6hpVrIUCoKZjGssm1Ef6kJJ81
	KaqiIHZYDWvQ7YQHHo7B5RqGMTu8F0ulII2fdNnGHwM3P7hMxphalUIMhwHXLsdNmwI=
X-Gm-Gg: ASbGnct3cCCMXnLdFMVizOI0xAKKtG8OdNowolUyI9Gg6PC6S6sb/FZyWA3z262WtJn
	SdHa85RiJCNQdd//ZVBXD7jlTzXYG62EnoEA5kaHb+XB8f2wpP6Xa85zo/g3t+QIzLHGquPPqay
	SLNmvN7JnAxRM487ON8u4xVWgO2/hE2IXrVGzeWGv7ZeDyv5S5wG0O1qdow020k/n6JJ570swCL
	qtNHm0kotvU3seYTusx/gChDMr4+KAgKtslQW8POLVBdFH/6V7Bt6gX6ebXykWT1+raMrnnrh2t
	Z35raUBxcqYrgfYvL532D4raFe9uIB4bNNnhsqN7j8zgR531n13B9Ymkiba687QXwK+hJjoeHTm
	ytRR8Ho2YtuowruBhjCfwr80VcehYRYnGiQg0Z4mpb+8j1dL/bqIFMvu1qCjW6RiTIxD/lw==
X-Google-Smtp-Source: AGHT+IHs9eajH2WM3NXgIzvKjebg01fyf2ACuZ9khHqmbOf6soY9xqnUvsrLiHhUDAZayHz34q7R/A==
X-Received: by 2002:a05:6902:f82:b0:e95:7f3:4c7d with SMTP id 3f1490d57ef6-e951c37dcf7mr18808774276.47.1756222913189;
        Tue, 26 Aug 2025 08:41:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96db453574sm890302276.9.2025.08.26.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 44/54] btrfs: remove references to I_FREEING
Date: Tue, 26 Aug 2025 11:39:44 -0400
Message-ID: <9bc7048e07162c9169f9b098b0bb7577749ce11e.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We do not need the BUG_ON in our evict truncate code, and in the
invalidate path we can simply check for the i_count == 0 to see if we're
evicting the inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 69aab55648b9..ea6884e5c791 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5338,7 +5338,6 @@ static void evict_inode_truncate_pages(struct inode *inode)
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct rb_node *node;
 
-	ASSERT(inode->i_state & I_FREEING);
 	truncate_inode_pages_final(&inode->i_data);
 
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
@@ -7448,7 +7447,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	u64 page_start = folio_pos(folio);
 	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
-	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	int inode_evicting = icount_read(&inode->vfs_inode) == 0;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
-- 
2.49.0


