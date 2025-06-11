Return-Path: <linux-btrfs+bounces-14602-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A3AD50D5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 12:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E92ED3A7DBE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7B267720;
	Wed, 11 Jun 2025 10:03:28 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5A265281
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636207; cv=none; b=dQibuZvM4rHWf0mD4WGo8wsiBBys2YGESsMF9yyhlYHTPNkzS+Ujmbjhfu8eacL3pBbyPfG1Vi9BL2ypMlXL0qwWfmnD1lXAhzxDDKyS6Cw/BFkiP338T2XAftoj/xicgIGuucioL8D0L/UV4W5Vaw2v5SPz1tLmf4tbflFuOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636207; c=relaxed/simple;
	bh=vHJrh26+eUYZ0VNf6sAgno5cegjAeSMiRCxNQREfb3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfiFpfHxLtICkF3y7GGt2vAMR0p55eL7kWJC2DoInL55jKKBvyTLNrnEju+TPuwKt1uwfN//xtKoAt3mLsxGlkydSMWavwUaGqy8usRm8LdJMceWytTbxITaXmHW0eq0krNZB6UOL8i51wPYrvnn535Pt8k0SgXm4g8w+xhwXYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so51829625e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 03:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749636204; x=1750241004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQnPjNRK4FPxWmJHoPqmPKjXkN833asChSOdv1b4njo=;
        b=EOvLOjjdvXqJLPp/KQI/Ld7Y5/qqPupFCcF/zh/6umDYtHCcG5+Jj8xJKfucO/QSTQ
         lGwQIzR89n6rRdfDXZ4/9sfVhc5xWYtWCUmE0unWBGxGyjjxrz+0SxxuKnfbFfwOq8ud
         nsWUxM623FHARtNfJy5/qzQvrx0b1hSHpnu1T7vd4K4TOy1LLiXaWqszOcrHDH/8KnWH
         DY4gIusMZTvEM1xLpa4I+OhSjMTDgpa7GrJC6Laeqs2Pe4AOtWP2b4M2gt9idKbh6/9B
         Sg6uj1DILPA6vU7/wHBrUbQbFGinN50pvWDe+lGhORNPNeByp5+y4ZuYIlD5MBJJdvPO
         Qmjg==
X-Gm-Message-State: AOJu0Yw+prD1d7w7e38AxB3Uqbn9whcNAWVcVzT2oGpPdO9Rk3i78eup
	DSJSKMVt57qJPpVs0XbsLCcOGV6q3jqX42rvOiwy1GMLgwSdTQOuM9/VuL1FSw==
X-Gm-Gg: ASbGncu+j6PZtPomp9V2xOGAxj8SnemIHBdvirHlh/Xnx8CRdeMSR6Fl4BXkN+lhXXe
	gu8j+wCrSzuqkdw1b9/gDRIIx/qGWBz4LBbjyJDDdIlNrYSLg2dldMArFQpyfYPCaQpPEIQvUMV
	bCYaq89WHX3kJMQ44MnEXhiXek7aQDAQtMy0I+waZTpk6DBEgWALVAyVxp7UO2IzAwq9/t290QK
	RGaJVrmoQ2CKAzNzYPAbJA8F1g6A7WqOnlyeRGKXP4j1hn8dEA0WRR4B4lJ5GAFq7QrWIY9dIN/
	mF/duxc8TFI04xkchkmaMLyk6YWVuIzmkO4rx4Db8FfZBFIJlgGQ22yo6WLMCooMm3SQ21VSQxN
	DXhBeero9A9SDlMcP2CFr7GryWSsottQXGbgaN+zJb6TAkqqc6w==
X-Google-Smtp-Source: AGHT+IFtcEPM4dPAY45KSvV/coPyUKAukkNKZQQ2q045C80B8QBH20xzZDl7rhbyvjk6ufhd/wFTkA==
X-Received: by 2002:a05:6000:1a8f:b0:3a5:2182:bd17 with SMTP id ffacd0b85a97d-3a55869b80amr1858084f8f.19.1749636204375;
        Wed, 11 Jun 2025 03:03:24 -0700 (PDT)
Received: from mayhem.fritz.box (p200300f6f734a1006f354b1e839513ef.dip0.t-ipconnect.de. [2003:f6:f734:a100:6f35:4b1e:8395:13ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f02asm14654274f8f.83.2025.06.11.03.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 03:03:23 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Qu Wenruo <wqu@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 5/5] btrfs: use the super_block as holder when mounting file systems
Date: Wed, 11 Jun 2025 12:03:03 +0200
Message-ID: <20250611100303.110311-6-jth@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611100303.110311-1-jth@kernel.org>
References: <20250611100303.110311-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

The file system type is not a very useful holder as it doesn't allow us
to go back to the actual file system instance.  Pass the super_block
instead which is useful when passed back to the file system driver.

This matches what is done for all other block device based file systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index eafa524c7c81..30c928562558 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1896,7 +1896,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
 		mutex_lock(&uuid_mutex);
-		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+		ret = btrfs_open_devices(fs_devices, mode, sb);
 		mutex_unlock(&uuid_mutex);
 		if (ret)
 			goto error_deactivate;
@@ -1909,7 +1909,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg",
 			 fs_devices->latest_dev->bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
-		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
+		btrfs_sb(sb)->bdev_holder = sb;
 		ret = btrfs_fill_super(sb, fs_devices);
 		if (ret)
 			goto error_deactivate;
-- 
2.49.0


