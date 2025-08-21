Return-Path: <linux-btrfs+bounces-16243-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F54B306E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 22:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82A43BEB0D
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 20:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC3F3921B0;
	Thu, 21 Aug 2025 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="gNRTtKkd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EC391931
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 20:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807683; cv=none; b=JplxwKP5PAHvKEJLgrmhbvgiyTH/5Tg2YaizKpWOPWC3Efvk/teJIxVXvtNdY/tNKCLcf1NwM1/8n16l6R9L6XVm8APqne7WK8AfTDxbI2hTZhJ1OEUrHGXffO9I39/kQq6hoXL+sz3WxXInkydeBH0z3J448fmb+VD8EeikLoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807683; c=relaxed/simple;
	bh=x0LPojx9IQXc26jVCUZk/B2yhhxr/cir7ETQSThbsBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/9LzcNYzCy72oNRWhbH4/O0Fcef1fzYjj6+ijgkezoVKS2s1HMrrjnYAb9be5uC5eJfeIm7ob2crXliTn9fw15ubMKpZ2hWAvEi15a6UrbjOcJEUHw9xzsEMtuiqk4HHyZ1U8VPwUiYzNx7qzwHgqqPOYdO/480HDF15IIXGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=gNRTtKkd; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e950257b9b9so1428277276.0
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807680; x=1756412480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tNYt8ttislOZxvkBkAGWr4O/dXYuvufQNUeuNOJLG/o=;
        b=gNRTtKkdMvkvxvuahbNvL3tjJvNdsEghXxKMzPuhKSWuvyDSi5gLeJ2CXTVhEm3Aae
         0XaQXGRZiTQHP2JD4R2r4D8XyGwqwfx2cbP1NFthqGxHRHDOaTlQWo7O2TPi0un7zFiQ
         yw2YgbOz+E7nrMioLhlpsbE/ZVFrf6sq+hDesa41SQJNztLdAhIAFs3H3gsvr26Q4eSO
         knwmYkJhjJX9FZlDHf3U6jJfai3yJLdyaCQNXqV/UQkK88hztEuKIuCF93KTe/xOm+x1
         1NhfuFnYqm/h96WDvmzstVrPHD/EaNjM43VRExbypaOYNu9Oo1Iq6mnFnGICz846JACf
         B43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807680; x=1756412480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNYt8ttislOZxvkBkAGWr4O/dXYuvufQNUeuNOJLG/o=;
        b=IQ4/G0JXQDxDWaglAF9X+q1pWN7nRF7sxb0IZR7TW1Gn2AzgcInDXcbGLV89wcjg9I
         0WS+KI+DZTG166owHVBYjrLOklDX6P2S5vzKhjjCD2cVX5f0L+flrzk8g8gK5o+DN8Wb
         h1Vgr/MTqNNE4XzXDzMwtvbz03n+xuacyqa3ba4J3uS9D0EKKu0LmJ4yl/uTku1naBsH
         Z+NUlA8N0mQsBt+1QhNE3R+XO4N3KsiPTMlbrGe7Kf2U8p8Y/c7xLnGxa81WZsGoRAz/
         UHVE2ig0C8F0RuIlH3tE6UzR2S0WnlIVS9l8fB5qHv7eLBERAfDtcgDzw8DIAhbm7PyS
         x4GA==
X-Forwarded-Encrypted: i=1; AJvYcCUPORjoY5gz2Q2ep0bddoPcT/hYzkBbXEJUX4C0ugjveiBAN67ykmIBHYpERPda19klP1Jy//gIeN480g==@vger.kernel.org
X-Gm-Message-State: AOJu0YycA8L1yjrV0k82mtOP0y1Z++0YfDjkF1OjGfn2eWd/YUktjswc
	T46zGX/7Ct84rdckgjmPHlcS0K3RrC/iQ/03qAV32j4pa3BLoFsBtve4LDTN9OziU1M=
X-Gm-Gg: ASbGnctU7+Bka/bvv1dgYjtD/T/km5iYa82SdaGAq6iKicOBK5z7KWaQAYeuF7i+f6W
	PDKaHDpFMpvO0crLRz13eCH60Fne4phpNFnZlhqdMajFTlzctNwb1vTeptqG4YUVsXdK8EiD47n
	DZCn3OgUoWE8mKumd2ZJZN9Qpy3zpr6iAEfbThYF2o07mOofUuoEtrCPGjf2NECGYQcXT8x00I7
	nv+22h/AsVl6uDq1oWN94W/q8YO7yjqu66hsLw2Qj91qUwc4qLykNo7Q7V8ty55lzoKltT0+qeI
	Obw7Kl67Z2VtlOFTjewdTgy9ToSZ7f3ewnHseSvUd0vq8VUzZeika+orNldySt8Xt/QNZoXjVbZ
	RewYgpFWFo6gzRoRvwegn1nzNd0BGqVW+rnpOZd2JinyEw+DtviJDzI6WncC76B8IqPCiVw==
X-Google-Smtp-Source: AGHT+IEdC0jxj0VQq2eeW7F/rssUiimWnvaXknuXhDlY2cRwdeuJW2P1Cj0gPVf99SnzHF6lzwYwTg==
X-Received: by 2002:a05:6902:f84:b0:e94:e1e7:fde with SMTP id 3f1490d57ef6-e951c42b49cmr876849276.52.1755807679876;
        Thu, 21 Aug 2025 13:21:19 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e93456fa756sm5217858276.30.2025.08.21.13.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 42/50] btrfs: remove references to I_FREEING
Date: Thu, 21 Aug 2025 16:18:53 -0400
Message-ID: <36185d8a18759d2ed86fa6a0d45ffc61bce82571.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
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
index 03fc3cbdb4af..191ded69ab38 100644
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
+	int inode_evicting = refcount_read(&inode->vfs_inode.i_count) == 0;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
-- 
2.49.0


