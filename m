Return-Path: <linux-btrfs+bounces-4803-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A389A8BEB48
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 20:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76E7B299EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2024 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F9016D4CC;
	Tue,  7 May 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="v1XuW6nv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1F15ECC6
	for <linux-btrfs@vger.kernel.org>; Tue,  7 May 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105548; cv=none; b=Xfuet215FtEAWloA/RpPAr/0zisqP+iDbhNeGTW9O83KMOqHwzqmIOYkarcwWKxojoKQaEKC96/IiGaEso3IEpUN5+1QrZ6nltMwG7XhJqjCm0SJ1zHloMlmQy5vq2zwbMnqWcylJWFF+xpGFbUJIAtnj4AIuXycv+o0B6NP6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105548; c=relaxed/simple;
	bh=mwDddtv5TcOx0Vxe1iXgiTMaUbZIsoNTsKB/M3zPyAY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrtYXQ80cickyrju2o0dqtM/wL/Rw/2sjmVmN++rEXChNQ4v+r60N4uh6tZr4hmKkJW6GWSGAnhSnC+jXVaB5A65vOyn5xUq1YUhO+Gqae/tiaq0tMFAP0DvASxBeJQaF9gKbHZRvRdF9eq5dyes1Yk5cnwDw4lth6GJ5ylPeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=v1XuW6nv; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de5ea7edb90so3561032276.1
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2024 11:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1715105545; x=1715710345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P4byrbGED+hkLveYLsNrZSI1dripGf/IQBH7DwgK+vI=;
        b=v1XuW6nvlOeBXpVV4sZG2/T4cG8WFOxX2J2gN8E5ApLOybzgrdh61r2OP/w9I5NDQA
         +K8R0iuQYHa8lFz/0QbSjCS1Y2ZC0JVADN4YwLsZ4Lo03OJpWMrBGOtjnDgSTD0e6zj9
         ISQfYTCi8Alk6PsEvSPrgOPvzGsJ7BEgzlH3WEvaa9IABu5CiV3VY0DFZwGgc7ywsVzF
         oqirXBKoX3qNXsizmaOP3qloxeNSmH9HD7KMgPbdND9iwjhmOsExLM5pjREDY5xheh3t
         y051kbU4RoEugeyrwYMF4kP+3t35/B2bL8sw9wnmQpO5gLhfAbbHdmZ14DpWEd1joscq
         pemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105545; x=1715710345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4byrbGED+hkLveYLsNrZSI1dripGf/IQBH7DwgK+vI=;
        b=gDpW9WmXW2toJFcUEwhd9dpr1egwbEkYxCX4OJKL+Edz6XUUm1e2ZX5m+w6i1tltjM
         1VizHorFJB/QLMvsiUJ0GfeFtj9B6BFtzup4j7Hyx/sAXyKPue/TOnhP9zT7Zn4RvjJM
         ljsnYYMHpRx8SImMSu0cl0oWG0aCzqMU4K2y2o3d8C1I4m7iNM7AW3Q2Y2fMRvKI9bJ0
         1PCdtHUe+cTXvYLoQPRZG12brjNOazcqMYmiTyzsbygmqBI8lfhIP7tBh9/k4oZB5duu
         d+XA0QyHDK1oHWzU14EGU+EKrbfCb4UVFwDCUZe/zBvxaD+NP7q0OYybSBXxWTDuCU78
         zFOw==
X-Gm-Message-State: AOJu0YwjSgmrgNivcIc8qqgnCQmmCHXk2xp2sNPVEF/g3tz/EIG/mYwO
	WP1KZGqhdEa/ovjE6uVUyuaeRYINeeU+4/Yf5+mh9nZZV8YyJd44bRTuuGMzKSY8TqRWTbFo+/v
	O
X-Google-Smtp-Source: AGHT+IGjLuHLQQLhJmH1hPbZUaLw4VQ+Zi2aI6DLugd1lECbmv/9DDvzX6mAlaVn7+KTONyzk8ITWA==
X-Received: by 2002:a5b:251:0:b0:de5:4d41:80c3 with SMTP id 3f1490d57ef6-debb9e4d5d5mr473331276.55.1715105545407;
        Tue, 07 May 2024 11:12:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 5-20020a250905000000b00de896cb3a47sm1097156ybj.61.2024.05.07.11.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 11:12:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 02/15] btrfs: remove all extra btrfs_check_eb_owner() calls
Date: Tue,  7 May 2024 14:12:03 -0400
Message-ID: <343d19395e2cfe7b15cde8e618f80cae17e9b0e7.1715105406.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715105406.git.josef@toxicpanda.com>
References: <cover.1715105406.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we have a handful of btrfs_check_eb_owner() calls in various
places and helpers that read extent buffers.  However we call this in
the endio handler for every metadata block, so these extra checks are
unnecessary, simply remove them from everywhere except the endio
handler.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   | 7 +------
 fs/btrfs/disk-io.c | 4 ----
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 1a49b9232990..48aa14046343 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1551,12 +1551,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 		if (ret) {
 			free_extent_buffer(tmp);
 			btrfs_release_path(p);
-			return -EIO;
-		}
-		if (btrfs_check_eb_owner(tmp, btrfs_root_id(root))) {
-			free_extent_buffer(tmp);
-			btrfs_release_path(p);
-			return -EUCLEAN;
+			return ret;
 		}
 
 		if (unlock_up)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a91a8056758a..92ada19ccd10 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -635,10 +635,6 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 		free_extent_buffer_stale(buf);
 		return ERR_PTR(ret);
 	}
-	if (btrfs_check_eb_owner(buf, check->owner_root)) {
-		free_extent_buffer_stale(buf);
-		return ERR_PTR(-EUCLEAN);
-	}
 	return buf;
 
 }
-- 
2.43.0


