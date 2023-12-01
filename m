Return-Path: <linux-btrfs+bounces-512-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA81801608
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 23:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E08A281245
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C4259E58;
	Fri,  1 Dec 2023 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TUJY6urd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EC7D63
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 14:12:36 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso1035559276.3
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 14:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468756; x=1702073556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBe2SByBGGZwnJKo5cDpxDIxZdLwl3MWb46l7m1eRCM=;
        b=TUJY6urdiF+q/GYGFcZ3OH9mhFfqDiaV484RDJqbhXZcpSCpk3qLrQAsWxBiRe1m4N
         nu0U095U4lnBGRejtqwW/BX3ocZ8gnJjF32qUhK4ppjnmhzHra1f/I3xwK9yalDr7SjZ
         6ibnbbD/Vtzqx1rVF8rab3FqoA2vqHICMXbroyI3KQ0QYbTil5rv+VT7wRWl+Ob5A/SY
         zwojZuQDbwS0yLYXeuUzkmotk2qyTGgezi+1kwt68dx30iTFEeqvWqRBeSLT48+c2hhJ
         jqDmIjV3p2k+bu4Yc1g+BlcJrwto7agkDFHFCAjTsIuwiZblVpwDGnu+Ghcm7AJp/PX6
         qhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468756; x=1702073556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nBe2SByBGGZwnJKo5cDpxDIxZdLwl3MWb46l7m1eRCM=;
        b=a7bXZ1hk0LVWjZop0BW2L2RGVwlDGibr8kkmMcZ8GF7TUYSpiCBFlkOHXV75rROE/6
         aljYryHT+FYlSkKqaYxq6/Ti70Jr8TuoinFzKLSlSZbUWzwo7KMnU0CRdYOCan4st1zj
         VBcABb8nLswZ79CsQVg661gem0aGA6A2ngsZVK1rpzCq4E8bjE0domM4kqUZppsLA0QT
         N0fhF6AehAarkNevrXrlYjhakJBqEQQsWnKtq2gVpj6P3vum60M0/1la6aYh1Gcsvra1
         4YffGR7xySDn7DrFxS3gHFxODmp2KULc2Uw3rEKLf1rOZRcpJklId8VkVqBCDhDxPPyV
         OsOg==
X-Gm-Message-State: AOJu0YyG3uMIDFLK2SEybssBCkS5f/JCXr8NQk+I0OktEViLQh7aw8lk
	7WPJuwjRn6AXiFIBjXXsjx0SnY6zvMWle1R4pW+3CQ==
X-Google-Smtp-Source: AGHT+IGLDjpnc3J07VZ8EZq6s54dsbVBs17DDHvoseuhxrchg5GwgyPv5+P5j1gz2qozr2uJUtrKbQ==
X-Received: by 2002:a25:ae0a:0:b0:db5:4043:77ad with SMTP id a10-20020a25ae0a000000b00db5404377admr326712ybj.56.1701468755763;
        Fri, 01 Dec 2023 14:12:35 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n75-20020a25da4e000000b00db7dcc2ab76sm21299ybf.34.2023.12.01.14.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:35 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 30/46] btrfs: pass the fscrypt_info through the replace extent infrastructure
Date: Fri,  1 Dec 2023 17:11:27 -0500
Message-ID: <c869b58206ae37b2127b636f147b1afedbbf231d.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prealloc uses the btrfs_replace_file_extents() infrastructure to insert
its new extents.  We need to set the fscrypt context on these extents,
so pass this through the btrfs_replace_extent_info so it can be used in
a later patch when we hook in this infrastructure.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 2 ++
 fs/btrfs/inode.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ba73171fb8b0..9eb14b067e1f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -369,6 +369,8 @@ struct btrfs_replace_extent_info {
 	char *extent_buf;
 	/* The length of @extent_buf */
 	u32 extent_buf_size;
+	/* The fscrypt_extent_info for a new extent. */
+	struct fscrypt_extent_info *fscrypt_info;
 	/*
 	 * Set to true when attempting to replace a file range with a new extent
 	 * described by this structure, set to false when attempting to clone an
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8bd5c7488055..231d9fe6ff8a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9760,6 +9760,7 @@ static struct btrfs_trans_handle *insert_prealloc_file_extent(
 	extent_info.update_times = true;
 	extent_info.qgroup_reserved = qgroup_released;
 	extent_info.insertions = 0;
+	extent_info.fscrypt_info = fscrypt_info;
 
 	path = btrfs_alloc_path();
 	if (!path) {
-- 
2.41.0


