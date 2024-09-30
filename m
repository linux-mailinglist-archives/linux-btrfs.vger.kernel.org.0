Return-Path: <linux-btrfs+bounces-8349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A33B98AFCB
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2024 00:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272431F22D68
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2024 22:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FC5188936;
	Mon, 30 Sep 2024 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlNMQEFt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D95185B74
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735097; cv=none; b=ZY5uCLBj4SFPg3lLscvfBayxYmbnzsRp8TOPSN0x3PqVxWUxvcrUKxm5u/Z93ycPp54q4px4Z746tsZW1Yr/OF4m3WO7xnt12sXPcaEq0nT0pAI4PJ+PA72GvXSNTzQhG8HK24XoKOZemg8gIaDTZFsz5Ix/GDsI/e1HdZ8Tu50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735097; c=relaxed/simple;
	bh=T7ETiAYYwO2IRRdpqP3lY2c0fJdbsp7UdfCCOGCl99c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enqUMOhtNl4LRsduKB2/1/dRSLjBLWP0MJZJpbqA4QfqAL7h2+OUoBDRD7lpjo83FF8yJ00oS6OVcy82L4wEyU84ShVVLQO2mrlPmkpPp0s6QqsoQIWaxCxEuOG65jiigHgGDFdYkxWL5RmY9Uv2wXax1XkAN0/qvsEhmLLX/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlNMQEFt; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-27c90f1e968so2700718fac.2
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2024 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727735095; x=1728339895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3Ki+4RA9p/lxY7Rnyqn1WuFg9uJtzpkciK4fI1mMlM=;
        b=AlNMQEFtjiJPYbfzQ9Q1G6ySvLVzYRlsMnKRdCO3nDMuxYjikmaw6PnuERUFNnDPwF
         zvnr/sy+S4QPiK2rCo/xD3nr1KTf40lJDFHqQAraReA4/v8gDI3MPR5Jce8kPJR7dZ5i
         4U3cHTGBnwNnlTqyUe3B0W1pbI89z1vk8TfGeazcJ/fniDuie4L4NaoqjCLejLXhGYrd
         HwyBHYDPdzwHIBJP8Juk/cJgeULMF0zczoEprewbJkW9y9kEpsWYOprOIuLB5fULICVa
         ZGPEjGznlUz7H7iyA3Z370WRW7HNj5s9AXNCXiM6pmosyLTH7tOxgm0dtNRAh+N9f1HU
         UEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727735095; x=1728339895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3Ki+4RA9p/lxY7Rnyqn1WuFg9uJtzpkciK4fI1mMlM=;
        b=Bt4/CcmOViDLfKdOyjboqR3dGhXjXITFymYsVpznIXPz+bwvnU20c57cjlOmOh9giD
         5KK35+rNI/Nx3vKF8wPvbHiDjRiOFdrcCDCo8ndPTkXnlFBcTE4yJ1A62Hid7Z0MtXbk
         0673DkPmq+/qZp314xoTxQwsiWDElqQUat3ZPj0LJ470Tw1Cd9OV4p9VoRcpaNl0UWTW
         OBNHUAkGVo91YqHI0WOEyjLXMAHYq/tg5mAQ1JcGy2fVts9IzUHYuIGTwmKbbi5PWgPR
         fJXEVSqGOVt80lZuqJlpj9wGo+vANCJg8MebaqEdJ3n2UBcpk/GOqs/44T1HR9FRyJ2M
         8F5g==
X-Gm-Message-State: AOJu0Yy3Yu0PwAr0qlJ086MQq3RKqF+3+rNk/naSBFDEjLfPEM8hHgKz
	L5iXKw6Jc7P9rCJ6WQijPcfDiyFJ1VGE6GFRtZRayChzYlurasEx+RgOi2x0
X-Google-Smtp-Source: AGHT+IHOzcslNNXw6kYX5ycxP/MhbM8WhFNxlp1EtOUTAohfdNgsxJmAM3YBK7pwJ/4Z1j7WLwIiPA==
X-Received: by 2002:a05:6870:289a:b0:277:eb68:2878 with SMTP id 586e51a60fabf-28710c2a304mr9951226fac.44.1727735094775;
        Mon, 30 Sep 2024 15:24:54 -0700 (PDT)
Received: from localhost (fwdproxy-eag-116.fbsv.net. [2a03:2880:3ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2870f7d5165sm3024837fac.18.2024.09.30.15.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:24:53 -0700 (PDT)
From: Leo Martins <loemra.dev@gmail.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs-progs: remove block group free space
Date: Mon, 30 Sep 2024 15:23:11 -0700
Message-ID: <ec4b14c022f987227ca8c7b004af8e42c981f3e3.1727732460.git.loemra.dev@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1727732460.git.loemra.dev@gmail.com>
References: <cover.1727732460.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the upstream equivalent of btrfs_remove_block_group(), the
function remove_block_group_free_space() is called to delete free
spaces associated with the block group being freed. However, this
function is defined in btrfs-progs but not called anywhere.

To address this issue, I added a call to
remove_block_group_free_space() in btrfs_remove_block_group(). This
ensures that the free spaces are properly deleted when a block group
is removed.

I also added a check to remove_block_group_free_space to make sure that
free-space-tree is enabled.

Signed-off-by: Leo Martins <loemra.dev@gmail.com>
---
CHANGELOG:
v2:
- Added the check to make sure that free-space-tree is enabled
---
 kernel-shared/extent-tree.c     | 10 ++++++++++
 kernel-shared/free-space-tree.c |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index af04b9ea..f44126e2 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -3536,6 +3536,16 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
+	/* delete free space items associated with this block group */
+	ret = remove_block_group_free_space(trans, block_group);
+	if (ret < 0) {
+		fprintf(stderr,
+			"failed to remove free space associated with block group for [%llu,%llu)\n",
+			bytenr, bytenr + len);
+		btrfs_unpin_extent(fs_info, bytenr, len);
+		return ret;
+	}
+
 	/* Now release the block_group_cache */
 	ret = free_block_group_cache(trans, fs_info, bytenr, len);
 	btrfs_unpin_extent(fs_info, bytenr, len);
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 81fd57b8..df704e4d 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1171,6 +1171,9 @@ int remove_block_group_free_space(struct btrfs_trans_handle *trans,
 	int done = 0, nr;
 	int ret;
 
+	if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
+		return 0;
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
-- 
2.43.5


