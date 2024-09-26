Return-Path: <linux-btrfs+bounces-8236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA68986E27
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C3A1F23ADC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE4A1925AB;
	Thu, 26 Sep 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLdPnZMQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC95914F10E;
	Thu, 26 Sep 2024 07:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727336998; cv=none; b=fibvfF98LAyHOOvZsh6jayLnkV7Hlbjp9ww+6w/FQjge/gpIO3FZ0Bc5zqz8qUG7NxUjSW8JliER8nMO5g+VxZvVvh/BxStycGJRa80ee0VfBa0W4RruMWAiAIpJ/vmtQH5npz/D11c2TkGGbH4PDNMMTi4EFqQ/eGQ/pHKIDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727336998; c=relaxed/simple;
	bh=w2Nb8wKrzfT34xq4lJTGEBc10maRlw0ReT/Lh3Hlz0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1pVjSkLcrOlBkQxNySUVR0mHCxLuujq80hO5X0HRJa08yIv/O0iroIBzjutwEKrroEfHkGH1xVrtLkqZxlla0K0m8DOQCbRybPSkNJv4Wdh/8uSmC/IUvnPTWo6lgnI8yl8NKDrvnfMXBkKKca/koX06ti1eVbnqRgHNiOhBYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLdPnZMQ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7d50e865b7aso476867a12.0;
        Thu, 26 Sep 2024 00:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727336996; x=1727941796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RhovYg730ng4CDXG+4s6DvuXclBVSlmynQtgpGXdtMY=;
        b=KLdPnZMQNhKvTDfdjyF0VIjDMNinPre3zMMPygMVhDvpHXbcOyb7EQiOkU4JH5OR1Z
         acs2BVM1/9QRD5Q0Srwl8CO1CT50HwKvQ/4PpfrLicRKXhdbIX7eqai9qj4aWbrc75aL
         tWduDO6NDrMxz2KrY75mNWX+gBe29z1p+iHRGQOsus9rg7Cm+lsKast1wRwO/ZRQZOlk
         gkjs13NlQnCFQf3xMh2U4cJduAsw3Ei+/Md//1/zA1UcIfGaclNWIh2LH2kg644NM5d0
         qqKARE+gpVWTXxq5tlOShxq8Xp9lWkCo1VgS7JpkCPBFRTYiJ/m9F0b4ht9d4/pLuIAx
         qknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727336996; x=1727941796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RhovYg730ng4CDXG+4s6DvuXclBVSlmynQtgpGXdtMY=;
        b=EeqZsZV9kFW5+K/7xJCZSYyjncGBMSOpLsGrIlnHFWzpxeUKSE+dU/0hoskL8rfX+R
         D8h9XMs8DJXA1at/YS+yjfscZoUia//XhgJbyucNM4LvqI/F+WOZpQVUkYtdM1DkipPk
         AaA0+TQvKVPc5ie5MxhT/WQqAoXqCfUhKnDB8KYnyENr1YyIC1XIZixtVsGly3QiNbC/
         F3Smm+KbX9s1kqsvfVdqvZXT3jegMaL5Z0qChvO9WTZAOttw64GAXelOaMidm9XvlFGF
         SywM5npa95cpVhbPF3braJ+AHqVqCs78lUrO3WvAU+m3XsF0OvqN2Xk/fB4H+M1dV633
         dLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxuNBYCpt3+hj6thKdlvlYqyhhAhICSwP/vvOkXSOSx4i/Q9D/4KZlPJmX8UN2A7FMtJJowTCyIkBtGLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjdYwBSpXwccMmTSqfGvtB7/yFX7l7R8Q6LW4xQIS1Cyrz2bQ0
	exM+qgixmxMMMQgYY6eejeFWP1BPuJABmvO4yvKY0a79MJaBuiwZb+xMUV5o
X-Google-Smtp-Source: AGHT+IG2A7Z5+dF2kyD2W7iT94m3L1aNXDuf2FvjBIMBl13ap1xa7daKFEgzBSa0/UbbSabw2xE+nQ==
X-Received: by 2002:a05:6a21:320b:b0:1cf:9a86:73e4 with SMTP id adf61e73a8af0-1d4d4aaf03amr7709467637.14.1727336995821;
        Thu, 26 Sep 2024 00:49:55 -0700 (PDT)
Received: from fedora.. ([106.219.166.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c7c86esm3737323a12.85.2024.09.26.00.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:49:55 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] btrfs: add missing NULL check in btrfs_free_tree_block()
Date: Thu, 26 Sep 2024 13:19:47 +0530
Message-ID: <20240926074947.39415-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 3ba2d3648f9dc (btrfs: reflow btrfs_free_tree_block), the block
group lookup using btrfs_lookup_block_group() was added in btrfs_free_tree_block().
However, the return value of this function is not checked for a NULL result,
which can lead to null pointer dereferences if the block group is not found.

This patch adds a check to ensure that if btrfs_lookup_block_group() returns
NULL, the function will gracefully exit, preventing further operations that
rely on a valid block group pointer.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
Compile tested only

 fs/btrfs/extent-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a5966324607d..7782d4436ca0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3454,6 +3454,8 @@ int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 	}
 
 	bg = btrfs_lookup_block_group(fs_info, buf->start);
+	if (!bg)
+		goto out;
 
 	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
 		pin_down_extent(trans, bg, buf->start, buf->len, 1);
-- 
2.46.1


